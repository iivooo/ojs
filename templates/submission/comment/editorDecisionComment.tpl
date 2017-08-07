{**
 * templates/submission/comment/editorDecisionComment.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to enter comments.
 *
 *}
{strip}
{include file="submission/comment/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
// In case this page is the result of a comment submit, reload the parent
// so that the necessary buttons will be activated.
window.opener.location.reload();
// -->
{/literal}
</script>
 <link rel="stylesheet" type="text/css" href="/ojs/styles/originstamper.css">

<div id="existingComments">
<table class="data" width="100%">
{foreach from=$articleComments item=comment}
<div id="comment">
<tr valign="top">
	<td width="25%">
		<div class="commentRole">{translate key=$comment->getRoleName()}</div>
		<div class="commentDate">{$comment->getDatePosted()|date_format:$datetimeFormatShort}</div>
	</td>
	<td width="75%">
		{if $comment->getAuthorId() eq $userId and not $isLocked}
			<div style="float: right"><a href="{url op="deleteComment" path=$articleId|to_array:$comment->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="submission.comments.confirmDelete"}')" class="action">{translate key="common.delete"}</a></div>
		{/if}
		<div id="{$comment->getId()}"></a>
		{if $comment->getCommentTitle() neq ""}
			<div class="commentTitle">{translate key="submission.comments.subject"}: {$comment->getCommentTitle()|escape}</div>
		{/if}
		</div>
		<div width="75%" style="float: left" class="comments">{$comment->getComments()|strip_unsafe_html|nl2br}</div>
			<div width="25%" style="float: right">
				<td align="right" width="15%" valign="center">
			{if $comment->getOriginstampStatus() eq 3} <td style="color:green;font-weight: bold;" align=left><div class="tooltip"><a style="color:green" href="{url op="downloadOriginZip" path=$articleId|to_array:$comment->getId()}">&#10003;</a><span class="tooltiptext">
					Originstamp Status: 3. Your submission is successfully timpestamped. By clicking, you will get a zip-file with the original timestamped sting ahead with a manual verifier.</span></div>
			<div><a target="_blank" href="https://app.originstamp.org/s/{$comment->getSHA256()|escape}">LINK</a></div></td>

		{else} <td style="color:orange;font-weight: bold;" align=left><div class="tooltip">&#10003;<span class="tooltiptext">
					Originstamp status: < 3. Your submission will be successfully timestamped in less than 24 hours. If this is done you can download a zip-file with the original timestamped sting ahead with a manual verifier. </span></div>
			<div><a target="_blank" style='color:orange' href="https://app.originstamp.org/s/{$comment->getSHA256()|escape}">LINK</a></div></td>{/if}
		</td>
		</div>

	</td>

</tr>
</div>
{foreachelse}
<tr>
	<td class="nodata">{translate key="submission.comments.noComments"}</td>
</tr>
{/foreach}
</table>
</div>
<br />
<br />

{if not $isLocked and $isEditor}
<form method="post" action="{url op=$commentAction}">
{if $hiddenFormParams}
	{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
		<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
	{/foreach}
{/if}


<div id="new">
{include file="common/formErrors.tpl"}

<table class="data" width="100%">
<tr valign="top">
	<td class="label">{fieldLabel name="commentTitle" key="submission.comments.subject"}</td>
	<td class="value"><input type="text" name="commentTitle" id="commentTitle" value="{$commentTitle|escape}" size="50" maxlength="255" class="textField" /></td>
</tr>
<tr valign="top">
	<td class="label">{fieldLabel name="comments" key="submission.comments.addComment"}</td>
	<td class="value"><textarea id="comments" name="comments" rows="10" cols="50" class="textArea">{$comments|escape}</textarea></td>
</tr>
</table>

<p><input type="submit" name="save" value="{translate key="common.save"}" class="button defaultButton" /> <input type="button" value="{translate key="common.close"}" class="button" onclick="window.close()" /></p>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</div>
</form>

{else}
<input type="button" value="{translate key="common.close"}" class="button defaultButton" style="width: 5em" onclick="window.close()" />
{/if}

{include file="submission/comment/footer.tpl"}

