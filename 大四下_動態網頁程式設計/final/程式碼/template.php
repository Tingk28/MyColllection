<?php
    session_start();
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
            <h1 style="text-align: center;">歡迎<?php echo $_SESSION['student_id']; ?></h1>
            <div class="alert alert-success">
                <strong>Success!</strong> Indicates a successful or positive action.
            </div>
        </div>
        <?php
            $conn = get_db();
            $sql = "SELECT student_ID FROM users WHERE auth_code = :auth_code";
            
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':auth_code', $_COOKIE["auth_code"]);
            $stmt->execute();

            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $conn = null;
            if(count($result)==0){
                echo "<script>setTimeout(() => {location.href=\"login.php\"}, \"500\");</script>";
                die;
            }
        ?>

    </body>
</html>    