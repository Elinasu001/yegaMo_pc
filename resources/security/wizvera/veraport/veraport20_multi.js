/**
 *  @name Veraport V2 - veraport20-multi.js
 *  @author wizvera
 *  @date 2017-11-30 with MultiOS v3.7.1.1 (3.7.0.3)
 *  apt-get remove veraport*
**/

if (typeof VP_BASE_URL == "undefined") alert("include 'veraport20.js'");
if (typeof jQuery == "undefined" && !VP_platformInfo.Windows) alert("jQuery is not available!!!");

var _vpm_distBase = VP_BASE_URL + "/dist";
var _vpm_pkgBase  = VP_DOWN_URL;

var vmp_jsonp = false; //true일 경우  vpm_loadInfo시 jquery jsonp 사용하며 별도의 json.jsp 필요
var vmp_jqueryUI  = false;
var vmp_jqueryAjax = true;
if (vmp_jsonp) {
    if (!vmp_jqueryAjax) alert("vmp_jqueryAjax change the value from [" + vmp_jqueryAjax + "] to [true]");
}

var vpm_dist = {
    Mac     : _vpm_distBase + "/macintel.dist.html",
    Ubuntu  : _vpm_distBase + "/ubuntu.dist.html", //DEV
    Fedora  : _vpm_distBase + "/fedora.dist.html"  //RPM
};

if (vmp_jsonp) { //원본 배포파일이 JSP와 동일경로 있어야 하며 파일명변경시 JSP 내용 확인
	vpm_dist.Mac = vpm_dist.Mac + ".jsonp.jsp"; 
	vpm_dist.Ubuntu = vpm_dist.Ubuntu + ".jsonp.jsp"; 
	vpm_dist.Fedora = vpm_dist.Fedora + ".jsonp.jsp"; 
}

var vpm_pkg = {
    Mac32   : _vpm_pkgBase + "/veraport.pkg",
    Mac64   : _vpm_pkgBase + "/veraport.pkg",
    Dev32   : _vpm_pkgBase + "/veraport_i386.deb",
    Dev64   : _vpm_pkgBase + "/veraport_amd64.deb",
    Rpm32   : _vpm_pkgBase + "/veraport.i386.rpm",
    Rpm64   : _vpm_pkgBase + "/veraport.x86_64.rpm"
};
var vpm_pkg_g3 = {
    Mac32   : _vpm_pkgBase + "/veraport-g3.pkg",
    Mac64   : _vpm_pkgBase + "/veraport-g3.pkg",
    Dev32   : _vpm_pkgBase + "/veraport-g3_i386.deb",
    Dev64   : _vpm_pkgBase + "/veraport-g3_amd64.deb",
    Rpm32   : _vpm_pkgBase + "/veraport-g3.i386.rpm",
    Rpm64   : _vpm_pkgBase + "/veraport-g3.x86_64.rpm"
};

var vpm_version = {
    Mac     : "2.7.0.3",
    Linux   : "2.7.0.3"
};
var vpm_version_g3 = {
    Mac     : "3.7.0.3",
    Linux   : "3.7.0.3"
};

var vpm_mimeType = {
    Mac     : "application/x-veraport20-plugin",
    Linux   : "application/x-veraport20-plugin"
};

/* platform modify config */
if (VP_config.useHandler) {
    vpm_pkg = vpm_pkg_g3;
    vpm_version = vpm_version_g3;
}

if (VP_platformInfo.Mac) {
    VP_config.mimeType = vpm_mimeType.Mac;
    VP_config.version = vpm_version.Mac;
} else if (VP_platformInfo.Linux) {
    VP_config.mimeType = vpm_mimeType.Linux;
    VP_config.version = vpm_version.Linux;
}

var header_name = {
	name : "프로그램명",
	content : "내용",
	installCondition : "설치현황"
}
var header_name_eng = {
	name : "Program Name",
	content : "Content",
	installCondition : "Condition"
}
var vpm_message = {
    restart     : "브라우저를 종료후 다시 실행해주세요.",
    success     : "설치완료",
    download    : "다운로드중",
    ready       : "설치안됨",
    working     : "설치중",
    fail        : "설치실패",
    download_fail:"다운로드실패"
};
var vpm_message_eng = {
    restart     : "You must restart the browser.",
    success     : "success",
    download    : "download",
    ready       : "ready",
    working     : "working",
    fail        : "fail",
    download_fail:"download_fail"
};
if (VP_SystemLang == "ENG") {
    vpm_message = vpm_message_eng;
    header_name = header_name_eng;
} else if (VP_SystemLang == "CHN") {
    vpm_message = vpm_message_eng;
    header_name = header_name_eng;
} else if (VP_SystemLang == "JPN") {
    vpm_message = vpm_message_eng;
    header_name = header_name_eng;
}

var vpm_siteui = {
    bgName       : VP_BASE_URL + "/siteui/normal_name_bg.gif",
    siteLogoName : VP_BASE_URL + "/siteui/normal_name_logo.gif",

    bgDesc       : VP_BASE_URL + "/siteui/normal_desc_bg.gif",
    siteLogoDesc : VP_BASE_URL + "/siteui/normal_desc_logo.gif",

    iconDefault  : VP_BASE_URL + "/siteui/icon_default.gif",
    iconDownload : VP_BASE_URL + "/siteui/icon_download.gif"
};
var jsonInfo = null;


/*
if (!VP_browserInfo.MSIE) {
    VP_config.installPage = VP_BASE_URL + "/install.html";
}
*/
if (!VP_platformInfo.Windows) {
    VP_config.axInfoURL = "";
    VP_config.exeUrl = "";
}

/* Initialize */
//TODO:veraport20.js로 이동해도 무방
try {
    if (!VP_platformInfo.Windows) {

        //MutiOS용 함수 assign
        vp_showVeraport = vpm_showVeraport;
        vp_init = vpm_init;
        vp_createObject = vpm_createObject;
        vp_loadInfo = function() {};
        vp_checkVp20Plugin = vpm_checkVp20Plugin;
        vp_checkVp20Install = vpm_checkVp20Install;

        if (VP_config.isCreateObject && !VP_config.useHandler) {
            vp_createObject();
            vp_init();
        }
    }
}
catch(err) {
    vp_alert("vp_Main[" + err.description  + "]");
}

function vpm_compareVersion(version1, version2){
    var v1 = version1.split(/\.|,/);
    var v2 = version2.split(/\.|,/);
    
    var len = Math.min(v1.length, v2.length);	
    for(var i=0; i<len; i++){
        var n1 = parseInt(v1[i], 10);
        var n2 = parseInt(v2[i], 10);
        if(n1 != n2 ) return n1 - n2;
    }	
    if(v1.length == v2.length) return 0;
    
    for(var i=len; i<v1.length; i++){
        var n1 = parseInt(v1[i], 10);
        if(n1 !=0 ) return 1;
    }
    
    for(var i=len; i<v2.length; i++){
        var n2 = parseInt(v2[i], 10);
        if(n2 !=0 ) return -1;
    }
    
    return 0;
}

function vpm_getPlugins() {    
    if(VP_browserInfo.Safari && vpm_compareVersion(VP_browserInfo.version, "10.0") >=0 ){    	
    	var plugins = [];
    	for(var i=0;i<navigator.mimeTypes.length;i++) {
    		var mimeType = navigator.mimeTypes[i];
    		var plugin = mimeType.enabledPlugin;    		
    		plugins.push(plugin);
    	}
    	return plugins;
    }
    else{
    	return navigator.plugins;
    }
}

function vpm_getPluginInfo(mimeType) {
    var plugins = vpm_getPlugins(); 
    	
    if(plugins == null || plugins.length == 0) return false;

    for(var i=0;i<plugins.length;i++) {
      try {
        if (typeof(plugins[i]) == "undefined" || plugins[i].length == 0) continue;
        var type = plugins[i][0].type;
        if(type == mimeType) return plugins[i][0];
      } catch(err) {}
    }
    return null;
}
function vpm_getVersionToInteger(version) {
    var ret = "";
    var size = 3;

    var version = version.replace(/\./gi, ",");
    var imsi = version.split(',');
    for(var i=0; i<imsi.length; i++) {
        for(var j=imsi[i].length; j<size; j++) ret += "0";
        ret += imsi[i];
    }
    return parseInt(ret, 10);
}
function vpm_getPluginVersion(plugin) {
    if (plugin == null) return "1.0.0.0";

    plugin = plugin.enabledPlugin;
    if(plugin == null) return "1.0.0.0";

    var desc = plugin.description;
    //alert(desc); //Delfino Mozila Plugin 1.0.0.7
    if(desc == "") return "1.0.0.0";

    var installVersion = "1.0.0.0";
    var result = new RegExp("version[=: ]?(\\d\(.?\\d)*)","i").exec(desc);
    if (result != null && result != undefined) {
        installVersion = result[1];
    } else {
        var idx = desc.lastIndexOf(" ");
        installVersion = desc.substring(idx+1); //1.0.0.7
    }
    installVersion = installVersion.replace(/\./gi, ",");
    //alert(installVersion);
    return installVersion;
}
function vpm_checkVp20Install(goInstallPage) {
    var ret = vpm_checkVp20Plugin();
    if (!ret && goInstallPage) vp_goVp20InstallPage();
    return ret;
}
function vpm_checkVp20Plugin() {
    /*
    var plugins = navigator.plugins;
    if(plugins == null || plugins.length == 0) return false;
    for(var i=0;i<plugins.length;i++) {
        //modify 2010.11.02
        if (typeof(plugins[i][0]) == "undefined") continue;
        if(VP_config.mimeType == plugins[i][0].type ) return true;
    }
    return false;
    */
    var isVersionCheck = true;
    var version = VP_config.version;
    var mimeType = VP_config.mimeType;
    //alert("version[" + version + "] mimeType[" + mimeType + "]");

    //navigator.plugins.refresh(); //TODO: ???
    var plugin = vpm_getPluginInfo(mimeType);
    if(!plugin) return false;

    if (isVersionCheck) {
        var chkVersion = vpm_getVersionToInteger(version);
        var installVersion = vpm_getVersionToInteger(vpm_getPluginVersion(plugin));
        //alert("version[" + version + "] chkVersion[" + chkVersion + "] installVer[" + installVersion + "]");
        if(installVersion < chkVersion) return false;
    }
    return true;
}
function vpm_createObject(){
    if (vpm_checkVp20Plugin()) {
        //var objstr = '<embed id="Vp20Ctl" type="application/x-veraport20-plugin" width=600 height=40>';
        var objstr = '<embed ID="Vp20Ctl" width="0" height="0" ';
        objstr += 'type="' + VP_config.mimeType + '" />';
        //alert(objstr);
        document.write(objstr);
    }
    //html dialog create
}

//TODO: 쿠키체크하다 안되서 그냥
//function vp_getObject() {
//     return document.getElementById("Vp20Ctl");
//}

/*
function vpm_InstallCheck(installType, objectName){
    if (VP_TYPE_MANAGE == installType) { //"manage"
        alert("베라포트 관리화면");
        return;
    }
    try {
        //plugins reload
        navigator.plugins.refresh(false);
        var vCookie = new VPCookie("veraportInstallComplete",0);
        if(vCookie.isEqualValue("Y") == true) return;
        VPmulti_SetConfigures();
        var cnt = vp_getObject().GetUninstalledCnt(0);
        if(cnt>0){
            var thisPage = window.location.href;
            if (thisPage.indexOf(vp_InstallRunPage) < 0) {
                window.location.href = vp_InstallRunPage + "?type=" + installType + "&name=" + objectName + "&url=" + thisPage;
            }
        }
    }
    catch(e){alert("vpm_InstallCheck:" + e);}
}
*/
function vpm_getAxInfo(){
    if (vp_getObject() == null) return;

    if (VP_platformInfo.Mac) {
        VP_config.axInfoURL = vpm_dist.Mac;
    } else if (VP_platformInfo.Linux) {
        var os = navigator.userAgent;
        try { os = vp_getObject().GetOSInfo(); } catch(e){ /*alert("vpm_init(GetOSInfo):" + e);*/ }
        if (os.match(/ubuntu/i)) {
            VP_config.axInfoURL = vpm_dist.Ubuntu;
        }
        else if(os.match(/fedora/i)){
            VP_config.axInfoURL = vpm_dist.Fedora;
        }
        else {
            vp_alert("vpm_getAxInfo: os: " + os);
            VP_config.axInfoURL = vpm_dist.Ubuntu;
        }
    }
    //alert(VP_config.axInfoURL);
    return VP_config.axInfoURL;
}

function vpm_loadInfo(){
    if (vp_getObject() == null) return;

    if (vpm_getAxInfo().indexOf('?') < 0) {
        dummy = "?dummy=" + new Date().getTime();
    } else {
        dummy = "&dummy=" + new Date().getTime();
    }
    var url = vpm_getAxInfo() + dummy;
    
    if(vmp_jsonp){
    	 jQuery.ajax({
             url: url,
             dataType: 'jsonp',
             jsonpCallback: "axInfoCallback",
             success: function(data){
            	 vp_setConfigure(VP_CONF_AXINFO, data);
             },
         	 error: function(xhr) {
         		alert("axinfo request fail!");
         	}
         });
    }
    else{
	    var data = vpm_get(url);
	    if(data!=null){
	        vp_setConfigure(VP_CONF_AXINFO, data);
	    }
	    
	    else{
	        alert("axinfo request fail!");
	    }
    }
}

var vpm_inited = false;
function vpm_init() {
    if (vp_getObject() == null) return;

    if(vpm_inited)return;
    vpm_inited = true;

    var browser = vpm_GetBrowser();
    //vp_getObject().SetConfigure(VP_CONF_BROWSER, browser.name+"/"+browser.version);
    vp_setConfigure(VP_CONF_BROWSER, browser.name+"/"+browser.version);

    vp_setDomain(VP_DOMAIN_URL); //add 2013-01-16
    vp_setLogSendUrl(VP_config.logInfoSendURL);
    vp_setClientInfoSendUrl(VP_config.cliInfoSendURL);
    vp_setSelectObject("");
    vp_setConfigure("sendMacAddr", ""+VP_config.sendMacAddr); //v3.7.1.1

    if (!VP_config.useHandler) vpm_loadInfo();
}

var veraport_dialog_opened = false;

var vmp_type = null;

function vpm_showDialog(type){
    vmp_type = type;

    if(vmp_jqueryUI){
        var dialog_id = null;
        var minWidthValue = 0;
        var minHeightValue = 0;

        if(type == VP_TYPE_NORMAL_NAME){
            dialog_id = "#dialogex";
            minWidthValue = 450;
            minHeightValue = 300;
        }
        else if(type == VP_TYPE_NORMAL_DESC){
            dialog_id = "#dialogex";
            minWidthValue = 670;
            minHeightValue = 360;
        }
        else{
            dialog_id = "#dialog";
            minWidthValue = 280;
            minHeightValue = 300;
            jQuery( "#progressbar" ).progressbar();
        }

        jQuery(dialog_id).dialog({
            closeOnEscape: false,
            modal: true,
            resizable: false,
            minWidth: minWidthValue,
            minHeight: minHeightValue,
            autoOpen: false,
            zIndex: 99999
        });
        jQuery(dialog_id).dialog("open");
    }
    else {
        if(veraport_dialog_opened) return;

        if(type == VP_TYPE_NORMAL_NAME || type == VP_TYPE_NORMAL_DESC){
            vpm_createDialogEx(type);
        }else{
            vpm_createDialog();
        }
    }
}

function vpm_showVeraport(type, goInstallPage, objectName){
    if(!vp_checkVp20Install(goInstallPage)) return;
    if (vp_getObject() == null) return;

    //vpm_loadInfo();
    //vp_setLogSendUrl(VP_config.logInfoSendURL);
    //vp_setClientInfoSendUrl(VP_config.cliInfoSendURL);

    try {
        vpm_showDialog(type);
        vp_getObject().Show();
    } catch(err) {VP_complete();}
}

function vpm_GetBrowser(){
    var userAgent = navigator.userAgent.toLowerCase();
    var rbrowsers = [
            [/firefox/, /firefox[ \/]([\w.]+)/]
            ,[/chrome/, /chrome[ \/]([\w.]+)/]
            ,[/safari/, /version[ \/]([\w.]+)/]
            ,[/opera/, /version[ \/]([\w.]+)/]
            ,[/msie/, /msie ([\w.]+)/]
            ,[/crios/, /crios[ \/]([\w.]+)/]
            ,[/opios/, /opios[ \/]([\w.]+)/]
            ];
    var name="";
    var version="";
    for(i=0; i<rbrowsers.length; i++){
        var rbrowser = rbrowsers[i];
        var match = rbrowser[0].exec(userAgent);
        if(match){
            name = match[0];
            match = rbrowser[1].exec(userAgent);
            version = match[1];
            break;
        }
    }
    var browser = {name:name, version:version};
    return browser;
}

//callback에 의해 처리되는 함수들
function vpm_getMessage(status){
    var message="";
    if(status == "success"){
        message =  vpm_message.success;
    } else if(status == "download"){
        message =  vpm_message.download;
    } else if(status == "ready"){
        message =  vpm_message.ready;
    } else if(status == "working"){
        message =  vpm_message.working;
    } else if(status == "fail"){
        message =  vpm_message.fail;
    } else if (status == "download_fail") {
        message = vpm_message.download_fail;
    }
    return message;
}

function VP_setInstallList(json){
    //alert(json);
    var list = jQuery.parseJSON(json);
    var i, html = "";

	jQuery("#install-list-header").empty();
	html += jQuery("<caption id='install-list-caption'>VeraPort MultiOS install list</caption>").html();
    html += vpm_createListHeader();
    jQuery("#install-list-header").html(html);

    html = "";

    var focusHeight = 40;
    var currentTop = 0;
    if(vmp_type == VP_TYPE_NORMAL_DESC){
        focusHeight += 8;
    }
    jQuery(".veraport-list-box-ex").css("height", focusHeight*4 + "px");

    for (i = 0; i < list.length; i++) {
        var obj = list[i];
        html += vpm_createListBody(obj);
        if(obj.status == "success" || obj.status == "fail"){
            currentTop += focusHeight;
        }
    }

    jQuery("div.veraport-list-box-ex").scrollTop(currentTop);

    if(vmp_type == VP_TYPE_NORMAL_NAME || vmp_type == VP_TYPE_NORMAL_DESC){
		jQuery("#install-list-body").empty();
		html += jQuery("<caption>VeraPort MultiOS install list</caption>").html();
        jQuery("#install-list-body").html(html);
    }
    else{
        jQuery("#install-list").html(html);
    }
}
function VP_setInstallMessage(value){
    jQuery("#install-message").html(value);
}
function VP_setInstallStage(value){
    jQuery("#install-stage").html(value);
}
function VP_setInstallProgress(value){
    if(vmp_type == VP_TYPE_NORMAL_NAME || vmp_type == VP_TYPE_NORMAL_DESC){
        jQuery("#percent").css("textAlign", "center");
        jQuery("#percent").text(value);
    }
    else{
    if (vmp_jqueryUI) {
        jQuery("#progressbar").progressbar("value", value);
    } else {
        jQuery("#veraport-progressbar-value").css("width", value + "%");
    }
  }
}

function VP_complete(){
    navigator.plugins.refresh(false);

    var dialog_id = null;
      if(vmp_type == VP_TYPE_NORMAL_NAME || vmp_type == VP_TYPE_NORMAL_DESC){
        dialog_id = "#dialogex";
      }
      else{
        dialog_id = "#dialog";
      }

    if (vmp_jqueryUI) {
        jQuery(dialog_id).dialog("close");
    } else {
        jQuery(dialog_id).css("display", "none");
        jQuery(dialog_id).appendTo(document.body);
        jQuery("#veraport-overlay").remove();
        jQuery("#veraport-ui-dialog").remove();
        veraport_dialog_opened = false;
    }
    vp_delay(500);
    if (typeof VP_axInstallCB === "function" && !VP_config.useHandler) setTimeout("VP_axInstallCB()", 500);
}


function VP_updated(){
    if(VP_platformInfo.Linux || VP_platformInfo.MAC){
        alert(vpm_message.restart);
    }
}

function vpm_get(url){
    if(vmp_jqueryAjax){
        var response = null;
        jQuery.ajax({
            url: url,
            async: false,
            dataType: 'text',
            success: function(data){
                response = data;
            }
        });
        return response;
    }
    else{
        var request = false;
        if (window.XMLHttpRequest) {
            request=new XMLHttpRequest();
        } else if (window.ActiveXObject) {
            request=new ActiveXObject("Microsoft.XMLHTTP");
        }
        if (!request){
            alert('Error initializing XMLHttpRequest!');
            return null;
        }
        request.open('GET', url, false);
        request.send(null);
        if (request.status === 200) {
            return request.responseText;
        }
        return null;
    }
}

/*
* veraport normal2, normal3 script add
* 2013-10-14
*/

function vpm_createDialog(){
	
	jQuery("#install-list").empty();
	jQuery("#install-list").append("<caption>VeraPort MultiOS install list</caption>");
	jQuery("#install-message").empty();
	jQuery("#install-stage").empty();
	jQuery("#veraport-progressbar-value").empty();
	
    var overlay = jQuery('<div id="veraport-overlay">')
    .addClass("veraport-ui-widget-overlay veraport-ui-front")
    .appendTo( document.body);

    var uiDialog = jQuery('<div id="veraport-ui-dialog">').addClass( "veraport-ui-dialog veraport-ui-widget-content veraport-ui-corner-all veraport-ui-front ");
    uiDialog.appendTo(document.body);
    jQuery("#dialog").appendTo(uiDialog);

    var left = (jQuery(window).width() - 300) / 2 + window.scrollX;
    var top = (jQuery(window).height() - jQuery("#dialog").height()) / 2 + window.scrollY;

    uiDialog.attr({
        style:"display: block; z-index: 100001; outline: 0px; height: auto; width: 300px; top: "+ top + "px; left: " + left + "px;"
    });
    jQuery("#dialog").css("display", "");
}




function vpm_createDialogEx(type){
    var bgUrl = "";
    var siteLogoUrl = "";
    var left=0, top=0, width=0, height=0;

    jQuery('<div id="veraport-overlay">').addClass("veraport-ui-widget-overlay").appendTo(document.body);
    var uiDialog = jQuery('<div id="veraport-ui-dialog">').addClass("veraport-ui-dialog-ex veraport-ui-widget-content");
    uiDialog.appendTo(document.body);
    var site_logo_height = "";
    jQuery("#dialogex").appendTo(uiDialog);


    jsonInfo = vpm_getJsonDataInfo();


    if(type == "normalname"){
        width = 448;
        height = 298;
        left = (jQuery(window).width() - width) / 2 + window.scrollX;
        top = (jQuery(window).height() - height) / 2 + window.scrollY;

        uiDialog.addClass("veraport-ui-normalnamebg");

        bgUrl = jsonInfo.info.images.normalname.bg;
        if(bgUrl == "")
            bgUrl = vpm_siteui.bgName;

        siteLogoUrl = jsonInfo.info.images.normalname.logo;
        if(siteLogoUrl == "")
            siteLogoUrl = vpm_siteui.siteLogoName;

        //site_logo_height="50";
        site_logo_height="80";

    }else if(type == "normaldesc"){
        width = 668;
        height = 358;
        left = (jQuery(window).width() - width) / 2 + window.scrollX;
        top = (jQuery(window).height() - height) / 2 + window.scrollY;

        uiDialog.addClass("veraport-ui-normaldescbg");

        bgUrl = jsonInfo.info.images.normaldesc.bg;
        if(bgUrl == "")
            bgUrl = vpm_siteui.bgDesc;

        siteLogoUrl = jsonInfo.info.images.normaldesc.logo;
        if(siteLogoUrl == "")
            siteLogoUrl = vpm_siteui.siteLogoDesc;

        site_logo_height="110";
    }else{
        alert("vpm_createDialogEx type error!");
        return;
    }



    if(bgUrl.indexOf("http://") == -1 && bgUrl.indexOf("https://") == -1){
        bgUrl = VP_SITE_URL + bgUrl;
    }

    if(siteLogoUrl.indexOf("http://") == -1 && siteLogoUrl.indexOf("https://") == -1){
        siteLogoUrl = VP_SITE_URL + siteLogoUrl;
    }

    var logo = jQuery("#install-site-logo");
    logo.attr({
        style:"width:" + width + "px; height:" + site_logo_height + "px; background-repeat:no-repeat; background-position:20px; background-image:url(" + siteLogoUrl + ");"
    });


    uiDialog.attr({
        style:"z-index: 100001; " + "width:" + width + "px; height:" + height + "px; top: "+ top + "px; left: " + left + "px; background-image:url(" + bgUrl + ");"

    });

    jQuery("#dialogex").css("display", "");
}

function vpm_getJsonDataInfo(){

    if(jsonInfo == null){

        if (VP_config.addInfoURL.indexOf('?') < 0) {
            dummy = "?dummy=" + new Date().getTime();
        } else {
            dummy = "&dummy=" + new Date().getTime();
        }

        var url = VP_config.addInfoURL + dummy;
        var data = vpm_get(url);
        return jQuery.parseJSON(data);
    }else{
        return jsonInfo;
    }

}

function vpm_getContent(obj){
    var i, content = obj.description;
    var jsonData = vpm_getJsonDataInfo();

    for (i = 0; i < jsonData.modules.length; i++) {
        var info = jsonData.modules[i];
        if(info.name == obj.objectName){
            if(info.desc != "") content = info.desc;
        }
    }

    if(content == ""){
        content = obj.name;
    }
    return content;
}

function vpm_getIconUrl(obj){
    var i, icon = vpm_siteui.iconDefault;
    var jsonData = vpm_getJsonDataInfo();

    for (i = 0; i < jsonData.modules.length; i++) {
        var info = jsonData.modules[i];
        if(info.name == obj.objectName){
            if(info.icon != "") icon = info.icon;
        }
    }

    return icon;
}

function vpm_getTitle(obj){
    var i, title = obj.displayName;
    var jsonData = vpm_getJsonDataInfo();

    for (i = 0; i < jsonData.modules.length; i++) {
        var info = jsonData.modules[i];
        if(info.name == obj.objectName){
            if(info.title != "") title = info.title;
        }
    }
    return title;
}


var vpm = vpm || {};

if (typeof jQuery != "undefined" ) {

  vpm = vpm || (function(jQuery){
        _vpm = {};
        return _vpm;
    }
  )(jQuery);

  vpm.n2 = vpm.n2 || (function(jQuery){
    _vpm2 = {};
    _vpm2 = jQuery.extend(true,_vpm2,vpm);
    _vpm2.getHeaderSize = function(){
        return ["70%","-1","30%"];
    };
    return _vpm2;
  })(jQuery);

  vpm.n3 = vpm.n3 || (function(jQuery) {
    _vpm3 = {};
    _vpm3 = jQuery.extend(true,_vpm3,vpm);
    _vpm3.getHeaderSize = function(){
        return ["25%", "63%", "12%"];
    };

    return _vpm3;
  })(jQuery);
}

function vpm_factory(type) {
    if(type == "normalname")
        return vpm.n2;
    if(type == "normaldesc")
        return vpm.n3;
    throw "e";
}

function vpm_createListHeader(){

    try {
        var thead = jQuery("<thead></thead>");
        var tr = jQuery("<tr></tr>");

        var header_text = [header_name.name, header_name.content, header_name.installCondition];
        var header_size = vpm_factory(vmp_type).getHeaderSize();

        jQuery.each(header_text,
            function(index,text) {
                var size = header_size[index];
                if(size == "-1")
                    return;

                var th = jQuery("<td></td>");
                th.css("width",header_size[index]);
                th.css("height","26px");
                th.css("textAlign","center");
                th.html(text);
                th.addClass("veraport-header-font");
                tr.append(th);
            }
        );
        thead.append(tr);
        return thead.html();
    }
    catch(e) { return ""; }

}


function getTitleTd(obj){
    var td = document.createElement("td");

    td.innerText = vpm_getTitle(obj);
    td.textContent = td.innerText;

    td.className = "veraport-body-font";

    td.width= "25%";
    td.style.fontWeight = 'bold';
    td.style.paddingLeft = "50px";
    td.style.backgroundImage = "url(" + vpm_getIconUrl(obj) + ")";
    td.style.backgroundRepeat = "no-repeat";
    td.style.backgroundPosition = "5% 50%";
    //td.style.backgroundPosition = "left center";
    //td.style.overflow = "hidden";
    //td.style.textOverflow = "ellipsis";
    //td.style.whiteSpace = "nowrap";
    if(vmp_type == "normalname"){
        td.height="40px";
    }
    else if(vmp_type == "normaldesc"){
        td.height="48px";

    }
    return td;
}

function getContentTd(obj){
    var td = document.createElement("td");
    td.innerText = vpm_getContent(obj);
    td.textContent = td.innerText;
    td.width= "63%";
    td.className = "veraport-body-font";
    //td.style.borderLeft = "1px solid #F0F0F0";
    //td.style.borderRight = "1px solid #F0F0F0";

    return td;
}

function getStatusTd(status){
    var td = document.createElement("td");

    td.className = "veraport-body-font";
    td.style.textAlign = "center";

    td.width= "12%";
    if(vmp_type == "normalname"){
        td.width= "11%";
    }

    var jsonData = vpm_getJsonDataInfo();


    if(status == "working"){
        td.className = "veraport-body-font";
        var icon = vpm_siteui.iconDownload;

        if(jsonData.info.images.common.progress != ""){
            icon = jsonData.info.images.common.progress;

            if(icon.indexOf("http://") == -1 && icon.indexOf("https://") == -1){
                icon = VP_SITE_URL + icon;
            }
        }

        td.style.backgroundRepeat = "no-repeat";
        td.style.backgroundPosition = "center";
        td.style.backgroundImage = "url(" + icon + ")";

        td.id = "percent";
    }
    else if(status == "download"){

        td.style.fontWeight = 'bold';
        td.className = "veraport-body-font";

        var icon = vpm_siteui.iconDownload;

        if(jsonData.info.images.common.progress != ""){
            icon = jsonData.info.images.common.progress;

            if(icon.indexOf("http://") == -1 && icon.indexOf("https://") == -1){
                icon = VP_SITE_URL + icon;
            }
        }
        td.style.backgroundRepeat = "no-repeat";
        td.style.backgroundPosition = "center";
        td.style.backgroundImage = "url(" + icon + ")";
        td.id = "percent";
    }
    else{
        td.style.fontWeight = 'bold';
        if(status == "fail"){
            td.style.color = "red";
        }
        else{
            td.style.color = "black";
        }

        td.innerText = vpm_getMessage(status);
        td.textContent = td.innerText;
    }

    return td;
}


function vpm_createListBody(obj){

    var status = obj.status;
    /*
    if(status == "success" && jQuery("#percent").text() == "100"){
        var height = jQuery("div.veraport-list-box-ex").scrollTop() + 48;
        jQuery("div.veraport-list-box-ex").scrollTop(height);
    }
    */
    if (status == "download_fail") {
        status = "fail";
    }



    if(vmp_type == "normalname" || vmp_type == "normaldesc"){

        var tr = document.createElement("tr");
        tr.appendChild(getTitleTd(obj));

        if(vmp_type == "normaldesc"){
            tr.appendChild(getContentTd(obj));
        }

        tr.appendChild(getStatusTd(status));

        // ubuntu fedora firefox에서 list가 안나옴. 아래코드로 변경.
        return jQuery('<div>').append(jQuery(tr).clone()).html();
        //return tr.outerHTML;
    }
    else{
        var one = '<tr><td class="veraport-' + status + '">' + obj.name + '</td>'
                    + '<td>' + vpm_getMessage(obj.status) + '</td></tr>';
        //alert(one);
        return one;
    }
}

function vpm_getInstallDialog() {
    var dialog = '';
    dialog += '<div class="veraport-ui-corner-all" style="background-color:#FFFFFF; width:300px;" >\n';
    dialog += '  <div style="padding-top:5px"><img src="' + VP_config.logoSmall + '" alt="VeraPort_logo" /></div>\n';
    dialog += '  <div><img src="' + VP_config.msgSmall + '" alt="VeraPort_msg" /></div>\n';
    dialog += '  <div class="veraport-ui-corner-all veraport-list-box veraport-component">\n';
    dialog += '    <table id="install-list" class="veraport-font" style="width:100%;">\n';
    dialog += '      <caption>VeraPort MultiOS install list</caption>\n';
    dialog += '          <tr><td>-</td><td>-</td></tr>\n';
    dialog += '    </table>\n';
    dialog += '  </div>\n';
    dialog += '  <div class="veraport-component">\n';
    dialog += '    <div id="install-message" class="veraport-font veraport-message">...</div>\n';
    dialog += '    <div id="install-stage" class="veraport-font" style="float:right;"></div>\n';
    dialog += '  </div>\n';
    dialog += '  <div id="progressbar" class="veraport-component veraport-ui-progressbar veraport-ui-widget veraport-ui-widget-content veraport-ui-corner-all" style="border:1px solid #F6A828">\n';
    dialog += '    <div id="veraport-progressbar-value" class="veraport-ui-progressbar-value veraport-ui-corner-left" style="width:0%;background-color: #F6A828"></div>\n';
    dialog += '  </div>\n';
    dialog += '  <div class="veraport-copyright-font veraport-component">wizvera</div>\n';
    dialog += '</div>\n';
    return dialog;
}
function vpm_getInstallDialogEX() {
    var dialog = '';
    dialog += '<div style="width:100%; height:218px;" >\n';
    dialog += '  <div id="install-site-logo"></div>\n';
    dialog += '  <div style="clear:both; overflow:hidden; margin-left:30px; margin-right:30px; ">\n';
    dialog += '    <table id="install-list-header" class="veraport-font" style="width:100%; TABLE-layout:fixed; border-spacing:0;" >\n';
    dialog += '      <caption id="install-list-caption">VeraPort MultiOS install list</caption>\n';
    dialog += '          <tr><td>-</td><td>-</td><td>-</td></tr>\n';
    dialog += '    </table>\n';
    dialog += '  </div>\n';
    dialog += '  <div style="clear:both; overflow:auto; margin-left:30px; margin-right:30px;" class="veraport-list-box-ex">\n';
    dialog += '    <table id="install-list-body" class="veraport-font" style="width:100%; TABLE-layout:fixed; border-spacing:0;">\n';
    dialog += '      <caption>VeraPort MultiOS install list</caption>\n';
    dialog += '          <tr><td>-</td><td>-</td><td>-</td></tr>\n';
    dialog += '    </table>\n';
    dialog += '  </div>\n';
    dialog += '  <div class="veraport-copyright-font-ex veraport-component"><font color="#15244F">Veraport&nbsp;</font><font color="#666666">by&nbsp;wizvera</font></div>\n';
    dialog += '</div>\n';
    return dialog;
}
function vpm_getInstallDialogString() {
    var dialog = '';
    dialog += '<div id="dialog" style="display:none">\n';
    dialog += vpm_getInstallDialog();
    dialog += '</div>\n';
    dialog += '<div id="dialogex" style="display:none">\n';
    dialog += vpm_getInstallDialogEX();
    dialog += '</div>\n';
    return dialog;
}

//end

/*
http://www.JSON.org/json2.js
2011-02-23

Public Domain.

NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.

See http://www.JSON.org/js.html


This code should be minified before deployment.
See http://javascript.crockford.com/jsmin.html

USE YOUR OWN COPY. IT IS EXTREMELY UNWISE TO LOAD CODE FROM SERVERS YOU DO
NOT CONTROL.


This file creates a global JSON object containing two methods: stringify
and parse.

    JSON.stringify(value, replacer, space)
        value       any JavaScript value, usually an object or array.

        replacer    an optional parameter that determines how object
                    values are stringified for objects. It can be a
                    function or an array of strings.

        space       an optional parameter that specifies the indentation
                    of nested structures. If it is omitted, the text will
                    be packed without extra whitespace. If it is a number,
                    it will specify the number of spaces to indent at each
                    level. If it is a string (such as '\t' or '&nbsp;'),
                    it contains the characters used to indent at each level.

        This method produces a JSON text from a JavaScript value.

        When an object value is found, if the object contains a toJSON
        method, its toJSON method will be called and the result will be
        stringified. A toJSON method does not serialize: it returns the
        value represented by the name/value pair that should be serialized,
        or undefined if nothing should be serialized. The toJSON method
        will be passed the key associated with the value, and this will be
        bound to the value

        For example, this would serialize Dates as ISO strings.

            Date.prototype.toJSON = function (key) {
                function f(n) {
                    // Format integers to have at least two digits.
                    return n < 10 ? '0' + n : n;
                }

                return this.getUTCFullYear()   + '-' +
                     f(this.getUTCMonth() + 1) + '-' +
                     f(this.getUTCDate())      + 'T' +
                     f(this.getUTCHours())     + ':' +
                     f(this.getUTCMinutes())   + ':' +
                     f(this.getUTCSeconds())   + 'Z';
            };

        You can provide an optional replacer method. It will be passed the
        key and value of each member, with this bound to the containing
        object. The value that is returned from your method will be
        serialized. If your method returns undefined, then the member will
        be excluded from the serialization.

        If the replacer parameter is an array of strings, then it will be
        used to select the members to be serialized. It filters the results
        such that only members with keys listed in the replacer array are
        stringified.

        Values that do not have JSON representations, such as undefined or
        functions, will not be serialized. Such values in objects will be
        dropped; in arrays they will be replaced with null. You can use
        a replacer function to replace those with JSON values.
        JSON.stringify(undefined) returns undefined.

        The optional space parameter produces a stringification of the
        value that is filled with line breaks and indentation to make it
        easier to read.

        If the space parameter is a non-empty string, then that string will
        be used for indentation. If the space parameter is a number, then
        the indentation will be that many spaces.

        Example:

        text = JSON.stringify(['e', {pluribus: 'unum'}]);
        // text is '["e",{"pluribus":"unum"}]'


        text = JSON.stringify(['e', {pluribus: 'unum'}], null, '\t');
        // text is '[\n\t"e",\n\t{\n\t\t"pluribus": "unum"\n\t}\n]'

        text = JSON.stringify([new Date()], function (key, value) {
            return this[key] instanceof Date ?
                'Date(' + this[key] + ')' : value;
        });
        // text is '["Date(---current time---)"]'


    JSON.parse(text, reviver)
        This method parses a JSON text to produce an object or array.
        It can throw a SyntaxError exception.

        The optional reviver parameter is a function that can filter and
        transform the results. It receives each of the keys and values,
        and its return value is used instead of the original value.
        If it returns what it received, then the structure is not modified.
        If it returns undefined then the member is deleted.

        Example:

        // Parse the text. Values that look like ISO date strings will
        // be converted to Date objects.

        myData = JSON.parse(text, function (key, value) {
            var a;
            if (typeof value === 'string') {
                a =
/^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?)Z$/.exec(value);
                if (a) {
                    return new Date(Date.UTC(+a[1], +a[2] - 1, +a[3], +a[4],
                        +a[5], +a[6]));
                }
            }
            return value;
        });

        myData = JSON.parse('["Date(09/09/2001)"]', function (key, value) {
            var d;
            if (typeof value === 'string' &&
                    value.slice(0, 5) === 'Date(' &&
                    value.slice(-1) === ')') {
                d = new Date(value.slice(5, -1));
                if (d) {
                    return d;
                }
            }
            return value;
        });


This is a reference implementation. You are free to copy, modify, or
redistribute.
*/

/*jslint evil: true, strict: false, regexp: false */

/*members "", "\b", "\t", "\n", "\f", "\r", "\"", JSON, "\\", apply,
call, charCodeAt, getUTCDate, getUTCFullYear, getUTCHours,
getUTCMinutes, getUTCMonth, getUTCSeconds, hasOwnProperty, join,
lastIndex, length, parse, prototype, push, replace, slice, stringify,
test, toJSON, toString, valueOf
*/


//Create a JSON object only if one does not already exist. We create the
//methods in a closure to avoid creating global variables.

var JSON;
if (!JSON) {
JSON = {};
}

(function () {
"use strict";

function f(n) {
    // Format integers to have at least two digits.
    return n < 10 ? '0' + n : n;
}

if (typeof Date.prototype.toJSON !== 'function') {

    Date.prototype.toJSON = function (key) {

        return isFinite(this.valueOf()) ?
            this.getUTCFullYear()     + '-' +
            f(this.getUTCMonth() + 1) + '-' +
            f(this.getUTCDate())      + 'T' +
            f(this.getUTCHours())     + ':' +
            f(this.getUTCMinutes())   + ':' +
            f(this.getUTCSeconds())   + 'Z' : null;
    };

    String.prototype.toJSON      =
        Number.prototype.toJSON  =
        Boolean.prototype.toJSON = function (key) {
            return this.valueOf();
        };
}

var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
    escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
    gap,
    indent,
    meta = {    // table of character substitutions
        '\b': '\\b',
        '\t': '\\t',
        '\n': '\\n',
        '\f': '\\f',
        '\r': '\\r',
        '"' : '\\"',
        '\\': '\\\\'
    },
    rep;


function quote(string) {

//If the string contains no control characters, no quote characters, and no
//backslash characters, then we can safely slap some quotes around it.
//Otherwise we must also replace the offending characters with safe escape
//sequences.

    escapable.lastIndex = 0;
    return escapable.test(string) ? '"' + string.replace(escapable, function (a) {
        var c = meta[a];
        return typeof c === 'string' ? c :
            '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
    }) + '"' : '"' + string + '"';
}


function str(key, holder) {

//Produce a string from holder[key].

    var i,          // The loop counter.
        k,          // The member key.
        v,          // The member value.
        length,
        mind = gap,
        partial,
        value = holder[key];

//If the value has a toJSON method, call it to obtain a replacement value.

    if (value && typeof value === 'object' &&
            typeof value.toJSON === 'function') {
        value = value.toJSON(key);
    }

//If we were called with a replacer function, then call the replacer to
//obtain a replacement value.

    if (typeof rep === 'function') {
        value = rep.call(holder, key, value);
    }

//What happens next depends on the value's type.

    switch (typeof value) {
    case 'string':
        return quote(value);

    case 'number':

//JSON numbers must be finite. Encode non-finite numbers as null.

        return isFinite(value) ? String(value) : 'null';

    case 'boolean':
    case 'null':

//If the value is a boolean or null, convert it to a string. Note:
//typeof null does not produce 'null'. The case is included here in
//the remote chance that this gets fixed someday.

        return String(value);

//If the type is 'object', we might be dealing with an object or an array or
//null.

    case 'object':

//Due to a specification blunder in ECMAScript, typeof null is 'object',
//so watch out for that case.

        if (!value) {
            return 'null';
        }

//Make an array to hold the partial results of stringifying this object value.

        gap += indent;
        partial = [];

//Is the value an array?

        if (Object.prototype.toString.apply(value) === '[object Array]') {

//The value is an array. Stringify every element. Use null as a placeholder
//for non-JSON values.

            length = value.length;
            for (i = 0; i < length; i += 1) {
                partial[i] = str(i, value) || 'null';
            }

//Join all of the elements together, separated with commas, and wrap them in
//brackets.

            v = partial.length === 0 ? '[]' : gap ?
                '[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']' :
                '[' + partial.join(',') + ']';
            gap = mind;
            return v;
        }

//If the replacer is an array, use it to select the members to be stringified.

        if (rep && typeof rep === 'object') {
            length = rep.length;
            for (i = 0; i < length; i += 1) {
                if (typeof rep[i] === 'string') {
                    k = rep[i];
                    v = str(k, value);
                    if (v) {
                        partial.push(quote(k) + (gap ? ': ' : ':') + v);
                    }
                }
            }
        } else {

//Otherwise, iterate through all of the keys in the object.

            for (k in value) {
                if (Object.prototype.hasOwnProperty.call(value, k)) {
                    v = str(k, value);
                    if (v) {
                        partial.push(quote(k) + (gap ? ': ' : ':') + v);
                    }
                }
            }
        }

//Join all of the member texts together, separated with commas,
//and wrap them in braces.

        v = partial.length === 0 ? '{}' : gap ?
            '{\n' + gap + partial.join(',\n' + gap) + '\n' + mind + '}' :
            '{' + partial.join(',') + '}';
        gap = mind;
        return v;
    }
}

//If the JSON object does not yet have a stringify method, give it one.

if (typeof JSON.stringify !== 'function') {
    JSON.stringify = function (value, replacer, space) {

//The stringify method takes a value and an optional replacer, and an optional
//space parameter, and returns a JSON text. The replacer can be a function
//that can replace values, or an array of strings that will select the keys.
//A default replacer method can be provided. Use of the space parameter can
//produce text that is more easily readable.

        var i;
        gap = '';
        indent = '';

//If the space parameter is a number, make an indent string containing that
//many spaces.

        if (typeof space === 'number') {
            for (i = 0; i < space; i += 1) {
                indent += ' ';
            }

//If the space parameter is a string, it will be used as the indent string.

        } else if (typeof space === 'string') {
            indent = space;
        }

//If there is a replacer, it must be a function or an array.
//Otherwise, throw an error.

        rep = replacer;
        if (replacer && typeof replacer !== 'function' &&
                (typeof replacer !== 'object' ||
                typeof replacer.length !== 'number')) {
            throw new Error('JSON.stringify');
        }

//Make a fake root object containing our value under the key of ''.
//Return the result of stringifying the value.

        return str('', {'': value});
    };
}


//If the JSON object does not yet have a parse method, give it one.

if (typeof JSON.parse !== 'function') {

    JSON.parse = function (text, reviver) {

//The parse method takes a text and an optional reviver function, and returns
//a JavaScript value if the text is a valid JSON text.

        var j;

        function walk(holder, key) {

//The walk method is used to recursively walk the resulting structure so
//that modifications can be made.

            var k, v, value = holder[key];
            if (value && typeof value === 'object') {
                for (k in value) {
                    if (Object.prototype.hasOwnProperty.call(value, k)) {
                        v = walk(value, k);
                        if (v !== undefined) {
                            value[k] = v;
                        } else {
                            delete value[k];
                        }
                    }
                }
            }
            return reviver.call(holder, key, value);
        }


//Parsing happens in four stages. In the first stage, we replace certain
//Unicode characters with escape sequences. JavaScript handles many characters
//incorrectly, either silently deleting them, or treating them as line endings.

        text = String(text);
        cx.lastIndex = 0;
        if (cx.test(text)) {
            text = text.replace(cx, function (a) {
                return '\\u' +
                    ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
            });
        }

//In the second stage, we run the text against regular expressions that look
//for non-JSON patterns. We are especially concerned with '()' and 'new'
//because they can cause invocation, and '=' because it can cause mutation.
//But just to be safe, we want to reject all unexpected forms.

//We split the second stage into 4 regexp operations in order to work around
//crippling inefficiencies in IE's and Safari's regexp engines. First we
//replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
//replace all simple value tokens with ']' characters. Third, we delete all
//open brackets that follow a colon or comma or that begin the text. Finally,
//we look to see that the remaining characters are only whitespace or ']' or
//',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.

        if (/^[\],:{}\s]*$/
                .test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')
                    .replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']')
                    .replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

//In the third stage we use the eval function to compile the text into a
//JavaScript structure. The '{' operator is subject to a syntactic ambiguity
//in JavaScript: it can begin a block or an object literal. We wrap the text
//in parens to eliminate the ambiguity.

            j = vp_jsonParse('(' + text + ')');

//In the optional fourth stage, we recursively walk the new structure, passing
//each name/value pair to a reviver function for possible transformation.

            return typeof reviver === 'function' ?
                walk({'': j}, '') : j;
        }

//If the text is not JSON parseable, then a SyntaxError is thrown.

        throw new SyntaxError('JSON.parse');
    };
}
}());

////////////////////////////////////////////////////////////
//wizvera
//TODO: need version
function pluginInfo2JSON() {
var plugins = vpm_getPlugins();
	
var pluginInfo = new Array();

for(var i=0; i < plugins.length; i++) {
    var _plugin = plugins[i];

    var plugin = new Object();

    plugin.name = _plugin.name;
    plugin.filename = _plugin.filename;
    plugin.description = _plugin.description;


    // when version is not exists, plugin dose NOT need to install . (so version 10000!!)
    plugin.version = "0";



    var re = new RegExp("version[=: ]?(\\d\(.?\\d)*)","i");
    var result = re.exec(plugin.description);

    if (result == null || result == undefined){
        result = new RegExp("(\\d\(.?\\d)*) *$").exec(plugin.description);
    }

    if (result != null && result != undefined) {
        plugin.version = result[1];
    } else{   //plugin description에서 못찾았을 때 mimeyte description에서 찾기
        for (var j = 0; j < _plugin.length; j++){
            var mimetype = _plugin[j];
            var re = new RegExp("version[=: ]?(\\d\(.?\\d)*)","i");
            var result = re.exec(mimetype.description);

            if (result == null || result == undefined){
                result = new RegExp("(\\d\(.?\\d)*) *$").exec(mimetype.description);
            }
            //alert("[" + result[0] + "][" + result[1] + "]");
            if (result != null && result != undefined) {
                plugin.version = result[1];
                break;
            }
        }
    }

//alert(plugin.name +":" + plugin.version);
    plugin.mimetypes = new Array();

    var mimeTypeCount = _plugin.length;

    for (var j=0; j < mimeTypeCount; j++) {
        plugin.mimetypes[j] = _plugin[j].type;
    }

    pluginInfo[i] = plugin;
}

return JSON.stringify(pluginInfo);
}
