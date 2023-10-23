<?php
include "../connect.php";

$email      = filterRequest("email");
$verifycode = rand(10000,99999);

$data = array(
"verifycode" => $verifycode,
);

updateData("users",$data, "email = '$email' " ,);

 // sendEmail($email ,"verifycode" , "Verifycode is $verifycode ");
 printSuccess();