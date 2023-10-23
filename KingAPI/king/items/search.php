<?php

include '../connect.php'; 

$search = filterRequest("search");

getAllData("itmesview" , "name_ar LIKE '%$search%' OR name LIKE '%$search%'");
