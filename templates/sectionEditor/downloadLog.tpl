{**
 * templates/sectionEditor/downloadLog.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show user downloads with corresponding originstamp.org timestampstatus of login string
 * as part of the CryptSubmit framework
 *
 *}
 <link rel="stylesheet" type="text/css" href="/ojs/styles/originstamper.css">
 <link rel="stylesheet" type="text/css" href="/ojs/styles/balloon.css">
<div style="border-bottom: 2px dotted #000; margin-top:6px;"></div>
<div style="margin-top:10px"></div>
<div style = 	"background-color:lightblue;
				 /*border:2px black solid;*/
                 padding:15px;">
    On this page you see the download log. All downloads are logged with user-data such as ip, username, name etc.
    {*<p>Note on the <a href="https://app.originstamp.org/">originstamp.org</a> status:*}
    {*<ul>*}
        {*<li><div style="color:green;font-weight: bold;" align=left>&#10003;</div> The submission is successfully timestamped. The hash is in the Blockchain and at least one block is above.</li>*}
        {*<li><div style="color:orange;font-weight: bold;" align=left>&#10003;</div> The submission's timestamping is in progress. Will be successfully done within max. 24 hours.</li>*}
        {*<li><div style="color:red;font-weight: bold;" align=left>&#10003;</div> There is no main submission uploaded to the server.</li>*}
    {*</ul>*}
    {*</p>*}
    {*By clicking <font style="color:green;font-weight: bold;" align=left">&#10003;</font> (must be green) you can download*}
    {*a zip-file which provides a link to*}
    {*<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.*}
    On this page you see the downloda log. All logins are logged with user-data such as ip, username, name etc.
    There is a link to <a href="https://app.originstamp.org/">originstamp.org</a> to each entry and a
    downloadable zip-file with the original timestamped string along with an offline verifier.<br>
    The timestamped login's along with the download log's and the articles may help to reveal users which violated copyrights.
</div>
<div id="LogInLog" style="height: 75vh; overflow-x: scroll; overflow-y: scroll">
    <table width="100%" class="listing">
        <tr><td colspan="8" class="headseparator">&nbsp;</td></tr>
        <tr class="heading" valign="bottom">
            <td width="5%">UserID</td>
            <td width="10%">IP Address</td>
            <td width="10%">Article ID/ File ID/ Revision</td>
            <td width="15%">Timestamp</td>
            <td width="10%">Username</td>
            <td width="10%">Firstname</td>
            <td width="10%">Lastname</td>
            <td width="40%">Originstamp.org status</td>
        </tr>
        <tr><td colspan="8" class="headseparator">&nbsp;</td></tr>

        {foreach from=$downloadLog item=log}

            <tr valign="top"{if $highlightClass} class="{$highlightClass|escape}"{/if}>
                <td>{$log.user_id}</td>
                <td>{$log.ip}</td>
                <td>{$log.article_id}/{$log.file_id}/{$log.revision}</td>
                <td>{$log.download_timestamp}</td>
                <td>{$log.username}</td>
                <td>{$log.first_name}</td>
                <td>{$log.last_name}</td>
                {*{if $log.origin_sha256 != ''}*}
                    {*{if $log.originstamp_status eq 3} <td style="color:green;font-weight: bold;" align=center><div style="display:inline" class="tooltip">*}
                            {*<a style="color:green" target="_blank" href="{url op="downloadDownloadLogZip" path=$log.ID}">&#10003;</a><span class="tooltiptext">*}
				{*Originstamp Status: 3. The log entry is successfully timpestamped. </span></div>*}
                        {*<div style="display:inline"><a target="_blank" href="https://app.originstamp.org/s/{$log.origin_sha256|escape}">LINK</a></div></td>*}
                    {*{else} <td style="color:orange;font-weight: bold;" align=center><div style="display:inline" class="tooltip">&#10003;<span class="tooltiptext">*}
				{*Originstamp status: < 3. The log entry will be successfully timestamped in less than 24 hours. </span></div>*}
                        {*<div style="display:inline"><a target="_blank" style='color:orange' href="https://app.originstamp.org/s/{$log.origin_sha256|escape}">LINK</a></div></td>{/if}*}
                {*{/if}*}

                {if $log.origin_sha256 != ''}
                    {if $log.originstamp_status eq 3}
                        <td align=left>
                            <div class="timestampbox success" data-balloon=" Originstamp Status: 3. The download entry is successfully timpestamped."
                            data-balloon-pos="left">
                                The download entry is successfully timestamped.
                            </div>
                            <div width="100%" class="timestampbox">
                                <a target="_blank" href="https://app.originstamp.org/s/{$log.origin_sha256|escape}">
                                <img height="10em" src="/ojs/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
                            </div>
                            <div class="timestampbox" data-balloon="Download the zip-file with the original timestamped string and an offline verifier tool."
                            data-balloon-pos="left">
                                <a href="{url op="downloadOriginZipLogin" path=$log.index}">
                                <img height="10em" src="/ojs/templates/images/cryptImages/zipLogo.svg"> download verifier zip</a>
                            </div>
                        </td>
                    {else}
                        <td align=left>
                            <div class="timestampbox pending" data-balloon="
                            Originstamp status: < 3. The download entry will be successfully timestamped in less than 24 hours.
                            After it's timestamped you can download a zip-file with the original timestamped string and all information you need for manual verification."
                            data-balloon-pos="left">
                                The login entry will be timestamped in less than 24 h.
                            </div>
                            <div class="timestampbox">
                                <a target="_blank" href="https://app.originstamp.org/s/{$log.origin_sha256|escape}"><img height="10em" src="/ojs/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
                            </div>
                        </td>
                    {/if}
                {/if}



            </tr>
            <tr>
                <td colspan="8" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
            </tr>
        {/foreach}
    </table>
</div>

