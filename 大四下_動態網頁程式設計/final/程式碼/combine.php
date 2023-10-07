<?php
    // dealing the request from combine_log.php
    // write into the user_log_table and user_question_table
    // and goto intest.php
    session_start();
    include 'connectdb.php';

    echo var_dump($_POST);

    $data = json_decode($_POST['data']);
    
    $content = "";
    foreach($data as $row){
        $content .= $row->log_id.":" ;
        if($row->all){
            $content .= "全部";
        }
        else{
            if($row->correct){
                $content .= "正確";
            }
            if($row->wrong){
                $content .= "錯誤";
            }
            if($row->null){
                $content .= "未作答";
            }
        }
        $content .= "/";
    }
    $log_table_name = strtolower($_SESSION['student_id']."_log_table");
    $question_table_name = strtolower($_SESSION['student_id']."_question_table");

    $conn = get_db();
    //write in the log-table
    $sql = "INSERT INTO `$log_table_name` 
    (`log_id`, `name`,`time`,`content`,`total`,`correct`,`wrong`)
    VALUES (NULL, :name, :time, :content, -1, 0, 0)";

    $stmt = $conn->prepare($sql);
    $name = $_POST['log-name']==""?"合併記錄檔":$_POST['log-name'];
    $stmt->bindParam(':name', $name);
    $stmt->bindParam(':time', $_POST['time-stamp']);
    $stmt->bindParam(':content',$content);
    $stmt->execute();


    $sql = "SELECT MAX(log_id) FROM $log_table_name";
    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $log_id = $stmt->fetchAll(PDO::FETCH_ASSOC)[0]["MAX(log_id)"];

    //write in the question table
    $total_count = 0;
    $values = [];
    $QID_array = [];
    $add_QID = [];
    
    //get all the qid we are going to add
    foreach($data as $log){
        if($log->all){
            $sql = "SELECT QID FROM $question_table_name WHERE log_ID=:log_ID";
        }
        else{
            $first_condiction = true;
            $sql = "SELECT QID FROM $question_table_name WHERE log_ID=:log_ID AND (";
            if($log->correct){
                if($first_condiction){
                    $sql .= "ans=user_ans";
                    $first_condiction = false;
                }
            }
            if($log->wrong){
                if($first_condiction){
                    $sql .= "ans!=user_ans";
                    $first_condiction = false;
                }
                else{
                    $sql .= " OR ans!=user_ans";
                }
            }
            if($log->null){
                if($first_condiction){
                    $sql .= "user_ans IS NULL";
                    $first_condiction = false;
                }
                else{
                    $sql .= " OR user_ans IS NULL";
                }
            }
            $sql .= ")";
        }
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':log_ID', $log->log_id);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);//all QID we need
        //echo var_dump($result);
        foreach($result as $qid){
            $add_QID[]=$qid['QID'];
        }
    }

    //del duplicate if needed
    if($_POST['delDuplicate']== 'T'){
        $add_QID = array_unique($add_QID);  
    }

    // add qid in to '$value'
    foreach($add_QID as $qid){
        $sql = "SELECT id,answer FROM `question_table` WHERE id=$qid";
        $stmt = $conn->prepare($sql);
        $stmt->execute();

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        if($_POST["skipTF"] == 'T'){
            if(in_array($result[0]['answer'],["T","F"])){
                continue;
            }
        }
        $QID_array[] = $result[0]["id"];
        $ans_sequence = ["0","1","2","3"];
        $total_count++;
        if(in_array($result[0]["answer"],$ans_sequence)){//選擇題
            shuffle($ans_sequence);
            $ans = array_search($result[0]["answer"],$ans_sequence);
            $ans_sequence = implode("", $ans_sequence);
            $values[] = "(NULL,'$qid', '$ans_sequence', '$ans', '$log_id')";
        }
        else{//是非題
            $ans = $result[0]["answer"];
            $values[] = "(NULL,'$qid', NULL, '$ans', '$log_id')";
        }
    }
    if($_POST["shuffle"]=="T"){
        $seed = mt_rand();
        srand($seed);
        shuffle($QID_array);
        srand($seed);
        shuffle($values);
    }
    
    
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
    $_SESSION["log_name"]=$name;
    $_SESSION["total_count"]=$total_count;
    $_SESSION["wrong"]=0;
    $_SESSION["correct"]=0;
    $_SESSION["QID_array"]= $QID_array;
?>