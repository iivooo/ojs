{**
 * templates/reviewer/active.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show reviewer's active submissions.
 *
 *}
<div class="descriptions">
	On this page you can..
	<ul>
		<li>.. see submissions to review with the corresponding <a href="https://app.originstamp.org/">originstamp.org</a> status on the right. </li>
		<li>.. click on a submission to do a review. Reviews are also timestamped. You can see the originstamp.org functions there.</li>
	</ul>
</div>
<div id="submissions">
<table class="listing" width="100%">
	<tr><td colspan="7" class="headseparator">&nbsp;</td></tr>
	<tr class="heading" valign="bottom">
		<td width="5%">{sort_heading key="common.id" sort='id'}</td>
		<td width="5%"><span class="disabled">{translate key="submission.date.mmdd"}</span><br />{sort_heading key="common.assigned" sort='assignDate'}</td>
		<td width="5%">{sort_heading key="submissions.sec" sort='section'}</td>
		<td width="50%">{sort_heading key="article.title" sort='title'}</td>
		<td width="5%">{sort_heading key="submission.due" sort='dueDate'}</td>
		<td width="10%">{sort_heading key="submissions.reviewRound" sort='round'}</td>
		<td width="20%" align="left">{sort_heading key="common.originstampStatus"}</td>
	</tr>
	<tr><td colspan="7" class="headseparator">&nbsp;</td></tr>

{iterate from=submissions item=submission}
	{assign var="articleId" value=$submission->getId()}
	{assign var="reviewId" value=$submission->getReviewId()}

	<tr valign="top">
		<td>{$articleId|escape}</td>
		<td>{$submission->getDateNotified()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getSectionAbbrev()|escape}</td>
		<td><a href="{url op="submission" path=$reviewId}" class="action">{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}</a></td>
		<td class="nowrap">{$submission->getDateDue()|date_format:$dateFormatTrunc}</td>
		<td>{$submission->getRound()}</td>
        {include file="cryptSubmit/originStatusReviewer.tpl"}

	</tr>
	<tr>
		<td colspan="7" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
	</tr>
{/iterate}
{if $submissions->wasEmpty()}
<tr>
		<td colspan="7" class="nodata">{translate key="submissions.noSubmissions"}</td>
	</tr>
	<tr>
		<td colspan="7" class="endseparator">&nbsp;</td>
	</tr>
{else}
	<tr>
		<td colspan="3" align="left">{page_info iterator=$submissions}</td>
		<td colspan="3" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
	</tr>
{/if}
</table>
</div>

