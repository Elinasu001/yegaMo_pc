/**
 *  @name Delfino - install.js
 *  @author wizvera
 *  @date 2016.02.02
 *  @include delfino_config.js, delfno_internal.js, delfino.js
**/

//DC_platformInfo.Windows = false; DC_platformInfo.Linux = true; //DC_platformInfo.Ubuntu = true; //리눅스테스트용
//DC_platformInfo.x64 = true; //x64테스트용

var instConfig = {};
instConfig.isDebug         = false;
instConfig.isCabInstall    = true; //Windows IE용 CAB 설치사용안할경우 false로 설정
instConfig.returnURL       = fn_getUrlParameter("url"); //설치완료 후 이동할 이전 페이지
instConfig.homeURL         = document.location.protocol+"//"+document.location.host;
instConfig.module          = fn_getUrlParameter("module");

if (fn_getUrlParameter("debug") == "on") instConfig.isDebug = true; //Debug ON
if (instConfig.returnURL!="close" && instConfig.returnURL.indexOf(document.location.host)<0 && instConfig.returnURL!="") instConfig.returnURL = instConfig.homeURL; //외부URL일 경우 homeURL로 변경
if (instConfig.module != "") {
    DelfinoConfig.useRecentModule = false; //add 2015-11-15
    Delfino.setModule(instConfig.module);
}
if (typeof(Delfino.setVersion) == "function") Delfino.setVersion(DelfinoConfig.version_update, DelfinoConfig.version_update_g3);

/***********************************
 * WizIN-Delfino install/run Function
 * - delfino_objectInstall()
 * - delfino_objectInstall_result(result)
 * - delfino_goHomePage()
 * - delfino_getDownload(pkgType)
 * - delfino_getSystemInfo()
 * - delfino_getSystemInfo_mini()
***********************************/
function delfino_objectInstall() {
    if (DC_browserInfo.MSIE && instConfig.isCabInstall && Delfino.getModule()=="G2") {
        var updateStr = "";
        var object_ID = "DcCtl_cabInstall";
        var object_CLSID = DC_mimeType.WinIE;
        var object_cabURL = DC_installPkg.Cab32;
        if (DC_platformInfo.x64) object_cabURL = DC_installPkg.Cab64;
        var object_version = DC_version.WinIE;

        updateStr += '<object id="' + object_ID + '" width="1" height="1" style="visibility:hidden;"  classid="';
        updateStr += object_CLSID;
        updateStr += '" codebase="' + object_cabURL + '#version=' + object_version;
        updateStr += '"></object>';
        //alert(updateStr); //document.write(updateStr);
        fn_updateElementByValue("DC_object_install", "", updateStr, true);
    }
    fn_checkAxFiltering(false, true); //ActiveX Filtering & Cookie Check
    //delfino_objectInstall_result(false);
    setTimeout(function(){Delfino.isInstall(false, delfino_objectInstall_result);}, 1000);
}
function delfino_objectInstall_result(result) {
    if (!DC_browserInfo.MSIE) navigator.plugins.refresh(false);
    if (result != true) {
        if (DC_browserInfo.MSIE && Delfino.getModule()=="G2") $("#delfinoDiv2").remove();
        setTimeout(function(){Delfino.isInstall(false, delfino_objectInstall_result);}, 3000);
        return;
    }
    
    //if (instConfig.module != "") Delfino.resetRecentModule(); //remove 2015-11-15
    //if (instConfig.returnURL == "") returnURL = instConfig.homeURL;
    if (instConfig.returnURL != "") {
        delfino_goHomePage();
    } else {
        alert("WizIN-Delfino " + Delfino.getModule() + " has completed installation");
        //alert("WizIN-Delfino 설치가 완료되었습니다");
        //delfino_goHomePage();
    }
}
function delfino_goHomePage() {
    if (typeof(SITE_goHomePage) == "function") {
        SITE_goHomePage();    	
        return;
    }

    var returnURL = instConfig.returnURL;
    if (instConfig.returnURL == "") returnURL = instConfig.homeURL;

    //alert("WizIN-Delfino 설치가 완료되었습니다.");
    if (returnURL == "close") {
        window.close();
    } else {
        location.replace(returnURL);
        //history.back();
        //setTimeout("history.back()", 10000);
    }
}
function delfino_getDownload(pkgType) {
    var downURL = DelfinoConfig.installPkg.Win32;
    if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Win64;

    if (pkgType == "DEV") {
        downURL = DelfinoConfig.installPkg.Dev32;
        if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Dev64;
    } else if (pkgType == "RPM") {
        downURL = DelfinoConfig.installPkg.Rpm32;
        if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Rpm64;
    } else if (DC_platformInfo.Mac) {
        downURL = DelfinoConfig.installPkg.Mac32;
        if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Mac64;
    } else if (DC_platformInfo.Ubuntu) {
        downURL = DelfinoConfig.installPkg.Dev32;
        if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Dev64;
    } else if (DC_platformInfo.Fedora) {
        downURL = DelfinoConfig.installPkg.Rpm32;
        if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Rpm64;
    }

    document.location = downURL;
    if ((pkgType == "RPM" || DC_platformInfo.Fedora) && Delfino.getModule() == "G3"){
      alert("설치완료 후, 어플리케이션 메뉴에서 델피노(delfino)를 실행하세요.\n(또는 커맨드라인에서 delfino를 입력하여 실행하세요.)");
    }
}
function delfino_getSystemInfo() {
    var ret = "[<b>" + DC_platformInfo.type + "," + DC_platformInfo.name + "</b>][<b>" + DC_browserInfo.name + "," + DC_browserInfo.version + "</b>] " + navigator.userAgent;
    return ret;
}
function delfino_getSystemInfo_mini() {
    var ret = "" + DC_platformInfo.type + "(" + DC_platformInfo.name + ") <b>" + DC_browserInfo.name + " " + DC_browserInfo.version + "</b>";
    return ret;
}

/***********************************
 * ETC Function
 * - fn_updateElementByValue(elementId, value, innerHTML, isErrCheck)
 * - fn_updateElementByDisplayON(elementId, isErrCheck)
 * - fn_updateElementByDisplayOFF(elementId, isErrCheck)
 * - fn_updateElementByDisplay_(elementId, display, isErrCheck)
 * - fn_getUrlParameter(name)
 * - fn_checkAxFiltering(isCookie, isActiveX)
***********************************/
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
function fn_checkAxFiltering(isCookie, isActiveX) {
    try { //ActiveX Filtering & Cookie Check
        if (isCookie) {
            document.cookie="cookieTEST=test; path=/;";
            if (Delfino_readCookie("cookieTEST") != "test") {
                alert("브라우저 Cookie가 정상적으로 동작하지 않습니다.");
            }
        }

        if (isActiveX && Delfino.getModule() == "G2") {
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
