<?php
require_once('connection.php');
class User
{
    static function getAll()
    {
        $db = DB::getInstance();
        $req = $db->query(
            "SELECT *
            FROM nhanvien;"
        );
        return $req;
    }

    static function checkTaixe($CCCD) {
        $db = DB::getInstance();
        $req = $db->query(
            "SELECT * FROM taixe WHERE CCCD = '$CCCD'"
        );
        $result = 0;
        while($i = $req->fetch_assoc()) {
            $result +=1;
        }
        return $result;
    }

    static function checkLoxe($CCCD) {
        $db = DB::getInstance();
        $req = $db->query(
            "SELECT * FROM loxe WHERE CCCD = '$CCCD'"
        );
        $result = 0;
        while($i = $req->fetch_assoc()) {
            $result +=1;
        }
        return $result;
    }

    static function checkNvbienban($CCCD) {
        $db = DB::getInstance();
        $req = $db->query(
            "SELECT * FROM nvbienban WHERE CCCD = '$CCCD'"
        );
        $result = 0;
        while($i = $req->fetch_assoc()) {
            $result +=1;
        }
        return $result;
    }

    static function checkQuanly($CCCD) {
        $db = DB::getInstance();
        $req = $db->query(
            "SELECT * FROM quanli WHERE CCCD = '$CCCD'"
        );
        $result = 0;
        while($i = $req->fetch_assoc()) {
            $result +=1;
        }
        return $result;
    }

    static function insert($name, $age, $CCCD, $phone, $email, $salary, $job, $gender, $img_url) {
        $db = DB::getInstance();
        $CCCD = (string)$CCCD;
        $db->query("CALL InsertNhanVien('$CCCD', '$name', '$age', '$email', '$salary', '$gender', '$phone', '$img_url', '$job', @result)");
        $req = $db->query("SELECT @result");
        return $req->fetch_assoc()['@result'];
    }

    static function update($name, $age, $CCCD, $phone, $email, $salary, $job, $gender, $img_url) {
        $db = DB::getInstance();
        $CCCD = (string)$CCCD;
        $db->query("CALL UpdateNV('$CCCD', '$name', '$age', '$email', '$salary', '$gender', '$phone', '$img_url', '$job', @result)");
        $req = $db->query("SELECT @result");
        return $req->fetch_assoc()['@result'];
    }

    static function delete($CCCD)
    {
        $db = DB::getInstance();
        $CCCD = (string)$CCCD;
        $db->query("CALL DeletefromCCCD('$CCCD')");
    }

    static function getSearch($content) {
        $db = DB::getInstance();
        $req = $db->query("CALL searchNV('$content')");
        mysqli_next_result($db);
        return $req;
    }

    static function getOrderASC() {
        $db = DB::getInstance();
        $req = $db->query(
            "SELECT *
            FROM nhanvien ORDER BY mucluong ASC;"
        );
        return $req;
    }

    static function getOrderDESC() {
        $db = DB::getInstance();
        $req = $db->query(
            "SELECT *
            FROM nhanvien ORDER BY mucluong DESC;"
        );
        return $req;
    }

    static function updateImage($CCCD, $target_file) {
        $db = DB::getInstance();
        $req = $db->query("UPDATE nhanvien SET img_url = '$target_file' WHERE CCCD = '$CCCD';");
        return $req;
    }

}

?>