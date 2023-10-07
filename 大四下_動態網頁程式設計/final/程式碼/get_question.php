<?php
    //this code will receive user question id and retrun the questions(string) and question types to the users
    //which not include the answer
    session_start();
    include 'connectdb.php';

    $question_data = json_decode("{}");

    $log_table_name = strtolower($_SESSION['student_id']."_log_table");
    $question_table_name = strtolower($_SESSION['student_id']."_question_table");

    $conn = get_db();
    $sql = "SELECT sequence,ans,user_ans FROM $question_table_name where log_ID = :log_id and QID = :QID";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':log_id', $_POST['log_id']);
    $stmt->bindParam(':QID', $_POST['QID']);
    $stmt->execute();

    $info = $stmt->fetchAll(PDO::FETCH_ASSOC);
    //echo var_dump($info[0]);
    
    if(in_array($info[0]['ans'],['T','F'])){//是非題
        $question_data->isTF = true;
    }
    else{//選擇題
        $question_data->isTF = false;
    }
    $question_data->user_ans = $info[0]['user_ans'];

    $sql = "SELECT question, option_a, option_b, option_c, option_d FROM question_table where id = :QID";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':QID', $_POST['QID']);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    
    $question_data->question_str = $result[0]['question']."<br>";
    $question_data->raw_str = $result;

    //echo var_dump($result);
    if(!$question_data->isTF){//選擇題
        $option_index = 0;//列印選項用
        $option_name = ["(A) ","(B) ","(C) ","(D) "];
        foreach (str_split($info[0]['sequence']) as $char) {
            $index = intval($char);
            $options = [$result[0]['option_a'],$result[0]['option_b'],$result[0]['option_c'],$result[0]['option_d']];
            $question_data->question_str .= "<br>".$option_name[$option_index].$options[$index];
            $option_index++;
        }
    }
      
    echo json_encode($question_data);
?>