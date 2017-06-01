<?php /* Smarty version 2.6.26, created on 2017-05-22 13:22:07
         compiled from author/active.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'sort_heading', 'author/active.tpl', 34, false),array('function', 'translate', 'author/active.tpl', 35, false),array('function', 'url', 'author/active.tpl', 57, false),array('function', 'page_info', 'author/active.tpl', 133, false),array('function', 'page_links', 'author/active.tpl', 134, false),array('block', 'iterate', 'author/active.tpl', 44, false),array('modifier', 'escape', 'author/active.tpl', 50, false),array('modifier', 'date_format', 'author/active.tpl', 51, false),array('modifier', 'truncate', 'author/active.tpl', 54, false),array('modifier', 'strip_tags', 'author/active.tpl', 57, false),)), $this); ?>
 <div style = 	"background-color:lightblue;
				 border:2px black solid;">
	On this page you can..
	<ul>
		<li>.. see your uploaded submissions with the corresponding <a href="https://app.originstamp.org/">originstamp.org</a> status on the right. </li>
		<li>.. upload a submission with the "five-step submission process"</li>
		<li>.. click the submission to get to the submissions summary, where you find a zip at the bottom of the page with the original file and an offline verificator, which provides a link to
		<a href="https://blockchain.info/">blockchain.info</a>. Also the underlying javascript acts as a blueprint to retrace the steps for manual address generation.</li>
	</ul>
	<p>Note on the <a href="https://app.originstamp.org/">originstamp.org</a> status:
	<ul>
		<li><div style="color:green;font-weight: bold;" align=left>&#10003;</div> The submission is sucessfully timestamped. The hash is in the Blockchain and at least one block is above.</li>
		<li><div style="color:orange;font-weight: bold;" align=left>&#10003;</div> The submission's timestamping is in progress. Will be successfully done within max. 24 hours.</li>
		<li><div style="color:red;font-weight: bold;" align=left>&#10003;</div> There is no main submission uploaded to the server.</li>
	</ul>
	 </p>
</div>

 <link rel="stylesheet" type="text/css" href="/styles/originstamper.css">
<div id="submissions">
<table class="listing" width="100%">
	<tr><td colspan="7" class="headseparator">&nbsp;</td></tr>
	<tr class="heading" valign="bottom">
		<td width="5%"><?php echo $this->_plugins['function']['sort_heading'][0][0]->smartySortHeading(array('key' => "common.id",'sort' => 'id','sortOrder' => 'ASC'), $this);?>
</td>
		<td width="5%"><span class="disabled"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "submission.date.mmdd"), $this);?>
</span><br /><?php echo $this->_plugins['function']['sort_heading'][0][0]->smartySortHeading(array('key' => "submissions.submit",'sort' => 'submitDate'), $this);?>
</td>
		<td width="5%"><?php echo $this->_plugins['function']['sort_heading'][0][0]->smartySortHeading(array('key' => "submissions.sec",'sort' => 'section'), $this);?>
</td>
		<td width="25%"><?php echo $this->_plugins['function']['sort_heading'][0][0]->smartySortHeading(array('key' => "article.authors",'sort' => 'authors'), $this);?>
</td>
		<td width="35%"><?php echo $this->_plugins['function']['sort_heading'][0][0]->smartySortHeading(array('key' => "article.title",'sort' => 'title'), $this);?>
</td>
		<td width="15%" align="left"><?php echo $this->_plugins['function']['sort_heading'][0][0]->smartySortHeading(array('key' => "common.status",'sort' => 'status'), $this);?>
</td>
		<td width="10%" align="left"><?php echo $this->_plugins['function']['sort_heading'][0][0]->smartySortHeading(array('key' => "common.originstampStatus"), $this);?>
</td>                               <!-- ORIGINSTAMP Status -->
	</tr>
	<tr><td colspan="7" class="headseparator">&nbsp;</td></tr>

<?php $this->_tag_stack[] = array('iterate', array('from' => 'submissions','item' => 'submission')); $_block_repeat=true;$this->_plugins['block']['iterate'][0][0]->smartyIterate($this->_tag_stack[count($this->_tag_stack)-1][1], null, $this, $_block_repeat);while ($_block_repeat) { ob_start(); ?>
	<?php $this->assign('articleId', $this->_tpl_vars['submission']->getId()); ?>
	<?php $this->assign('progress', $this->_tpl_vars['submission']->getSubmissionProgress()); ?>
	<?php $this->assign('sha256', $this->_tpl_vars['submission']->getSHA256()); ?>

	<tr valign="top">
		<td><?php echo ((is_array($_tmp=$this->_tpl_vars['articleId'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
</td>
		<td><?php if ($this->_tpl_vars['submission']->getDateSubmitted()): ?><?php echo ((is_array($_tmp=$this->_tpl_vars['submission']->getDateSubmitted())) ? $this->_run_mod_handler('date_format', true, $_tmp, $this->_tpl_vars['dateFormatTrunc']) : smarty_modifier_date_format($_tmp, $this->_tpl_vars['dateFormatTrunc'])); ?>
<?php else: ?>&mdash;<?php endif; ?></td>
		<td><?php echo ((is_array($_tmp=$this->_tpl_vars['submission']->getSectionAbbrev())) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
</td>
		
		<td><?php echo ((is_array($_tmp=((is_array($_tmp=$this->_tpl_vars['submission']->getAuthorString(true))) ? $this->_run_mod_handler('truncate', true, $_tmp, 40, "...") : $this->_plugins['modifier']['truncate'][0][0]->smartyTruncate($_tmp, 40, "...")))) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
</td>
		
		<?php if ($this->_tpl_vars['progress'] == 0): ?>
			<td><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'submission','path' => $this->_tpl_vars['articleId']), $this);?>
" class="action"><font color="red"><?php if ($this->_tpl_vars['submission']->getLocalizedTitle()): ?><?php echo ((is_array($_tmp=((is_array($_tmp=$this->_tpl_vars['submission']->getLocalizedTitle())) ? $this->_run_mod_handler('strip_tags', true, $_tmp) : smarty_modifier_strip_tags($_tmp)))) ? $this->_run_mod_handler('truncate', true, $_tmp, 60, "...") : $this->_plugins['modifier']['truncate'][0][0]->smartyTruncate($_tmp, 60, "...")); ?>
<?php else: ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.untitled"), $this);?>
<?php endif; ?></font></a></td>
			<td align="left">
				<?php $this->assign('status', $this->_tpl_vars['submission']->getSubmissionStatus()); ?>
				<?php if ($this->_tpl_vars['status'] == STATUS_QUEUED_UNASSIGNED): ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "submissions.queuedUnassigned"), $this);?>

				<?php elseif ($this->_tpl_vars['status'] == STATUS_QUEUED_REVIEW): ?>
					<a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'submissionReview','path' => $this->_tpl_vars['articleId']), $this);?>
" class="action">
						<?php $this->assign('decision', $this->_tpl_vars['submission']->getMostRecentDecision()); ?>
						<?php if ($this->_tpl_vars['decision'] == @SUBMISSION_EDITOR_DECISION_PENDING_REVISIONS): ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submissions.queuedReviewRevisions"), $this);?>

						<?php elseif ($this->_tpl_vars['submission']->getCurrentRound() > 1): ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submissions.queuedReviewSubsequent",'round' => $this->_tpl_vars['submission']->getCurrentRound()), $this);?>

						<?php else: ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "submissions.queuedReview"), $this);?>

						<?php endif; ?>
					</a>
				<?php elseif ($this->_tpl_vars['status'] == STATUS_QUEUED_EDITING): ?>
					<?php $this->assign('proofSignoff', $this->_tpl_vars['submission']->getSignoff('SIGNOFF_PROOFREADING_AUTHOR')); ?>
					<a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'submissionEditing','path' => $this->_tpl_vars['articleId']), $this);?>
" class="action">
						<?php if ($this->_tpl_vars['proofSignoff']->getDateNotified() && ! $this->_tpl_vars['proofSignoff']->getDateCompleted()): ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submissions.queuedEditingCopyedit"), $this);?>

						<?php elseif ($this->_tpl_vars['proofSignoff']->getDateNotified() && ! $this->_tpl_vars['proofSignoff']->getDateCompleted()): ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submissions.queuedEditingProofread"), $this);?>

						<?php else: ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "submissions.queuedEditing"), $this);?>

						<?php endif; ?>
					</a>
				<?php endif; ?>
				<?php if ($this->_tpl_vars['submission']->getOriginstampStatus() == 3): ?> <td style="color:green;font-weight: bold;" align=left><div class="tooltip" onclick='originstampDownload.php'>&#10003;<span class="tooltiptext">
				Originstamp Status: 3. Your submission is successfully timpestamped. In the articles summary, you will find a zip-file with all information you need for manual verification. </span></div>
				<div><a target="_blank" href="https://app.originstamp.org/s/<?php echo ((is_array($_tmp=$this->_tpl_vars['sha256'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
">LINK</a></div></td>
				<?php elseif ($this->_tpl_vars['submission']->getOriginstampStatus() == 0): ?>
				 <td style="color:red;font-weight: bold;" align=left><div class="tooltip" onclick='originstampDownload.php'>&#10003;<span class="tooltiptext">
				No primary file uploaded. </span></div><div>NO LINK</div></td>

				<?php else: ?> <td style="color:orange;font-weight: bold;" align=left><div class="tooltip" onclick='originstampDownload.php'>&#10003;<span class="tooltiptext">
				Originstamp status: < 3. Your submission will be successfully timestamped in less than 24 hours. In the articles summary, you will find a zip-file with all information you need for manual verification. </span></div>
				<div><a target="_blank" style='color:orange' href="https://app.originstamp.org/s/<?php echo ((is_array($_tmp=$this->_tpl_vars['sha256'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
">LINK</a></div></td><?php endif; ?>

								<?php if ($this->_tpl_vars['status'] == STATUS_QUEUED_UNASSIGNED || $this->_tpl_vars['status'] == STATUS_QUEUED_REVIEW): ?>
					<?php if ($this->_tpl_vars['submissionEnabled'] && ! $this->_tpl_vars['completedPaymentDAO']->hasPaidSubmission($this->_tpl_vars['submission']->getJournalId(),$this->_tpl_vars['submission']->getId())): ?>
						<br />
						<a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'paySubmissionFee','path' => ($this->_tpl_vars['articleId'])), $this);?>
" class="action"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "payment.submission.paySubmission"), $this);?>
</a>					
					<?php elseif ($this->_tpl_vars['fastTrackEnabled']): ?>
						<br />
						<?php if ($this->_tpl_vars['submission']->getFastTracked()): ?>
							<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "payment.fastTrack.inFastTrack"), $this);?>

						<?php else: ?>
							<a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'payFastTrackFee','path' => ($this->_tpl_vars['articleId'])), $this);?>
" class="action"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "payment.fastTrack.payFastTrack"), $this);?>
</a>
						<?php endif; ?>
					<?php endif; ?>
				<?php elseif ($this->_tpl_vars['status'] == STATUS_QUEUED_EDITING): ?>
					<?php if ($this->_tpl_vars['publicationEnabled']): ?>
						<br />
						<?php if ($this->_tpl_vars['completedPaymentDAO']->hasPaidPublication($this->_tpl_vars['submission']->getJournalId(),$this->_tpl_vars['submission']->getId())): ?>
							<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "payment.publication.publicationPaid"), $this);?>

						<?php else: ?>
							<a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'payPublicationFee','path' => ($this->_tpl_vars['articleId'])), $this);?>
" class="action"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "payment.publication.payPublication"), $this);?>
</a>
						<?php endif; ?>
				<?php endif; ?>		
		<?php endif; ?>
			</td>
		<?php else: ?>
			<td><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'submit','path' => $this->_tpl_vars['progress'],'articleId' => $this->_tpl_vars['articleId']), $this);?>
" class="action"><?php if ($this->_tpl_vars['submission']->getLocalizedTitle()): ?><?php echo ((is_array($_tmp=((is_array($_tmp=$this->_tpl_vars['submission']->getLocalizedTitle())) ? $this->_run_mod_handler('strip_tags', true, $_tmp) : smarty_modifier_strip_tags($_tmp)))) ? $this->_run_mod_handler('truncate', true, $_tmp, 60, "...") : $this->_plugins['modifier']['truncate'][0][0]->smartyTruncate($_tmp, 60, "...")); ?>
<?php else: ?><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.untitled"), $this);?>
<?php endif; ?></a></td>
			<td align="right"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "submissions.incomplete"), $this);?>
<br /><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'deleteSubmission','path' => $this->_tpl_vars['articleId']), $this);?>
" class="action" onclick="return confirm('<?php echo ((is_array($_tmp=$this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "author.submissions.confirmDelete"), $this))) ? $this->_run_mod_handler('escape', true, $_tmp, 'jsparam') : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp, 'jsparam'));?>
')"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.delete"), $this);?>
</a></td>
		<?php endif; ?>

	</tr>

	<tr>
		<td colspan="7" class="<?php if ($this->_tpl_vars['submissions']->eof()): ?>end<?php endif; ?>separator">&nbsp;</td>
	</tr>
<?php $_block_content = ob_get_contents(); ob_end_clean(); $_block_repeat=false;echo $this->_plugins['block']['iterate'][0][0]->smartyIterate($this->_tag_stack[count($this->_tag_stack)-1][1], $_block_content, $this, $_block_repeat); }  array_pop($this->_tag_stack); ?>
<?php if ($this->_tpl_vars['submissions']->wasEmpty()): ?>
	<tr>
		<td colspan="6" class="nodata"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "submissions.noSubmissions"), $this);?>
</td>
	</tr>
	<tr>
		<td colspan="6" class="endseparator">&nbsp;</td>
	</tr>
<?php else: ?>
	<tr>
		<td colspan="4" align="left"><?php echo $this->_plugins['function']['page_info'][0][0]->smartyPageInfo(array('iterator' => $this->_tpl_vars['submissions']), $this);?>
</td>
		<td colspan="2" align="right"><?php echo $this->_plugins['function']['page_links'][0][0]->smartyPageLinks(array('anchor' => 'submissions','name' => 'submissions','iterator' => $this->_tpl_vars['submissions'],'sort' => $this->_tpl_vars['sort'],'sortDirection' => $this->_tpl_vars['sortDirection']), $this);?>
</td>
	</tr>
<?php endif; ?>
</table>
</div>
