{**
 * templates/author/active.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show the details of active submissions.
 *
 *}
 <p>Here you can see the originstamp.org status on the right side of the active submissions. If the check font is green
 the submission is safely timestamped. If you click on the submission you will get to the overview page of
 the submission. Down the page there you can download a zip file with your submission and all the additional data
 you need for manual verification for your personal archives. Also, you can go through the 5 step submission 
 where your submission is timestamped client-side.</p>
 <link rel="stylesheet" type="text/css" href="/styles/originstamper.css">
<div id="submissions">
<table class="listing" width="100%">
	<tr><td colspan="7" class="headseparator">&nbsp;</td></tr>
	<tr class="heading" valign="bottom">
		<td width="5%">{sort_heading key="common.id" sort="id" sortOrder="ASC"}</td>
		<td width="5%"><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_heading key="submissions.submit" sort="submitDate"}</td>
		<td width="5%">{sort_heading key="submissions.sec" sort="section"}</td>
		<td width="25%">{sort_heading key="article.authors" sort="authors"}</td>
		<td width="35%">{sort_heading key="article.title" sort="title"}</td>
		<td width="15%" align="left">{sort_heading key="common.status" sort="status"}</td>
		<td width="10%" align="left">{sort_heading key="common.originstampStatus"}</td>                               <!-- ORIGINSTAMP Status -->
	</tr>
	<tr><td colspan="7" class="headseparator">&nbsp;</td></tr>

{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	{assign var="progress" value=$submission->getSubmissionProgress()}
	{assign var="sha256" value=$submission->getSHA256()}

	<tr valign="top">
		<td>{$articleId|escape}</td>
		<td>{if $submission->getDateSubmitted()}{$submission->getDateSubmitted()|date_format:$dateFormatTrunc}{else}&mdash;{/if}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		
		<td>{$submission->getAuthorString(true)|truncate:40:"..."|escape}</td>
		
		{if $progress == 0}
			<td><a href="{url op="submission" path=$articleId}" class="action"><font color="red">{if $submission->getLocalizedTitle()}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{else}{translate key="common.untitled"}{/if}</font></a></td>
			<td align="left">
				{assign var="status" value=$submission->getSubmissionStatus()}
				{if $status==STATUS_QUEUED_UNASSIGNED}{translate key="submissions.queuedUnassigned"}
				{elseif $status==STATUS_QUEUED_REVIEW}
					<a href="{url op="submissionReview" path=$articleId}" class="action">
						{assign var=decision value=$submission->getMostRecentDecision()}
						{if $decision == $smarty.const.SUBMISSION_EDITOR_DECISION_PENDING_REVISIONS}{translate key="author.submissions.queuedReviewRevisions"}
						{elseif $submission->getCurrentRound() > 1}{translate key="author.submissions.queuedReviewSubsequent" round=$submission->getCurrentRound()}
						{else}{translate key="submissions.queuedReview"}
						{/if}
					</a>
				{elseif $status==STATUS_QUEUED_EDITING}
					{assign var="proofSignoff" value=$submission->getSignoff('SIGNOFF_PROOFREADING_AUTHOR')}
					<a href="{url op="submissionEditing" path=$articleId}" class="action">
						{if $proofSignoff->getDateNotified() && !$proofSignoff->getDateCompleted()}{translate key="author.submissions.queuedEditingCopyedit"}
						{elseif $proofSignoff->getDateNotified() && !$proofSignoff->getDateCompleted()}{translate key="author.submissions.queuedEditingProofread"}
						{else}{translate key="submissions.queuedEditing"}
						{/if}
					</a>
				{/if}
				{if $submission->getOriginstampStatus() eq 3} <td style="color:green;font-weight: bold;" align=left><div class="tooltip" onclick='originstampDownload.php'>&#10003;<span class="tooltiptext">
				Originstamp Status: 3. Your submission is successfully timpestamped. In the articles summary, you will find a zip-file with all information you need for manual verification. </span></div>
				<div><a target="_blank" href="https://app.originstamp.org/s/{$sha256|escape}">LINK</a></div></td>
				{else} <td style="color:orange;font-weight: bold;" align=left><div class="tooltip" onclick='originstampDownload.php'>&#10003;<span class="tooltiptext">
				Originstamp status: < 3. Your submission will be successfully timestamped in less than 24 hours. In the articles summary, you will find a zip-file with all information you need for manual verification. </span></div>
				<div><a target="_blank" href="https://app.originstamp.org/s/{$sha256|escape}">LINK</a></div></td>{/if}

				{** Payment related actions *}
				{if $status==STATUS_QUEUED_UNASSIGNED || $status==STATUS_QUEUED_REVIEW}
					{if $submissionEnabled && !$completedPaymentDAO->hasPaidSubmission($submission->getJournalId(), $submission->getId())}
						<br />
						<a href="{url op="paySubmissionFee" path="$articleId"}" class="action">{translate key="payment.submission.paySubmission"}</a>					
					{elseif $fastTrackEnabled}
						<br />
						{if $submission->getFastTracked()}
							{translate key="payment.fastTrack.inFastTrack"}
						{else}
							<a href="{url op="payFastTrackFee" path="$articleId"}" class="action">{translate key="payment.fastTrack.payFastTrack"}</a>
						{/if}
					{/if}
				{elseif $status==STATUS_QUEUED_EDITING}
					{if $publicationEnabled}
						<br />
						{if $completedPaymentDAO->hasPaidPublication($submission->getJournalId(), $submission->getId())}
							{translate key="payment.publication.publicationPaid}
						{else}
							<a href="{url op="payPublicationFee" path="$articleId"}" class="action">{translate key="payment.publication.payPublication"}</a>
						{/if}
				{/if}		
		{/if}
			</td>
		{else}
			<td><a href="{url op="submit" path=$progress articleId=$articleId}" class="action">{if $submission->getLocalizedTitle()}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{else}{translate key="common.untitled"}{/if}</a></td>
			<td align="right">{translate key="submissions.incomplete"}<br /><a href="{url op="deleteSubmission" path=$articleId}" class="action" onclick="return confirm('{translate|escape:"jsparam" key="author.submissions.confirmDelete"}')">{translate key="common.delete"}</a></td>
		{/if}

	</tr>

	<tr>
		<td colspan="7" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
	<tr>
		<td colspan="6" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
	<tr>
		<td colspan="6" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td colspan="4" align="left">{page_info iterator=$submissions}</td>
		<td colspan="2" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>

