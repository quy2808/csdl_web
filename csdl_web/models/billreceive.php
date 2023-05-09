<?php
require_once('connection.php');
class Billreceive
{
    
    static function getAll()
    {
        $db = DB::getInstance();
        $req = $db->query("CALL Getbienban_nhan()");
        return $req;
    }

    static function getSearchtype($type) {
        $db = DB::getInstance();
        $req = $db->query("CALL bienban_nhanhang('$type')");
        mysqli_next_result($db);
        return $req;
    }

}
?>