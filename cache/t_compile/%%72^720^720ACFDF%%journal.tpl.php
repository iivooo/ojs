<?php /* Smarty version 2.6.26, created on 2017-05-19 11:14:58
         compiled from index/journal.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'call_hook', 'index/journal.tpl', 63, false),array('function', 'translate', 'index/journal.tpl', 67, false),array('function', 'url', 'index/journal.tpl', 82, false),array('modifier', 'escape', 'index/journal.tpl', 67, false),array('modifier', 'strip_unsafe_html', 'index/journal.tpl', 91, false),array('modifier', 'nl2br', 'index/journal.tpl', 91, false),)), $this); ?>
<?php echo ''; ?><?php $this->assign('pageTitleTranslated', $this->_tpl_vars['siteTitle']); ?><?php echo ''; ?><?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "common/header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?><?php echo ''; ?>

<div style = 	"background-color:lightblue;
				 border:2px black solid;">
	This prototype shows a possible implementation of <a href="https://www.gipp.com/wp-content/papercite-data/pdf/gipp2017b.pdf">CryptSubmit</a> in an existing system.<br><br>
	The following is the abstract of the before mentioned paper which describes brief the use of such a system:<br><br>
	<i>Manuscript submission systems are a central fixture in scholarly
	publishing. However, researchers who submit their unpublished
	work to a conference or journal must trust that the system and its
	provider will not accidentally or willfully leak unpublished
	findings. Additionally, researchers must trust that the program
	committee and the anonymous peer reviewers will not plagiarize
	unpublished ideas or results. To address these weaknesses, we
	propose a method that automatically creates a publicly verifiable,
	tamper-proof timestamp for manuscripts utilizing the
	decentralized Bitcoin blockchain. The presented method hashes
	each submitted manuscript and uses the API of the timestamping
	service OriginStamp to persistently embed this manuscript hash
	on Bitcoin’s blockchain. Researchers can use this tamper-proof
	trusted timestamp to prove that their manuscript existed in its
	specific form at the time of submission to a conference or journal.
	This verifiability allows researchers to stake a claim to their
	research findings and intellectual property, even in the face of
	vulnerable submission platforms or dishonest peer reviewers.
	Optionally, the system also associates trusted timestamps with the
	feedback and ideas shared by peer reviewers to increase the
	traceability of ideas. The proposed concept, which we introduce
	as CryptSubmit, is currently being integrated into the open-source
	conference management system OJS. In the future, the method
	could be integrated at nearly no overhead cost into other
	manuscript submission systems, such as EasyChair, ConfTool, or
	Ambra. The introduced method can also improve electronic preprint
		services and storage systems for research data.</i><br><br>
Please login on the right side with:<br><br>
	<div>
	<b>Username: author</b><br>
	<b>Password: 123456</b><br><br>
	</div>
	The prototype supports following functions already:<br><br>
	<ul>
		<li>Timestamping submissions client-side with <a href="https://app.originstamp.org/">orginstamp.org</a> before uploaded.</li>
		<li>Show the actual <a href="https://app.originstamp.org/home">orginstamp.org</a> timestamping-status in the summary.</li>
		<li>Within a submissions summary a zip is downloadable with the original file and an offline verificator, which provides a link to
		<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>
	</ul>
</div>
<?php if ($this->_tpl_vars['journalDescription']): ?>
	<div id="journalDescription"><?php echo $this->_tpl_vars['journalDescription']; ?>
</div>
<?php endif; ?>

<?php echo $this->_plugins['function']['call_hook'][0][0]->smartyCallHook(array('name' => "Templates::Index::journal"), $this);?>


<?php if ($this->_tpl_vars['homepageImage']): ?>
<br />
<div id="homepageImage"><img src="<?php echo $this->_tpl_vars['publicFilesDir']; ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['homepageImage']['uploadName'])) ? $this->_run_mod_handler('escape', true, $_tmp, 'url') : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp, 'url')); ?>
" width="<?php echo ((is_array($_tmp=$this->_tpl_vars['homepageImage']['width'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
" height="<?php echo ((is_array($_tmp=$this->_tpl_vars['homepageImage']['height'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
" <?php if ($this->_tpl_vars['homepageImageAltText'] != ''): ?>alt="<?php echo ((is_array($_tmp=$this->_tpl_vars['homepageImageAltText'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
"<?php else: ?>alt="<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.journalHomepageImage.altText"), $this);?>
"<?php endif; ?> /></div>
<?php endif; ?>

<?php if ($this->_tpl_vars['additionalHomeContent']): ?>
<br />
<div id="additionalHomeContent"><?php echo $this->_tpl_vars['additionalHomeContent']; ?>
</div>
<?php endif; ?>

<?php if ($this->_tpl_vars['enableAnnouncementsHomepage']): ?>
		<div id="announcementsHome">
		<h3><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "announcement.announcementsHome"), $this);?>
</h3>
		<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "announcement/list.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>	
		<table class="announcementsMore">
			<tr>
				<td><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('page' => 'announcement'), $this);?>
"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "announcement.moreAnnouncements"), $this);?>
</a></td>
			</tr>
		</table>
	</div>
<?php endif; ?>

<?php if ($this->_tpl_vars['issue'] && $this->_tpl_vars['currentJournal']->getSetting('publishingMode') != @PUBLISHING_MODE_NONE): ?>
		<br />
	<h3><?php echo ((is_array($_tmp=((is_array($_tmp=$this->_tpl_vars['issue']->getIssueIdentification())) ? $this->_run_mod_handler('strip_unsafe_html', true, $_tmp) : String::stripUnsafeHtml($_tmp)))) ? $this->_run_mod_handler('nl2br', true, $_tmp) : smarty_modifier_nl2br($_tmp)); ?>
</h3>
	<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "issue/view.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
<?php endif; ?>

<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "common/footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
