<div class="modal">
    <label for="modal-trigger{$submission->getId()}" class="timestampbox a"
           style="color: #375; text-decoration: underline; width: 100%; display:block"
           data-balloon="Upload to IPFS driven datastorage!"
           data-balloon-pos="left" data-balloon-length="large">
        <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png">
        Upload to StorageUI
    </label>

    <input id="modal-trigger{$submission->getId()}" class="checkbox overlay-toggle" type="checkbox">
    <div class="modal-overlay">
        <label for="modal-trigger{$submission->getId()}" class="o-close"></label>
        <div class="modal-wrap" style="padding: 0%">
            {*<label for="modal-trigger" class="close">&#10006;</label>*}

            {*THE CONTENT*}
            <div class="modal-header">
                {*<span class="close">&times;</span>*}
                <h2>StorageUI Upload</h2>
                <label for="modal-trigger{$submission->getId()}" class="close">&#10006;</label>
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
                <div class="wap" style="margin-bottom: 3px" id="{$submission->getId()}">
                    <div id="responseAlert{$submission->getId()}" class="responseAlert"
                         style="background-color: #ff000b; padding: 5px; visibility: hidden; margin-bottom: 1em ">

                    </div>
                    <input type='checkbox' id="form-switch{$submission->getId()}" class="form-switch">

                    <form id="{$submission->getId()}" class="login-form storform" action="#" method='post'>

                        <input class="usr storinput" name="usr" type="text" placeholder="Username" required>
                        <input class="pwd storinput" name="pwd" type="password" placeholder="Password"
                               required>
                        <input class="storagePath" name="storagePath"
                               value="{url op="uploadToStorageUi" path=$submission->getId()|to_array:$submission->getSubmissionFileId()}"
                               style="display: none">
                        <input class="thisid" name="thisid"
                               value="{$submission->getId()}"
                               style="display:none">
                        <button type="submit" class="storbutton">Upload submission</button>
                        <label for='form-switch{$submission->getId()}'
                               class="storlabel"><span>Register</span></label>
                    </form>
                    <form id="reg{$submission->getId()}" class="register-form storform" action="#"
                          method='post'>
                        <input class="storinput regusr" name="regusr" type="text" placeholder="Username"
                               required>
                        <input class="storinput regpwd1" name="regpwd1" type="password"
                               placeholder="Password"
                               required>
                        <input class="storinput regpwd2" name="regpwd2" type="password"
                               placeholder="Re Password"
                               required>
                        <input class="registerPath" name="registerPath"
                               value="{url op="uploadToStorageUi" path=$submission->getId()|to_array:$submission->getSubmissionFileId()}"
                               style="display: none">
                        <input class="thisid" name="thisid"
                               value="{$submission->getId()}"
                               style="display:none">
                        <button type='submit' class="storbutton">Sign up</button>
                        <label for='form-switch{$submission->getId()}' class="storlabel">Already Member ?
                            Sign In Now..</label>
                    </form>

                </div>
            </div>

            <div class="modal-footer">
                <h2></h2>
            </div>


        </div>
    </div>
</div>