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
                <td>{$log.timestamp}</td>
                <td>{$log.username}</td>
                <td>{$log.first_name}</td>
                <td>{$log.last_name}</td>
                {if $log.sha256 != ''}
                    {if $log.originstampStatus eq 3} <td style="color:green;font-weight: bold;" align=center><div style="display:inline" class="tooltip">
                            <a style="color:green" target="_blank" href="{url op="downloadOriginZipLogin" path=$log.index}">&#10003;</a><span class="tooltiptext">
				Originstamp Status: 3. The log entry is successfully timpestamped. By clicking you can download a zip-file with all
                            necessary information for manual verification.</span></div>
                    <div style="display:inline"><a target="_blank" href="https://app.originstamp.org/s/{$log.sha256|escape}">LINK</a></div></td>
                {else} <td style="color:orange;font-weight: bold;" align=center><div style="display:inline" class="tooltip">&#10003;<span class="tooltiptext">
				Originstamp status: < 3. The log entry will be successfully timestamped in less than 24 hours. Later you can download by clicking a zip file with all
                            necessary information for manual verification.</span></div>
                    <div style="display:inline"><a target="_blank" style='color:orange' href="https://app.originstamp.org/s/{$log.sha256|escape}">LINK</a></div></td>{/if}
                {/if}
            </tr>
            <tr>
                <td colspan="7" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
            </tr>
        {/foreach}
    </table>
</div>

