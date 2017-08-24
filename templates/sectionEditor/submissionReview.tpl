{**
 * templates/sectionEditor/submissionReview.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Submission review.
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="submission.page.review" id=$submission->getId()}{assign var="pageCrumbTitle" value="submission.review"}
{include file="common/header.tpl"}
{/strip}
<ul class="menu">
	<li><a href="{url op="submission" path=$submission->getId()}">{translate key="submission.summary"}</a></li>
	<li class="current"><a href="{url op="submissionReview" path=$submission->getId()}">{translate key="submission.review"}</a></li>
	{if $canEdit}<li><a href="{url op="submissionEditing" path=$submission->getId()}">{translate key="submission.editing"}</a></li>{/if}
	<li><a href="{url op="submissionHistory" path=$submission->getId()}">{translate key="submission.history"}</a></li>
	<li><a href="{url op="submissionCitations" path=$submission->getId()}">{translate key="submission.citations"}</a></li>
</ul>
<div style="border-bottom: 2px dotted #000; margin-top:6px;"></div>
<div style="margin-top:10px"></div>
<div style = 	"background-color:lightblue;
				 /*border:2px black solid;*/
				 padding:15px;">
	At the bottom of this page, at the section Editor Decision you can find the comments <font color="red">(red)</font>.
	The comments are timestamped along with user-data such as ip-address, name etc.
	<p>Note on the <a href="https://app.originstamp.org/">originstamp.org</a> status:
	<ul>
		<li><div style="color:green;font-weight: bold;" align=left>&#10003;</div> The submission is successfully timestamped. The hash is in the Blockchain and at least one block is above.</li>
		<li><div style="color:orange;font-weight: bold;" align=left>&#10003;</div> The submission's timestamping is in progress. Will be successfully done within max. 24 hours.</li>
		<li><div style="color:red;font-weight: bold;" align=left>&#10003;</div> There is no main submission uploaded to the server.</li>
	</ul>
	</p>
	By clicking <font style="color:green;font-weight: bold;" align=left">&#10003;</font> (must be green) you can download
	a zip-file which provides a link to
	<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.
</div>

{include file="sectionEditor/submission/peerReview.tpl"}

<div class="separator"></div>

{include file="sectionEditor/submission/editorDecision.tpl"}

{include file="common/footer.tpl"}

