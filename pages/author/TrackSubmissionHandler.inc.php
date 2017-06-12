<?php

/**
 * @file pages/author/TrackSubmissionHandler.inc.php
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class TrackSubmissionHandler
 * @ingroup pages_author
 *
 * @brief Handle requests for submission tracking.
 */

import('pages.author.AuthorHandler');
import('classes.file.ArticleFileManager');

class TrackSubmissionHandler extends AuthorHandler {
	/** submission associated with the request **/
	var $submission;

	/**
	 * Constructor
	 **/
	function TrackSubmissionHandler() {
		parent::AuthorHandler();
	}

	/**
	 * Delete a submission.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function deleteSubmission($args, $request) {
		$articleId = (int) array_shift($args);
		$this->validate($request, $articleId);
		$authorSubmission =& $this->submission;
		$this->setupTemplate($request, true);

		// If the submission is incomplete, allow the author to delete it.
		if ($authorSubmission->getSubmissionProgress()!=0) {
			import('classes.file.ArticleFileManager');
			$articleFileManager = new ArticleFileManager($articleId);
			$articleFileManager->deleteArticleTree();

			$articleDao =& DAORegistry::getDAO('ArticleDAO');
			$articleDao->deleteArticleById($articleId);

			import('classes.search.ArticleSearchIndex');
			$articleSearchIndex = new ArticleSearchIndex();
			$articleSearchIndex->articleDeleted($articleId);
			$articleSearchIndex->articleChangesFinished();
		}

		$request->redirect(null, null, 'index');
	}

	/**
	 * Delete an author version file.
	 * @param $args array ($articleId, $fileId)
	 * @param $request PKPRequest
	 */
	function deleteArticleFile($args, $request) {
		$articleId = (int) array_shift($args);
		$fileId = (int) array_shift($args);
		$revisionId = (int) array_shift($args);

		$this->validate($request, $articleId);
		$authorSubmission =& $this->submission;

		if ($authorSubmission->getStatus() != STATUS_PUBLISHED && $authorSubmission->getStatus() != STATUS_ARCHIVED) {
			AuthorAction::deleteArticleFile($authorSubmission, $fileId, $revisionId);
		}

		$request->redirect(null, null, 'submissionReview', $articleId);
	}

	/**
	 * Display a summary of the status of an author's submission.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function submission($args, $request) {
		$journal =& $request->getJournal();
		$user =& $request->getUser();
		$articleId = (int) array_shift($args);

		$this->validate($request, $articleId);
		$submission =& $this->submission;
		$this->setupTemplate($request, true, $articleId);

		$journalSettingsDao =& DAORegistry::getDAO('JournalSettingsDAO');
		$journalSettings = $journalSettingsDao->getJournalSettings($journal->getId());

		// Setting the round.
		$round = (int) array_shift($args);
		if (!$round) $round = $submission->getCurrentRound();

		$templateMgr =& TemplateManager::getManager();

		$publishedArticleDao =& DAORegistry::getDAO('PublishedArticleDAO');
		$publishedArticle =& $publishedArticleDao->getPublishedArticleByArticleId($submission->getId());
		if ($publishedArticle) {
			$issueDao =& DAORegistry::getDAO('IssueDAO');
			$issue =& $issueDao->getIssueById($publishedArticle->getIssueId());
			$templateMgr->assign_by_ref('issue', $issue);
		}

		$sectionDao =& DAORegistry::getDAO('SectionDAO');
		$section =& $sectionDao->getSection($submission->getSectionId());
		$templateMgr->assign_by_ref('section', $section);

		$templateMgr->assign_by_ref('journalSettings', $journalSettings);
		$templateMgr->assign_by_ref('submission', $submission);
		$templateMgr->assign_by_ref('publishedArticle', $publishedArticle);
		$templateMgr->assign_by_ref('reviewAssignments', $submission->getReviewAssignments($round));
		$templateMgr->assign('round', $round);
		$templateMgr->assign_by_ref('submissionFile', $submission->getSubmissionFile());
		$templateMgr->assign_by_ref('revisedFile', $submission->getRevisedFile());
		$templateMgr->assign_by_ref('suppFiles', $submission->getSuppFiles());

		import('classes.submission.sectionEditor.SectionEditorSubmission');
		$templateMgr->assign_by_ref('editorDecisionOptions', SectionEditorSubmission::getEditorDecisionOptions());

		// Set up required Payment Related Information
		import('classes.payment.ojs.OJSPaymentManager');
		$paymentManager = new OJSPaymentManager($request);
		if ( $paymentManager->submissionEnabled() || $paymentManager->fastTrackEnabled() || $paymentManager->publicationEnabled()) {
			$templateMgr->assign('authorFees', true);
			$completedPaymentDao =& DAORegistry::getDAO('OJSCompletedPaymentDAO');

			if ($paymentManager->submissionEnabled()) {
				$templateMgr->assign_by_ref('submissionPayment', $completedPaymentDao->getSubmissionCompletedPayment ($journal->getId(), $articleId));
			}

			if ($paymentManager->fastTrackEnabled()) {
				$templateMgr->assign_by_ref('fastTrackPayment', $completedPaymentDao->getFastTrackCompletedPayment ($journal->getId(), $articleId));
			}

			if ($paymentManager->publicationEnabled()) {
				$templateMgr->assign_by_ref('publicationPayment', $completedPaymentDao->getPublicationCompletedPayment ($journal->getId(), $articleId));
			}
		}

		$templateMgr->assign('helpTopicId','editorial.authorsRole');

		$initialCopyeditSignoff = $submission->getSignoff('SIGNOFF_COPYEDITING_INITIAL');
		$templateMgr->assign('canEditMetadata', !$initialCopyeditSignoff->getDateCompleted() && $submission->getStatus() != STATUS_PUBLISHED);

		$templateMgr->display('author/submission.tpl');
	}

	/**
	 * Display specific details of an author's submission.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function submissionReview($args, $request) {
		$user =& $request->getUser();
		$articleId = (int) array_shift($args);

		$this->validate($request, $articleId);
		$authorSubmission =& $this->submission;
		$this->setupTemplate($request, true, $articleId);
		AppLocale::requireComponents(LOCALE_COMPONENT_OJS_EDITOR); // editor.article.decision etc. FIXME?

		$reviewAssignmentDao =& DAORegistry::getDAO('ReviewAssignmentDAO');
		$reviewModifiedByRound = $reviewAssignmentDao->getLastModifiedByRound($articleId);
		$reviewEarliestNotificationByRound = $reviewAssignmentDao->getEarliestNotificationByRound($articleId);
		$reviewFilesByRound =& $reviewAssignmentDao->getReviewFilesByRound($articleId);
		$authorViewableFilesByRound =& $reviewAssignmentDao->getAuthorViewableFilesByRound($articleId);

		$editorDecisions = $authorSubmission->getDecisions($authorSubmission->getCurrentRound());
		$lastDecision = count($editorDecisions) >= 1 ? $editorDecisions[count($editorDecisions) - 1] : null;

		$templateMgr =& TemplateManager::getManager();

		$reviewAssignments =& $authorSubmission->getReviewAssignments();
		$templateMgr->assign_by_ref('reviewAssignments', $reviewAssignments);
		$templateMgr->assign_by_ref('submission', $authorSubmission);
		$templateMgr->assign_by_ref('reviewFilesByRound', $reviewFilesByRound);
		$templateMgr->assign_by_ref('authorViewableFilesByRound', $authorViewableFilesByRound);
		$templateMgr->assign_by_ref('reviewModifiedByRound', $reviewModifiedByRound);

		$reviewIndexesByRound = array();
		for ($round = 1; $round <= $authorSubmission->getCurrentRound(); $round++) {
			$reviewIndexesByRound[$round] = $reviewAssignmentDao->getReviewIndexesForRound($articleId, $round);
		}
		$templateMgr->assign_by_ref('reviewIndexesByRound', $reviewIndexesByRound);

		$templateMgr->assign('reviewEarliestNotificationByRound', $reviewEarliestNotificationByRound);
		$templateMgr->assign_by_ref('submissionFile', $authorSubmission->getSubmissionFile());
		$templateMgr->assign_by_ref('revisedFile', $authorSubmission->getRevisedFile());
		$templateMgr->assign_by_ref('suppFiles', $authorSubmission->getSuppFiles());
		$templateMgr->assign('lastEditorDecision', $lastDecision);
		import('classes.submission.sectionEditor.SectionEditorSubmission');
		$templateMgr->assign('editorDecisionOptions', SectionEditorSubmission::getEditorDecisionOptions());
		$templateMgr->assign('helpTopicId', 'editorial.authorsRole.review');
		$templateMgr->display('author/submissionReview.tpl');
	}

	/**
	 * Add a supplementary file.
	 * @param $args array ($articleId)
	 * @param $request PKPRequest
	 */
	function addSuppFile($args, $request) {
		$articleId = (int) array_shift($args);
		$journal =& $request->getJournal();

		$this->validate($request, $articleId);
		$authorSubmission =& $this->submission;

		if ($authorSubmission->getStatus() != STATUS_PUBLISHED && $authorSubmission->getStatus() != STATUS_ARCHIVED) {
			$this->setupTemplate($request, true, $articleId, 'summary');

			import('classes.submission.form.SuppFileForm');

			$submitForm = new SuppFileForm($authorSubmission, $journal);

			if ($submitForm->isLocaleResubmit()) {
				$submitForm->readInputData();
			} else {
				$submitForm->initData();
			}
			$submitForm->display();
		} else {
			$request->redirect(null, null, 'submission', $articleId);
		}
	}

	/**
	 * Edit a supplementary file.
	 * @param $args array ($articleId, $suppFileId)
	 * @param $request PKPRequest
	 */
	function editSuppFile($args, &$request) {
		$articleId = (int) array_shift($args);
		$suppFileId = (int) array_shift($args);
		$this->validate($request, $articleId);
		$authorSubmission =& $this->submission;

		if ($authorSubmission->getStatus() != STATUS_PUBLISHED && $authorSubmission->getStatus() != STATUS_ARCHIVED) {
			$this->setupTemplate($request, true, $articleId, 'summary');

			import('classes.submission.form.SuppFileForm');

			$journal =& $request->getJournal();
			$submitForm = new SuppFileForm($authorSubmission, $journal, $suppFileId);

			if ($submitForm->isLocaleResubmit()) {
				$submitForm->readInputData();
			} else {
				$submitForm->initData();
			}
			$submitForm->display();
		} else {
			$request->redirect(null, null, 'submission', $articleId);
		}
	}

	/**
	 * Set reviewer visibility for a supplementary file.
	 * @param $args array ($suppFileId)
	 * @param $request PKPRequest
	 */
	function setSuppFileVisibility($args, $request) {
		$articleId = (int) $request->getUserVar('articleId');
		$this->validate($request, $articleId);
		$authorSubmission =& $this->submission;

		if ($authorSubmission->getStatus() != STATUS_PUBLISHED && $authorSubmission->getStatus() != STATUS_ARCHIVED) {
			$suppFileId = $request->getUserVar('fileId');
			$suppFileDao =& DAORegistry::getDAO('SuppFileDAO');
			$suppFile = $suppFileDao->getSuppFile($suppFileId, $articleId);

			if (isset($suppFile) && $suppFile != null) {
				$suppFile->setShowReviewers($request->getUserVar('hide')==1?0:1);
				$suppFileDao->updateSuppFile($suppFile);
			}
		}
		$request->redirect(null, null, 'submissionReview', $articleId);
	}

	/**
	 * Save a supplementary file.
	 * @param $args array ($suppFileId)
	 * @param $request PKPRequest
	 */
	function saveSuppFile($args, $request) {
		$articleId = (int) $request->getUserVar('articleId');
		$suppFileId = (int) array_shift($args);
		$this->validate($request, $articleId);

		$authorSubmission =& $this->submission;
		$this->setupTemplate($request, true, $articleId, 'summary');

		if ($authorSubmission->getStatus() != STATUS_PUBLISHED && $authorSubmission->getStatus() != STATUS_ARCHIVED) {
			import('classes.submission.form.SuppFileForm');

			$journal =& $request->getJournal();
			$submitForm = new SuppFileForm($authorSubmission, $journal, $suppFileId);
			$submitForm->readInputData();

			if ($submitForm->validate()) {
				$submitForm->execute();
				$request->redirect(null, null, 'submission', $articleId);
			} else {
				$submitForm->display();
			}
		} else {
			$request->redirect(null, null, 'submission', $articleId);
		}
	}

	/**
	 * Display the status and other details of an author's submission.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function submissionEditing($args, $request) {
		$journal =& $request->getJournal();
		$user =& $request->getUser();
		$articleId = (int) array_shift($args);

		$this->validate($request, $articleId);
		$submission =& $this->submission;
		$this->setupTemplate($request, true, $articleId);

		AuthorAction::copyeditUnderway($submission);
		import('classes.submission.proofreader.ProofreaderAction');
		ProofreaderAction::proofreadingUnderway($submission, 'SIGNOFF_PROOFREADING_AUTHOR');

		$templateMgr =& TemplateManager::getManager();
		$templateMgr->assign_by_ref('submission', $submission);
		$templateMgr->assign_by_ref('copyeditor', $submission->getUserBySignoffType('SIGNOFF_COPYEDITING_INITIAL'));
		$templateMgr->assign_by_ref('submissionFile', $submission->getSubmissionFile());
		$templateMgr->assign_by_ref('initialCopyeditFile', $submission->getFileBySignoffType('SIGNOFF_COPYEDITING_INITIAL'));
		$templateMgr->assign_by_ref('editorAuthorCopyeditFile', $submission->getFileBySignoffType('SIGNOFF_COPYEDITING_AUTHOR'));
		$templateMgr->assign_by_ref('finalCopyeditFile', $submission->getFileBySignoffType('SIGNOFF_COPYEDITING_FINAL'));
		$templateMgr->assign_by_ref('suppFiles', $submission->getSuppFiles());
		$templateMgr->assign('useCopyeditors', $journal->getSetting('useCopyeditors'));
		$templateMgr->assign('useLayoutEditors', $journal->getSetting('useLayoutEditors'));
		$templateMgr->assign('useProofreaders', $journal->getSetting('useProofreaders'));
		$templateMgr->assign('helpTopicId', 'editorial.authorsRole.editing');
		$templateMgr->display('author/submissionEditing.tpl');
	}

	/**
	 * Upload the author's revised version of an article.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function uploadRevisedVersion($args, $request) {
		$articleId = (int) $request->getUserVar('articleId');
		$this->validate($request, $articleId);
		$submission =& $this->submission;
		$this->setupTemplate($request, true);

		AuthorAction::uploadRevisedVersion($submission, $request);

		$request->redirect(null, null, 'submissionReview', $articleId);
	}

	/**
	 * View the submission metadata.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function viewMetadata($args, $request) {
		$articleId = (int) array_shift($args);
		$journal =& $request->getJournal();
		$this->validate($request, $articleId);
		$submission =& $this->submission;
		$this->setupTemplate($request, true, $articleId, 'summary');

		AuthorAction::viewMetadata($submission, $journal);
	}

	/**
	 * Save the modified metadata.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function saveMetadata($args, $request) {
		$articleId = (int) $request->getUserVar('articleId');
		$this->validate($request, $articleId);
		$submission =& $this->submission;
		$this->setupTemplate($request, true, $articleId);

		// If the copy editor has completed copyediting, disallow
		// the author from changing the metadata.
		$signoffDao =& DAORegistry::getDAO('SignoffDAO');
		$initialSignoff = $signoffDao->build('SIGNOFF_COPYEDITING_INITIAL', ASSOC_TYPE_ARTICLE, $submission->getId());
		if ($initialSignoff->getDateCompleted() != null || AuthorAction::saveMetadata($submission, $request)) {
			$request->redirect(null, null, 'submission', $articleId);
		}
	}

	/**
	 * Remove cover page from article
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function removeArticleCoverPage($args, $request) {
		$articleId = (int) array_shift($args);
		$this->validate($request, $articleId);

		$formLocale = array_shift($args);
		if (!AppLocale::isLocaleValid($formLocale)) {
			$request->redirect(null, null, 'viewMetadata', $articleId);
		}

		$submission =& $this->submission;
		$journal =& $request->getJournal();

		import('classes.file.PublicFileManager');
		$publicFileManager = new PublicFileManager();
		$publicFileManager->removeJournalFile($journal->getId(),$submission->getFileName($formLocale));
		$submission->setFileName('', $formLocale);
		$submission->setOriginalFileName('', $formLocale);
		$submission->setWidth('', $formLocale);
		$submission->setHeight('', $formLocale);

		$articleDao =& DAORegistry::getDAO('ArticleDAO');
		$articleDao->updateArticle($submission);

		$request->redirect(null, null, 'viewMetadata', $articleId);
	}

	/**
	 * Uploaded a copyedited version of the submission.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function uploadCopyeditVersion($args, $request) {
		$copyeditStage = $request->getUserVar('copyeditStage');
		$articleId = (int) $request->getUserVar('articleId');

		$this->validate($request, $articleId);
		$submission =& $this->submission;
		$this->setupTemplate($request, true, $articleId);

		AuthorAction::uploadCopyeditVersion($submission, $copyeditStage);

		$request->redirect(null, null, 'submissionEditing', $articleId);
	}

	/**
	 * Flag the author copyediting process as complete.
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function completeAuthorCopyedit($args, $request) {
		$articleId = (int) $request->getUserVar('articleId');
		$this->validate($request, $articleId);
		$submission =& $this->submission;
		$this->setupTemplate($request, true);

		if (AuthorAction::completeAuthorCopyedit($submission, $request->getUserVar('send'), $request)) {
			$request->redirect(null, null, 'submissionEditing', $articleId);
		}
	}

	//
	// Misc
	//
	/**
	 * Download the originstampZip
	 * @param $args array ($articleId, $fileId, [$revision])
	 * @param $request PKPRequest
	 */
	
	function downloadOriginstampZipFile($args, $request) {
		$articleId = (int) array_shift($args);
		$fileId = (int) array_shift($args);
		$revision = (int) array_shift($args);
		if (!$revision) $revision = null;
//		var_dump("ID: ".$articleId." fileId: ".$fileId." revision: ".$revision);
		$this->validate($request, $articleId);
		$submission =& $this->submission;
		$artFileMan = new ArticleFileManager($articleId);
		$tempFile = $artFileMan->getFile($fileId, $revision);
		$filePath = $tempFile->getFilePath();
//		var_dump("filepath: ".$filePath);
		$originalName = $tempFile->getOriginalFileName();
//		$originstampVerificator = $_SERVER['DOCUMENT_ROOT']."/originstampVerificator.zip";
		//copy zip template with originstampValidator
//		copy($originstampVerificator, dirname($filePath));
        $seedPath = $this->getSeedFile($filePath);
        //fetch timestamp from db and get the path for the zip.
        $timestampPath=$this->getTimeStampPath($articleId,$filePath);
//        var_dump("seedpath: ".$seedPath);
		if($seedPath  == false){
			print "<script>alert('seedfile not available yet, or originstamp.com is currently not available.')</script>";
            $request->redirect(null, null, 'submission', $articleId);
		}

		$paths = array(
				$filePath,
				$seedPath,
				//add hashes list
		);
		if($timestampPath!=false){
			array_push($paths, $timestampPath);
		} else {
			echo '<script>alert("something gone wrong with the timestamp")</script>';
		}
		$zipDestination = $this->add_to_zip($paths, dirname($filePath).'/'.pathinfo($originalName,PATHINFO_FILENAME).'_originstampVerificator.zip', $originalName);
		if(!($zipDestination)){
            $request->redirect(null, null, 'submission', $articleId);
		} else if(file_exists($zipDestination)) {
			//$quoted = sprintf('"%s"', addcslashes(basename(dirname($filePath)."/".$articleId.".zip"), '"\\'));
            $quoted = sprintf('"%s"', addcslashes(basename($zipDestination), '"\\'));//TODO:dirname($filePath)."/originstampVerficator.zip"
			$size   = filesize($zipDestination);//TODO:dirname($filePath)."/originstampVerificator.zip"
			ob_clean();
			header('Content-Description: File Transfer');
			header('Content-Type: application/zip'); //octet-stream
			header('Content-Disposition: attachment; filename=' . $quoted);
			header('Content-Transfer-Encoding: binary');
			header('Connection: Keep-Alive');
			header('Expires: 0');
			header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
			header('Pragma: public');
			header('Content-Length:' . $size);
			ob_clean();
			flush();
			readfile($zipDestination);
		} else {
			print "file doesnt exists";
			var_dump("file does not exist");
		}
	}

	function getTimeStampPath($id, $filePath){
        $db = mysqli_connect("localhost", "iivooo", "AeC4deVoop4eiRohb9a", "iivooo");
        if(!$db)
        {
            var_dump('database connection failed.');
            exit("Verbindungsfehler: ".mysqli_connect_error());

        }

        //fetch all article_ids with submissionstatus < 3
        $query = "SELECT originTimestamp FROM articles WHERE article_id =".$id;
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

        mysqli_close($db);

	}

	function getSeedFile($filePath){
		$fileHash=hash_file("sha256",$filePath, FALSE);
        $url = "https://api.originstamp.org/api/download/seed/".$fileHash;
        $apiKey = "988e7238-995e-4db0-8277-ce8f75d4b037";
       // $apiKey="c5adf195-e5c0-44fe-97d9-6317367229ae";

        $ch = curl_init( $url );
//        curl_setopt( $ch, CURLOPT_POST, 1);
//        curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
//        curl_setopt( $ch, CURLOPT_HEADER, 0);
//        curl_setopt($ch, CURLOPT_POSTFIELDS,$vars);  //Post Fields
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-type: application/json',
            'charset: utf-8',
            'Authorization: '.$apiKey
        ));
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);
		//TODO: error handling

        $response = curl_exec( $ch );
        curl_close ($ch);
		if(strpos($response, $fileHash) === FALSE){
			return false;
		}
        $resultPath= dirname($filePath)."/seedfile.txt";
        $fp = fopen($resultPath,"wb");
        fwrite($fp,$response);
        fclose($fp);

        return $resultPath;
    }

    /**
     * @param array $files
     * @param string $destination
     * @param bool $overwrite
     * @return bool|string
     */
    function add_to_zip($files = array(), $destination = '', $originalName) {
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
			 //$overwrite ? ZIPARCHIVE::OVERWRITE :
			//workaround because ZipArchive OVERWRITE isnt working proerply
			if(file_exists($destination)){
				unlink($destination);
			}
            $zip = new ZipArchive();
			if($err = $zip->open($destination, ZIPARCHIVE::CREATE) !== TRUE) {
              var_dump("err: ".$err);
				return false;
			}


			//add manual verificator
			$rootPath = $_SERVER['DOCUMENT_ROOT']."/originstampVerificator/";
            $files = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($rootPath),
                RecursiveIteratorIterator::LEAVES_ONLY
            );

            foreach ($files as $name => $file)
            {
                // Skip directories (they would be added automatically)
                if (!$file->isDir())
                {
                    // Get real and relative path for current file
                    $filePath = $file->getRealPath();
//                    var_dump($filePath);
                    $relativePath = substr($filePath, strlen($rootPath) );

                    // Add current file to archive
                    $zip->addFile($filePath, $relativePath);
//                    for($i=0; $i < $zip->numFiles; $i++){
//                        var_dump($zip->getNameIndex($i));
//                    }
                }
            }
            //add the filess
            foreach($valid_files as $file) {
            	$content = file_get_contents($file);
//				var_dump($file);
                $zip->addFromString(pathinfo($file, PATHINFO_BASENAME), $content); //
//				var_dump(basename($file));
//				for($i=0; $i < $zip->numFiles; $i++){
//                    var_dump($zip->getNameIndex($i));
//				}

            }




            //debug
// 			print 'The zip archive contains '.$zip->numFiles.' files with a status of '.$zip->status;
			//close the zip -- done!
			$zip->close();
	
			//check to make sure the file exists
			return $destination;
		}
		else
		{
			return false;
		}
	}

	/**
	 * Download a file.
	 * @param $args array ($articleId, $fileId, [$revision])
	 * @param $request PKPRequest
	 */
	function downloadFile($args, $request) {
		$articleId = (int) array_shift($args);
		$fileId = (int) array_shift($args);
		$revision = (int) array_shift($args);
		if (!$revision) $revision = null;

		$this->validate($request, $articleId);
		$submission =& $this->submission;
		if (!AuthorAction::downloadAuthorFile($submission, $fileId, $revision)) {
			$request->redirect(null, null, 'submission', $articleId);
		}
	}

	/**
	 * Download a file.
	 * @param $args array ($articleId, $fileId, [$revision])
	 * @param $request PKPRequest
	 */
	function download($args, $request) {
		$articleId = (int) array_shift($args);
		$fileId = (int) array_shift($args);
		$revision = (int) array_shift($args);
		if (!$revision) $revision = null;

		$this->validate($request, $articleId);
		Action::downloadFile($articleId, $fileId, $revision);
	}

	//
	// Proofreading
	//

	/**
	 * Set the author proofreading date completion
	 * @param $args array
	 * @param $request PKPRequest
	 */
	function authorProofreadingComplete($args, $request) {
		$articleId = (int) $request->getUserVar('articleId');
		$this->validate($request, $articleId);
		$this->setupTemplate($request, true);

		$send = $request->getUserVar('send');

		import('classes.submission.proofreader.ProofreaderAction');

		if (ProofreaderAction::proofreadEmail($articleId, 'PROOFREAD_AUTHOR_COMPLETE', $request, $send?'':$request->url(null, 'author', 'authorProofreadingComplete'))) {
			$request->redirect(null, null, 'submissionEditing', $articleId);
		}
	}

	/**
	 * Proof / "preview" a galley.
	 * @param $args array ($articleId, $galleyId)
	 * @param $request PKPRequest
	 */
	function proofGalley($args, $request) {
		$articleId = (int) array_shift($args);
		$galleyId = (int) array_shift($args);
		$this->validate($request, $articleId);
		$this->setupTemplate($request);

		$templateMgr =& TemplateManager::getManager();
		$templateMgr->assign('articleId', $articleId);
		$templateMgr->assign('galleyId', $galleyId);
		$templateMgr->display('submission/layout/proofGalley.tpl');
	}

	/**
	 * Proof galley (shows frame header).
	 * @param $args array ($articleId, $galleyId)
	 * @param $request PKPRequest
	 */
	function proofGalleyTop($args, $request) {
		$articleId = (int) array_shift($args);
		$galleyId = (int) array_shift($args);
		$this->validate($request, $articleId);
		$this->setupTemplate($request);

		$templateMgr =& TemplateManager::getManager();
		$templateMgr->assign('articleId', $articleId);
		$templateMgr->assign('galleyId', $galleyId);
		$templateMgr->assign('backHandler', 'submissionEditing');
		$templateMgr->display('submission/layout/proofGalleyTop.tpl');
	}

	/**
	 * Proof galley (outputs file contents).
	 * @param $args array ($articleId, $galleyId)
	 * @param $request PKPRequest
	 */
	function proofGalleyFile($args, $request) {
		$articleId = (int) array_shift($args);
		$galleyId = (int) array_shift($args);
		$this->validate($request, $articleId);

		$galleyDao =& DAORegistry::getDAO('ArticleGalleyDAO');
		$galley =& $galleyDao->getGalley($galleyId, $articleId);

		import('classes.file.ArticleFileManager'); // FIXME

		if (isset($galley)) {
			if ($galley->isHTMLGalley()) {
				$templateMgr =& TemplateManager::getManager();
				$templateMgr->assign_by_ref('galley', $galley);
				if ($galley->isHTMLGalley() && $styleFile =& $galley->getStyleFile()) {
					$templateMgr->addStyleSheet($request->url(null, 'article', 'viewFile', array(
						$articleId, $galleyId, $styleFile->getFileId()
					)));
				}
				$templateMgr->display('submission/layout/proofGalleyHTML.tpl');

			} else {
				// View non-HTML file inline
				$this->viewFile(array($articleId, $galley->getFileId()), $request);
			}
		}
	}

	/**
	 * View a file (inlines file).
	 * @param $args array ($articleId, $fileId, [$revision])
	 * @param $request PKPRequest
	 */
	function viewFile($args, $request) {
		$articleId = (int) array_shift($args);
		$fileId = (int) array_shift($args);
		$revision = (int) array_shift($args);
		if (!$revision) $revision = null;

		$this->validate($request, $articleId);
		if (!AuthorAction::viewFile($articleId, $fileId, $revision)) {
			$request->redirect(null, null, 'submission', $articleId);
		}
	}

	//
	// Payment Actions
	//

	/**
	 * Display a form to pay for the submission an article
	 * @param $args array ($articleId)
	 * @param $request PKPRequest
	 */
	function paySubmissionFee($args, $request) {
		$articleId = (int) array_shift($args);

		$this->validate($request, $articleId);
		$this->setupTemplate($request, true, $articleId);

		$journal =& $request->getJournal();

		import('classes.payment.ojs.OJSPaymentManager');
		$paymentManager = new OJSPaymentManager($request);
		$user =& $request->getUser();

		$queuedPayment =& $paymentManager->createQueuedPayment($journal->getId(), PAYMENT_TYPE_SUBMISSION, $user->getId(), $articleId, $journal->getSetting('submissionFee'));
		$queuedPaymentId = $paymentManager->queuePayment($queuedPayment);

		$paymentManager->displayPaymentForm($queuedPaymentId, $queuedPayment);
	}

	/**
	 * Display a form to pay for Fast Tracking an article
	 * @param $args array ($articleId)
	 * @param $request PKPRequest
	 */
	function payFastTrackFee($args, $request) {
		$articleId = (int) array_shift($args);

		$this->validate($request, $articleId);
		$this->setupTemplate($request, true, $articleId);

		$journal =& $request->getJournal();

		import('classes.payment.ojs.OJSPaymentManager');
		$paymentManager = new OJSPaymentManager($request);
		$user =& $request->getUser();

		$queuedPayment =& $paymentManager->createQueuedPayment($journal->getId(), PAYMENT_TYPE_FASTTRACK, $user->getId(), $articleId, $journal->getSetting('fastTrackFee'));
		$queuedPaymentId = $paymentManager->queuePayment($queuedPayment);

		$paymentManager->displayPaymentForm($queuedPaymentId, $queuedPayment);
	}

	/**
	 * Display a form to pay for Publishing an article
	 * @param $args array ($articleId)
	 * @param $request PKPRequest
	 */
	function payPublicationFee($args, $request) {
		$articleId = (int) array_shift($args);

		$this->validate($request, $articleId);
		$this->setupTemplate($request, true, $articleId);

		$journal =& $request->getJournal();

		import('classes.payment.ojs.OJSPaymentManager');
		$paymentManager = new OJSPaymentManager($request);
		$user =& $request->getUser();

		$queuedPayment =& $paymentManager->createQueuedPayment($journal->getId(), PAYMENT_TYPE_PUBLICATION, $user->getId(), $articleId, $journal->getSetting('publicationFee'));
		$queuedPaymentId = $paymentManager->queuePayment($queuedPayment);

		$paymentManager->displayPaymentForm($queuedPaymentId, $queuedPayment);
	}
}

?>
