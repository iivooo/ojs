{*<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">*}
{*<script src="https://code.jquery.com/jquery-1.12.4.js"></script>*}
{*<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>*}


<div id="accordion">
    <h3>Introduction</h3>
    <div>

            This prototype shows a possible implementation of <a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf">
                <img style="height: 15px;" src="{$baseUrl}/templates/images/cryptImages/Adobe_PDF_Icon.png">CryptSubmit</a> in an existing system.<br><br>
            The paper describes a fully automated trusted timestamping framework, that makes use of <a href="https://app.originstamp.org/">OriginStamp</a>.
            OriginStamp is a free trusted timestamping solution based on the blockchain of Bitcoin.
            The Open Journal Systems (OJS) is a popular open-source publishing system, which we extended with fully automatized trusted timestamping.
            CryptSubmit tracks and verifies the time of submission of digital content such as academic manuscripts (PDF, Word, ..) and others.
            In our case, we also timestamp system events, such as: logins, download times and user-interaction (comments, reviews).
            The trusted timestamps can help you afterwards to prove, that you are the originator of your published content, e.g. in case of copyright-violation of other users.
            The trusted timestamps in the system are shown to the user and can be downloaded as a zip-file with the original content for the own archives.
            The zip-file also includes an offline verifier, which describes how to retrace the bitcoin address generation for the timestamped content.
            Thanks to the <a href="https://app.originstamp.org/dev">OriginStamp-API</a>, all these features take almost no additional overhead.
            <br><br>
            For further information about the usage of this system or technical backgrounds please visit the about page.
            Or just try out the prototype:

    </div>
    <h3>Basic workflow of this prototype</h3>
    <div>
        <p>
            Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
            purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
            velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
            suscipit faucibus urna.
        </p>
    </div>
    <h3>Author information and login data</h3>
    <div>
        <p>
            <div style="width:100%;overflow-x: auto; overflow-y: hidden">
                <img style="width:100%; min-width: 920px; max-height:540px;" src="{$baseUrl}/templates/images/cryptImages/cryptSubmitOJS_author_2.svg">
            </div>
            <br>
            The author is able to upload submissions to the OJS. Before the submission reaches the server, the submission is timestamped
            in the browser with JavaScript. That makes sure that the submission is timestamped as you have it original on the harddisk and
            that it is timestamped before anyone in the OJS can read it. Afterwards authors can see their submissions on the main page with
            their corresponding timestamp status (takes max. up to 24 h before a submission is safely submitted to the bitcoin blockchain).
            Also there is a direct link to <a href="https://app.originstamp.org/">originstamp.org</a> provided, where you also
            can retrace the status of the timestamping process. As the timestamping process is done you can find at the bottom of the submissions
            summary a download link to a zip-file which contains an offline verifier along with your original submission. The offline
            verifier is based on HTML and JavaScript and describes how to manually retrace the address generation for your submission
            in the bitcoin blockchain.
            <br><br>
            Please login on the right side with:<br>
            <b>Username: author</b><br>
            <b>Password: 123456</b><br><br>
            <br>
        </p>
    </div>
    <h3>Section editor information and login data</h3>
    <div>
        <p>
            <div style="width:100%;overflow-x: auto;overflow-y: hidden">
                <img style="width:100%; min-width: 920px; max-height:540px;" src="{$baseUrl}/templates/images/cryptImages/cryptSubmitOJS_sectioneditor_2.svg">
            </div>
            <br>
            The section editor is able to comment articles to give feedback. The comments are automatically timestamped by the system.
            At the right side of the comments you can find the timestamping status and a direct link to <a href="https://app.originstamp.org/">originstamp.org</a>.
            By clicking the status tick you can download a zip-file with an offline verifier along with the original timestamped text file.
            The offline verifier is based on HTML and JavaScript and describes how to manually retrace the address generation for the timestamped
            text in the bitcoin blockchain. The same functionality applies to the download times to see who downloaded which file and the login times of each user.
            <br><br>
            Please login on the right side with:<br>
            <b>Username: sectioneditor</b><br>
            <b>Password: 123456</b><br><br>
            <br>
        </p>
    </div>
</div>





{*<div>*}
    {*The Open Journal System is an open-source publishing system. We extended it with fully automatized*}
    {*<div width="100%">*}
        {*<img class="img-centered" src="{$baseUrl}/templates/images/cryptImages/logo.png">*}
    {*</div>*}
{*</div>*}