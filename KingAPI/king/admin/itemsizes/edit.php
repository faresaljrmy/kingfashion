<?php

include '../../connect.php';

$id = filterRequest("id");
$itmclrid = filterRequest("itmclrid");
$sizeid = filterRequest("sizeid");
$qty = filterRequest("qty");
$price = filterRequest("price");
$descount = filterRequest("descount");
$userid = filterRequest("userid");


$data = array(
    "itm_clr_id" => $itmclrid,
    "size_id" => $sizeid,
    "qty" => $qty,
    "price" => $price,
    "descount" => $descount,    
    );



updateData("itemsizes", $data, "id = $id");