<!--@cryptSubmit-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
{*<div style = 	"background-color:lightblue;*}
				 {*/*border:2px black solid;*/*}
                 {*padding: 15px">*}
    {*This prototype shows a possible implementation of <a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf">*}
        {*<img style="height: 15px;" src="{$baseUrl}/templates/images/cryptImages/Adobe_PDF_Icon.png">CryptSubmit</a> in an existing system.<br><br>*}
    {*The paper describes a fully automated trusted timestamping framework, that makes use of <a href="https://app.originstamp.org/">OriginStamp</a>.*}
    {*OriginStamp is a free trusted timestamping solution based on the blockchain of Bitcoin.*}
    {*The Open Journal Systems (OJS) is a popular open-source publishing system, which we extended with fully automatized trusted timestamping.*}
    {*CryptSubmit tracks and verifies the time of submission of digital content such as academic manuscripts (PDF, Word, ..) and others.*}
    {*In our case, we also timestamp system events, such as: logins, download times and user-interaction (comments, reviews).*}
    {*The trusted timestamps can help you afterwards to prove, that you are the originator of your published content, e.g. in case of copyright-violation of other users.*}
    {*The trusted timestamps in the system are shown to the user and can be downloaded as a zip-file with the original content for the own archives.*}
    {*The zip-file also includes an offline verifier, which describes how to retrace the bitcoin address generation for the timestamped content.*}
    {*Thanks to the <a href="https://app.originstamp.org/dev">OriginStamp-API</a>, all these features take almost no additional overhead.*}
    {*<br><br>*}
    {*For further information about the usage of this system or technical backgrounds please visit the about page.*}
    {*Or just try out the prototype:*}
    {*<br><br>*}


    {*<div class="toggleBox">*}
        {*<input name="toggleContent" id="toggleContent" type="checkbox" checked="checked">*}
        {*<label for="toggleContent" class="open"><h5>Basic workflow in our prototype </h5></label>*}
        {*<label for="toggleContent" class="close"><h5>Basic workflow in our prototype </h5></label>*}
        {*<div>*}

        {*</div>*}
    {*</div>*}

    {*<div class="toggleBox">*}
        {*<input name="toggleContent" id="toggleContent" type="checkbox" checked="checked">*}
        {*<label for="toggleContent" class="open"><h5>Author information and login data.</h5></label>*}
        {*<label for="toggleContent" class="close"><h5>Author information and login data.</h5></label>*}
        {*<div>*}
            {*<div style="width:100%;overflow-x: auto; overflow-y: hidden">*}
                {*<img style="width:100%; min-width: 920px; max-height:540px;" src="{$baseUrl}/templates/images/cryptImages/cryptSubmitOJS_author_2.svg">*}
            {*</div>*}
            {*<br>*}
            {*The author is able to upload submissions to the OJS. Before the submission reaches the server, the submission is timestamped*}
            {*in the browser with JavaScript. That makes sure that the submission is timestamped as you have it original on the harddisk and*}
            {*that it is timestamped before anyone in the OJS can read it. Afterwards authors can see their submissions on the main page with*}
            {*their corresponding timestamp status (takes max. up to 24 h before a submission is safely submitted to the bitcoin blockchain).*}
            {*Also there is a direct link to <a href="https://app.originstamp.org/">originstamp.org</a> provided, where you also*}
            {*can retrace the status of the timestamping process. As the timestamping process is done you can find at the bottom of the submissions*}
            {*summary a download link to a zip-file which contains an offline verifier along with your original submission. The offline*}
            {*verifier is based on HTML and JavaScript and describes how to manually retrace the address generation for your submission*}
            {*in the bitcoin blockchain.*}
            {*<br><br>*}
            {*Please login on the right side with:<br>*}
            {*<b>Username: author</b><br>*}
            {*<b>Password: 123456</b><br><br>*}
            {*<br>*}
        {*</div>*}
    {*</div>*}

    {*<div class="toggleBox">*}
        {*<input name="toggleContent" id="toggleContent" type="checkbox" checked="checked">*}
        {*<label for="toggleContent" class="open"><h5>Section editor information and login data.</h5></label>*}
        {*<label for="toggleContent" class="close"><h5>Section editor information and login data.</h5></label>*}
        {*<div>*}
            {*<div style="width:100%;overflow-x: auto;overflow-y: hidden">*}
                {*<img style="width:100%; min-width: 920px; max-height:540px;" src="{$baseUrl}/templates/images/cryptImages/cryptSubmitOJS_sectioneditor_2.svg">*}
            {*</div>*}
            {*<br>*}
            {*The section editor is able to comment articles to give feedback. The comments are automatically timestamped by the system.*}
            {*At the right side of the comments you can find the timestamping status and a direct link to <a href="https://app.originstamp.org/">originstamp.org</a>.*}
            {*By clicking the status tick you can download a zip-file with an offline verifier along with the original timestamped text file.*}
            {*The offline verifier is based on HTML and JavaScript and describes how to manually retrace the address generation for the timestamped*}
            {*text in the bitcoin blockchain. The same functionality applies to the download times to see who downloaded which file and the login times of each user.*}
            {*<br><br>*}
            {*Please login on the right side with:<br>*}
            {*<b>Username: sectioneditor</b><br>*}
            {*<b>Password: 123456</b><br><br>*}
            {*<br>*}
        {*</div>*}
    {*</div>*}




    {*<b>Publications:</b>*}
    <br>
    <ul>
    <li><a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf">
        <img style="height: 15px;" src="{$baseUrl}/templates/images/cryptImages/Adobe_PDF_Icon.png"></a>
    B. Gipp, C. Breitinger, N. Meuschke, and J. Beel, “CryptSubmit: Introducing Securely Timestamped Manuscript Submission
    and Peer Review Feedback using the Blockchain,” in Proceedings of the ACM/IEEE-CS Joint Conference on Digital Libraries
    (JCDL), Toronto, Canada, 2017.</li>
    </ul>
    <div class="panel-group" id="accordion">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">
                        Introduction</a>
                </h4>
            </div>
            <div id="collapse1" class="panel-collapse collapse in">
                <div class="panel-body">
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
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
                        Basic workflow of this prototype</a>
                </h4>
            </div>
            <div id="collapse2" class="panel-collapse collapse">
                <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit,
                    sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
                    minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
                    commodo consequat.</div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">
                        Author information and login data</a>
                </h4>
            </div>
            <div id="collapse3" class="panel-collapse collapse">
                <div class="panel-body">
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
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse4">
                        Section editor information and login data</a>
                </h4>
            </div>
            <div id="collapse3" class="panel-collapse collapse">
                <div class="panel-body">
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
                </div>
            </div>
        </div>
    </div>



{*</div>*}