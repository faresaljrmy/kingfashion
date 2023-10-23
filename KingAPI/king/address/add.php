<?php

include '../connect.php';

$name    = filterRequest("name");
$city    = filterRequest("city");
$street  = filterRequest("street");
$lat     = filterRequest("lat");
$lang    = filterRequest("lang");
$userid = filterRequest("userid");

$data = array(
  "name"    => $name,
  "city"    => $city,
  "street"  => $street,
  "lat"     => $lat,
  "lang"    => $lang,
  "userid" => $userid
); 

insertData("address",$data);

