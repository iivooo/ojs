{if $submission->getOriginstampStatus() eq 3}
    <td align=left>
        <div class="tooltip timestampbox success">Your submission is sucessfully timestamped.<span class="tooltiptext">
                Originstamp Status: 3. Your submission is successfully timpestamped. In the articles summary,
                you will find a zip-file with the original file and all information you need for manual verification. </span>
        </div>
        <div class="boxx1">
            <a target="_blank" href="https://app.originstamp.org/s/{$sha256|escape}"><img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
        </div>
    </td>
{elseif $submission->getOriginstampStatus() eq 0}
    <td align=left>
        <div class="tooltip timestampbox nofile">No primary file to timestamp.<span class="tooltiptext">
                There are no primary files to timestamp uploaded. </span>
        </div>
    </td>
{else}
    <td align=left>
        <div class="tooltip timestampbox pending" '>Your file will be timestamped in less than 24 h.<span class="tooltiptext">
				Originstamp status: < 3. Your submission will be successfully timestamped in less than 24 hours.
                After it's timestamped, n the articles summary, you will find a zip-file with the original file and all information you need for manual verification. </span>
        </div>
        <div>
            <a target="_blank" class="timestampbox" href="https://app.originstamp.org/s/{$sha256|escape}">LINK</a>
        </div>
    </td>
{/if}