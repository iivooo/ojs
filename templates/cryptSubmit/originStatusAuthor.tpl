{if $submission->getOriginstampStatus() eq 3}
    <td align=left>
        <div>
            {*wrap*}
            <input type="checkbox" class="toggle" id="toggle{$submission->getId()}"/>

            <label for="toggle{$submission->getId()}">
                {*wrap*}
                <div class="timestampbox success" data-balloon="Originstamp Status: 3. Your submission is successfully timpestamped. In the articles summary,
        you will find a zip-file with the original file and all information you need for manual verification."
                     data-balloon-pos="left" data-balloon-length="large">
                    <span class="changeArrow arrow-up">↑</span>
                    <span class="changeArrow arrow-dn">↓</span>
                    Your submission is successfully timestamped.
                </div>
                {*wrap*}
            </label>

            {*wrap fieldsetContainer around body*}
            <div class="fieldsetContainer">
                <div class="timestampbox">
                    <a target="_blank" href="https://app.originstamp.org/s/{$sha256|escape}">
                        <img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to
                        originstamp.org</a>
                </div>

                <div class="timestampbox"
                     data-balloon="Download your original file with an offline verifier for your archives."
                     data-balloon-pos="left" data-balloon-length="large">
                    <a href="{url op="downloadOriginstampZipFile" path=$submission->getId()|to_array:$submission->getSubmissionFileId()}"> {*|to_array:$submissionFile->getFileId():$submissionFile->getRevision()*}
                        <img height="10em" src="{$baseUrl}/templates/images/cryptImages/zipLogo.svg"> download verifier
                        zip
                    </a>
                </div>
            </div>
        </div>

        {if empty($submission->getIpfsHash())}
            {include file="cryptSubmit/uploadToStorageUiModal.tpl"}
        {else}
            <input type="checkbox" class="toggle" id="toggle{$submission->getIpfsHash()}"/>
            <label for="toggle{$submission->getIpfsHash()}">
                {*wrap*}
                <div class="timestampbox storageUi" data-balloon="Your file is successfully uploaded to StorageUI, click
to see more options."
                     data-balloon-pos="left" data-balloon-length="large">
                    <span class="changeArrow arrow-up">↑</span>
                    <span class="changeArrow arrow-dn">↓</span>
                    Successfully uploaded to StorageUI
                </div>
                {*wrap*}
            </label>
            {*wrap fieldsetContainer around body*}
            <div class="fieldsetContainer">
                <div class="timestampbox">
                    <a target="_blank" href="https://ipfs.io/ipfs/{$submission->getIpfsHash()|escape}">
                        <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"> link to
                        ipfs.io</a>
                </div>

                <div class="timestampbox">
                    <a target="_blank" href="http://192.52.3.143:3000/">
                        <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"> link to
                        StorageUI</a>
                </div>
                {include file="cryptSubmit/updateStorageUiModal.tpl"}
            </div>

        {/if}
    </td>
{elseif $submission->getOriginstampStatus() eq 0}
    <td align=left>
        <div class="timestampbox nofile" data-balloon="There are no primary files to timestamp uploaded."
             data-balloon-pos="left">
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
            <a target="_blank" class="timestampbox" href="https://app.originstamp.org/s/{$sha256|escape}"><img
                        height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to
                originstamp.org</a>
        </div>
    </td>
{/if}

