/**
 *  @name Veraport V2 - install_config.js
 *  @author wizvera
 *  @date 2017.12.07
 *  @include veraport20.js, install_internal.js
 **/

window.alert = function (message) {
    customAlert({title: '알림', message: message, type: 'anything'})
};

//VP_platformInfo.Windows = false; VP_platformInfo.Linux = true; //VP_platformInfo.Ubuntu = true; //리눅스테스트용
//VP_platformInfo.x64 = true; //x64테스트용
//function vp_checkVp20Install() { return false; }; //미설치테스트용
//function vp_isUse() { return false; }; //미지원테스트용
//instConfig.isDebug = true;

//VP_TYPE_MUST = VP_TYPE_FULL;
//VP_TYPE_MUST = VP_TYPE_NORMAL_NAME; //v2.5.6.0 over
//VP_TYPE_MUST = VP_TYPE_NORMAL_DESC; //v2.5.6.0 over

instConfig.P_name = fn_getUrlParameter("P_name"); //설치대상 제품코드(P_name)
instConfig.returnURL = fn_getUrlParameter("url"); //설치완료 후 이동할 이전 페이지
instConfig.homeURL = document.location.protocol + "//" + document.location.host;
if (instConfig.returnURL != "close" && instConfig.returnURL.indexOf(document.location.host) < 0 && instConfig.returnURL != "") instConfig.returnURL = instConfig.homeURL; //외부URL일 경우 homeURL로 변경

//베라포트 설치완료후 자동실행 또는 인자가 없을경우 기본 설치방식
instConfig.objectDefType = instCode.TYPE_SELECT; //instCode.TYPE_MUST, instCode.TYPE_ALL

//instCode.TYPE_SELECT일경우 설치되어야하는 제품리스트
instConfig.objectInstList = "DelfinoG3,ASTx,NXiBASE";

//동작방식(브라우저)에 따른 설치제품 구분 처리, 이기능은 instCode.TYPE_SELECT일 경우만 처리가능함
if (VP_config.useHandler /*VP_browserInfo.Chrome || VP_browserInfo.Edge*/) {
    //instConfig.usePluginModule = false;
    //instConfig.objectInstList = "DelfinoG3,ASTx,TouchEnNxKey";
}

//동일한 설치모듈에서 2개이상의 제품이 설치되는 제품리스트
//instConfig.objectOverlapList = "MarkanyNX,EPSBrokerNX;VoiceEyeNX,WSActiveBridgeNX";

//non-Plugin 동작시 강제로 설치상태 업데이트 처리를 위한 제품리스트
//instConfig.objectUpdateList = instConfig.objectInstList;


instConfig.isCabInstall = false; //Windows IE용 CAB 허용하지 않을경우 주석을 제거하세요
instConfig.mobileWarning = true; //모바일 접속 경고
//instConfig.edgeWarning = true; //Edge 브라우저 접속 경고
//instConfig.x64msieWarning = true; //업무시스템의 보안모듈이 64Bit MSIE를 지원하지 않을경우  주석제거하세요
//instConfig.displayDownload = true; //설치여부에 상관없이 다운로드 버튼을 보여주고고자 할경우 주석 제거하세요
//instConfig.vpInstallAndExce = false; //베라포트 설치 후 자동으로 통합설치를 실행하지 않을경우 주석 제거하세요

//instConfig.isForceInstall = true; //v2.5.3.1 over
//instConfig.killBrowser = "all,confirm"; //"all,confirm", "parent,confirm", "all,silent" //v2.5.5.0 over
//instConfig.initialUrl = document.location.protocol+"//"+document.location.host;

//instConfig.retryCompleteCB = true; //설치 완료메시지가 비정상일경우 재시도 처리
//instConfig.retryCompleteTimeOut = 3000; //필요시 5000으로 변경

instConfig.multiDownloadObjectList = "INISAFEWeb"; //리눅스에서 다중 다운로드 버튼이 필요할경우
if (fn_getUrlParameter("debug") == "on") instConfig.isDebug = true;

if (VP_SystemLang == "KOR") {
    instMsg.status[instCode.STATUS_INST_OK] = "<span class='install_yes'>설치됨</span>"; //설치됨 Installed
    instMsg.status[instCode.STATUS_INST_BK] = "<span class='install_yes'>설치됨</span>"; //설치됨(차단) Installed
    instMsg.status[instCode.STATUS_INST_RE] = "<span class='install_no'>재설치</span>"; //설치됨(재설치) ReInstall
    instMsg.status[instCode.STATUS_INST_UP] = "<span class='install_no'>업데이트</span>"; //미설치(업데이트) Update
    instMsg.status[instCode.STATUS_INST_NO] = "<span class='install_no'>미설치</span>"; //미설치 Not Installed
    instMsg.status[instCode.STATUS_NOT_SUP] = "<span class='install_no'>미지원</span>"; //미지원 unsupported
    instMsg.status[instCode.STATUS_NOT_CHK] = "<span class='install_no'>미설치</span>"; //미확인(베라포트미설치) undefined

    instMsg.result[instCode.RESULT_INST_OK] = "보안프로그램 통합설치가 완료되었습니다.\n[확인]을 클릭하시면 이전페이지로 이동합니다.";
    instMsg.result[instCode.RESULT_INST_ER] = "선택하신 보안프로그램이 전부 설치되어 있습니다.(#objectInstType#)";
    instMsg.result[instCode.RESULT_INST_NO] = "통합설치프로그램(VeraPort)이 설치되지 않았습니다\n설치하시겠습니까?";
    instMsg.result[instCode.RESULT_NOT_SUP] = "통합설치프로그램(VeraPort)이 지원하지 않은 환경입니다.";
    instMsg.result[instCode.RESULT_INST_CK] = "보안프로그램(#objectName#)이 정상적으로 동작하지 않습니다.\n[확인]을 클릭하시면 동작확인 페이지로 이동합니다.";

    instMsg.notice[instCode.NOTICE_BLOCK_COOKIE] = "브라우저 Cookie가 정상적으로 동작하지 않습니다.";
    instMsg.notice[instCode.NOTICE_BLOCK_ACTIVEX] = "Active-X 필터링이 설정되어 있어 프로그램이 정상동작하지 않습니다.\n브라우저 메뉴의 [도구]->[안전]의  ActiveX 필터링 체크를 해제하시기 바랍니다.";
    instMsg.notice[instCode.NOTICE_BLOCK_PLUGIN] = "This plug-in is blocked a security program does not work properly. Please unblock in your browser settings.";
    instMsg.notice[instCode.NOTICE_WARNING_X64] = "64bit 브라우저로 접속하셨습니다.\n\n일부 보안모듈이 64Bit 브라우저를 지원하지 않아 거래가 불가능합니다. 지원가능 브라우저를 확인하시기 바랍니다.";
    instMsg.notice[instCode.NOTICE_WARNING_MOBILE] = "모바일 브라우저는 통합설치를 지원하지 않습니다.";
    instMsg.notice[instCode.NOTICE_WARNING_EDGE] = "Microsoft Edge 브라우저로 접속하셨습니다.\n\n일부 보안모듈이 해당 브라우저를 지원하지 않아 거래가 불가능합니다. 지원가능 브라우저를 확인하시기 바랍니다..";
}
else {
    instMsg.status[instCode.STATUS_INST_OK] = "<span class='install_yes'>Installed</span>"; //설치됨 Installed
    instMsg.status[instCode.STATUS_INST_BK] = "<span class='install_yes'>Installed</span>"; //설치됨(차단) Installed
    instMsg.status[instCode.STATUS_INST_RE] = "<span class='install_no'>ReInstall</span>"; //설치됨(재설치) ReInstall
    instMsg.status[instCode.STATUS_INST_UP] = "<span class='install_no'>Update</span>"; //미설치(업데이트) Update
    instMsg.status[instCode.STATUS_INST_NO] = "<span class='install_no'>Not Installed</span>"; //미설치 Not Installed
    instMsg.status[instCode.STATUS_NOT_SUP] = "<span class='install_no'>unsupported</span>"; //미지원 unsupported
    instMsg.status[instCode.STATUS_NOT_CHK] = "<span class='install_no'>Not Installed</span>"; //미확인(베라포트미설치) undefined

    instMsg.result[instCode.RESULT_INST_OK] = "Integrated installation of security programs is complete.\nClick [Confirm] to go back to previous page.";
    instMsg.result[instCode.RESULT_INST_ER] = "Integrated installation of security programs is complete.(#objectInstType#)";
    instMsg.result[instCode.RESULT_INST_NO] = "Integrated installation program (VeraPort) not installed \nWould you like to install?";
    instMsg.result[instCode.RESULT_NOT_SUP] = "Integrated installation program (VeraPort) does not support this platform.";
    instMsg.result[instCode.RESULT_INST_CK] = "Security Program(#objectName#) does not work properly.\nClick [Confirm] to go to the action confirmation page.";

    instMsg.notice[instCode.NOTICE_BLOCK_COOKIE] = "Browser Cookie is not operating normally.";
    instMsg.notice[instCode.NOTICE_BLOCK_ACTIVEX] = "Active-X filtering is set and the program does not operate normally.\nBrowser, select [Tools]->[Security] please uncheck the ActiveX Filtering.";
    instMsg.notice[instCode.NOTICE_BLOCK_PLUGIN] = "This plug-in is blocked a security program does not work properly. Please unblock in your browser settings.";
    instMsg.notice[instCode.NOTICE_WARNING_X64] = "64bit browser to access points.\n\nSome of the security module is not possible 64Bit browser does not support the deal.";
    instMsg.notice[instCode.NOTICE_WARNING_MOBILE] = "Mobile browser does not support the installation of an integrated";
    instMsg.notice[instCode.NOTICE_WARNING_EDGE] = "Microsoft Edge browser to access points.\n\nSome of the security module is not possible this browser does not support the deal.";

    //VP_config.logoSmall  = VP_BASE_URL + "/sitelogo/logo_small.gif";
    //VP_config.msgSmall   = VP_BASE_URL + "/sitelogo/msg_small.gif";
    //VP_config.msgLarge   = VP_BASE_URL + "/sitelogo/msg_large.gif";
    //VP_config.msgLargeM  = VP_BASE_URL + "/sitelogo/msg_large.gif";
    //VP_config.msgInfo    = VP_BASE_URL + "/sitelogo/msg_info.html";
    //VP_config.msgInfoM   = VP_BASE_URL + "/sitelogo/msg_info.html";
    //VP_config.addInfoURL = VP_BASE_URL + "/siteui/addinfo_en.json";
}

/***********************************
 * 고객사 커스트마이징용 Function
 * - VP_loadCB(isVpInstall)
 *   VP_loadCB_handlerCB(result, param)
 * - SITE_axReInstallVP(objectInstType, confirmUnload, reInstallObjectList)
 * - SITE_axInstallVP(objectInstType, confirmUnload)
 * - SITE_axInstallCB(objectInstType, unInstallCnt)
 * - SITE_vpObjectInstall()
 * - SITE_vpmInstallDialog()
 * - SITE_enableBrowser()
 * - SITE_disableBrowser(message)
 * - fn_goHomePage(isHome)
 * - fn_reload()
 ***********************************
 * 설치완료 후 개별함수를 통한 설치/동작 확인 Function
 * - SITE_installCheck_push(fn_installCheck)
 * - SITE_installCheck_init(applyConfirm, applyCancel)
 * - SITE_installCheck_start()
 * - SITE_installCheck_next(checkResult, objectName)
 ***********************************
 * 설치상태/버튼표시 Timer Function
 * - timer_vpObjectLoad()
 * - timer_vpHandlerLoad(isInstall)
 * - timer_vpMsgUpdate()
 * - timer_vpBtnUpdate()
 * - timer_objectUpdate(objectName)
 * - timer_vpBtnUpdate()
 * - SITE_objectUpdate(objectName, objectStatus)
 ***********************************/

//베라포트 설치/로딩 완료 후 자동으로 호출됨
function VP_loadCB(isVpInstall) {

    var forceObjectList = ""; //"Delfino,Aosmgr";

    if (VP_isReloadInstallObject(false) == false) { //새로고침 또는 재접속시 true 로 리턴됨, 초기화는 정상적으로 페이지이동시 VP_getReturnURL()에서 처리
        forceObjectList = instConfig.P_name;   //해당 제품에 대한 재설치기능 강제로 ON
        instConfig.isForceInstall = true;      //동일 제품명으로 두번이상 설치페이지 호출시 재설치 및 브라우저종료 기능 자동 ON

        /* if (instConfig.P_name == "ASTx") { //개별 솔루션 동작확인 기능 사용시 특정제품 재설치 사용안함
            forceObjectList = "";
            instConfig.isForceInstall = false;
        } */
    }

    //if (!VP_platformInfo.Windows) forceObjectList = ""; //멀티OS 재설치 기능 OFF
    //if (instConfig.P_name=='Aosmgr' && (VP_platformInfo.Mac||VP_platformInfo.Linux)) forceObjectList=instConfig.P_name; //특정제품만 멀티OS에서 재설치 설정
    //forceObjectList = "DelfinoG3,Aosmgr"; //지정제품 무조건 재설치

    VP_reloadAxInfo(forceObjectList); //제품별 설치상태 및 재설치 기능 설정
    //vp_setForceInstall("DelfinoG3"); //재설치테스트용

    //베라포트 신규 설치시 자동실행
    if (VP_config.useHandler) {
        SITE_disableBrowser("checking");
        if (instConfig.objectUpdateList != "") {
            fn_vpMsgUpdate();
            fn_vpBtnUpdate();
            fn_objectUpdateByList(SITE_objectUpdate, instCode.VERAPORT);
        }
        execVP_getAxInfo(VP_loadCB_handlerCB, {"isVpInstall": isVpInstall, "forceObjectList": forceObjectList});
        return;
    } else {
        if (isVpInstall) setTimeout(function () {
            VP_axInstallVP(instConfig.objectDefType, true, true);
        }, 1000);
    }
}

function VP_loadCB_handlerCB(result, param) {
    VP_reloadAxInfo(param.forceObjectList);

    if (instConfig.objectUpdateList != "") {
        fn_objectUpdateByList(SITE_objectUpdate, instConfig.objectUpdateList); //설치상태 강제 업데이트
        vp_delay(500);
    } else {
        fn_vpMsgUpdate();
        fn_vpBtnUpdate();
        vp_delay(2500);
    }
    SITE_enableBrowser();

    if (param.isVpInstall && instConfig.vpInstallAndExce && !SITE_disableBrowser("working")) {
        setTimeout(function () {
            VP_axInstallVP(instConfig.objectDefType, true, true);
        }, 1000);
    } else if (typeof(SITE_vpUninstallCnt) == "function") {
        var unInstallCnt = fn_getUninstallCnt(instConfig.objectDefType, false);
        setTimeout(function () {
            SITE_vpUninstallCnt(unInstallCnt, param.isVpInstall);
        }, 500);
    }
}

//통합재설치 실행: reInstallObjectList 설정 후 통합설치 실행
function SITE_axReInstallVP(objectInstType, confirmUnload, reInstallObjectList) {
    //reInstallObjectList = "Aosmgr";
    if (typeof(reInstallObjectList) == "undefined") reInstallObjectList = "";
    instConfig._reInstallObjectList = reInstallObjectList;

    if (instConfig._reInstallObjectList != "" && instConfig.P_name != "") instConfig._reInstallObjectList += ",";
    instConfig._reInstallObjectList += instConfig.P_name;

    SITE_axInstallVP(objectInstType, confirmUnload);
}

//통합설치 실행: 설치완료 후 SITE_axInstallCB() 가 호출됨
function SITE_axInstallVP(objectInstType, confirmUnload) {
    if (SITE_disableBrowser("working")) return;

    var veraportStatus = VP_getObjectStatus(instCode.VERAPORT);
    if (veraportStatus == instCode.STATUS_NOT_SUP) {
        alert(instMsg.result[instCode.RESULT_NOT_SUP]); //"통합설치프로그램(VeraPort)이 지원하지 않은 환경입니다."
    } else if (veraportStatus == instCode.STATUS_INST_BK) {
        alert(instMsg.notice[instCode.NOTICE_BLOCK_PLUGIN]);
    } else if (veraportStatus != instCode.STATUS_INST_OK) {
        fn_download_Veraport('');
        removeLoading();
        // if (confirm(instMsg.result[instCode.RESULT_INST_NO])) vp_goVp20InstallPage(); //"통합설치프로그램(VeraPort)이 설치되지 않았습니다\n설치하시겠습니까?"
    } else {
        if (typeof isVeraportInstalling !== 'undefined') {
            isVeraportInstalling = true;
        }
        VP_axInstallVP(objectInstType, confirmUnload, false); //통합설치 실행
    }
}

//통합설치 완료 후 호출: 미설치가 없을경우 설치완료메시지 출력 후 fn_goHomePage() 호출
function SITE_axInstallCB(objectInstType, unInstallCnt) {
    var isConfirm = true; //설치완료 메시지알림을 confirm으로 사용시  true로 변경
    if (instConfig.isDebug) isConfirm = true;

    if (instConfig.objectUpdateList != "") fn_objectUpdateByList(SITE_objectUpdate, instConfig.objectUpdateList); //설치상태 강제 업데이트

    if (unInstallCnt == 0 && VP_isReservedInstType(objectInstType)) {
        //메시지업데이트를 위해 delay처리: "보안프로그램 통합설치가 완료되었습니다.\n[확인]을 클릭하시면 이전페이지로 이동합니다."
        if (instMsg.result[instCode.RESULT_INST_OK] == "") {
            setTimeout(function () {
                SITE_enableBrowser();
                fn_goHomePage(false);
            }, 1000);
        } else if (isConfirm) {
            setTimeout(function () {
                SITE_enableBrowser();
                customAlert({
                    title: '알림',
                    message: instMsg.result[instCode.RESULT_INST_OK],
                    type: 'confirm'
                }, function () {
                    fn_goHomePage(false);
                });
            }, 1000);
        } else {
            setTimeout(function () {
                SITE_enableBrowser();
                alert(instMsg.result[instCode.RESULT_INST_OK]);
                fn_goHomePage(false);
            }, 1000);
        }
        return;
    }
    SITE_enableBrowser();
    if (instConfig.isDebug) alert("SITE_axInstallCB: objectInstType[" + objectInstType + "][" + instConfig.objectInstList + "] unInstallCnt[" + unInstallCnt + "]");
}

//베라포트 자동설치 및 차단감지
function SITE_vpObjectInstall() {
    fn_checkBlocked(false, true, instConfig.x64msieWarning); //Cookie && ActiveX Filtering && x64msieWarning

    /*
    var msieVersion = 10;
    if (VP_browserInfo.MSIE && VP_browserInfo.version < msieVersion) {
        var warnMsg = "Microsoft Internet Explorer #browserVersion# 으로 접속하셨습니다.";
        warnMsg += "\n\n업무시스템이 MSIE #browserVersion#을 지원하지 않아 거래가 불가능합니다. 지원가능 브라우저를 확인하시기 바랍니다.";
        if (VP_SystemLang != "KOR") {
            warnMsg = "You are logged in with Microsoft Internet Explorer #browserVersion#";
            warnMsg += "\n\nBusiness systems do not support MSIE #browserVersion# and transactions are not possible. Please check the supported browsers.";
        }
        var msg = warnMsg.replace(/#browserVersion#/g, VP_browserInfo.version);
        alert(msg);
    }
    */

    var updateStr = "";
    if (!VP_config.useHandler && VP_browserInfo.MSIE && instConfig.isCabInstall && vp_isUse() && !vp_checkVp20Install(false)) {
        updateStr += fn_getVpObjectStr("Vp20Ctl_cabInstall", true);
    }
    if (instConfig.isDebug) updateStr += fn_getDebugInfoString();

    //alert(updateStr); //document.write(updateStr);
    fn_updateElementByValue("VP_object_install", "", updateStr, true);
}

//베라포트 멀티OS UI설정
function SITE_vpmInstallDialog() {
    if (VP_platformSupport.MultiOS) {
        if (typeof vpm_getInstallDialog == "function") {
            fn_updateElementByValue("dialog", "", vpm_getInstallDialog(), true);
            fn_updateElementByValue("dialogex", "", vpm_getInstallDialogEX(), true);
        } else {
            alert("undefined vpm_getInstallDialog(), check veraport20_multi.js");
        }
    }
}

//화면 enable 처리
function SITE_enableBrowser() {
    vp_enableBrowser();
}

//화면 disable 처리 및 중복실행 방지
function SITE_disableBrowser(message) {
    return vp_disableBrowser(message);
}

//홈페이지 또는 이전 페이지로 이동
function fn_goHomePage(isHome) {
    var url = VP_getReturnURL(isHome);
    if (url == "close") {
        window.close();
        return;
    }

    if (objectCheck.init && (objectCheck.applyCancel || isHome == false)) {
        objectCheck.returnURL = url;
        SITE_installCheck_start();
        return;
    }
    location.replace(url); //window.location.href = url;
}

//새로고침
function fn_reload() {
    if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false);
    location.reload();
}


//솔루션 설치체크: 실행할 함수를 스택에 추가
function SITE_installCheck_push(fn_installCheck) {
    objectCheck.storeBackup.push(fn_installCheck);
}

//솔루션 설치체크: 초기화
function SITE_installCheck_init(applyConfirm, applyCancel) {
    objectCheck.applyConfirm = applyConfirm;
    objectCheck.applyCancel = applyCancel;

    objectCheck.init = true; //true로 설정되어야  통합설치 완료후 SITE_objectCheck_exec()가 실행됨
    if (instMsg.result[instCode.RESULT_INST_OK] != "") {
        objectCheck.alertMSG = instMsg.result[instCode.RESULT_INST_OK]; //결과메시지
        instMsg.result[instCode.RESULT_INST_OK] = "";
    }
}

//솔루션 설치체크:: 통합설치완료 후 페이지이동전(fn_goHomePage)에 호출됨: 베라포트를 통한 설치체크가 완료시만 호출됨
function SITE_installCheck_start() {
    objectCheck.store = [];
    for (var i = 0; i < objectCheck.storeBackup.length; i++) {
        objectCheck.store.push(objectCheck.storeBackup[i]);
    }
    SITE_installCheck_next(true, "");
}

//솔루션 설치체크: 실행 및 결과 처리
function SITE_installCheck_next(checkResult, objectName) {
    if (typeof(checkResult) == "undefined") checkResult = true;
    if (typeof(objectName) == "undefined") objectName = objectCheck.objectName;

    //스택에 저장된 설치 체크 함수를 순차적으로 실행
    if (checkResult == true) {
        var _installCheck = objectCheck.store[0];
        if (typeof _installCheck == "function") {
            delete objectCheck.store[0];
            objectCheck.store.splice(0, 1);
            //alert(objectCheck.store.length + "\n" + install_check)
            _installCheck(true);
            return;
        }
    }

    var returnURL = objectCheck.returnURL;
    var alertMSG = objectCheck.alertMSG;
    if (checkResult != true) { //동작확인 실패시 알림메시지 및 이동페이지 설정
        alertMSG = instMsg.result[instCode.RESULT_INST_CK].replace(/#objectName#/g, objectName);
        returnURL = objectCheck.checkURL;
        if (typeof(encodeURIComponent) == "function") returnURL += "?url=" + encodeURIComponent(objectCheck.returnURL);
    }

    SITE_enableBrowser();
    var isConfirm = false; //설치완료 메시지알림을 confirm으로 사용시  true로 변경
    if (instConfig.isDebug) isConfirm = true;
    if (objectCheck.applyConfirm && checkResult == false) isConfirm = true;

    if (isConfirm) {
        customAlert({title: '알림', message: alertMSG, type: 'confirm'}, function () {
            window.location.href = returnURL;
        });
    } else {
        alert(alertMSG);
        window.location.href = returnURL;
    }
}


//베라포트 ActiveX/Plugin 설치 및 로딩 확인용 타이머
function timer_vpObjectLoad() {
    if (VP_config.useHandler) return;
    if (VP_objectLoad()) setTimeout(function () {
        timer_vpObjectLoad();
    }, 3000);
}

//베라포트 non-Plugin 설치 및 로딩 확인용 타이머
var _call_install_check_result = true;

function timer_vpHandlerLoad(isInstall) {
	
    if (!VP_config.useHandler) return;

    if (_call_install_check_result && _vp_handler_load >= 0) {
        _call_install_check_result = false;
        if (typeof(SITE_vpInstalCheckResult) == "function") setTimeout(function () {
            SITE_vpInstalCheckResult(isInstall);
        }, 1000);
    }

    if (VP_handlerLoad(isInstall)) setTimeout(function () {
        execVP_isInstall(timer_vpHandlerLoad);
    }, 3000);
}

//베라포트 메세지 업데이트용 타이머
function timer_vpMsgUpdate() {
    if (fn_vpMsgUpdate()) setTimeout(function () {
        timer_vpMsgUpdate();
    }, 3000);
}

//베라포트 버튼 업데이트용 타이머
function timer_vpBtnUpdate() {
    if (fn_vpBtnUpdate()) setTimeout(function () {
        timer_vpBtnUpdate();
    }, 3000);
}

//설치상태 업데이트용 타이머
function timer_objectUpdate(objectName) {
    if (SITE_objectUpdate(objectName)) setTimeout(function () {
        timer_objectUpdate(objectName);
    }, 3000);
}

function timer_objectUpdate2(objectPluginName, objectNonPluginName) {
    if (instConfig.usePluginModule) {
        fn_updateElementByDisplayON("plugin_" + objectPluginName, true);
        fn_updateElementByDisplayOFF("nonplugin_" + objectNonPluginName, true);
        timer_objectUpdate(objectPluginName);
    } else {
        fn_updateElementByDisplayOFF("plugin_" + objectPluginName, true);
        fn_updateElementByDisplayON("nonplugin_" + objectNonPluginName, true);
        timer_objectUpdate(objectNonPluginName);
    }
}

//커스트마이징용 제품별 설치상태
function SITE_objectUpdate(objectName, objectStatus) {
    var isStop = true; //설치완료시 타이머 종료 여부
    //var objectStatus = VP_getObjectStatus(objectName);

    //외부에서 입력된 설치상태값이 없으면 베라포트 설치상태값 사용(default)
    if (typeof(objectStatus) == "undefined") {
        objectStatus = VP_getObjectStatus(objectName);
        if (VP_platformInfo.Windows && (objectName == "ASTx1" || objectName == "ASTx2")) objectStatus = VP_getObjectStatus("ASTx");
    }

    //non-Plugin모드에서 특정제품 설치여부 확인 안하기
    if (!instConfig.usePluginModule) {
        //if (objectName == "Netizen5" || objectName == "SecuLog") objectStatus = instCode.STATUS_NOT_CHK;
    }

    //베라포트 미설치시 설치상태를 확인하고자 할경우 개별제품에서 확인 후 아래와 같이 설치상태를 세팅합니다.
    if (VP_getObjectStatus(instCode.VERAPORT) != instCode.STATUS_INST_OK) {
        //objectStatus = instCode.STATUS_NOT_SUP; //미지원
        //objectStatus = instCode.STATUS_INST_OK; //설치됨
        //objectStatus = instCode.STATUS_INST_NO; //미설치
    }

    if (!VP_browserInfo.MSIE) { //멀티브라우저 미지원
        //if (objectName == "SCSK4") objectStatus = instCode.STATUS_NOT_SUP;
    }
    if (VP_platformInfo.Windows && VP_platformInfo.x64) { //Win64 미지원
        if (objectName == "SCSK4" || objectName == "INISAFEWeb") objectStatus = instCode.STATUS_NOT_SUP;
    }
    if (!VP_platformInfo.Windows) { //멀티OS 미지원
        if (objectName == "SCSK4" || objectName == "TouchEnKey") objectStatus = instCode.STATUS_NOT_SUP;
    }
    if (VP_platformInfo.Mobile) objectStatus = instCode.STATUS_NOT_SUP; //모바일 미지원

    //NH:  VeraPort 미설치 메시지 표시안함, VeraPort 미설치시 상세보기 표시
    //if (objectName == instCode.VERAPORT && objectStatus == instCode.STATUS_INST_NO) objectStatus = instCode.STATUS_NOT_CHK;
    //if (objectStatus == instCode.STATUS_NOT_CHK) fn_updateElementByDisplayON("object_detail_" + objectName, false);
    //if (objectStatus != instCode.STATUS_NOT_CHK) fn_updateElementByDisplayOFF("object_detail_" + objectName, false);

    //설치됨(제품명): 다운로드버튼 분리일경우 설치되었는데도 해당 P_name이 붙여서 올경우 설치상태에 제품명표시
    var statusMsg = instMsg.status[objectStatus];
    if ((instConfig.displayDownload) && (objectStatus == instCode.STATUS_INST_OK) && (objectName == instConfig.P_name)) {
        statusMsg += "<br/>(" + objectName + ")";
    }

    //설치됨+다운로드버튼: 설치되었는데도 해당 P_name이 붙여서 올경우 차단감지로 처리(베라포트 실행전에만해당)
    if ((instConfig._vpExecCount <= 0) && (objectStatus == instCode.STATUS_INST_OK) && (objectName == instConfig.P_name)) {
        objectStatus = instCode.STATUS_INST_BK;
        //statusMsg += "<br/>(" + objectName + ")";
    }

    //베라포트 설치유무에 따라 처리 필요시 사용
    if (objectName == instCode.VERAPORT) {
        if (objectStatus == instCode.STATUS_INST_OK) {
            //베라포트 설치됨
        } else {
            //베라포트 미설치
        }
    }

    //if (objectStatus == instCode.STATUS_INST_OK) alert(objectName);
    return fn_objectUpdate(objectName, objectStatus, statusMsg, isStop);
}

//베라포트 설치여부를 기준으로한 커스트마이징용 타이머샘플
function timer_customUpdate(objectName) {
    var reTry = false;
    if (VP_getObjectStatus(instCode.VERAPORT) == instCode.STATUS_INST_OK) {
        var axInfo = vp_getAxInfo(instConfig._axInfoList, objectName);
        var installType = "N/A";
        if (axInfo != null) installType = (axInfo.installType == "must") ? "[필수]" : "[옵션]";
        alert(objectName + ":" + installType);
        //fn_updateElementByValue("object_installType_" + objectName, "", installType, true);
    } else {
        setTimeout(function () {
            timer_customUpdate(objectName);
        }, 3000);
    }
}

//window.onload= function() { fn_checkBlocked(false, true, true); };
