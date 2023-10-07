<?php
// this php is used for the user redo the problem
// will reset the question's options sequence and set user answer to null

    session_start();
    include 'connectdb.php';
    //set table name
    $log_table_name = strtolower($_SESSION['student_id']."_log_table");
    $question_table_name = strtolower($_SESSION['student_id']."_question_table");

    
    //check if this question is answered
    $conn = get_db();
    $sql = "SELECT ans, user_ans,sequence FROM $question_table_name where log_ID = :log_id and QID = :QID";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':log_id', $_POST['log_id']);
    $stmt->bindParam(':QID', $_POST['QID']);
    $stmt->execute();

    $info = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $user_ans = $info[0]['user_ans'];
    $isCorrect = $info[0]['user_ans']==$info[0]['ans'];//此題是否答對
    $isTF;
    
    //取得正確答案
    //是非題->將答案轉成0 1；選擇題->將亂序後的答案還原
    if(in_array($info[0]['ans'],["F","T"])){//是非題
        $ans_index = $info[0]['ans']=="T"?1:0;
        $isTF = true;
    }
    else{//選擇題
        $ans_index = intval($info[0]['ans']);
        $real_answer = intval($info[0]['sequence'][$ans_index]);
        $isTF = false;
    }
    
    //update question table
    if($isTF){
        $sql = "UPDATE $question_table_name SET user_ans=NULL, ans=:ans where log_ID = :log_id and QID = :QID";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':ans', $info[0]['ans']);
    }
    else{
        $ans_sequence = ["0","1","2","3"];
        shuffle($ans_sequence);
        $ans = array_search($real_answer,$ans_sequence);
        $sequence = implode("", $ans_sequence);

        $sql = "UPDATE $question_table_name SET user_ans=NULL, sequence=:sequence, ans=:ans where log_ID = :log_id and QID = :QID";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':sequence', $sequence);
        $stmt->bindParam(':ans', $ans);
    }
    $stmt->bindParam(':log_id', $_POST['log_id']);
    $stmt->bindParam(':QID', $_POST['QID']);
    $stmt->execute();

    //get log table data
    $sql = "SELECT total, correct, wrong FROM $log_table_name where log_id = :log_id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':log_id', $_POST['log_id']);
    $stmt->execute();
    
    $info = $stmt->fetchAll(PDO::FETCH_ASSOC);
    //update log table
    $data = json_decode("{}");
    $data ->correct = $info[0]['correct'];
    $data ->wrong = $info[0]['wrong'];
    
    if($user_ans != null){//已經作答
        if($isCorrect){
            $data ->correct--;
        }
        else{
            $data ->wrong--;
        }
        $sql = "UPDATE $log_table_name SET correct=:correct, wrong=:wrong where log_id = :log_id";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':correct', $data->correct);
        $stmt->bindParam(':wrong', $data->wrong);
        $stmt->bindParam(':log_id', $_POST['log_id']);
        $stmt->execute();
    }
    echo json_encode($data);
?>