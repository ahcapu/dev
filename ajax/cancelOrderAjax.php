<?php

require_once('../../../config/config.inc.php');
require_once('../../../init.php');
require_once('../frank.php');
require_once('../api/FrankApi.php');

$frank_api = new FrankApi();

$cancelOrder = array(
    '_id' => $_POST['_id'],
    'cancellationReason' => 'Cancelled by admin',
    'status' => 'cancelledByStore'
);

$res = $frank_api->doCurlRequest('https://p-post.herokuapp.com/api/v1/orders/cancel', $cancelOrder, Configuration::get('FRANK_TOKEN'));
print_r($res);