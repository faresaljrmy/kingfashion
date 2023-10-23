<?php

include "../../connect.php";

$email    = filterRequest("email");
$password =sha1($_POST["password"]);

$data = array("delivery_password" => $password);

updateData("delivary" , $data , "delivery_email = '$email'");
?>