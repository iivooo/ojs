<?php /* Smarty version 2.6.26, created on 2017-08-06 21:43:44
         compiled from core:user/login.tpl */ ?>
<?php require_once(SMARTY_CORE_DIR . 'core.load_plugins.php');
smarty_core_load_plugins(array('plugins' => array(array('function', 'translate', 'core:user/login.tpl', 24, false),array('function', 'url', 'core:user/login.tpl', 33, false),array('modifier', 'strip_unsafe_html', 'core:user/login.tpl', 114, false),array('modifier', 'escape', 'core:user/login.tpl', 114, false),)), $this); ?>
<?php echo ''; ?><?php $this->assign('pageTitle', "user.login"); ?><?php echo ''; ?><?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "common/header.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?><?php echo ''; ?>


<?php if (! $this->_tpl_vars['registerOp']): ?>
	<?php $this->assign('registerOp', 'register'); ?>
<?php endif; ?>
<?php if (! $this->_tpl_vars['registerLocaleKey']): ?>
	<?php $this->assign('registerLocaleKey', "user.login.registerNewAccount"); ?>
<?php endif; ?>

<?php if ($this->_tpl_vars['loginMessage']): ?>
	<span class="instruct"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => ($this->_tpl_vars['loginMessage'])), $this);?>
</span>
	<br />
	<br />
<?php endif; ?>

<?php if ($this->_tpl_vars['implicitAuth'] === @IMPLICIT_AUTH_OPTIONAL): ?>
	<h3><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "user.login.implicitAuth"), $this);?>
</h3>
<?php endif; ?>
<?php if ($this->_tpl_vars['implicitAuth']): ?>
	<a id="implicitAuthLogin" href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('page' => 'login','op' => 'implicitAuthLogin'), $this);?>
"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "user.login.implicitAuthLogin"), $this);?>
</a>
<?php endif; ?>
<?php if ($this->_tpl_vars['implicitAuth'] === @IMPLICIT_AUTH_OPTIONAL): ?>
	<h3><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "user.login.localAuth"), $this);?>
</h3>
<?php endif; ?>
<?php if (! $this->_tpl_vars['implicitAuth'] || $this->_tpl_vars['implicitAuth'] === @IMPLICIT_AUTH_OPTIONAL): ?>
	<form id="signinForm" method="post" action="<?php echo $this->_tpl_vars['loginUrl']; ?>
">
<?php endif; ?>

<?php if ($this->_tpl_vars['error']): ?>
	<span class="pkp_form_error"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => ($this->_tpl_vars['error']),'reason' => $this->_tpl_vars['reason']), $this);?>
</span>
	<br />
	<br />
<?php endif; ?>
		<!--@cryptSubmit-->
		<div style = 	"background-color:lightblue;
				 border:2px black solid; margin-bottom: 20px;">
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

<input type="hidden" name="source" value="<?php echo ((is_array($_tmp=((is_array($_tmp=$this->_tpl_vars['source'])) ? $this->_run_mod_handler('strip_unsafe_html', true, $_tmp) : String::stripUnsafeHtml($_tmp)))) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
" />

<?php if (! $this->_tpl_vars['implicitAuth'] || $this->_tpl_vars['implicitAuth'] === @IMPLICIT_AUTH_OPTIONAL): ?>
	<table id="signinTable" class="data">
	<tr>
		<td class="label"><label for="loginUsername"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "user.username"), $this);?>
</label></td>
		<td class="value"><input type="text" id="loginUsername" name="username" value="<?php echo ((is_array($_tmp=$this->_tpl_vars['username'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
" size="20" maxlength="32" class="textField" /></td>
	</tr>
	<tr>
		<td class="label"><label for="loginPassword"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "user.password"), $this);?>
</label></td>
		<td class="value"><input type="password" id="loginPassword" name="password" value="<?php echo ((is_array($_tmp=$this->_tpl_vars['password'])) ? $this->_run_mod_handler('escape', true, $_tmp) : $this->_plugins['modifier']['escape'][0][0]->smartyEscape($_tmp)); ?>
" size="20" class="textField" /></td>
	</tr>
	<?php if ($this->_tpl_vars['showRemember']): ?>
	<tr valign="middle">
		<td></td>
		<td class="value"><input type="checkbox" id="loginRemember" name="remember" value="1"<?php if ($this->_tpl_vars['remember']): ?> checked="checked"<?php endif; ?> /> <label for="loginRemember"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "user.login.rememberUsernameAndPassword"), $this);?>
</label></td>
	</tr>
	<?php endif; ?>
	<tr>
		<td></td>
		<td><input type="submit" value="<?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "user.login"), $this);?>
" class="button" /></td>
	</tr>
	</table>

	<ul>
		<?php if (! $this->_tpl_vars['hideRegisterLink']): ?><li><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('page' => 'user','op' => $this->_tpl_vars['registerOp']), $this);?>
"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => $this->_tpl_vars['registerLocaleKey']), $this);?>
</a></li><?php endif; ?>
		<li><a href="<?php echo $this->_plugins['function']['url'][0][0]->smartyUrl(array('page' => 'login','op' => 'lostPassword'), $this);?>
"><?php echo $this->_plugins['function']['translate'][0][0]->smartyTranslate(array('key' => "user.login.forgotPassword"), $this);?>
</a></li>
	</ul>

<script type="text/javascript">
<!--
	document.getElementById('<?php if ($this->_tpl_vars['username']): ?>loginPassword<?php else: ?>loginUsername<?php endif; ?>').focus();
// -->
</script>
</form>
<?php endif; ?>
<?php $_smarty_tpl_vars = $this->_tpl_vars;
$this->_smarty_include(array('smarty_include_tpl_file' => "common/footer.tpl", 'smarty_include_vars' => array()));
$this->_tpl_vars = $_smarty_tpl_vars;
unset($_smarty_tpl_vars);
 ?>