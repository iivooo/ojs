{**
 * templates/user/login.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{strip}
{assign var="pageTitle" value="user.login"}
{include file="common/header.tpl"}
{/strip}

{if !$registerOp}
	{assign var="registerOp" value="register"}
{/if}
{if !$registerLocaleKey}
	{assign var="registerLocaleKey" value="user.login.registerNewAccount"}
{/if}

{if $loginMessage}
	<span class="instruct">{translate key="$loginMessage"}</span>
	<br />
	<br />
{/if}

{if $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
	<h3>{translate key="user.login.implicitAuth"}</h3>
{/if}
{if $implicitAuth}
	<a id="implicitAuthLogin" href="{url page="login" op="implicitAuthLogin"}">{translate key="user.login.implicitAuthLogin"}</a>
{/if}
{if $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
	<h3>{translate key="user.login.localAuth"}</h3>
{/if}
{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
	<form id="signinForm" method="post" action="{$loginUrl}">
{/if}

{if $error}
	<span class="pkp_form_error">{translate key="$error" reason=$reason}</span>
	<br />
	<br />
{/if}
		<!--@cryptSubmit-->
        {*{include file="cryptSubmit/mainDescription.tpl"}*}
        {include file="cryptSubmit/mainDescription3.tpl"}

        {*<div style = 	"background-color:lightblue;*}
				 {*border:2px black solid; margin-bottom: 20px;">*}
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

{*<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />*}

{*{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}*}
	{*<table id="signinTable" class="data">*}
	{*<tr>*}
		{*<td class="label"><label for="loginUsername">{translate key="user.username"}</label></td>*}
		{*<td class="value"><input type="text" id="loginUsername" name="username" value="{$username|escape}" size="20" maxlength="32" class="textField" /></td>*}
	{*</tr>*}
	{*<tr>*}
		{*<td class="label"><label for="loginPassword">{translate key="user.password"}</label></td>*}
		{*<td class="value"><input type="password" id="loginPassword" name="password" value="{$password|escape}" size="20" class="textField" /></td>*}
	{*</tr>*}
	{*{if $showRemember}*}
	{*<tr valign="middle">*}
		{*<td></td>*}
		{*<td class="value"><input type="checkbox" id="loginRemember" name="remember" value="1"{if $remember} checked="checked"{/if} /> <label for="loginRemember">{translate key="user.login.rememberUsernameAndPassword"}</label></td>*}
	{*</tr>*}
	{*{/if}*}{* $showRemember *}

	{*<tr>*}
		{*<td></td>*}
		{*<td><input type="submit" value="{translate key="user.login"}" class="button" /></td>*}
	{*</tr>*}
	{*</table>*}

	{*<ul>*}
		{*{if !$hideRegisterLink}<li><a href="{url page="user" op=$registerOp}">{translate key=$registerLocaleKey}</a></li>{/if}*}
		{*<li><a href="{url page="login" op="lostPassword"}">{translate key="user.login.forgotPassword"}</a></li>*}
	{*</ul>*}

{*<script type="text/javascript">*}
{*<!--*}
	{*document.getElementById('{if $username}loginPassword{else}loginUsername{/if}').focus();*}
{*// -->*}
{*</script>*}
{*</form>*}
{*{/if}*}{* !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL *}

{include file="common/footer.tpl"}
