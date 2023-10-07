<?php
    // viewing all the log that user have
    session_start();
    ob_start();
    include 'connectdb.php';
    include 'common_lib.php';
    if(!isset($_COOKIE['auth_code'])){
        setcookie('auth_code', "000", time() + 3600, '/');
    }

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
    
    $conn = get_db();
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
        <title>檢視紀錄</title>
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            td span, th span{
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
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg" id="show_questions" style="display:none">Large modal</button>
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
                                
                                <div class="col-md-4 px-1"></div>
                                <div class="col-md-2 px-1">
                                    <button type="button" class="btn btn-info btn-block" id="resume" onclick="resume()">繼續作答</button>
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
                const xmlhttp = new XMLHttpRequest();
                xmlhttp.onload = function() {
                    // alert(this.responseText);
                    question_json = JSON.parse(this.responseText);
                    $("#show_questions").click()
                    $("#log-name").text(log_name)
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
                        <span class=\"badge badge-primary\">"+row.total+"</span>\
                        <span class=\"badge badge-success\">"+row.correct+"</span>\
                        <span class=\"badge badge-danger\">"+row.wrong+"</span>\
                        <span class=\"badge badge-secondary\">"+unanswer+"</span></td>";
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
            }
            function resume(){
                const xmlhttp = new XMLHttpRequest();
                xmlhttp.onload = function() {
                    //console.log(this.responseText)
                    return setTimeout(function(){location.href="intest.php"},500);
                }
                xmlhttp.open("POST", "resume.php");
                var formData = new URLSearchParams();
                formData.append('log_id', log_id);
                xmlhttp.send(formData);
            }
        </script>
        <?php
            ob_end_flush();
            redirect();//redirect if not login.
        ?>

    </body>
</html>    