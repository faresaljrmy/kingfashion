<?php

include "../../connect.php";


$email      = filterRequest("email");
$verifycode = filterRequest("verifycode");


$stm = $con->prepare("SELECT * FROM delivary WHERE delivery_email = '$email' AND delivery_verifycode = '$verifycode'");

$stm->execute();

$count = $stm->rowCount();

result($count);
?>