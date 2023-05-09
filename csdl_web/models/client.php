<?php
require_once('connection.php');
class Client
{

    static function getAll()
    {
        $db = DB::getInstance();
        $req = $db->query("SELECT * FROM khachhang");
        return $req;
    }

    static function checkKhachgui($id) {
        $db = DB::getInstance();
        $req = $db->query("SELECT * FROM khachgui WHERE ID_khachgui = '$id';");
        $result = 0;
        while($i = $req->fetch_assoc()) {
            $result +=1;
        }
        return $result;
    }

    static function checkKhachnhan($id) {
        $db = DB::getInstance();
        $req = $db->query("SELECT * FROM khachnhan WHERE ID_khachnhan = '$id';");
        $result = 0;
        while($i = $req->fetch_assoc()) {
            $result +=1;
        }
        return $result;
    }

    static function insert($name, $age, $addr, $phone, $email, $gui, $nhan) {
        $db = DB::getInstance();
        $db->query("CALL InsertKhachHang('$name', '$age', '$addr', '$phone', '$email', $gui, $nhan, @result)");
        $req = $db->query("SELECT @result");
        return $req->fetch_assoc()['@result'];
    }

    static function update($name, $age, $addr, $phone, $email, $gui, $nhan, $id) {
        $db = DB::getInstance();
        $db->query("CALL UpdateKH($id,'$name', '$age', '$addr', '$phone', '$email', $gui, $nhan, @result)");
        $req = $db->query("SELECT @result");
        return $req->fetch_assoc()['@result'];
    }

    static function delete($ID) {
        $db = DB::getInstance();
        $db->query("DELETE FROM khachhang WHERE id = $ID");
    }

    static function getSearch($content) {
        $db = DB::getInstance();
        $req = $db->query("SELECT * FROM khachhang WHERE hoten LIKE '%$content%' OR namsinh LIKE '%$content%' OR
            email LIKE '%$content%' OR
            Diachi LIKE '%$content%' OR
            sdt LIKE '%$content%';     
        ");
        return $req;
    }

    
}