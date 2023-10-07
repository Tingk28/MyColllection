<?php
    // few function that will be used repeatedly
    function redirect($address="login.php"){
        $conn = get_db();
        $sql = "SELECT student_ID FROM users WHERE auth_code = :auth_code";
        
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':auth_code', $_COOKIE["auth_code"]);
        $stmt->execute();

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $conn = null;
        if(count($result)==0){
            echo "<script>setTimeout(() => {location.href=\"".$address."\"}, \"500\");</script>";
            die;
        }
        else{
            $_SESSION["student_id"] = $result[0]["student_ID"];
        }
    }
    function generateJSON($array) {
        $result = array();
        
        foreach ($array as $item) {
            $chapter = $item['chapter'];
            $lo = $item['LO'];
            
            if (!isset($result[$chapter])) {
                $result[$chapter] = array();
            }
            
            $result[$chapter][] = $lo;
        }
        
        return json_encode($result);
    }
    
?>