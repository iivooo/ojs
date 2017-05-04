{** * templates/author/submit/step2.tpl * * Copyright (c) 2013-2016
Simon Fraser University Library * Copyright (c) 2003-2016 John Willinsky
* Distributed under the GNU GPL v2. For full terms see the file
docs/COPYING. * * Step 2 of author article submission. * *} {assign
var="pageTitle" value="author.submit.step2"} {include
file="author/submit/submitHeader.tpl"}

<!-- includes for the originstamp submission script to work - dont know where else yet -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> -->
<!-- <script src="ojs/js/forge-sha256.min.js" type="text/javascript"></script> -->
<!-- <script src="ojs/js/originstamper.js" type="text/javascript"></script> -->
<script type="text/javascript" src="{$baseUrl}/js/forge-sha256.min.js"></script>
<script type="text/javascript" src="{$baseUrl}/js/originstamper.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->

<!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"> -->
<!-- </script> -->



<form method="post" action="{url op=" saveSubmit" path=$submitStep} id="submitStep2"  
	" enctype="multipart/form-data">
	<input type="hidden" name="articleId" value="{$articleId|escape}" />
	{include file="common/formErrors.tpl"}

	<div id="uploadInstructions">{translate
		key="author.submit.uploadInstructions"}</div>

	{if $journalSettings.supportPhone} {assign var="howToKeyName"
	value="author.submit.howToSubmit"} {else} {assign var="howToKeyName"
	value="author.submit.howToSubmitNoPhone"} {/if}

	<p>{translate key=$howToKeyName
		supportName=$journalSettings.supportName
		supportEmail=$journalSettings.supportEmail
		supportPhone=$journalSettings.supportPhone}</p>

	<div class="separator"></div>

	<div id="submissionFile">
		<h3>{translate key="author.submit.submissionFile"}</h3>
		<table class="data" width="100%">
			{if $submissionFile}
			<tr valign="top">
				<td width="20%" class="label">{translate key="common.fileName"}</td>
				<td width="80%" class="value"><a href="{url op="download" path=$articleId|to_array:$submissionFile->getFileId()}">{$submissionFile->getFileName()|escape}</a></td>
			</tr>
			<tr valign="top">
				<td width="20%" class="label">{translate
					key="common.originalFileName"}</td>
				<td width="80%" class="value">{$submissionFile->getOriginalFileName()|escape}</td>
			</tr>
			<tr valign="top">
				<td width="20%" class="label">{translate key="common.fileSize"}</td>
				<td width="80%" class="value">{$submissionFile->getNiceFileSize()}</td>
			</tr>
			<tr valign="top">
				<td width="20%" class="label">{translate key="common.dateUploaded"}</td>
				<td width="80%" class="value">{$submissionFile->getDateUploaded()|date_format:$datetimeFormatShort}</td>
			</tr>
			{else}
			<tr valign="top">
				<td colspan="2" class="nodata">{translate
					key="author.submit.noSubmissionFile"}</td>
			</tr>
			{/if}
		</table>
	</div>

	<div class="separator"></div>

	<div id="addSubmissionFile">
		<table class="data" width="100%">
			<tr>
				<td width="30%" class="label">{if $submissionFile} {fieldLabel
					name="submissionFile" key="author.submit.replaceSubmissionFile"}
					{else} {fieldLabel name="submissionFile"
					key="author.submit.uploadSubmissionFile"} {/if}</td>
				<td width="70%" class="value"><input type="file" class="uploadField"
					name="submissionFile" id="submissionFile1" /> 
					<input
					name="uploadSubmissionFile" type="submit" class="button" onclick="handleFileSelect()"
					value="{translate key=" common.upload"}" /> {if
					$currentJournal->getSetting('showEnsuringLink')}<a class="action"
					href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate
						key="reviewer.article.ensuringBlindReview"}</a>{/if}</td>
			</tr>
		</table>
	</div>

	<div class="separator"></div>

	<!-- TODO: maybe insert this to translation files -->

	<h2>Trusted Timestamping</h2>
	<p>
		Your submission will be timestamped automatically by the trusted timestamping service <a
			href="https://www.originstamp.org">originstamp.org</a>. The service will 
		insert a unique fingerprint of your submission in the BitCoin Blockchain. 
		Afterwards you can verify a document, that it existed exactly in this form (not altered)
		at the upload time.
		<h2 style="color:red">IMPORTANT BEFORE UPLOADING:</h2>
		If you want to, you can copy a symbolic link into your document before uploading. With that, anybody can directly access the
		<a href="https://www.originstamp.org">originstamp.org</a> site and see your timestamp. <br>
		Click here to get a link to copy in your document before uploading:<br>
		<br>
		<span style="font-weight: bold" id="uuidLink"></span>
<!-- 		If you want to, we can trusted timestamp your submission. You will get -->
<!-- 		a SHA-256 hash from your submission which is submitted to <a -->
<!-- 			href="https://www.originstamp.org">originstamp.org</a>, which -->
<!-- 		timestamps the file via the BitCoin blockchain. You can later verify -->
<!-- 		that the submission existed in this not altered form at this time. The -->
<!-- 		service is free, but it can last up to 24h. If you need that -->
<!-- 		immediately, there is the option that you timestamp your submission -->
<!-- 		manually at the originstamp website. Your hashcode will be displayed -->
<!-- 		at your submissions overview. -->
	</p>
	<div class="separator"></div>

	<p>
		<input type="submit"
			{if !$submissionFile} onclick="return confirm('{translate|escape:"jsparam" key="author.submit.noSubmissionConfirm"
			}')"{/if} value="{translate key="common.saveAndContinue"}" class="button defaultButton"
			onclick="uploadHash(hash)" />
			<input
			type="button" value="{translate key=" common.cancel"}" class="button"
			onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission" }')" />
	</p>

</form>

{include file="common/footer.tpl"}

