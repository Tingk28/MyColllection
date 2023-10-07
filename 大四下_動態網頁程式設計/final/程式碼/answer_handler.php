<?php
        // update the user_ans to the user_question_table
        // and update the correct or wrong to the user_log_table
        // return the correct answer and the number of correct and wrong
        session_start();
        include 'connectdb.php';
        //set table name
        $log_table_name = strtolower($_SESSION['student_id']."_log_table");
        $question_table_name = strtolower($_SESSION['student_id']."_question_table");
    
        $answer_data = json_decode("{}");
        $answer_data->user_ans = intval($_POST['user_ans']);
    
        //get the answer
        $conn = get_db();
        $sql = "SELECT ans, user_ans FROM $question_table_name where log_ID = :log_id and QID = :QID";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':log_id', $_POST['log_id']);
        $stmt->bindParam(':QID', $_POST['QID']);
        $stmt->execute();
    
        $info = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $user_ans = $info[0]['user_ans'];
        if(in_array($info[0]['ans'],["F","T"])){//set 'ans' in to 0-3
            $answer_data->ans = $info[0]['ans']=="T"?1:0;
        }
        else{
            $answer_data->ans = intval($info[0]['ans']);
        }


        //update 答題記錄
        $sql = "SELECT total, correct, wrong FROM $log_table_name where log_id = :log_id";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':log_id', $_POST['log_id']);
        
        $stmt->execute();
        $info = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if($user_ans == NULL){//沒有作答過此題
            if($answer_data->user_ans == $answer_data->ans){//答對
                $answer_data->wrong = intval($info[0]['wrong']);
                $answer_data->correct = intval($info[0]['correct'])+1;
            }
            else{//答錯
                $answer_data->wrong = intval($info[0]['wrong'])+1;
                $answer_data->correct = intval($info[0]['correct']);
            }
            
            $sql = "UPDATE $log_table_name SET correct=:correct, wrong=:wrong where log_id = :log_id";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':correct', $answer_data->correct);
            $stmt->bindParam(':wrong', $answer_data->wrong);
            $stmt->bindParam(':log_id', $_POST['log_id']);
            
            $stmt->execute();
    
            $sql = "UPDATE $question_table_name SET user_ans=:user_ans where log_ID = :log_id and QID = :QID";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':user_ans', $_POST['user_ans']);
            $stmt->bindParam(':log_id', $_POST['log_id']);
            $stmt->bindParam(':QID', $_POST['QID']);
            $stmt->execute();
        }
        else{//作答過，維持原題數
            $answer_data->wrong = intval($info[0]['wrong']);
            $answer_data->correct = intval($info[0]['correct']);
        }

        echo json_encode($answer_data);


?>