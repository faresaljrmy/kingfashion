
<?php
include "../../connect.php";

$email      = filterRequest("email");
$verifycode = rand(10000,99999);


$stm =$con->prepare("SELECT * FROM users WHERE email = ?  and type=3");

$stm->execute(array($email));
$count = $stm->rowCount();

result($count);
if($count > 0){
    $data = array("verifycode" => $verifycode );
    updateData("users" , $data , "email = '$email'" ,false);
    // sendEmail($email ,"verifycode" , "Verifycode is $verifycode ");

}