USE ojsInstall;

ALTER TABLE `articles` ADD(
  `originstamp_status` tinyint(4) DEFAULT '1',
  `origin_sha256` char(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `origin_timestamp` varchar(65) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '0'
);

CREATE TABLE IF NOT EXISTS `article_comments_timestamping_cryptSubmit` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `article_id` bigint(20) DEFAULT NULL,
  `original_comments` text COLLATE utf8_unicode_ci,
  `comment_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_id` bigint(20) DEFAULT NULL,
  `comment_timestamp` int(10) DEFAULT NULL,
  `originstamp_status` int(2) DEFAULT NULL,
  `origin_timestamp` bigint(20) DEFAULT NULL,
  `origin_sha256` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_id` (`user_id`),
  KEY `article_id` (`article_id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=55 ;


CREATE TABLE IF NOT EXISTS `download_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `ip` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middle_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `article_id` bigint(20) DEFAULT NULL,
  `file_id` bigint(20) DEFAULT NULL,
  `revision` bigint(20) DEFAULT NULL,
  `article_hash` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `download_timestamp` int(10) DEFAULT NULL,
  `originstamp_status` int(2) DEFAULT NULL,
  `origin_timestamp` bigint(20) DEFAULT NULL,
  `origin_sha256` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_id` (`user_id`),
  KEY `article_id` (`article_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;


TRUNCATE TABLE `journals`;
INSERT INTO `journals` (`journal_id`, `path`, `seq`, `primary_locale`, `enabled`) VALUES
(1, 'testJournal', 1, 'en_US', 1);

TRUNCATE TABLE `journal_settings`;
INSERT INTO `journal_settings` (`journal_id`, `locale`, `setting_name`, `setting_value`, `setting_type`) VALUES
(1, '', 'numPageLinks', '10', 'int'),
(1, '', 'itemsPerPage', '25', 'int'),
(1, '', 'numWeeksPerReview', '4', 'int'),
(1, 'en_US', 'privacyStatement', 'The names and email addresses entered in this journal site will be used exclusively for the stated purposes of this journal and will not be made available for any other purpose or to any other party.', 'string'),
(1, 'en_US', 'openAccessPolicy', 'This journal provides immediate open access to its content on the principle that making research freely available to the public supports a greater global exchange of knowledge.', 'string'),
(1, 'en_US', 'authorSelfArchivePolicy', 'This journal permits and encourages authors to post items submitted to the journal on personal websites or institutional repositories both prior to and after publication, while providing bibliographic details that credit, if applicable, its publication in this journal.', 'string'),
(1, 'en_US', 'copyeditInstructions', 'The copyediting stage is intended to improve the flow, clarity, grammar, wording, and formatting of the article. It represents the last chance for the author to make any substantial changes to the text because the next stage is restricted to typos and formatting corrections. \n\nThe file to be copyedited is in Word or .rtf format and therefore can easily be edited as a word processing document. The set of instructions displayed here proposes two approaches to copyediting. One is based on Microsoft Word''s Track Changes feature and requires that the copy editor, editor, and author have access to this program. A second system, which is software independent, has been borrowed, with permission, from the Harvard Educational Review. The journal editor is in a position to modify these instructions, so suggestions can be made to improve the process for this journal.\n\n\n<h4>Copyediting Systems</h4>\n\n<strong>1. Microsoft Word''s Track Changes</strong>\n\nUnder Tools in the menu bar, the feature Track Changes enables the copy editor to make insertions (text appears in color) and deletions (text appears crossed out in color or in the margins as deleted). The copy editor can posit queries to both the author (Author Queries) and to the editor (Editor Queries) by inserting these queries in square brackets. The copyedited version is then uploaded, and the editor is notified. The editor then reviews the text and notifies the author.\n\nThe editor and author should leave those changes with which they are satisfied. If further changes are necessary, the editor and author can make changes to the initial insertions or deletions, as well as make new insertions or deletions elsewhere in the text. Authors and editors should respond to each of the queries addressed to them, with responses placed inside the square brackets. \n\nAfter the text has been reviewed by editor and author, the copy editor will make a final pass over the text accepting the changes in preparation for the layout and galley stage.\n\n\n<strong>2. Harvard Educational Review </strong>\n\n<strong>Instructions for Making Electronic Revisions to the Manuscript</strong>\n\nPlease follow the following protocol for making electronic revisions to your manuscript:\n\n<strong>Responding to suggested changes.</strong>\n&nbsp; For each of the suggested changes that you accept, unbold the text.\n&nbsp; For each of the suggested changes that you do not accept, re-enter the original text and <strong>bold</strong> it.\n\n<strong>Making additions and deletions.</strong>\n&nbsp; Indicate additions by <strong>bolding</strong> the new text.\n&nbsp; Replace deleted sections with: <strong>[deleted text]</strong>.\n&nbsp; If you delete one or more sentence, please indicate with a note, e.g., <strong>[deleted 2 sentences]</strong>.\n\n<strong>Responding to Queries to the Author (QAs).</strong>\n&nbsp; Keep all QAs intact and bolded within the text. Do not delete them.\n&nbsp; To reply to a QA, add a comment after it. Comments should be delimited using:\n<strong>[Comment:]</strong>\n&nbsp; e.g., <strong>[Comment: Expanded discussion of methodology as you suggested]</strong>.\n\n<strong>Making comments.</strong>\n&nbsp; Use comments to explain organizational changes or major revisions\n&nbsp; e.g., <strong>[Comment: Moved the above paragraph from p. 5 to p. 7].</strong>\n&nbsp; Note: When referring to page numbers, please use the page numbers from the printed copy of the manuscript that was sent to you. This is important since page numbers may change as a document is revised electronically.\n\n<h4>An Illustration of an Electronic Revision</h4>\n\n<ol>\n<li><strong>Initial copyedit.</strong> The journal copy editor will edit the text to improve flow, clarity, grammar, wording, and formatting, as well as including author queries as necessary. Once the initial edit is complete, the copy editor will upload the revised document through the journal Web site and notify the author that the edited manuscript is available for review.</li>\n<li><strong>Author copyedit.</strong> Before making dramatic departures from the structure and organization of the edited manuscript, authors must check in with the editors who are co-chairing the piece. Authors should accept/reject any changes made during the initial copyediting, as appropriate, and respond to all author queries. When finished with the revisions, authors should rename the file from AuthorNameQA.doc to AuthorNameQAR.doc (e.g., from LeeQA.doc to LeeQAR.doc) and upload the revised document through the journal Web site as directed.</li>\n<li><strong>Final copyedit.</strong> The journal copy editor will verify changes made by the author and incorporate the responses to the author queries to create a final manuscript. When finished, the copy editor will upload the final document through the journal Web site and alert the layout editor to complete formatting.</li>\n</ol>', 'string'),
(1, '', 'emailSignature', '________________________________________________________________________\r\ntestJournal\r\nhttps://iivooo.suhail.uberspace.de/ojs/index.php/testJournal', 'string'),
(1, 'en_US', 'proofInstructions', '<p>The proofreading stage is intended to catch any errors in the galley''s spelling, grammar, and formatting. More substantial changes cannot be made at this stage, unless discussed with the Section Editor. In Layout, click on VIEW PROOF to see the HTML, PDF, and other available file formats used in publishing this item.</p>\n	<h4>For Spelling and Grammar Errors</h4>\n\n	<p>Copy the problem word or groups of words and paste them into the Proofreading Corrections box with "CHANGE-TO" instructions to the editor as follows:</p>\n\n	<pre>1. CHANGE...\n	then the others\n	TO...\n	than the others</pre>\n	<br />\n	<pre>2. CHANGE...\n	Malinowsky\n	TO...\n	Malinowski</pre>\n	<br />\n\n	<h4>For Formatting Errors</h4>\n\n	<p>Describe the location and nature of the problem in the Proofreading Corrections box after typing in the title "FORMATTING" as follows:</p>\n	<br />\n	<pre>3. FORMATTING\n	The numbers in Table 3 are not aligned in the third column.</pre>\n	<br />\n	<pre>4. FORMATTING\n	The paragraph that begins "This last topic..." is not indented.</pre>', 'string'),
(1, 'en_US', 'refLinkInstructions', '<h4>To Add Reference Linking to the Layout Process</h4>\n	<p>When turning a submission into HTML or PDF, make sure that all hyperlinks in the submission are active.</p>\n	<h4>A. When the Author Provides a Link with the Reference</h4>\n	<ol>\n	<li>While the submission is still in its word processing format (e.g., Word), add the phrase VIEW ITEM to the end of the reference that has a URL.</li>\n	<li>Turn that phrase into a hyperlink by highlighting it and using Word''s Insert Hyperlink tool and the URL prepared above.</li>\n	</ol>\n	<h4>B. Enabling Readers to Search Google Scholar For References</h4>\n	<ol>\n		<li>While the submission is still in its word processing format (e.g., Word), copy the title of the work referenced in the References list (if it appears to be too common a title—e.g., "Peace"—then copy author and title).</li>\n		<li>Paste the reference''s title between the %22''s, placing a + between each word: http://scholar.google.com/scholar?q=%22PASTE+TITLE+HERE%22</li>\n\n	<li>Add the phrase GS SEARCH to the end of each citation in the submission''s References list.</li>\n	<li>Turn that phrase into a hyperlink by highlighting it and using Word''s Insert Hyperlink tool and the URL prepared in #2.</li>\n	</ol>\n	<h4>C. Enabling Readers to Search for References with a DOI</h4>\n	<ol>\n	<li>While the submission is still in Word, copy a batch of references into CrossRef Text Query http://www.crossref.org/freeTextQuery/.</li>\n	<li>Paste each DOI that the Query provides in the following URL (between = and &): http://www.cmaj.ca/cgi/external_ref?access_num=PASTE DOI#HERE&link_type=DOI.</li>\n	<li>Add the phrase CrossRef to the end of each citation in the submission''s References list.</li>\n	<li>Turn that phrase into a hyperlink by highlighting the phrase and using Word''s Insert Hyperlink tool and the appropriate URL prepared in #2.</li>\n	</ol>', 'string'),
(1, 'en_US', 'readerInformation', 'We encourage readers to sign up for the publishing notification service for this journal. Use the <a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/user/register">Register</a> link at the top of the home page for the journal. This registration will result in the reader receiving the Table of Contents by email for each new issue of the journal. This list also allows the journal to claim a certain level of support or readership. See the journal''s <a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/about/submissions#privacyStatement">Privacy Statement</a>, which assures readers that their name and email address will not be used for other purposes.', 'string'),
(1, 'en_US', 'authorInformation', 'Interested in submitting to this journal? We recommend that you review the <a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/about">About the Journal</a> page for the journal''s section policies, as well as the <a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/about/submissions#authorGuidelines">Author Guidelines</a>. Authors need to <a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/user/register">register</a> with the journal prior to submitting or, if already registered, can simply <a href="https://iivooo.suhail.uberspace.de/ojs/index.php/index/login">log in</a> and begin the five-step process.', 'string'),
(1, 'en_US', 'librarianInformation', 'We encourage research librarians to list this journal among their library''s electronic journal holdings. As well, it may be worth noting that this journal''s open source publishing system is suitable for libraries to host for their faculty members to use with journals they are involved in editing (see <a href="http://pkp.sfu.ca/ojs">Open Journal Systems</a>).', 'string'),
(1, 'en_US', 'lockssLicense', 'This journal utilizes the LOCKSS system to create a distributed archiving system among participating libraries and permits those libraries to create permanent archives of the journal for purposes of preservation and restoration. <a href="http://www.lockss.org/">More...</a>', 'string'),
(1, '', 'supportedFormLocales', 'a:1:{i:0;s:5:"en_US";}', 'object'),
(1, '', 'supportedSubmissionLocales', 'a:1:{i:0;s:5:"en_US";}', 'object'),
(1, 'en_US', 'submissionChecklist', 'a:6:{i:0;a:2:{s:7:"content";s:165:"The submission has not been previously published, nor is it before another journal for consideration (or an explanation has been provided in Comments to the Editor).";s:5:"order";s:1:"1";}i:1;a:2:{s:7:"content";s:95:"The submission file is in OpenOffice, Microsoft Word, RTF, or WordPerfect document file format.";s:5:"order";s:1:"2";}i:2;a:2:{s:7:"content";s:60:"Where available, URLs for the references have been provided.";s:5:"order";s:1:"3";}i:3;a:2:{s:7:"content";s:239:"The text is single-spaced; uses a 12-point font; employs italics, rather than underlining (except with URL addresses); and all illustrations, figures, and tables are placed within the text at the appropriate points, rather than at the end.";s:5:"order";s:1:"4";}i:4;a:2:{s:7:"content";s:260:"The text adheres to the stylistic and bibliographic requirements outlined in the <a href="https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/about/submissions#authorGuidelines" target="_new">Author Guidelines</a>, which is found in About the Journal.";s:5:"order";s:1:"5";}i:5;a:2:{s:7:"content";s:251:"If submitting to a peer-reviewed section of the journal, the instructions in <a href="javascript:openHelp(''https://iivooo.suhail.uberspace.de/ojs/index.php/testJournal/help/view/editorial/topic/000044'')">Ensuring a Blind Review</a> have been followed.";s:5:"order";s:1:"6";}}', 'object'),
(1, '', 'rtAbstract', '1', 'bool'),
(1, '', 'rtCaptureCite', '1', 'bool'),
(1, '', 'rtViewMetadata', '1', 'bool'),
(1, '', 'rtSupplementaryFiles', '1', 'bool'),
(1, '', 'rtPrinterFriendly', '1', 'bool'),
(1, '', 'rtDefineTerms', '1', 'bool'),
(1, '', 'rtAddComment', '1', 'bool'),
(1, '', 'rtEmailAuthor', '1', 'bool'),
(1, '', 'rtEmailOthers', '1', 'bool'),
(1, '', 'allowRegReviewer', '1', 'bool'),
(1, '', 'allowRegAuthor', '1', 'bool'),
(1, '', 'allowRegReader', '1', 'bool'),
(1, '', 'submissionFee', '0', 'int'),
(1, 'en_US', 'submissionFeeName', 'Article Submission', 'string'),
(1, 'en_US', 'submissionFeeDescription', 'Authors are required to pay an Article Submission Fee as part of the submission process to contribute to review costs.', 'string'),
(1, '', 'fastTrackFee', '0', 'int'),
(1, 'en_US', 'fastTrackFeeName', 'Fast-Track Review', 'string'),
(1, 'en_US', 'fastTrackFeeDescription', 'With the payment of this fee, the review, editorial decision, and author notification on this manuscript is guaranteed to take place within 4 weeks.', 'string'),
(1, '', 'publicationFee', '0', 'int'),
(1, 'en_US', 'publicationFeeName', 'Article Publication', 'string'),
(1, 'en_US', 'publicationFeeDescription', 'If this paper is accepted for publication, you will be asked to pay an Article Publication Fee to cover publications costs.', 'string'),
(1, 'en_US', 'waiverPolicy', 'If you do not have funds to pay such fees, you will have an opportunity to waive each fee. We do not want fees to prevent the publication of worthy work.', 'string'),
(1, '', 'purchaseArticleFee', '0', 'int'),
(1, 'en_US', 'purchaseArticleFeeName', 'Purchase Article', 'string'),
(1, 'en_US', 'purchaseArticleFeeDescription', 'The payment of this fee will enable you to view, download, and print this article.', 'string'),
(1, '', 'membershipFee', '0', 'int'),
(1, 'en_US', 'membershipFeeName', 'Association Membership', 'string'),
(1, 'en_US', 'membershipFeeDescription', 'The payment of this fee will enroll you as a member in this association for one year and provide you with free access to this journal.', 'string'),
(1, 'en_US', 'donationFeeName', 'Donations to journal', 'string'),
(1, 'en_US', 'donationFeeDescription', 'Donations of any amount to this journal are gratefully received and provide a means for the editors to continue to provide a journal of the highest quality to its readers.', 'string'),
(1, '', 'metaCitations', '1', 'bool'),
(1, '', 'supportedLocales', 'a:1:{i:0;s:5:"en_US";}', 'object'),
(1, 'en_US', 'title', 'CryptSubmit', 'string'),
(1, 'en_US', 'initials', 'CS', 'string'),
(1, '', 'printIssn', '', 'string'),
(1, '', 'onlineIssn', '', 'string'),
(1, '', 'mailingAddress', '', 'string'),
(1, '', 'categories', 'N;', 'object'),
(1, '', 'useEditorialBoard', '0', 'bool'),
(1, '', 'contactName', 'author', 'string'),
(1, '', 'contactEmail', 'ivoschueepp@gmail.com', 'string'),
(1, '', 'contactPhone', '', 'string'),
(1, '', 'contactFax', '', 'string'),
(1, '', 'supportName', 'asdfasf', 'string'),
(1, '', 'supportEmail', 'asdf@asdf.de', 'string'),
(1, '', 'supportPhone', '', 'string'),
(1, '', 'sponsors', 'a:0:{}', 'object'),
(1, '', 'publisherInstitution', '', 'string'),
(1, '', 'publisherUrl', '', 'string'),
(1, '', 'contributors', 'a:0:{}', 'object'),
(1, '', 'envelopeSender', '', 'string');

CREATE TABLE IF NOT EXISTS `login_log` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(5) NOT NULL,
  `ip` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` int(15) NOT NULL,
  `username` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `billing_address` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `country` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `originstamp_status` int(1) NOT NULL DEFAULT '0',
  `origin_sha256` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `origin_timestamp` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`index`),
  UNIQUE KEY `index` (`index`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=153 ;

TRUNCATE TABLE `plugin_settings`;
INSERT INTO `plugin_settings` (`plugin_name`, `locale`, `journal_id`, `setting_name`, `setting_value`, `setting_type`) VALUES
('usagestatsplugin', '', 0, 'enabled', '1', 'bool'),
('usagestatsplugin', '', 0, 'createLogFiles', '1', 'bool'),
('usagestatsplugin', '', 0, 'accessLogFileParseRegex', '/^(?P<ip>\\S+) \\S+ \\S+ \\[(?P<date>.*?)\\] "\\S+ (?P<url>\\S+).*?" (?P<returnCode>\\S+) \\S+ ".*?" "(?P<userAgent>.*?)"/', 'string'),
('usagestatsplugin', '', 0, 'optionalColumns', 'a:2:{i:0;s:4:"city";i:1;s:6:"region";}', 'object'),
('acronplugin', '', 0, 'enabled', '1', 'bool'),
('acronplugin', '', 0, 'crontab', 'a:10:{i:0;a:3:{s:9:"className";s:43:"plugins.generic.pln.classes.tasks.Depositor";s:9:"frequency";a:1:{s:4:"hour";s:2:"25";}s:4:"args";a:1:{i:0;s:9:"autoStage";}}i:1;a:3:{s:9:"className";s:43:"plugins.generic.usageStats.UsageStatsLoader";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:1:{i:0;s:9:"autoStage";}}i:2;a:3:{s:9:"className";s:48:"plugins.importexport.datacite.DataciteInfoSender";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:0:{}}i:3;a:3:{s:9:"className";s:48:"plugins.importexport.crossref.CrossrefInfoSender";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:0:{}}i:4;a:3:{s:9:"className";s:42:"plugins.importexport.medra.MedraInfoSender";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:0:{}}i:5;a:3:{s:9:"className";s:48:"plugins.importexport.crossref.CrossrefInfoSender";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:0:{}}i:6;a:3:{s:9:"className";s:48:"plugins.importexport.crossref.CrossrefInfoSender";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:0:{}}i:7;a:3:{s:9:"className";s:28:"classes.tasks.ReviewReminder";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:0:{}}i:8;a:3:{s:9:"className";s:40:"classes.tasks.SubscriptionExpiryReminder";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:0:{}}i:9;a:3:{s:9:"className";s:36:"classes.tasks.OpenAccessNotification";s:9:"frequency";a:1:{s:4:"hour";i:24;}s:4:"args";a:0:{}}}', 'object'),
('coinsplugin', '', 0, 'enabled', '1', 'bool'),
('tinymceplugin', '', 0, 'enabled', '1', 'bool'),
('luceneplugin', '', 0, 'enabled', '0', 'bool'),
('luceneplugin', '', 0, 'searchEndpoint', 'http://localhost:8983/solr/ojs/search', 'string'),
('luceneplugin', '', 0, 'username', 'admin', 'string'),
('luceneplugin', '', 0, 'password', 'please change', 'string'),
('luceneplugin', '', 0, 'instId', 'localhost', 'string'),
('luceneplugin', '', 0, 'lastEmailTimestamp', '0', 'int'),
('luceneplugin', '', 0, 'autosuggest', '1', 'bool'),
('luceneplugin', '', 0, 'autosuggestType', '2', 'int'),
('luceneplugin', '', 0, 'spellcheck', '1', 'bool'),
('luceneplugin', '', 0, 'pullIndexing', '0', 'bool'),
('luceneplugin', '', 0, 'simdocs', '1', 'bool'),
('luceneplugin', '', 0, 'highlighting', '1', 'bool'),
('luceneplugin', '', 0, 'facetCategoryDiscipline', '1', 'bool'),
('luceneplugin', '', 0, 'facetCategorySubject', '1', 'bool'),
('luceneplugin', '', 0, 'facetCategoryType', '1', 'bool'),
('luceneplugin', '', 0, 'facetCategoryCoverage', '1', 'bool'),
('luceneplugin', '', 0, 'facetCategoryJournalTitle', '1', 'bool'),
('luceneplugin', '', 0, 'facetCategoryAuthors', '1', 'bool'),
('luceneplugin', '', 0, 'facetCategoryPublicationDate', '1', 'bool'),
('luceneplugin', '', 0, 'customRanking', '0', 'bool'),
('nlm30metadataplugin', '', 0, 'metadataPluginControlledVocabInstalled', '1', 'bool'),
('mods34metadataplugin', '', 0, 'metadataPluginControlledVocabInstalled', '1', 'bool'),
('openurl10metadataplugin', '', 0, 'metadataPluginControlledVocabInstalled', '1', 'bool'),
('helpblockplugin', '', 0, 'enabled', '1', 'bool'),
('helpblockplugin', '', 0, 'seq', '1', 'int'),
('helpblockplugin', '', 0, 'context', '2', 'int'),
('donationblockplugin', '', 0, 'enabled', '1', 'bool'),
('donationblockplugin', '', 0, 'seq', '5', 'int'),
('donationblockplugin', '', 0, 'context', '2', 'int'),
('navigationblockplugin', '', 0, 'enabled', '1', 'bool'),
('navigationblockplugin', '', 0, 'seq', '5', 'int'),
('navigationblockplugin', '', 0, 'context', '2', 'int'),
('userblockplugin', '', 0, 'enabled', '1', 'bool'),
('userblockplugin', '', 0, 'seq', '2', 'int'),
('userblockplugin', '', 0, 'context', '2', 'int'),
('notificationblockplugin', '', 0, 'enabled', '1', 'bool'),
('notificationblockplugin', '', 0, 'seq', '3', 'int'),
('notificationblockplugin', '', 0, 'context', '2', 'int'),
('developedbyblockplugin', '', 0, 'enabled', '1', 'bool'),
('developedbyblockplugin', '', 0, 'seq', '0', 'int'),
('developedbyblockplugin', '', 0, 'context', '2', 'int'),
('languagetoggleblockplugin', '', 0, 'enabled', '1', 'bool'),
('languagetoggleblockplugin', '', 0, 'seq', '4', 'int'),
('languagetoggleblockplugin', '', 0, 'context', '2', 'int'),
('fontsizeblockplugin', '', 0, 'enabled', '1', 'bool'),
('fontsizeblockplugin', '', 0, 'seq', '6', 'int'),
('fontsizeblockplugin', '', 0, 'context', '2', 'int'),
('tinymceplugin', '', 1, 'enabled', '1', 'bool'),
('informationblockplugin', '', 1, 'enabled', '1', 'bool'),
('informationblockplugin', '', 1, 'seq', '7', 'int'),
('informationblockplugin', '', 1, 'context', '2', 'int'),
('roleblockplugin', '', 1, 'enabled', '1', 'bool'),
('roleblockplugin', '', 1, 'seq', '3', 'int'),
('roleblockplugin', '', 1, 'context', '2', 'int'),
('subscriptionblockplugin', '', 1, 'enabled', '1', 'bool'),
('subscriptionblockplugin', '', 1, 'seq', '2', 'int'),
('subscriptionblockplugin', '', 1, 'context', '2', 'int'),
('developedbyblockplugin', '', 1, 'enabled', '1', 'bool'),
('developedbyblockplugin', '', 1, 'seq', '0', 'int'),
('developedbyblockplugin', '', 1, 'context', '2', 'int'),
('helpblockplugin', '', 1, 'enabled', '1', 'bool'),
('helpblockplugin', '', 1, 'seq', '1', 'int'),
('helpblockplugin', '', 1, 'context', '2', 'int'),
('userblockplugin', '', 1, 'enabled', '1', 'bool'),
('userblockplugin', '', 1, 'seq', '2', 'int'),
('userblockplugin', '', 1, 'context', '2', 'int'),
('notificationblockplugin', '', 1, 'enabled', '1', 'bool'),
('notificationblockplugin', '', 1, 'seq', '3', 'int'),
('notificationblockplugin', '', 1, 'context', '2', 'int'),
('languagetoggleblockplugin', '', 1, 'enabled', '1', 'bool'),
('languagetoggleblockplugin', '', 1, 'seq', '4', 'int'),
('languagetoggleblockplugin', '', 1, 'context', '2', 'int'),
('donationblockplugin', '', 1, 'enabled', '1', 'bool'),
('donationblockplugin', '', 1, 'seq', '5', 'int'),
('donationblockplugin', '', 1, 'context', '2', 'int'),
('navigationblockplugin', '', 1, 'enabled', '1', 'bool'),
('navigationblockplugin', '', 1, 'seq', '5', 'int'),
('navigationblockplugin', '', 1, 'context', '2', 'int'),
('fontsizeblockplugin', '', 1, 'enabled', '1', 'bool'),
('fontsizeblockplugin', '', 1, 'seq', '6', 'int'),
('fontsizeblockplugin', '', 1, 'context', '2', 'int'),
('resolverplugin', '', 1, 'enabled', '1', 'bool'),
('webfeedplugin', '', 1, 'enabled', '1', 'bool'),
('webfeedplugin', '', 1, 'displayPage', 'homepage', 'string'),
('webfeedplugin', '', 1, 'displayItems', '1', 'bool'),
('plnplugin', '', 1, 'enabled', '0', 'bool'),
('plnplugin', '', 1, 'journal_uuid', '', 'string'),
('plnplugin', '', 1, 'checksum_type', 'SHA-1', 'string'),
('plnplugin', '', 1, 'object_type', 'Issue', 'string'),
('plnplugin', '', 1, 'object_threshold', '20', 'int'),
('plnplugin', '', 1, 'pln_accepting', '0', 'bool'),
('referralplugin', '', 1, 'enabled', '1', 'bool'),
('referralplugin', '', 1, 'exclusions', '#^https?://www.google.#\n#^https?://www.yahoo.#', 'string'),
('dataciteexportplugin', '', 1, 'username', '', 'string'),
('dataciteexportplugin', '', 1, 'password', '', 'string'),
('crossrefexportplugin', '', 1, 'username', '', 'string'),
('crossrefexportplugin', '', 1, 'password', '', 'string'),
('medraexportplugin', '', 1, 'registrantName', '', 'string'),
('medraexportplugin', '', 1, 'fromCompany', '', 'string'),
('medraexportplugin', '', 1, 'fromName', '', 'string'),
('medraexportplugin', '', 1, 'fromEmail', '', 'string'),
('medraexportplugin', '', 1, 'publicationCountry', 'US', 'string'),
('medraexportplugin', '', 1, 'exportIssuesAs', '1', 'int'),
('usageeventplugin', '', 0, 'uniqueSiteId', '59870260f16ac', 'string');

TRUNCATE TABLE `roles`;
INSERT INTO `roles` (`journal_id`, `user_id`, `role_id`) VALUES
(0, 1, 1),
(1, 1, 16),
(1, 2, 65536),
(1, 3, 4096),
(1, 4, 512),
(1, 5, 256),
(1, 6, 4096),
(1, 7, 4096),
(1, 8, 4096),
(1, 9, 4096),
(1, 9, 65536),
(1, 9, 1048576),
(1, 10, 4096),
(1, 10, 65536),
(1, 10, 1048576);

TRUNCATE TABLE `sections`;
INSERT INTO `sections` (`section_id`, `journal_id`, `review_form_id`, `seq`, `editor_restricted`, `meta_indexed`, `meta_reviewed`, `abstracts_not_required`, `hide_title`, `hide_author`, `hide_about`, `disable_comments`, `abstract_word_count`) VALUES
(1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0);

TRUNCATE TABLE `section_settings`;
INSERT INTO `section_settings` (`section_id`, `locale`, `setting_name`, `setting_value`, `setting_type`) VALUES
(1, 'en_US', 'title', 'Articles', 'string'),
(1, 'en_US', 'abbrev', 'ART', 'string'),
(1, 'en_US', 'policy', '', 'string');

TRUNCATE TABLE `site_settings`;
INSERT INTO `site_settings` (`setting_name`, `locale`, `setting_value`, `setting_type`) VALUES
('showThumbnail', '', '1', 'bool'),
('showTitle', '', '1', 'bool'),
('showDescription', '', '1', 'bool'),
('title', 'en_US', 'CryptSubmit Prototype', 'string'),
('contactName', 'en_US', 'Open Journal Systems', 'string'),
('contactEmail', 'en_US', 'ivoschueepp@gmail.com', 'string'),
('siteTheme', '', '', 'string'),
('oneStepReset', '', '0', 'bool'),
('useAlphalist', '', '0', 'bool'),
('usePaging', '', '0', 'bool'),
('defaultMetricType', '', '', 'string'),
('preventManagerPluginManagement', '', '0', 'bool');

TRUNCATE TABLE `users`;
INSERT INTO `users` (`user_id`, `username`, `password`, `salutation`, `first_name`, `middle_name`, `last_name`, `suffix`, `gender`, `initials`, `email`, `url`, `phone`, `fax`, `mailing_address`, `billing_address`, `country`, `locales`, `date_last_email`, `date_registered`, `date_validated`, `date_last_login`, `must_change_password`, `auth_id`, `auth_str`, `disabled`, `disabled_reason`, `inline_help`) VALUES
(1, 'admin', '$2y$10$c183T1mxIhcLmPAT62FcNOKcnV.0NynGpcejjYV9ABMuvrPR6mPUG', NULL, 'admin', NULL, '', NULL, NULL, NULL, 'ivoschueepp@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, '2017-03-21 14:14:17', NULL, '2017-08-31 14:10:59', 0, NULL, NULL, 0, NULL, 0),
(2, 'author', '$2y$10$NWPqsTb0KFse0iHo2/uGC.iwd7qlXCJNB.vBQ/RXP5shEjU9H7V/S', '', 'au', '', 'thor', NULL, '', '', 'au@thor.de', '', '', '', '', NULL, '', '', NULL, '2017-03-21 14:16:33', NULL, '2017-08-29 20:13:28', 0, NULL, NULL, 0, NULL, 0),
(3, 'reviewer', '$2y$10$p6mWxYRvsRqiozXJ.jWAwegeBNKj0ZuHVTCeNbik.XQPLzle5I9Ca', '', 're', '', 'viewer', NULL, '', '', 'reviewer@test.de', '', '', '', '', NULL, '', '', NULL, '2017-05-29 21:20:24', NULL, '2017-08-23 20:23:29', 0, NULL, NULL, 0, NULL, 0),
(4, 'sectioneditor', '$2y$10$27sISu9GWsLDBQ1gQB8M9uF/AUiVYhMo1Ij2NBb07zNwpqws6Qxt6', '', 'section', '', 'editor', NULL, '', '', 'secedit@test.de', '', '', '', '', NULL, '', '', NULL, '2017-05-29 21:21:10', NULL, '2017-08-30 15:50:23', 0, NULL, NULL, 0, NULL, 0),
(5, 'editor', '$2y$10$5V8eTDhymqyin.1Eaa83ueeCtVS6l93TzgaJaCazafWwLSPDzxOZe', '', 'edit', '', 'or', NULL, '', '', 'editor@test.de', '', '', '', '', NULL, '', '', NULL, '2017-05-29 21:25:38', NULL, '2017-06-14 08:25:26', 0, NULL, NULL, 0, NULL, 0),
(6, 'reviewer1', '$2y$10$xsqmqaF/SdzSH.2456evq.BpPIGPcMe8vW/81SY1YuUeGaphkU1BS', '', 're', '', 'viewer1', NULL, '', '', 'reviewer1@test.de', '', '', '', '', NULL, '', '', NULL, '2017-06-14 08:21:25', NULL, '2017-06-14 08:21:25', 0, NULL, NULL, 0, NULL, 0),
(7, 'reviewer2', '$2y$10$b1lXBoH1e16zWixNTmA8NOD/T.ExiJbxOzzwXx5q3C2l/lOns65LG', '', 're', '', 'viewer2', NULL, '', '', 'reviewer2@test.de', '', '', '', '', NULL, '', '', NULL, '2017-06-14 08:23:44', NULL, '2017-06-14 17:33:46', 0, NULL, NULL, 0, NULL, 0),
(8, 'reviewer3', '$2y$10$lDzodscKmrmrewyFSEcULuSSvgfNKzXGUzdC2IxpMHCFtDcGwjlOK', '', 're', '', 'viewer3', NULL, '', '', 'reviewer3@test.de', '', '', '', '', NULL, '', '', NULL, '2017-06-14 18:53:39', NULL, '2017-06-14 18:53:39', 0, NULL, NULL, 0, NULL, 0),
(9, 'bdj-007', '$2y$10$ytlVbStRP7QDq85S2gKcy.7VeP9NbSevgQgoRjt.iSYnkKaWJvjsy', 'ys', 'ys', 'ys', 'ys', NULL, 'F', '', 'sdasd@gmail.com', '', '', '', '', NULL, '', '', NULL, '2017-08-16 17:35:41', NULL, '2017-08-16 17:35:42', 0, NULL, NULL, 0, NULL, 0),
(10, 'matain', '$2y$10$YBYXq/CSMC12fZ8luRpae.W0zlslvOzBhD0N2tMNdJgnScLosEGKq', 'ys', 'ys', 'ysy', 's', NULL, 'F', '', 'sungkanrawuh@gmail.com', '', '', '', '', NULL, '', '', NULL, '2017-08-23 15:14:12', NULL, '2017-08-23 15:14:13', 0, NULL, NULL, 0, NULL, 0);

TRUNCATE TABLE `user_settings`;
INSERT INTO `user_settings` (`user_id`, `locale`, `setting_name`, `assoc_type`, `assoc_id`, `setting_value`, `setting_type`) VALUES
(2, 'en_US', 'biography', 0, 0, '', 'string'),
(2, 'en_US', 'signature', 0, 0, '', 'string'),
(2, 'en_US', 'gossip', 0, 0, '', 'string'),
(2, 'en_US', 'affiliation', 0, 0, '', 'string'),
(2, '', 'orcid', 0, 0, '', 'string'),
(3, 'en_US', 'biography', 0, 0, '', 'string'),
(3, 'en_US', 'signature', 0, 0, '', 'string'),
(3, 'en_US', 'gossip', 0, 0, '', 'string'),
(3, 'en_US', 'affiliation', 0, 0, '', 'string'),
(3, '', 'orcid', 0, 0, '', 'string'),
(4, 'en_US', 'biography', 0, 0, '', 'string'),
(4, 'en_US', 'signature', 0, 0, '', 'string'),
(4, 'en_US', 'gossip', 0, 0, '', 'string'),
(4, 'en_US', 'affiliation', 0, 0, '', 'string'),
(4, '', 'orcid', 0, 0, '', 'string'),
(4, '', 'filterSection', 256, 1, '0', 'int'),
(5, 'en_US', 'biography', 0, 0, '', 'string'),
(5, 'en_US', 'signature', 0, 0, '', 'string'),
(5, 'en_US', 'gossip', 0, 0, '', 'string'),
(5, 'en_US', 'affiliation', 0, 0, '', 'string'),
(5, '', 'orcid', 0, 0, '', 'string'),
(5, '', 'filterEditor', 256, 1, '0', 'int'),
(5, '', 'filterSection', 256, 1, '0', 'int'),
(6, 'en_US', 'biography', 0, 0, '', 'string'),
(6, 'en_US', 'gossip', 0, 0, '', 'string'),
(6, 'en_US', 'affiliation', 0, 0, '', 'string'),
(6, '', 'orcid', 0, 0, '', 'string'),
(7, 'en_US', 'biography', 0, 0, '', 'string'),
(7, 'en_US', 'signature', 0, 0, '', 'string'),
(7, 'en_US', 'gossip', 0, 0, '', 'string'),
(7, 'en_US', 'affiliation', 0, 0, '', 'string'),
(7, '', 'orcid', 0, 0, '', 'string'),
(6, 'en_US', 'signature', 0, 0, '', 'string'),
(8, 'en_US', 'biography', 0, 0, '', 'string'),
(8, 'en_US', 'signature', 0, 0, '', 'string'),
(8, 'en_US', 'gossip', 0, 0, '', 'string'),
(8, 'en_US', 'affiliation', 0, 0, '', 'string'),
(8, '', 'orcid', 0, 0, '', 'string'),
(9, 'en_US', 'biography', 0, 0, '', 'string'),
(9, 'en_US', 'signature', 0, 0, '', 'string'),
(9, 'en_US', 'affiliation', 0, 0, '', 'string'),
(9, '', 'orcid', 0, 0, '', 'string'),
(10, 'en_US', 'biography', 0, 0, '', 'string'),
(10, 'en_US', 'signature', 0, 0, '', 'string'),
(10, 'en_US', 'affiliation', 0, 0, '', 'string'),
(10, '', 'orcid', 0, 0, '', 'string');

CREATE TABLE IF NOT EXISTS `review_forms` (
  `review_form_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint(20) DEFAULT NULL,
  `assoc_id` bigint(20) DEFAULT NULL,
  `seq` double DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`review_form_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

TRUNCATE TABLE `review_forms`;
INSERT INTO `review_forms` (`review_form_id`, `assoc_type`, `assoc_id`, `seq`, `is_active`) VALUES
(1, 256, 1, 1, 1);

CREATE TABLE IF NOT EXISTS `review_form_settings` (
  `review_form_id` bigint(20) NOT NULL,
  `locale` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `setting_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8_unicode_ci,
  `setting_type` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `review_form_settings_pkey` (`review_form_id`,`locale`,`setting_name`),
  KEY `review_form_settings_review_form_id` (`review_form_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

TRUNCATE TABLE `review_form_settings`;
INSERT INTO `review_form_settings` (`review_form_id`, `locale`, `setting_name`, `setting_value`, `setting_type`) VALUES
(1, 'en_US', 'title', 'review form', 'string'),
(1, 'en_US', 'description', '', 'string');