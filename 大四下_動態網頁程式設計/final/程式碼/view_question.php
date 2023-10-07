<?php
    // for user try to see the questions in the log 
    // the view_log.php will send a request to this php

    session_start();
    include 'connectdb.php';

    $question_list = [];

    $log_table_name = strtolower($_SESSION['student_id']."_log_table");
    $question_table_name = strtolower($_SESSION['student_id']."_question_table");

    //get the QID sequence ans and user answer
    $conn = get_db();
    $sql = "SELECT QID,sequence,ans,user_ans FROM $question_table_name where log_ID = :log_id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':log_id', $_POST['log_id']);
    $stmt->execute();
    $questions = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    foreach($questions as $question){
        //use qid to search the question and option sequence
        $temp = json_decode('{}');
        $QID = $question['QID'];
        $sql = "SELECT question, option_a, option_b, option_c, option_d FROM question_table where id = :QID";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':QID', $QID);
        
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        //combine the question and sequence text to the answer
        $temp->QID=$QID;
        $temp->question=$result[0]['question'];
        $temp->ans = $question['ans'];
        $temp->user_ans = $question['user_ans'];

        $options = ['option_a', 'option_b', 'option_c', 'option_d'];

        if(in_array($temp->ans,["T","F"])){
            $temp->option_a = "";
            $temp->option_b = "";
            $temp->option_c = "";
            $temp->option_d = "";
        }
        else{
            $temp->option_a = $result[0][$options[intval($question['sequence'][0])]];
            $temp->option_b = $result[0][$options[intval($question['sequence'][1])]];
            $temp->option_c = $result[0][$options[intval($question['sequence'][2])]];
            $temp->option_d = $result[0][$options[intval($question['sequence'][3])]];
        }
        $question_list[] = $temp;
    }
    echo json_encode($question_list);
?>