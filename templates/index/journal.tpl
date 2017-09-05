{**
 * templates/index/journal.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal index page.
 *
 *}
{strip}
{assign var="pageTitleTranslated" value=$siteTitle}
{include file="common/header.tpl"}
{/strip}
{*{include file="cryptSubmit/mainDescription.tpl"}*}
{include file="cryptSubmit/mainDescription3.tpl"}

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
{*Please login on the right side with:<br><br>*}
	{*<div>*}
	{*<b>Username: author</b><br>*}
	{*<b>Password: 123456</b><br><br>*}
	{*</div>*}
	{*The prototype supports following functions already:<br><br>*}
	{*<ul>*}
		{*<li>Timestamping submissions client-side with <a href="https://app.originstamp.org/">orginstamp.org</a> before uploaded.</li>*}
		{*<li>Show the actual <a href="https://app.originstamp.org/home">orginstamp.org</a> timestamping-status in the summary.</li>*}
		{*<li>Within a submissions summary a zip is downloadable with the original file and an offline verifier, which provides a link to*}
		{*<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>*}
	{*</ul>*}
{*</div>*}
{if $journalDescription}
	<div id="journalDescription">{$journalDescription}</div>
{/if}

{call_hook name="Templates::Index::journal"}

{if $homepageImage}
<br />
<div id="homepageImage"><img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}" width="{$homepageImage.width|escape}" height="{$homepageImage.height|escape}" {if $homepageImageAltText != ''}alt="{$homepageImageAltText|escape}"{else}alt="{translate key="common.journalHomepageImage.altText"}"{/if} /></div>
{/if}

{if $additionalHomeContent}
<br />
<div id="additionalHomeContent">{$additionalHomeContent}</div>
{/if}

{if $enableAnnouncementsHomepage}
	{* Display announcements *}
	<div id="announcementsHome">
		<h3>{translate key="announcement.announcementsHome"}</h3>
		{include file="announcement/list.tpl"}	
		<table class="announcementsMore">
			<tr>
				<td><a href="{url page="announcement"}">{translate key="announcement.moreAnnouncements"}</a></td>
			</tr>
		</table>
	</div>
{/if}

{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
	{* Display the table of contents or cover page of the current issue. *}
	<br />
	<h3>{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</h3>
	{include file="issue/view.tpl"}
{/if}

{include file="common/footer.tpl"}

