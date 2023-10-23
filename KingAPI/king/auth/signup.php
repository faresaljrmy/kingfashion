<?php
include "../connect.php";
$name   = filterRequest("name");
$email      = filterRequest("email");
$shop      = filterRequest("shop");
$address      = filterRequest("address");
$phone      = filterRequest("phone");
$password =sha1($_POST["password"]);
// $type = filterRequest("type");
$verifycode = rand(10000,99999);


$stm = $con->prepare("SELECT * FROM users WHERE email = ? OR phone = ?");

$stm->execute(array($email,$phone));
$count = $stm->rowCount();
if($count >0 ){
    printFailure("PHONE OR EMAIL FUNDE");
}else{
    $data = array(
        "name"       => $name,
        "email"      => $email,
        "shop"      => $shop,
        "address"      => $address,
        "phone"      => $phone,
        "password"   => $password,
        // "type"      => $type,
        "verifycode" => $verifycode,
    );
    
    // sendEmail($email ,"verifycode" , "Verifycode is $verifycode ");
    insertData("users" , $data);
}