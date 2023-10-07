<?php
    session_start();
    isset($_SESSION["send_email"])?$_SESSION["send_email"]:$_SESSION["send_email"]=false;
    isset($_SESSION["verify"])?$_SESSION["verify"]:$_SESSION["verify"]=false;
    include 'connectdb.php';
    require 'PHPMailer/src/PHPMailer.php';
    require 'PHPMailer/src/SMTP.php';
    require 'PHPMailer/src/Exception.php';
    
    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\SMTP;
    use PHPMailer\PHPMailer\Exception;
?>
<!-- forget_pwd.php -->
<html>
    <head>
    <meta charset="UTF-8">
        <title>忘記密碼</title>
        <link rel="stylesheet" href="login_form.css">
        <style>
            .login_form form input{
                width:78%;
            }
            .login_form form button{
                width:20%;
                height:5%;
                font-size: 0.7em;
            }   
            .login_form form button:disabled{
                width:20%;
                height:5%;
                font-size: 0.7em;
            }
            button:disabled{
                background-color: rgb(149, 209, 149);
            }         
        </style>
        <?php

            if ($_SERVER["REQUEST_METHOD"] == "POST"){

                $conn = get_db();   
                if(!$_SESSION["send_email"]){//尚未傳送email
                    $_SESSION["student_id"] = $_POST["student_id"];
                    //查詢該帳號是否存在
                    
                    $sql = "SELECT ID FROM users WHERE student_ID = :student_ID";
                    
                    $stmt = $conn->prepare($sql);
                    $stmt->bindParam(':student_ID', $_POST["student_id"]);
                    //echo "變數到".var_dump($stmt)."<br>";
                    $stmt->execute();
                    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

                    if(count($result) ==1 ){//帳號存在
                        $mail = new PHPMailer(true);
                        $mail->CharSet = 'UTF-8';
                        try {
                            // 設定郵件伺服器的相關資訊
                            $mail->isSMTP();
                            $mail->Host = 'smtp.gmail.com';
                            $mail->SMTPAuth = true;
                            $mail->Username = ''; // 您的 Gmail 信箱
                            $mail->Password = ''; // 您的 Gmail 密碼
                            $mail->SMTPSecure = 'tls';
                            $mail->Port = 587;

                            // 寄件者和收件者資訊
                            $mail->setFrom('your_eamil_address@gmail.com', '審計選擇題系統');
                            $email = $_POST["student_id"]."@gs.ncku.edu.tw";
                            $mail->addAddress($email, '');
                            
                            // 郵件內容
                            $code = generateVerificationCode();
                            $mail->isHTML(true);
                            $mail->Subject = '審計選擇題系統重設密碼';
                            $mail->Body = $_POST["student_id"] . '您好：<br>您的驗證碼是：'.$code;
                            
                            // 發送郵件
                            $mail->send();
                            //將資料寫入資料庫
                            $sql = "UPDATE `users` SET var_code=:var_code WHERE student_ID = :student_id";

                            $stmt = $conn->prepare($sql);
                            $stmt->bindParam(':var_code', $code);
                            $stmt->bindParam(':student_id', $_POST["student_id"]);
                            
                            if ($stmt->execute()) {
                                $_SESSION["send_email"] = true;
                            } else {
                                echo "帳號啟動失敗";
                            }
                        } 
                        catch (Exception $e) {
                            echo '郵件寄送失敗：' . $mail->ErrorInfo;
                        }
                    }
                    else{
                        echo '<script>alert("該帳號不存在，請重新檢查或點擊註冊")</script>';                        
                    }
                }
                else if(!$_SESSION["verify"]){//輸入驗證碼
                    $sql = "SELECT var_code FROM `users` WHERE student_ID = :student_id";
                
                    $stmt = $conn->prepare($sql);
                    $stmt->bindParam(':student_id', $_SESSION["student_id"]);
                    $stmt->execute();
                
                    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                    if (count($result) > 0) {//如果有查到這個email
                        //檢查該email 是否存在過
                        $row = $result[0];
                        $varCode = $row['var_code'];
                        if($varCode == (int)$_POST['var_code']&&$_POST['var_code']!=""){
                            $_SESSION["verify"] = true;
                            //移除驗證碼
                            $sql = "UPDATE users SET var_code = NULL WHERE student_ID = :student_id";
                            $stmt = $conn->prepare($sql);
                            $stmt->bindParam(':student_id', $_SESSION["student_id"]);
                            $stmt->execute();
                        }
                        else{
                            echo "<script>alert(\"驗證碼錯誤\")</script>";
                        }
                    }
                }
                else if($_SESSION["send_email"]&&$_SESSION["verify"]){//重設密碼
                    //移除驗證碼
                    $sql = "UPDATE users SET pwd = :pwd WHERE student_ID = :student_id";
                    $stmt = $conn->prepare($sql);
                    $stmt->bindParam(':pwd', password_hash($_POST["pwd"], PASSWORD_DEFAULT));
                    $stmt->bindParam(':student_id', $_SESSION["student_id"]);
                    $stmt->execute();
                    $conn = null;

                    unset($_SESSION["send_email"]);
                    unset($_SESSION["verify"]);
                    echo "<script>alert(\"已重設密碼\")</script>";
                    echo "<script>setTimeout(() => {location.href=\"login.php\"}, \"0\");</script>";
                    die;
                }
            }
            else{
                $_SESSION["send_email"]=false;
                $_SESSION["verify"]=false;
            }
            $conn = null;
            function generateVerificationCode() {//隨機生成六位數密碼
                return rand(100000, 999999);
            }
        ?>
    </head>
    <body>
        <h1>審計選擇題系統</h1>
        <div class="login_form">
            <h1 style="text-align: center;">忘記密碼</h1>
            <form method="post" action="forget_pwd.php">
                <label>學號：</label>                
                <input type="text" name="student_id" id="student_id" value="<?php echo isset($_SESSION["student_id"])?$_SESSION["student_id"]:"";?>" pattern="[A-Z a-z][0-9]{8}" <?php echo $_SESSION["send_email"]?"disabled":"required";?>>
                <button name = "btn" value = "send_email" id="send_email_btn"
                    <?php echo $_SESSION["send_email"]?"disabled":"required";?>>
                    <?php echo $_SESSION["send_email"]?"已寄出":"寄送驗證碼";?>
                </button> <br>
                <label>驗證碼：</label>
                <input type="text" name="var_code" id="var_code" value="<?php echo isset($_POST["var_code"])?$_POST["var_code"]:"";?>" <?php echo (bool)($_SESSION["send_email"]) && (!$_SESSION["verify"])?"required":"disabled";?> >
                <button name = "btn" value = "verify" <?php echo (bool)($_SESSION["send_email"]) && (!$_SESSION["verify"])?:"disabled";?>>
                    <?php echo $_SESSION["verify"]?"已驗證":"驗證";?>
                </button> <br>
                <label>新密碼：</label>
                <input type="password" name="pwd" id="pwd" style="width:100%" <?php echo $_SESSION["verify"]?"required":"disabled";?>> <br>
                
                <input type="submit" name="btn" id="submit" value="set_pwd" style="display: none;">
            </form>
            <button id="register" <?php echo $_SESSION["verify"]?:"disabled";?>>更改密碼</button>
            <p style="text-align: center;"><a href="login.php">登入</a></p>
            <script>
                register.addEventListener("click",function(){
                    document.getElementById("submit").click();
                })
            </script>
        </div>
        

    </body>
</html>    