var autoInstall = true;
var load_cnt = 0;
var homeURL = "/";
var returnURL = homeURL;
//if (Delfino.getModule() == "G3") DelfinoConfig.useHandler = true;

function getUrlParameter(name) {
	var value = "";
	try {
        var url = document.location.href;
        var idx = url.indexOf("?");
        var params = "&"+url.substring(idx+1);
        idx = params.indexOf("&" + name + "=");
        if (idx >= 0) value = params.substring(idx+name.length+2);
        idx = value.indexOf("&");
        if (idx > 0) value = value.substring(0, idx);
        value = decodeURIComponent(value);
        //alert(name + "[" + value + "]\n\n" + params);
	} catch(err) { alert("getUrlParameter[" + name + "," + err.description + "]");}
    return value;
}
returnURL = getUrlParameter("url");
function delfino_download() {
    var downURL = DelfinoConfig.installPkg.Win32;
    if (DC_platformInfo.Mac) {
      downURL = DelfinoConfig.installPkg.Mac32;
      if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Mac64;
    } else if (DC_platformInfo.Ubuntu) {
      downURL = DelfinoConfig.installPkg.Dev32;
      if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Dev64;
    } else if (DC_platformInfo.Fedora) {
      if(Delfino.getModule() == "G3"){
    	  alert("설치완료 후, 어플리케이션 메뉴에서 델피노(delfino)를 실행하세요.\n(또는 커맨드라인에서 delfino를 입력하여 실행하세요.)");
      }
      downURL = DelfinoConfig.installPkg.Rpm32;
      if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Rpm64;
    } else if (DC_platformInfo.iOS) {
        downURL = DelfinoConfig.installPkg.iOS;
    } else if (DC_platformInfo.Android) {
        downURL = DelfinoConfig.installPkg.Android;
    } else {
      downURL = DelfinoConfig.installPkg.Win32;
      if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Win64;
    }
	load_cnt = 0;
	document.cookie="PageReload=Y; path=/;";
    document.location = downURL;
}
function delfino_download_Dev() {
    var downURL = DelfinoConfig.installPkg.Dev32;
    if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Dev64;
    document.location = downURL;
}
function delfino_download_Rpm() {
    if(Delfino.getModule() == "G3"){
    	alert("설치완료 후, 어플리케이션 메뉴에서 델피노(delfino)를 실행하세요.\n(또는 커맨드라인에서 delfino를 입력하여 실행하세요.)");
    }
    var downURL = DelfinoConfig.installPkg.Rpm32;
    if (DC_platformInfo.x64) downURL = DelfinoConfig.installPkg.Rpm64;
    document.location = downURL;
}
function delfino_getDownload() {
    var updateMsg = "";
    if (DC_platformInfo.Linux && !DC_platformInfo.Fedora && !DC_platformInfo.Ubuntu ) {
    	updateMsg += '<a href="javascript:delfino_download_Dev();"><img src="images/download_ubuntu.gif" /></a>';
    	updateMsg += '<a href="javascript:delfino_download_Rpm();"><img src="images/download_fedora.gif" /></a>';
    } else {
    	updateMsg += '<a href="javascript:delfino_download();"><img src="images/download.gif" /></a>';
    }
    return updateMsg;
} 

function delfino_getSystemInfo() {
    var ret = "[<b>" + DC_platformInfo.type + "," + DC_platformInfo.name + "</b>][<b>" + DC_browserInfo.name + "," + DC_browserInfo.version + "</b>] " + navigator.userAgent;
    return ret;
}
function delfino_getSystemInfo_mini() {
    var ret = "" + DC_platformInfo.type + "(" + DC_platformInfo.name + ") <b>" + DC_browserInfo.name + " " + DC_browserInfo.version + "</b>";
    return ret;
}

function isInstallDelfino() {
    if(DC_browserInfo.MSIE) return DCryptoPlugin.isInstallActiveX();
	return DCryptoPlugin.isInstallPlugin(true);
}
function delfino_createObjectActiveX() {
	if (Delfino.getModule() == "G3") return; //URL Handler
	var objstr="";
	if (DC_browserInfo.MSIE) {
		var version = DC_version.WinIE;
		var clsid = DC_mimeType.WinIE;
		var caburl = DC_installPkg.Cab32;
		if (DC_platformInfo.x64) caburl = DC_installPkg.Cab64;
		objstr  = "<div><object id='DelfinoCrypto' classid='" + clsid + "' WIDTH='1' HEIGHT='1' style='position:absolute;left:1px;top:1px;' ";
		objstr += "codebase="+caburl+"#version="+version+" ";
		objstr += "><param name='url' value='"+ document.URL +"'></param></object></div>";	
	}
	if (!autoInstall) objstr = DCryptoPlugin.getObjectTag();
	document.write(objstr);
}

function delfino_goHomePage() {
    if (!DC_browserInfo.MSIE) navigator.plugins.refresh(false);
    //history.back();
    if (returnURL == "") {
        location.replace(homeURL);
    } else if (returnURL == "close") {
        window.close();
    } else {
        location.replace(returnURL);
    }
}

function delfino_updateElementByDisplay(elementId, display, isErrCheck) {
    if (typeof(isErrCheck) == "undefined") isErrCheck = true;
    try {
        var ele = document.getElementById(elementId);
        if (ele == null) {
            if (isErrCheck) alert("delfino_updateElementByDisplay(" + elementId + ")" + " is not found. (HTML Check and Modify)");
            return;
        }
        ele.style.display = display;
    } catch(err) {
        alert("delfino_updateElementByDisplay[" + elementId + "][" + err.description + "]");
    }
}

var g_aliveChecker;
var g_tryExecCount = 1;
function delfino_load() {
	if (Delfino.getModule() == "G3") {
        //if (!DC_browserInfo.MSIE) setTimeout("delfino.handler.execute()", 500);
        g_aliveChecker = new wiz.util.timer(3000,function(){
            delfino.handler.helper.isInstall({"error":function(param){
                if(param.objver >= param.confver || param.objver == "") {
                    if(g_tryExecCount > 0 ) {
                    	//if (!DC_browserInfo.MSIE) delfino.handler.execute();
                        g_tryExecCount = g_tryExecCount-1;
                    }
                }
            },"success":function(){
                g_aliveChecker.stop();
                if (returnURL != "") {
            	    delfino_goHomePage();
                } else {
                    alert("WizIN-Delfino 설치가 완료되었습니다");
                    //setTimeout("history.back()", 10000);
                }
            }});
        });
        g_aliveChecker.start();
		return;
	}
	
    try {
        if(isInstallDelfino()) {
            if (returnURL != "") {
            	delfino_goHomePage();
            } else {
                alert("WizIN-Delfino 설치가 완료되었습니다");
                //setTimeout("history.back()", 10000);
            }
        }
        else {
            load_cnt++;
            if (!DC_browserInfo.MSIE) navigator.plugins.refresh(false);
    		if (DC_browserInfo.MSIE && !autoInstall && load_cnt >= 3 && Delfino_readCookie("PageReload") == "Y" ) location.reload();
            setTimeout("delfino_load()", 5000);
        }
    }
    catch(err) {
        if (DC_browserInfo.MSIE) setTimeout("location.reload()", 10000);
    }
}
