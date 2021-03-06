{**
 * templates/author/index.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal author index.
 *
 *}
{strip}
{assign var="pageTitle" value="common.queue.long.$pageToDisplay"}
{include file="common/header.tpl"}
{/strip}

<ul class="menu">
	<li{if ($pageToDisplay == "active")} class="current"{/if}><a href="{url op="index" path="active"}">{translate key="common.queue.short.active"}</a></li>
	{*@cryptSubmit archive out*}
	{*<li{if ($pageToDisplay == "completed")} class="current"{/if}><a href="{url op="index" path="completed"}">{translate key="common.queue.short.completed"}</a></li>*}
</ul>

<br />

{include file="author/$pageToDisplay.tpl"}
<div id="submitStart">
<h4>{translate key="author.submit.startHereTitle"}</h4>
{url|assign:"submitUrl" op="submit"}
<font color="red">{translate submitUrl=$submitUrl key="author.submit.startHereLink"}<br /></font>
</div>

{call_hook name="Templates::Author::Index::AdditionalItems"}

{include file="common/footer.tpl"}

