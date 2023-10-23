<?php

include "../connect.php";


$email      = filterRequest("email");
$verifycode = filterRequest("verifycode");


$stm = $con->prepare("SELECT * FROM users WHERE email = '$email' AND verifycode = '$verifycode'");

$stm->execute();

$count = $stm->rowCount();

result($count);
