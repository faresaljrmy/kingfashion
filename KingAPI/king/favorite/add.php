
<?php

include '../connect.php';

$userid = filterRequest("userid");
$itemid = filterRequest("itemid");
 $data = array(
    "usr_id" => $userid ,
    "itm_id" => $itemid

 );

 insertData("favorite",$data);