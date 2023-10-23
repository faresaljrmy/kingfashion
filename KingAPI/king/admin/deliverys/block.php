<?php

include "../../connect.php";

$deliveryid    = filterRequest("deliveryid");
// $password =sha1($_POST["password"]);

$data = array("delivery_approve" => "0");

updateData("delivary" , $data , "delivery_id = '$deliveryid'");
?>