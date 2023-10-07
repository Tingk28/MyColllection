<?php
    //the form to have a new test. the user can choose which chapter they want and go to create.php
    session_start();
    include 'connectdb.php';
    include 'common_lib.php';
    if(!isset($_COOKIE['auth_code'])){
        setcookie('auth_code', "000", time() + 3600, '/');
    }
?>
<!-- verification.php -->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>新增測驗</title>
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            #chapter, #LOs, #options{
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
            }
            #chapter button, #LOs button, #options button{
                flex: 1 0 100px;
                max-height: 50px;
                margin-right: 10px;
                margin-bottom: 10px;
            }
            
            #chapter btn:last-child, #LOs btn:last-child, #options btn:last-child {
                margin-right: 0;
            }

            @media (max-width: 500px) {
                img {
                    display: none;
                }
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
        <br>
        <div class="container">
            <h1 style="text-align: center;">新增練習</h1>
            <div class="container" id="chapter">
                
            </div>
            <hr>
            <div class="container" id="LOs" style="min-height: 45px;">
                
            </div>
            <hr>
            <div class="container" id="options" style="min-height: 45px;">
                <button class="btn btn-outline-warning" id = "clear-all">清除全部</button>
                <button class="btn btn-outline-primary" id="send" data-toggle="modal" data-target="#Modal-popup" onclick="set_placeholder()">送出</button>
            </div>
            <hr>
            <div class="container">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th class="col-5">章節</th>
                        <th class="col-5">LOs</th>
                        <th class="col-2 text-center">刪除</th>
                    </tr>
                    </thead>
                    <tbody id="table-body">
                    
                    </tbody>
                </table>
            </div>
            <!-- The Modal -->
            <div class="modal fade" id="Modal-popup">
                <div class="modal-dialog modal-sm">
                <div class="modal-content">
                
                    <!-- Modal Header -->
                    <div class="modal-header">
                    <h4 class="modal-title">詳細設定</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    
                    <!-- Modal body -->
                    <div class="modal-body">
                    <form action="create.php">
                        <div class="form-group">
                            <div class="alert alert-success" id="alert-box-success" style="display:none;padding-left:10px">
                                <strong>成功</strong>&nbsp;&nbsp;資料已新增
                            </div>
                            <div class="alert alert-danger" id="alert-box-danger" style="display:none;padding-left:10px">
                                <strong>錯誤</strong>&nbsp;&nbsp;請選擇章節
                            </div>
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

                            <!-- <input type="text" class="form-control" id="log-name" placeholder="" name="email"> -->
                        </div>
                    </form>
                    </div>
                    
                    <!-- Modal footer -->
                    <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="post_select()">確定</button>
                    </div>
                    
                </div>
                </div>
            </div>
        </div>
        <script>
            document.getElementById('logout').addEventListener('click', function() {//delete the cookie
                document.cookie = "auth_code=000; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            });
            function set_placeholder(){
                $("#alert-box-danger").css('display','none');
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
                document.getElementById("log-name").placeholder = formattedDate;
            }
            function post_select() {
                if(chapter_select.length == 0){
                    return $("#alert-box-danger").css('display','block')
                }
                const xmlhttp = new XMLHttpRequest();
                xmlhttp.onload = function() {
                    //console.log(xmlhttp.responseText)
                    $("#alert-box-success").css('display','block')
                    return setTimeout(function(){location.href="intest.php"},500);
                }
                xmlhttp.open("POST", "create.php");
                var formData = new URLSearchParams();
                formData.append('log-name', $("#log-name").val() || $("#log-name").attr("placeholder"));
                formData.append('time-stamp', $("#log-name").attr("placeholder"));
                formData.append('shuffle', document.querySelector('input[name="shuffle"]:checked').value);
                formData.append('skipTF', document.querySelector('input[name="skipTF"]:checked').value);
                formData.append('chapter-select', JSON.stringify(chapter_select));

                xmlhttp.send(formData);
            }
        </script>
        <?php
            redirect();//redirect if not login.
            $conn = get_db();
            $sql = "SELECT DISTINCT chapter,LO FROM question_table";
            
            $stmt = $conn->prepare($sql);
            $stmt->execute();

            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $conn = null;
            if(count($result)==0){
                echo "<script>setTimeout(() => {location.href=\"login.php\"}, \"500\");</script>";
                die;
            }
            echo "<script>chapter_list = ".generateJSON($result)."</script>";
        ?>
        <script>
            function isSelect(data,chapter,lo){
                for(var i=0;i<data.length;i++){
                    let temp = data[i]
                    if(temp['chapter']==chapter && temp['lo']==lo){
                        return true
                    }
                }
                return false
            }
            function convertToTable(data) {
                let tableHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var row = data[i];
                    tableHTML += "<tr><td>" + row.chapter + "</td>";
                    tableHTML += "<td>" + row.lo + "</td>";
                    tableHTML += "<td class=\"text-center\"><button class=\"delete-btn btn btn-secondary text-right\">Delete</button></td>";
                    tableHTML += "</tr>";
                }

                return tableHTML;
            }
            function convertToData(){
                var tableData = [];
                $("#table-body tr").each(function() {
                    var chapter = $(this).find("td:first-child").text().trim();
                    var lo = $(this).find("td:nth-child(2)").text().trim();
                    tableData.push({ "chapter": chapter, "lo": lo });
                });
                return tableData;
            }
            var current_chapter = Object.keys(chapter_list)[0]
            //generate the buttons
            var chapter_btn_list_html = ""
            var chapter_select = [] //使用者加入的章節表
            $("#clear-all").click(function(){
                chapter_select = []
                $("#table-body").html(convertToTable(chapter_select))
                $("#LOs button").prop("disabled",false);
                $("#LOs button").removeClass("btn-outline-secondary");
                $("#LOs button").removeClass("btn-outline-success");
                $("#LOs button").addClass("btn-outline-success");
            })
            for(chapter in chapter_list){
                chapter_btn_list_html += "<button type=\"button\" class=\"btn btn-outline-success\" id=\"chapter"+chapter+"\">第"+chapter+"章</button>"
            }
            $("#chapter").html(chapter_btn_list_html)
            var chapter_btn_list = new Array()
            for(chapter in chapter_list){
                let btn = $("#chapter" + chapter)
                chapter_btn_list.push(btn)
            }
            for(chapter in chapter_list){
                (function(chapter) {
                    $("#chapter" + chapter).click(function() {
                        current_chapter = chapter
                        for (var i = 0; i < chapter_btn_list.length; i++) {
                            var currentBtn = chapter_btn_list[i];
                            if (currentBtn.is(this)) {
                                currentBtn.removeClass("btn-outline-success");
                                currentBtn.addClass("btn-success");
                            }
                            else {
                                currentBtn.removeClass("btn-success");
                                currentBtn.addClass("btn-outline-success");
                            }
                        }
                        let LO_list = "";
                        for (var i = 0; i < chapter_list[chapter].length; i++) {
                            var lo = chapter_list[chapter][i];
                            if(isSelect(chapter_select,current_chapter,lo)){
                                LO_list += "<button type=\"button\" class=\"btn btn-outline-secondary\" disabled id=\"" + lo + "\">" + lo + "</button>";
                            }
                            else{
                                LO_list += "<button type=\"button\" class=\"btn btn-outline-success\" id=\"" + lo + "\">" + lo + "</button>";
                            }
                        }
                        LO_list += "<button type=\"button\" class=\"btn btn-outline-success\" id=\"add-all\">全選</button>";
                        $("#LOs").html(LO_list);
                        for(lo in chapter_list[chapter]){
                            (function(lo) {
                                $("#LO" + lo).click(function() {
                                    chapter_select.push({ "chapter": current_chapter, "lo": $(this).text() })
                                    $("#table-body").html(convertToTable(chapter_select))//update table content
                                    $(this).prop("disabled", true);
                                    $(this).removeClass("btn-outline-success");
                                    $(this).addClass("btn-outline-secondary");

                                    // add addEventListener on delete btn
                                    $("#table-body").on("click", ".delete-btn", function() {
                                        let del_chapter = $(this).closest("tr").find("td:first-child").text().trim()
                                        if(del_chapter == current_chapter){//restore btn format
                                            let del_lo = $(this).closest("tr").find("td:nth-child(2)").text().trim()
                                            $("#"+del_lo).prop("disabled",false)
                                            $("#"+del_lo).removeClass("btn-outline-secondary");
                                            $("#"+del_lo).addClass("btn-outline-success");
                                            $("#add-all").prop("disabled",false);
                                            $("#add-all").removeClass("btn-outline-secondary");
                                            $("#add-all").addClass("btn-outline-success");
                                        }
                                        $(this).closest("tr").remove();//remove data in table
                                        chapter_select = convertToData()//update chapter_select
                                    });
                                });
                                
                            })(parseInt(lo)+1);
                        }
                        $("#add-all").click(function() {
                            $("#LOs button:not(:disabled)").not('#add-all').click();
                            $(this).prop("disabled",true)
                            $(this).removeClass("btn-outline-success");
                            $(this).addClass("btn-outline-secondary");         
                        });
                    });
                })(chapter);
            }
            $("#chapter button:first").click()
        </script>

    </body>
</html>    