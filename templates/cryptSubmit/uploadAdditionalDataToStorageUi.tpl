{*<td align=left>
    <div>
        *}{*wrap*}{*
        <input type="checkbox" class="toggle" id="toggle{$suppFile->getFileId()}"/>

        <label for="toggle{$suppFile->getFileId()}">
            *}{*wrap*}{*
            <div class="timestampbox success" data-balloon="Originstamp Status: 3. Your submission is successfully timpestamped. In the articles summary,
        you will find a zip-file with the original file and all information you need for manual verification."
                 data-balloon-pos="left" data-balloon-length="large">
                <span class="changeArrow arrow-up">↑</span>
                <span class="changeArrow arrow-dn">↓</span>
                Your submission is successfully timestamped.
            </div>
            *}{*wrap*}{*
        </label>

        *}{*wrap fieldsetContainer around body*}{*
        <div class="fieldsetContainer">
            <div class="timestampbox">
                <a target="_blank" href="https://app.originstamp.org/s/{$sha256|escape}">
                    <img height="10em" src="{$baseUrl}/templates/images/cryptImages/logo.png"> link to
                    originstamp.org</a>
            </div>

            <div class="timestampbox"
                 data-balloon="Download your original file with an offline verifier for your archives."
                 data-balloon-pos="left" data-balloon-length="large">
                <a href="{url op="downloadOriginstampZipFile" path=$suppFile->getFileId()|to_array:$submission->getSubmissionFileId()}"> *}{*|to_array:$submissionFile->getFileId():$submissionFile->getRevision()*}{*
                    <img height="10em" src="{$baseUrl}/templates/images/cryptImages/zipLogo.svg"> download verifier
                    zip
                </a>
            </div>
        </div>
    </div>*}

    {if empty($suppFile->getIpfsHash())}

        <div class="modal">


            <input id="modal-trigger{$suppFile->getFileId()}" class="checkbox overlay-toggle" type="checkbox">
            <div class="modal-overlay">
                <label for="modal-trigger{$suppFile->getFileId()}" class="o-close"></label>
                <div class="modal-wrap" style="padding: 0%">
                    {*<label for="modal-trigger" class="close">&#10006;</label>*}

                    {*THE CONTENT*}
                    <div class="modal-header">
                        {*<span class="close">&times;</span>*}
                        <h2>StorageUI Upload</h2>
                        <label for="modal-trigger{$suppFile->getFileId()}" class="close">&#10006;</label>
                    </div>

                    <div class="modal-body">
                        <div class="descriptions">
                            <p>You can upload your submission to StorageUI which is a IPFS based decentralized and
                                persistent storage solution which makes your submission permanently available to the
                                public.</p>
                            <p>If you have no account on StorageUI please sign up here.</p>
                            <p>Else: please enter your login data and click submit.</p>
                            <p>!!! Please keep in mind that it is currently not possible to delete submissions
                                !!!</p>
                            <p>You can modify the metadata of your submission on StorageUI directly!</p>
                        </div>


                        {*alert box*}


                        {*login*}
                        <div class="wap" style="margin-bottom: 3px" id="{$suppFile->getFileId()}">
                            <div id="responseAlert{$suppFile->getFileId()}" class="responseAlert"
                                 style="background-color: #ff000b; padding: 5px; visibility: hidden; margin-bottom: 1em ">

                            </div>
                            <input type='checkbox' id="form-switch{$suppFile->getFileId()}" class="form-switch">

                            <form id="{$suppFile->getFileId()}" class="login-form-additional storform" action="#" method='post'>

                                <input class="usr storinput" name="usr" type="text" placeholder="Username" required>
                                <input class="pwd storinput" name="pwd" type="password" placeholder="Password"
                                       required>
                                <input class="storagePath" name="storagePath"
                                       value="{url op="uploadAdditionalDataToStorageUi" path=$submission->getId()|to_array:$suppFile->getId()}"
                                       style="display: none">
                                <input class="thisid" name="thisid"
                                       value="{$suppFile->getFileId()}"
                                       style="display:none">
                                <button type="submit" class="storbutton">Upload submission</button>
                                <label for='form-switch{$suppFile->getFileId()}' class="storlabel"><span>Register</span></label>
                            </form>
                            <form id="reg{$suppFile->getFileId()}" class="register-form storform" action="#" method='post'>
                                <input class="storinput regusr" name="regusr" type="text" placeholder="Username"
                                       required>
                                <input class="storinput regpwd1" name="regpwd1" type="password"
                                       placeholder="Password"
                                       required>
                                <input class="storinput regpwd2" name="regpwd2" type="password"
                                       placeholder="Re Password"
                                       required>
                                <input class="registerPath" name="registerPath"
                                       value="{url op="uploadToStorageUi" path=$suppFile->getFileId()|to_array:$submission->getSubmissionFileId()}"
                                       style="display: none">
                                <input class="thisid" name="thisid"
                                       value="{$suppFile->getFileId()}"
                                       style="display:none">
                                <button type='submit' class="storbutton">Sign up</button>
                                <label for='form-switch{$suppFile->getFileId()}' class="storlabel">Already Member ? Sign In Now..</label>
                            </form>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <h2></h2>
                    </div>


                </div>
            </div>
        </div>
{*
    {else}
        <input type="checkbox" class="toggle" id="toggle{$suppFile->getIpfsHash()}"/>
        <label for="toggle{$suppFile->getIpfsHash()}">
            wrap
            <div class="timestampbox storageUi" data-balloon="Your file is successfully uploaded to StorageUI, click
to see more options."
                 data-balloon-pos="left" data-balloon-length="large">
                <span class="changeArrow arrow-up">↑</span>
                <span class="changeArrow arrow-dn">↓</span>
                Successfully uploaded to StorageUI
            </div>
            wrap
        </label>
        wrap fieldsetContainer around body
        <div class="fieldsetContainer">
            <div class="timestampbox">
                <a target="_blank" href="https://ipfs.io/ipfs/{$suppFile->getIpfsHash()|escape}">
                    <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"> link to
                    ipfs.io</a>
            </div>

            <div class="timestampbox">
                <a target="_blank" href="http://192.52.3.143:3000/">
                    <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"> link to
                    StorageUI</a>
            </div>
        </div>
        </div>

        <a target="_blank" href="https://ipfs.io/ipfs/{$suppFile->getIpfsHash()}">
            <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"> link to
            ipfs.io</a>
        <a target="_blank" href="http://192.52.3.143:3000/">
            <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"> link to
            StorageUI</a>
*}


    {/if}