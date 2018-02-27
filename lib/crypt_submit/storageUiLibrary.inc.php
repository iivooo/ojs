<?php
/**
 * Created by PhpStorm.
 * User: IIvoo
 * Date: 05.02.2018
 * Time: 22:23
 */

import('lib.crypt_submit.cryptSubmitLibrary');
/**
 * @file classes/articleArticleFileDAO.inc.php
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class ArticleFileDAO
 * @ingroup article
 * @see ArticleFile
 *
 * @brief Operations for retrieving and modifying ArticleFile objects.
 */
import('classes.article.ArticleFileDAO');
import('pages.author.TrackSubmissionHandler');

class storageUiLibrary
{
    function uploadToStorageUI($articleId, $filePath, $submission, $usr, $pwd, $revision)
    {
//        extract submission stuff to upload
        $postFields = array(
            'file_contents' => $filePath,
            'title' => $submission->getLocalizedTitle(),
            'abstract' => $submission->getLocalizedAbstract(),
            'tags' => 'cryptSubmit', 'authors' => implode(", ", $submission->getAuthors()),
            'usr' => $usr,
            'pwd' => $pwd
        );

//        var_dump($revision);
        $json_result = $this->postUpload($filePath, 'uploadArticle', $postFields);
        print $json_result;
        $result = json_decode($json_result);

        /* $json_result = json_decode('{"article":{"_id":"480a3f7ae3e9155c9b5350d8731238f60300f241c62832a6f233849e7ea6d46d","title":"yolo","abstract":"scientific2","tags":"tag1, tag2","authors":"author1, author2","owner":"28d96ccd3a2c0ca2cd2d2c0989968182c7e79574640cb9c6b5be3e1f167b4dbf","filesets":[],"revisions":[],"ipfsAddress":"QmbvvyKyvEfRVcD49KyhG1STPUcTuB9PEFUUyzC8ugZxCg","metadata":{"originalName":"libEGL.dll","encoding":"7bit","mimetype":"application/x-msdownload","sha256":"480a3f7ae3e9155c9b5350d8731238f60300f241c62832a6f233849e7ea6d46d"}},"errors":false}');

         var_dump($json_result->article->title);*/


        if (!$result->errors) {
            $crypt = new cryptSubmitLibrary();
            $db = $crypt->getDatabase();

            //fetch additional user info to create logInInfoHash for originstamp.org
//            $query = "SELECT * FROM articles WHERE (article_id = $articleId) ";
//            $ids = $crypt->sqlQueryRetrieve($db, $query);
//            while ($id = $ids->fetch_row()) {
//                if ($id[25] != null) {
//                    $submit_status = 0;
//                    $hash = null;
//                    $timestamp = null;
            $query = "UPDATE articles SET ipfs_hash = '" . $result->article->ipfsAddress . "' WHERE article_id = " . $articleId;
            $crypt->sqlQuery($db, $query);
            $crypt->closeDatabase($db);
        } else if ($json_result->article->_id == $submission->getSHA256()) {
//                    TODO: revisions upload? we have origin sha256 and can compare... to addRevisions...
        }


    }






    function uploadAdditionalDataToStorageUI($article, $suppFile, $filePath, $usr, $pwd)
    {
//        extract submission stuff to upload
        $postFields = array(
            'file_contents' => $filePath,
            'title' => $suppFile->getSuppFileTitle(),
            'abstract' => $suppFile->getSuppFileDescription(),
            'tags' => 'cryptSubmit',
            'articleSha' => $article->getSHA256(),
            'authors' => implode(", ", $article->getAuthors()),
            'usr' => $usr,
            'pwd' => $pwd
        );
//        var_dump($postFields);

//        var_dump($revision);
        $json_result = $this->postUpload($filePath, 'uploadAdditionalData', $postFields);
        print $json_result;
        $result = json_decode($json_result);
//        var_dump($result->errors[0]->msg);


        if (!$result->errors) {
            $crypt = new cryptSubmitLibrary();
            $db = $crypt->getDatabase();

            $query = "UPDATE article_supplementary_files SET ipfs_hash = '" . $result->file->ipfsAddress . "' WHERE supp_id = " . $suppFile->getSuppFileId();
//            var_dump($query);
//            var_dump($json_result);
            $crypt->sqlQuery($db, $query);
            $crypt->closeDatabase($db);
        } else if ($json_result->article->_id == $article->getSHA256()) {
//                    TODO: revisions upload? we have origin sha256 and can compare... to addRevisions...
        }


    }

    function updateRevisions($articleId, $usr, $pwd)
    {
        //TODO: check if article is already uploaded. -> only shown when article is uploaded

        $articleFileDao =& DAORegistry::getDAO('ArticleFileDAO');
        $articleDao =& DAORegistry::getDAO('ArticleDAO');

        $crypt = new cryptSubmitLibrary();
        $sql = "SELECT * FROM article_files WHERE article_id = {$articleId} ORDER BY revision DESC";
        $dbresult = $crypt->sqlQueryRetrieve($crypt->getDatabase(), $sql);
        $crypt->closeDatabase();
        $article = $articleDao->getArticle($articleId);
//        var_dump($article);
        $checkres = true;
        while ($row = mysqli_fetch_assoc($dbresult)) {
            $articleFile = $articleFileDao->getArticleFile($row['file_id'], $row['revision'], $row['article_id']);
//            var_dump($articleFile);
//            var_dump($articleFile->getFilePath());
//            var_dump($row);
            if ($row['ipfs_hash'] == null) {
                $postFields = array(
                    'associated_article' => $article->getSHA256(),
                    'original_filename' => $articleFile->getOriginalFileName(),
                    'date' => $articleFile->getDateModified(),
                    'authors' => 'cryptSubmit',
                    'usr' => $usr,
                    'pwd' => $pwd
                );
//                var_dump($postFields);

                $json_result = $this->postUpload($articleFile->getFilePath(), 'uploadReviewFile', $postFields);
                $result = json_decode($json_result);
//                print $json_result;

                if (!$result->errors) {
                    $crypt = new cryptSubmitLibrary();
                    $db = $crypt->getDatabase();

                    $query = "UPDATE article_files SET ipfs_hash = '" . $result->revisedfile->ipfsAddress . "' WHERE article_id = " . $articleId . " AND revision = " . $row['revision'] . " AND file_id = " . $row['file_id'] . " ;";
                    $crypt->sqlQuery($db, $query);
                    $crypt->closeDatabase($db);
                } else {
                    $checkres = false;
                  return $json_result;
                    break;
                }
            }
        }
//        if($checkres) print '{errors:false}';
        $crypt->closeDatabase();
        return !$checkres;
    }

    function updateComments($articleId, $usr, $pwd)
    {
        $crypt = new cryptSubmitLibrary();
        $sql = "SELECT * FROM article_comments_timestamping_cryptSubmit WHERE article_id = ".$articleId;
        $db = $crypt->getDatabase();
        $dbresult = $crypt->sqlQueryRetrieve($db, $sql);

        $articleDao =& DAORegistry::getDAO('ArticleDAO');
        $article = $articleDao->getArticle($articleId);

//        var_dump($article->getSHA256());
//        var_dump($article->getIpfsHash());

        $checkres = true;
        if (($article->getSHA256() != null) && ($article->getIpfsHash() != null)) {
//            var_dump('invoked if');
            while ($row = mysqli_fetch_assoc($dbresult)) {
                //timestampstring per comment
//                var_dump($row);

                $timestampstring = "{$row[user_id]},{$row[ip]},{$row[username]},{$row[first_name]},{$row[middle_name]},{$row[last_name]},{$row[phone]}," .
                    "{$row[billing_address]},{$row[country]},{$row[article_id]},{$row[original_comments]},{$row[comment_title]},{$row[comment_id]}," .
                    "{$row[comment_timestamp]}";
                $timestampstringcontents = 'user_id,ip,username,first_name,middle_name,last_name,phone,billing_address,country,article_id,original_comments,comment_title.comment_id,comment_timestamp';

//                var_dump($timestampstring);
                if ($row['ipfs_hash'] == null) {
                    $postFields = array(
                        'title' => $row[comment_title],
                        'comment' => $row[original_comments],
                        'timestampString' => $timestampstring,
                        'timestampStringContents' => $timestampstringcontents,
                        'articleHash' => $article->getSHA256(),
                        'date' => $row[comment_timestamp],
                        'authors' => $row[username],
                        'from' => 'cryptSubmit',
                        'sha256' => $row['origin_sha256'],
                        'usr' => $usr,
                        'pwd' => $pwd
                    );

//                    var_dump($postFields);

                    $json_result = $this->postUpload(null, 'uploadComment', $postFields);
                    $result = json_decode($json_result);

//                    var_dump($result);

                    if (!$result->errors) {
                        $crypt = new cryptSubmitLibrary();
                        $db = $crypt->getDatabase();

                        $query = "UPDATE article_comments_timestamping_cryptSubmit SET ipfs_hash = '" . $result->comment->ipfsAddress . "' WHERE comment_id = ".$row['comment_id']." ;";
                        $crypt->sqlQuery($db, $query);
                        $crypt->closeDatabase($db);
                    } else {
                        $checkres = false;
//                        var_dump($json_result);
                        return $json_result;
                        break;
                    }
                }
            }
        }

//        if($checkres) print '{errors:false}';
        $crypt->closeDatabase();
        return !$checkres;

    }


    function postUpload($filePath, $postAddress, $postFields)
    {

        if ($filePath != null){
            $postFields['file_contents'] = curl_file_create($filePath);
            $header = 'Content-Type: multipart/form-data; charset=UTF-8';
        } else {
            $header = 'Content-Type: application/json';
            $postFields = json_encode($postFields);
        }
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'http://192.52.3.143:3000/api/' . $postAddress);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postFields);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_ENCODING, "");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            $header
        ));

        $result = curl_exec($ch);
//        var_dump(curl_error($ch));

        curl_close($ch);
        return $result;

    }
//    file_contents, title, abstract, tags, authors, usr, pwd
}