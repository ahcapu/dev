<?php

require_once ('../../config/config.inc.php');
require_once ('../../init.php');
require_once ('frank.php');
require_once ('api/FrankApi.php');


$frank_api = new FrankApi();

$id = $_POST['_id'];
$res = $frank_api->doCurlDeleteRequest('https://p-post.herokuapp.com/api/v1/stores/warehouse/' . $id, Configuration::get('FRANK_TOKEN'));
echo $res;
