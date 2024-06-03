/**
 *  @name Veraport V2 - veraport20.js
 *  @author wizvera
 *  @date 2017-12-19 with Windows v3.7.1.2 (3.7.0.1)
**/
var VP_SystemLang = "KOR";  //"KOR", "ENG", "CHN", "JPN"
if (typeof _SITE_SystemLang != "undefined") VP_SystemLang = _SITE_SystemLang;

var VP_platformInfo     = vp_getPlatformInfo();
var VP_browserInfo      = vp_getBrowserInfo();
var VP_platformSupport  = {
    WinMoz:true, Win64:true, MultiOS:true
};

/* default base */
//var VP_DOMAIN_URL   = "http://"+document.location.host;
var VP_DOMAIN_URL   = document.location.protocol+"//"+document.location.host; //v2.5.1.8 over
var VP_CONTEXT_NAME = vp_getContextName("wizvera");

var VP_SITE_URL     = document.location.protocol+"//"+document.location.host;
var VP_BASE_URL     = document.location.protocol+"//"+document.location.host + "/resources/security/wizvera/veraport";
var VP_HTML_URL     = VP_BASE_URL;
var VP_UPDATE_URL   = "";

var VP_DOWN_URL     = VP_BASE_URL + "/down"; //package url
var VP_DOWN_URLS    = VP_BASE_URL + "/down"; //ssl cab url

/*
//Download the server using the sample
try {
    VP_DOMAIN_URL = "http://real.banking.com";
    var hostName = document.location.hostname;
    if (hostName.indexOf("test.banking.com")>=0 || hostName.indexOf("testbiz.banking.com") >= 0 ) { //test
        VP_DOMAIN_URL = "http://test.download.com";
    }
    else if (hostName.indexOf("dev.banking.com")>=0 || hostName.indexOf("devbiz.banking.com") >= 0 ) { //dev
        VP_DOMAIN_URL = "http://dev.download.com";
    }
    VP_DOWN_URL  = VP_DOMAIN_URL + "/product/veraport";
    VP_DOWN_URLS = VP_DOWN_URL;
} catch(err) {}
*/

/* default config */
var VP_config = {
    useHandler      : true,
    version         : "2,7,1,2", //plug-in version(2561)
    version_g3      : "3,8,6,6", //handler version
    mimeType        : "application/x-veraport20-plugin",
    CLSID           : "CLSID:477D5B9A-6479-44F8-9718-9340119B0308",

    cabURL          : VP_DOWN_URLS+ "/veraport20.cab",
    cabURL_x64      : VP_DOWN_URLS+ "/veraport20-x64.cab",

    //exeURL          : VP_DOWN_URL + "/veraport20.exe",
    //exeURL_x64      : VP_DOWN_URL + "/veraport20-x64.exe",

    exeURL          : VP_DOWN_URL + "/veraport-g3.exe",
    exeURL_x64      : VP_DOWN_URL + "/veraport-g3-x64.exe",

    exeURL_g3       : VP_DOWN_URL + "/veraport-g3.exe",
    exeURL_x64_g3   : VP_DOWN_URL + "/veraport-g3-x64.exe",

    cabURL_sha2     : VP_DOWN_URLS+ "/veraport20-sha2.cab",
    cabURL_x64_sha2 : VP_DOWN_URLS+ "/veraport20-x64-sha2.cab",

    //exeURL_sha2     : VP_DOWN_URL + "/veraport20-sha2.exe",
    //exeURL_x64_sha2 : VP_DOWN_URL + "/veraport20-x64-sha2.exe",

    exeURL_sha2     : VP_DOWN_URL + "/veraport-g3-sha2.exe",
    exeURL_x64_sha2 : VP_DOWN_URL + "/veraport-g3-x64-sha2.exe",

    exeURL_g3_sha2  : VP_DOWN_URL + "/veraport-g3-sha2.exe",
    exeURL_x64_g3_sha2 : VP_DOWN_URL + "/veraport-g3-x64-sha2.exe",

    axInfoURL       : VP_BASE_URL + "/dist/axinfo.dist.html",
    plInfoURL       : VP_BASE_URL + "/dist/plinfo.dist.html",
    installPage     : VP_HTML_URL + "/install20/install_vp.html",

    installType     : "", //NONE, TOP
    domainCookie    : false,
    useSHA2         : true,
    isCreateObject  : true,
    isCabInstall    : false,
    installCB       : false,
    useJsonParse    : false,
    sendMacAddr     : false,

    skin            : "", // "undertaker"
    logoSmall       : VP_BASE_URL + "/sitelogo/logo_small.gif",
    msgSmall        : VP_BASE_URL + "/sitelogo/msg_small.gif",
    logoLarge       : "", //VP_BASE_URL + "/sitelogo/logo_large.gif",
    msgLarge        : VP_BASE_URL + "/sitelogo/msg_large.gif",
    msgLargeM       : VP_BASE_URL + "/sitelogo/msg_large.gif",
    msgInfo         : VP_BASE_URL + "/sitelogo/msg_info.html",
    msgInfoM        : VP_BASE_URL + "/sitelogo/msg_info.html",
    agreePageURL    : VP_BASE_URL + "/sitelogo/agreement.html",
    processingImgURL: VP_BASE_URL + "/sitelogo/install_processing.gif",
    addInfoURL      : VP_BASE_URL + "/siteui/addinfo.json", //v2.5.6.0

    cliInfoSendURL  : VP_SITE_URL + "/wizvera/recv/recvClientInfo.jsp",
    logInfoSendURL  : VP_SITE_URL + "/wizvera/recv/recvInstallLog.jsp"
};

//windows NT 6.1 이상만 sha2 설치, 특정브라우저 또는 개발도메인에서 sha2 사용한함
//if (!VP_browserInfo.MSIE) VP_config.useSHA2 = false;
//if (VP_browserInfo.MSIE && VP_browserInfo.version < 11) VP_config.useSHA2 = false;
//if (document.location.hostname.indexOf("test.banking.com")>=0) VP_config.useSHA2 = false;
if (VP_config.useSHA2 && !navigator.userAgent.match(/NT 5./i) && !navigator.userAgent.match(/NT 6.0/i)) {
    VP_config.cabURL = VP_config.cabURL_sha2;
    VP_config.cabURL_x64 = VP_config.cabURL_x64_sha2;

    VP_config.exeURL = VP_config.exeURL_sha2;
    VP_config.exeURL_x64 = VP_config.exeURL_x64_sha2;

    VP_config.exeURL_g3 = VP_config.exeURL_g3_sha2;
    VP_config.exeURL_x64_g3 = VP_config.exeURL_x64_g3_sha2;
}

//VP_config.cliInfoSendURL="";
//VP_config.logInfoSendURL="";

//if (VP_platformInfo.Windows) VP_config.useHandler = true;
//if (!VP_browserInfo.MSIE) VP_config.useHandler = true;
//if (VP_browserInfo.Chrome || VP_browserInfo.Edge) VP_config.useHandler = true;
//if (VP_browserInfo.Chrome || VP_browserInfo.Edge || VP_browserInfo.ETC) VP_config.useHandler = true;

/* //WIZVERA_TEST_START
if (document.location.hostname.indexOf("wizvera.com")>=0) {
    VP_DOMAIN_URL = "http://help.wizvera.com";
    if (document.location.hostname.indexOf("demo.wizvera.com") >= 0) VP_config.useHandler = false;
    if (document.location.hostname.indexOf("help.wizvera.com") >= 0) VP_config.useHandler = false;
    if (document.location.hostname.indexOf("ts2.wizvera.com") >= 0) VP_config.useHandler = false;
    if (document.location.hostname.indexOf("test2.wizvera.com") >= 0) VP_config.useHandler = false;
    VP_config.cliInfoSendURL="http://help.wizvera.com/help/wizvera/recvVeraport.jsp?recvType=cliInfo&siteId=test";
    VP_config.logInfoSendURL="http://help.wizvera.com/help/wizvera/recvVeraport.jsp?recvType=logInfo&siteId=test";
}
//WIZVERA_TEST_END */

{ /* check isCreateObject, isCabInstall */
    var thisPage = window.location.href;
    if (thisPage.indexOf(VP_config.installPage)>=0) VP_config.isCabInstall = true;
    if (thisPage.indexOf("/demo/info.html")>=0) VP_config.isCabInstall = true;
    if (thisPage.indexOf("install_check.html")>=0) VP_config.isCabInstall = true;
    if (thisPage.indexOf("help.html")>=0) VP_config.isCabInstall = true;
    if (thisPage.indexOf("/axinfo.do?action=test")>=0) VP_config.isCabInstall = true;

    if (thisPage.indexOf("VP=install")>=0) {
        VP_config.isCabInstall = true;
        if (VP_browserInfo.MSIE && VP_config.isCabInstall) VP_config.isCreateObject = false;
    }
    if (typeof _SITE_CreateObject != "undefined") VP_config.isCreateObject = _SITE_CreateObject;
}

/* platform modify config */
if (VP_platformSupport.WinMoz && !VP_browserInfo.MSIE) VP_config.axInfoURL = VP_config.plInfoURL;
if (VP_platformInfo.x64) { //Win64
    VP_config.cabURL = VP_config.cabURL_x64;
    VP_config.exeURL = VP_config.exeURL_x64;
}

//V2.5.2.3 over firefox
//if (VP_platformInfo.Windows && VP_browserInfo.Firefox) VP_config.installCB = true;

/* Constant */
var VP_USE_COOKIE       = "Veraport20Use";
var VP_DEBUG_COOKIE     = "Veraport20Debug";
var VP_UPDATE_COOKIE    = "Veraport20Update";
var VP_INSTALL_COOKIE   = "Veraport20Install";

var VP_TYPE_SIMPLE      = "simple";
var VP_TYPE_MINI        = "mini";
var VP_TYPE_NORMAL      = "normal";
var VP_TYPE_FULL        = "full";
var VP_TYPE_MANAGE      = "manage";

var VP_TYPE_NORMAL_NAME = "normalname"; //v2.5.6.0
var VP_TYPE_NORMAL_DESC = "normaldesc"; //v2.5.6.0
var VP_CONF_ADDINFOURL  = "addinfourl"; //v2.5.6.0

var VP_CONF_AXINFOURL   = "axinfourl";
var VP_CONF_TYPE        = "type";
var VP_CONF_LOGOURL     = "logourl";
var VP_CONF_MSGURL      = "msgurl";
var VP_CONF_WEBINFOURL  = "webinfourl";
var VP_CONF_INFOPAGEURL = "infopageurl";
var VP_CONF_LANGUAGE    = "language";
var VP_CONF_CISENDURL   = "clientinfosendurl";
var VP_CONF_ILSENDURL   = "installlogsendurl";
var VP_CONF_SILENCE     = "silence";
var VP_CONF_SENDVPINFO  = "sendvpinfo";
var VP_CONF_INSTALLGUIDE= "installguide";
var VP_CONF_SELECTOBJECT= "selectobject";
var VP_CONF_DOMAIN      = "domain";
var VP_CONF_CONTEXT     = "context";
var VP_CONF_INITXPOS    = "initxpos";
var VP_CONF_INITYPOS    = "initypos";
var VP_CONF_SELECTOBJECT_ALL = "all";
var VP_CONF_BROWSER     = "browser";
var VP_CONF_AXINFO      = "axinfo";
var VP_CONF_BLOCKCHECK  = "blockcheck";
var VP_CONF_CONFIRMUNLOAD = "confirmunload";

var VP_TRUE             = 1;
var VP_FALSE            = 0;
var VP_DELAY            = 200; //ms

/****************************************
***** modify site information begin *****
*****************************************/
var VP_TYPE_MUST        = VP_TYPE_NORMAL; //VP_TYPE_SIMPLE, VP_TYPE_MINI, VP_TYPE_NORMAL, VP_TYPE_FULL
var VP_TYPE_SELECT      = VP_TYPE_MINI;
var VP_SITE_ID          = "default"; //"wizvera";

if (VP_SITE_ID == "wizvera") {
    VP_config.cliInfoSendURL = "http://veraport.wizvera.com/wizvera/recv/recvClientInfo.jsp";
    VP_config.logInfoSendURL = "http://veraport.wizvera.com/wizvera/recv/recvInstallLog.jsp";
}
else if (VP_SITE_ID == "verain") {
    VP_config.axInfoURL      = VP_BASE_URL + "/dist/axinfo.dist";
    VP_config.cliInfoSendURL = "";
    VP_config.logInfoSendURL = "";
}

var vp_AgreeSiteID      = document.location.host;
var vp_AgreeInstall     = VP_FALSE; //VP_TRUE; windows view opt default FALSE
var vp_AgreeDefUse      = VP_FALSE; //err check opt default FALSE
/****************************************
***** modify site information end *****
*****************************************/


/* Initialize */
try {
    //vp_notUse();
    //vp_setDebug();
    //if (VP_browserInfo.MSIE && !VP_browserInfo.VeraIN) vp_notUse(); //IE is veraport off(VeraIN on)
    //if (VP_platformInfo.Windows && VP_config.axInfoURL.indexOf('?')<0) VP_config.axInfoURL += "?dummy=" + new Date().getTime(); //no cache

    /* handler config */
    //if (VP_config.useHandler && vp_getCookie("VeraPortUseHandler")=="false") VP_config.useHandler = false;
    if (vp_getCookie("VeraPortUseHandler") == "false") VP_config.useHandler = false;
    if (vp_getCookie("VeraPortUseHandler") == "true") VP_config.useHandler = true;
    if (VP_config.useHandler) {
        VP_config.version = VP_config.version_g3;
        VP_config.cabURL  = "";
        VP_config.exeURL  = VP_config.exeURL_g3;
        if (VP_platformInfo.x64) VP_config.exeURL = VP_config.exeURL_x64_g3;
    }

    vp_checkBrowser();
    if (VP_platformInfo.Windows && VP_config.isCreateObject && !VP_config.useHandler) {
        vp_createObject();
        vp_init();
        //vp_update();
    }
}
catch(err) {
   vp_alert("vp_Main[" + err.description  + "]");
}

/****************************************
**********   OPEN API begin    **********
*****************************************/

//[OPEN API] set axInfoName&URL
function VP_setAxInfoName(axInfoName) {
    VP_setAxInfoUrl(VP_BASE_URL + "/dist/" + axInfoName);
    if (VP_config.installPage.indexOf('?') < 0) {
        VP_config.installPage += "?axInfoName=" + axInfoName;
    } else {
        VP_config.installPage += "&axInfoName=" + axInfoName;
    }
}

//[OPEN API] set axInfoUrl
function VP_setAxInfoUrl(axInfoUrl) {
    VP_config.axInfoURL = axInfoUrl;
    vp_setAxInfoUrl(VP_config.axInfoURL);
}

//[OPEN API] View Plug-in Management
function VP_axManage() {
   VP_axInstall(VP_TYPE_MANAGE, false, '');
}

//[OPEN API] Required Install Plug-in
function VP_axInstallMust() {
    VP_axInstall(VP_TYPE_MUST, true, '');
}

//[OPEN API] ALL Install Plug-in
function VP_axInstallAll() {
    VP_axInstall(VP_TYPE_MUST, true, VP_CONF_SELECTOBJECT_ALL);
}

//[OPEN API] Select Install Plug-in
function VP_axInstallSelect(objectName) {
    VP_axInstall(VP_TYPE_SELECT, false, objectName);
}

//[OPEN API] Install Plug-in
function VP_axInstall(installType, goInstallPage, objectName) {
    if(VP_browserInfo.MSIE && typeof(this.document.Vp20Ctl) == "undefined") VP_config.installType = "NONE";
    if(!vp_checkVp20Install(goInstallPage)) return;
    vp_setSelectObject(objectName);
    try { //add 2013-06-24
        vp_showVeraport(installType);
    } catch(err) {}
    if (VP_platformInfo.Windows && !VP_browserInfo.MSIE) navigator.plugins.refresh(false);
}

//[API] Not Install Count(input_param: "obj1,obj2,obj3","must","option","all")
function VP_axUninstalledCnt(objList) {
    if (VP_config.useHandler) alert("Warning unsupported function(VP_axUninstalledCnt).\n  used execVP_axUninstalledCnt()\n  URL:" + location.pathname);
    if (!vp_isUse()) return 0;
    if (!vp_checkVp20Install(false)) return -1;
    try {
        var axInfoList = vp_getAxInfoList();
        if (axInfoList == null) return 0;
        var instInfo = vp_getInstalledInfo(axInfoList,objList);
        //vp_alert("objList ["+objList+"]\ninstList ["+instInfo.instList.length+"]["+instInfo.instList.toString()+"]\nuninsList ["+instInfo.uninsList.length+"]["+instInfo.uninsList.toString()+"]");
        return instInfo.uninsList.length;
    } catch (err) {
        vp_alert("VP_axUninstalledCnt[" + err.description + "]");
        return 0;
    }
}


//[API] Not Install Count Must: unsupported non-Plugin
function VP_axCountMust() {
    if (VP_config.useHandler) alert("Warning unsupported function(VP_axCountMust).\n  used execVP_axUninstalledCnt()\n  URL:" + location.pathname);
    return vp_getUninstalledCnt(0);
    //return VP_axUninstalledCnt("must");
}

//[API] Not Install Count Opt: unsupported non-Plugin
function VP_axCountOpt() {
    if (VP_config.useHandler) alert("Warning unsupported function(VP_axCountOpt).\n  used execVP_axUninstalledCnt()\n  URL:" + location.pathname);
    return vp_getUninstalledCnt(1);
    //return VP_axUninstalledCnt("option");
}

//[API] set trustedSite
function VP_setTrustedSite(trustedSite) {
    //trustedSite = "*.wizvera.com,veraport.wizvera.com";
    if (!vp_isAvailable("VP_setTrustedSite", "2,0,0,22")) return;
    if (trustedSite == "") trustedSite = document.location.hostname;
    vp_setConfigure("trustedsite", trustedSite);
}

/***************************************
Previous version compatibility (bank.keb.co.kr)
/****************************************/
function VeraPortSetNbebank() {
    //VP_setAxInfoUrl("http://acs.keb.co.kr/dist/nbebank.dist");
}
function VeraPortShowAndInstall() {
    //alert("Warning delete function(VeraportShowAndInstall). used VP_axInstallMust()\n\tURL:" + location.pathname);
    //vp_showVeraport(VP_TYPE_NORMAL);
    VP_axInstall(VP_TYPE_MUST, true, '');
}
function VeraPortShow() {
    //alert("Warning delete function(VeraPortShow). used VP_axManage()\n\tURL:" + location.pathname);
    //vp_showVeraport(VP_TYPE_MANAGE);
    VP_axInstall(VP_TYPE_MANAGE, false, '');
}
function VP_isUse() {
    return vp_isUse();
}
function VeraPortInstallCheck() {
    return vp_checkVp20Install(false);
}
var VP_VeraPortInstallUrl = VP_config.installPage;

/*
function VeraPortSetYescard() {
    //VP_setAxInfoUrl("http://acs.keb.co.kr/dist/yescard.dist");
}
function VeraPortSetB2c() {
    //VP_setAxInfoUrl("http://acs.keb.co.kr/dist/b2c.dist");
}
function VeraPortShowAndInstallEn() {
}
function VeraPortShowEn() {
}
*/

/***************************************
Previous version compatibility (hanabank.com, scfirstbank.com)
/****************************************/
function SetAxInfoName(dist_name) {
    alert("Warning delete function(SetAxInfoName). used VP_axInstallSelect(objectName)\n\tURL:" + location.pathname);
    //VP_config.axInfoURL = VP_BASE_URL + "/down/dist/" + dist_name;
    //vp_setAxInfoUrl(VP_config.axInfoURL);
    VP_setAxInfoUrl(VP_BASE_URL + "/down/dist/" + dist_name);
}
function VeraportShowAndInstall() {
    //alert("Warning delete function(VeraportShowAndInstall). used VP_axInstallMust()\n\tURL:" + location.pathname);
    //vp_showVeraport(VP_TYPE_NORMAL);
    VP_axInstall(VP_TYPE_MUST, false, '');
}
function VeraportShow() {
    //alert("Warning delete function(VeraportShow). used VP_axManage()\n\tURL:" + location.pathname);
    //vp_showVeraport(VP_TYPE_MANAGE);
    VP_axInstall(VP_TYPE_MANAGE, false, '');
}
function VeraportSelectInstall(axname,viewtype) {
    //alert("Warning delete function(VeraportSelectInstall). used VP_axInstallSelect(objectName)\n\tURL:" + location.pathname);
    //vp_setSelectObject(axname);
    //vp_showVeraport(viewtype);
    VP_axInstall(viewtype, false, axname);
}

/****************************************
**********   OPEN API end      **********
*****************************************/

/* functions */
function vp_init() {
    //vp_setWindowPosition(-100, -100); //add v2,0,0,20
    vp_setContext(VP_CONTEXT_NAME); //add 2016.11.24
    vp_setDomain(VP_DOMAIN_URL); //add 2013.01.16
    vp_setAxInfoUrl(VP_config.axInfoURL);
    vp_setLogo(VP_config.logoLarge);
    vp_setMsg(VP_config.msgLarge);
    vp_setWebInfo(VP_config.msgInfo);
    vp_setType(VP_TYPE_MANAGE);
    vp_setLogSendUrl(VP_config.logInfoSendURL);
    vp_setClientInfoSendUrl(VP_config.cliInfoSendURL);
    vp_setSelectObject("");
    vp_setSendVpInfo(false);
    vp_setConfigure("skin", VP_config.skin); //v2.5.4.3
    vp_setConfigure(VP_CONF_ADDINFOURL,VP_config.addInfoURL); //v2.5.6.0
    vp_setConfigure("sendMacAddr", ""+VP_config.sendMacAddr); //v3.7.1.1
    vp_setLanguage(VP_SystemLang);
    
    //vp_setConfigure("killbrowser","parent,silent"); //v2.5.4.2
    //vp_setConfigure("initialurl",document.location.protocol+"//"+document.location.host);
    if (VP_config.useHandler) vp_setBrowser(); //v2.5.2.0
    //vp_setConfigure(VP_CONF_CONFIRMUNLOAD, "true"); //v2.5.2.0
    //vp_setConfigure(VP_CONF_LANGUAGE, "eng");
    //vp_setConfigure(VP_CONF_BLOCKCHECK,"yes");
    //vp_setConfigure("trustedsite","http://test.com,http://veraport.wizvera.com");
}
function vp_getUninstalledCnt(objType) {
    var obj = vp_getObject();
    if(obj == null) return -1;
    vp_loadInfo();
    var unInstallCnt = obj.GetUninstalledCnt(objType);
    //alert(installCnt + ":" + objType);
    return unInstallCnt;
}
function vp_isAvailable(fnName, inVersion) {
    var thisArray = VP_config.version.split(',');
    var inputArray = inVersion.split(',');
    for (var i=0; i<4; i++) {
        if (parseInt(thisArray[i], 10) > parseInt(inputArray[i], 10)) {
            return true;
        } else if (parseInt(thisArray[i], 10) < parseInt(inputArray[i], 10)) {
            vp_alert("vp_isAvailable[function:" + fnName + "is not support][version:" + inVersion + "]");
            return false;
        }
    }
    return true;
}
function vp_getVersion() {
    try {
        if (VP_platformInfo.Windows) {
            if (!vp_checkVp20Install(false)) return "0";
            if (!vp_isAvailable("vp_getVersion", "2,5,6,7")) return VP_config.version;
            return vp_getObject().GetVersion();
        } else {
            if (typeof(vpm_getPluginInfo) == "undefined" || typeof(vpm_getPluginVersion) == "undefined" ) return "0";
            var plugin = vpm_getPluginInfo(VP_config.mimeType);
            if(plugin == null) return "0";
            return vpm_getPluginVersion(plugin);
        }
    } catch(err) { return "-1"; }
    return "0";
}
function vp_setWindowPosition(xPos, yPos) {
    if (!vp_isAvailable("vp_setRequireAgreement", "2,0,0,20")) return;
    vp_setConfigure(VP_CONF_INITXPOS,xPos);
    vp_setConfigure(VP_CONF_INITYPOS,yPos);
}
function vp_setRequireAgreement(agree,siteid,url,defuse) {
    if (!vp_isAvailable("vp_setRequireAgreement", "2,0,0,8")) return;
    var obj = vp_getObject();
    if(obj == null) return "null";
    return obj.SetRequireAgreement(agree,siteid,url,defuse); //windows view, no error check
}
function vp_notUpdateToDay(days)
{
    var today = new Date();
    var expiry = new Date(today.getTime() + days * 24 * 60 * 60 * 1000);
    document.cookie=VP_UPDATE_COOKIE+"=N; path=/; expires=" + expiry.toGMTString();
}
function vp_update() {
    var obj = vp_getObject();
    if(obj == null) return "null";

    //alert(document.cookie);
    if (vp_getCookie(VP_UPDATE_COOKIE) == "N")
        return;

    //alert(document.cookie);
    vp_notUpdateToDay(1);
    return obj.Update(VP_UPDATE_URL);
}
function vp_checkVp20Plugin_org() {
    var plugins = navigator.plugins;
    if(plugins == null || plugins.length == 0) return false;
    for(var i=0;i<plugins.length;i++) {
        //modify 2010.11.02
        if (typeof(plugins[i][0]) == "undefined") continue;
        if(VP_config.mimeType == plugins[i][0].type ) return true;
    }
    return false;
}
function vp_checkVp20Plugin() {
    var plugins = navigator.plugins;
    if(plugins == null || plugins.length == 0) return false;

    var myMimetype = navigator.mimeTypes[VP_config.mimeType];
    if(myMimetype == null || myMimetype == "undefined") return false;

    var pluginDesc = myMimetype.enabledPlugin.description;
    var idx = pluginDesc.lastIndexOf("(");
    var installVer = pluginDesc.substring(idx+1);
    installVer = installVer.substr(0,installVer.length-1);
    var updateVer = VP_config.version.replace(/,/gi,"");
    if( updateVer > installVer ) return false;
    return true;
}
function vp_checkVp20Install(goInstallPage) {
    if (!vp_isUse()) return false;
    try {
        if (!VP_browserInfo.MSIE) {
            var myMimetype = navigator.mimeTypes[VP_config.mimeType];
            //modify 2010.08.23
            if ( myMimetype && vp_checkVp20Plugin()) {
                //alert("installOK:" + myMimetype);
            }
            else {
                //alert("not install:" + myMimetype);
                if (goInstallPage) vp_goVp20InstallPage();
                return false;
            }
        }
        else {
            if( ((typeof(this.document.Vp20Ctl) == "undefined") || (this.document.Vp20Ctl == "undefined")
                ||(this.document.Vp20Ctl == null) || (this.document.Vp20Ctl.object == null) )) {
                if (goInstallPage) vp_goVp20InstallPage();
                return false;
            }
        }
    }
    catch(err) {
        vp_alert("vp_checkVp20Install[" + err.description + "]");
    }
    return true;
}
function vp_isReady() {	
	if (VP_config.useHandler) return true;
	var obj = vp_getObject();
	if(obj==null) return false;
	if(typeof(obj.SetConfigure)=="undefined") return false;
	
	return true;
}
function vp_getDomain() {
    var thisDomain = document.location.hostname;
    try {
        var idx = thisDomain.indexOf(".");
        thisDomain = thisDomain.substring(idx+1);
    } catch(err) {
        alert("vp_getDomain[" + thisDomain + "][" + err.description + "]");
    }
    return thisDomain;
}
function vp_goVp20InstallPage(isReplase) {
    vp_enableBrowser();
    var thisDomain = vp_getDomain();
    if (VP_config.installPage.indexOf(thisDomain)<0) {
        if (vp_getCookie(VP_INSTALL_COOKIE) == "Y") {
            document.cookie=VP_INSTALL_COOKIE+"=N; path=/;";
            //alert("Not goInstallPage:" + VP_config.installPage + "\n" + thisDomain + "\n" + VP_config.installPage.indexOf(thisDomain));
            return;
        }
        document.cookie=VP_INSTALL_COOKIE+"=Y; path=/;";
    }

    var thisPage = window.location.href;
    if (thisPage.indexOf(VP_config.installPage) < 0 && VP_config.installType != "NONE") {
        var encodedThisPage = encodeURIComponent(thisPage);
        if (VP_config.installPage.indexOf('?') < 0) {
            parameter = "?url=" + encodedThisPage;
        } else {
            parameter = "&url=" + encodedThisPage;
        }

        if (VP_config.installType == "TOP") {
            if (isReplase != null && isReplase == true) {
                top.window.location.replace(VP_config.installPage + parameter);
            } else {
                top.window.location.href = VP_config.installPage + parameter;
            }
        } else {
            if (isReplase != null && isReplase == true) {
                window.location.replace(VP_config.installPage + parameter);
            } else {
                window.location.href = VP_config.installPage + parameter;
            }
        }
    }
}
function vp_checkBrowser() {
    try {
        if (VP_platformInfo.Mobile) {
            vp_notUse();
        } else if (!VP_platformInfo.Windows) {
            if (!VP_platformSupport.MultiOS) vp_notUse();
        } else if (VP_platformInfo.x64) {
            if (!VP_platformSupport.Win64) vp_notUse();
        } else if(navigator.platform != "Win32") {
            vp_notUse();
        }

        if (!VP_browserInfo.MSIE) {
            if (!VP_platformSupport.WinMoz) vp_notUse();
            if (navigator.appName != 'Netscape' && navigator.appName != 'Opera') vp_notUse();
            if (VP_browserInfo.Edge && !VP_config.useHandler) vp_notUse(); //Microsoft Edge
            //if (VP_browserInfo.ETC) vp_notUse();
        }
        else {
            if (VP_browserInfo.version < 5.5) vp_notUse();
            var os = window.navigator.appVersion;
            if(os.indexOf(" Windows 98") != -1 || os.indexOf(" Windows 95") != -1
                || os.indexOf(" Windows NT 4.0") != -1) vp_notUse();
        }


        if (!vp_isUse()) {
            var msg  = "Browser Information\t\t[" + VP_platformInfo.type + "," + VP_platformInfo.name + "][" + VP_browserInfo.name + "," + VP_browserInfo.version + "]\n\n";
                msg += "Navigator Information\n";
                msg += "navigator.platform\t\t[" + navigator.platform + "]\n";
                msg += "navigator.appName\t\t[" + navigator.appName + "]\n";
                msg += "navigator.appCodeName\t[" + navigator.appCodeName + "]\n";
                msg += "navigator.systemLanguage\t[" + navigator.systemLanguage + "]\n";
                msg += "navigator.javaEnabled()\t[" + navigator.javaEnabled() + "]\n";
                msg += "navigator.language\t\t[" + navigator.language + "]\n";
                msg += "navigator.cpuClass\t\t[" + navigator.cpuClass + "]\n";
                msg += "navigator.appVersion\t[" + navigator.appVersion + "]\n";
                msg += "navigator.userAgent\t\t[" + navigator.userAgent + "]\n";

            vp_alert(msg);
        }
    }
    catch(err) {
        vp_alert("vp_checkBrowser[" + err.description + "]");
        vp_notUse();
    }
}

function vp_getCookie( name ) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) {
            return c.substring(nameEQ.length,c.length);
        }
    }
    return "";
}

function vp_isUse() {
    if (vp_getCookie(VP_USE_COOKIE) == "N") return false;
    return true;
}
function vp_getDomainCookieString() {
    var addDomain = "";
    if (VP_config.domainCookie) {
        alert("Security vulnerabilities have been commented out. If necessary, remove your comment below.");
        //addDomain = " domain=." + vp_getDomain();
    }
    return addDomain;
}
function vp_setUse() {
    document.cookie=VP_USE_COOKIE+"=Y; path=/;" + vp_getDomainCookieString();
}
function vp_notUse() {
    document.cookie=VP_USE_COOKIE+"=N; path=/;" + vp_getDomainCookieString();
}
function vp_setDebug() {
    document.cookie=VP_DEBUG_COOKIE+"=Y; path=/;" + vp_getDomainCookieString();
}
function vp_notDebug() {
    document.cookie=VP_DEBUG_COOKIE+"=N; path=/;" + vp_getDomainCookieString();
}
function vp_setUseHandler(useHandler) {
    document.cookie="VeraPortUseHandler=" + useHandler + "; path=/;" + vp_getDomainCookieString();
}
function vp_clearUseHandler() {
    document.cookie="VeraPortUseHandler=; path=/;" + vp_getDomainCookieString();
}
function vp_notUseDays(days) {
    var today = new Date();
    var expiry = new Date(today.getTime() + days * 24 * 60 * 60 * 1000);
    document.cookie=VP_USE_COOKIE+"=N; path=/; expires=" + expiry.toGMTString() + vp_getDomainCookieString();
}
function vp_isDebug() {
    if (vp_getCookie(VP_DEBUG_COOKIE) == "Y") return true;
    return false;
}
function vp_alert(msg) {
    if (vp_isDebug())
        alert(msg);
    else
        document.cookie="Veraport20Alert=" + msg + "; path=/;";
}
function vp_createObject() {
    var objstr = "";
    if (!vp_isUse()) return;
    //add 2011.1.4 wizvera
    if (document.getElementById("Vp20Ctl") != null) return;
    if (!VP_browserInfo.MSIE) {
        //add 2010.08.23
        var myMimetype = navigator.mimeTypes[VP_config.mimeType];
        if ( myMimetype && vp_checkVp20Plugin()) {
            objstr += '<embed ID="Vp20Ctl" width="0" height="0" ';
            objstr += 'codeBaseURL="' +  VP_config.cabURL + '#version=' + VP_config.version + '" ';
            objstr += 'type="' + VP_config.mimeType + '" />';
        }
    }
    else {
        //objstr += '<object id="Vp20Ctl" width="1" height="1" classid="';
        objstr += '<object id="Vp20Ctl" width="1" height="1" style="visibility:hidden;"  classid="';
        objstr += VP_config.CLSID;
        objstr += '" codebase="';
        if (VP_config.isCabInstall) objstr += VP_config.cabURL; ////modify 2012.07.30
        objstr += '#version=';
        objstr += VP_config.version;
        objstr += '"></object>';
    }
    //vp_alert(objstr);
    document.write(objstr);

    //add 2010.05.25 wizvera
    try {
        if(VP_browserInfo.MSIE && typeof(this.document.Vp20Ctl) == "undefined") {
            var debugMsg = "[" + typeof(this.document.Vp20Ctl) + "]";
            var el  = document.createElement("div");
            el.innerHTML = objstr;
            if (document.body != null) document.body.appendChild(el);
            if(typeof(this.document.Vp20Ctl) == "undefined") VP_config.installType = "NONE";
            debugMsg += "[" + typeof(this.document.Vp20Ctl) + "]";
            vp_alert("createObject:" +  debugMsg);
        }
    } catch(err) {
        VP_config.installType = "NONE";
        vp_alert("vp_createObject:[" + err.description + "]");
    }
}
function vp_getObject() {
    if(!vp_checkVp20Install(false)) return null;
    return document.getElementById("Vp20Ctl");
}
function vp_getObject_new() {
    if(!vp_checkVp20Install(false)) return null;
    var obj =  document.getElementById("Vp20Ctl");
    if(obj && (typeof obj.SetConfigure == "function") || obj.object != null) return obj;
    return null;
}
function vp_getLastError() {
    var obj = vp_getObject();
    if(obj == null) return "null";
    return obj.GetLastErrorMsg();
}
function vp_getConfigureAll() {
    var obj = vp_getObject();
    if(obj == null) return "null";
    return obj.GetConfigureAll();
}
function vp_getConfigureJson() {
    var obj = vp_getObject();
    if(obj == null) return "null";
    return obj.GetConfigureJson();
}
function vp_showVeraport(type) {

    vp_setContext(VP_CONTEXT_NAME); //add 2016.11.24
    vp_setDomain(VP_DOMAIN_URL); //add 2013.01.16
    vp_setAxInfoUrl(VP_config.axInfoURL);
    vp_setLogSendUrl(VP_config.logInfoSendURL);
    vp_setClientInfoSendUrl(VP_config.cliInfoSendURL);
    vp_setRequireAgreement(vp_AgreeInstall,vp_AgreeSiteID,VP_config.agreePageURL,vp_AgreeDefUse); //add v2,0,0,8

    var flag = 1;
    if(type ==  VP_TYPE_MANAGE || type ==  VP_TYPE_FULL) {
        vp_setLogo(VP_config.logoLarge);
        vp_setMsg(VP_config.msgLarge);
        vp_setWebInfo(VP_config.msgInfo);
        if (type == VP_TYPE_MANAGE && typeof(VP_config.msgLargeM) != "undefined" && typeof(VP_config.msgInfoM) != "undefined" ) {
            vp_setMsg(VP_config.msgLargeM);
            vp_setWebInfo(VP_config.msgInfoM);
        }
        if(type ==  VP_TYPE_MANAGE) flag = 0;
    } else {
        vp_setLogo(VP_config.logoSmall);
        vp_setMsg(VP_config.msgSmall);
    }
    vp_setConfigure("type",type);

    //V2.5.2.3 firefox
    if (type!= VP_TYPE_MANAGE && vp_isInstallCB()) {
        vp_show(0);
        setTimeout("vp_completeCB()", 500);
    } else {
        vp_show(flag);
    }
}
function vp_isInstallCB() {
    if (VP_config.installCB==true && typeof(vp_getObject().IsRunning)!="undefined") return true;
    return false;
}
function vp_completeCB(){
    if (vp_getObject().IsRunning(1) == 0) {
        navigator.plugins.refresh(false);
        if (typeof VP_axInstallCB === "function") VP_axInstallCB();
    } else {
        setTimeout("vp_completeCB()", 500);
    }
}
function vp_setWebInfo(url) {
    vp_setConfigure(VP_CONF_WEBINFOURL,url);
}
function vp_setContext(context) {
    vp_setConfigure(VP_CONF_CONTEXT,context);
}
function vp_setDomain(domain) {
    //if (!vp_isAvailable("vp_setDomain", "2,0,0,7")) return;
    vp_setConfigure(VP_CONF_DOMAIN,domain);
}
function vp_setBrowser() {
    var name = VP_browserInfo.name;
    var version = VP_browserInfo.version;
    if (VP_browserInfo.MSIE) name = "IE";
    vp_setConfigure(VP_CONF_BROWSER, name+"/"+version); //v2.5.2.0
}
function vp_setLanguage(lang) {
    if (lang == "KOR" || lang == "kor") {
        vp_setConfigure(VP_CONF_LANGUAGE, "kor");
    } else if (lang == "ENG" || lang == "eng") {
        vp_setConfigure(VP_CONF_LANGUAGE, "eng");
    } else if (lang == "CHN" || lang == "chn") {
        vp_setConfigure(VP_CONF_LANGUAGE, "eng");
    } else if (lang == "JPN" || lang == "jpn") {
        vp_setConfigure(VP_CONF_LANGUAGE, "eng");
    }
}
function vp_setMsg(url) {
    vp_setConfigure(VP_CONF_MSGURL,url);
}
function vp_setLogo(url) {
    vp_setConfigure(VP_CONF_LOGOURL,url);
}
function vp_setClientInfoSendUrl(url) {
    vp_setConfigure(VP_CONF_CISENDURL,url);
}
function vp_setLogSendUrl(url) {
    vp_setConfigure(VP_CONF_ILSENDURL,url);
}
function vp_setAxInfoUrl(url){
    VP_config.axInfoURL = url;
    vp_setConfigure(VP_CONF_AXINFOURL, url);
}
function vp_setType(type) {
    vp_setConfigure(VP_CONF_TYPE,type);
}
function vp_setInstallGuide(url) {
    vp_setConfigure(VP_CONF_INSTALLGUIDE,url);
}
function vp_delay(gap){
    if (gap < 0) return;
    var then,now;
    then=new Date().getTime();
    now=then;
    while((now-then)<gap) {
        now=new Date().getTime();
    }
}
function vp_show(flag) {
    var obj = vp_getObject();
    if(obj == null) return;
    vp_loadInfo();
    //obj.ShowType(flag);
    var res = obj.ShowType(flag);
    try {
        if(res == 0) { // fail
            var code = obj.GetLastErrorCode(); //add v2,0,0,8
            if(code == 58) vp_notUse();
        }
        else {
            vp_delay(VP_DELAY);
        }
    } catch(err) {
        vp_alert("vp_show:deplay[" + err.description + "]");
    }
}
function vp_setConfigure(key,value) {
    try {
        var obj = vp_getObject();
        if(obj == null) return;
        obj.SetConfigure(key,value);
    } catch(err) {}
}
function vp_uninstallAll() {
    var obj = vp_getObject();
    if(obj == null) return;
    obj.UninstallAll();
}
function vp_loadInfo() {
    var obj = vp_getObject();
    if(obj == null) return "null";
    var ret = obj.LoadInfo("");
    return ret;
}
function vp_setSendVpInfo(flag) {
    vp_setConfigure(VP_CONF_SENDVPINFO,flag);
}
function vp_SetSendVpInfo(flag) {
    vp_setSendVpInfo(flag);
}
function vp_setSelectObject(name) {
    vp_setConfigure(VP_CONF_SELECTOBJECT,name);
}
function vp_setForceInstall(name) {
    vp_setConfigure("forceinstall",name);
}
function vp_setKillBrowser(killbrowser, initialurl) {
    if (typeof(killbrowser) == "undefined") killbrowser = "parent,confirm"; //all|parent, silent:confirm
    if (VP_config.useHandler) killbrowser = killbrowser.replace(/parent/g, "browser");
    if (typeof(initialurl) == "undefined") initialurl = document.location.protocol+"//"+document.location.host; //window.location.href;
    vp_setConfigure("killbrowser",killbrowser);
    vp_setConfigure("initialurl",initialurl);
}
function vp_getDistInfo() {
    var retDistInfo = {version: "", createDate: "", allowDomains: ""};
    try {
        var obj = vp_getObject();
        if(obj == null) return null;
        vp_loadInfo();
        var distinfo = vp_jsonParse(obj.GetDistributeInfo());
        if (typeof(distinfo) == "undefined") return null;

        retDistInfo.version = (distinfo[0].version == 0) ? "1.0" : "2.0";
        if(distinfo[0].verstring != null && distinfo[0].verstring != "undefined")
            retDistInfo.version = distinfo[0].verstring;

        retDistInfo.createDate = distinfo[0].createdate;
        if(distinfo[0].allowdomains != null && distinfo[0].allowdomains != "undefined")
            retDistInfo.allowDomains =distinfo[0].allowdomains;
        return retDistInfo;
    }
    catch(err) {
        vp_alert("vp_getDistInfo[" + err.description + "]");
    }
    return null;
}
function vp_getAxInfoList() {
    try {
        var obj = vp_getObject();
        if(obj == null) return null;
        vp_loadInfo();
        return vp_jsonParse(obj.GetAxInfo());
    }
    catch(err) {
        //alert("vp_getAxInfoList[" + err + "]");
    }
    return null;
}
function vp_getAxInfo(axInfoList, objectName) {
    if (axInfoList == null) return null;
    var retAxInfo = {objectName: "", displayName: "", objectVersion: "", systemType: "",
                     installStatus: false, installType: "", downloadURL: "", backupURL: "",
                     objectCLSID: "", updateStatus: false, localVersion: "", description: "",
                     installStatusEnable: false, block:false, killbit:false, allowrun:true, forceInstall:false, allowrunDomains:""};
    try {
        //alert("objectInfoList: " + objectInfoList);
        for(var i=0;i<axInfoList.length;i++) {
            //alert(objectInfoList[i].objectname);
            if (objectName == axInfoList[i].objectname) {
                retAxInfo.objectName = axInfoList[i].objectname;
                retAxInfo.displayName = axInfoList[i].displayname;
                retAxInfo.objectVersion = axInfoList[i].objectversion;
                retAxInfo.systemType = axInfoList[i].systemtype;
                retAxInfo.installStatus = (axInfoList[i].installstate == 0) ? false : true;
                try{
                    if (VP_browserInfo.MSIE && !VP_platformInfo.x64) {
                        retAxInfo.block = (axInfoList[i].block == "true") ? true : false;
                        retAxInfo.killbit = (axInfoList[i].killbit == "true") ? true : false;
                        retAxInfo.allowrun = (axInfoList[i].allowrun == "false") ? false : true;
                        retAxInfo.allowrunDomains   = axInfoList[i].allowrundomains;
                    }
                    retAxInfo.forceInstall = (axInfoList[i].forceinstall == "true") ? true : false;
                }catch(e){};
                if (retAxInfo.installStatus && !retAxInfo.block && !retAxInfo.killbit && !retAxInfo.forceInstall) retAxInfo.installStatusEnable = true;

                if (typeof axInfoList[i].updatestate  != "undefined") retAxInfo.updateStatus = axInfoList[i].updatestate;
                if (typeof axInfoList[i].localversion != "undefined") retAxInfo.localVersion = axInfoList[i].localversion;
                if (typeof axInfoList[i].objectclsid  != "undefined") retAxInfo.objectCLSID  = axInfoList[i].objectclsid;
                if (typeof axInfoList[i].objectclsid  != "undefined") retAxInfo.description  = axInfoList[i].description;

                retAxInfo.installType = (axInfoList[i].objecttype == 0) ? "must" : "option";
                retAxInfo.downloadURL = axInfoList[i].downloadurl;
                retAxInfo.backupURL = axInfoList[i].backupurl;
                return retAxInfo;
            }
        }
    }
    catch(err) {
        alert("vp_getAxInfo[" + err.description + "]");
    }
    return null;
}
function vp_isAxInfoStatus(axInfoList, objectName) {
    var axInfo = vp_getAxInfo(axInfoList, objectName);
    if (axInfo == null) return true;
    return axInfo.installStatus;
}
function vp_getInstalledInfo(axInfoList,objList) {
    var installedInfo = {instList:[],uninsList:[]};
    var objs = objList.split(",");
    if (objList == "all" || objList == "must" || objList == "option") {
        for(var i=0;i<axInfoList.length;i++) {
            var axInfo = vp_getAxInfo(axInfoList, axInfoList[i].objectname);
            if (axInfo == null) continue;
            if ((objList != "all") && objList != axInfo.installType) continue;
            if (axInfo.installStatusEnable == true) {
                installedInfo.instList.push(axInfo.objectName);
            } else {
                installedInfo.uninsList.push(axInfo.objectName);
            }
        }
    } else {
        for(var i=0;i<objs.length;i++) {
            var axInfo = vp_getAxInfo(axInfoList, objs[i]);
            if (axInfo == null) continue;
            if (axInfo.installStatusEnable == true) {
                installedInfo.instList.push(axInfo.objectName);
            } else {
                installedInfo.uninsList.push(axInfo.objectName);
            }
        }
    }
    return installedInfo;
}

function vp_getAgreementInfo() {
    var obj = vp_getObject();
    if(obj == null) return "" ;
    try {
        var result = "-------------------------\n";
        var info = vp_jsonParse(obj.GetAgreementInfo());
        for(key in info[0]) {
            result += key;
            result += " : ";
            result += info[0][key];
            result += "\n";
            if(key == "baselocation") result += "-------------------------\n";
        }
        return result;
    }
    catch(err) {
        vp_alert("vp_getAgreementInfo[" + err.description + "]");
    }

}
function _selectInstall(name) {
    var config = vp_jsonParse(vp_getConfigureJson());
    //alert(vp_getConfigureJson());
    var curr = "";
    for(var i=0;i<config.length;i++) {
        if(config[i].key == 'type') {
            curr = config[i].value;
            break;
        }
    }
    var old = curr;
    if(curr == "")
        return;

    if(curr == VP_TYPE_MANAGE)
        vp_setConfigure('type',VP_TYPE_FULL);

    vp_setSelectObject(name);
    vp_show(1);

    vp_setConfigure('type',old);
}

function vp_jsonParse(text) {
    if (VP_config.useJsonParse) {
        if (typeof json_parse == "function") return json_parse(text);
        alert("include 'jquery/json_parse.js'");
    } else {
        return eval(text);
    }
}

function vp_enableBrowser(){
    if (typeof jQuery == "undefined") return;
    //if (!VP_config.useHandler) return;
    //jQuery("#vp_overlay").remove();
    removeLoading();
}
function vp_disableBrowser(message){
    if (typeof jQuery == "undefined") return;
    //if (!VP_config.useHandler) return;

    //커스텀 다이얼로그로 주석처리
    // if(jQuery("#vp_overlay")!=null && jQuery("#vp_overlay").length>0) return true;
    // var overlayHtml ='<div id="vp_overlay" style="z-index:9998;position:fixed; width:100%; height:100%; top:0px; left:0px; background-color: #000000; opacity: 0.3; filter: alpha(opacity=30);">';
    // //overlayHtml = '<div id="vp_overlay" style="z-index:9998;position:fixed; width:100%; height:100%; top:0px; left:0px; background-color: rgba(0,0,0,0.0); opacity: 0.3; filter: alpha(opacity=30);">';
    // if(message && VP_config.processingImgURL){
    //     overlayHtml += '<div style="z-index:9999;position:fixed;top:50%; height:100%;width:100%;">'
    //         + '<div style="margin: 0 auto; padding: 5px; width:150px; background-color:#fff; vertical-align:middle; font-weight:bold; text-align: center; color:#555;  border-radius:5px;">'
    //         + message
    //         + ' <img src="'+ VP_config.processingImgURL + '" alt="checking" style="vertical-align:middle"/>'
    //         + '</div>'
    //         + '</div>';
    // }
    // overlayHtml += '</div>';
    // jQuery("body").append(overlayHtml);
    //커스텀 다이얼로그로 주석처리
    addLoading();
    return false;
}

//check browser and system info
function vp_getBrowserInfo() {
    var browserInfo = {
        MSIE:false, Edge:false, Navigator:false, Firefox:false, Chrome:false, Safari:false, Opera:false, ChromePlus:false, VeraIN:false, ETC:false,
        name: "unknown", version: "-1"
    };

    try {
        var index = -1;
        var tmp = "";
        if(navigator.appName == "Microsoft Internet Explorer") {
            browserInfo.MSIE = true;
            browserInfo.name = "MSIE";
            index = navigator.userAgent.indexOf(browserInfo.name)+browserInfo.name.length+1;
            tmp = navigator.userAgent.substring(index);
            index = tmp.indexOf(";");
            if (index < 0) index = tmp.indexOf(")");
            browserInfo.version = tmp.substring(0, index);

            //IE_CONTROL(MSIE_11)
            if (navigator.userAgent.match(/Trident/i) && (browserInfo.version.indexOf("Windows")>0)) {
                browserInfo.ETC = true;
                index = navigator.userAgent.lastIndexOf("rv:")+"rv:".length;
                tmp = navigator.userAgent.substring(index);
                index = tmp.indexOf(")");
                if (index < 0) index = tmp.indexOf(" ");
                browserInfo.version = tmp.substring(0, index);
            }
        }
        else if (navigator.userAgent.match(/Edge/i)) { //Edge
            browserInfo.Edge = true;
            browserInfo.name = "Edge";
            index = navigator.userAgent.lastIndexOf(browserInfo.name)+browserInfo.name.length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/Navigator/i)) { //Firefox
            browserInfo.Navigator = true;
            browserInfo.name = "Navigator";
            index = navigator.userAgent.lastIndexOf(browserInfo.name)+browserInfo.name.length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/OPR/i)) {  //Opera 18 over
            browserInfo.Opera = true;
            browserInfo.name = "Opera";
            index = navigator.userAgent.lastIndexOf("OPR")+"OPR".length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/OPiOS/i)) {  //modify 20151118: Opera for iOS
            browserInfo.Opera = true;
            browserInfo.name = "Opera-OPiOS";
            index = navigator.userAgent.lastIndexOf("OPiOS")+"OPiOS".length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/Firefox/i)) {
            browserInfo.Firefox = true;
            browserInfo.name = "Firefox";
            index = navigator.userAgent.lastIndexOf(browserInfo.name)+browserInfo.name.length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/Chrome/i)) { //Safari
            browserInfo.Chrome = true;
            browserInfo.name = "Chrome";
            if (navigator.userAgent.match(/ChromePlus/i)) {
                browserInfo.ChromePlus = true;
                browserInfo.name = "ChromePlus";
            }
            index = navigator.userAgent.lastIndexOf(browserInfo.name)+browserInfo.name.length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/CriOS/i)) { //modify 20151118: Chrome for iOS
            browserInfo.Chrome = true;
            browserInfo.name = "Chrome-CriOS";
            index = navigator.userAgent.lastIndexOf("CriOS")+"CriOS".length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/Safari/i)) {
            browserInfo.Safari = true;
            browserInfo.name = "Safari";
            //index = navigator.userAgent.lastIndexOf(browserInfo.name)+browserInfo.name.length+1;
            index = navigator.userAgent.lastIndexOf("Version")+"Version".length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/Opera/i)) {
            browserInfo.Opera = true;
            browserInfo.name = navigator.appName;
            index = navigator.userAgent.lastIndexOf("Version")+"Version".length+1;
            tmp = navigator.userAgent.substring(index);
            browserInfo.version = tmp;
            index = tmp.indexOf(" ");
            if (index > 0) browserInfo.version = tmp.substring(0, index);
        }
        else if (navigator.userAgent.match(/Trident/i)) {
            browserInfo.MSIE = true;
            browserInfo.name = "MSIE";
            index = navigator.userAgent.lastIndexOf("rv:")+"rv:".length;
            if (index <= 2) index = navigator.userAgent.indexOf(browserInfo.name)+browserInfo.name.length+1; //Emulation
            tmp = navigator.userAgent.substring(index);
            index = tmp.indexOf(")");
            if (index < 0 || index > 10) index = tmp.indexOf(";");
            if (index < 0 || index > 10) index = tmp.indexOf(" ");
            browserInfo.version = tmp.substring(0, index);
        }
        /*
        else if (navigator.userAgent.match(/Windows NT 10.0; Win64; x64/i)) { //modify 20150908 Edge
            browserInfo.Edge = true;
            browserInfo.name = "Edge";
            browserInfo.version = "12.0";
        }
        */
        else {
            browserInfo.ETC = true;
            browserInfo.name = navigator.appName;
            browserInfo.version = "NOT_OK";
        }
    }
    catch(err) {
        alert("vp_getBrowserInfo[" + err.description + "]");
    }

    //VeraIN Check: Mozilla+VeraIN
    try {
        var value1 = vp_getCookie("Verain");
        var value2 = vp_getCookie("Verain2Web");
        if(value1 != "" || value2 != "") browserInfo.VeraIN = true; //VeraIN
    } catch(err) {
        alert("vp_getBrowserInfo[" + err.description + "][" + document.cookie + "]");
    }
    return browserInfo;
}
function vp_getPlatformInfo() {
    var platformInfo = {
        Windows:false, Linux:false, Ubuntu:false, Fedora:false, Mac:false, iOS:false, Android:false,
        Mobile:false, x64:false,
        type: "unknown", name: "unknown"
    };
    platformInfo.name = navigator.platform;
    if (navigator.appVersion.match("WOW64")) platformInfo.name = "WOW64";

    if (platformInfo.name.match(/Win32/i) || platformInfo.name.match(/WOW64/i)) {
        platformInfo.Windows = true;
        platformInfo.type = "Windows";
        if (navigator.appVersion.match(/Win64/i)) {
            platformInfo.name = "Win64";
            platformInfo.x64 = true;
            platformInfo.type = "Windows64";
        }
    } else if (platformInfo.name.match("Win64")) {
        platformInfo.Windows = true;
        platformInfo.x64 = true;
        platformInfo.type = "Windows64";
    } else if (platformInfo.name.match("Linux armv")) {
        platformInfo.Mobile = true;
        platformInfo.Android = true;
        platformInfo.type = "Android";
    } else if (platformInfo.name.match(/Linux/i)) {
        platformInfo.Linux = true;
        platformInfo.type = "Linux";
        if (platformInfo.name.match(/x86_64/i)) {
            platformInfo.x64 = true;
            platformInfo.type = "Linux64";
        } else if (navigator.userAgent.match(/x86_64/i)) { //Opera
            platformInfo.x64 = true;
            platformInfo.type = "Linux64";
        }
        if (navigator.userAgent.match(/Fedora/i)) {
            platformInfo.Fedora = true;
            platformInfo.type = "Fedora";
            if (platformInfo.x64) platformInfo.type = "Fedora64";
        } else if (navigator.userAgent.match(/Ubuntu/i)) {
            platformInfo.Ubuntu = true;
            platformInfo.type = "Ubuntu";
            if (platformInfo.x64) platformInfo.type = "Ubuntu64";
        } else if (navigator.userAgent.match(/Android/i)) { //modify 20150903: Samsung Galaxy Edge
            platformInfo.Linux = false;
            platformInfo.Mobile = true;
            platformInfo.Android = true;
            platformInfo.type = "Android";
        }
    } else if (platformInfo.name.match(/MacIntel/i)) {
        platformInfo.Mac = true;
        platformInfo.type = "Mac";
    } else if (platformInfo.name == "iPad"
            || platformInfo.name == "iPhone"
            || platformInfo.name == "iPod"
            || platformInfo.name == "iOS") {
        platformInfo.Mobile = true;
        platformInfo.iOS = true;
        platformInfo.type = "iOS";
    }

    if( (navigator.userAgent.match(/iPhone/i))  ||
        (navigator.userAgent.match(/iPod/i))    ||
        (navigator.userAgent.match(/iPad/i))    ||
        (navigator.userAgent.match(/Android/i))) {
        platformInfo.Mobile = true;
    }
    if( (navigator.userAgent.match(/Windows Phone/i)) ||
        (navigator.userAgent.match(/Windows CE/i))    ||
        (navigator.userAgent.match(/Symbian/i))       ||
        (navigator.userAgent.match(/BlackBerry/i))) {
        platformInfo.Mobile = true;
    }

    //modify/remove system type
    if (navigator.userAgent.match("Android") && navigator.userAgent.match("Opera Mini")) {
        platformInfo.Mobile = true;
        platformInfo.Android = true;
        platformInfo.type = "Android";
    }
    return platformInfo;
}
function vp_getContextName(defaultValue) {
    var context = "";
    try {
        var idx = location.pathname.indexOf('/', 1);
        if (idx > 0) context = location.pathname.substring(1, idx);
    } catch(err) {}
    if (context == "") context = defaultValue;
    return context;
}

var vp_MozilaPlugin     = VP_platformSupport.WinMoz;

/*
var vp_X64Platform      = VP_platformSupport.Win64;

var vp_Version          = VP_config.version;
var vp_MozialVersion    = VP_config.version;
var vp_mimeType         = VP_config.mimeType;
var vp_CLSID            = VP_config.CLSID;

var vp_AxInfoUrl        = VP_config.axInfoURL;
var vp_CabUrl           = VP_config.cabURL;
var vp_ExeUrl           = VP_config.exeURL;
var vp_InstallPage      = VP_config.installPage;
var vp_installType      = VP_config.installType;
var vp_domainCookie     = VP_config.domainCookie;

var vp_LogoS            = VP_config.logoSmall;
var vp_LogoL            = VP_config.logoLarge;
var vp_MsgS             = VP_config.msgSmall;
var vp_MsgL             = VP_config.msgLarge;
var vp_Html             = VP_config.msgInfo;
var vp_AgreePageURL     = VP_config.agreePageURL;

var vp_ClientInfoSendUrl= VP_config.cliInfoSendURL;
var vp_LogSendUrl       = VP_config.logInfoSendURL;

function vp_isMozila() { return !VP_browserInfo.MSIE; };
function vp_getMozilaInfo() {return [VP_browserInfo.name, VP_browserInfo.version]; };
*/
/*
function GetTD(value) { }
function UpdateDistributeInfo(target) { return; };
function GetAgreementInfo() { return vp_getAgreementInfo(); };
function UpdateInstallState(target) { return; };
*/

/**
 *  @updateInfo
 *  50. modify 2013.07.09  V2.5.5.0
 *    - support scheme, dist(base64)
 *  51. modify 2013.07.24  JS
 *    - mod function: vp_getBrowserInfo(): support IE 11.0
 *  52. modify 2013.11.06  JS V2.5.6.0
 *    - add VP_config.addInfoURL, VP_TYPE_NORMAL_NAME, DESC, VP_CONF_ADDINFOURL
 *    - modify  function: vp_init()
 *    - set _SITE_CreateObject value to VP_config.isCreateObject
 *  53. modify 2014.01.06  JS V2.5.6.1
 *    - remove domain cookie
 *    - add userAgent: OPR to Opera
 *  54. update 2014.02.28  V2.5.6.7
 *    - add function vp_getVersion()
 *  55. modify 2014.07.02  V2.5.7.0
 *    - add function vp_jsonParse(): include json_parse.js
 *  56. modify 2015.03.11  V2.6.0.3
 *    - handler/plugin Integration
 *    - add veraport20_handler.js
 *  57. modify 2015.04.15  JS
 *    - add function: VP_axUninstalledCnt(objList),vp_getInstalledInfo(axInfoList,objList)
 *  58. modify 2015.04.30  JS
 *    - add: VP_config.processingImgURL, vp_enableBrowser(), vp_disableBrowser(message)
 *    - modify: vp_init(): default set vp_setBrowser();
 *  59. modify 2015.05.21  JS
 *    - add: vp_setUseHandler(): plug-in/non-plugin setting
 *    - modify: vp_setKillBrowser: handler("parent" replace "browser")
 *  59. modify 2015.06.23  V3.0.2.9 support Win10
 *  60. modify 2015.06.24  JS
 *    - modify: vp_getBrowserInfo: support Edge
 *  61. modify 2015.09.03  JS
 *    - modify: vp_getPlatformInfo: Samsung Galaxy Edge platform info fix
 *  61. modify 2015.11.18  JS
 *    - modify: vp_getBrowserInfo: fix iOS(Chrome, Opera)
 *  62. modify 2016.11.28  JS
 *    - add: VP_CONTEXT_NAME, vp_setContext(), vp_getContextName()
 *    - modify: vp_init, vp_showVeraport: add vp_setContext()
 *  63. modify 2017.01.12  JS
 *    - add: vp_isReady()
 *  64. modify 2017.12.19  JS
 *    - modify: vp_getCookie()
**/
