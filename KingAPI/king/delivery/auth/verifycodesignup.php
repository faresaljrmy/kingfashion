<?php

include "../../connect.php";


$email      = filterRequest("email");
$verifycode = filterRequest("verifycode");


$stm = $con->prepare("SELECT * FROM delivary WHERE delivery_email = '$email' AND delivery_verifycode = '$verifycode' ");

$stm->execute();

$count = $stm->rowCount();


if($count >0){
$data = array("delivery_approve" => "1");

updateData("delivary" , $data , "delivery_email = '$email' ");
}else{
    printFailure("verifycode  is not Correct $count");
}
