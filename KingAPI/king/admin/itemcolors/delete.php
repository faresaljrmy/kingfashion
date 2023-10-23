<?php

include '../../connect.php';

$id        = filterRequest("id");
$userid = filterRequest("userid");

deleteData("itemcolors","id = $id");