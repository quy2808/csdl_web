<?php
require_once('connection.php');
class Billsend
{
    
    static function getAll()
    {
        $db = DB::getInstance();
        $req = $db->query("CALL Getbienban_gui()");
        mysqli_next_result($db);
        return $req;
    }

    static function getSearchyear($year) {
        $db = DB::getInstance();
        $req = $db->query("CALL Bienbantrongnam('$year')");
        mysqli_next_result($db);
        return $req;
    }

    static function getRevenue($year) {
        $db = DB::getInstance();
        $req = $db->query("CALL Doanhthu1nam('$year')");
        return $req->fetch_assoc()['DoanhThu'];
    }



}
?>