<?php 

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
	$query = "SELECT article_id FROM articles WHERE (originstampStatus < 3) ";
	$ids = mysqli_query($db, $query);
	var_dump($ids);
	while ($id = $ids->fetch_row()) {
	    var_dump($id);
		//get filepath, hash file, get result from originstamp
		if($filepath=searchFilePath($id[0])==null){
			continue;
		}
		echo "<p>".$filepath."</p>";
		//fetch json from originstamp
		$json_result = checkHash(hash_file("sha256",searchFilePath($id[0]), FALSE));
		//get submissionstatus
		$submissionStatus = json_decode($json_result);
		$res=$submissionStatus->multi_seed->submit_status;
		//update db
		$query = "UPDATE articles SET originstampStatus = ".$res." WHERE article_id =".$id[0];
		mysqli_query($db, $query);
		var_dump("else: ".$id[0]." fetched.");

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
		if(is_file($name) && preg_match("/.*".$id.".*SM\./",$name) ){
			return $name;
		}
	}
	return null;
}




?>