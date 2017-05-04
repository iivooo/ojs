{**
 * templates/author/submission.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Author's submission summary.
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="submission.page.summary" id=$submission->getId()}
{assign var="pageCrumbTitle" value="submission.summary"}
{include file="common/header.tpl"}
{/strip}

<ul class="menu">
	<li class="current"><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	<li><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>
	<li><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>
</ul>

{include file="author/submission/management.tpl"}

{if $authorFees}
<div class="separator"></div>

{include file="author/submission/authorFees.tpl"}
{/if}

<div class="separator"></div>

{include file="author/submission/status.tpl"}

<div class="separator"></div>

{include file="submission/metadata/metadata.tpl"}

<div class="separator"></div>
{**
 * templates/author/submission/originstampDownload.tpl
 *
 * Subtemplate defining the author's submission originstamp information download.
 *
 *}
<div id="submission">
<h3>{translate key="common.originstampStatus"}</h3>
<table width="100%" class="data">
	<tr valign="top">
	<!-- 	<td width="20%" class="label">{translate key="common.originstampZip"}</td> -->
		<td width="80%" colspan="2" class="data">
		{if $submission->getOriginstampStatus() == 3}
		In case of unavailability or for your archives, download a Zip-archive with all information needed to 
		manually verify your file within the Bitcoin-Blockchain.
			{if $submissionFile}
				<a href="{url op="downloadOriginstampZipFile" path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}" class="file"><font color="red">Download Zip.</font></a>&nbsp;&nbsp;
			{else}
				{translate key="common.none"}
			{/if}
        {else}
			You can download an offline verficator with your submission and anything you need to manually verify your submission in about 24 hours, when the timestamping process is completed.
		{/if}
		</td>
	</tr>
</table>
</div>


{include file="common/footer.tpl"}

