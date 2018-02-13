<?php
/* You might want some authentication here */
/* check authentication */
/* Authentication ended. */
foreach($_GET as $getname => $getvar) {
    $fields[$getname] = urlencode($getvar); //for proxying get request to POST.
}

foreach($_POST as $postname => $postvar) {
    $fields[$postname ] = urlencode($postvar); //for proxying POST requests.
}

$jsonresult = json_encode($fields);

//curl ssl not possible... why?
$ch = curl_init('http://192.52.3.143:3000/api/register');
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
curl_setopt($ch, CURLOPT_POSTFIELDS, $jsonresult);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, false);
curl_setopt($ch,CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    'Content-Type: application/json',
    'Access-Control-Allow-Origin: *',

));

$result = curl_exec($ch);

?>