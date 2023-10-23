<?php
include "../../connect.php";

$email      = filterRequest("email");
$password =sha1($_POST["password"]);




// $stm =$con->prepare("SELECT * FROM users WHERE users_email = ?  AND users_password = ? AND users_approve = 1 ");

// $stm->execute(array($email ,$password));
// $count = $stm->rowCount();

// result($count);

getData("delivary" , "delivery_email = ?  AND delivery_password = ? " ,array($email,$password));