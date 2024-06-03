/**
 *  @name Veraport V2 - install_vp.js
 *  @author wizvera
 *  @date 2017.01.12
 *  @include veraport20.js
**/

var instConfig = {};
instConfig.isDebug         = false;
instConfig.isCabInstall    = true; //Windows IE용 CAB 설치사용안할경우 false로 설정
instConfig.returnURL       = fn_getUrlParameter("url"); //설치완료 후 이동할 이전 페이지
instConfig.homeURL         = document.location.protocol+"//"+document.location.host;
instConfig.installList     = ""; //"" is VP_axInstallMust(), "all" is VP_axInstallAll()

if (fn_getUrlParameter("debug") == "on") instConfig.isDebug = true; //Debug ON
if (instConfig.returnURL.indexOf(document.location.host)<0 && instConfig.returnURL!="") instConfig.returnURL = instConfig.homeURL; //외부URL일 경우 homeURL로 변경

instConfig._errCount = 0;
instConfig._errMessage = {};

/***********************************
 * VERAPORT install/run Function
 * - timer_vpObjectLoad()
 * - fn_goHomePage(notUse)
 * - fn_download_Veraport(pkgType)
 * - fn_reload()
 * - fn_getSystemInfo()
***********************************/
function timer_vpObjectLoad() {
    if (VP_objectLoad()) setTimeout(function(){timer_vpObjectLoad();}, 3000);
}
function fn_goHomePage(notUse) {
    //alert("[" + VP_config.installType + "][" + instConfig.homeURL + "][" + instConfig.returnURL + "]");
    if (notUse) vp_notUse();
    if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false);
    //history.back();
    if (VP_config.installType == "TOP" || instConfig.returnURL == "")
        location.replace(instConfig.homeURL);
    else
        location.replace(instConfig.returnURL);
}
function fn_download_Veraport(pkgType) {
    document.location = fn_getVpDownloadURL(pkgType);
    if ((pkgType == "RPM" || VP_platformInfo.Fedora) && VP_config.useHandler){
      alert("브라우저를 종료 한후, 어플리케이션 메뉴에서 베라포트(Veraport)를 실행하세요.\n(또는 커맨드라인에서 veraport를 입력하여 실행하세요.)");
    }
}
function fn_reload() {
    javascript:navigator.plugins.refresh(false);
    location.reload();
}
function fn_getSystemInfo() {
    var ret = "[<b>" + VP_platformInfo.type + "," + VP_platformInfo.name + "</b>][<b>" + VP_browserInfo.name + "," + VP_browserInfo.version + "</b>] " + navigator.userAgent;
    return ret;
}
function fn_vpmInstallDialog() {
    if (VP_platformSupport.MultiOS) {
        if (typeof vpm_getInstallDialog == "function") {
            fn_updateElementByValue("dialog", "", vpm_getInstallDialog(), true);
            fn_updateElementByValue("dialogex", "", vpm_getInstallDialogEX(), true);
        } else {
            alert("undefined vpm_getInstallDialog(), check veraport20_multi.js");
        }
    }
}
function fn_vpObjectInstall() {
    fn_checkAxFiltering(false, true); //ActiveX Filtering & Cookie Check
    setTimeout(function(){timer_vpObjectLoad();}, 500);
    var updateStr = "";
    if (VP_browserInfo.MSIE && instConfig.isCabInstall && vp_isUse() && !vp_checkVp20Install(false) ) {
        updateStr += fn_getVpObjectStr("Vp20Ctl_cabInstall", true);
    }
    //alert(updateStr); //document.write(updateStr);
    fn_updateElementByValue("VP_object_install", "", updateStr, true);
}

/***********************************
 * VERAPORT install/run Function
 * - VP_loadCB(isVpInstall)
 * - VP_axInstallCB()
 * - VP_objectLoad()
***********************************/
function VP_loadCB(isVpInstall) {
	vp_SetSendVpInfo("false");
    if (isVpInstall) vp_SetSendVpInfo("true");
    if (VP_browserInfo.MSIE) vp_setConfigure(VP_CONF_BLOCKCHECK, 'yes');
    if (typeof SITE_setConfigure == "function") SITE_setConfigure(isVpInstall);
    VP_axInstall(VP_TYPE_MUST, true, instConfig.installList); //VP_axInstallMust(); //VP_axInstallAll();
    //if (isVpInstall && !VP_config.useHandler) vp_SetSendVpInfo("false");
    if (VP_platformInfo.Windows && !vp_isInstallCB() && !VP_config.useHandler) VP_axInstallCB(); //modify 2013.03.04
}
function VP_axInstallCB() {
    if (!VP_browserInfo.MSIE) navigator.plugins.refresh(false);
    if (instConfig.returnURL != "") {
        if (typeof(fn_goHomePage) == "function") {
            fn_goHomePage(false);
        } else {
            location.replace(homeURL);
        }
    } else {
        //alert("The installation is now complete VeraPort");
        setTimeout(function(){alert("The installation is now complete VeraPort");}, 100);
        //setTimeout("history.back()", 10000);
    }
}
var _vp_object_load = true;
var _vp_object_load_error = 0;
var _vp_handler_load = 0;
var _vp_object_unblock_msg = true;
function timer_vpHandlerLoad(isInstall) {
    if (isInstall) {
        VP_objectLoad(false);
        return;
    }
    if (++_vp_handler_load >= 0) { //3번이상 호출시 베라포트 미설치로 처리
        _vp_object_load = false;
        document.cookie="_vp_object_load=N; path=/;";
    }
    setTimeout(function(){execVP_isInstall(timer_vpHandlerLoad);}, 3000);
}
function VP_objectLoad(isCB) {
    if (!vp_isUse()) return false; //timer stop
    if (document.getElementById("Vp20Ctl") != null && _vp_object_load) {
        alert("VP_config.isCreateObject change the value from [" + VP_config.isCreateObject + "] to [false]");
    }

    if (typeof(isCB) == "undefined") isCB = true;
    if (VP_config.useHandler && isCB) {
        execVP_isInstall(timer_vpHandlerLoad);
        return false; //timer stop
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
                    if (_vp_object_unblock_msg) alert("This plug-in is blocked a security program does not work properly. Please unblock in your browser settings.");
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
function fn_getVpDownloadURL(pkgType) {
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
        if (typeof(decodeURIComponent) == "function") value = decodeURIComponent(value); //mod 2013.11.13 IE5
        //alert("fn_getUrlParameter", name + "[" + value + "]\n\n" + params);
    } catch(err) { alert("fn_getUrlParameter[" + name + "," + err.description + "]");}
    return value;
}


/***********************************
 * TEST/DEBUG Function
 * - fn_checkAxFiltering(isCookie, isActiveX)
 * - fn_vpmTestUI(type)
***********************************/
function fn_checkAxFiltering(isCookie, isActiveX) {
    try { //ActiveX Filtering & Cookie Check
        if (isCookie) {
            document.cookie="cookieTEST=test; path=/;";
            if (vp_getCookie("cookieTEST") != "test") {
                alert("브라우저 Cookie가 정상적으로 동작하지 않습니다.");
            }
        }
        if (isActiveX && !VP_config.useHandler) {
            if (typeof window.external != "undefined"
                && typeof window.external.msActiveXFilteringEnabled != "undefined"
                && window.external.msActiveXFilteringEnabled() == true) {
                var msg = "Active-X 필터링이 설정되어 있어 보안프로그램이 정상동작하지 않습니다.";
                msg += "\n브라우저 메뉴의 [도구]->[안전]의  ActiveX 필터링 체크를 해제하시기 바랍니다.";
                alert(msg);
            }
        }
    } catch(err) { };
}
function fn_vpmTestUI(type) {
    VP_TYPE_MUST = type;
    try {
        vpm_showDialog(type);
        VP_setInstallList(pluginInfo2JSON());
        VP_setInstallMessage(vpm_getMessage("success"));
        VP_setInstallStage(10);
        VP_setInstallProgress(10);
        setTimeout("VP_complete()", 3000);
    } catch (err) {
        alert("VeraPort not Installed");
        VP_complete();
    }
}

//window.onload= function() { fn_checkAxFiltering(false, true); };
