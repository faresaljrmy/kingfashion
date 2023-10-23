<?php
include "../../connect.php";
$username   = filterRequest("name");
$password =sha1($_POST["password"]);
$email      = filterRequest("email");
$phone      = filterRequest("phone");
// $role      = filterRequest("role");
$verifycode = rand(10000,99999);


$stm = $con->prepare("SELECT * FROM users WHERE email = ? OR phone = ?");

$stm->execute(array($email,$phone));
$count = $stm->rowCount();
if($count >0 ){
    printFailure("PHONE OR EMAIL FUNDE");
}else{
    $data = array(
        "name"       => $username,
        "password"   => $password,
        ////// Type 0-> signup customer  1->  admin  2-> customer  3-> signup admin 4-> block
        "type"  => "3",
        // "role"       => $role,
        "email"      => $email,
        "phone"      => $phone,
        "verifycode" => $verifycode,
    );
    
    // sendEmail($email ,"verifycode" , "Verifycode is $verifycode ");
    insertData("users" , $data);
}