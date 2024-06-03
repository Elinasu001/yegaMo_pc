/**
 * (C) Copyright AhnLab, Inc.
 *
 * Any part of this source code can not be copied with
 * any method without prior written permission from
 * the author or authorized person.
 *
 * @version			$Revision: 14980 $
 *
 */

function gotoInstallASTX2()
{
	var sub = '';
	if(typeof(_INST_SUB) != 'undefined' && _INST_SUB != null) {
		sub = _INST_SUB;
	}

	var url = sub+'page_inst_check.jsp?page='+encodeURIComponent(window.location)+'&rnd='+new Date().getTime();
	window.location.href = url;
}

function checkInstallASTX2(fnSuccess, fnFailure)
{
	$_astxj.showOverlay();

	$ASTX2.init(
		function onSuccess() {
			$_astxj.hideOverlay();
			$_astxu.log('ASTX.init() success [astx2.1]');

			if(fnSuccess) {	fnSuccess(); }
		},
		function onFailure() {
			$_astxj.hideOverlay();

			var errno = $ASTX2.getLastError();
			$_astxu.log('ASTX.init() failure: errno='+errno);
			if(errno == $ASTX2_CONST.ERROR_NOTINST) {
				gotoInstallASTX2();
			}else {
				if(fnFailure) { fnFailure(); }
			} // end of if
		}
	);
}

function onMoveFocus(objCurr, idNext, nLength)
{
	if(objCurr.value.length >= nLength)
	{
		var elm = document.getElementById(idNext);
		if(elm) { elm.focus(); }
	}
}
