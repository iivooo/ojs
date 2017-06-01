<?php
//require_once($_SERVER['DOCUMENT_ROOT'].'/classes/file/ArticleFileManager.inc.php');

// call with: https://iivooo.suhail.uberspace.de/ojs/originstampUpdaterTest.php?=fetchArticles

function checkHash($hash){
	$url = "https://api.originstamp.org/api/".$hash;
	$apiKey = "988e7238-995e-4db0-8277-ce8f75d4b037";
	
	$ch = curl_init( $url );
//	curl_setopt( $ch, CURLOPT_POST, 1);
//	curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
//	curl_setopt( $ch, CURLOPT_HEADER, 0);
//	curl_setopt($ch, CURLOPT_POSTFIELDS,$vars);  //Post Fields
	curl_setopt($ch, CURLOPT_HTTPHEADER, array(
			'Content-type: application/json',
			'charset: utf-8',
			'Authorization: '.$apiKey
	));
	curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1); //option to not print and get response.
	
	
	$response = curl_exec( $ch );
	
	curl_close ($ch);
	
//	print  $response ;
//	var_dump($response);
	return $response;
}


/**
 * fetches all articles with originstamp submission status < 3
 * get all the new submission status from originstamp
 * and writes them to the database.
 * this function is later triggered by a cronjob
 */
function fetchArticles() {
	//get database connection
	$db = mysqli_connect("localhost", "iivooo", "AeC4deVoop4eiRohb9a", "iivooo");
	if(!$db)
	{
	    var_dump('database connection failed.');
		exit("Verbindungsfehler: ".mysqli_connect_error());

	}
	
	//fetch all article_ids with submissionstatus < 3
	$query = "SELECT article_id FROM articles";//WHERE (originstampStatus <= 3) "; //TODO: correct later
	$ids = mysqli_query($db, $query);
	var_dump($ids);
	while ($id = $ids->fetch_row()) {
	    var_dump($id);
		//get filepath, hash file, get result from originstamp
		if($filepath=searchFilePath($id[0])==null){
			continue;
		}
//		$fileMan = new ArticleFileManager($id);

		var_dump(searchFilePath($id[0]));
		//fetch json from originstamp
        $hash=hash_file("sha256",searchFilePath($id[0]));
		$json_result = checkHash($hash, FALSE);
		//get submissionstatus
		$submissionStatus = json_decode($json_result);
		var_dump($submissionStatus);
		$res=$submissionStatus->multi_seed->submit_status;
		$timestamp=$submissionStatus->multi_seed->timestamp;
//		var_dump(gmdate("F j, Y, g:i a", $timestamp/1000));
		if($res == null){$res = 1;}
		//update db
		$query = "UPDATE articles SET originstampStatus = ".$res.", sha256 ='".$hash."', originTimestamp = '".$timestamp."' WHERE article_id =".$id[0];
		var_dump($query);
		mysqli_query($db, $query);
		var_dump("id: ".$id[0]." hash: ".$hash);
		var_dump(mysqli_error($db));

		//maybe supply a logfile later.
	}
	var_dump('exit');
	//close database connection
	mysqli_close($db);
	
	//return $result;
	
}
fetchArticles();


/**
 * Searches for article submission filepath for the corresponding id
 * @param integer $id 
 * @return string 
 */
function searchFilePath($id){
	$result=array();
	$path = '/var/www/virtual/iivooo/html/files/journals/';
	$objects = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($path));
	foreach($objects as $name => $object){	
		if(is_file($name) && preg_match("/^".$id."-.*SM\./",basename($name)) ){
			return $name;
		}
	}
	return null;
}




?>