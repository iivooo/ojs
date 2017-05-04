{**
 * templates/author/submission/originstampDownload.tpl
 *
 * Subtemplate defining the author's submission originstamp information download.
 *
 *}
<div id="submission">
<h3>{translate key="common.originstampStatus"}</h3>
<table width="100%" class="data">
	<tr valign="top">
	<!-- 	<td width="20%" class="label">{translate key="common.originstampZip"}</td> -->
		<td width="80%" colspan="2" class="data">

		In case of unavailability or for your archives, download a Zip-archive with all information needed to 
		manually verify your file within the Bitcoin-Blockchain.
			{if $submissionFile}
				<a href="{url op="downloadOriginstampZipFile" path=$submission->getId()|to_array:$submissionFile->getFileId():$submissionFile->getRevision()}" class="file"><font color="red">Download Zip.</font></a>&nbsp;&nbsp;
			{else}
				{translate key="common.none"}
			{/if}
		</td>
	</tr>
</table>
</div>

