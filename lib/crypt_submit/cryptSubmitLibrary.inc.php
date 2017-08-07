<?php

/**
 * @file lib/crypt_submit/cryptSubmitLibrary.inc.php
 * Created by PhpStorm.
 * User: IIvoo
 * Date: 07.06.2017
 * Time: 16:06
 *
 */

/**
 * Imports
 */
import('classes.article.ArticleDAO');
import('classes.file.ArticleFileManager');

class cryptSubmitLibrary
{

    /**
     * functions to interact with OJS database.
     */


    /**
     * @return mysqli
     */
    function getDatabase(){
        $host = "localhost";
        $user = "iivooo";
        $password = "AeC4deVoop4eiRohb9a";
        $database = "iivooo";

        $db = mysqli_connect($host, $user, $password, $database);
        if(!$db)
        {
            print "<script>alert('Database connection failed. Please contact the admin.')</script>";
            exit("Verbindungsfehler: ".mysqli_connect_error());

        } else {
            return $db;
        }
    }

    /**
     * @param $db
     */
    function closeDatabase($db){
        mysqli_close($db);
    }

    /**Returns a standard mysqli result set
     * @param $db
     * @param $sql
     * @return bool|mysqli_result|null
     */
    function sqlQueryRetrieve($db, $sql){
        $result = null;
        if(!($result = mysqli_query($db, $sql))){
            print "<script>alert('DB query failed. Please contact the admin.')</script>";
            var_dump($db->error);
            return $db->error;
        } else {
            return $result;
        }
    }

    /**2d array-representation from mysqli result set
     * @param $db
     * @param $sql
     * @return array
     */
    function getNumericArrayFromSQL($db, $sql){
        $result = $this->sqlQueryRetrieve($db, $sql);
        $result_arr = array();
        while($row = mysqli_fetch_assoc($result)){
            $result_arr[] = $row;
        }
        return $result_arr;
    }

    /**Function for updating and inserting in sql
     * @param $sql
     * @param $db
     */
    function sqlQuery($db, $sql){
        if(!($result = mysqli_query($db, $sql))) {
            var_dump($result." query: ".$sql);
            var_dump($db->error);
            print "<script>alert('DB query failed. Please contact the admin.')</script>";
        }
    }

    /**Function to get the Log in log... user, ip, timestamp etc.
     * @return array
     */
    function fetchLogInLog(){
        $this->updateLogInLog();
        $sql = "SELECT * FROM login_log ORDER BY timestamp DESC";
        $result = $this->sqlQueryRetrieve($this->getDatabase(),$sql);
        $this->closeDatabase();
        $result_arr = array();
        while($row = mysqli_fetch_assoc($result)){
            $row['timestamp'] = gmdate("d M Y H:i:s \(\G\M\T\)", $row['timestamp']);
            $result_arr[] = $row;
        }
        // result_arr[0]->first_name etc..
        return $result_arr;
    }

    function fetchDownloadLog(){
        $this->updateDownloadLog();
        $sql = "SELECT * FROM download_log ORDER BY download_timestamp DESC";
        $result = $this->sqlQueryRetrieve($this->getDatabase(), $sql);
        $this->closeDatabase();
        $result_arr = array();
        while($row = mysqli_fetch_assoc($result)){
            $row['download_timestamp'] = gmdate("d M Y H:i:s \(\G\M\T\)", $row['download_timestamp']);
            $result_arr[] = $row;
        }
        return $result_arr;
    }


    /**
     * Functions for interaction with originstamp.org
     */

    /**
     * @param $hash
     * @return originstamp result json
     */
    function submitRetrieveOriginstamp($hash){
        $url = "https://api.originstamp.org/api/".$hash;
        $apiKey = "988e7238-995e-4db0-8277-ce8f75d4b037";

        $ch = curl_init( $url );
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-type: application/json',
            'charset: utf-8',
            'Authorization: '.$apiKey
        ));
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1); //option to not print and get response.
        $response = curl_exec( $ch );
        curl_close ($ch);
        return $response;
    }


    /**Function for downloading the originstamp verifier
     * fetches seedfile path, a timestamp .txt file can be provided for offline verification
     * @param $filePath: file which is timestamped
     * @param null $timestampPath: path where the timestamp lies
     * @return bool
     */

    function downloadArticleOriginstampZipFile($articleId, $filePath) {

        $seedPath = $this->getSeedFile($filePath);
        $timestampPath = $this->getArticleTimeStampPath($articleId, $filePath);

        if($seedPath  == false){
            print "<script>alert('currently no seedfile available')</script>";
            return false;
        }

        if($timestampPath!=null){
            array_push($paths, $timestampPath);
        }

        $paths = array(
            $filePath,
            $seedPath,
            $timestampPath
        );

        $zipDestination = $this->add_to_zip($paths, dirname($filePath).'/'.pathinfo($filePath,PATHINFO_FILENAME).'_originstampVerifier.zip');
        if(!($zipDestination)){
            //TODO error handling
        } else if(file_exists($zipDestination)) {
            $this->userDownload($zipDestination);
        } else {
            print "<script>alert('Error: article file doesnt exists')</script>";
        }
    }

    /**Function to provide a file download
     * @param $filePath
     * @param string $contentType:
     */

    function userDownload($filePath, $contentType = "application/zip"){
        $quoted = sprintf('"%s"', addcslashes(basename($filePath), '"\\'));
        $size   = filesize($filePath);
        ob_clean();
        header('Content-Description: File Transfer');
        header('Content-Type: '.$contentType); //octet-stream
        header('Content-Disposition: attachment; filename=' . $quoted);
        header('Content-Transfer-Encoding: binary');
        header('Connection: Keep-Alive');
        header('Expires: 0');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Pragma: public');
        header('Content-Length:' . $size);
        ob_clean();
        flush();
        readfile($filePath);

    }

    /**Function for fetching the timestamp for an article.
     * @param $id: articleID
     * @param $filePath: where to save?
     * @return bool|string
     */
    function getArticleTimeStampPath($id, $filePath){
        $db = $this->getDatabase();

        $query = "SELECT origin_timestamp FROM articles WHERE article_id =".$id;
        $timestamp =mysqli_query($db, $query);

        if($timestamp){
            $res = $timestamp->fetch_row();
            $resultPath= dirname($filePath)."/timestamp.js";
            $fp = fopen($resultPath,"wb");
            fwrite($fp,"var timestamp = ".$res[0]);
            fclose($fp);
            if(!file_exists($resultPath)){
                var_dump(var_dump(mysqli_error($db)));
                return false;
            } else {
                return $resultPath;
            }

        }

        $this->closeDatabase($db);

    }

    /**Function for fetching the seedfile from originstamp for a file
     * @param $filePath
     * @return bool|string
     */

    function getSeedFile($filePath, $destination = false){
        $fileHash=hash_file("sha256",$filePath, FALSE);
        $url = "https://api.originstamp.org/api/download/seed/".$fileHash;
        $apiKey = "988e7238-995e-4db0-8277-ce8f75d4b037";

        $ch = curl_init( $url );
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-type: application/json',
            'charset: utf-8',
            'Authorization: '.$apiKey
        ));
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

        $response = curl_exec( $ch );
        curl_close ($ch);
        if(strpos($response, $fileHash) === FALSE){
            return false;
        }
        if(!$destination) $destination = dirname($filePath)."/seedfile.txt";
        $fp = fopen($destination,"w");
        fwrite($fp,$response);
        fclose($fp);
        if(!file_exists($destination)){return false;}
        return $destination;
    }

    /**function for packing the originstamp.org zip file
     * offline-verifier is already included
     * @param array $files
     * @param string $destination
     * @return bool|string
     */
    function add_to_zip($files = array(), $destination = '') {
        if($destination == ""){

            return false;
        }
        //vars
        $valid_files = array();
        //if files were passed in...
        if(is_array($files)) {
            //cycle through each file
            foreach($files as $file) {
                //make sure the file exists
                if(file_exists($file)) {
                    $valid_files[] = $file;
                } else {
                    var_dump("file not existing: "+$file);
                }
            }
        }
        //if we have good files...
        if(count($valid_files)) {
            //create the archive
            if(file_exists($destination)){
                unlink($destination);
            }
            $zip = new ZipArchive();
            if($err = $zip->open($destination, ZIPARCHIVE::CREATE) !== TRUE) {
                var_dump("err: ".$err);
                return false;
            }


            //add manual verifier
            $rootPath = $_SERVER['DOCUMENT_ROOT']."/ojs/originstampVerifier/";
            $files = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($rootPath),
                RecursiveIteratorIterator::LEAVES_ONLY
            );

            foreach ($files as $name => $file) {
                // Skip directories (they would be added automatically)
                if (!$file->isDir()) {
                    // Get real and relative path for current file
                    $filePath = $file->getRealPath();
                    $relativePath = substr($filePath, strlen($rootPath) );

                    // Add current file to archive
                    $zip->addFile($filePath, $relativePath);
                }
            }
            //add the submission and seedfile. workaround..
            foreach($valid_files as $file) {
                $content = file_get_contents($file);
                $zip->addFromString(pathinfo($file, PATHINFO_BASENAME), $content);
            }
            $zip->close();

            return $destination;
        } else {
            return false;
        }
    }

    function timestampLogIn($session){
        $db = $this->getDatabase();

        $user = $session->getUser();
        $ipAddress = $session->getIpAddress();
        $timestamp = time();

        $userQuery = "SELECT username, first_name, middle_name, last_name, phone, billing_address, country
						FROM users WHERE user_id = '{$user->getUserId()}';";
        $userQueryResult = $this->sqlQueryRetrieve($db, $userQuery);

        $userQueryArray = mysqli_fetch_assoc($userQueryResult);

        //timestampstring : userid,ipaddress,timestamp,username,first_name,middle_name,last_name,phone,billing_address,country
        $timestampString = "{$user->getUserId()},{$ipAddress},{$timestamp},{$user->getUsername()},{$user->getFirstName()},
		{$user->getMiddleName()},{$user->getLastName()},{$user->getPhone()},
		{$user->getBillingAddress()},{$user->getCountry()}";

        //timestamp the string
        $hashTimestampString = hash(sha256,$timestampString);

        $query = 	"INSERT INTO login_log (user_id, ip, timestamp, username, first_name, middle_name, last_name, phone,
 					billing_address, country, originstamp_status,origin_sha256)
					VALUES ({$user->getUserId()},'{$ipAddress}',{$timestamp},'{$user->getUsername()}','{$user->getFirstName()}',
		'{$user->getMiddleName()}','{$user->getLastName()}','{$user->getPhone()}',
		'{$user->getBillingAddress()}','{$user->getCountry()}', 0, '{$hashTimestampString}')";
        $this->sqlQuery($db,$query);

        $this->submitRetrieveOriginstamp($hashTimestampString);
    }

    /**
     * Function to timestamp downloads
     * currently implemented in classes.sectionEditor.SubmissionEditHandler.inc.php -> downloadFile for sectionEditor download
     * @param $cryptArgs
     * @param $articleId
     * @param $fileId
     * @param $revision
     */
    function timestampDownload($cryptArgs, $articleId,$fileId,$revision){
        //file details
        $article_hash = hash('sha256',$cryptArgs[articleContent]);
        $timestamp = time();

        //timestamp the string with originstamp.org
        $tmp = "{$cryptArgs[userData][id]},{$cryptArgs[userIp]},{$cryptArgs[userData][username]},".
            "{$cryptArgs[userData][firstName]},{$cryptArgs[userData][middleName]},{$cryptArgs[userData][lastName]},".
            "{$cryptArgs[userData][phone]},,{$cryptArgs[userData][country]},{$articleId},{$fileId},{$revision},".
            "{$article_hash},{$timestamp}";

        $tmpHash = hash('sha256', $tmp);

        $query = "INSERT INTO download_log (user_id, ip, username, first_name, middle_name, last_name, phone, 
                  billing_address, country, article_id, file_id, revision, article_hash, download_timestamp, 
                  originstamp_status, origin_timestamp,origin_sha256)
                  VALUES ({$cryptArgs[userData][id]}, '{$cryptArgs[userIp]}', '{$cryptArgs[userData][username]}', '{$cryptArgs[userData][firstName]}',
                  '{$cryptArgs[userData][middleName]}', '{$cryptArgs[userData][lastName]}', '{$cryptArgs[userData][phone]}',
                  '', '{$cryptArgs[userData][country]}', {$articleId}, {$fileId}, {$revision}, '{$article_hash}', {$timestamp}, 0, 0, '{$tmpHash}'  );";

        $db = $this->getDatabase();
        $this->sqlQuery($db,$query);
        $this->closeDatabase($db);
        $this->submitRetrieveOriginstamp($tmpHash);

    }

    function timestampComment($comment){

        $user_id = $comment->getAuthorId();
        $userDAO = new UserDAO($user_id);
        $user = $userDAO->getUser($user_id);

        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
        } else {
            $ip = $_SERVER['REMOTE_ADDR'];
        }

//        //user details
        $username = $user->getUsername();
        $first_name = $user->getFirstName();
        $middle_name = $user->getMiddleName();
        $last_name = $user->getLastName();
        $phone = $user->getPhone();
        $billing_address = $user->getBillingAddress();
        $country = $user->getCountry();
//
//        //article details
        $articleId = $comment->getArticleId();
//
//        //comment
        $original_comments = $comment->getComments();
        $comment_title = $comment->getCommentTitle();
        $comment_id = $comment->getCommentId();
        $comment_timestamp = time();

        //timestamp the string with originstamp.org
        $tmp = "{$user_id},{$ip},{$username},{$first_name},{$middle_name},{$last_name},{$phone},".
        "{$billing_address},{$country},{$articleId},{$original_comments},{$comment_title},{$comment_id},".
        "{$comment_timestamp}";

        $tmpHash = hash('sha256', $tmp);

        $query = "INSERT INTO article_comments_timestamping_cryptSubmit (user_id, ip, username, first_name, middle_name, last_name, phone,
                  billing_address, country, article_id, original_comments, comment_title, comment_id, comment_timestamp, origin_sha256)
                  VALUES ({$user_id}, '{$ip}', '{$username}', '{$first_name}', '{$middle_name}', '{$last_name}',
                  '{$phone}','{$billing_address}', '{$country}', {$articleId}, '{$original_comments}', '{$comment_title}',
             '{$comment_id}', {$comment_timestamp}, '{$tmpHash}');";

        $db = $this->getDatabase();
        $this->sqlQuery($db,$query);
        $this->closeDatabase($db);
         $this->submitRetrieveOriginstamp($tmpHash);
    }

    /**
     * Function to add additional data to display comments with cryptSubmitInfo:
     * sha256 of the string, timestamp status, timestamp time
     * @param $articleComments
     * @return updated $articleComments
     *
     */

    function addArticleCommentData($articleComments){
        $db = $this->getDatabase();
        $this->updateArticleCommentLog();
        foreach ($articleComments as &$comment){
            $sql = "SELECT * FROM article_comments_timestamping_cryptSubmit  WHERE comment_id = {$comment->getCommentId()}";
            $res = null;
            $res = $this->getNumericArrayFromSQL($db, $sql);
                $comment->setSHA256($res[0][origin_sha256]);
                $comment->setOriginstampStatus($res[0][originstamp_status]);
                $comment->setOriginTimestamp($res[0][origin_timestamp]);
        }
        //TODO: after updater is written: adjust template

        $this->closeDatabase($db);

        return $articleComments;

    }


    /**
     * originstamp updaters
     */

    function updateLogInLog(){
        $db = $this->getDatabase();

        //fetch additional user info to create logInInfoHash for originstamp.org
        $userQuery = "SELECT *
						FROM login_log WHERE NOT originstamp_status = 3";
        $userQueryResult = $this->sqlQueryRetrieve($db, $userQuery);

        $row = null;
        while($row = $userQueryResult->fetch_assoc()){
            if($row['origin_sha256'] == null){continue;}
            $origRes = json_decode($this->submitRetrieveOriginstamp($row['origin_sha256']));
            $query = "UPDATE `login_log` SET `originstamp_status` = '{$origRes->multi_seed->submit_status}' , `origin_timestamp` = '{$origRes->multi_seed->timestamp}' WHERE origin_sha256 = '{$row['origin_sha256']}';";
            $this->sqlQuery($db,$query);
        }
        $this->closeDatabase($db);

    }

    function updateDownloadLog(){
        $db = $this->getDatabase();
        $userQuery ="SELECT * FROM download_log WHERE NOT originstamp_status = 3";
        $userQueryResult = $this->sqlQueryRetrieve($db, $userQuery);

        $row = null;
        while($row = $userQueryResult->fetch_assoc()){
            if($row['origin_sha256'] == null){continue;}
            $originRes = json_decode($this->submitRetrieveOriginstamp($row['origin_sha256']));
            $query = "UPDATE download_log SET originstamp_status = '{$originRes->multi_seed->submit_status}', origin_timestamp = '{$originRes->multi_seed->timestamp}' WHERE origin_sha256 = '{$row['origin_sha256']}';";
            $this->sqlQuery($db, $query);
        }
        $this->closeDatabase($db);

    }

    function updateArticleCommentLog(){
        $db = $this->getDatabase();

        $userQuery = "SELECT * FROM article_comments_timestamping_cryptSubmit  WHERE (originstamp_status IS NULL) OR (originstamp_status != 3);";
        $userQueryResult = $this->sqlQueryRetrieve($db, $userQuery);
        $row = null;
        while($row = $userQueryResult->fetch_assoc()){
            if($row['origin_sha256'] == null){continue;}
            $origRes = json_decode($this->submitRetrieveOriginstamp($row['origin_sha256']));
            $submit_status = $origRes->multi_seed->submit_status;
            if($submit_status == null) $submit_status = 1;
            $timestamp = $origRes->multi_seed->timestamp;
            $query = "UPDATE article_comments_timestamping_cryptSubmit SET originstamp_status = {$submit_status}, origin_timestamp = '{$timestamp}' WHERE `ID` = '{$row['ID']}';";
            $this->sqlQuery($db,$query);
        }
        $this->closeDatabase($db);
    }

    function updateArticles(){
        //get database connection
        $db = $this->getDatabase();

        //fetch all article_ids with submissionstatus < 3
        $query = "SELECT article_id FROM articles WHERE (originstamp_status < 3) ";
        $ids = $this->sqlQueryRetrieve($db, $query);
        while ($id = $ids->fetch_row()) {
            //get filepath, hash file, get result from originstamp
            //case 1 means no main article available -> no timestamp
            if ($filepath = $this->searchFilePath($id[0]) == null) {
                $submit_status = 0;
                $hash = null;
                $timestamp = null;
            } else {
                //fetch json from originstamp
                $hash = hash_file("sha256", $this->searchFilePath($id[0]));
                $json_result = $this->submitRetrieveOriginstamp($hash);
                //get submissionstatus
                $submissionStatus = json_decode($json_result);
                $submit_status = $submissionStatus->multi_seed->submit_status;
                $timestamp = $submissionStatus->multi_seed->timestamp;
                if ($submit_status == null) {
                    $submit_status = 1;
                }
            }
            //update db
            $query = "UPDATE articles SET originstamp_status = ".$submit_status.", origin_sha256 ='".$hash."', origin_timestamp = '".$timestamp."' WHERE article_id =".$id[0];
            $this->sqlQuery($db, $query);
        }
        //close database connection
        $this->closeDatabase($db);
    }

    /**
     * Function to search for the file path of a given article. //TODO: deprecated: change to articleFileManager?
     * @param $id
     * @return int|mixed|null|string
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

    function downloadArticleCommentZip($articleId, $commentId){
        $sqlQuery="SELECT * FROM article_comments_timestamping_cryptSubmit WHERE comment_id = {$commentId}";
        $db = $this->getDatabase();
        $res = $this->getNumericArrayFromSQL($db,$sqlQuery);
        $tmp = "{$res[0][user_id]},{$res[0][ip]},{$res[0][username]},{$res[0][first_name]},{$res[0][middle_name]},{$res[0][last_name]},{$res[0][phone]},".
            "{$res[0][billing_address]},{$res[0][country]},{$res[0][article_id]},{$res[0][original_comments]},{$res[0][comment_title]},{$res[0][comment_id]},".
            "{$res[0][comment_timestamp]}";
        //write to txt file
        $basePath=$_SERVER['DOCUMENT_ROOT']."/files/DownloadableTxtFiles/";
        $this->checkUserDownloadDirectory();


        $wComment = fopen($basePath."articleComment_{$commentId}.txt", "w") or die("Unable to open file!");
        fwrite($wComment, $tmp);
        fclose($wComment);
        //write Timestamp
        $wComment = fopen($basePath."timestamp.js", "w") or die("Unable to open file!");
        fwrite($wComment, "var timestamp = ".$res[0][origin_timestamp]);
        fclose($wComment);
        $seedFilePath=$this->getSeedFile($basePath."articleComment_{$commentId}.txt");

        $zipPaths=array(
            $basePath."articleComment_{$commentId}.txt",
            $basePath."timestamp.js",
            $seedFilePath
        );
        $zipDestination=$basePath."articleCommentTimestamp_{$commentId}.zip";
        $this->userDownload($this->add_to_zip($zipPaths,$zipDestination));

    }

    function downloadLoginZip($loginId){
        $sqlQuery = "SELECT * FROM login_log WHERE `index` = {$loginId}";
        $db =$this->getDatabase();
        $res = $this->getNumericArrayFromSQL($db,$sqlQuery);

        $timestampString = "{$res[0][user_id]},{$res[0][ip]},{$res[0][timestamp]},{$res[0][username]},{$res[0][first_name]},
		{$res[0][middle_name]},{$res[0][last_name]},{$res[0][phone]},
		{$res[0][billing_address]},{$res[0][country]}";
        $basePath = $_SERVER['DOCUMENT_ROOT']."/files/DownloadableTxtFiles/";
        $filePath = $basePath."loginTimestamp_{$loginId}.txt";
        $timestampPath = $basePath."timestamp.js";
        $this->checkUserDownloadDirectory();

        $wComment = fopen($filePath, "w") or die("Unable to open file!");
        fwrite($wComment, $timestampString);
        fclose($wComment);
        //write Timestamp
        $wComment = fopen($timestampPath, "w") or die("Unable to open file!");
        fwrite($wComment, "var timestamp = ".$res[0][origin_timestamp]);
        fclose($wComment);
        $seedFileDestination = $basePath."loginTimestamp_{$loginId}_seedfile.txt";
        $seedFilePath=$this->getSeedFile($filePath, $seedFileDestination);

        $zipPaths=array(
            $filePath,
            $timestampPath,
            $seedFilePath
        );
        $zipDestination = $basePath."loginTimestamp_{$loginId}.zip";

        $this->userDownload($this->add_to_zip($zipPaths,$zipDestination));

        echo "<script>window.close();</script>";


    }

    function downloadDownloadLogZip($downloadId){
        $sqlQuery = "SELECT * FROM download_log WHERE `ID` = {$downloadId}";
        $db =$this->getDatabase();
        $res = $this->getNumericArrayFromSQL($db,$sqlQuery);

        $timestampString = "{$res[0][user_id]},{$res[0][ip]},{$res[0][username]},".
            "{$res[0][first_name]},{$res[0][middle_name]},{$res[0][last_name]},".
            "{$res[0][phone]},,{$res[0][country]},{$res[0][article_id]},{$res[0][file_id]},{$res[0][revision]},".
            "{$res[0][article_hash]},{$res[0][download_timestamp]}";

        $this->checkUserDownloadDirectory();
        $basePath = $_SERVER['DOCUMENT_ROOT']."/files/DownloadableTxtFiles/";
        $filePath = $basePath."downloadTimestamp_{$downloadId}.txt";
        $timestampPath = $basePath."timestamp.js";

        $wComment = fopen($filePath, "w") or die("Unable to open file!");
        fwrite($wComment, $timestampString);
        fclose($wComment);
        //write Timestamp
        $wComment = fopen($timestampPath, "w") or die("Unable to open file!");
        fwrite($wComment, "var timestamp = ".$res[0][origin_timestamp]);
        fclose($wComment);
        $seedFileDestination = $basePath."downloadTimestamp_{$downloadId}_seedfile.txt";
        $seedFilePath=$this->getSeedFile($filePath, $seedFileDestination);

        $zipPaths=array(
            $filePath,
            $timestampPath,
            $seedFilePath
        );
        $zipDestination = $basePath."downloadTimestamp_{$downloadId}.zip";

        $this->userDownload($this->add_to_zip($zipPaths,$zipDestination));

        echo "<script>window.close();</script>";
    }

    function checkUserDownloadDirectory(){
        $basePath=$_SERVER['DOCUMENT_ROOT']."/files/DownloadableTxtFiles/";
        if (!file_exists($basePath)) {
            mkdir($basePath, 0777, true);
        }
    }
}