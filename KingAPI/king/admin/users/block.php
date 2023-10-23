<?php

include "../../connect.php";

$deliveryid    = filterRequest("userid");
// $password =sha1($_POST["password"]);

$data = array("users_approve" => "0");

updateData("users" , $data , "users_id = '$deliveryid'");
?>