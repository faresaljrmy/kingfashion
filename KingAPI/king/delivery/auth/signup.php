<?php
include "../../connect.php";
$username   = filterRequest("deliveryname");
$password =sha1($_POST["password"]);
$email      = filterRequest("email");
$phone      = filterRequest("phone");
$verifycode = rand(10000,99999);


$stm = $con->prepare("SELECT * FROM delivary WHERE delivery_email = ? OR delivery_phone = ?");

$stm->execute(array($email,$phone));
$count = $stm->rowCount();
if($count >0 ){
    printFailure("PHONE OR EMAIL FUNDE");
}else{
    $data = array(
        "delivery_name"       => $username,
        "delivery_password"   => $password,
        "delivery_email"      => $email,
        "delivery_phone"      => $phone,
        "delivery_verifycode" => $verifycode,
    );
    
    // sendEmail($email ,"verifycode" , "Verifycode is $verifycode ");
    insertData("delivary" , $data);
}