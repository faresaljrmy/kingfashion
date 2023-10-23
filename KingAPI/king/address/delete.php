<?php
include '../connect.php';

$id = filterRequest("id");

deleteData("address", "id = $id");