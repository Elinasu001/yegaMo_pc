/**
 *  @name Veraport V2 - install_internal.js
 *  @author wizvera
 *  @date 2017.12.07
 *  @include veraport20.js
**/

//커트트마이징이 필요하면 별도의 JS(install_업무명.js)로 만들어 사용하고 여기는 수정/추가하지 마세요
//아래 설정값은 기본값입니다. 변경이 필요한 내용은 install_config 에서 수정하세요.

var instMsg = {};
instMsg.status = new Array(); //설치상태 메시지
instMsg.result = new Array(); //설치결과 메시지
instMsg.notice = new Array(); //알림 메시지

var instCode = {};
instCode.STATUS_NOT_SUP = 0; //미지원
instCode.STATUS_INST_OK = 1; //설치됨
instCode.STATUS_INST_BK = 2; //설치됨(차단감지)
instCode.STATUS_INST_RE = 3; //설치됨(재설치)
instCode.STATUS_INST_UP = 6; //미설치(업데이트)
instCode.STATUS_INST_NO = 7; //미설치
instCode.STATUS_NOT_CHK = 8; //미확인(베라포트미설치)

instCode.RESULT_INST_OK = 0; //설치완료
instCode.RESULT_INST_ER = 1; //설치완료(배포파일오류)
instCode.RESULT_INST_NO = 2; //베라포트 미설치
instCode.RESULT_NOT_SUP = 3; //베라포트 미지원
instCode.RESULT_INST_CK = 4; //보안모듈 별도체크 필요

instCode.NOTICE_BLOCK_COOKIE  = 0; //쿠기차단
instCode.NOTICE_BLOCK_ACTIVEX = 1; //Active-X 필터링
instCode.NOTICE_BLOCK_PLUGIN  = 2; //Plug-in 차단
instCode.NOTICE_WARNING_X64   = 3; //64Bit IE 경고
instCode.NOTICE_WARNING_MOBILE= 4; //모바일 접속 경고
instCode.NOTICE_WARNING_EDGE  = 5; //Edge브라우저 접속 경고

instCode.TYPE_SELECT    = "select";
instCode.TYPE_MUST      = "";
instCode.TYPE_ALL       = "all";
instCode.VERAPORT       = "Veraport";

var objectCheck = {};
objectCheck.checkURL = "";
objectCheck.objectName = "";

objectCheck.init = false;
objectCheck.applyCancel = false;
objectCheck.applyConfirm = false;

objectCheck.returnURL = "";
objectCheck.alertMSG = "";
objectCheck.storeBackup = [];
objectCheck.store = [];

var instConfig = {};
instConfig.isDebug         = false;
instConfig.isCabInstall    = true;
instConfig.x64msieWarning  = false;
instConfig.mobileWarning   = false;
instConfig.edgeWarning     = false;
instConfig.returnURL       = "";
instConfig.P_name          = "";
instConfig.displayDownload = false;

instConfig.usePluginModule = true;
instConfig.objectInstList  = "";
instConfig.objectOverlapList = "";
instConfig.objectUpdateList= "";
instConfig.objectDefType   = instCode.TYPE_MUST;

instConfig.isForceInstall  = false;
instConfig.killBrowser     = ""; //"all,confirm", "parent,confirm", "all,silent"
instConfig.initialUrl      = document.location.protocol+"//"+document.location.host;
instConfig.homeURL         = document.location.protocol+"//"+document.location.host;
instConfig.multiDownloadObjectList = "";

instConfig.retryCompleteCB = false;
instConfig.retryCompleteTimeOut = 3000;
instConfig.vpInstallAndExce = true;

instConfig._reInstallObjectList = "";
instConfig._objectInstType = "";
instConfig._axInfoList     = null;
instConfig._timer = {};
instConfig._vpExecCount = 0;
instConfig._isLoadVeraport = false;
instConfig._errCount = 0;
instConfig._errMessage = {};

/***********************************
 * VERAPORT install/run Function
 * - VP_axInstallVP(objectName, confirmUnload, isVpInstall)
 *   VP_axInstallVP_handlerCB(result, param)
 * - VP_axInstallCB()
 *   VP_axInstallCB_handlerCB(result, param)
 * - VP_objectLoad()
 * - VP_handlerLoad()
***********************************/
function VP_axInstallVP_handlerCB(result, param) {
    VP_axInstallVP(param.objectInstType, param.confirmUnload, param.isVpInstall, false);
}
function VP_axInstallVP(objectInstType, confirmUnload, isVpInstall, isCB) { //통합설치 실행
    if (typeof(isCB) == "undefined") isCB = true;
    if (VP_config.useHandler && isCB && instConfig._axInfoList == null) {
        execVP_getAxInfo(VP_axInstallVP_handlerCB,{"objectInstType":objectInstType,"confirmUnload":confirmUnload,"isVpInstall":isVpInstall});
        return;
    }

    //alert(objectInstType + ":"+ confirmUnload + ":" + isVpInstall);
    if (typeof(objectInstType) == "undefined") objectInstType = instConfig.objectDefType;
    if (typeof(confirmUnload) == "undefined") confirmUnload = false;
    if (typeof(isVpInstall) == "undefined") isVpInstall = false;
    instConfig._objectInstType = objectInstType;
    //alert(objectInstType + ":"+ confirmUnload + ":" + isVpInstall);

    if (isVpInstall == false) {
        if (instConfig._axInfoList == null) VP_reloadAxInfo();
        if (!vp_isUse()) {
            alert(instMsg.result[instCode.RESULT_NOT_SUP]); //"통합설치프로그램(VeraPort)이 지원하지 않은 환경입니다."
        } else if (!vp_checkVp20Install(false)) {
            customAlert({title: '알림', message: instMsg.result[instCode.RESULT_INST_NO], type: 'confirm'}, function () {
                vp_goVp20InstallPage();
            });
        } else {
            if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false);
            var unInstallCnt = fn_getUninstallCnt(objectInstType, false);
            if (unInstallCnt == 0 && VP_isReservedInstType(objectInstType) && instConfig._reInstallObjectList == "") {
                VP_axInstallCB();
                return;
            } else if (unInstallCnt < 0) { //나오면 안됨, 배포파일을 불러오지 못할경우 발생함
                if (instConfig._axInfoList == null) fn_alert("VP_axInstallVP", "instConfig._axInfoList is null\nvp_getLastError: "+vp_getLastError());
                var msg = instMsg.result[instCode.RESULT_INST_ER].replace(/#objectInstType#/g, objectInstType); //"선택하신 보안프로그램이 전부 설치되어 있습니다."
                if (!instConfig._isLoadVeraport) msg = instMsg.notice[instCode.NOTICE_BLOCK_PLUGIN];
                vp_enableBrowser(); //add 2016.06.15
                alert(msg);
                return;
            }
        }
    }

    if (instConfig.isForceInstall && VP_isForceInstallObject(instConfig.P_name)) vp_setForceInstall(instConfig.P_name); //add 2013-04-28
    vp_setKillBrowser(instConfig.killBrowser, instConfig.initialUrl); //add 2013-05-27
    if (instConfig.killBrowser == "" && instConfig.isForceInstall && VP_isForceInstallObject(instConfig.P_name)) vp_setKillBrowser(); //add 2013-05-27

    //alert(instConfig._reInstallObjectList);
    if (instConfig._reInstallObjectList != "") { //add 2015-12-02: SITE_axReInstallVP() 에서  설정됨
        vp_setForceInstall(instConfig._reInstallObjectList);
        instConfig._reInstallObjectList = "";
    }

    if (VP_browserInfo.MSIE) vp_setConfigure(VP_CONF_BLOCKCHECK, 'yes');
    if (VP_platformInfo.Windows && confirmUnload) vp_setConfigure(VP_CONF_CONFIRMUNLOAD, "true"); //선택설치시만 브라우저 강제종료 설정
    //vp_setLanguage("ENG");

    vp_SetSendVpInfo("false");
    if (isVpInstall) vp_SetSendVpInfo("true");
    if (objectInstType == instCode.TYPE_SELECT) objectInstType = instConfig.objectInstList;

    //동일한 설치모듈에서 2개이상의 제품이 설치될 경우 중복된 설치제품을 설치대상에서 제외시킴
    objectInstType = VP_removeObjectOverlapList(objectInstType, instConfig.objectOverlapList); //add 2016-11-03
    //{alert(objectInstType); VP_axInstallCB(); return;}

    VP_axInstall(VP_TYPE_MUST, true, objectInstType);
    //if (isVpInstall && !VP_config.useHandler) vp_SetSendVpInfo("false");
    if (VP_platformInfo.Windows && !vp_isInstallCB() && !VP_config.useHandler) VP_axInstallCB(); //modify 2013.03.04
}

function VP_axInstallCB_handlerCB(result, param) {
    VP_axInstallCB(false);
}
function VP_axInstallCB(isCB) {
    if (typeof(isCB) == "undefined") isCB = true;
    if (VP_config.useHandler && isCB) {
        execVP_getAxInfo(VP_axInstallCB_handlerCB);
        return;
    }

    instConfig._vpExecCount++;
    vp_delay(500);
    if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false);
    vp_setLanguage(VP_SystemLang);
    if (VP_isForceInstallObject(instConfig.P_name)) VP_setForceInstallObject("_" + instConfig.P_name + "_");
    VP_reloadAxInfo();

    //설치 완료메시지가 비정상일경우 재시도 처리:
    var unInstallCnt = fn_getUninstallCnt(instConfig._objectInstType, true);
    if (instConfig.retryCompleteCB && VP_platformInfo.Windows && typeof(vp_getObject().IsRunning)!="undefined" && unInstallCnt != 0) {
        instConfig.retryCompleteCB = false;
        setTimeout(function(){vp_completeCB();}, instConfig.retryCompleteTimeOut);
        fn_alert("SITE_retryCompleteCB(retry vp_completeCB)", "");
        return;
    }

    if (typeof(SITE_axInstallCB) == "function") {
        SITE_axInstallCB(instConfig._objectInstType, unInstallCnt);
    } else {
        var objectInstType = instConfig._objectInstType;
        var isConfirm = false;
        if (instConfig.isDebug) isConfirm = true;
        if (unInstallCnt == 0 && VP_isReservedInstType(objectInstType)) {
            if (isConfirm) {
                setTimeout(function(){vp_enableBrowser();
                    customAlert({title: '알림', message: instMsg.result[instCode.RESULT_INST_OK], type: 'confirm'}, function () {
                        location.replace(VP_getReturnURL(false));
                    });}, 1000);
            } else {
                setTimeout(function(){vp_enableBrowser(); alert(instMsg.result[instCode.RESULT_INST_OK]); location.replace(VP_getReturnURL(false));}, 1000);
            }
            return;
        }
        vp_enableBrowser();
        if (instConfig.isDebug) alert("VP_axInstallCB: objectInstType[" + objectInstType + "][" + instConfig.objectInstList + "] unInstallCnt[" + unInstallCnt + "]");
    }
}

var _vp_object_load = true;
var _vp_object_load_error = 0;
var _vp_handler_load = 0;
var _vp_object_unblock_msg = true;
function VP_handlerLoad(isInstall) {
    if (isInstall) {
        VP_objectLoad();
        return false;
    }
    if (++_vp_handler_load >= 3) { //3번이상 호출시 베라포트 미설치로 처리
        _vp_object_load = false;
        document.cookie="_vp_object_load=N; path=/;";
    }
    return true; //reTry
}

//TODO 버전 체크시 화면 멈춤 현상 있음 
function VP_objectLoad() {
    if (!vp_isUse()) return false; //timer stop
    if (document.getElementById("Vp20Ctl") != null && _vp_object_load) {
        alert("VP_config.isCreateObject change the value from [" + VP_config.isCreateObject + "] to [false]");
    }

    try {
        var objstr = fn_getVpObjectStr("Vp20Ctl", false);
        if (VP_config.useHandler) objstr = ""; //TODO 설치체크
        if (objstr !== "") fn_updateElementByValue("VP_object_load", "", objstr, true);
        if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false); //add 2014/08/18

        if (!vp_checkVp20Install(false)) {
            if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false);
            _vp_object_load = false;
            document.cookie="_vp_object_load=N; path=/;";
            fn_updateElementByValue("VP_object_load", "", "", true);
            return true; //reTry
        }
        else if (vp_getObject() == null && !VP_config.useHandler) {
            _vp_object_load_error++;
            fn_updateElementByValue("VP_object_load", "", "", true);
            if (_vp_object_load_error <= 3) return true; //reTry
            fn_alert("VP_objectLoad", "vp_getObject() is null: _vp_object_load_error: "+_vp_object_load_error);
            setTimeout(function(){if (typeof(fn_reload)=="function") fn_reload(); else location.reload();}, 500);
            return false;
        }
        else {
            //TODO: Blocked veraport(Chrome)
            try {
               vp_getObject().SetConfigure(VP_CONF_SELECTOBJECT,"");
            } catch (err) {
                //_vp_object_load_error++;
                if (err.name == "TypeError" && !VP_config.useHandler) {
                    if (VP_platformInfo.Mac && VP_browserInfo.Safari) _vp_object_unblock_msg = false; //add 2017-01-12, 맥(사파리)에서는 차단감지 메시지 사용안함
                    if (_vp_object_unblock_msg) alert(instMsg.notice[instCode.NOTICE_BLOCK_PLUGIN]);
                    _vp_object_unblock_msg = false;
                    //fn_alert("VP_objectLoad", "Blocked veraport: _vp_object_load_error: "+_vp_object_load_error+"\nError: "+err);
                    fn_updateElementByValue("VP_object_load", "", "", true);
                    return true;  //reTry
                }
            }
            if (_vp_object_load_error > 0) fn_alert("VP_objectLoad", "vp_getObject() load OK: _vp_object_load_error: "+_vp_object_load_error);

            //VeraPort new install check
            var isVpInstall = false;
            if (_vp_object_load == false || vp_getCookie("_vp_object_load") == "N") {
                _vp_object_load = true;
                document.cookie="_vp_object_load=Y; path=/;";
                isVpInstall = true;
            }

            vp_init();
            instConfig._isLoadVeraport = true;
        }
    } catch(err) {
        _vp_object_load_error++;
        fn_updateElementByValue("VP_object_load", "", "", true);
        fn_alert("VP_objectLoad", "_vp_object_load_error:"+_vp_object_load_error+"\nError: "+err);
        if (_vp_object_load_error <= 5) return true; //reTry
        setTimeout(function(){if (typeof(fn_reload)=="function") fn_reload(); else location.reload();}, 5000);
        return false;
    }

    if (typeof(VP_loadCB) == "function") VP_loadCB(isVpInstall);
    return false;
}


/***********************************
 * VERAPORT_ETC Function
 * - VP_getObjectStatus(objectName)
 * - VP_getObjectDownload(objectName, isBackupURL)
 * - VP_reloadAxInfo(forceObjectList)
 * - VP_setForceInstallObject(objectName)
 * - VP_isForceInstallObject(objectName)
 * - VP_isReloadInstallObject(isRemove)
 * - VP_isReservedInstType(objectName)
 * - VP_getReturnURL(isHome)
 * - VP_removeObjectOverlapList(objectInstList, objectOverlapList)
***********************************/
function VP_getObjectStatus(objectName) {
    if (objectName == instCode.VERAPORT) {
        if (!vp_isUse()) {
            return instCode.STATUS_NOT_SUP; //미지원
        } else if (vp_checkVp20Install(false)) {
            //if (instConfig._isLoadVeraport == false) return instCode.STATUS_INST_BK; //TODO: Blocked veraport
            return instCode.STATUS_INST_OK; //설치됨
        } else {
            return instCode.STATUS_INST_NO; //미설치
        }
    }

    if (!(vp_checkVp20Install(false) && instConfig._isLoadVeraport)) return instCode.STATUS_NOT_CHK; //미확인
    //if (instConfig._axInfoList == null) VP_reloadAxInfo(); //TODO: delete ?

    /* add 2013.04.11 베라포트 차단/배포파일 오류로 인하여 확인 불가 */
    if (instConfig._axInfoList == null) return instCode.STATUS_NOT_CHK;

    var axInfo = vp_getAxInfo(instConfig._axInfoList, objectName);
    if (axInfo == null) return instCode.STATUS_NOT_SUP; //미지원;
    if (axInfo.installStatus) {
        if (typeof(axInfo.forceInstall) != "undefined" && axInfo.forceInstall == true) return instCode.STATUS_INST_RE; //설치됨(재설치)
        if (typeof(axInfo.installStatusEnable) != "undefined" && axInfo.installStatusEnable == false) return  instCode.STATUS_INST_BK; //설치됨(차단됨)
        return instCode.STATUS_INST_OK; //설치됨
    }
    if (typeof(axInfo.updateStatus) != "undefined" && axInfo.updateStatus) return  instCode.STATUS_INST_UP; //미설치(업데이트)
    return instCode.STATUS_INST_NO; //미설치
}
function VP_getObjectDownloadURL(objectName, isBackupURL) {
    if (typeof(isBackupURL) == "undefined") isBackupURL = false;

    if (VP_getObjectStatus(instCode.VERAPORT) != instCode.STATUS_INST_OK) return ""; //베라포트 미설치됨
    var axInfo = vp_getAxInfo(instConfig._axInfoList, objectName);
    if (axInfo == null) return ""; //해당 제품정보 없음

    var downloadURL = axInfo.downloadURL;
    if (isBackupURL == true) downloadURL = axInfo.backupURL;
    var idx = downloadURL.indexOf(" ");
    if (idx>0) downloadURL = downloadURL.substring(0, idx);
    idx = downloadURL.indexOf("#");
    if (idx>0) downloadURL = downloadURL.substring(0, idx);
    return downloadURL;
}

function VP_reloadAxInfo(forceObjectList) {
    if (typeof(forceObjectList) == "undefined") forceObjectList = "";
    if (forceObjectList != "") {
        vp_setForceInstall(forceObjectList);
    } else {
        vp_setForceInstall("");
        if (instConfig.isForceInstall && VP_isForceInstallObject(instConfig.P_name)) vp_setForceInstall(instConfig.P_name);
    }
    if (!VP_platformInfo.Windows && VP_platformSupport.MultiOS) vpm_loadInfo(); //multiOS

    instConfig._axInfoList = vp_getAxInfoList();
    if (instConfig._axInfoList == null) {
        //fn_alert("VP_reloadAxInfo", "instConfig._axInfoList is null: vp_init()");
        if (!VP_platformInfo.Windows && VP_platformSupport.MultiOS) vpm_inited = false; //multiOS
        vp_init();
        instConfig._axInfoList = vp_getAxInfoList();
    }
}
function VP_setForceInstallObject(objectName) {
    if (objectName == "") return;
    document.cookie = "_vp_forceInstallObject=" + objectName + "; path=/;";
}
function VP_isForceInstallObject(objectName) {
    var orgName = vp_getCookie("_vp_forceInstallObject");
    if (orgName == "" || orgName != objectName) return false;
    return true;
}
function VP_isReloadInstallObject(isRemove) {
    var isReload = false;
    if (instConfig.P_name == "") return true; //P_name이 없으면 무시
    if (typeof(isRemove) == "undefined") isRemove = false;

    if (isRemove == true) {
        document.cookie="_vp_reloadInstallObject=_" + instConfig.P_name + "_; path=/;"; //설정제거(VP_getReturnURL에서 처리)
    } else {
        if (instConfig.P_name == vp_getCookie("_vp_reloadInstallObject")) isReload = true; //새로고침확인
        document.cookie="_vp_reloadInstallObject=" + instConfig.P_name + "; path=/;";
    }
    //alert("remove=" + isRemove + ":reload=" + isReload);
    return isReload;
}
function VP_isReservedInstType(objectName) {
    if ( instConfig._objectInstType == instCode.TYPE_ALL
      || instConfig._objectInstType == instCode.TYPE_MUST
      || instConfig._objectInstType == instCode.TYPE_SELECT ) return true;
    return false;
}
function VP_getReturnURL(isHome)  {
    VP_setForceInstallObject(instConfig.P_name); //add 2013-04-28
    VP_isReloadInstallObject(true);

    if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false);
    var url = instConfig.returnURL;
    if (isHome || url == "") url = instConfig.homeURL;
    return url;
}
function VP_removeObjectOverlapList(objectInstList, objectOverlapList) {
    if (objectOverlapList == "") return objectInstList;
    if (objectInstList == instCode.TYPE_MUST || objectInstList == instCode.TYPE_ALL) return objectInstList; //필수설치,전체설치제외

    var realObjectInstList = objectInstList;
    var arrayOverlapList = objectOverlapList.split(";");
    for(var i=0;i<arrayOverlapList.length;i++) {
        if (arrayOverlapList[i] == "") continue;
        var unistCnt = fn_getUninstallCntObject(arrayOverlapList[i]);
        if (unistCnt <= 1) continue;

        //미설치가 2개이상일경우 해당 objectName 제거
        var arrayObject = arrayOverlapList[i].split(",");
        for(var j=1;j<arrayObject.length;j++) {
            realObjectInstList = realObjectInstList.replace(","+arrayObject[j], "");
        }
    }
    return realObjectInstList;
}

/***********************************
 * VERAPORT Uninstall_Count Function
 * - fn_getUninstallCnt(objectName, retry)
 * - fn_getUninstallCntObject(objectName)
 * - fn_getUninstallCntAll()
 * - fn_getUninstallCntMust()
 * - fn_getUninstallCntOpt()
 * - fn_getUninstallCnt_(installType)
***********************************/
function fn_getUninstallCnt(objectName, retry) {
    var unInstallCnt = -1;

    if (objectName == instCode.TYPE_MUST) {
        unInstallCnt = fn_getUninstallCntMust();
    } else if (objectName == instCode.TYPE_ALL) {
        unInstallCnt = fn_getUninstallCntAll();
    } else {
        if (objectName == instCode.TYPE_SELECT) objectName = instConfig.objectInstList;
        unInstallCnt = fn_getUninstallCntObject(objectName);
    }

    //install target nothing 2014-02-04: vp_getObject().GetLastErrorCode()==27
    if (instConfig._axInfoList == null && VP_browserInfo.MSIE && VP_platformInfo.x64) {
        fn_alert("fn_getUninstallCnt:Win64", "unInstallCnt: "+unInstallCnt + " _axInfoList: " + instConfig._axInfoList);
        unInstallCnt = 0;
    }

    if (unInstallCnt == -1 && retry) {
        fn_alert("fn_getUninstallCnt:Retry", "unInstallCnt: "+unInstallCnt + " _axInfoList: " + instConfig._axInfoList);
        vp_delay(1000);
        if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false);
        VP_reloadAxInfo();
        return fn_getUninstallCnt(objectName, false);
    }
    return unInstallCnt;
}
function fn_getUninstallCntObject(objectName) {
    if (instConfig._axInfoList == null) return -1;
    var unInstallCnt = 0;
    var arrayObject = objectName.split(",");
    for(var i=0;i<arrayObject.length;i++) {
        var axInfo = vp_getAxInfo(instConfig._axInfoList, arrayObject[i]);
        if (axInfo !== null) {
            if (axInfo.installStatusEnable == false || axInfo.allowrun == false) unInstallCnt++;
        }
    }
    //alert("fn_getUninstallCntObject", "arrayObject[" + arrayObject + "] cnt[" + unInstallCnt + "]");
    return unInstallCnt;
}
function fn_getUninstallCntAll()  { return fn_getUninstallCnt_("");      }
function fn_getUninstallCntMust() { return fn_getUninstallCnt_("must");  }
function fn_getUninstallCntOpt()  { return fn_getUninstallCnt_("option");}
function fn_getUninstallCnt_(installType) {
    if (instConfig._axInfoList == null) return -1;
    var unInstallCnt = 0;
    for(var i=0;i<instConfig._axInfoList.length;i++) {
        var axInfo = vp_getAxInfo(instConfig._axInfoList, instConfig._axInfoList[i].objectname);
        if (axInfo !== null) {
            //alert(axInfo.objectName + ":" + axInfo.installStatus)
            //if (axInfo.installStatus == false) unInstallCnt++;
            //if (axInfo.installStatus == false) {
            if (axInfo.installStatusEnable == false || axInfo.allowrun == false) {
                if (installType == null || installType == "") {
                    unInstallCnt++;
                } else if (axInfo.installType == installType) { //must, option
                    unInstallCnt++;
                }
            }
        }
    }
    //alert("fn_getUninstallCnt_", "installType[" + installType + "] cnt[" + unInstallCnt + "]");
    return unInstallCnt;
}


/***********************************
 * ETC Function
 * - fn_alert(fnName, rMsg)
 * - fn_getVpObjectStr(objectID, isCabInstall)
 * - fn_getVpDownloadURL(pkgType)
 * - fn_updateElementByValue(elementId, value, innerHTML, isErrCheck)
 * - fn_updateElementByDisplayON(elementId, isErrCheck)
 * - fn_updateElementByDisplayOFF(elementId, isErrCheck)
 * - fn_updateElementByDisplay_(elementId, display, isErrCheck)
 * - fn_getUrlParameter(name)
***********************************/
function fn_alert(fnName, rMsg) {
    instConfig._errCount++;
    instConfig._errMessage[instConfig._errCount] = "function(" + fnName + ")\n" + rMsg;
    if (instConfig.isDebug) alert(instConfig._errMessage[instConfig._errCount]);
}
function fn_getVpObjectStr(objectID, isCabInstall) {
    var objstr = "";
    if (!VP_browserInfo.MSIE) {
        //add 2010.08.23
        var myMimetype = navigator.mimeTypes[VP_config.mimeType];
        if ( myMimetype && vp_checkVp20Plugin()) {
            objstr += '<embed ID="' + objectID + '" width="0" height="0" ';
            //objstr += 'codeBaseURL="' +  VP_config.cabURL + '#version=' + VP_config.version + '" ';
            objstr += 'type="' + VP_config.mimeType + '" />';
        }
    }
    else {
        //objstr += '<object id="Vp20Ctl" width="1" height="1" classid="';
        objstr += '<object id="' + objectID + '" width="1" height="1" style="visibility:hidden;"  classid="';
        objstr += VP_config.CLSID;
        objstr += '" codebase="';
        if (isCabInstall) objstr += VP_config.cabURL; ////modify 2012.07.30
        objstr += '#version=';
        objstr += VP_config.version;
        objstr += '"></object>';
    }
    //alert(objstr);
    return objstr;
}
function fn_getVpDownloadURL(pkgType, checkBlock) {
    if (typeof(checkBlock) == "undefined") checkBlock = false;
    if (checkBlock == true) {
        fn_checkBlocked(false, true, false);
        if (vp_checkVp20Install(false) && !instConfig._isLoadVeraport) {
            alert(instMsg.notice[instCode.NOTICE_BLOCK_PLUGIN]);
        }
    }

    var downURL = VP_config.exeURL;
    if (pkgType == "DEV") {
        downURL = vpm_pkg.Dev32;
        if (VP_platformInfo.x64) downURL = vpm_pkg.Dev64;
    } else if (pkgType == "RPM") {
        downURL = vpm_pkg.Rpm32;
        if (VP_platformInfo.x64) downURL = vpm_pkg.Rpm64;
    } else if (VP_platformInfo.Mac) {
        downURL = vpm_pkg.Mac32;
        if (VP_platformInfo.x64) downURL = vpm_pkg.Mac64;
    } else if (VP_platformInfo.Ubuntu) {
        downURL = vpm_pkg.Dev32;
        if (VP_platformInfo.x64) downURL = vpm_pkg.Dev64;
    } else if (VP_platformInfo.Fedora) {
        downURL = vpm_pkg.Rpm32;
        if (VP_platformInfo.x64) downURL = vpm_pkg.Rpm64;
    }
    return downURL;
}
function fn_updateElementByValue(elementId, value, innerHTML, isErrCheck) {
    if (typeof(isErrCheck) == "undefined") isErrCheck = true;
    try {
        var ele = document.getElementById(elementId);
        if (ele == null) {
            if (isErrCheck) alert("fn_updateElementByValue(" + elementId + ")" + " is not found. (HTML Check and Modify)");
            return;
        }
        ele.value = value;
        ele.innerHTML = innerHTML;
    } catch(err) {
        alert("fn_updateElementByValue[" + elementId + "][" + err.description + "]");
    }
}
function fn_updateElementByDisplayON(elementId, isErrCheck) {
    fn_updateElementByDisplay_(elementId, "", isErrCheck);
}
function fn_updateElementByDisplayOFF(elementId, isErrCheck) {
    fn_updateElementByDisplay_(elementId, "none", isErrCheck);
}
function fn_updateElementByDisplay_(elementId, display, isErrCheck) {
    if (typeof(isErrCheck) == "undefined") isErrCheck = true;
    try {
        var ele = document.getElementById(elementId);
        if (ele == null) {
            if (isErrCheck) alert("fn_updateElementByDisplay(" + elementId + ")" + " is not found. (HTML Check and Modify)");
            return;
        }
        ele.style.display = display;
    } catch(err) {
        alert("fn_updateElementByDisplay[" + elementId + "][" + err.description + "]");
    }
}
function fn_getUrlParameter(name) {
    var value = "";
    try {
        var url = document.location.href;
        var idx = url.indexOf("?");
        var params = "&"+url.substring(idx+1);
        idx = params.indexOf("&" + name + "=");
        if (idx >= 0) value = params.substring(idx+name.length+2);
        idx = value.indexOf("&");
        if (idx >= 0) value = value.substring(0, idx); //mod 2012.11.15

        //XSS방지코드 추가/START
        value = value.replace(/\</gi, "&lt;");
        value = value.replace(/\>/gi, "&gt;");
        value = value.replace(/\&/gi, "&amp;");
        value = value.replace(/\"/gi, "&qout;");
        value = value.replace(/\'/gi, "&#039;");
        //XSS방지코드 추가/END

        if (typeof(decodeURIComponent) == "function") value = decodeURIComponent(value); //mod 2013.11.13 IE5
        //alert("fn_getUrlParameter[" + name + "][" + value + "]\n\n" + params);

    } catch(err) { alert("fn_getUrlParameter[" + name + "," + err.description + "]");}
    return value;
}


/***********************************
 * TEST/DEBUG Function
 * - fn_checkBlocked(cookieWarning, activeXFilterWarning, x64msieWarning)
 * - fn_vpmTestUI(type)
 * - fn_getAxinfoString()
 * - fn_alertLastError()
 * - fn_getInstConfigString()
 * - fn_getDebugInfoString()
***********************************/

function fn_checkBlocked(cookieWarning, activeXFilterWarning, x64msieWarning) {
    try {
        if (cookieWarning) {
            document.cookie="cookieTEST=test; path=/;";
            if (vp_getCookie("cookieTEST") != "test") alert(instMsg.notice[instCode.NOTICE_BLOCK_COOKIE]);
        }
        if (activeXFilterWarning && !VP_config.useHandler) {
            if (typeof window.external != "undefined"
                && typeof window.external.msActiveXFilteringEnabled != "undefined"
                && window.external.msActiveXFilteringEnabled() == true) {
                alert(instMsg.notice[instCode.NOTICE_BLOCK_ACTIVEX]);
            }
        }
        if (x64msieWarning && VP_platformInfo.Windows && VP_platformInfo.x64) alert(instMsg.notice[instCode.NOTICE_WARNING_X64]);
        if (instConfig.mobileWarning && VP_platformInfo.Mobile) alert(instMsg.notice[instCode.NOTICE_WARNING_MOBILE]);
        if (instConfig.edgeWarning && VP_browserInfo.Edge) alert(instMsg.notice[instCode.NOTICE_WARNING_EDGE]);
    } catch(err) { };
}
function fn_vpmTestUI(type) {
    VP_TYPE_MUST = type;
    try {
        if (typeof(SITE_disableBrowser) == "function" && SITE_disableBrowser("working")) return;
        vpm_showDialog(type);
        VP_setInstallList(pluginInfo2JSON());
        VP_setInstallMessage(vpm_getMessage("success"));
        VP_setInstallStage(10);
        VP_setInstallProgress(10);
        setTimeout("vp_enableBrowser();VP_complete();", 3000);
    } catch (err) {
        alert("VeraPort not Installed\n" + err.description);
        vp_enableBrowser(); VP_complete();
    }
}
function fn_getAxinfoString() {
    if (instConfig._axInfoList == null) return "instConfig._axInfoList is null";
    var info = "";
    for(var i=0;i<instConfig._axInfoList.length;i++) {
        var axInfo = vp_getAxInfo(instConfig._axInfoList, instConfig._axInfoList[i].objectname);
        if (axInfo !== null) {
            info += "["+(i+1)+"]["+axInfo.objectName+"]["+axInfo.installType+"]["+axInfo.objectVersion+"->"+axInfo.localVersion+"][install="+axInfo.installStatus+"]\n";
            info += "["+axInfo.displayName+"][enable="+axInfo.installStatusEnable+",update="+axInfo.updateStatus+",force="+axInfo.forceInstall+"]";
            info += "\n\n";
        }
    }
    return info;
}
function fn_alertLastError() {
    if (VP_config.useHandler) {
        vp20.handler.getLastErrorMsg({success:function(res){ alert("["+res.res + "] " + res.data); } }).invoke();
    } else {
        alert(vp_getLastError());
    }
}
function fn_getInstConfigString() {
    var info = "";
    info += "VP_TYPE_MUST=[" + VP_TYPE_MUST + "]\n";
    info += "instConfig.objectDefType=[" + instConfig.objectDefType + "]\n";
    info += "instConfig.isCabInstall=[" + instConfig.isCabInstall + "]\n";
    info += "instConfig.P_name=[" + instConfig.P_name + "]\n";
    info += "instConfig.returnURL=[" + instConfig.returnURL + "]\n";
    info += "\n";

    info += "instConfig.isForceInstall=[" + instConfig.isForceInstall + "]\n";
    info += "instConfig.killBrowser=[" + instConfig.killBrowser + "]\n";
    info += "instConfig.initialUrl=[" + instConfig.initialUrl + "]\n";
    info += "instConfig.homeURL[" + instConfig.homeURL + "]\n";
    info += "instConfig.multiDownloadObjectList=[" + instConfig.multiDownloadObjectList + "]\n";
    info += "\n";

    info += "instConfig._objectInstType=[" + instConfig._objectInstType + "]\n";
    info += "instConfig._isLoadVeraport=[" + instConfig._isLoadVeraport + "]\n";

    if (instConfig._axInfoList == null) {
        info += "instConfig._axInfoList=[null]\n";
    } else {
        info += "instConfig._axInfoList=[load OK]\n";
    }
    info += "instConfig.objectInstList=[" + instConfig.objectInstList + "]\n";
    info += "instConfig.objectUpdateList=[" + instConfig.objectUpdateList + "]\n";

    info += "\n";

    var arrayObject = instConfig.objectInstList.split(",");
    for(i=0;i<arrayObject.length;i++) {
        var objectName = arrayObject[i];
        if (objectName == "") continue;
        info += "objectStatus[" + objectName + "]=[" + instConfig._timer[objectName] + "]";
        info += "[" + instMsg.status[VP_getObjectStatus(objectName)] + "]";
        try {
            var axInfo = vp_getAxInfo(instConfig._axInfoList, objectName);
            info += "[" + axInfo.installType   + "]";
            info += "[" + axInfo.objectVersion + "]";
            info += "[" + axInfo.installStatus + "]";
            info += "[" + axInfo.forceInstall  + "]";
        } catch (err) {}
        info += "\n";
    }
    info += "objectStatus[" + instCode.VERAPORT + "]=[" + instConfig._timer[instCode.VERAPORT] + "]";
    info += "[" + instMsg.status[VP_getObjectStatus(instCode.VERAPORT)] + "][option][" + VP_config.version + "]\n";
    info += "\n";

    info += "instConfig._vpExecCount=[" + instConfig._vpExecCount + "]\n";
    info += "instConfig._errCount=[" + instConfig._errCount + "]\n";
    for(j=1;j<=instConfig._errCount;j++) {
        info += "[" + j + "]"+ instConfig._errMessage[j] + "\n";
    }
    info += "\n";

    info += "systemInfo=["+VP_platformInfo.type+","+VP_platformInfo.name+"]["+VP_browserInfo.name+","+VP_browserInfo.version+"]\n"+navigator.userAgent;

    return info;
}
function fn_getDebugInfoString() {
    var info = "";
    info += "<center><br/>";
    info += '<a href="javascript:alert(fn_getInstConfigString());">viewConfig</a> ';
    info += '<a href="javascript:alert(fn_getAxinfoString());">viewAxInfo</a> ';
    info += '<a href="javascript:fn_alertLastError();">lastErr</a> ';
    info += '<a href="javascript:alert(document.cookie);">viewCookie</a> ';
    info += '<a href="javascript:VP_reloadAxInfo();fn_objectUpdateByList(SITE_objectUpdate, instConfig.objectInstList);">reloadAxInfo</a> ';
    if (objectCheck.init) info += '<a href="javascript:javascript:SITE_installCheck_start();">installCheck</a> ';
    if (VP_platformInfo.Windows) info += '<a href="javascript:javascript:VP_axManage();">axManage</a> ';
    if (VP_platformSupport.MultiOS) {
        info += "UI[";
        info += '[<a href="javascript:fn_vpmTestUI(VP_TYPE_NORMAL);">normal</a>]';
        info += '[<a href="javascript:fn_vpmTestUI(VP_TYPE_NORMAL_NAME);">normalname</a>]';
        info += '[<a href="javascript:fn_vpmTestUI(VP_TYPE_NORMAL_DESC);">normaldesc</a>]';
    }
    if (VP_config.useHandler) info += ' <a href="javascript:vp20.handler.execute();">execute</a> ';
    info += "<br/>" + document.cookie + "</center><br/>";
    return info;
}


/***********************************
 * Display Status/Print Function
 * - fn_isMultiDownloadObject(objectName)
 * - fn_vpMsgUpdate()
 * - fn_vpBtnUpdate()
 * - fn_objectUpdateByList(objectInstList)
 * - fn_objectUpdate(objectName, objectStatus, statusMsg)
***********************************/
function fn_isMultiDownloadObject(objectName) {
    var arrayObject = instConfig.multiDownloadObjectList.split(",");
    for(var i=0;i<arrayObject.length;i++) {
        if (arrayObject[i] == objectName) return true;
    }
    return false;
}
function fn_vpMsgUpdate() {
    var reTry = false;
    try {
        if (vp_checkVp20Install(false) && instConfig._isLoadVeraport) {
            fn_updateElementByDisplayON ("VP_msg_installed", true);
            fn_updateElementByDisplayOFF("VP_msg_notinstall",true);
            fn_updateElementByDisplayOFF("VP_msg_unsupported",false);
        } else if (!vp_isUse()) { //미지원
            fn_updateElementByDisplayOFF("VP_msg_installed", true);
            fn_updateElementByDisplayOFF("VP_msg_notinstall",true);
            fn_updateElementByDisplayON ("VP_msg_unsupported",false);
        } else { //미설치
            fn_updateElementByDisplayOFF("VP_msg_installed", true);
            fn_updateElementByDisplayON ("VP_msg_notinstall",true);
            fn_updateElementByDisplayOFF("VP_msg_unsupported",false);
            reTry = true;
        }
    } catch(err) { alert("fn_vpMsgUpdate(): " + err); }
    return reTry;
}
function fn_vpBtnUpdate() {
    var reTry = false;
    try {
        if (!vp_isUse()) { //미지원
            fn_updateElementByDisplayOFF("VP_btn_install",   true);
            fn_updateElementByDisplayOFF("VP_btn_installM",  false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_installA",  false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_download",  true);
            fn_updateElementByDisplayOFF("VP_btn_downloadU", false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_downloadF", false); //옵션
        } else if (vp_checkVp20Install(false) && instConfig._isLoadVeraport) { //설치됨
            fn_updateElementByDisplayON ("VP_btn_install",   true);
            fn_updateElementByDisplayON ("VP_btn_installM",  false); //옵션
            fn_updateElementByDisplayON ("VP_btn_installA",  false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_download",  true);
            fn_updateElementByDisplayOFF("VP_btn_downloadU", false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_downloadF", false); //옵션
        } else if (VP_platformInfo.Linux && !VP_platformInfo.Fedora && !VP_platformInfo.Ubuntu) { //미설치 Linux
            fn_updateElementByDisplayOFF("VP_btn_install",   true);
            fn_updateElementByDisplayOFF("VP_btn_installM",  false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_installA",  false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_download",  true);
            fn_updateElementByDisplayON ("VP_btn_downloadU", false); //옵션
            fn_updateElementByDisplayON ("VP_btn_downloadF", false); //옵션
            reTry = true;
        } else { //미설치
            fn_updateElementByDisplayOFF("VP_btn_install",   true);
            fn_updateElementByDisplayOFF("VP_btn_installM",  false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_installA",  false); //옵션
            fn_updateElementByDisplayON ("VP_btn_download",  true);
            fn_updateElementByDisplayOFF("VP_btn_downloadU", false); //옵션
            fn_updateElementByDisplayOFF("VP_btn_downloadF", false); //옵션
            reTry = true;
        }
    } catch(err) { alert("fn_vpBtnUpdate(): " + err); }
    if (!vp_isUse()) reTry = false; //미지원(타이머종료)
    return reTry;
}
function fn_objectUpdateByList(fnExecCB, objectInstList) {
    if (typeof(objectInstList) == "undefined") objectInstList = instConfig.objectInstList;
    var arrayObject = objectInstList.split(",");
    for(i=0;i<arrayObject.length;i++) {
        var objectName = arrayObject[i];
        if (objectName == "") continue;
        //if (instConfig._timer[objectName] == false) {
            if (typeof(fnExecCB) == "function") fnExecCB(objectName);
        //}
    }
}
function fn_objectUpdate(objectName, objectStatus, statusMsg, isStop) {
    var reTry = false;
    try {
        fn_updateElementByValue("object_status_" + objectName, "", statusMsg, true);

        if (objectStatus == instCode.STATUS_NOT_SUP) { //미지원-모든버튼OFF
            fn_updateElementByDisplayON ("object_default_"  + objectName,       false);
            fn_updateElementByDisplayOFF("object_download_" + objectName,       true);
            fn_updateElementByDisplayOFF("object_download_" + objectName + "U", false);
            fn_updateElementByDisplayOFF("object_download_" + objectName + "F", false);
            fn_updateElementByDisplayOFF("object_install_"  + objectName,       false);
            //reTry = true;
        } else if (objectStatus == instCode.STATUS_INST_OK && !instConfig.displayDownload) { //설치됨-모든버튼OFF
            fn_updateElementByDisplayON ("object_default_"  + objectName,       false);
            fn_updateElementByDisplayOFF("object_download_" + objectName,       true);
            fn_updateElementByDisplayOFF("object_download_" + objectName + "U", false);
            fn_updateElementByDisplayOFF("object_download_" + objectName + "F", false);
            fn_updateElementByDisplayOFF("object_install_"  + objectName,       false);
        } else if (VP_platformInfo.Linux && fn_isMultiDownloadObject(objectName) ) { //미설치(차단)-다수다운로드버튼 및 개별설치 ON
            fn_updateElementByDisplayOFF("object_default_"  + objectName,       false);
            fn_updateElementByDisplayOFF("object_download_" + objectName,       true);
            if (VP_platformInfo.Fedora) {
                fn_updateElementByDisplayOFF("object_download_" + objectName + "U", false);
                fn_updateElementByDisplayON ("object_download_" + objectName + "F", false);
            } else if (VP_platformInfo.Ubuntu) {
                fn_updateElementByDisplayON ("object_download_" + objectName + "U", false);
                fn_updateElementByDisplayOFF("object_download_" + objectName + "F", false);
            } else {
                fn_updateElementByDisplayON ("object_download_" + objectName + "U", false);
                fn_updateElementByDisplayON ("object_download_" + objectName + "F", false);
            }
            if (objectStatus != instCode.STATUS_NOT_CHK && objectStatus != instCode.STATUS_INST_BK ) fn_updateElementByDisplayON ("object_install_" + objectName, false);
            if (objectStatus != instCode.STATUS_INST_OK) reTry = true;
        } else if (VP_platformInfo.Linux && !VP_platformInfo.Fedora && !VP_platformInfo.Ubuntu) { //미설치(차단)-다운로드버튼2개 및 개별설치ON
            fn_updateElementByDisplayOFF("object_default_"  + objectName,       false);
            fn_updateElementByDisplayOFF("object_download_" + objectName,       true);
            fn_updateElementByDisplayON ("object_download_" + objectName + "U", false);
            fn_updateElementByDisplayON ("object_download_" + objectName + "F", false);
            if (objectStatus != instCode.STATUS_NOT_CHK && objectStatus != instCode.STATUS_INST_BK ) fn_updateElementByDisplayON ("object_install_" + objectName, false);
            if (objectStatus != instCode.STATUS_INST_OK) reTry = true;
        } else { //미설치(차단)-다운로드버튼1개 및 개별설치버튼 ON
            fn_updateElementByDisplayOFF("object_default_"  + objectName,       false);
            if(objectStatus == instCode.STATUS_INST_OK || objectStatus== instCode.STATUS_INST_BK){
                fn_updateElementByDisplayOFF ("object_download_" + objectName,       false);
            }else{
                fn_updateElementByDisplayON ("object_download_" + objectName,       false);
            }
            fn_updateElementByDisplayOFF("object_download_" + objectName + "U", false);
            fn_updateElementByDisplayOFF("object_download_" + objectName + "F", false);
            if (objectStatus != instCode.STATUS_NOT_CHK && objectStatus != instCode.STATUS_INST_BK ) fn_updateElementByDisplayON ("object_install_" + objectName, false);
            if (objectStatus != instCode.STATUS_INST_OK) reTry = true;
        }
    } catch(err) { alert("fn_objectUpdate(" + objectName + "): " + err); }
    if (!vp_isUse()) reTry = false; //미지원(타이머종료)
    if (!isStop) reTry = true;
    instConfig._timer[objectName] = reTry;
    return reTry;
}
