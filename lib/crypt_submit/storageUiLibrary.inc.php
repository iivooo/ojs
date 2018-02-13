<?php
/**
 * Created by PhpStorm.
 * User: IIvoo
 * Date: 05.02.2018
 * Time: 22:23
 */

import('lib.crypt_submit.cryptSubmitLibrary');


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
        } else if ($json_result->article->_id == $submission->getSHA256()){
//                    TODO: revisions upload? we have origin sha256 and can compare... to addRevisions...
        }




    }

    function uploadAdditionalDataToStorageUI ($article, $suppFile, $filePath, $usr, $pwd)
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
        } else if ($json_result->article->_id == $article->getSHA256()){
//                    TODO: revisions upload? we have origin sha256 and can compare... to addRevisions...
        }




    }


    function postUpload($filePath, $postAddress, $postFields)
    {
        $postFields['file_contents'] = curl_file_create($filePath);


        $postFields['file_contents'] = curl_file_create($filePath);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'http://192.52.3.143:3000/api/' . $postAddress);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postFields);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_ENCODING, "");
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: multipart/form-data; charset=UTF-8'
        ));

        $result = curl_exec($ch);
//        var_dump(curl_error($ch));

        curl_close($ch);
        return $result;

    }
//    file_contents, title, abstract, tags, authors, usr, pwd
}