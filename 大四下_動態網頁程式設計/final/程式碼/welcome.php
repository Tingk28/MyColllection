<?php
    // the welcome page for all the functions
    // and get a accouncement from database
    // then we can update a accouncement without restart the server.
    session_start();
    ob_start();
    include 'connectdb.php';
    include 'common_lib.php';
    if(!isset($_COOKIE['auth_code'])){
        setcookie('auth_code', "000", time() + 3600, '/');
    }
    redirect();//redirect if not login.
    $conn = get_db();
    $sql = "SELECT title,content FROM announcement ORDER BY id DESC LIMIT 1;";
    $stmt = $conn->prepare($sql);
    $stmt->execute();

    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $conn = null;
?>
<!-- verification.php -->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>驗證</title>
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
            
        </style>
    </head>
    <body>
        <div class="container" style="height:8%">
            <span class="h1 d-inline">審計選擇題系統</span>
            <div class="float-right d-flex align-items-center" style="height: 48px;">
                <a href="contact_us.php">聯絡我們</a>&emsp;|&emsp;
                <a href="" id="logout">登出</a>
            </div>
        </div>
        <br>
        <div class="container">
            <h1 style="text-align: center;">歡迎：<?php echo strtoupper($_SESSION['student_id']); ?>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                    公佈欄：<?php echo $result[0]['title']; ?>
                </button>
            </h1>
            <div class="container" style="height:25%">
                <a href="new_test.php">
                    <button class="btn btn-lg btn-success" style="height:100%; width:100%">
                        <img src="img/exam.png" alt="" style="height:85%">
                        <span style="font-size:2.5em;color:black">新增練習</span>
                    </button>

                </a>
            </div>
            <div class="container" style="height:25%">
                <a href="view_log.php">
                    <button class="btn btn-lg btn-primary" style="height:100%; width:100%">
                        <img src="img/log.png" alt="" style="height:90%">
                        <!-- <a href="https://www.flaticon.com/free-icons/history" title="history icons">History icons created by Arkinasi - Flaticon</a>     -->
                        <span style="font-size:2.5em;color:black">練習紀錄</span>
                    </button>
                </a>
            </div>
            <div class="container" style="height:25%">
                <a href="combine_log.php">
                    <button class="btn btn-lg btn-warning" style="height:100%; width:100%">
                        <img src="img/edit.png" alt="" style="height:80%">
                        <!-- <a href="https://www.flaticon.com/free-icons/history" title="history icons">History icons created by Arkinasi - Flaticon</a>     -->
                        <span style="font-size:2.5em;color:black">合併紀錄</span>
                    </button>
                </a>
            </div>
        </div>
        <!-- The Modal -->
        <div class="modal" id="myModal">
            <div class="modal-dialog">
                <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title"><?php echo $result[0]['title']; ?></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <?php echo $result[0]['content']; ?>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>

                </div>
            </div>
        </div>
        <script>
            document.getElementById('logout').addEventListener('click', function() {//delete the cookie
                document.cookie = "auth_code=000; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            });
        </script>
        <?php
            ob_end_flush();
        ?>

    </body>
</html>    