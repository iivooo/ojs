<script>
    {literal}
    $(document).ready(function() {
        $("#accordion section h1").click(function(e) {
            $(this).parents().siblings("section").addClass("ac_hidden");
            $(this).parents("section").removeClass("ac_hidden");

            e.preventDefault();
        });
    });
    {/literal}
</script>

<div id="accordion">
    <section id="item1">
       <p class="pointer">&#9654;</p> <a href="#"><h1>Introduction</a></h1>
        <p>
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
        </p>
    </section>
    <section id="item2" class="ac_hidden">
        <p class="pointer">&#9654;</p><h1><a href="#">Login Data</a></h1>
        <p>
            <b>username:</b> author, editor, sectioneditor, reviewer <b>password:</b> 123456
        </p>
    </section>
    <section id="item3" class="ac_hidden">
        <p class="pointer">&#9654;</p><h1><a href="#">Basic workflow overview</a></h1>
        <p>
            <img style="margin-right: 10px; margin-bottom:10px; padding:5px; border: 1px solid lightgray; float:left; max-height:320px;" src="{$baseUrl}/templates/images/cryptImages/crypt_basicWorkflow.svg">
            <p>
                Our prototype is limited to the peer-reviewing process, which includes authors, (section-)editors and reviewers. Let's have a look at the basic workflow:<br>
                The author uploads an academic manuscript (article) and the editor assigns a section editor or himself as a section editor.
                The section editor is now responsible to manage the reviewing process of the manuscript. He assigns one or many reviewers.
                The reviewers then review the manuscript and (depending on the reviewing round) gives recommondations to accept/ decline the manuscript.
                After one or many rounds of reviewing and adjusting the manuscript the section editor/editor decides the publication of the manuscript.
            </p>
        </p>
    </section>
    <section id="item3" class="ac_hidden">
        <p class="pointer">&#9654;</p><h1><a href="#">For authors</a></h1>
        <p>
            <div style="width:100%;overflow-x: auto; overflow-y: hidden">
                <img style="width:100%; min-width: 920px; max-height:540px;" src="{$baseUrl}/templates/images/cryptImages/crypt_author_white.svg">
            </div>
            <br>
            The author is able to upload submissions to the OJS. Before the submission reaches the server, the submission is timestamped
            in the browser with JavaScript. That makes sure that the submission is timestamped as you have it original on the harddisk and
            that it is timestamped before anyone in the OJS can read it. Afterwards authors can see their submissions on the main page with
            their corresponding timestamp status (takes max. up to 24 h before a submission is safely submitted to the bitcoin blockchain).
            Also there is a direct link to <a href="https://app.originstamp.org/">originstamp.org</a> provided, where you also
            can retrace the status of the timestamping process. As the timestamping process is done there is also a
            download link to a zip-file provided, which contains an offline verifier along with your original submission. The offline
            verifier is based on HTML and JavaScript and describes how to manually retrace the address generation for your submission
            in the bitcoin blockchain.
            <br><br>
            Please login on the right side with:<br>
            <b>Username: author</b><br>
            <b>Password: 123456</b>
        </p>
    </section>
    <section id="item3" class="ac_hidden">
        <p class="pointer">&#9654;</p><h1><a href="#">For editors</a></h1>
        <p>
        <div style="width:100%;overflow-x: auto; overflow-y: hidden">
            <img style="width:100%; min-width: 920px; max-height:540px;" src="{$baseUrl}/templates/images/cryptImages/crypt_editor_white.svg">
        </div>
        <br>
        The editor assigns the authors manuscript to a section editor or to himself, who is then responsible to manage
        the reviewing process of the manuscript. If the editor is assigned himself, he can add reviewers to the manuscript.
        The editor has correspondence with comments with reviewers and the author. The editor can afterwards decide wheter
        the article will be published or reject it.
        The comments, logins and manuscript downloads are timestamped.
        <br><br>
        Please login on the right side with:<br>
        <b>Username: editor</b><br>
        <b>Password: 123456</b>
        </p>
    </section>
    <section id="item3" class="ac_hidden">
        <p class="pointer">&#9654;</p><h1><a href="#">For section editors</a></h1>
        <p>
        <div style="width:100%;overflow-x: auto;overflow-y: hidden">
            <img style="width:100%; min-width: 920px; max-height:540px;" src="{$baseUrl}/templates/images/cryptImages/crypt_sectioneditor_white.svg">
        </div>
        <br>
        The section editor can assign reviewers and is able to comment articles to give feedback himself.
        The section editor is afterwards able to publish or reject the article. The comments, logins and downloads are timestamped.<br>
        The section editor sees the download log
        and the login log. In case of copyright violations this might help to identify the originator of the manuscripts
        content.

        <br><br>
        Please login on the right side with:<br>
        <b>Username: sectioneditor</b><br>
        <b>Password: 123456</b>

        </p>
    </section>
    <section id="item3" class="ac_hidden">
        <p class="pointer">&#9654;</p><h1><a href="#">For reviewers</a></h1>
        <p>
        <div style="width:100%;overflow-x: auto; overflow-y: hidden">
            <img style="width:100%; min-width: 920px; max-height:540px;" src="{$baseUrl}/templates/images/cryptImages/crypt_reviewer_white.svg">
        </div>
        <br>
        The reviewer can review(comments) the manuscripts assigned to him. Every comment, login and manuscript download is timestamped.
        <br><br>
        Please login on the right side with:<br>
        <b>Username: reviewer</b><br>
        <b>Password: 123456</b>
        </p>
    </section>
    <section id="item3" class="ac_hidden">
        <p class="pointer">&#9654;</p><h1><a href="#">Technical Background and References</a></h1>
        <p>
            For the theoretical background of the system, please read the following paper:
            <br>
        <ul>
            <li><a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf">
                    <img style="height: 15px;" src="{$baseUrl}/templates/images/cryptImages/Adobe_PDF_Icon.png"></a>
                B. Gipp, C. Breitinger, N. Meuschke, and J. Beel, “CryptSubmit: Introducing Securely Timestamped Manuscript Submission
                and Peer Review Feedback using the Blockchain,” in Proceedings of the ACM/IEEE-CS Joint Conference on Digital Libraries
                (JCDL), Toronto, Canada, 2017.</li>
        </ul>


        </p>
    </section>
    <section id="item3" class="ac_hidden">
        <p class="pointer">&#9654;</p><h1><a href="#">Storage UI - IPFS based storage system</a></h1>
        <p>
            Authors can upload their articles and supplementary data to Storage UI, a storage system prototype based on IPFS (Interplanetary File System), which is a decentralized peer-to-peer storage solution. Storage UI was build to support permanent and immutable data storage to provide long-term availability. A storage system having those two qualities is beneficial for usage in the scientific community, whether by individuals or by research institutions and research facilities. Scientific data which is fundamentally important for scientific work could be stored to be verified at later times without being exposed the danger of loss, deletion or manipulation, thus making the data provable and verifiable at any later point.
            <img style="width:100%" src="{$baseUrl}/templates/images/cryptImages/StorageUiOverview.png">
        </p>
    </section>
</div>