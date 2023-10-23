<?php

include '../connect.php';

$id = filterRequest("id");
$name    = filterRequest("name");
$city    = filterRequest("city");
$street  = filterRequest("street");
$lat     = filterRequest("lat");
$lang    = filterRequest("lang");


$data = array(
  "name"    => $name,
  "city"    => $city,
  "street"  => $street,
  "lat"     => $lat,
  "lang"    => $lang,
  "id" => $id
); 

updateData("address",$data,"address_id = $id");
