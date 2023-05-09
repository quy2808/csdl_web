<?php
require_once('connection.php');
class Admin
{
    
    static function validation($username, $password)
    {
        $db = DB::getInstance();
        $req = $db->query("SELECT * FROM admin WHERE username = '$username'");
        if($result = $req -> fetch_assoc()) {
            if ($password == $result['password'])
                return true;
            else
                return false;
        }
        else {
            return false;
        }
    }

    
}
?>