<?php
include '../connect.php';

$id = filterRequest('id');

deleteData("favorite"," id = $id");