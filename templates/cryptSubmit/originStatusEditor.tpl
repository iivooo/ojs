<link rel="stylesheet" type="text/css" href="{$baseUrl}/styles/originstamper.css">
<link rel="stylesheet" type="text/css" href="{$baseUrl}/styles/balloon.css">
{if $submission->getOriginstampStatus() eq 3}
    <td align=left>
        <div class="timestampbox success" data-balloon="Originstamp Status: 3. The submission is successfully timpestamped."
             data-balloon-pos="left" data-balloon-length="large">
            The submission is successfully timestamped.
        </div>
        <div class="timestampbox">
            <a target="_blank" href="https://app.originstamp.org/s/{$submission->getSHA256()|escape}">
                <img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
        </div>
        <div class="timestampbox" data-balloon="Download your original file with an offline verifier for your archives."
             data-balloon-pos="left" data-balloon-length="large">
            <a href="{url op="downloadOriginstampZipFile" path=$submission->getId()|to_array:$submission->getSubmissionFileId()}"> {*|to_array:$submissionFile->getFileId():$submissionFile->getRevision()*}
                <img height="10em" src="{$baseUrl}/templates/images/cryptImages/zipLogo.svg"> download verifier zip
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
        <div class=" timestampbox pending" data-balloon="Originstamp status: < 3. The submission will be successfully timestamped in less than 24 hours.
            The filehash is already published at twitter."
             data-balloon-pos="left">
            The file will be timestamped in less than 24 h.
        </div>
        <div>
            <a target="_blank" class="timestampbox" href="https://app.originstamp.org/s/{$submission->getSHA256()|escape}"><img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
        </div>
    </td>
{/if}