<?php

include '../../connect.php';

$id = filterRequest("id");
$name = filterRequest("name");
$namear = filterRequest("namear");
$symbol = filterRequest("symbol");
$userid = filterRequest("userid");


    $data = array(
        "name" => $name,
        "name_ar" => $namear,
        "symbol" => $symbol
        
        );



updateData("sizes", $data, "id = $id");