//-----------------------------------------------------------------------------------------------------------------------
// * 고객사 전용(공통함수 필요시 추가해서 사용)
// * 작성일 : 2021-07-27
//-----------------------------------------------------------------------------------------------------------------------

/**
 * 인증서 필터링 설정값
 * CERT_Accept_Koscom
 * CERT_Accept_YesSign
 */
/*
var CERT_Accept_Koscom_sample
    = "1.2.410.200004.5.1.1.7|"  //증권전산, 법인, 상호연동
    + "1.2.410.200004.5.1.1.9|"  //증권전산, 개인, 용도제한(개인)*
    + "1.2.410.200004.5.1.1.5|"  //증권전산, 개인, 상호연동
    + "1.2.410.200004.5.2.1.2|"  //정보인증, 개인, 상호연동
    + "1.2.410.200004.5.2.1.1|"  //정보인증, 법인, 상호연동
    + "1.2.410.200004.5.3.1.9|"  //전산원,   개인, 상호연동
    + "1.2.410.200004.5.3.1.2|"  //전산원,   법인, 상호연동
    + "1.2.410.200004.5.4.1.1|"  //전자인증, 개인, 상호연동
    + "1.2.410.200004.5.4.1.2|"  //전자인증, 법인, 상호연동
    + "1.2.410.200005.1.1.1|"    //금결원,  개인, 상호연동
    + "1.2.410.200005.1.1.5|"    //금결원,  법인, 상호연동
    + "1.2.410.200012.1.1.1|"    //무역정보, 개인, 상호연동
    + "1.2.410.200012.1.1.3|"    //무역정보, 법인, 상호연동
;

var CERT_Accept_YesSign_sample
    = "1.2.410.200005.1.1.1|"    //금결원, 개인, 상호연동
    + "1.2.410.200005.1.1.2|"    //금결원, 법인, 용도제한(은행/보험/카드)
    + "1.2.410.200005.1.1.4|"    //금결원, 개인, 용도제한(은행/보험/카드)
    + "1.2.410.200005.1.1.5|"    //금결원, 법인, 상호연동
    + "1.2.410.200005.1.1.6.1|"  //금결원, 법인, 용도제한(기업뱅킹)
    + "1.2.410.200004.5.4.1.1|"  //전자인증, 개인, 상호연동
    + "1.2.410.200004.5.4.1.2|"  //전자인증, 법인, 상호연동
    + "1.2.410.200004.5.1.1.7|"  //증권전산, 법인, 상호연동
    + "1.2.410.200004.5.1.1.5|"  //증권전산, 개인, 상호연동
;
*/

function SITE_disableBrowserDP(message) {
    var DC_processingImageUrl = DelfinoConfig.processingImageUrl;
    if (jQuery("#dc_overlay") != null && jQuery("#dc_overlay").length > 0) return;
    var document = DelfinoConfig.insideIframe && DC_isIframe() ? top.window.document : window.document;
    var overlayHtml = '<div id="dc_overlay" style="z-index:100000;position:fixed; width:100%; height:100%; top:0px; left:0px; background-color: #000000; opacity: 0.3; filter: alpha(opacity=30);">';
    //overlayHtml = '<div id="dc_overlay" style="z-index:100000;position:fixed; width:100%; height:100%; top:0px; left:0px; background-color: rgba(0,0,0,0.0); opacity: 0.3; filter: alpha(opacity=30);">';
    if (message && DC_processingImageUrl) {
        overlayHtml += '<div style="z-index:100001;position:fixed;top:50%; height:100%;width:100%;">' + '<div style="margin: 0 auto; padding: 5px; width:150px; background-color:#fff; vertical-align:middle; font-weight:bold; text-align: center; color:#555;  border-radius:5px;">' + message + ' <img src="' + DC_processingImageUrl + '" style="vertical-align:middle"/>' + "</div>" + "</div>";
    } else if (DC_processingImageUrl) {
        overlayHtml += '<div style="z-index:100001;position:fixed;top:50%; height:100%;width:100%;">' + '<div style="margin: 0 auto; padding: 5px; width:26px; height:26px;  background-color:#fff; vertical-align:middle; font-weight:bold; text-align: center; color:#555;  border-radius:5px;">' + ' <img src="' + DC_processingImageUrl + '" style="vertical-align:middle"/>' + "</div>" + "</div>";
    }
    overlayHtml += "</div>";
    jQuery("body", document).append(overlayHtml);
}
//DC_disableBrowser = SITE_disableBrowserDP;
//window.DCrypto.goInstallPage = SITE_goInstallPage; //함수재정의필요

if (DC_browserInfo.MSIE && DC_browserInfo.version >= 11) {
    delfino.conf.handler.checkAjaxto = 5000; //미설치가 자주 나올경우 주석해제,미설치시 해당시간만큼 느려짐

    //JSONP 대신 ajax 로 원복시킴
    //delfino.conf.handler.supportSync = true;
    //delfino.conf.handler.ajaxto = 10000;
    //delfino.conf.handler.checkAjaxto = 10000;
}

function SITE_customInfoDialog(message, okCallback, cancelCallback, options) {
    //alert("customInfoDialog TEST: " + options.type + ":" + options.title + "\n" + message);
    if (typeof cancelCallback === "object") {
        options = cancelCallback;
        cancelCallback = new Function();
    }
    var color = options.color || {};
    var title = options.title;
    if ($("#wizvera-alert-dialog").length == 0) $("head").append('<style id="wizvera-alert-dialog">#wizveraAlertBackground{position:fixed;top:0;bottom:0;left:0;right:0;background-color:rgba(0, 0, 0, 0.15);vertical-align:middle;display:grid;align-items:center;align-content:center;justify-content:center;z-index:100010;}#wizveraAlertBackground .wizveraAlertDialog{display:block;width:80vw;max-width:540px;min-width:300px;background-color:#fff;box-sizing:border-box;display:grid;grid-template-rows:auto auto auto;grid-template-columns:top;grid-template-areas:"title""message""button";text-align:center;border-radius:12px;background-color:#fff;box-shadow:0 0 4px 0 rgba(0, 0, 0, 0.5);padding:21px;grid-row-gap:33px;max-height:100vh;}.wizveraAlertDialog .wizveraAlertTitle{grid-area:title;color:#292929;font-size:17px;font-weight:bold;letter-spacing:-1.2px;line-height:23px;padding-top:10px;}.wizveraAlertDialog .wizveraAlertMessage{grid-area:message;color:#333333;font-size:16px;letter-spacing:-0.39px;line-height:21px;padding-bottom:11px;max-height:100vh;}.wizveraAlertDialog .wizveraAlertMessage b{color:#0062B3;}.wizveraAlertDialog .wizveraAlertMessage b.warning{color:#E95454;}.wizveraAlertDialog .wizveraAlertButtonArea{grid-area:button;display:grid;grid-template-rows:auto;grid-template-columns:auto;column-gap:4px}.wizveraAlertDialog .wizveraAlertButtonArea.confirm{grid-template-columns:auto auto;}.wizveraAlertDialog .wizveraAlertButtonArea a.wizveraAlertButton{box-sizing:border-box;line-height:46px;border-radius:6px;vertical-align:middle;font-size:15px;letter-spacing:0;text-align:center;cursor:pointer;}.wizveraAlertDialog .wizveraAlertButtonArea a.wizveraAlertOk{background-color:#0062B3;color:#fff;}.wizveraAlertDialog .wizveraAlertButtonArea a.wizveraAlertCancel{border:1px solid #E4E4E4;background-color:#FFFFFF;color:#555;}</style>');
    $("body").append('<div id="wizveraAlertBackground">' + '<div class="wizveraAlertDialog" role="dialog" aria-labelledby="wizveraAlertTitle" aria-describedby="wizveraAlertMessage" tabindex="-1">' + '<div id="wizveraAlertTitle" class="wizveraAlertTitle">' + title + "</div>" + '<div id="wizveraAlertMessage" class="wizveraAlertMessage">' + message + "</div>" + '<div class="wizveraAlertButtonArea' + (options.type !== "confirm" ? "" : " confirm") + '">' + '<a class="wizveraAlertButton wizveraAlertOk">' + (options.okButtonMessage || "확인") + "</a>" + (options.type == "confirm" ? '<a class="wizveraAlertButton wizveraAlertCancel">' + (options.cancelButtonMessage || "취소") + "</a>" : "") + "</div>" + "</div>" + "</div>");
    var notCall = true;
    var removeDialog = function() {
        $("#wizveraAlertBackground").remove();
        notCall = false;
    };
    setTimeout(function() {
        $(".wizveraAlertDialog")[0].blur();
        $(".wizveraAlertDialog")[0].focus();
        $("#wizveraAlertBackground a.wizveraAlertOk")[0].addEventListener("click", function(evt) {
            if (notCall) {
                removeDialog();
                okCallback();
            }
        });
        if ($("#wizveraAlertBackground a.wizveraAlertCancel").length > 0) {
            $("#wizveraAlertBackground a.wizveraAlertCancel")[0].addEventListener("click", function(evt) {
                if (notCall) {
                    removeDialog();
                    cancelCallback();
                }
            });
        }
    });
}
function SITE_alertCors(message, callback, options) {
    options = options || {};
    options.type = "info";
    options.title = "알림";
    SITE_customInfoDialog(message, callback, options);
}
function SITE_confirmCors(message, okCallback, cancelCallback, options) {
    options = options || {};
    options.type = "confirm";
    options.title = "";
    SITE_customInfoDialog(message, okCallback, cancelCallback, options);
}
//window.DC_alertCors = SITE_alertCors;
//window.DC_confirmCors = SITE_confirmCors;
//DelfinoConfig.useAlertDialog = true;
if (DC_browserInfo.MSIE) DelfinoConfig.useAlertDialog = false;
