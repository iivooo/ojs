<link rel="stylesheet" type="text/css" href="{$baseUrl}/styles/originstamper.css">
<link rel="stylesheet" type="text/css" href="{$baseUrl}/styles/balloon.css">
{if $comment->getOriginstampStatus() eq 3}
    <td align=left>
        <div class="timestampbox success" data-balloon="Originstamp Status: 3. The comment is successfully timpestamped." data-balloon-pos="left">
            The download entry is sucessfully timestamped.
        </div>
        <div width="100%" class="timestampbox">
            <a target="_blank" href="https://app.originstamp.org/s/{$comment->getSHA256()|escape}"><img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to originstamp.org</a>
        </div>
        <div class="timestampbox" data-balloon="Download the zip-file with the original timestamped string and an offline verifier tool."
             data-balloon-pos="left" data-balloon-length="large">
            <a href="{url op="downloadOriginZip" path=$articleId|to_array:$comment->getId()}"><img height="10em" src="{$baseUrl}/templates/images/cryptImages/zipLogo.svg"> download verifier zip</a>
        </div>
    </td>
{else}
    <td align=left>
        <div class="timestampbox pending" data-balloon="
                                        Originstamp status: < 3. The comment entry will be successfully timestamped in less than 24 hours.
                                       After it's timestamped you can download a zip-file with the original timestamped string and all
                                       information you need for manual verification." data-balloon-length="large" data-balloon-pos="left">
            The login entry will be time<wbr>stamped in less than 24h.
        </div>
        <div class="timestampbox">
            <a target="_blank" href="https://app.originstamp.org/s/{$comment->getSHA256()|escape}">
                <img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to originstamp.org
            </a>
        </div>
    </td>
{/if}