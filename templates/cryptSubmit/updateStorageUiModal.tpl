<div class="modal">
    <label for="modal-trigger-update{$submission->getId()}" class="timestampbox a"
           style="color: #375; text-decoration: underline; width: 100%; display:block">
        <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png">
        Update Storage Supp. Data
    </label>

    <input id="modal-trigger-update{$submission->getId()}" class="checkbox overlay-toggle" type="checkbox">
    <div class="modal-overlay">
        <label for="modal-trigger-update{$submission->getId()}" class="o-close"></label>
        <div class="modal-wrap" style="padding: 0%">
            {*<label for="modal-trigger" class="close">&#10006;</label>*}

            {*THE CONTENT*}
            <div class="modal-header">
                {*<span class="close">&times;</span>*}
                <h2>StorageUI Upload</h2>
                <label for="modal-trigger-update{$submission->getId()}" class="close">&#10006;</label>
            </div>

            <div class="modal-body">
                <div class="descriptions">
                    <p>You can update your submissions files, comments and reviews in StorageUI which is a IPFS based decentralized and
                        persistent storage solution which makes your submission permanently available to the
                        public.</p>
                    <p>You can modify the metadata of your submission on StorageUI directly!</p>
                </div>


                {*alert box*}


                {*login*}
                <div class="wap" style="margin-bottom: 3px" id="update{$submission->getId()}">
                    <div id="responseAlertUpdate{$submission->getId()}" class="responseAlert"
                         style="background-color: #ff000b; padding: 5px; visibility: hidden; margin-bottom: 1em ">
                        <img height="10em" src="{$baseUrl}/templates/images/cryptImages/ipfs.png"><h5>Loading...</h5>

                    </div>
                    <input type='checkbox' id="form-switch-update{$submission->getId()}" class="form-switch">

                    <form id="update{$submission->getId()}" class="login-form-update storform" action="#" method='post'>

                        <input class="usr storinput" name="usr" type="text" placeholder="Username" required>
                        <input class="pwd storinput" name="pwd" type="password" placeholder="Password"
                               required>
                        <input class="storagePath" name="storagePath"
                               value="{url op="updateRevisions" path=$submission->getId()}"
                               style="display: none">
                        <input class="thisid" name="thisid"
                               value="{$submission->getId()}"
                               style="display:none">
                        <button type="submit" class="storbutton">Update Submission Data</button>
                    </form>


                </div>
            </div>

            <div class="modal-footer">
                <h2></h2>
            </div>


        </div>
    </div>
</div>