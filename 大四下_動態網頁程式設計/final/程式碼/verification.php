<?php
    //for activate user account by verificate their email
    session_start();
    include 'connectdb.php';
?>
<!-- verification.php -->
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>驗證</title>
        <link rel="stylesheet" href="login_form.css">
        <!-- bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body>
        <h1>審計選擇題系統</h1>
        <div class="login_form">
            <h1 style="text-align: center;">輸入驗證碼</h1>
            <form method="post" action="verification.php" >
                <label>請輸入驗證碼，共6位數：</label>
                <input type="number" name="var_code" id="var_code" required="required"><br>
                <input type="submit" name="submit()" id="submit" style="display: none;">
            </form>
            <button id="verify">驗證</button>
            <p style="text-align: center;"><a href="login.php">登入</a></p>
            <script>
                verify.addEventListener("click",function(){
                    document.getElementById("submit").click();
                })
            </script>
            <?php
                if ($_SERVER["REQUEST_METHOD"] == "POST"){
                    try {
                        $conn = get_db();
                    
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
                                echo "<script>alert(\"驗證成功，請重新登入\")</script>";
                                //將帳號設定為active
                                $sql = "UPDATE `users` SET is_active=1 WHERE student_ID = :student_id";

                                $stmt = $conn->prepare($sql);
                                $stmt->bindParam(':student_id', $_SESSION["student_id"]);
                                
                                if ($stmt->execute()) {
                                    echo "帳號已啟動<a herf=\"login.php\">回首頁</>";
                                    //將var_code 改為null
                                    $sql = "UPDATE users SET var_code = NULL WHERE student_ID = :student_id";
                                    $stmt = $conn->prepare($sql);
                                    $stmt->bindParam(':student_id', $_SESSION["student_id"]);
                                    $stmt->execute();
                                    $conn = null;
                                    
                                    echo "<script>setTimeout(() => {location.href=\"login.php\"}, \"500\");</script>";
                                    die;
                                } else {
                                    echo "帳號啟動失敗";
                                }
                                
                            }
                            else{
                                echo "驗證碼錯誤";
                            }
                        }
                        else{
                            echo '<script>alert("查不到該email相關紀錄，請與管理員聯絡")</script>';
                        }
                        $conn = null;
                    } catch (PDOException $e) {
                        echo "Connection failed: " . $e->getMessage();
                    }
                }
            ?>
        </div>

    </body>
</html>    