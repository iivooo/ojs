{**
 * templates/index/site.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site index.
 *
 *}
{strip}
{if $siteTitle}
	{assign var="pageTitleTranslated" value=$siteTitle}
{/if}
{include file="common/header.tpl"}
{/strip}

<br />

{if $intro}<div id="intro">{$intro|nl2br}</div>{/if}

<a name="journals"></a>

{if $useAlphalist}
	<p>{foreach from=$alphaList item=letter}<a href="{url searchInitial=$letter sort="title"}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>
{/if}
{include file="cryptSubmit/mainDescription.tpl"}
<!--@cryptSubmit-->
{*<div style = 	"background-color:lightblue;*}
				 {*border:2px black solid;">*}
	{*This prototype shows a possible implementation of <a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf">CryptSubmit</a> in an existing system.<br><br>*}
	{*The following is the abstract of the before mentioned paper which describes brief the use of such a system:<br><br>*}
	{*<i>Manuscript submission systems are a central fixture in scholarly*}
		{*publishing. However, researchers who submit their unpublished*}
		{*work to a conference or journal must trust that the system and its*}
		{*provider will not accidentally or willfully leak unpublished*}
		{*findings. Additionally, researchers must trust that the program*}
		{*committee and the anonymous peer reviewers will not plagiarize*}
		{*unpublished ideas or results. To address these weaknesses, we*}
		{*propose a method that automatically creates a publicly verifiable,*}
		{*tamper-proof timestamp for manuscripts utilizing the*}
		{*decentralized Bitcoin blockchain. The presented method hashes*}
		{*each submitted manuscript and uses the API of the timestamping*}
		{*service OriginStamp to persistently embed this manuscript hash*}
		{*on Bitcoin’s blockchain. Researchers can use this tamper-proof*}
		{*trusted timestamp to prove that their manuscript existed in its*}
		{*specific form at the time of submission to a conference or journal.*}
		{*This verifiability allows researchers to stake a claim to their*}
		{*research findings and intellectual property, even in the face of*}
		{*vulnerable submission platforms or dishonest peer reviewers.*}
		{*Optionally, the system also associates trusted timestamps with the*}
		{*feedback and ideas shared by peer reviewers to increase the*}
		{*traceability of ideas. The proposed concept, which we introduce*}
		{*as CryptSubmit, is currently being integrated into the open-source*}
		{*conference management system OJS. In the future, the method*}
		{*could be integrated at nearly no overhead cost into other*}
		{*manuscript submission systems, such as EasyChair, ConfTool, or*}
		{*Ambra. The introduced method can also improve electronic preprint*}
		{*services and storage systems for research data.</i><br><br>*}

	{*The prototype supports following functions already:<br><br>*}

		{*<b>For authors:</b><br>*}
	{*<ol>*}
		{*<li>Timestamping submissions client-side with <a href="https://app.originstamp.org/">orginstamp.org</a> before uploaded.</li>*}
		{*<li>Show the actual <a href="https://app.originstamp.org/home">orginstamp.org</a> timestamping-status in the summary.</li>*}
		{*<li>Within a submissions summary a zip is downloadable with the original file and an offline verifier, which provides a link to*}
			{*<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>*}
		{*<div>*}
			{*<br>*}
			{*Please login on the right side with:<br>*}
			{*<b>Username: author</b><br>*}
			{*<b>Password: 123456</b><br><br>*}
		{*</div>*}
	{*</ol>*}
	{*<b>For section editors:</b>*}
	{*<ol>*}
		{*<li>Comments are timestamped with ip-address, name etc.</li>*}
		{*<li>Downloads are timestamped (e.g. if a reviewer or author downloads an article) with ip-address, name etc.</li>*}
		{*<li>Login's are timestamped with ip-address, name etc.</li>*}
		{*<li>For all timestampings there is a status (with clickable link to originstamp.org) as well..</li>*}
		{*<li>.. as a zip is downloadable with the original file and an offline verifier, which provides a link to*}
			{*<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>*}
		{*<div>*}
			{*<br>*}
			{*Please login on the right side with:<br>*}
			{*<b>Username: sectioneditor</b><br>*}
			{*<b>Password: 123456</b><br><br>*}
		{*</div>*}
	{*</ol>*}


{*</div>*}
{*{iterate from=journals item=journal}*}
	{*{if $site->getSetting('showThumbnail')}*}
		{*{assign var="displayJournalThumbnail" value=$journal->getLocalizedSetting('journalThumbnail')}*}
		{*<div style="clear:left;">*}
		{*{if $displayJournalThumbnail && is_array($displayJournalThumbnail)}*}
			{*{assign var="altText" value=$journal->getLocalizedSetting('journalThumbnailAltText')}*}
			{*<div class="homepageImage"><a href="{url journal=$journal->getPath()}" class="action"><img src="{$journalFilesPath}{$journal->getId()}/{$displayJournalThumbnail.uploadName|escape:"url"}" {if $altText != ''}alt="{$altText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} /></a></div>*}
		{*{/if}*}
		{*</div>*}
	{*{/if}*}
	{*{if $site->getSetting('showTitle')}*}
		{*<h3>{$journal->getLocalizedTitle()|escape}</h3>*}
	{*{/if}*}
	{*{if $site->getSetting('showDescription')}*}
		{*{if $journal->getLocalizedDescription()}*}
			{*<div class="journalDescription" id="journalDescription-{$journal->getId()|escape}">*}
				{*{$journal->getLocalizedDescription()|nl2br}*}
			{*</div>*}
		{*{/if}*}
	{*{/if}*}
	{*<p><a href="{url journal=$journal->getPath()}" class="action">{translate key="site.journalView"}</a> | <a href="{url journal=$journal->getPath() page="issue" op="current"}" class="action">{translate key="site.journalCurrent"}</a> | <a href="{url journal=$journal->getPath() page="user" op="register"}" class="action">{translate key="site.journalRegister"}</a></p>*}
{*{/iterate}*}
{*{if $journals->wasEmpty()}*}
	{*{translate key="site.noJournals"}*}
{*{/if}*}

{*<div id="journalListPageInfo">{page_info iterator=$journals}</div>*}
{*<div id="journalListPageLinks">{page_links anchor="journals" name="journals" iterator=$journals}</div>*}

{include file="common/footer.tpl"}

