
<?php
include "../../connect.php";

$email      = filterRequest("email");
$verifycode = rand(10000,99999);


$stm =$con->prepare("SELECT * FROM delivary WHERE delivery_email = ? ");

$stm->execute(array($email));
$count = $stm->rowCount();

result($count);
if($count > 0){
    $data = array("delivery_verifycode" => $verifycode );
    updateData("delivary" , $data , "delivery_email = '$email'" ,false);
    // sendEmail($email ,"verifycode" , "Verifycode is $verifycode ");

}