{**
 * templates/author/submission/management.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the author's submission management table.
 *
 *}
<link rel="stylesheet" type="text/css" href="{$baseUrl}/styles/originstamper.css">
<link rel="stylesheet" type="text/css" href="{$baseUrl}/styles/balloon.css">
<div id="submission">
    <h3>{translate key="article.submission"}</h3>
    <table width="100%" class="data">
        <tr valign="top">
            <td width="20%" class="label">{translate key="article.authors"}</td>
            <td width="80%" colspan="2" class="data">{$submission->getAuthorString(false)|escape}</td>
        </tr>
        <tr valign="top">
            <td width="20%" class="label">{translate key="article.title"}</td>
            <td width="80%" colspan="2" class="data">{$submission->getLocalizedTitle()|strip_unsafe_html}</td>
        </tr>
        <tr valign="top">
            <td width="20%" class="label">{translate key="submission.originalFile"}</td>
            <td width="80%" colspan="2" class="data">
                {if $submissionFile}
                    <a href="{url op="downloadFile" path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}"
                       class="file">{$submissionFile->getFileName()|escape}</a>
                    &nbsp;&nbsp;{$submissionFile->getDateModified()|date_format:$dateFormatShort}
                {else}
                    {translate key="common.none"}
                {/if}
            </td>
        </tr>
        <tr valign="top">
            <td class="label">{translate key="article.suppFilesAbbrev"}</td>
            <td width="60%" class="value">
                {foreach name="suppFiles" from=$suppFiles item=suppFile}
                    <div>
                        <a href="{if $submission->getStatus() != STATUS_PUBLISHED && $submission->getStatus() != STATUS_ARCHIVED}{url op="editSuppFile" path=$submission->getId()|to_array:$suppFile->getId()}{else}{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId()}{/if}"
                           class="file">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;
                        {$suppFile->getDateModified()|date_format:$dateFormatShort}
                        {if empty($suppFile->getIpfsHash()) && $suppFile->getFileId() != 0}
                            {*@cryptSubmit storageUI must fire label here for the divs inserted at the bottom for css reasons*}
                            <label for="modal-trigger{$suppFile->getFileId()}" class="a"
                                   style="color: #375; text-decoration: underline; "
                                   data-balloon="Upload to IPFS driven datastorage!"
                                   data-balloon-pos="right" data-balloon-length="large">
                                <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png">
                                Upload to StorageUI
                            </label>
                        {*else show status    *}
                        {elseif $suppFile->getFileId() != 0}
                        <input type="checkbox" class="toggle" id="toggle{$suppFile->getIpfsHash()}"/>
                        <label for="toggle{$suppFile->getIpfsHash()}" style="display: inline-block;">

                            <div class="a" data-balloon="Your file is successfully uploaded to StorageUI, click
to see more options."
                                 data-balloon-pos="right" data-balloon-length="large" style="display: inline-block;">
                                <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png">
                                <span class="changeArrow arrow-up">↑</span>
                                <span class="changeArrow arrow-dn">↓</span>
                                Successfully uploaded to StorageUI
                            </div>
                        </label>
                        <div class="fieldsetContainer">
                            <div class="timestampbox" style="display: inline-block;">
                                <a target="_blank" href="https://ipfs.io/ipfs/{$suppFile->getIpfsHash()|escape}">
                                    <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"> link to
                                    ipfs.io</a>
                            </div>

                            <div class="timestampbox" style="display: inline-block;">
                                <a target="_blank" href="http://192.52.3.143:3000/">
                                    <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"> link to
                                    StorageUI</a>
                            </div>
                        </div>
                    </div>

                        {/if}
                    </div>
                    <br/>
                    {*{include file="cryptSubmit/uploadAdditionalDataToStorageUi.tpl"}*}


                    {foreachelse}
                    {translate key="common.none"}
                {/foreach}
            </td>

            <td width="40%" class="value">
                {if $submission->getStatus() != STATUS_PUBLISHED && $submission->getStatus() != STATUS_ARCHIVED}
                    <a href="{url op="addSuppFile" path=$submission->getId()}"
                       class="action">{translate key="submission.addSuppFile"}</a>
                {else}
                    &nbsp;
                {/if}
            </td>

        </tr>


        <tr>
            <td class="label">{translate key="submission.submitter"}</td>
            <td colspan="2" class="value">
                {assign var="submitter" value=$submission->getUser()}
                {assign var=emailString value=$submitter->getFullName()|concat:" <":$submitter->getEmail():">"}
                {url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
                {$submitter->getFullName()|escape} {icon name="mail" url=$url}
            </td>
        </tr>
        <tr>
            <td class="label">{translate key="common.dateSubmitted"}</td>
            <td>{$submission->getDateSubmitted()|date_format:$datetimeFormatLong}</td>
        </tr>
        <tr valign="top">
            <td width="20%" class="label">{translate key="section.section"}</td>
            <td width="80%" colspan="2" class="data">{$submission->getSectionTitle()|escape}</td>
        </tr>
        <tr valign="top">
            <td width="20%" class="label">{translate key="user.role.editor"}</td>
            {assign var="editAssignments" value=$submission->getEditAssignments()}
            <td width="80%" colspan="2" class="data">
                {foreach from=$editAssignments item=editAssignment}
                    {assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
                    {url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$currentUrl subject=$submission->getLocalizedTitle()|strip_tags articleId=$submission->getId()}
                    {$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
                    {if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
                        {if $editAssignment->getCanEdit()}
                            ({translate key="submission.editing"})
                        {else}
                            ({translate key="submission.review"})
                        {/if}
                    {/if}
                    <br/>
                    {foreachelse}
                    {translate key="common.noneAssigned"}
                {/foreach}
            </td>
        </tr>
        {if $submission->getCommentsToEditor()}
            <tr valign="top">
                <td width="20%" class="label">{translate key="article.commentsToEditor"}</td>
                <td width="80%" colspan="2"
                    class="data">{$submission->getCommentsToEditor()|strip_unsafe_html|nl2br}</td>
            </tr>
        {/if}
        {if $publishedArticle}
            <tr>
                <td class="label">{translate key="submission.abstractViews"}</td>
                <td>{$publishedArticle->getViews()}</td>
            </tr>
        {/if}
    </table>
    {*@cryptSubmit storageUI iterate the divs seperately*}
    {foreach name="suppFiles" from=$suppFiles item=suppFile}
               {include file="cryptSubmit/uploadAdditionalDataToStorageUi.tpl"}
    {/foreach}
</div>


