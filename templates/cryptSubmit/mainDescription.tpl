<!--@cryptSubmit-->
<div style = 	"background-color:lightblue;
				 /*border:2px black solid;*/
                 padding: 15px">
    This prototype shows a possible implementation of <a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf">
        <img style="height: 15px;" src="/ojs/templates/images/cryptImages/Adobe_PDF_Icon.png">CryptSubmit</a> in an existing system.<br><br>
    The paper describes a fully automated trusted timestamping framework, that makes use of <a href="https://app.originstamp.org/">OriginStamp</a>.
    OriginStamp is a free trusted timestamping solution based on the blockchain of Bitcoin.
    The Open Journal Systems (OJS) is a popular open-source publishing system, which we extended with fully automatized trusted timestamping.
    CryptSubmit tracks and verifies the time of submission of digital content such as articles (PDF, Word, ..) and others.
    In our case, we timestamp academic manuscripts submitted for peer-review and system events, such as: logins, download times and user-interaction (comments).
    The trusted timestamps can help you afterwards to prove, that you are the originator of your published content, e.g. in case of copyright-violation of other users.
    The trusted timestamps in the system are shown to the user and can be downloaded as a zip-file with the original content for the own archives.
    The zip-file also includes an offline verifier, which describes how to retrace the bitcoin address generation for the timestamped content.
    Thanks to the <a href="https://app.originstamp.org/dev">OriginStamp-API</a>, all these features take almost no additional overhead.
    <br><br>
    For further information about the usage of this system or technical backgrounds please visit the about page.
    Or just try out the prototype:
    <br><br>

    {*<div style="border: 1px;">*}
        {*<b>Quick note on trusted timestamping: </b>*}
        {*Trusted timestamping of digital content means that the content has existed at a certain time in a specific form.*}

        {*For example, if you have written an article and you export it to pdf. As soon as you timestamp it, you have a*}
        {*proof that this document existed at this time and with its content. If someone publishes your content, it*}
        {*helps you to proof afterwards that you are the originator of your content at an earlier time. This works with an unique fingerprint (hash) of your document*}
        {*that is submitted to the blockchain.*}
        {*So you must not alter your document for a specific timestamp. For technical details please visit <a href="https://app.originstamp.org/">originstamp.org</a>*}
        {*or read <a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf"><img style="height: 15px;" src="/ojs/templates/images/cryptImages/Adobe_PDF_Icon.png">CryptSubmit</a> paper.*}
    {*</div>*}
    {*<br>*}
    {*Let’s have a look at the functionality of this prototype:<br> <br>*}
    <b>For authors:</b><br>
    <br><br>
    <div style="width:100%;overflow-x: auto; overflow-y: hidden">
        <img style="width:100%; min-width: 920px; max-height:540px;" src="/ojs/templates/images/cryptImages/cryptSubmitOJS_author_2.svg">
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
    <br>

    {*<ol>*}
        {*<li>Timestamping submissions client-side with <a href="https://app.originstamp.org/">orginstamp.org</a> before uploaded.</li>*}
        {*<li>Show the actual <a href="https://app.originstamp.org/home">orginstamp.org</a> timestamping-status in the summary.</li>*}
        {*<li>Within a submissions summary a zip is downloadable with the original file and an offline verifier, which provides a link to*}
            {*<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>*}
        {*<div>*}
            <br>
            Please login on the right side with:<br>
            <b>Username: author</b><br>
            <b>Password: 123456</b><br><br>
        {*</div>*}
    {*</ol>*}
    <br>
    <b>For section editors:</b>
    <div style="width:100%;overflow-x: auto;overflow-y: hidden">
        <img style="width:100%; min-width: 920px; max-height:540px;" src="/ojs/templates/images/cryptImages/cryptSubmitOJS_sectioneditor_2.svg">
    </div>
    <br>
    The section editor is able to comment articles to give feedback. The comments are automatically timestamped by the system.
    At the right side of the comments you can find the timestamping status and a direct link to <a href="https://app.originstamp.org/">originstamp.org</a>.
    By clicking the status tick you can download a zip-file with an offline verifier along with the original timestamped text file.
    The offline verifier is based on HTML and JavaScript and describes how to manually retrace the address generation for the timestamped
    text in the bitcoin blockchain. The same functionality applies to the download times to see who downloaded which file and the login times of each user.
    {*<ol>*}
        {*<li>Comments are timestamped with ip-address, name etc.</li>*}
        {*<li>Downloads are timestamped (e.g. if a reviewer or author downloads an article) with ip-address, name etc.</li>*}
        {*<li>Login's are timestamped with ip-address, name etc.</li>*}
        {*<li>For all timestampings there is a status (with clickable link to originstamp.org) as well..</li>*}
        {*<li>.. as a zip is downloadable with the original file and an offline verifier, which provides a link to*}
            {*<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>*}
        {*<div>*}
            <br><br>
            Please login on the right side with:<br>
            <b>Username: sectioneditor</b><br>
            <b>Password: 123456</b><br><br>
        {*</div>*}
    {*</ol>*}
    <br><br>
    <b>Publications:</b>
    <br>
    <ul>
    <li><a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf">
        <img style="height: 15px;" src="/ojs/templates/images/cryptImages/Adobe_PDF_Icon.png"></a>
    B. Gipp, C. Breitinger, N. Meuschke, and J. Beel, “CryptSubmit: Introducing Securely Timestamped Manuscript Submission
    and Peer Review Feedback using the Blockchain,” in Proceedings of the ACM/IEEE-CS Joint Conference on Digital Libraries
    (JCDL), Toronto, Canada, 2017.</li>
    </ul>



</div>