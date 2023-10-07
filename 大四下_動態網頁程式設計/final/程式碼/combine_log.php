<?php
    //user can see all the log from this file and decide which they would like to combine
    //and send the request to combine.php
    session_start();
    ob_start();
    include 'connectdb.php';
    include 'common_lib.php';
    if(!isset($_COOKIE['auth_code'])){
        setcookie('auth_code', "000", time() + 3600, '/');
    }

    $conn = get_db();

    $log_table_name = strtolower($_SESSION['student_id']."_log_table");
    
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
        echo "<script>alert(\"目前無作答紀錄\")</script>";
        echo "<script>setTimeout(function(){location.href=\"welcome.php\"},500)</script>";
        $conn = null;
        die;
    }

    $sql = "SELECT log_id,name, time, content, total, correct, wrong FROM $log_table_name";

    $stmt = $conn->prepare($sql);
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $temp = json_encode($result);
    echo "<script>data = $temp</script>";
?>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>合併紀錄</title>
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            td .btn, th span{
                width: 40px;
                text-align: center;
            }
            .modal-xl .modal-dialog {
               max-width: 90%;
            }
            .bg-light-danger{
                background-color:rgba(255, 94, 110,0.8) ;
            }
            .bg-light-success{
                background-color:rgba(64, 255, 104,0.8) ;
            }
        </style>
    </head>
    <body>
        <div class="container" style="height:8%">
            <a href="welcome.php" style="color:black"><span class="h1 d-inline">審計選擇題系統</span></a>
            <div class="float-right d-flex align-items-center" style="height: 48px;">
                <a href="contact_us.php">聯絡我們</a>&emsp;|&emsp;
                <a href="" id="logout">登出</a>
            </div>
        </div>
        <div class="container">
            <div class="alert alert-danger" id="alert-box-danger" style="display:none">
                <strong>錯誤</strong>&nbsp;&nbsp;請選擇題目
            </div>
            <form action="create.php">
                <div class="form-group">
                    <label>紀錄名稱</label>
                    <input type="text" class="form-control" id="log-name" placeholder="" name="log-name"><br>
                    <label>是否隨機順序</label><br>
                    <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="shuffle" value="T" checked>是
                        </label>
                        </div>
                        <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="shuffle" value="F">否
                        </label>
                    </div>
                    <br>
                    <label>是否跳過是非題</label><br>
                    <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="skipTF" value="T" checked>是
                        </label>
                        </div>
                        <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="skipTF" value="F">否
                        </label>
                    </div>
                    <br>
                    <label>是否刪除重複</label><br>
                    <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="delDuplicate" value="T" checked>是
                        </label>
                        </div>
                        <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="radio" class="form-check-input" name="delDuplicate" value="F">否
                        </label>
                    </div>

                    <!-- <input type="text" class="form-control" id="log-name" placeholder="" name="email"> -->
                </div>
            </form>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg" id="show_questions" style="display:none">Large modal</button>
            <button type="button" class="btn btn-info btn-block" onclick="combine()">合併錯題</button>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th class="col-1">序號</th>
                    <th class="col-2">紀錄名稱</th>
                    <th class="col-3">時間</th>
                    <th class="col-3">範圍</th>
                    <th class="col-3 text-center">
                        <span class="badge badge-primary">總數</span>
                        <span class="badge badge-success">答對</span>
                        <span class="badge badge-danger">答錯</span>
                        <span class="badge badge-secondary">未答</span>
                    </th>
                </tr>
                </thead>
                <tbody id="table-body">

                </tbody>
            </table>
        </div>
        <!-- Modal -->
        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" style="min-width: 80%;">
                <div class="modal-content">             
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title" id="log-name">詳細設定</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    
                    <!-- Modal body -->
                    <div class="modal-body" id = "">
                        <div class="container-fluid" >
                            <div class="row">
                                <div class="col-md-2 px-1">
                                    <button type="button" class="btn btn-info btn-block" id="hide_null" onclick="table_filter('#hide_null')">隱藏未作答</button>
                                </div>
                                <div class="col-md-2 px-1">
                                    <button type="button" class="btn btn-info btn-block" id="hide_correct" onclick="table_filter('#hide_correct')">隱藏答對</button>
                                </div>
                                <div class="col-md-2 px-1">
                                    <button type="button" class="btn btn-info btn-block" id="hide_wrong" onclick="table_filter('#hide_wrong')">隱藏答錯</button>
                                </div>
                            </div>
                            <br>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th class="col-1">題號</th>
                                        <th class="col-3">題目</th>
                                        <th class="col-3">選項</th>
                                        <th class="col-1">正解</th>
                                        <th class="col-1">學生<br>回答</th>
                                    </tr>
                                </thead>
                                <tbody id="question_table">

                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>




        <script>
            $(document).ready(function() {
                $("#hide_null").val(false);    
                $("#hide_correct").val(false);
                $("#hide_wrong").val(false);
            });
            document.getElementById('logout').addEventListener('click', function() {//delete the cookie
                document.cookie = "auth_code=000; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            });
            var question_json;
            var log_id="";
            function see_log(){
                log_id = $(this).children(":first").text()
                let log_name = $(this).children(":nth-child(2)").text()
                let get_correct =$(this).find(".correct").hasClass("btn-success")
                let get_wrong =$(this).find(".wrong").hasClass("btn-danger")
                let get_null =$(this).find(".null").hasClass("btn-secondary")
                const xmlhttp = new XMLHttpRequest();
                xmlhttp.onload = function() {
                    question_json = JSON.parse(this.responseText);
                    $("#show_questions").click()
                    $("#log-name").text("已勾選的題目")
                    set_table_filter(get_null,get_correct,get_wrong);
                    create_question_table(question_json,$("#hide_null").val()=="true",$("#hide_correct").val()=="true",$("#hide_wrong").val()=="true")
                    if(log_id == '序號'){
                        $("#resume").attr("disabled",true)
                    }
                    else{
                        $("#resume").attr("disabled",false)
                    }
                }
                xmlhttp.open("POST", "view_question.php");
                var formData = new URLSearchParams();
                formData.append('log_id', $(this).children(":first").text());
                xmlhttp.send(formData);
            }
            function convertToTable(data) {
                tableHTML = ""
                for (var i = 0; i < data.length; i++) {
                    var row = data[i];
                    let unanswer = row.total - row.correct - row.wrong
                    tableHTML += "<tr><td>" + row.log_id + "</td>";
                    tableHTML += "<td>" + row.name + "</td>";
                    tableHTML += "<td>" + row.time + "</td>";
                    tableHTML += "<td>" + row.content + "</td>";
                    tableHTML += "<td onclick=\"see_log()\" style=\"text-align: center\">\
                        <button type=\"button\" class=\"btn btn-outline-primary btn-sm all\" onclick=\"select_all(event,this)\">"+row.total+"</button>\
                        <button type=\"button\" class=\"btn btn-outline-success btn-sm correct\" onclick=\"select_correct(event,this)\">"+row.correct+"</button>\
                        <button type=\"button\" class=\"btn btn-outline-danger btn-sm wrong\" onclick=\"select_wrong(event,this)\">"+row.wrong+"</button>\
                        <button type=\"button\" class=\"btn btn-outline-secondary btn-sm null\" onclick=\"select_null(event,this)\">"+unanswer+"</button></td>"
                    tableHTML += "</tr>";
                }
                return tableHTML;
            }
            function create_question_table(question_json,hideNull,hideCorrect,hideWrong){
                let tableHTML = ""
                let options = ["A","B","C","D"]
                let TFoptions = ["T","F"]
                for(let i=0;i<question_json.length;i++){
                    let row = question_json[i];
                    let isTF = TFoptions.includes(row.ans);

                    // 判斷底色
                    if(row.user_ans!=null){//有作答
                        if(row.user_ans == row.ans){//選擇題完全相同
                            if(hideCorrect){
                                continue;
                            }
                            tableHTML += "<tr ><td class=\"bg-light-success\">" + (i+1) + "</td>";
                        }
                        else if(TFoptions[row.user_ans] == row.ans){//是非題，且答對
                            if(hideCorrect){
                                continue;
                            }
                            tableHTML += "<tr ><td class=\"bg-light-success\">" + (i+1) + "</td>";
                        }
                        else{
                            if(hideWrong){
                                continue;
                            }
                            tableHTML += "<tr ><td class=\"bg-light-danger\">" + (i+1) + "</td>";}
                    }
                    else{
                        if(hideNull){
                            continue
                        }
                        tableHTML += "<tr><td>" + (i+1) + "</td>";
                    }
                    tableHTML += "<td>" + row.question + "</td>";
                    let user_ans
                    if(isTF){
                        user_ans = row.user_ans==null?"未作答":TFoptions[row.user_ans]
                        tableHTML += "<td></td>";//無選項
                        tableHTML += "<td>" + row.ans + "</td>";
                    }
                    else{
                        user_ans = row.user_ans==null?"未作答":options[row.user_ans]

                        option_str = "<details>\
                            <summary>ABCD</summary>\
                            <p>(A)"+row.option_a+"<br>(B)"+row.option_b+"<br>(C)"+row.option_c+"<br>(D)"+row.option_d+"</p></details>"

                        tableHTML += "<td>" + option_str + "</td>";

                        tableHTML += "<td>" + options[row.ans] + "</td>";
                    }
                    tableHTML += "<td>" + user_ans + "</td>";
                    tableHTML += "</tr>";
                }
                $("#question_table").html(tableHTML)
            }
            $("#table-body").html(convertToTable(data))
            $("tr").click(see_log)
            function set_table_filter(selectNull,selectCorrect,selectWrong){//T 表示要選
                let bool_list = [selectNull,selectCorrect,selectWrong];
                let $buttons = [$("#hide_null"),$("#hide_correct"),$("#hide_wrong")]
                for(let i =0;i<3;i++){
                    if(!bool_list[i]){//因為要選所以顯示
                        $buttons[i].val("true")
                        $buttons[i].text($buttons[i].text().replace("隱藏","顯示"))
                        $buttons[i].removeClass("btn-outline-info")
                        $buttons[i].addClass("btn-info")
                    }
                    else{
                        $buttons[i].val("false")
                        $buttons[i].text($buttons[i].text().replace("顯示","隱藏"))
                        $buttons[i].removeClass("btn-info")
                        $buttons[i].addClass("btn-outline-info")
                    }
                }
            }
            function table_filter(id){
                if($(id).val()=="true"){
                    $(id).val("false")
                    $(id).text($(id).text().replace("顯示","隱藏"))
                    $(id).removeClass("btn-info")
                    $(id).addClass("btn-outline-info")
                }
                else if($(id).val()!="true"){
                    $(id).val("true")
                    $(id).text($(id).text().replace("隱藏","顯示"))
                    $(id).removeClass("btn-outline-info")
                    $(id).addClass("btn-info")
                }
                create_question_table(question_json,$("#hide_null").val()=="true",$("#hide_correct").val()=="true",$("#hide_wrong").val()=="true")
                let current_row = find_row_by_log_id(log_id);
                let btn_index = ["hide_correct","hide_wrong","hide_null"].indexOf($(id).attr("id"))+1;
                console.log(btn_index)
                current_row.find("button").eq(btn_index).click();
            }
            function find_row_by_log_id(log_id) {
                var row = $("#table-body").find("tr").filter(function() {
                    return $(this).find("td:first").text() == log_id;
                });
                return row;
            }
            function select_all(event,click_btn){//全選
                event.stopPropagation();
                var $buttons = $(click_btn).siblings("button");

                if($(click_btn).hasClass("btn-outline-primary")){//選擇全部
                    $(click_btn).removeClass("btn-outline-primary")
                    $(click_btn).addClass("btn-primary")
                    
                    $buttons.eq(0).removeClass("btn-outline-success")
                    $buttons.eq(1).removeClass("btn-outline-danger")
                    $buttons.eq(2).removeClass("btn-outline-secondary")
                    $buttons.eq(0).addClass("btn-success")
                    $buttons.eq(1).addClass("btn-danger")
                    $buttons.eq(2).addClass("btn-secondary")
                }
                else{//全部不選
                    $(click_btn).addClass("btn-outline-primary")
                    $(click_btn).removeClass("btn-primary")
                    
                    $buttons.eq(0).addClass("btn-outline-success")
                    $buttons.eq(1).addClass("btn-outline-danger")
                    $buttons.eq(2).addClass("btn-outline-secondary")
                    $buttons.eq(0).removeClass("btn-success")
                    $buttons.eq(1).removeClass("btn-danger")
                    $buttons.eq(2).removeClass("btn-secondary")
                }
            }
            function select_correct(event,click_btn){
                event.stopPropagation();
                var $buttons = $(click_btn).siblings("button");

                if($(click_btn).hasClass("btn-outline-success")){//選取
                    $(click_btn).removeClass("btn-outline-success")
                    $(click_btn).addClass("btn-success")
                    
                    if($buttons.eq(1).hasClass("btn-danger") && $buttons.eq(2).hasClass("btn-secondary")){
                        $buttons.eq(0).removeClass("btn-outline-primary")
                        $buttons.eq(0).addClass("btn-primary")
                    }
                }
                else{//取消選取
                    $(click_btn).addClass("btn-outline-success")
                    $(click_btn).removeClass("btn-success")

                    $buttons.eq(0).addClass("btn-outline-primary")
                    $buttons.eq(0).removeClass("btn-primary")
                }
            }
            function select_wrong(event,click_btn){
                event.stopPropagation();
                var $buttons = $(click_btn).siblings("button");

                if($(click_btn).hasClass("btn-outline-danger")){//選取
                    $(click_btn).removeClass("btn-outline-danger")
                    $(click_btn).addClass("btn-danger")
                    
                    if($buttons.eq(1).hasClass("btn-success") && $buttons.eq(2).hasClass("btn-secondary")){
                        $buttons.eq(0).removeClass("btn-outline-primary")
                        $buttons.eq(0).addClass("btn-primary")
                    }
                }
                else{//取消選取
                    $(click_btn).addClass("btn-outline-danger")
                    $(click_btn).removeClass("btn-danger")
                    
                    $buttons.eq(0).addClass("btn-outline-primary")
                    $buttons.eq(0).removeClass("btn-primary")
                }
            }
            function select_null(event,click_btn){
                event.stopPropagation();
                var $buttons = $(click_btn).siblings("button");

                if($(click_btn).hasClass("btn-outline-secondary")){//選取
                    $(click_btn).removeClass("btn-outline-secondary")
                    $(click_btn).addClass("btn-secondary")
                    
                    if($buttons.eq(1).hasClass("btn-success") && $buttons.eq(2).hasClass("btn-danger")){
                        $buttons.eq(0).removeClass("btn-outline-primary")
                        $buttons.eq(0).addClass("btn-primary")
                    }
                }
                else{//取消選取
                    $(click_btn).addClass("btn-outline-secondary")
                    $(click_btn).removeClass("btn-secondary")
                    
                    $buttons.eq(0).addClass("btn-outline-primary")
                    $buttons.eq(0).removeClass("btn-primary")
                }
            }
            function combine(){
                let combine_list = [];
                let $table = $("#table-body tr");
                for (let i = 0; i < $table.length; i++) {
                    let row = $table[i];
                    let temp = {};
                    temp['log_id'] = $(row).find("td:first").text();
                    temp['all'] = $(row).find("button").eq(0).hasClass("btn-primary")
                    temp['correct'] = $(row).find("button").eq(1).hasClass("btn-success")
                    temp['wrong'] = $(row).find("button").eq(2).hasClass("btn-danger")
                    temp['null'] = $(row).find("button").eq(3).hasClass("btn-secondary")
                    if(temp['all']+temp['correct']+temp['wrong']+temp['null']){//if have chosen in this log
                        combine_list.push(temp);
                    }
                }
                if(combine_list.length>0){
                    const xmlhttp = new XMLHttpRequest();
                    xmlhttp.onload = function() {
                        //console.log(this.responseText)
                        return setTimeout(function(){location.href="intest.php"},500);
                    }
                    xmlhttp.open("POST", "combine.php");
                    var formData = new URLSearchParams();
                    formData.append('data', JSON.stringify(combine_list));
                    formData.append('time-stamp', current_time());
                    formData.append('log-name', $("#log-name").val());
                    formData.append('shuffle', document.querySelector('input[name="shuffle"]:checked').value);
                    formData.append('skipTF', document.querySelector('input[name="skipTF"]:checked').value);
                    formData.append('delDuplicate', document.querySelector('input[name="delDuplicate"]:checked').value);
                    xmlhttp.send(formData);
                }
                else{
                    $("#alert-box-danger").css("display","block")
                }
            }
            function current_time(){
                let currentDate = new Date();
                // 格式化日期和时间
                let year = currentDate.getFullYear();
                let month = ("0" + (currentDate.getMonth() + 1)).slice(-2);
                let day = ("0" + currentDate.getDate()).slice(-2);
                let hours = ("0" + currentDate.getHours()).slice(-2);
                let minutes = ("0" + currentDate.getMinutes()).slice(-2);
                let seconds = ("0" + currentDate.getSeconds()).slice(-2);
                // 設定placeholder
                let formattedDate = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
                return formattedDate;
            }
        </script>
        <?php
            ob_end_flush();
            redirect();//redirect if not login.
            
        ?>

    </body>
</html>    