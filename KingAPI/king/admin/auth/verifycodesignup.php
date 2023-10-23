<?php

include "../../connect.php";


$email      = filterRequest("email");
$verifycode = filterRequest("verifycode");


$stm = $con->prepare("SELECT * FROM users WHERE email = '$email' AND verifycode = '$verifycode' ");

$stm->execute();

$count = $stm->rowCount();


if($count >0){
$data = array("type" => "2");

updateData("users" , $data , "email = '$email' ");
}else{
    printFailure("verifycode  is not Correct $count");
}
