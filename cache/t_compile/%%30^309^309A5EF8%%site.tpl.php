<?php /* Smarty version 2.6.26, created on 2017-08-06 14:13:07
         compiled from index/site.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('modifier', 'nl2br', 'index/site.tpl', 20, false),array('modifier', 'escape', 'index/site.tpl', 25, false),array('function', 'url', 'index/site.tpl', 25, false),array('function', 'translate', 'index/site.tpl', 25, false),array('function', 'page_info', 'index/site.tpl', 119, false),array('function', 'page_links', 'index/site.tpl', 120, false),array('block', 'iterate', 'index/site.tpl', 93, false),)), $this); ?>
<?php echo ''; ?><?php if ($this->_tpl_vars['siteTitle']): ?><?php echo ''; ?><?php $this->assign('pageTitleTranslated', $this->_tpl_vars['siteTitle']); ?><?php echo ''; ?><?php endif; ?><?php echo ''; ?><?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "common/header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?><?php echo ''; ?>


<br />

<?php if ($this->_tpl_vars['intro']): ?><div id="intro"><?php echo ((is_array($_tmp=$this->_tpl_vars['intro'])) ? $this->_run_mod_handler('nl2br', true, $_tmp) : smarty_modifier_nl2br($_tmp)); ?>
</div><?php endif; ?>

<a name="journals"></a>

<?php if ($this->_tpl_vars['useAlphalist']): ?>
	<p><?php $_from = $this->_tpl_vars['alphaList']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array'); }if (count($_from)):
    foreach ($_from as $this->_tpl_vars['letter']):
?><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('searchInitial' => $this->_tpl_vars['letter'],'sort' => 'title'), $this);?>
"><?php if ($this->_tpl_vars['letter'] == $this->_tpl_vars['searchInitial']): ?><strong><?php echo ((is_array($_tmp=$this->_tpl_vars['letter'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
</strong><?php else: ?><?php echo ((is_array($_tmp=$this->_tpl_vars['letter'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
<?php endif; ?></a> <?php endforeach; endif; unset($_from); ?><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array(), $this);?>
"><?php if ($this->_tpl_vars['searchInitial'] == ''): ?><strong><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.all"), $this);?>
</strong><?php else: ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.all"), $this);?>
<?php endif; ?></a></p>
<?php endif; ?>
<!--@cryptSubmit-->
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

	The prototype supports following functions already:<br><br>

		<b>For authors:</b><br>
	<ol>
		<li>Timestamping submissions client-side with <a href="https://app.originstamp.org/">orginstamp.org</a> before uploaded.</li>
		<li>Show the actual <a href="https://app.originstamp.org/home">orginstamp.org</a> timestamping-status in the summary.</li>
		<li>Within a submissions summary a zip is downloadable with the original file and an offline verifier, which provides a link to
			<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>
		<div>
			<br>
			Please login on the right side with:<br>
			<b>Username: author</b><br>
			<b>Password: 123456</b><br><br>
		</div>
	</ol>
	<b>For section editors:</b>
	<ol>
		<li>Comments are timestamped with ip-address, name etc.</li>
		<li>Downloads are timestamped (e.g. if a reviewer or author downloads an article) with ip-address, name etc.</li>
		<li>Login's are timestamped with ip-address, name etc.</li>
		<li>For all timestampings there is a status (with clickable link to originstamp.org) as well..</li>
		<li>.. as a zip is downloadable with the original file and an offline verifier, which provides a link to
			<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>
		<div>
			<br>
			Please login on the right side with:<br>
			<b>Username: sectioneditor</b><br>
			<b>Password: 123456</b><br><br>
		</div>
	</ol>


</div>
<?php $this->_tag_stack[] = array('iterate', array('from' => 'journals','item' => 'journal')); $_block_repeat=true;$this->_plugins['block']['iterate'][0][0]->smartyIterate($this->_tag_stack[count($this->_tag_stack)-1][1], null, $this, $_block_repeat);while ($_block_repeat) { ob_start(); ?>
	<?php if ($this->_tpl_vars['site']->getSetting('showThumbnail')): ?>
		<?php $this->assign('displayJournalThumbnail', $this->_tpl_vars['journal']->getLocalizedSetting('journalThumbnail')); ?>
		<div style="clear:left;">
		<?php if ($this->_tpl_vars['displayJournalThumbnail'] && is_array ( $this->_tpl_vars['displayJournalThumbnail'] )): ?>
			<?php $this->assign('altText', $this->_tpl_vars['journal']->getLocalizedSetting('journalThumbnailAltText')); ?>
			<div class="homepageImage"><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('journal' => $this->_tpl_vars['journal']->getPath()), $this);?>
" class="action"><img src="<?php echo $this->_tpl_vars['journalFilesPath']; ?>
<?php echo $this->_tpl_vars['journal']->getId(); ?>
/<?php echo ((is_array($_tmp=$this->_tpl_vars['displayJournalThumbnail']['uploadName'])) ? $this->_run_mod_handler('escape', true, $_tmp, 'url') : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp, 'url')); ?>
" <?php if ($this->_tpl_vars['altText'] != ''): ?>alt="<?php echo ((is_array($_tmp=$this->_tpl_vars['altText'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
"<?php else: ?>alt="<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.pageHeaderLogo.altText"), $this);?>
"<?php endif; ?> /></a></div>
		<?php endif; ?>
		</div>
	<?php endif; ?>
	<?php if ($this->_tpl_vars['site']->getSetting('showTitle')): ?>
		<h3><?php echo ((is_array($_tmp=$this->_tpl_vars['journal']->getLocalizedTitle())) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
</h3>
	<?php endif; ?>
	<?php if ($this->_tpl_vars['site']->getSetting('showDescription')): ?>
		<?php if ($this->_tpl_vars['journal']->getLocalizedDescription()): ?>
			<div class="journalDescription" id="journalDescription-<?php echo ((is_array($_tmp=$this->_tpl_vars['journal']->getId())) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
">
				<?php echo ((is_array($_tmp=$this->_tpl_vars['journal']->getLocalizedDescription())) ? $this->_run_mod_handler('nl2br', true, $_tmp) : smarty_modifier_nl2br($_tmp)); ?>

			</div>
		<?php endif; ?>
	<?php endif; ?>
	<p><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('journal' => $this->_tpl_vars['journal']->getPath()), $this);?>
" class="action"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "site.journalView"), $this);?>
</a> | <a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('journal' => $this->_tpl_vars['journal']->getPath(),'page' => 'issue','op' => 'current'), $this);?>
" class="action"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "site.journalCurrent"), $this);?>
</a> | <a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('journal' => $this->_tpl_vars['journal']->getPath(),'page' => 'user','op' => 'register'), $this);?>
" class="action"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "site.journalRegister"), $this);?>
</a></p>
<?php $_block_content = ob_get_contents(); ob_end_clean(); $_block_repeat=false;echo $this->_plugins['block']['iterate'][0][0]->smartyIterate($this->_tag_stack[count($this->_tag_stack)-1][1], $_block_content, $this, $_block_repeat); }  array_pop($this->_tag_stack); ?>
<?php if ($this->_tpl_vars['journals']->wasEmpty()): ?>
	<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "site.noJournals"), $this);?>

<?php endif; ?>

<div id="journalListPageInfo"><?php echo $this->_plugins['function']['page_info'][0][0]->smartyPageInfo(array('iterator' => $this->_tpl_vars['journals']), $this);?>
</div>
<div id="journalListPageLinks"><?php echo $this->_plugins['function']['page_links'][0][0]->smartyPageLinks(array('anchor' => 'journals','name' => 'journals','iterator' => $this->_tpl_vars['journals']), $this);?>
</div>

<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "common/footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
