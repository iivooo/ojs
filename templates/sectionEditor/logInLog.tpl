{**
 * templates/sectionEditor/logInLog.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show user logins with corresponding originstamp.org timestampstatus of login string
 * as part of the CryptSubmit framework
 *
 *}
<link rel="stylesheet" type="text/css" href="{$baseUrl}/styles/originstamper.css">
<link rel="stylesheet" type="text/css" href="{$baseUrl}/styles/balloon.css">
<div style="border-bottom: 2px dotted #000; margin-top:6px;"></div>
<div style="margin-top:10px"></div>
<div style = 	"background-color:lightblue;
				 /*border:2px black solid;*/
                 padding:15px;
                 z-index: 3;
                ">
        On this page you see the login log. All logins are logged with user-data such as ip, username, name etc.
        There is a link to <a href="https://app.originstamp.org/">originstamp.org</a> to each entry and a
        downloadable zip-file with the original timestamped string along with an offline verifier.<br>
        The timestamped login's along with the download log's and the articles may help to reveal users which violated copyrights.
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
</div>
<div id="submissions LogInLog" style="height: 75vh; overflow-x: scroll; overflow-y: scroll">
    <table width="100%" class="listing">
        <tr><td colspan="7" class="headseparator">&nbsp;</td></tr>
        <tr class="heading" valign="bottom">
            <td width="2.5%">UserID</td>
            <td width="5%">IP Address</td>
            <td width="15%">Timestamp</td>
            <td width="12.5%">Username</td>
            <td width="12.5%">Firstname</td>
            <td width="12.5%">Lastname</td>
            <td width="40%">Originstamp.org status</td>
        </tr>
        <tr><td colspan="7" class="headseparator">&nbsp;</td></tr>

        {foreach from=$logs item=log}

            <tr valign="top"{if $highlightClass} class="{$highlightClass|escape}"{/if}>
                <td>{$log.user_id}</td>
                <td>{$log.ip}</td>
                <td>{$log.timestamp}</td><!--<td><script>document.write(new Date({$log.timestamp}).toUTCString())</script></td>-->
                <td>{$log.username}</td>
                <td>{$log.first_name}</td>
                <td>{$log.last_name}</td>
                {if $log.origin_sha256 != ''}

                {if $log.originstamp_status eq 3}
                    <td align=left>
                        <div class="timestampbox success" data-balloon="Originstamp Status: 3. The login entry is successfully timpestamped."
                        data-balloon-pos="left">
                            The login entry is successfully timestamped.
                        </div>
                        <div width="100%" class="timestampbox">
                            <a target="_blank" href="https://app.originstamp.org/s/{$log.origin_sha256|escape}"><img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
                        </div>
                        <div class="timestampbox" data-balloon="Download the zip-file with the original timestamped string and an offline verifier tool."
                        data-balloon-pos="left">
                            <a href="{url op="downloadOriginZipLogin" path=$log.index}">
                                <img height="10em" src="{$baseUrl}/templates/images/cryptImages/zipLogo.svg"> download verifier zip
                            </a>
                        </div>
                    </td>
                {else}
                    <td align=left>
                        <div class="timestampbox pending" data-balloon="
                                Originstamp status: < 3. The login entry will be successfully timestamped in less than 24 hours.
                                After it's timestamped you can download a zip-file with the original timestamped string and all
                                information you need for manual verification." data-balloon-pos="left">
                            The login entry will be timestamped in less than 24 h.
                        </div>
                        <div class="timestampbox">
                            <a target="_blank" href="https://app.originstamp.org/s/{$log.origin_sha256|escape}"><img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
                        </div>
                    </td>
                {/if}
            {/if}

            </tr>
            <tr>
                <td colspan="7" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
            </tr>
        {/foreach}
    </table>
</div>

