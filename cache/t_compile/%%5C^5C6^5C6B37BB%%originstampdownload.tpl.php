<?php /* Smarty version 2.6.26, created on 2017-03-14 15:19:59
         compiled from author/submission/originstampdownload.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'translate', 'author/submission/originstampdownload.tpl', 8, false),array('function', 'url', 'author/submission/originstampdownload.tpl', 16, false),array('modifier', 'to_array', 'author/submission/originstampdownload.tpl', 16, false),)), $this); ?>
<div id="submission">
<h3><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.originstampStatus"), $this);?>
</h3>
<table width="100%" class="data">
	<tr valign="top">
	<!-- 	<td width="20%" class="label"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.originstampZip"), $this);?>
</td> -->
		<td width="80%" colspan="2" class="data">
		In case of unavailability or for your archives, download a Zip-archive with all information needed to 
		manually verify your file within the Bitcoin-Blockchain.
			<?php if ($this->_tpl_vars['submissionFile']): ?>
				<a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('op' => 'downloadOriginstampZipFile','path' => ((is_array($_tmp=$this->_tpl_vars['submission']->getId())) ? $this->_run_mod_handler('to_array', true, $_tmp, $this->_tpl_vars['submissionFile']->getFileId(), $this->_tpl_vars['submissionFile']->getRevision()) : $this->_plugins['modifier']['to_array'][0][0]->smartyToArray($_tmp, $this->_tpl_vars['submissionFile']->getFileId(), $this->_tpl_vars['submissionFile']->getRevision()))), $this);?>
" class="file"><font color="red">Download Zip.</font></a>&nbsp;&nbsp;
			<?php else: ?>
				<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "common.none"), $this);?>

			<?php endif; ?>
		</td>
	</tr>
</table>
</div>
