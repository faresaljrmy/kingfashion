<?php

include '../../connect.php';

$id        = filterRequest("deliveryid");
// $imagename = filterRequest("imagename");

// deleteFile("../../upload/items",$imagename);

deleteData("delivary","delivery_id = $id");