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
<div style="border-bottom: 2px dotted #000; margin-top:6px;"></div>
<div style="margin-top:10px"></div>
<div style = 	"background-color:lightblue;
				 /*border:2px black solid;*/
                 padding:15px;">
    On this page you see the login log. All logins are logged with user-data such as ip, username, name etc.
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
<div id="LogInLog" style="height: 75vh; overflow-x: scroll; overflow-y: scroll">
    <table width="100%" class="listing">
        <tr><td colspan="7" class="headseparator">&nbsp;</td></tr>
        <tr class="heading" valign="bottom">
            <td width="5%">UserID</td>
            <td width="5%">IP Address</td>
            <td width="20%">Timestamp</td>
            <td width="15%">Username</td>
            <td width="15%">Firstname</td>
            <td width="15%">Lastname</td>
            <td width="5%">Originstamp.org status</td>
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
                    {if $log.originstamp_status eq 3} <td style="color:green;font-weight: bold;" align=center><div style="display:inline" class="tooltip">
                            <a style="color:green" target="_blank" href="{url op="downloadOriginZipLogin" path=$log.index}">&#10003;</a><span class="tooltiptext">
				Originstamp Status: 3. The log entry is successfully timpestamped. By clicking you can download a zip-file with all
                            necessary information for manual verification.</span></div>
                    <div style="display:inline"><a target="_blank" href="https://app.originstamp.org/s/{$log.origin_sha256|escape}">LINK</a></div></td>
                {else} <td style="color:orange;font-weight: bold;" align=center><div style="display:inline" class="tooltip">&#10003;<span class="tooltiptext">
				Originstamp status: < 3. The log entry will be successfully origin_timestamped in less than 24 hours. Later you can download by clicking a zip file with all
                            necessary information for manual verification.</span></div>
                    <div style="display:inline"><a target="_blank" style='color:orange' href="https://app.originstamp.org/s/{$log.origin_sha256|escape}">LINK</a></div></td>{/if}
                {/if}
            </tr>
            <tr>
                <td colspan="7" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
            </tr>
        {/foreach}
    </table>
</div>

