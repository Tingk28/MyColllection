<?php
    session_start();
    include 'connectdb.php';
?>
<!-- register.php -->
<html>
    <head>
        <meta charset="UTF-8">
        <title>註冊</title>
        <link rel="stylesheet" href="login_form.css">
    </head>
    <body>
        <h1>審計選擇題系統</h1>
        <div class="login_form">
            <h1 style="text-align: center;">註冊</h1>
            <form method="post" action="register.php">
                <label>學號：</label>
                <input type="text" name="student_id" id="student_id" pattern="[A-Z a-z][0-9]{8}" required="required"><br>
                <label>密碼：</label>
                <input type="password" name="pwd" id="pwd" required="required"><br>
                <input type="submit" name="submit()" id="submit" style="display: none;">
            </form>
            <button id="register">註冊</button>
            <p style="text-align: center;"><a href="login.php">登入</a></p>
            <script>
                register.addEventListener("click",function(){
                    document.getElementById("submit").click();
                })
            </script>
            <?php
                
                require 'PHPMailer/src/PHPMailer.php';
                require 'PHPMailer/src/SMTP.php';
                require 'PHPMailer/src/Exception.php';
                
                use PHPMailer\PHPMailer\PHPMailer;
                use PHPMailer\PHPMailer\SMTP;
                use PHPMailer\PHPMailer\Exception;
                if ($_SERVER["REQUEST_METHOD"] == "POST"){
                    if(!preg_match("/[A-Z a-z][0-9]{8}/",$_POST["student_id"])){
                        echo "字串格式不符";
                        die;
                    }

                    $_POST["student_id"] = strtolower($_POST["student_id"]);
                    $_SESSION["student_id"] = $_POST["student_id"];
                    $email = $_POST["student_id"]. "@gs.ncku.edu.tw";
                    
                    $conn = get_db();
                    $sql = "SELECT id, student_ID, pwd, email FROM users WHERE student_ID = :student_id";
                    
                    $stmt = $conn->prepare($sql);
                    $stmt->bindParam(':student_id', $_SESSION["student_id"]);
                    $stmt->execute();

                    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    
                    if (count($result) > 0) {
                        //檢查該email 是否存在過
                        echo '<script>alert("該email已存在，請登入")</script>';
                        $conn = null;
                        echo "頁面將自動跳轉";
                        echo "<script>setTimeout(() => {location.href=\"login.php\"}, \"500\");</script>";
                        echo "若沒有跳轉，請點擊<a href=\"login.php\">這裡</a>";
                        die;
                    }
                    else {
                        echo '<script>alert("歡迎註冊")</script>';
                        
                        // 建立新的 PHPMailer 實例
                        $mail = new PHPMailer(true);
                        $mail->CharSet = 'UTF-8';
                        try {
                            // 設定郵件伺服器的相關資訊
                            $mail->isSMTP();
                            $mail->Host = 'smtp.gmail.com';
                            $mail->SMTPAuth = true;
                            $mail->Username = '@gmail.com'; // 您的 Gmail 信箱
                            $mail->Password = ''; // 您的 Gmail 密碼
                            $mail->SMTPSecure = 'tls';
                            $mail->Port = 587;
                            // 寄件者和收件者資訊
                            $mail->setFrom('@gmail.com', '審計選擇題系統');
                            $mail->addAddress($email, '');
                            
                            // 郵件內容
                            $code = generateVerificationCode();
                            $mail->isHTML(true);
                            $mail->Subject = '審計選擇題系統驗證碼';
                            $mail->Body = $_POST["student_id"] . '您好：<br>您的驗證碼是：'.$code;
                            
                            // 發送郵件
                            $mail->send();
                            echo '驗證碼已寄至您的信箱！<br>'. $email;
                            echo '<br>若沒有收到信請檢查垃圾郵件，或與H14086030@gs.ncku.edu.tw聯繫<br>';
                            
                            //將資料寫入資料庫
                            $sql = "INSERT INTO `users` (`ID`, `student_ID`, `pwd`, `email`, `is_active`, `role_id`, `var_code`) VALUES (NULL, :student_id, :pwd, :email, '0', '0', :code)";

                            $stmt = $conn->prepare($sql);
                            $pwd = password_hash($_POST["pwd"], PASSWORD_DEFAULT);
                            $stmt->bindParam(':student_id', $_POST["student_id"]);//email與學號固定為小寫
                            $stmt->bindParam(':pwd',$pwd);
                            $stmt->bindParam(':email', $email);
                            $stmt->bindParam(':code', $code);
                            $stmt->execute();
                            
                        } 
                        catch (Exception $e) {
                            echo '郵件寄送失敗：' . $mail->ErrorInfo;
                        }
                        $conn = null;
                        echo "頁面將在五秒後跳轉";

                        echo "<script>setTimeout(() => {location.href=\"verification.php\"}, \"5000\");</script>";
                        echo "若沒有跳轉，請點擊<a href=\"verification.php\">這裡</a>";

                        die;
                    }
                }
                function generateVerificationCode() {//隨機生成六位數密碼
                    return rand(100000, 999999);
                }
                
                ?>
        </div>

    </body>
</html>