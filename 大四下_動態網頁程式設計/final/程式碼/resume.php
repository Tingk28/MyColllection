<?php
    // this php received the log_id from view_log.php
    // and set the data it need for intest.php
    session_start();
    include 'connectdb.php';

    //check if the table is create

    $log_table_name = strtolower($_SESSION['student_id']."_log_table");
    $question_table_name = strtolower($_SESSION['student_id']."_question_table");

    $conn = get_db();

    $sql = "SELECT name,total,correct,wrong FROM $log_table_name WHERE log_id=:log_id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':log_id', $_POST['log_id']);
    $stmt->execute();

    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $_SESSION["log_id"]=$_POST['log_id'];
    $_SESSION["log_name"]=$result[0]['name'];
    $_SESSION["total_count"]=$result[0]['total'];
    $_SESSION["correct"]==$result[0]['correct'];
    $_SESSION["wrong"]==$result[0]['wrong'];


    $sql = "SELECT QID FROM $question_table_name WHERE log_id=:log_id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':log_id', $_POST['log_id']);
    $stmt->execute();

    $QID_array = [];
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    foreach($result as $question){
        $QID_array[] = $question['QID'];
    }
    $conn = null;

    // Store the needed data in session
    $_SESSION["QID_array"]= $QID_array;
    echo var_dump($_SESSION)
?>