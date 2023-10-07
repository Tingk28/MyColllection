<?php
    // this php have the UI for user to answer the questions
    // and handel all the event including switching between question, answering, redo.
    session_start();
    include 'connectdb.php';
    include 'common_lib.php';
    if(!isset($_COOKIE['auth_code'])){
        setcookie('auth_code', "000", time() + 3600, '/');
    }
    redirect();//redirect if not login.

    //echo var_dump($_SESSION);
    $data = $_SESSION;
    unset($data['auth_code']);
    echo "<script>data = ".json_encode($data)."</script>";
    

?>
<!-- verification.php -->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>測驗</title>
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            @media (max-width: 500px) {
                img {
                    display: none;
                }
            }
            .col-md-6,.col-md-2{
                margin-bottom: 3px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid" style="height:8%">
            <a href="welcome.php" style="color:black"><span class="h1 d-inline">審計選擇題系統</span></a>
            <div class="float-right d-flex align-items-center" style="height: 48px;">
                <a href="contact_us.php">聯絡我們</a>&emsp;|&emsp;
                <a href="" id="logout">登出</a>
            </div>
        </div>
        <br>
        <div class="container" style="border:1px solid black;min-height: 75%;">
            <div class="container pt-1" style="min-height:10%;">
                <div class="row">
                    <div class="col" style="transform:translate(0%,40%)">
                        <span id="log-name">Log_name</span>
                    </div>
                    <div class="col d-flex justify-content-end" id="total-question">
                        總題數
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <span></span>
                    </div>
                    <div class="col d-flex justify-content-end">
                        <div class="progress" style="width: 50%;" id="progress-bar">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 15%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100">15%</div>
                            <div class="progress-bar bg-danger" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100">30%</div>
                            <div class="progress-bar bg-secondary" role="progressbar" style="width: 55%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100">55%</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container" style="border:1px solid gray; height:65%;overflow:scroll;font-size:20px" id="question">
            The objective of an audit of the financial statements is an expression of an opinion on<br>

            A) the fairness of the financial statements in all material respects.<br>
            B) the accuracy of the balance sheet and income statement.<br>
            C) the accuracy of the annual report.<br>
            D) the accuracy of the financial statements.

            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-6 px-1">
                        <button type="button" class="btn btn-info btn-block " onclick="send_ans(0)" id="option_0">A</button>
                    </div>
                    <div class="col-md-6 px-1">
                        <button type="button" class="btn btn-info btn-block" onclick="send_ans(1)" id="option_1">B</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 px-1">
                        <button type="button" class="btn btn-info btn-block" onclick="send_ans(2)" id="option_2">C</button>
                    </div>
                    <div class="col-md-6 px-1">
                        <button type="button" class="btn btn-info btn-block" onclick="send_ans(3)" id="option_3">D</button>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-2 px-1">
                        <button type="button" class="btn btn-info btn-block" onclick="redo()">重做此題</button>
                    </div>
                    <div class="col-md-6 px-1"></div>
                    <div class="col-md-2 px-1">
                        <button type="button" class="btn btn-info btn-block" id="prev" onclick="prev()" disabled>上一題</button>
                    </div>
                    <div class="col-md-2 px-1">
                        <button type="button" class="btn btn-info btn-block" id="next" onclick="next()">下一題</button>
                    </div>
                </div>
            </div>

        </div>

        


        </div>
        <script>
            function update_progress_bar(all,correct,wrong){
                let percentage = [Math.round(correct*100/all),Math.round(wrong*100/all)];
                percentage.push(100-percentage[0]-percentage[1])
                $("#progress-bar :nth-child(1)").text(correct);
                $("#progress-bar :nth-child(1)").css("width",percentage[0].toString()+"%");
                $("#progress-bar :nth-child(2)").text(wrong);
                $("#progress-bar :nth-child(2)").css("width",percentage[1].toString()+"%");
                $("#progress-bar :nth-child(3)").text(all-correct-wrong);
                $("#progress-bar :nth-child(3)").css("width",percentage[2].toString()+"%");
            }
            function update_total_question(all){
                $("#total-question").text("總題數："+all);
            }
            function update_log_name(name){
                $("#log-name").text(name);
            }
            function update_question(QID){
                const xmlhttp = new XMLHttpRequest();
                xmlhttp.onload = function() {
                    // alert(this.responseText);
                    question_json = JSON.parse(this.responseText);
                    //console.log(question_json)
                    $("#question").html(question_json['question_str']);
                    initial_btns(question_json['isTF']);
                    let user_ans= question_json['user_ans']
                    if(question_json['user_ans']!=null){
                        if(['T','F'].includes(question_json['user_ans'])){
                            user_ans == 'T'?1:0;
                        }
                        send_ans(user_ans);
                    }
                }
                xmlhttp.open("POST", "get_question.php");
                var formData = new URLSearchParams();
                formData.append('log_id', data['log_id']);
                formData.append('QID', QID);
                xmlhttp.send(formData);
            }
            function prev(){
                if(index<0){
                    return null;
                }
                $("#next").attr('disabled', false);
                index --;
                update_question(data['QID_array'][index]);
                if(index == 0){
                    $("#prev").attr('disabled', true);
                }
            }
            function next(){
                if(index==data['total_count']-1){
                    return null;
                }
                $("#prev").attr('disabled', false);
                index ++;
                update_question(data['QID_array'][index]);
                if(index==data['total_count']-1){
                    $("#next").attr('disabled', true);
                }
            }
            function send_ans(ans){
                const xmlhttp = new XMLHttpRequest();
                xmlhttp.onload = function() {
                    // alert(this.responseText);
                    //console.log(this.responseText);
                    let response = JSON.parse(this.responseText);
                    data['correct'] = response['correct'];
                    data['wrong'] = response['wrong'];
                    update_progress_bar(data['total_count'],data['correct'],data['wrong']);
                    //$("#question").html(question_json['question_str']);
                    judge(response['ans'], response['user_ans'])
                }
                xmlhttp.open("POST", "answer_handler.php");
                var formData = new URLSearchParams();
                formData.append('log_id', data['log_id']);
                formData.append('QID', data['QID_array'][index]);
                formData.append('user_ans', ans);
                xmlhttp.send(formData);
            }
            function redo(){
                const xmlhttp = new XMLHttpRequest();
                xmlhttp.onload = function() {
                    //console.log(this.responseText);
                    let response = JSON.parse(this.responseText);
                    data['correct'] = response['correct'];
                    data['wrong'] = response['wrong'];
                    update_progress_bar(data['total_count'],data['correct'],data['wrong']);
                    update_question(data['QID_array'][index]);
                }
                xmlhttp.open("POST", "redo.php");
                var formData = new URLSearchParams();
                formData.append('log_id', data['log_id']);
                formData.append('QID', data['QID_array'][index]);
                xmlhttp.send(formData);
            }
            function initial_btns(isTF){
                $("#option_0, #option_1, #option_2, #option_3").removeClass("btn-danger");
                $("#option_0, #option_1, #option_2, #option_3").removeClass("btn-success");
                $("#option_0, #option_1, #option_2, #option_3").addClass("btn-info")
                $("#option_0, #option_1, #option_2, #option_3").prop("disabled", false);
                $("#option_0").text('A')
                $("#option_1").text('B')
                if(isTF){
                    $("#option_2, #option_3").prop("disabled", true);
                    $("#option_0").text('F')
                    $("#option_1").text('T')
                }
            }
            
            function judge(ans,user_ans){
                if(ans == user_ans){//答對
                    $("#option_"+user_ans).removeClass("btn-info"); 
                    $("#option_"+user_ans).addClass("btn-success");
                    }
                else{//答錯
                    $("#option_"+ans).removeClass("btn-info"); 
                    $("#option_"+ans).addClass("btn-success");
                    $("#option_"+user_ans).removeClass("btn-info"); 
                    $("#option_"+user_ans).addClass("btn-danger");
                }
                $("#option_0, #option_1, #option_2, #option_3").prop("disabled", true);
            }
            document.getElementById('logout').addEventListener('click', function() {//delete the cookie
                document.cookie = "auth_code=000; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            });
            index = 0;
            update_progress_bar(data['total_count'],data['correct'],data['wrong']);
            update_total_question(data['total_count']);
            update_log_name(data['log_name']);
            update_question(data['QID_array'][index])
        </script>
    </body>
</html>    