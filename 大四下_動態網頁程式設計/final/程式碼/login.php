<?php
    //the login form, if the user haven't verificated their eamil yet, will redirect to verification.php
    //otherwise, to welcome.php
    session_start();
    ob_start();
    include 'connectdb.php';
    if(!isset($_COOKIE['auth_code'])){
        setcookie('auth_code', "000", time() + 3600, '/');
    }
?>
<!-- login.php -->
<html>
    <head>
    <meta charset="UTF-8">
        <title>登入</title>
        <link rel="stylesheet" href="login_form.css">
    </head>
    <body>
        <h1>審計選擇題系統</h1>
        <div class="login_form">
            <h1 style="text-align: center;">登入</h1>
            <form method="post" action="login.php">
                <label>學號：</label>
                <input type="text" name="student_id" id="student_id" value="<?php echo isset($_POST["student_id"])?$_POST["student_id"]:"";?>" pattern="[A-Z a-z][0-9]{8}" required="required"><br>
                <label>密碼：</label>
                <input type="password" name="pwd" id="pwd" required="required" value="<?php echo isset($_POST["pwd"])?$_POST["pwd"]:"";?>"><br>
                <input type="submit" name="submit()" id="submit" style="display: none;">
            </form>
            <button id="register">登入</button>
            <p style="text-align: center;"><a href="register.php">註冊</a></p>
            <p style="text-align: center;"><a href="forget_pwd.php">忘記密碼</a></p>
            <p style="text-align: center;"><a href="contact_us.php">聯絡我們</a></p>

            <script>
                register.addEventListener("click",function(){
                    document.getElementById("submit").click();
                })
            </script>
        </div>
        <?php
            $conn = get_db();
            $sql = "SELECT student_ID FROM users WHERE auth_code = :auth_code";
            
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':auth_code', $_COOKIE["auth_code"]);
            $stmt->execute();

            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $conn = null;
            if(count($result)==1){
                $row = $result[0];
                $_SESSION["student_id"] = $row['student_ID'];
                echo "<script>setTimeout(() => {location.href=\"welcome.php\"}, \"500\");</script>";
                ob_end_flush();
                die;
            }
            if ($_SERVER["REQUEST_METHOD"] == "POST"){
                if(!preg_match("/[A-Z a-z][0-9]{8}/",$_POST["student_id"])){
                    echo "字串格式不符";
                    ob_end_flush();
                    die;
                }
                //記錄下帳號密碼
                $_SESSION["student_id"] = $_POST["student_id"];
                //檢查登入是否成功
                $conn = get_db();
                $sql = "SELECT student_ID, pwd, is_active FROM users WHERE student_ID = :student_ID";
                
                $stmt = $conn->prepare($sql);
                $stmt->bindParam(':student_ID', $_SESSION["student_id"]);
                //echo "變數到".var_dump($stmt)."<br>";
                $stmt->execute();

                $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
                $conn = null;
                
                if (count($result) == 0) {
                    echo '<script>alert("該帳號不存在，請重新檢查或點擊註冊")</script>';
                    ob_end_flush();
                }
                else if (count($result)==1){
                    $row = $result[0];
                    if(password_verify($_POST["pwd"], $row["pwd"])){//若密碼正確
                        if($row["is_active"]=="1"){//帳號已經啟用
                            $randomCode = hash('sha256', uniqid());
                            setcookie('auth_code', $randomCode , time() + 10800, '/');
                            $_SESSION['auth_code'] = $randomCode;

                            $conn = get_db();
                            $sql = "UPDATE users SET auth_code = :auth_code WHERE student_ID = :student_id";
                            $stmt = $conn->prepare($sql);
                            $stmt->bindParam(':auth_code', $randomCode);
                            $stmt->bindParam(':student_id', $_SESSION["student_id"]);
                            $stmt->execute();
                            $conn = null;

                            echo '<script>alert("登入成功")</script>';
                            echo "<script>setTimeout(() => {location.href=\"welcome.php\"}, \"500\");</script>";
                            ob_end_flush();
                            die;
                        }
                        if($row["is_active"]=="0"){//帳號尚未啟用
                            echo '<script>alert("您的帳號尚未啟動，請前往驗證")</script>';
                            echo "<script>setTimeout(() => {location.href=\"verification.php\"}, \"500\");</script>";
                            ob_end_flush();
                            die;
                        }
                    }
                    else{
                        echo '<script>alert("帳號或密碼錯誤")</script>';
                    }
                }
                else{//若有多個帳號（但應該不會發生這種事）
                    echo '<script>alert("重複註冊，請與管理員聯繫")</script>';
                }

                ob_end_flush();
            }
        ?>

    </body>
</html>    