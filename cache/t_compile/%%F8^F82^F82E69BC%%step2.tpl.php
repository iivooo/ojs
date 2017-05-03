<?php /* Smarty version 2.6.26, created on 2017-05-03 01:59:14
         compiled from author/submit/step2.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'url', 'author/submit/step2.tpl', 21, false),array('function', 'translate', 'author/submit/step2.tpl', 26, false),array('function', 'fieldLabel', 'author/submit/step2.tpl', 75, false),array('function', 'get_help_id', 'author/submit/step2.tpl', 85, false),array('modifier', 'escape', 'author/submit/step2.tpl', 23, false),array('modifier', 'to_array', 'author/submit/step2.tpl', 46, false),array('modifier', 'date_format', 'author/submit/step2.tpl', 59, false),)), $this); ?>
 <?php $this->assign('pageTitle', "author.submit.step2"); ?> <?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "author/submit/submitHeader.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

<!-- includes for the originstamp submission script to work - dont know where else yet -->
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> -->
<!-- <script src="ojs/js/forge-sha256.min.js" type="text/javascript"></script> -->
<!-- <script src="ojs/js/originstamper.js" type="text/javascript"></script> -->
<script type="text/javascript" src="<?php echo $this->_tpl_vars['baseUrl']; ?>
/js/forge-sha256.min.js"></script>
<script type="text/javascript" src="<?php echo $this->_tpl_vars['baseUrl']; ?>
/js/originstamper.js"></script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->

<!-- <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"> -->
<!-- </script> -->



<form method="post" action="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => ' saveSubmit','path' => $this->_tpl_vars['submitStep']), $this);?>
 id="submitStep2"  
	" enctype="multipart/form-data">
	<input type="hidden" name="articleId" value="<?php echo ((is_array($_tmp=$this->_tpl_vars['articleId'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
" />
	<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "common/formErrors.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>

	<div id="uploadInstructions"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submit.uploadInstructions"), $this);?>
</div>

	<?php if ($this->_tpl_vars['journalSettings']['supportPhone']): ?> <?php $this->assign('howToKeyName', "author.submit.howToSubmit"); ?> <?php else: ?> <?php $this->assign('howToKeyName', "author.submit.howToSubmitNoPhone"); ?> <?php endif; ?>

	<p><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => $this->_tpl_vars['howToKeyName'],'supportName' => $this->_tpl_vars['journalSettings']['supportName'],'supportEmail' => $this->_tpl_vars['journalSettings']['supportEmail'],'supportPhone' => $this->_tpl_vars['journalSettings']['supportPhone']), $this);?>
</p>

	<div class="separator"></div>

	<div id="submissionFile">
		<h3><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submit.submissionFile"), $this);?>
</h3>
		<table class="data" width="100%">
			<?php if ($this->_tpl_vars['submissionFile']): ?>
			<tr valign="top">
				<td width="20%" class="label"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.fileName"), $this);?>
</td>
				<td width="80%" class="value"><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'download','path' => ((is_array($_tmp=$this->_tpl_vars['articleId'])) ? $this->_run_mod_handler('to_array', true, $_tmp, $this->_tpl_vars['submissionFile']->getFileId()) : $this->_plugins['modifier']['to_array'][0][0]->smartyToArray($_tmp, $this->_tpl_vars['submissionFile']->getFileId()))), $this);?>
"><?php echo ((is_array($_tmp=$this->_tpl_vars['submissionFile']->getFileName())) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
</a></td>
			</tr>
			<tr valign="top">
				<td width="20%" class="label"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.originalFileName"), $this);?>
</td>
				<td width="80%" class="value"><?php echo ((is_array($_tmp=$this->_tpl_vars['submissionFile']->getOriginalFileName())) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
</td>
			</tr>
			<tr valign="top">
				<td width="20%" class="label"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.fileSize"), $this);?>
</td>
				<td width="80%" class="value"><?php echo $this->_tpl_vars['submissionFile']->getNiceFileSize(); ?>
</td>
			</tr>
			<tr valign="top">
				<td width="20%" class="label"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.dateUploaded"), $this);?>
</td>
				<td width="80%" class="value"><?php echo ((is_array($_tmp=$this->_tpl_vars['submissionFile']->getDateUploaded())) ? $this->_run_mod_handler('date_format', true, $_tmp, $this->_tpl_vars['datetimeFormatShort']) : smarty_modifier_date_format($_tmp, $this->_tpl_vars['datetimeFormatShort'])); ?>
</td>
			</tr>
			<?php else: ?>
			<tr valign="top">
				<td colspan="2" class="nodata"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submit.noSubmissionFile"), $this);?>
</td>
			</tr>
			<?php endif; ?>
		</table>
	</div>

	<div class="separator"></div>

	<div id="addSubmissionFile">
		<table class="data" width="100%">
			<tr>
				<td width="30%" class="label"><?php if ($this->_tpl_vars['submissionFile']): ?> <?php echo $this->_plugins['function']['fieldLabel'][0][0]->smartyFieldLabel(array('name' => 'submissionFile','key' => "author.submit.replaceSubmissionFile"), $this);?>

					<?php else: ?> <?php echo $this->_plugins['function']['fieldLabel'][0][0]->smartyFieldLabel(array('name' => 'submissionFile','key' => "author.submit.uploadSubmissionFile"), $this);?>
 <?php endif; ?></td>
				<td width="70%" class="value"><input type="file" class="uploadField"
					name="submissionFile" id="submissionFile1" /> 
					<input
					name="uploadSubmissionFile" type="submit" class="button" onclick="handleFileSelect()"
					value="<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => " common.upload"), $this);?>
" /> <?php if ($this->_tpl_vars['currentJournal']->getSetting('showEnsuringLink')): ?><a class="action"
					href="javascript:openHelp('<?php echo $this->_plugins['function']['get_help_id'][0][0]->smartyGetHelpId(array('key' => "editorial.sectionEditorsRole.review.blindPeerReview",'url' => 'true'), $this);?>
')"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "reviewer.article.ensuringBlindReview"), $this);?>
</a><?php endif; ?></td>
			</tr>
		</table>
	</div>

	<div class="separator"></div>

	<!-- TODO: maybe insert this to translation files -->

	<h2>Trusted Timestamping</h2>
	<p>
		Your submission will be timestamped automatically by the trusted timestamping service <a
			href="https://www.originstamp.org">originstamp.org</a>. The service will 
		insert a unique fingerprint of your submission in the BitCoin Blockchain. 
		Afterwards you can verify a document, that it existed exactly in this form (not altered)
		at the upload time.
		<h2 style="color:red">IMPORTANT BEFORE SAVE AND CONTINUE</h2>
		If you want to, you can copy a symbolic link into your document before uploading. With that, anybody can directly access the
		<a href="https://www.originstamp.org">originstamp.org</a> site and see your timestamp. <br>
		Click here to get a link to copy in your document before uploading:<br>
		<br>
		<span style="font-weight: bold" id="uuidLink"></span>
<!-- 		If you want to, we can trusted timestamp your submission. You will get -->
<!-- 		a SHA-256 hash from your submission which is submitted to <a -->
<!-- 			href="https://www.originstamp.org">originstamp.org</a>, which -->
<!-- 		timestamps the file via the BitCoin blockchain. You can later verify -->
<!-- 		that the submission existed in this not altered form at this time. The -->
<!-- 		service is free, but it can last up to 24h. If you need that -->
<!-- 		immediately, there is the option that you timestamp your submission -->
<!-- 		manually at the originstamp website. Your hashcode will be displayed -->
<!-- 		at your submissions overview. -->
	</p>
	<div class="separator"></div>

	<p>
		<input type="submit"
			<?php if (! $this->_tpl_vars['submissionFile']): ?> onclick="return confirm('<?php echo ((is_array($_tmp=$this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submit.noSubmissionConfirm"), $this))) ? $this->_run_mod_handler('escape', true, $_tmp, 'jsparam') : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp, 'jsparam'));?>
')"<?php endif; ?> value="<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.saveAndContinue"), $this);?>
" class="button defaultButton"
			<!--  onclick='uploadHash(hash)' -->
			/> 
			<input
			type="button" value="<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => " common.cancel"), $this);?>
" class="button"
			onclick="confirmAction('<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('page' => 'author'), $this);?>
', '<?php echo ((is_array($_tmp=$this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submit.cancelSubmission"), $this))) ? $this->_run_mod_handler('escape', true, $_tmp, 'jsparam') : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp, 'jsparam'));?>
')" />
	</p>

</form>

<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "common/footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>
