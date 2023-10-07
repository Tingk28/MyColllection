<?php
    // this php will write in the user_log-table and store 
    // the related question id(QID) in to the user_question_table too
    // if the table not exist create one
    // and return the info. need in intest.php
    session_start();
    include 'connectdb.php';
    include 'common_lib.php';
    //echo var_dump($_POST)."<br>";
    //echo var_dump($_SESSION)."<br>";

    //check if the table is create

    $log_table_name = strtolower($_SESSION['student_id']."_log_table");
    $question_table_name = strtolower($_SESSION['student_id']."_question_table");

    $conn = get_db();
    $sql = "SHOW TABLES";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $table_list = [];

    foreach($result as $row){
        $table_list[] = $row["Tables_in_audit-multiple-choice"];
    }
    if(!in_array($log_table_name,$table_list)){ //the log_table don't exist
        echo "not exist\n";
        $sql = "CREATE TABLE `audit-multiple-choice`.`$log_table_name`
        (`log_id` INT NOT NULL AUTO_INCREMENT , `name` TEXT NOT NULL , 
        `time` DATETIME NOT NULL , `content` TEXT NOT NULL , `total` INT NOT NULL ,
        `correct` INT NOT NULL , `wrong` INT NOT NULL , PRIMARY KEY (`log_id`))
        ENGINE = InnoDB;";
        
        $stmt = $conn->prepare($sql);
        $stmt->execute();
    }
    if(!in_array($question_table_name,$table_list)){ //the question_table don't exist
        echo "not exist2";
        $sql = "CREATE TABLE `audit-multiple-choice`.`$question_table_name` (
            `ID` INT NOT NULL AUTO_INCREMENT,
            `QID` INT NOT NULL,
            `sequence` VARCHAR(10) NULL,
            `ans` TEXT NOT NULL,
            `user_ans` TEXT NULL,
            `chapter` TEXT NULL,
            `LO` TEXT NULL,
            `log_ID` INT NOT NULL,
            PRIMARY KEY (`ID`),
            FOREIGN KEY (`QID`) REFERENCES `question_table` (`id`)
        )";
        
        $stmt = $conn->prepare($sql);
        $stmt->execute();
    }
    // echo var_dump($table_list);
    //write in the log-table and question table
    $sql = "INSERT INTO `$log_table_name` 
    (`log_id`, `name`,`time`,`content`,`total`,`correct`,`wrong`)
    VALUES (NULL, :name, :time, :content, -1, 0, 0)";

    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':name', $_POST['log-name']);
    $stmt->bindParam(':time', $_POST['time-stamp']);
    $stmt->bindParam(':content', $_POST['chapter-select']);
    $stmt->execute();

    $sql = "SELECT MAX(log_id) FROM $log_table_name";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $log_id = $stmt->fetchAll(PDO::FETCH_ASSOC)[0]["MAX(log_id)"];


    $chapter_select = json_decode($_POST['chapter-select']);
    $total_count = 0;
    $values = [];
    $QID_array = [];
    ECHO $_POST["skipTF"];
    foreach($chapter_select as $entry){
        
        if($_POST["skipTF"] == 'T'){
            $sql = "SELECT id,answer FROM `question_table` WHERE chapter=:chapter and LO=:lo AND answer NOT IN ('T', 'F');";
        }
        else{
            $sql = "SELECT id,answer FROM `question_table` WHERE chapter=:chapter and LO=:lo;";
        }
        
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':chapter', $entry->chapter);
        $stmt->bindParam(':lo', $entry->lo);
        
        $stmt->execute();
        
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $total_count += count($result);
        foreach ($result as $row) {
            $qid = $row["id"];
            $QID_array[] = $qid;
            $ans_sequence = ["0","1","2","3"];
            if(in_array($row["answer"],$ans_sequence)){
                shuffle($ans_sequence);
                $ans = array_search($row["answer"],$ans_sequence);
                $ans_sequence = implode("", $ans_sequence);
                $values[] = "(NULL,'$qid', '$ans_sequence', '$ans', '$log_id')";
            }
            else{
                $ans = $row["answer"];
                $values[] = "(NULL,'$qid', NULL, '$ans', '$log_id')";
            }
        }
    }
    if($_POST["shuffle"]=="T"){
        $seed = mt_rand();
        srand($seed);
        shuffle($QID_array);
        srand($seed);
        shuffle($values);
        echo var_dump($values)."<br>";
        echo var_dump($QID_array);
    }
    //echo var_dump($values);
    $sql = "INSERT INTO $question_table_name (ID, QID, sequence, ans, log_id) VALUES " . implode(", ", $values);
    $conn->query($sql);

    $sql = "UPDATE $question_table_name AS uqt
            JOIN `question_table` AS qt ON uqt.QID = qt.id
            SET uqt.chapter = qt.chapter , uqt.LO = qt.LO;";
    $stmt = $conn->prepare($sql);
    $stmt->execute();

    $sql = "UPDATE `$log_table_name` SET `total`='$total_count' WHERE log_id =$log_id";
    $stmt = $conn->prepare($sql);
    $stmt->execute();

    $conn = null;

    // Store the needed data in session
    $_SESSION["log_id"]=$log_id;
    $_SESSION["log_name"]=$_POST['log-name'];
    $_SESSION["total_count"]=$total_count;
    $_SESSION["wrong"]=0;
    $_SESSION["correct"]=0;
    $_SESSION["QID_array"]= $QID_array;
?>