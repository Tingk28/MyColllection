第一次使用時執行
```
git clone https://github.com/Tingk28/DWP_final.git
```
執行下列兩行一併下載子模組
```
git submodule init
git submodule update
```

connect to sql
```
gcloud sql connect audit-multiple-choice --user=admin
```

若要連接到gcloud SQL
透過公開IP連接
```
    $servername = "35.236.171.191"; // change to localhost for locally
    $username = "root";
    $password = "Euq]O5FuORbJml0v";
    $dbname = "audit-multiple-choice";
    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT var_code FROM `users` WHERE email = :email";
        echo $sql . "<br>";

        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':email', $_SESSION["email"]);
        $stmt->execute();

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo var_dump($result);

        if ($stmt->rowCount() > 0) {
            //檢查該email 是否存在過
            $row = $result[0];
            $varCode = $row['var_code'];
            echo "<br>var_code: " . $varCode;
        }
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
    }

    $conn = null;
```

the template for log
```
CREATE TABLE `audit-multiple-choice`.`log_table` (`log_id` INT NOT NULL AUTO_INCREMENT , `name` TEXT NOT NULL , `time` DATETIME NOT NULL , `content` INT NOT NULL , `total` INT NOT NULL , `correct` INT NOT NULL , `wrong` INT NOT NULL , PRIMARY KEY (`log_id`)) ENGINE = InnoDB;
```
the template for log-question
```
CREATE TABLE `audit-multiple-choice`.`user_table` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `QID` INT NOT NULL,
  `sequence` TEXT NULL,
  `ans` TEXT NOT NULL,
  `user_ans` TEXT NULL,
  `chapter` TEXT NULL,
  `LO` TEXT NULL,
  `log_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  FOREIGN KEY (`question_id`) REFERENCES `question_table` (`id`)
) ENGINE = InnoDB;
```
Join
```
UPDATE `user_table` AS ut
JOIN `question_table` AS qt ON ut.question_id = qt.id
SET ut.ans = qt.answer;
```

make a sql query
```
$conn = get_db();
$sql = "SELECT sequence,ans,user_ans FROM $question_table_name where log_ID = :log_id";
$stmt = $conn->prepare($sql);
$stmt->bindParam(':log_id', $_POST['log_id']);
$stmt->execute();
```
