{if $submission->getOriginstampStatus() eq 3}
    <td align=left>
        <div class="timestampbox success" data-balloon="Originstamp Status: 3. Your submission is successfully timpestamped. In the articles summary,
        you will find a zip-file with the original file and all information you need for manual verification."
        data-balloon-pos="left" data-balloon-length="large">
            Your submission is successfully timestamped.
        </div>
        <div class="timestampbox">
            <a target="_blank" href="https://app.originstamp.org/s/{$sha256|escape}">
            <img height="10em" src="/ojs/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
        </div>
        <div class="timestampbox">
            <a href="{url op="downloadOriginstampZipFile" path=$submission->getId()|to_array:$submission->getSubmissionFileId()}"> {*|to_array:$submissionFile->getFileId():$submissionFile->getRevision()*}
                <img height="10em" src="/ojs/templates/images/cryptImages/zipLogo.svg"> download verifier zip
            </a>
        </div>
    </td>
{elseif $submission->getOriginstampStatus() eq 0}
    <td align=left>
        <div class="timestampbox nofile" data-balloon="There are no primary files to timestamp uploaded." data-balloon-pos="left">
            No primary file to timestamp.
        </div>
    </td>
{else}
    <td align=left>
        <div class=" timestampbox pending" data-balloon="Originstamp status: < 3. Your submission will be successfully timestamped in less than 24 hours.
        After it's timestamped, n the articles summary, you will find a zip-file with the original file and all information you need for manual verification."
        data-balloon-pos="left">
            Your file will be timestamped in less than 24 h.
        </div>
        <div>
            <a target="_blank" class="timestampbox" href="https://app.originstamp.org/s/{$sha256|escape}"><img height="10em" src="/ojs/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
        </div>
    </td>
{/if}