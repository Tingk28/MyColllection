<?php
    //the contact us form have my basic information
    //and all the data will be stored in `connect_us` table immediately
    session_start();
    ob_start();
    include 'connectdb.php';
    if(!isset($_COOKIE['auth_code'])){
        setcookie('auth_code', "000", time() + 3600, '/');
    }
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
            本系統為課堂的Final project，作者並不擁有內部題目的著作權。請勿任意散播。<br>
            作者：會計112 郭庭維<br>
            聯絡email: h14086030@gs.ncku.edu.tw<br>
            <hr>
            如果有遇到任何問題或有任何意見，請填寫下列表格與我們聯繫。<br>
            <br>
            回饋表單
            <div class="alert alert-success" id="alert-box-success" style="display:none">
                <strong>成功</strong>&nbsp;&nbsp;感謝您的回饋，我們已經收到您的留言
            </div>
            <form method="post" action="contact_us.php">
                <div class="form-group">
                    <label for="name">姓名</label>
                    <input type="text" class="form-control" id="name" placeholder="匿名同學" name="name">
                </div>
                <div class="form-group">
                    <label for="email">電子信箱</label>
                    <input type="email" class="form-control" id="email" placeholder="email" name="email">
                </div>
                <div class="form-group">
                    <label for="email">主旨</label>
                    <input type="text" class="form-control" id="subject" placeholder="" name="subject" required>
                </div>
                <div class="form-group">
                    <label for="comment">Comment:</label>
                    <textarea class="form-control" rows="5" id="content" name="content" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
        <script>
            document.getElementById('logout').addEventListener('click', function() {//delete the cookie
                document.cookie = "auth_code=000; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            });
        </script>
        <?php
            if ($_SERVER["REQUEST_METHOD"] == "POST"){
                $conn = get_db();
                $sql = "INSERT INTO `contact_us`(`ID`, `name`, `email`, `subject`, `content`) VALUES (NULL,:name,:email,:subject,:content)";
                $stmt = $conn->prepare($sql);
                $stmt->bindParam(':name', $_POST['name']);
                $stmt->bindParam(':email', $_POST['email']);
                $stmt->bindParam(':subject', $_POST['subject']);
                $stmt->bindParam(':content', $_POST['content']);
                $stmt->execute();
                echo "<script>$(\"#alert-box-success\").css(\"display\",\"block\")</script>";
                ob_end_flush();
            }
            else{
                ob_end_flush();
            }
        ?>

    </body>
</html>    