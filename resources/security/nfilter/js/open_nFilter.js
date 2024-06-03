// ver.3.2.2_yegaram_2018060401

var nFilterSiteCode = "";
var nFilterContextPath = "";
var nFilterJSPath = "/resources/security/nfilter/js/";
var nFilterCSSPath = "/resources/security/nfilter/css/";
var nFilterCSSMobilePath = "/resources/security/nfilter/css/";
var nFilterIsResourceAutoLoad = true;
var nFilterIsNoSecretKeypad = false;
var nFilterFileEncoding = "";
var nFilterDefaultLanguage = "en";
var nFilterLanguage = "en";
var nFilterImageRenderType = "m";
var nFilterRandomIdLength = 10;
var nFilterUserInputMin = 1;
var nFilterUserInputMax = 50;
var nFilterIsKeypadEncode = true;
var nFilterIsEncryptImmediate = true;
var nFilterReturnNullString = false;
var nFilterSecElement = "";
var nFilterServiceNameKeypadManager = "NFilterKeypadManager";
var nFilterServiceNameImageManager = "NFilterImageManager";
var nFilterServiceNameCSManager = "NFilterCSManager";
var nFilterServiceNameJSManager = "NFilterJSManager";
var nFilterRequestParamLanguage = "nfilter_lang";
var nFilterRequestParamKeypadType = "nfilter_type";
var nFilterRequestParamIsKeypadInit = "nfilter_is_init";
var nFilterRequestParamIsMobile = "nfilter_is_mobile";
var nFilterRequestParamEnableNoSecret = "nfilter_enable_nosecret";
var nFilterRequestParamImageRandom = "nfilter_imgsec";
var nFilterRequestParamSecretValue = "nfilter_encrypted";
var nFilterRequestParamScreenSize = "nFilter_screenSize";
var nFilterRequestParamScreenKeyPadSize = "nFilter_screenKeyPadSize";
var nFilterRequestParamScreenKeyPadPCSize = "nFilter_screenKeyPadPCSize";
var nFilterRequestParamSiteCode = "nFilter_SiteCode";
var nFilterRequestParamResponseImageManger = "ResponseImageManger";
var nFilterResponseErrCdPrefix = "ErrCode:";
var nFilterResponseErrMsgPrefix = "ErrMsg:";
var nFilterResponseErrCallBackType = "";
var nfilterEnumObj = new Object();
nfilterEnumObj.KEYPAD_TYPE_MASK = {
    "NONE": parseInt("0000", 2),
    "CHAR_L": parseInt("0001", 2),
    "CHAR_U": parseInt("0010", 2),
    "CHAR_S": parseInt("0100", 2),
    "NUM": parseInt("1000", 2)
};
var nFilterImageRenderTypeE = "e";
var nFilterKeypadIdCharL = "nfilter_char_content_l";
var nFilterKeypadIdCharU = "nfilter_char_content_u";
var nFilterKeypadIdCharS = "nfilter_char_content_s";
var nFilterKeypadIdNum = "nfilter_num_content";
var nFilterKeypadIdPreviewChar = "nfilter_preview_char";
var nFilterKeypadIdPreviewNum = "nfilter_preview_num";
var nFilterKeypadIdTargetSuffix = "_nfilter_sec";
var nFilterKeypadIdNoSecretSuffix = "_no_secret";
var nFilterKeypadIdNoSecretPrefix = "no_secret_";
var nFilterKeypadIdDummy = "dummy";
var nFilterKeypadType = 0;
var nFilterKeypadShowType = 0;
var nFilterIsSInitialized = false;
var nFilterLoadingStatusEnabled = false;
var nFilterMain;
var nFilterMainSub;
var nFilterInputTargetElement;
var nFilterInputDisplayElement;
var nFilterInputNextTargetElementIdList;
var nFilterInputNextDisplayElementIdList;
var nFilterPositionElementId = "";
var nFilterPositionCode = "";
var nFilterPositionCheckElement;
var nFilterTargetX = null;
var nFilterTargetY = null;
var nFilterPreScrollTop;
var nFilterIsTargetChecked = false;
var nFilterIsKeyShiftNow = false;
var nfilterKeypadState = 0x0000;
var nFilterIsInputShow = false;
var nFilterIsMobileRequest = false;
var nFilterEnableNoSecretKeypad = false;
var nFilterInputAutoFocus = false;
var tmpKeypadIdCharL = "";
var tmpKeypadIdCharU = "";
var tmpKeypadIdCharS = "";
var tmpKeypadIdNum = "";
var nFilterCSPublicKey = "";
var nFilterCSReturnURL = "";
var nFilterJSReturnURL = "";
var nFilterJSresult = "";
var nFilterXmlHttp;
var nFilterHttp;
var nFilterAlgName = "";
var nFilterSecurityKeyPair = "";
var nFilterSecurityPrikey = "";
var nFilterSecurityPubkey = "";
var nFilterHiddenFieldId = "";
var nFilterFinancialEcdhPublicKey = "";
if (!nFilterCallback) {
    var nFilterCallback = null;
}
var nFilterMsgKeypadLoading = new Array();
var nFilterMsgMinCheck = new Array();
var nFilterMsgMaxCheck = new Array();
var commaNum = 0;
var nfilterBtLocation = "";
var nFilterNumType = "";
var finiahedCallback = null;
var nFilterFinancialRsaPublicKey = "";
var nFilterFinancialRsaExponent = "";
var callbackMsg = null;
var fullDeviceHeight = null;
var nFilterSessionCheck = false;
var nFilterSessionCheckUrl = "/resources/security/nfilter/jsp/open_nFilter_session_manager.jsp";
var nfilterObjForKeypadElm = new Object();
var nFilterOSInfo = getNFilterOSInfo();
var nFilterTabletWidth = 0;
var nFilterTOPGap = 0;
var nFilterDeviceMode = "";


function getNFilterBrowerInfo() {
    var ua = navigator.userAgent;
    if (ua.indexOf("Trident/7.0") != -1) return "IE11";
    else if (ua.indexOf("Trident/6.0") != -1) return "IE10";
    else if (ua.indexOf("Trident/5.0") != -1) return "IE9";
    else if (ua.indexOf("Trident/4.0") != -1) return "IE8";
    else if (ua.indexOf("MSIE 8") != -1) return "IE8";
    else if (ua.indexOf("MSIE 7") != -1) return "IE7";
    else if (ua.indexOf("Trident") != -1) return "IE";
    else if (ua.indexOf("Firefox") != -1) return "Firefox";
    else if (ua.indexOf("Opera") != -1) return "Opera";
    else return "";
}


function getNFilterOSInfo() {
    var ua = navigator.userAgent;
    if (ua.indexOf("NT 6.1") != -1) return "Windows7";
    else if (ua.indexOf("iPhone") != -1) return "iPhone";
    else if (ua.indexOf("iPod") != -1) return "iPod";
    else if (ua.indexOf("iPad") != -1) return "iPad";
    else if (ua.indexOf("Android") != -1) return "Android";
    else if (ua.indexOf("NT 6.0") != -1) return "Windows Vista/Server 2008";
    else if (ua.indexOf("NT 5.2") != -1) return "Windows Server 2003";
    else if (ua.indexOf("NT 5.1") != -1) return "Windows XP";
    else if (ua.indexOf("NT 5.0") != -1) return "Windows 2000";
    else if (ua.indexOf("NT") != -1) return "Windows NT";
    else if (ua.indexOf("9x 4.90") != -1) return "Windows Me";
    else if (ua.indexOf("Win16") != -1) return "Windows 3.x";
    else if (ua.indexOf("Windows") != -1) return "Windows";
    else if (ua.indexOf("Macintosh") != -1) return "Macintosh";
    else if (ua.indexOf("BlackBerry") != -1) return "BlackBerry";
    else if (ua.indexOf("Linux") != -1) return "Linux";
    else return "";
}

if (nFilterOSInfo != "BlackBerry" && nFilterOSInfo != "iPhone" && nFilterOSInfo != 'iPod') {
    var timeout;
    var lastTap = 0;
    document.ontouchstart = function (e) {
        var currentTime = new Date().getTime();
        var tapLength = currentTime - lastTap;
        clearTimeout(timeout);
        if (tapLength < 500 && tapLength > 0) {
            event.preventDefault();
        } else {
            timeout = setTimeout(function () {
                clearTimeout(timeout);
            }, 500);
        }
        lastTap = currentTime;
    };
}

function nFilterTopHeight(height) {
    nFilterTOPGap = height;
}


function nFilterFindOffsetTop(obj) {
    var vTop = 0;
    if (obj.offsetParent) {
        do {
            vTop += obj.offsetTop;
            if (obj.scrollTop > 30) vTop -= obj.scrollTop;
        } while (obj = obj.offsetParent);
    }
    return vTop;
}


function nFilterFindOffsetLeft(obj) {
    var vLeft = 0;
    if (obj.offsetParent) {
        do {
            vLeft += obj.offsetLeft;
        } while (obj = obj.offsetParent);
    }
    return vLeft;
}


function nFilterPxSplit(str) {
    var spl = str.split('px');
    return Number(spl[0]);
}


function nFilterGetNowScroll() {
    var de = document.documentElement;
    var b = document.body;
    var now = {};

    
    now.X = document.getElementById ? (!de.scrollLeft ? b.scrollLeft : de.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
    now.Y = document.getElementById ? (!de.scrollTop ? b.scrollTop : de.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);
    return now;
}

var nFilter_LEFT_TOP = "LeftTop";
var nFilter_LEFT_MIDDLE = "LeftMiddle";
var nFilter_RIGHT_TOP = "RightTop";
var nFilter_RIGHT_MIDDLE = "RightMiddle";
var nFilter_RIGHT_BOTTOM = "RightBottom";
var nFilterAutoPositionHeight = 0;
var nFilterAutoPositionwidth = 0;
var nFilterMainPositionLeftOrigin = 0;
var nFilterMainPositionTopOrigin = 0;
var nFilterInputGap = 0;

function nFilterGap(inputgap) {
    nFilterInputGap = inputgap;
}


function nFilterSetLocation(obj) {
    var inputLeft = nFilterFindOffsetLeft(obj) + nFilterPxSplit(obj.style.paddingLeft);
    var inputTop = nFilterFindOffsetTop(obj) + nFilterTOPGap;
    var gap = obj.offsetHeight + nFilterInputGap;
    var nowScroll = nFilterGetNowScroll();

    
    nFilterPositionCode = obj.getAttribute("location");
    if (nFilterPositionCode == null) {
        nFilterPositionCode = "";
    }
    var location = nFilterPositionCode;

    
    if (nFilterPositionCode != "") {
        var nFilterWidth = nFilterPxSplit(nFilterMainSub.style.width);
        var nFilterHeight = nFilterPxSplit(nFilterMainSub.style.height);
        if (nFilterIsMobileRequest) {
            if (nFilterGetKeypadBinary(nFilterKeypadShowType) != nfilterEnumObj.KEYPAD_TYPE_MASK.NUM || obj.getAttribute("mode") == "qwerty") {
                nFilterWidth = 320;
                nFilterHeight = 244;
            } else {
                nFilterWidth = 320;
                if (nFilterScreenSize == 620) {
                    nFilterHeight = 234;
                } else if (nFilterScreenSize == 400) {
                    nFilterHeight = 166;
                } else if (nFilterScreenSize == 360) {
                    nFilterHeight = 154;
                } else {
                    nFilterHeight = 148;
                }
            }
        } else {
            if (nFilterGetKeypadBinary(nFilterKeypadShowType) != nfilterEnumObj.KEYPAD_TYPE_MASK.NUM || obj.getAttribute("mode") == "qwerty") {
                nFilterWidth = 495;
                nFilterHeight = 200;
            } else {
                nFilterWidth = 285;
                nFilterHeight = 132;
            }
        }
        var inputWidth = obj.offsetWidth + nFilterPxSplit(obj.style.paddingLeft);
        var inputHeight = nFilterPxSplit(obj.style.height);
        nFilterMain.style.top = nFiltergetAbsolutePos(obj).y + obj.offsetHeight + "px";
        nFilterMain.style.left = nFiltergetAbsolutePos(obj).x + "px";
        if (location == nFilter_LEFT_TOP) {
            nFilterMain.style.top = (nFiltergetAbsolutePos(obj).y) - nFilterHeight + "px";
        } else if (location == nFilter_RIGHT_MIDDLE) {
            var rightBottomLeft = inputLeft + inputWidth / 2 - nFilterWidth / 2 - gap;
            nFilterMain.style.left = rightBottomLeft + "px";
        } else if (location == nFilter_RIGHT_TOP) {
            nFilterMain.style.top = (nFiltergetAbsolutePos(obj).y) - nFilterHeight + "px";
            nFilterMain.style.left = (nFiltergetAbsolutePos(obj).x) - nFilterWidth + obj.clientWidth + "px";
        } else if (location == nFilter_LEFT_MIDDLE) {
            nFilterMain.style.left = inputLeft - inputWidth / 2 + gap + "px";
        } else if (location == nFilter_RIGHT_BOTTOM) {
            nFilterMain.style.left = (nFiltergetAbsolutePos(obj).x) - nFilterWidth + obj.clientWidth + "px";
        }
    } else {
        nFilterMain.style.top = nFiltergetAbsolutePos(obj).y + obj.offsetHeight + "px";
        nFilterMain.style.left = nFiltergetAbsolutePos(obj).x + "px";
    }

    
    if (nFilterIsMobileRequest) {
        var nFilterInnerWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
        nFilterMain.style.left = (nFilterInnerWidth - nFilterPxSplit(nFilterMain.style.width)) / 2 + "px";
    }

    
    if (nFilterIsPCMiddle) {
        var nFilterInnerWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
        if (obj.getAttribute("mode") == "number") {
            nFilterMain.style.left = (nFilterInnerWidth - 300) / 2 + "px";
        } else {
            if (nFilterScreenKeyPadPCSize == 362) {
                nFilterMain.style.left = (nFilterInnerWidth - 408) / 2 + "px";
            } else {
                nFilterMain.style.left = (nFilterInnerWidth - 505) / 2 + "px";
            }
        }
    }

    
    if (nfilterscrollto) {
        parent.scrollTo(0, nFilterPxSplit(nFilterMain.style.top) - 25);
    }

    
    if (nfilterBtLocation == true && nFilterNumType == 2) {
        setNFilterKeypadBottom(obj);
    }
}



var nFilterIsPCMiddle = false;

function nFilterIsPCMiddleLocation(value) {
    nFilterIsPCMiddle = value;
}


function nFiltergetAbsolutePos(obj) {
    var position = new Object;
    position.x = 0;
    position.y = 0;
    if (obj) {
        position.x = obj.offsetLeft + obj.clientLeft;
        position.y = obj.offsetTop + obj.clientTop;
        if (obj.offsetParent) {
            var parentpos = nFiltergetAbsolutePos(obj.offsetParent);
            position.x += parentpos.x;
            position.y += parentpos.y;
        }
    }
    return position;
}


var nfilterscrollto = false;

function nFilterScrollto(scrollto) {
    nfilterscrollto = scrollto;
}


function nFilterSetPosition(elementId) {
    var nFilterPositionTargetObj = document.getElementById(elementId);
    nFilterPositionTargetObj.setAttribute("nfilter", "on");
    nFilterInputDisplayElement.setAttribute("disabled", "disabled");
    var height = Math.max(document.body["scrollHeight"], document.documentElement["scrollHeight"], document.body["offsetHeight"], document.documentElement["offsetHeight"]);

    
    if (nFilterIsElementExist("nfilter_bg")) {
        document.getElementById("nfilter_bg").style.display = 'block';
        document.getElementById("nfilter_bg").style.height = height + "px";
    }
    nFilterMain.style.display = 'block';

    
    if (nFilterIsNoSecretKeypad == true) {
        tmpKeypadIdCharL = nFilterKeypadIdCharL + nFilterKeypadIdNoSecretSuffix;
        tmpKeypadIdCharU = nFilterKeypadIdCharU + nFilterKeypadIdNoSecretSuffix;
        tmpKeypadIdCharS = nFilterKeypadIdCharS + nFilterKeypadIdNoSecretSuffix;
        tmpKeypadIdNum = nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix;
    } else {
        tmpKeypadIdCharL = nFilterKeypadIdCharL;
        tmpKeypadIdCharU = nFilterKeypadIdCharU;
        tmpKeypadIdCharS = nFilterKeypadIdCharS;
        tmpKeypadIdNum = nFilterKeypadIdNum;
    }

    
    if (nFilterKeypadShowType == nfilterEnumObj.KEYPAD_TYPE_MASK.NUM) {
        document.getElementById(tmpKeypadIdNum).style.display = "block";
        nFilterMainSub = document.getElementById("nfilter_num");
    } else {
        if (nFilterKeypadShowType == nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L) {
            document.getElementById(tmpKeypadIdCharL).style.display = "block";
        } else if (nFilterKeypadShowType == nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U) {
            document.getElementById(tmpKeypadIdCharU).style.display = "block";
        } else if (nFilterKeypadShowType == nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S) {
            document.getElementById(tmpKeypadIdCharS).style.display = "block";
        } else if (nFilterKeypadShowType == "0011") {
            document.getElementById(tmpKeypadIdCharL).style.display = "block";
            document.getElementById(tmpKeypadIdCharU).style.display = "none";
        } else if (nFilterKeypadShowType == "0111") {
            document.getElementById(tmpKeypadIdCharL).style.display = "block";
            document.getElementById(tmpKeypadIdCharU).style.display = "none";
            document.getElementById(tmpKeypadIdCharS).style.display = "none";
        }
        nFilterMainSub = document.getElementById("nfilter_char");
    }

    
    nFilterSetLocation(nFilterPositionTargetObj);

    return true;
}


var OnorientationchangeStyle = false;

function onorientationchangeStyle() {
    if (OnorientationchangeStyle == true) {

        setTimeout(function () {
            nFilterSetPosition(nFilterInputDisplayElement.id);
        }, 600);
    }
}


function nFilterClearInput() {
    if (nFilterInputTargetElement != undefined && nFilterInputTargetElement != null) {
        nFilterInputTargetElement.value = "";
        nFilterSecElement = "";
    }
    if (nFilterInputDisplayElement != undefined && nFilterInputDisplayElement != null) {
        nFilterInputDisplayElement.value = "";
    }
    if (getNFilterBrowerInfo() == "IE7" || getNFilterBrowerInfo() == "IE8" || getNFilterBrowerInfo() == "IE9" || getNFilterBrowerInfo() == "IE10" || getNFilterBrowerInfo() == "IE11") {
        if (nFilterIsElementExist("nfilter_tmp_editview")) {
            document.getElementById("nfilter_tmp_editview").innerHTML = "&nbsp;";
        }
        if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
            document.getElementById("nfilter_tmp_editview_num").innerHTML = "&nbsp;";
        }
    } else {
        if (nFilterIsElementExist("nfilter_tmp_editview")) {
            document.getElementById("nfilter_tmp_editview").innerHTML = "";
        }
        if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
            document.getElementById("nfilter_tmp_editview_num").innerHTML = "";
        }
    }
}

var nFilterMaxCall = false;


function nFilterMinMaxCheck(inputKeyId) {
    var minMaxCheckElement = document.getElementById(inputKeyId);
    var maxlenth = 0;
    var minlength = 0;
    try {
        maxlenth = window[inputKeyId].getMaxLength();
        minlength = window[inputKeyId].getMinLength();
    } catch (e) {
        maxlenth = minMaxCheckElement.maxlength;
        minlength = minMaxCheckElement.minlength;
        if (maxlenth == null && maxlenth == undefined) {
            maxlenth = minMaxCheckElement.getAttribute('maxlength');
        }
        if (minlength == null && minlength == undefined) {
            minlength = minMaxCheckElement.getAttribute('minlength');
        }
    }
    if (maxlenth == null || maxlenth == undefined || maxlenth == 0) {
        maxlenth = nFilterUserInputMax;
    }
    if (minlength == null || minlength == undefined || minlength == 0) {
        minlength = nFilterUserInputMin;
    }
    var checkElement = minMaxCheckElement.value;
    try {
        if (isMoneyFormatting()) {
            checkElement = checkElement.replace(/,/g, "");
        }
    } catch (e) {
    }
    if (Number(maxlenth) < Number(checkElement.length)) {
        nFilterMaxCall = true;

        
        if (typeof nFilterExtMessageHandler == "function") {
            nFilterExtMessageHandler(nFilterMsgMaxCheck[nFilterLanguage].replace("#1", maxlenth));
        }
        return false;
    }
    if (Number(minlength) > Number(checkElement.length)) {
        if (typeof nFilterExtMessageHandler == "function") {

            
            window.setTimeout(function () {
                nFilterExtMessageHandler(nFilterMsgMinCheck[nFilterLanguage].replace("#1", minlength));
            }, 100);
        }
        return false;
    }
    return true;
}


function nFilterGetMaxLength(inputKeyId) {
    var minMaxCheckElement = document.getElementById(inputKeyId);
    var maxlenth = 0;
    try {
        maxlenth = window[inputKeyId].getMaxLength();
    } catch (e) {
        maxlenth = minMaxCheckElement.maxlength;
        if (maxlenth == null || maxlenth == undefined) {
            maxlenth = minMaxCheckElement.getAttribute('maxlength');
        }
    }
    if (maxlenth == null || maxlenth == undefined || maxlenth == 0) {
        maxlenth = nFilterUserInputMax;
    }
    return maxlenth;
}


function nFilterCreateElement(createElementId, siblingElementId) {
    if (!nFilterIsElementExist(createElementId)) {
        var inputTargetElement = document.createElement("input");
        inputTargetElement.setAttribute("type", "hidden");
        
        var decArea = document.getElementById(siblingElementId).getAttribute("decarea");
        if (decArea != undefined && NFILTERSET != null) {
            inputTargetElement.setAttribute("id", siblingElementId + "_nfilter_sec_" + decArea);
            inputTargetElement.setAttribute("name", siblingElementId + "_nfilter_sec_" + decArea);
        } else {
            inputTargetElement.setAttribute("id", siblingElementId + "_nfilter_sec");
            inputTargetElement.setAttribute("name", siblingElementId + "_nfilter_sec");
        }
        var displayElement = document.getElementById(siblingElementId);
        try {
            displayElement.parentNode.insertBefore(inputTargetElement, displayElement.nextSibling);
            return true;
        } catch (e) {
            return false;
        }
    }
}


function nFilterCheckBoxClose(id) {
    document.getElementById(id).setAttribute("nfilter", "off");
    document.getElementById(id).value = '';
    document.getElementById(id).onfocus = null;
    document.getElementById(id).onclick = null;
    document.getElementById(id).readOnly = false;
    document.getElementById(id).disabled = false;
}


function nFilterClose() {
    nFilterEscClick = false;
    OnorientationchangeStyle = false;
    if (nFilterInputDisplayElement == undefined || nFilterInputDisplayElement == null) return false;
    if (nFilterInputDisplayElement != undefined) nFilterInputDisplayElement.removeAttribute("disabled");
    if (nFilterIsElementExist("nfilter_char")) {
        document.getElementById("nfilter_char").style.display = "none";
    }
    if (nFilterIsElementExist("nfilter_num")) {
        document.getElementById("nfilter_num").style.display = "none";
    }
    nFilterSetDefaultKeypadType();
    document.getElementById("nfilter_document").style.display = "none";
    try {
        if (nFilterInputDisplayElement.getAttribute("directkey") == "on") {
            nFilterInputDisplayElement.focus();
        }
    } catch (e) {
    }
    if (typeof nFilterCallback == "function") {
        nFilterCallback("close");
    }
    if (nFilterInputDisplayElement != undefined && nFilterInputDisplayElement.value.length > 0) {
        nFilterInputDisplayElement.value = "";
        if (getNFilterBrowerInfo() == "IE7" || getNFilterBrowerInfo() == "IE8" || getNFilterBrowerInfo() == "IE9" || getNFilterBrowerInfo() == "IE10" || getNFilterBrowerInfo() == "IE11") {
            if (nFilterIsElementExist("nfilter_tmp_editview")) {
                document.getElementById("nfilter_tmp_editview").innerHTML = "&nbsp;";
            }
            if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
                document.getElementById("nfilter_tmp_editview_num").innerHTML = "&nbsp;";
            }
        } else {
            if (nFilterIsElementExist("nfilter_tmp_editview")) {
                document.getElementById("nfilter_tmp_editview").innerHTML = "";
            }
            if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
                document.getElementById("nfilter_tmp_editview_num").innerHTML = "";
            }
        }
    } else {
        return false;
    }
    if (nFilterInputTargetElement != undefined && nFilterInputTargetElement.value.length > 0) {
        nFilterInputTargetElement.value = "";
        nFilterSecElement = "";
    } else {
        return false;
    }
}


function nFilterClose2(inputKeyId) {
    nFilterEscClick = false;
    OnorientationchangeStyle = false;
    if (nFilterIsElementExist("nfilter_change_eng")) {
        document.getElementById("nfilter_change_eng").style.display = "none";
    }
    if (nFilterIsElementExist("nfilter_change_special")) {
        document.getElementById("nfilter_change_special").style.display = "none";
    }
    if (inputKeyId == "nfilter_close_num" || inputKeyId == "nfilter_enter_num" || inputKeyId == "nfilter_enter_num_secret" ||
        inputKeyId == "nfilter_close_num_mobile" || inputKeyId == "nfilter_enter_num_mobile" || inputKeyId == "nfilter_enter_num_mobile_secret") {
        if (nFilterIsElementExist(tmpKeypadIdNum)) {
            document.getElementById(tmpKeypadIdNum).style.display = "none";
            document.getElementById("nfilter_num_header").style.display = "none";
            document.getElementById("nfilter_num").style.display = "none";
        }
    } else {
        if (nFilterIsElementExist(tmpKeypadIdCharL)) {
            document.getElementById(tmpKeypadIdCharL).style.display = "none";
        }
        if (nFilterIsElementExist(tmpKeypadIdCharU)) {
            document.getElementById(tmpKeypadIdCharU).style.display = "none";
        }
        if (nFilterIsElementExist(tmpKeypadIdCharS)) {
            document.getElementById(tmpKeypadIdCharS).style.display = "none";
        }
    }
    if (nFilterTouchMaskElt) {
        nFilterTouchMaskElt.style.display = "none";
    }
    document.getElementById("nfilter_document").style.display = "none";
    try {
        if (nFilterInputDisplayElement.getAttribute("directkey") == "on") {
            nFilterInputDisplayElement.focus();
        }
    } catch (e) {
    }
    nFilterInputDisplayElement.removeAttribute("disabled");
}


function nFilterIsElementExist(elementName, doc) {
    if (doc == undefined) doc = document;
    if (!doc.getElementById(elementName)) {
        return false;
    } else {
        return true;
    }
}


function nFilterSetDefaultKeypadType() {
    if (nFilterIsMaskMatch(nFilterKeypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L)) {
        nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L;
    } else if (nFilterIsMaskMatch(nFilterKeypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U)) {
        nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U;
    } else if (nFilterIsMaskMatch(nFilterKeypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S)) {
        nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S;
    } else if (nFilterIsMaskMatch(nFilterKeypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM)) {
        nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.NUM;
    }
}


function nFilterGetDefaultKeypadId(keypadType) {
    var keypadId = "";
    if (nFilterIsMaskMatch(keypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L)) {
        keypadId = nFilterKeypadIdCharL;
    } else if (nFilterIsMaskMatch(keypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U)) {
        keypadId = nFilterKeypadIdCharU;
    } else if (nFilterIsMaskMatch(keypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S)) {
        keypadId = nFilterKeypadIdCharS;
    } else if (nFilterIsMaskMatch(keypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM)) {
        keypadId = nFilterKeypadIdNum;
    }
    return keypadId;
}


function nFilterAsyncRequest(url, param, cfunc) {
    if (window.XMLHttpRequest) {
        nFilterXmlHttp = new XMLHttpRequest();
    } else {
        nFilterXmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    nFilterXmlHttp.onreadystatechange = cfunc;
    nFilterXmlHttp.open("POST", url, true);
    nFilterXmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    nFilterXmlHttp.send(param);
}


function nFilterSessionRequest(url, cfunc) {
    if (window.XMLHttpRequest) {
        nFilterHttp = new XMLHttpRequest();
    } else {
        nFilterHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    nFilterHttp.onreadystatechange = cfunc;
    nFilterHttp.open("POST", url, true);
    nFilterHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    nFilterHttp.send();
}


function nFilterGetKeypadBinary(keypadType) {
    var keypadBinary = keypadType.toString(2);
    keypadBinary = "0000".substr(0, (4 - keypadBinary.length)) + keypadBinary;
    return keypadBinary;
}


function nFilterIsMaskMatch(keypadTypeInt, maskString) {
    var maskInt = 0;
    if (typeof maskInt != "number")
        maskInt = parseInt(maskString.toString, 2);
    else
        maskInt = maskString;
    var isMatched = false;
    var masked = keypadTypeInt & maskInt;
    if (masked > 0)
        isMatched = true;
    return isMatched;
}


function nFilterParseErrorCode(errorData) {
    var errCode = "";
    if (errorData.indexOf(nFilterResponseErrMsgPrefix) > -1) {
        errCode = errorData.substr(nFilterResponseErrCdPrefix.length, 3);
    }
    return errCode;
}


function nFilterParseErrorMessage(errorData) {
    var errMssage = "";
    if (errorData.indexOf(nFilterResponseErrMsgPrefix) > -1) {
        errMssage = errorData.substr(errorData.indexOf(nFilterResponseErrMsgPrefix) + nFilterResponseErrMsgPrefix.length);
    }
    return errMssage;
}

function nFilterKeypadInitMobile(requestKeypadType, isKeypadInit, isDisplay, targetElementId, displayElementId, responseElementId) {
    nFilterIsMobileRequest = true;
    
    
    
    

    var strActiveBkColor = "";

    
    strActiveBkColor += "nfilter_enter_char_mobile|#e67e22|#4a4d54";
    strActiveBkColor += "&";
    strActiveBkColor += "nfilter_change_mobile|#e67e22|#4a4d54";
    strActiveBkColor += "&";
    strActiveBkColor += "nfilter_clear_mobile|#e67e22|#4a4d54";
    strActiveBkColor += "&";
    strActiveBkColor += "nfilter_close_char_mobile|#e67e22|#4a4d54";
    
    strActiveBkColor += "&";
    strActiveBkColor += "nfilter_close_num_mobile|#e67e22|#4a4d54";

    
    

    nFilterKeypadInit(requestKeypadType, isKeypadInit, isDisplay, targetElementId, displayElementId, responseElementId);
}


function createNFilterDocument() {
    if (!document.getElementById("nfilter_document")) {
        var nFilterDocumentElement = document.createElement("div");
        nFilterDocumentElement.setAttribute("id", "nfilter_document");
        nFilterDocumentElement.setAttribute("style", "display: none");
        nFilterDocumentElement.setAttribute("tabindex", "2");
        nFilterDocumentElement.setAttribute("oncontextmenu", "return false");
        nFilterDocumentElement.setAttribute("ondragstart", "return false");
        nFilterDocumentElement.setAttribute("onselectstart", "return false");
        document.body.appendChild(nFilterDocumentElement);
        return nFilterDocumentElement;
    } else {
        return document.getElementById("nfilter_document");
    }
}

function nFilterInitBefore(requestKeypadType, targetElementId, displayElementId) {
    nFilterIsNoSecretKeypad = false;
    tmpKeypadIdCharL = nFilterKeypadIdCharL;
    tmpKeypadIdCharU = nFilterKeypadIdCharU;
    tmpKeypadIdCharS = nFilterKeypadIdCharS;
    tmpKeypadIdNum = nFilterKeypadIdNum;

    createNFilterDocument();

    
    if (targetElementId == undefined || targetElementId == "") {
        targetElementId = displayElementId + nFilterKeypadIdTargetSuffix;
    }

    
    if (!nFilterIsElementExist(targetElementId)) {
        if (!nFilterCreateElement(targetElementId, displayElementId)) return;
    }
    window.defaultStatus = "";
    nFilterInputTargetElement = document.getElementById(targetElementId);
    nFilterInputDisplayElement = document.getElementById(displayElementId);
    nFilterInputTargetElement.value = "";
    nFilterInputDisplayElement.value = "";
    if (getNFilterBrowerInfo() == "IE7" || getNFilterBrowerInfo() == "IE8" || getNFilterBrowerInfo() == "IE9" || getNFilterBrowerInfo() == "IE10" || getNFilterBrowerInfo() == "IE11") {
        if (nFilterIsElementExist("nfilter_tmp_editview")) {
            document.getElementById("nfilter_tmp_editview").innerHTML = "&nbsp;";
        }
        if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
            document.getElementById("nfilter_tmp_editview_num").innerHTML = "&nbsp;";
        }
    } else {
        if (nFilterIsElementExist("nfilter_tmp_editview")) {
            document.getElementById("nfilter_tmp_editview").innerHTML = "";
        }
        if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
            document.getElementById("nfilter_tmp_editview_num").innerHTML = "";
        }
    }
    nFilterIsSInitialized = false;
    nFilterIsInputShow = false;
    nFilterInputDisplayElement.setAttribute("location", "");
    nFilterKeypadType = requestKeypadType;
}

var nFilterScreenSize = 320;
var nFilterScreenKeyPadSize = nFilterScreenSize - 10;
var nFilterScreenKeyPadPCSize = 452;
var nFilterScreenKeyPadPCSizeC = false;


function setNFilterPCScreenSize(value) {
    nFilterScreenKeyPadPCSizeC = value;
}


function setNFilterScreenSize(screenSizeWidth, screenSizeHeight) {
    
    if (navigator.userAgent.indexOf("Trident") != -1) {
        screenSizeWidth = screenSizeWidth + 1;
    }
    var screenSize = 320;
    if (screenSizeWidth >= screenSizeHeight) {
        screenSize = screenSizeHeight;
    } else {
        screenSize = screenSizeWidth;
    }
    if (screenSize >= 620) {
        nFilterScreenSize = 620;
    } else if (screenSize >= 400) {
        nFilterScreenSize = 400;
    } else if (screenSize >= 360) {
        nFilterScreenSize = 360;
    } else {
        nFilterScreenSize = "null";
    }
    if (nFilterScreenSize == "null") {
        nFilterScreenSize = 320;
        nFilterScreenKeyPadSize = 310;
    } else {
        nFilterScreenKeyPadSize = (nFilterScreenSize - 10);
    }
}


function nFilterKeypadInit(requestKeypadType, isKeypadInit, isDisplay, targetElementId, displayElementId, responseElementId) {
    
    nFilterSecurityKeyPair = new GenECKeyPair("secp256r1");
    nFilterSecurityPrikey = nFilterSecurityKeyPair.getPriKey();
    nFilterSecurityPubkey = nFilterSecurityKeyPair.getPubKey();

    nFilterInitBefore(requestKeypadType, targetElementId, displayElementId);

    if (document.getElementById("nfilter_main")) {
        return;
    }

    var requestParam = "";
    nFilterLanguage = (nFilterLanguage != null && nFilterLanguage != undefined && nFilterLanguage != "") ? nFilterLanguage : nFilterDefaultLanguage;
    if (nFilterIsMobileRequest) {
        requestParam = nFilterRequestParamLanguage + "=" + nFilterLanguage +
            "&" + nFilterRequestParamKeypadType + "=" + nFilterKeypadType +
            "&" + nFilterRequestParamIsKeypadInit + "=" + isKeypadInit +
            "&" + nFilterRequestParamIsMobile + "=" + nFilterIsMobileRequest;
        requestParam += "&" + nFilterRequestParamScreenSize + "=" + nFilterScreenSize +
            "&" + nFilterRequestParamScreenKeyPadSize + "=" + nFilterScreenKeyPadSize;
    } else {
        if (nFilterScreenKeyPadPCSizeC) {
            nFilterScreenKeyPadPCSize = 362;
        } else {
            nFilterScreenKeyPadPCSize = 452;
        }
        requestParam = nFilterRequestParamLanguage + "=" + nFilterLanguage +
            "&" + nFilterRequestParamKeypadType + "=" + nFilterKeypadType +
            "&" + nFilterRequestParamIsKeypadInit + "=" + isKeypadInit +
            "&" + nFilterRequestParamScreenKeyPadPCSize + "=" + nFilterScreenKeyPadPCSize;
    }
    if (nFilterRequestParamResponseImageManger != "null") {
        requestParam += "&" + nFilterRequestParamResponseImageManger + "=" + nFilterServiceNameImageManager;
    }
    if (nFilterEnableNoSecretKeypad) {
        requestParam += "&" + nFilterRequestParamEnableNoSecret + "=" + nFilterEnableNoSecretKeypad;
    }

    
    
    if (nFilterSessionCheck) {
        nFilterSessionRequest(nFilterContextPath + nFilterSessionCheckUrl, function () {
            if (nFilterHttp.readyState === 4 && nFilterHttp.status === 200) {
                nFilterAsyncRequest(nFilterContextPath + "/" + nFilterServiceNameKeypadManager, requestParam, function () {
                    if (nFilterXmlHttp.readyState == 1 || nFilterXmlHttp.readySate == 2 || nFilterXmlHttp.readyState == 3) {
                        if (nFilterLoadingStatusEnabled) {
                            if (!document.getElementById("nfilter_loading")) {
                                document.getElementById("nfilter_document").innerHTML += "<div id='nfilter_loading' " +
                                    "style='position:absolute;z-index:1000;" +
                                    "padding: 7.5px 15px;font-size: 15px;" +
                                    "top:50%;left:50%;margin: -50px 0 0 -70px;background: #ffffff;" +
                                    "border: 1px solid #8f8f8f;" +
                                    "background: #949494;" +
                                    "background: -webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#ffffff));" +
                                    "background: -moz-linear-gradient(top, #ffffff, #ffffff);" +
                                    "-webkit-border-radius: 8px;-moz-border-radius: 8px;border-radius: 8px;" +
                                    "-webkit-box-shadow: rgba(0,0,0,1) 0 1px 0;-moz-box-shadow: rgba(0,0,0,1) 0 1px 0;box-shadow: rgba(0,0,0,1) 0 1px 0;'>" + nFilterMsgKeypadLoading[nFilterLanguage] + "</div>";
                            } else {
                                document.getElementById("nfilter_loading").style.display = "block";
                            }
                        }
                    } else if (nFilterXmlHttp.readyState == 4 && nFilterXmlHttp.status == 200) {
                        if (nFilterLoadingStatusEnabled) {
                            document.getElementById("nfilter_loading").style.display = "none";
                            nFilterLoadingStatusEnabled = false;
                        }
                        if (nFilterResponseErrCdPrefix == nFilterXmlHttp.responseText.substr(0, 8)) {
                            if (responseElementId != null && responseElementId != "") {
                                if (typeof nFilterExtExceptionCallBack == "function") {
                                    nFilterExtExceptionCallBack(nFilterXmlHttp.responseText, responseElementId);
                                }
                            } else {
                                if (typeof nFilterExtExceptionCallBack == "function") {
                                    nFilterExtExceptionCallBack(nFilterXmlHttp.responseText, "");
                                }
                            }
                        } else {
                            var d = new Date();
                            var responseData = "";
                            responseData = nFilterXmlHttp.responseText.replace("nfilter_imgsec=num_no_secret", "nfilter_imgsec=num_no_secret&postfix=" + d.getMilliseconds());
                            responseData = responseData.replace("nfilter_imgsec=charl_no_secret", "nfilter_imgsec=charl_no_secret&postfix=" + d.getMilliseconds());
                            responseData = responseData.replace("nfilter_imgsec=charu_no_secret", "nfilter_imgsec=charu_no_secret&postfix=" + d.getMilliseconds());
                            responseData = responseData.replace("nfilter_imgsec=chars_no_secret", "nfilter_imgsec=chars_no_secret&postfix=" + d.getMilliseconds());

                            
                            if (responseData.replace(/(\s*)/g, "") == "null") {
                                if (typeof nFilterMessageCallback == "function") {
                                    window.setTimeout(function () {
                                        nFilterMessageCallback("not-Equal Session");
                                    }, 100);
                                }
                            } else {
                                if (typeof nFilterMessageCallback == "function") {
                                    window.setTimeout(function () {
                                        nFilterMessageCallback("Equal Session");
                                    }, 100);
                                }
                                document.getElementById("nfilter_document").innerHTML = responseData;
                                nFilterInitAfter(isDisplay, targetElementId, displayElementId);

                                
                                settingKeypadId();
                                

                                
                                isFinishInit = true;
                                OnInitFinished();
                                isFinishInit = false;
                            }
                        }
                    }
                });
            }
        });
    } else {
        nFilterAsyncRequest(nFilterContextPath + "/" + nFilterServiceNameKeypadManager, requestParam, function () {
            if (nFilterXmlHttp.readyState == 1 || nFilterXmlHttp.readySate == 2 || nFilterXmlHttp.readyState == 3) {
                if (nFilterLoadingStatusEnabled) {
                    if (!document.getElementById("nfilter_loading")) {
                        document.getElementById("nfilter_document").innerHTML += "<div id='nfilter_loading' " +
                            "style='position:absolute;z-index:1000;" +
                            "padding: 7.5px 15px;font-size: 15px;" +
                            "top:50%;left:50%;margin: -50px 0 0 -70px;background: #ffffff;" +
                            "border: 1px solid #8f8f8f;" +
                            "background: #949494;" +
                            "background: -webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#ffffff));" +
                            "background: -moz-linear-gradient(top, #ffffff, #ffffff);" +
                            "-webkit-border-radius: 8px;-moz-border-radius: 8px;border-radius: 8px;" +
                            "-webkit-box-shadow: rgba(0,0,0,1) 0 1px 0;-moz-box-shadow: rgba(0,0,0,1) 0 1px 0;box-shadow: rgba(0,0,0,1) 0 1px 0;'>" + nFilterMsgKeypadLoading[nFilterLanguage] + "</div>";
                    } else {
                        document.getElementById("nfilter_loading").style.display = "block";
                    }
                }
            } else if (nFilterXmlHttp.readyState == 4 && nFilterXmlHttp.status == 200) {
                if (nFilterLoadingStatusEnabled) {
                    document.getElementById("nfilter_loading").style.display = "none";
                    nFilterLoadingStatusEnabled = false;
                }
                if (nFilterResponseErrCdPrefix == nFilterXmlHttp.responseText.substr(0, 8)) {
                    if (responseElementId != null && responseElementId != "") {
                        if (typeof nFilterExtExceptionCallBack == "function") {
                            nFilterExtExceptionCallBack(nFilterXmlHttp.responseText, responseElementId);
                        }
                    } else {
                        if (typeof nFilterExtExceptionCallBack == "function") {
                            nFilterExtExceptionCallBack(nFilterXmlHttp.responseText, "");
                        }
                    }
                } else {
                    var d = new Date();
                    var responseData = "";
                    responseData = nFilterXmlHttp.responseText.replace("nfilter_imgsec=num_no_secret", "nfilter_imgsec=num_no_secret&postfix=" + d.getMilliseconds());
                    responseData = responseData.replace("nfilter_imgsec=charl_no_secret", "nfilter_imgsec=charl_no_secret&postfix=" + d.getMilliseconds());
                    responseData = responseData.replace("nfilter_imgsec=charu_no_secret", "nfilter_imgsec=charu_no_secret&postfix=" + d.getMilliseconds());
                    responseData = responseData.replace("nfilter_imgsec=chars_no_secret", "nfilter_imgsec=chars_no_secret&postfix=" + d.getMilliseconds());
                    document.getElementById("nfilter_document").innerHTML = responseData;
                    nFilterInitAfter(isDisplay, targetElementId, displayElementId);

                    
                    settingKeypadId();
                    

                    
                    isFinishInit = true;
                    OnInitFinished();
                    isFinishInit = false;
                }
            }
        });
    }
}


function settingKeypadId() {
    if (nFilterEnableNoSecretKeypad == true) {
        if (nFilterExtKeypadTypeInitBinary == "1111") {
            nfilterObjForKeypadElm.mobile = {
                "CharL": {
                    "idForImgCharL": document.getElementById("forMask_imgId_charl"),
                    "idForMapCharL": document.getElementById("forMask_mapId_charl"),
                },
                "CharU": {
                    "idForImgCharU": document.getElementById("forMask_imgId_charu"),
                    "idForMapCharU": document.getElementById("forMask_mapId_charu"),
                },
                "CharS": {
                    "idForImgCharS": document.getElementById("forMask_imgId_chars"),
                    "idForMapCharS": document.getElementById("forMask_mapId_chars"),
                },
                "Num": {
                    "idForImgNum": document.getElementById("forMask_imgId_num"),
                    "idForMapNum": document.getElementById("forMask_mapId_num")
                },
                "NoSecretCharL": {
                    "idForImgNoSecretCharL": document.getElementById("forMask_imgId_secret_charl"),
                    "idForMapNoSecretCharL": document.getElementById("forMask_mapId_secret_charl")
                },
                "NoSecretCharU": {
                    "idForImgNoSecretCharU": document.getElementById("forMask_imgId_secret_charu"),
                    "idForMapNoSecretCharU": document.getElementById("forMask_mapId_secret_charu")
                },
                "NoSecretCharS": {
                    "idForImgNoSecretCharS": document.getElementById("forMask_imgId_secret_chars"),
                    "idForMapNoSecretCharS": document.getElementById("forMask_mapId_secret_chars")
                },
                "NoSecretNum": {
                    "idForImgNoSecretNum": document.getElementById("forMask_imgId_secret_num"),
                    "idForMapNoSecretNum": document.getElementById("forMask_mapId_secret_num")
                }
            };
        } else if (nFilterExtKeypadTypeInitBinary == "0111") {
            nfilterObjForKeypadElm.mobile = {
                "CharL": {
                    "idForImgCharL": document.getElementById("forMask_imgId_charl"),
                    "idForMapCharL": document.getElementById("forMask_mapId_charl"),
                },
                "CharU": {
                    "idForImgCharU": document.getElementById("forMask_imgId_charu"),
                    "idForMapCharU": document.getElementById("forMask_mapId_charu"),
                },
                "CharS": {
                    "idForImgCharS": document.getElementById("forMask_imgId_chars"),
                    "idForMapCharS": document.getElementById("forMask_mapId_chars"),
                },
                "NoSecretCharL": {
                    "idForImgNoSecretCharL": document.getElementById("forMask_imgId_secret_charl"),
                    "idForMapNoSecretCharL": document.getElementById("forMask_mapId_secret_charl")
                },
                "NoSecretCharU": {
                    "idForImgNoSecretCharU": document.getElementById("forMask_imgId_secret_charu"),
                    "idForMapNoSecretCharU": document.getElementById("forMask_mapId_secret_charu")
                },
                "NoSecretCharS": {
                    "idForImgNoSecretCharS": document.getElementById("forMask_imgId_secret_chars"),
                    "idForMapNoSecretCharS": document.getElementById("forMask_mapId_secret_chars")
                }
            };
        } else if (nFilterExtKeypadTypeInitBinary == "1000") {
            nfilterObjForKeypadElm.mobile = {
                "Num": {
                    "idForImgNum": document.getElementById("forMask_imgId_num"),
                    "idForMapNum": document.getElementById("forMask_mapId_num")
                },
                "NoSecretNum": {
                    "idForImgNoSecretNum": document.getElementById("forMask_imgId_secret_num"),
                    "idForMapNoSecretNum": document.getElementById("forMask_mapId_secret_num")
                }
            }
        }
    } else {
        if (nFilterExtKeypadTypeInitBinary == "1111") {
            nfilterObjForKeypadElm.mobile = {
                "CharL": {
                    "idForImgCharL": document.getElementById("forMask_imgId_charl"),
                    "idForMapCharL": document.getElementById("forMask_mapId_charl"),
                },
                "CharU": {
                    "idForImgCharU": document.getElementById("forMask_imgId_charu"),
                    "idForMapCharU": document.getElementById("forMask_mapId_charu"),
                },
                "CharS": {
                    "idForImgCharS": document.getElementById("forMask_imgId_chars"),
                    "idForMapCharS": document.getElementById("forMask_mapId_chars"),
                },
                "Num": {
                    "idForImgNum": document.getElementById("forMask_imgId_num"),
                    "idForMapNum": document.getElementById("forMask_mapId_num")
                }
            };
        } else if (nFilterExtKeypadTypeInitBinary == "0111") {
            nfilterObjForKeypadElm.mobile = {
                "CharL": {
                    "idForImgCharL": document.getElementById("forMask_imgId_charl"),
                    "idForMapCharL": document.getElementById("forMask_mapId_charl"),
                },
                "CharU": {
                    "idForImgCharU": document.getElementById("forMask_imgId_charu"),
                    "idForMapCharU": document.getElementById("forMask_mapId_charu"),
                },
                "CharS": {
                    "idForImgCharS": document.getElementById("forMask_imgId_chars"),
                    "idForMapCharS": document.getElementById("forMask_mapId_chars"),
                }
            };
        } else if (nFilterExtKeypadTypeInitBinary == "1000") {
            nfilterObjForKeypadElm.mobile = {
                "Num": {
                    "idForImgNum": document.getElementById("forMask_imgId_num"),
                    "idForMapNum": document.getElementById("forMask_mapId_num")
                }
            }
        }
    }

    
    for (var device in nfilterObjForKeypadElm) {
        for (var keypadType in nfilterObjForKeypadElm[device]) {
            for (var elm in nfilterObjForKeypadElm[device][keypadType]) {
                var idsTmp = nfilterObjForKeypadElm[device][keypadType][elm];
                if (typeof idsTmp === "undefined" || idsTmp == null) {
                    console.log("[" + elm + "] is undefined.");
                } else {
                    nfilterObjForKeypadElm[device][keypadType][elm] = idsTmp.value;
                }
            }
        }
    }
}


function fitKeypadPos(_caller) {
    var tmpStrImg = "";
    var tmpStrMap = "";
    var tmpIdImg = null;
    var tmpIdMap = null;
    var elmImg = null;
    var elmMap = null;
    var mainTopY = parseInt(nFilterPxSplit(document.getElementById("nfilter_main").style.top));

    
    for (var device in nfilterObjForKeypadElm) {
        for (var keypadType in nfilterObjForKeypadElm[device]) {
            tmpStrImg = "idForImg" + keypadType;
            tmpStrMap = "idForMap" + keypadType;
            tmpIdImg = nfilterObjForKeypadElm[device][keypadType][tmpStrImg];
            tmpIdMap = nfilterObjForKeypadElm[device][keypadType][tmpStrMap];
            if (!nFilterIsElementExist(tmpIdImg) || !nFilterIsElementExist(tmpIdMap)) {
                console.log("img or map not found");
                return;
            }
            elmImg = document.getElementById(tmpIdImg);
            elmMap = document.getElementById(tmpIdMap);
            elmMap.style.left = elmImg.offsetLeft + "px";
            elmMap.style.top = elmImg.offsetTop + "px";

            
            
            
            
        }
    }
}

function nFilterInitAfter(isDisplay, targetElementId, displayElementId) {

    
    if (nFilterIsElementExist(nFilterKeypadIdCharL)) {
        if (nFilterIsKeypadEncode == true) {
            document.getElementById(nFilterKeypadIdCharL).innerHTML = nFilterDecode64(document.getElementById(nFilterKeypadIdCharL).innerHTML);
        }
        document.getElementById(nFilterKeypadIdCharL).style.display = "none";
    }
    if (nFilterIsElementExist(nFilterKeypadIdCharU)) {
        if (nFilterIsKeypadEncode == true) {
            document.getElementById(nFilterKeypadIdCharU).innerHTML = nFilterDecode64(document.getElementById(nFilterKeypadIdCharU).innerHTML);
        }
        document.getElementById(nFilterKeypadIdCharU).style.display = "none";
    }
    if (nFilterIsElementExist(nFilterKeypadIdCharS)) {
        if (nFilterIsKeypadEncode == true) {
            document.getElementById(nFilterKeypadIdCharS).innerHTML = nFilterDecode64(document.getElementById(nFilterKeypadIdCharS).innerHTML);
        }
        document.getElementById(nFilterKeypadIdCharS).style.display = "none";
    }
    if (nFilterIsElementExist(nFilterKeypadIdNum)) {
        if (nFilterIsKeypadEncode == true) {
            document.getElementById(nFilterKeypadIdNum).innerHTML = nFilterDecode64(document.getElementById(nFilterKeypadIdNum).innerHTML);
        }
        document.getElementById(nFilterKeypadIdNum).style.display = "none";
    }
    if (nFilterEnableNoSecretKeypad) {
        if (nFilterIsElementExist(nFilterKeypadIdCharL + nFilterKeypadIdNoSecretSuffix)) {
            if (nFilterIsKeypadEncode == true) {
                document.getElementById(nFilterKeypadIdCharL + nFilterKeypadIdNoSecretSuffix).innerHTML = nFilterDecode64(document.getElementById(nFilterKeypadIdCharL + nFilterKeypadIdNoSecretSuffix).innerHTML);
            }
            document.getElementById(nFilterKeypadIdCharL + nFilterKeypadIdNoSecretSuffix).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdCharU + nFilterKeypadIdNoSecretSuffix)) {
            if (nFilterIsKeypadEncode == true) {
                document.getElementById(nFilterKeypadIdCharU + nFilterKeypadIdNoSecretSuffix).innerHTML = nFilterDecode64(document.getElementById(nFilterKeypadIdCharU + nFilterKeypadIdNoSecretSuffix).innerHTML);
            }
            document.getElementById(nFilterKeypadIdCharU + nFilterKeypadIdNoSecretSuffix).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdCharS + nFilterKeypadIdNoSecretSuffix)) {
            if (nFilterIsKeypadEncode == true) {
                document.getElementById(nFilterKeypadIdCharS + nFilterKeypadIdNoSecretSuffix).innerHTML = nFilterDecode64(document.getElementById(nFilterKeypadIdCharS + nFilterKeypadIdNoSecretSuffix).innerHTML);
            }
            document.getElementById(nFilterKeypadIdCharS + nFilterKeypadIdNoSecretSuffix).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix)) {
            if (nFilterIsKeypadEncode == true) {
                document.getElementById(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix).innerHTML = nFilterDecode64(document.getElementById(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix).innerHTML);
            }
            document.getElementById(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix).style.display = "none";
        }
    }
    

    
    if (isDisplay) {
        document.getElementById("nfilter_document").style.display = "block";
    } else {
        document.getElementById("nfilter_document").style.display = "none";
    }
    if (nFilterIsMaskMatch(nFilterKeypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L)
        || nFilterIsMaskMatch(nFilterKeypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U)
        || nFilterIsMaskMatch(nFilterKeypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S)
        || nFilterIsMaskMatch(nFilterKeypadType, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM)) {
        if (nFilterKeypadType.toString(2) == "1000") {
            if (document.getElementById("nfilter_char")) {
                document.getElementById("nfilter_char").style.display = "none";
            }
            if (document.getElementById("nfilter_num")) {
                document.getElementById("nfilter_num").style.display = "block";
            }
        }
        nFilterSetDefaultKeypadType();
        nFilterIsKeyShiftNow = false;
        if (nFilterCSReturnURL != "" && nFilterIsElementExist("nfilter_close_char")) {
            document.getElementById("nfilter_close_char").style.display = "none";
        }
    }
    nFilterMain = document.getElementById("nfilter_main");

    
    if (isDisplay) {
        nFilterSetPosition(displayElementId);
    }
    nFilterExtRegistEventOnKeyDownUp();

    
    if (isDisplay) {
        nFilterKeypadShow(nFilterGetKeypadBinary(nFilterKeypadType), false, targetElementId, displayElementId);
    }

    
    if (getNFilterOSInfo() == "Android" || getNFilterOSInfo() == "iPad" || getNFilterOSInfo() == "iPhone" || getNFilterOSInfo() == "iPod") {
        var mobileEnterChar = document.getElementById("nfilter_enter_char_mobile");
        if (mobileEnterChar != undefined && mobileEnterChar.ontouchstart == undefined && mobileEnterChar.onclick == undefined) {
            mobileEnterChar.ontouchstart = function () {
                nFilterOnTouchstart();
            }
        }
        if (mobileEnterChar != undefined && mobileEnterChar.ontouchend == undefined && mobileEnterChar.onclick == undefined) {
            mobileEnterChar.ontouchend = function () {
                nFilterOnTouchend(this.id);
            }
        }
        var mobileClearChar = document.getElementById("nfilter_clear_mobile");
        if (mobileClearChar != undefined && mobileClearChar.ontouchstart == undefined && mobileClearChar.onclick == undefined) {
            mobileClearChar.ontouchstart = function () {
                nFilterOnTouchstart();
            }
        }
        if (mobileClearChar != undefined && mobileClearChar.ontouchend == undefined && mobileClearChar.onclick == undefined) {
            mobileClearChar.ontouchend = function () {
                nFilterOnTouchend(this.id);
            }
        }
        var mobileChangeChar = document.getElementById("nfilter_change_mobile");
        if (mobileChangeChar != undefined && mobileChangeChar.ontouchstart == undefined && mobileChangeChar.onclick == undefined) {
            mobileChangeChar.ontouchstart = function () {
                nFilterOnTouchstart();
            }
        }
        if (mobileChangeChar != undefined && mobileChangeChar.ontouchend == undefined && mobileChangeChar.onclick == undefined) {
            mobileChangeChar.ontouchend = function () {
                nFilterOnTouchend(this.id);
            }
        }
        var mobileCloseNum = document.getElementById("nfilter_close_num_mobile");
        if (mobileCloseNum != undefined && mobileCloseNum.ontouchstart == undefined && mobileCloseNum.onclick == undefined) {
            mobileCloseNum.ontouchstart = function () {
                nFilterOnTouchstart();
            }
        }
        if (mobileCloseNum != undefined && mobileCloseNum.ontouchend == undefined && mobileCloseNum.onclick == undefined) {
            mobileCloseNum.ontouchend = function () {
                nFilterOnTouchend(this.id);
            }
        }
        var mobileCloseChar = document.getElementById("nfilter_close_char_mobile");
        if (mobileCloseChar != undefined && mobileCloseChar.ontouchstart == undefined && mobileCloseChar.onclick == undefined) {
            mobileCloseChar.ontouchstart = function () {
                nFilterOnTouchstart();
            }
        }
        if (mobileCloseChar != undefined && mobileCloseChar.ontouchend == undefined && mobileCloseChar.onclick == undefined) {
            mobileCloseChar.ontouchend = function () {
                nFilterOnTouchend(this.id);
            }
        }
    } else {
        var changeEng = document.getElementById("nfilter_change_eng");
        if (changeEng != undefined && changeEng.onclick == undefined) {
            changeEng.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
        var changeSpecial = document.getElementById("nfilter_change_special");
        if (changeSpecial != undefined && changeSpecial.onclick == undefined) {
            changeSpecial.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
        var closeChar = document.getElementById("nfilter_close_char");
        if (closeChar != undefined && closeChar.onclick == undefined) {
            closeChar.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
        var closeNum = document.getElementById("nfilter_close_num");
        if (closeNum != undefined && closeNum.onclick == undefined) {
            closeNum.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
        var mobileEnterChar = document.getElementById("nfilter_enter_char_mobile");
        if (mobileEnterChar != undefined && mobileEnterChar.onclick == undefined) {
            mobileEnterChar.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
        var mobileClearChar = document.getElementById("nfilter_clear_mobile");
        if (mobileClearChar != undefined && mobileClearChar.onclick == undefined) {
            mobileClearChar.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
        var mobileChangeChar = document.getElementById("nfilter_change_mobile");
        if (mobileChangeChar != undefined && mobileChangeChar.onclick == undefined) {
            mobileChangeChar.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
        var mobileCloseNum = document.getElementById("nfilter_close_num_mobile");
        if (mobileCloseNum != undefined && mobileCloseNum.onclick == undefined) {
            mobileCloseNum.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
        var mobileCloseChar = document.getElementById("nfilter_close_char_mobile");
        if (mobileCloseChar != undefined && mobileCloseChar.onclick == undefined) {
            mobileCloseChar.onclick = function () {
                nFilterOnKeyClick(this);
            }
        }
    }
    var mapTags = document.getElementsByClassName('nfilter_keypad_div');
    for (var int = 0; int < mapTags.length; int++) {
        var area = mapTags[int].getElementsByTagName('button');
        for (var int2 = 0; int2 < area.length; int2++) {
            if (getNFilterOSInfo() == "Android" || getNFilterOSInfo() == "iPad" || getNFilterOSInfo() == "iPhone" || getNFilterOSInfo() == "iPod") {
                if (getNFilterBrowerInfo() == "Firefox") {
                    if (area[int2].onmouseup == undefined) {
                        area[int2].onmouseup = function () {
                            nFilterOnKeyClick(this);
                        }
                    }
                }
                if (area[int2].ontouchstart == undefined) {
                    area[int2].ontouchstart = function () {
                        nFilterOnTouchstart();
                    }
                }
                if (area[int2].ontouchend == undefined) {
                    area[int2].ontouchend = function () {
                        nFilterOnTouchend(this.id);
                    }
                }
            } else {
                if (area[int2].onmouseup == undefined) {
                    area[int2].onmouseup = function () {
                        nFilterOnKeyClick(this);
                    }
                }
            }
        }
    }
    

    
    setnFilterChangeKey();
}


function nFilterKeypadShowExt(keypadShowTypeBinary, targetElementId, displayElementId) {
    for (var int = 0; int < nFilterTypeArray.length; int++) {
        var nFilterTypeCheck = nFilterTypeArray[int].replace(new RegExp(document.getElementById(displayElementId).id + "&", "g"), "");
        if (nFilterTypeCheck == "true") {
            nFilterKeypadShow(keypadShowTypeBinary, false, targetElementId, displayElementId);
            break;
        } else if (nFilterTypeCheck == "false") {
            nFilterKeypadShow(keypadShowTypeBinary, true, targetElementId, displayElementId);
            break;
        }
    }
}

var inputMax = 13;
var inputMaxNum = 7;
var inputMaxMobile = 13;
var inputMaxMobileNum = 16;
var nFilterEscClick = false;

function nFilterKeypadShow(keypadShowTypeBinary, isNoSecret, targetElementId, displayElementId) {

    
    if (nFilterScreenKeyPadPCSize == 362) {
        document.getElementById("nfilter_char").style.paddingLeft = 10 + "px";
        document.getElementById("nfilter_char").style.width = 356 + "px";
        document.getElementById("nfilter_char_header").style.width = 356 + "px";
        document.getElementById("nfilter_char").style.height = 130 + "px";

        var elems = document.getElementsByClassName('nfilter_char_header_li1');
        for (var i = 0; i < elems.length; i++) {
            elems[i].style.width = 93 + "px";
        }
        var elems2 = document.getElementsByClassName('nfilter_char_header_li2');
        for (var i = 0; i < elems2.length; i++) {
            elems2[i].style.width = 112 + "px";
        }
        var elems3 = document.getElementsByClassName('nfilter_char_header_li3');
        for (var i = 0; i < elems3.length; i++) {
            elems3[i].style.marginLeft = 0 + "px";
        }
    }

    
    nFilterEscClick = true;
    document.getElementById(displayElementId).blur();

    
    OnorientationchangeStyle = true;
    nFilterKeypadShowType = parseInt(keypadShowTypeBinary, 2);

    
    if (nFilterIsMobileRequest) {
        if (isNoSecret) {
            if (nFilterIsMaskMatch(keypadShowTypeBinary, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM)) {
                var minMaxCheckElement = document.getElementById(displayElementId);
                inputMaxMobileNum = minMaxCheckElement.getAttribute('maxlength');
            } else {
                var minMaxCheckElement = document.getElementById(displayElementId);
                inputMaxMobile = minMaxCheckElement.getAttribute('maxlength');
            }
        } else {
            if (nFilterIsMaskMatch(keypadShowTypeBinary, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM)) {
                var minMaxCheckElement = document.getElementById(displayElementId);
                inputMaxMobileNum = minMaxCheckElement.getAttribute('maxlength');
            } else {
                var minMaxCheckElement = document.getElementById(displayElementId);
                inputMaxMobile = minMaxCheckElement.getAttribute('maxlength');
            }
        }
    } else {
        if (isNoSecret) {
            if (nFilterIsMaskMatch(keypadShowTypeBinary, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM)) {
                var minMaxCheckElement = document.getElementById(displayElementId);
                inputMaxNum = minMaxCheckElement.getAttribute('maxlength');
            } else {
                var minMaxCheckElement = document.getElementById(displayElementId);
                inputMax = minMaxCheckElement.getAttribute('maxlength');
            }
        } else {
            if (nFilterIsMaskMatch(keypadShowTypeBinary, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM)) {
                var minMaxCheckElement = document.getElementById(displayElementId);
                inputMaxNum = minMaxCheckElement.getAttribute('maxlength');
            } else {
                var minMaxCheckElement = document.getElementById(displayElementId);
                inputMax = minMaxCheckElement.getAttribute('maxlength');
            }
        }
    }
    

    
    if (displayElementId == undefined || displayElementId == null || displayElementId == "") {
        return false;
    }

    if (targetElementId == undefined || targetElementId == null || targetElementId == "") {
        
        if (displayElementId.indexOf("|") > -1) {
            var displayElts = displayElementId.split("|");
            for (var d = 0; d < displayElts.length; d++) {
                targetElementId += displayElts[d] + nFilterKeypadIdTargetSuffix;
            }
        } else {
            targetElementId = displayElementId + nFilterKeypadIdTargetSuffix;
        }
        
    }

    
    if (isNoSecret != undefined && isNoSecret != null && isNoSecret == true) {
        nFilterIsNoSecretKeypad = true;
        tmpKeypadIdCharL = nFilterKeypadIdCharL + nFilterKeypadIdNoSecretSuffix;
        tmpKeypadIdCharU = nFilterKeypadIdCharU + nFilterKeypadIdNoSecretSuffix;
        tmpKeypadIdCharS = nFilterKeypadIdCharS + nFilterKeypadIdNoSecretSuffix;
        tmpKeypadIdNum = nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix;
        if (nFilterIsElementExist(nFilterKeypadIdCharL)) {
            document.getElementById(nFilterKeypadIdCharL).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdCharU)) {
            document.getElementById(nFilterKeypadIdCharU).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdCharS)) {
            document.getElementById(nFilterKeypadIdCharS).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdNum)) {
            document.getElementById(nFilterKeypadIdNum).style.display = "none";
        }
    } else {
        nFilterIsNoSecretKeypad = false;
        tmpKeypadIdCharL = nFilterKeypadIdCharL;
        tmpKeypadIdCharU = nFilterKeypadIdCharU;
        tmpKeypadIdCharS = nFilterKeypadIdCharS;
        tmpKeypadIdNum = nFilterKeypadIdNum;
        if (nFilterIsElementExist(nFilterKeypadIdCharL + nFilterKeypadIdNoSecretSuffix)) {
            document.getElementById(nFilterKeypadIdCharL + nFilterKeypadIdNoSecretSuffix).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdCharU + nFilterKeypadIdNoSecretSuffix)) {
            document.getElementById(nFilterKeypadIdCharU + nFilterKeypadIdNoSecretSuffix).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdCharS + nFilterKeypadIdNoSecretSuffix)) {
            document.getElementById(nFilterKeypadIdCharS + nFilterKeypadIdNoSecretSuffix).style.display = "none";
        }
        if (nFilterIsElementExist(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix)) {
            document.getElementById(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix).style.display = "none";
        }
    }
    

    
    if (targetElementId.indexOf("|") > -1 && displayElementId.indexOf("|") > -1) {
        targetElementId = targetElementId.substring(0, targetElementId.indexOf("|"));
        displayElementId = displayElementId.substring(0, displayElementId.indexOf("|"));
        nFilterCreateElement(targetElementId, displayElementId);
        nFilterInputTargetElement = document.getElementById(targetElementId);
        nFilterInputDisplayElement = document.getElementById(displayElementId);
    } else {
        nFilterCreateElement(targetElementId, displayElementId);
        nFilterInputTargetElement = document.getElementById(targetElementId);
        nFilterInputDisplayElement = document.getElementById(displayElementId);
    }
    

    
    nFilterClearInput();

    
    nFilterSetPosition(displayElementId);

    
    if (nFilterIsElementExist("nfilter_document")) {
        document.getElementById("nfilter_document").style.display = "block";

        
        if (nFilterIsMobileRequest) {
            if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L) && nFilterIsElementExist(tmpKeypadIdCharL)) {
                document.getElementById(tmpKeypadIdCharL).style.display = "block";
                nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L;
                if (nFilterIsElementExist(tmpKeypadIdCharU)) {
                    document.getElementById(tmpKeypadIdCharU).style.display = "none";
                }
                if (nFilterIsElementExist(tmpKeypadIdCharS)) {
                    document.getElementById(tmpKeypadIdCharS).style.display = "none";
                }
                if (nFilterIsElementExist(tmpKeypadIdNum)) {
                    document.getElementById(tmpKeypadIdNum).style.display = "none";
                }
            } else if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U) && nFilterIsElementExist(tmpKeypadIdCharU)) {
                document.getElementById(tmpKeypadIdCharU).style.display = "block";
                nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U;
                if (nFilterIsElementExist(tmpKeypadIdCharS)) {
                    document.getElementById(tmpKeypadIdCharS).style.display = "none";
                }
                if (nFilterIsElementExist(tmpKeypadIdNum)) {
                    document.getElementById(tmpKeypadIdNum).style.display = "none";
                }
            } else if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S) && nFilterIsElementExist(tmpKeypadIdCharS)) {
                document.getElementById(tmpKeypadIdCharS).style.display = "block";
                nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S;
                if (nFilterIsElementExist(tmpKeypadIdNum)) {
                    document.getElementById(tmpKeypadIdNum).style.display = "none";
                }
            } else if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM) && nFilterIsElementExist(tmpKeypadIdNum)) {
                nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.NUM;
                document.getElementById(tmpKeypadIdNum).style.display = "block";
            }
        } else {
            
            if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L) ||
                nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U)) {
                if (nFilterIsElementExist("nfilter_change_eng")) {
                    document.getElementById("nfilter_change_eng").style.display = "block";
                }
            } else {
                if (nFilterIsElementExist("nfilter_change_eng")) {
                    document.getElementById("nfilter_change_eng").style.display = "none";
                }
            }
            if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S)) {
                if (nFilterIsElementExist("nfilter_change_special")) {
                    document.getElementById("nfilter_change_special").style.display = "block";
                }
            } else {
                if (nFilterIsElementExist("nfilter_change_special")) {
                    document.getElementById("nfilter_change_special").style.display = "none";
                }
            }
        }

        
        if (parseInt(keypadShowTypeBinary, 2) == nfilterEnumObj.KEYPAD_TYPE_MASK.NUM) {
            if (nFilterIsElementExist("nfilter_char")) {
                document.getElementById("nfilter_char").style.display = "none";
            }
            if (nFilterIsElementExist("nfilter_num")) {
                document.getElementById("nfilter_num").style.display = "block";
                document.getElementById("nfilter_num_header").style.display = "block";
            }
            if (isNoSecret != undefined && isNoSecret != null && isNoSecret == true) {
                if (nFilterIsElementExist(nFilterKeypadIdNum)) {
                    document.getElementById(nFilterKeypadIdNum).style.display = "none";
                }
                if (nFilterIsElementExist(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix)) {
                    document.getElementById(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix).style.display = "block";
                }
            } else {
                if (nFilterIsElementExist(nFilterKeypadIdNum)) {
                    document.getElementById(nFilterKeypadIdNum).style.display = "block";
                }
                if (nFilterIsElementExist(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix)) {
                    document.getElementById(nFilterKeypadIdNum + nFilterKeypadIdNoSecretSuffix).style.display = "none";
                }
            }
            if (nFilterIsElementExist(tmpKeypadIdNum)) {
                document.getElementById(tmpKeypadIdNum).style.display = "block";
            }
            nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.NUM;
        } else {
            if (nFilterIsElementExist("nfilter_num")) {
                document.getElementById("nfilter_num").style.display = "none";
            }
            if (nFilterIsElementExist("nfilter_char")) {
                document.getElementById("nfilter_char").style.display = "block";
            }
            if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L)) {
                if (nFilterIsElementExist(tmpKeypadIdCharL)) {
                    document.getElementById(tmpKeypadIdCharL).style.display = "block";
                }
            } else if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U)) {
                if (nFilterIsElementExist(tmpKeypadIdCharU)) {
                    document.getElementById(tmpKeypadIdCharU).style.display = "block";
                }
            } else if (nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S)) {
                if (nFilterIsElementExist(tmpKeypadIdCharS)) {
                    document.getElementById(tmpKeypadIdCharS).style.display = "block";
                }
            }
            if (nFilterIsElementExist("nfilter_change_special") && nFilterIsElementExist("nfilter_change_eng")) {
                if (keypadShowTypeBinary == "0101" || keypadShowTypeBinary == "0110" || keypadShowTypeBinary == "0111") {
                    document.getElementById("nfilter_change_special").style.display = "block";
                    document.getElementById("nfilter_change_eng").style.display = "block";
                } else {
                    document.getElementById("nfilter_change_special").style.display = "none";
                    document.getElementById("nfilter_change_eng").style.display = "none";
                }
            }
        }
    }
    


    
    if (nFilterNumType == 2) {
        var elems = document.getElementsByClassName('nfilter_num_content');
        for (var i = 0; i < elems.length; i++) {
            var imgElems = elems[i].getElementsByTagName('img');
            for (var j = 0; j < imgElems.length; j++) {
                imgElems[j].style.margin = "4px 0 0";
            }
        }
        var elems2 = document.getElementsByClassName('nfilter_num_header_li3');
        for (var i = 0; i < elems2.length; i++) {
            if (nFilterIsMobileRequest) {
                elems2[i].style.width = "7%";
            } else {
                elems2[i].style.width = "";
            }
            var imgElems = elems2[i].getElementsByTagName('img');
            for (var j = 0; j < imgElems.length; j++) {
                
                imgElems[j].style.boxShadow = "0px 0px 0px black";
            }
        }
    } else if (nFilterNumType == 1) {
        var elems = document.getElementsByClassName('nfilter_num_content');
        for (var i = 0; i < elems.length; i++) {
            if (nFilterIsMobileRequest) {
                elems[i].style.marginLeft = "4px";
            }
        }
        var elems2 = document.getElementsByClassName('nfilter_num_content_no_secret');
        for (var i = 0; i < elems2.length; i++) {
            if (nFilterIsMobileRequest) {
                elems2[i].style.marginLeft = "4px";
            }
        }
    }
    
    settingKeypadId();

    
    fitKeypadPos('popup');

    
    var keypadFocus = document.getElementById("nfilter_main");
    keypadFocus.focus();
    
}

var touchUse = false;


function nFilterOnTouchstart() {
    touchUse = true;
}

function nFilterOnTouchend(key) {
   if (touchUse == true) {
        nFilterClick(key);
   }
}

function nFilterOnKeyClick(key) {
    if (key.id == "nfilter_close_char_mobile" || key.id == "nfilter_close_num_mobile" || key.id == "nfilter_enter_char_mobile"|| key.id == "nfilter_change_mobile") {
       return;
    }
    if (touchUse == false) {
        nFilterClick(key);
    }
}

var nFilterMapTags = "";
var nFilterAreaTags = "";
var nFilterTouchMaskElt = document.getElementById("nfilter_touch_mask");
var nFilterMaxLength = false;


function nFilterClick(key) {
    if (typeof key == "string" && key.indexOf(nFilterKeypadIdDummy) > -1) {
        return;
    }
    else if (typeof key == "object" && key.id.indexOf(nFilterKeypadIdDummy) > -1) {
        return;
    }
    var inputKeyId = "";
    var inputKeyElement = null;
    var inputImageUrl = "";
    try {
        
        if (key.id == undefined || key.id == null || key.id == "") {
            var num_check = /^[0-9]*$/;
            if (nFilterKeypadShowType == 7 && num_check.test(key)) {
                var charl_childNodes = document.getElementById((nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U) ?
                    "charu_no_secretmap" : "charl_no_secretmap").childNodes;
                for (i = 0; i < charl_childNodes.length; i++) {
                    if (key == charl_childNodes[i].id) {
                        inputKeyElement = charl_childNodes[i];
                        break;
                    }
                }
            } else {
                inputKeyElement = document.getElementById(key);
            }
            inputKeyId = key;
        } else {
            inputKeyElement = key;
            inputKeyId = key.id;
        }
    } catch (e) {
    }
    try {
        nFilterTouchMaskElt = document.getElementById("nfilter_touch_mask");
        if (inputKeyElement.tagName.toLowerCase() == "button") {
            var nowScroll = nFilterGetNowScroll();
            if (nFilterRequestParamIsMobile) {
                

                

                var objPosMain = {
                    "name": "main",
                    "left": parseFloat(nFilterPxSplit(document.getElementById("nfilter_main").style.left)),
                    "top": parseFloat(nFilterPxSplit(document.getElementById("nfilter_main").style.top))
                };
                

                
                var objParentMap = inputKeyElement.parentElement;
                

                var objPosMap = {
                    "name": "div",
                    "left": parseFloat(nFilterPxSplit(objParentMap.style.left)),
                    "top": parseFloat(nFilterPxSplit(objParentMap.style.top))
                };
                

                var objPosKey = {
                    "name": "clicked key",
                    "left": parseFloat(inputKeyElement.style.left),	
                    "top": parseFloat(inputKeyElement.style.top),	
                    "right": parseFloat(inputKeyElement.style.width), 	
                    "bottom": parseFloat(inputKeyElement.style.height)	
                };
                

                var objPosMask = {
                    "name": "mask",
                    "left": objPosMain.left + objPosMap.left + objPosKey.left,
                    "top": objPosMain.top + objPosMap.top + objPosKey.top,
                    "width": objPosKey.right,
                    "height": objPosKey.bottom,
                };
                

                nFilterTouchMaskElt.style.width = objPosMask.width + "px";
                nFilterTouchMaskElt.style.left = objPosMask.left + "px";
                nFilterTouchMaskElt.style.height = objPosMask.height + "px";
                nFilterTouchMaskElt.style.top = objPosMask.top + "px";

                
            } else {
                
                nFilterTouchMaskElt.style.left = (parseInt(nFilterFindOffsetLeft(inputKeyElement.parentNode.parentNode)) + parseInt(inputKeyElement.coords.split(',')[0])) + "px";
                nFilterTouchMaskElt.style.top = (parseInt(nFilterFindOffsetTop(inputKeyElement.parentNode.parentNode)) + parseInt(inputKeyElement.coords.split(',')[1]) + nowScroll.Y + 2) + "px";
            }
            nFilterTouchMaskElt.style.display = "block";
            window.setTimeout(function () {
                nFilterTouchMaskElt.style.display = "none";
            }, inputTime);
        }
    } catch (e) {
    }
    if (inputKeyId == "nfilter_close_char" || inputKeyId == "nfilter_close_char_mobile" || inputKeyId == "nfilter_close_char_u" ||
        inputKeyId == "nfilter_enter_char" || inputKeyId == "nfilter_enter_char_u" ||
        inputKeyId == "nfilter_close_num" || inputKeyId == "nfilter_enter_num" || inputKeyId == "nfilter_enter_num_secret" ||
        inputKeyId == "nfilter_close_num_mobile" ||
        inputKeyId == "nfilter_enter_char_mobile" || inputKeyId == "nfilter_enter_num_mobile" || inputKeyId == "nfilter_enter_num_mobile_secret" ||
        inputKeyId == "nfilter_clear_mobile") {
        if (nFilterClassActiveState) nFilterClassActive(inputKeyId);
        if (inputKeyId == "nfilter_close_char" || inputKeyId == "nfilter_close_char_mobile" || inputKeyId == "nfilter_close_char_u" || inputKeyId == "nfilter_close_num" ||
            inputKeyId == "nfilter_close_num_mobile" || inputKeyId == "nfilter_clear_mobile") {
            nFilterClearInput();
            if (inputKeyId == "nfilter_clear_mobile") return;
            nFilterInputDisplayElement.removeAttribute("disabled");
        } else {
            
            var checkResult = nFilterMinMaxCheck(nFilterInputDisplayElement.id);

            
            if (!checkResult) {
                nFilterClearInput();
                return false;
            }
            nFilterInputDisplayElement.setAttribute("directkey", "off");
            nFilterInputDisplayElement.readOnly = true;
            if (nFilterIsEncryptImmediate == true || nFilterCSReturnURL != "") {
                if (nFilterIsNoSecretKeypad) {
                    
                    if (nFilterAlgName == "ECDH") {
                        nFilterInputTargetElement.value = nFilterInputEncryptEcdh(nFilterKeypadIdNoSecretPrefix + nFilterSecElement);
                    } else {
                        nFilterInputTargetElement.value = nFilterInputEncrypt(nFilterKeypadIdNoSecretPrefix + nFilterSecElement);
                    }
                } else {
                    if (!nFilterInputDisplayElement.getAttribute("curConfirm") && !nFilterInputDisplayElement.getAttribute("confirm")) {
                        if (nFilterAlgName == "ECDH") {
                            nFilterInputTargetElement.value = nFilterInputEncryptEcdh(nFilterSecElement);
                        } else {
                            nFilterInputTargetElement.value = nFilterInputEncrypt(nFilterSecElement);
                        }
                        
                    }
                }
            }
            if (nFilterCSReturnURL != "") {
                nFilterCSProcess(nFilterInputTargetElement.value, nFilterInputDisplayElement.id);
            }
        }

        nFilterSetDefaultKeypadType();

        callbackMsg = (inputKeyId == "nfilter_close_char" || inputKeyId == "nfilter_close_char_mobile" || inputKeyId == "nfilter_close_char_u" ||
            inputKeyId == "nfilter_close_num" || inputKeyId == "nfilter_close_num_mobile" || inputKeyId == "nfilter_clear_mobile") ? "close" : "enter";

        
        setTimeout(function () {
            nFilterClose2(inputKeyId);
        }, 300);

        if (typeof nFilterCallback == "function" && !nFilterMaxLength) {
            if (nFilterMaxCall) {
                callbackMsg = "close";
                nFilterMaxCall = false;
            }
            nFilterMaxLength = true;
            nFilterCallback(callbackMsg, nFilterInputDisplayElement.id);
            nFilterMaxLength = false;
        }

    } else if (inputKeyId == "nfilter_backspace_char" || inputKeyId == "nfilter_backspace_char_u" || inputKeyId == "nfilter_backspace_num" || inputKeyId == "nfilter_backspace_num_secret" || inputKeyId == "nfilter_backspace_l_mobile" ||
        inputKeyId == "nfilter_backspace_l_mobile_secret" || inputKeyId == "nfilter_backspace_u_mobile" || inputKeyId == "nfilter_backspace_u_mobile_secret" || inputKeyId == "nfilter_backspace_s_mobile" ||
        inputKeyId == "nfilter_backspace_s_mobile_secret" || inputKeyId == "nfilter_backspace_num_mobile" || inputKeyId == "nfilter_backspace_num_mobile_secret") {

        
        if (nFilterSecElement.length > 0) {
            nFilterSecElement = nFilterSecElement.substr(0, nFilterSecElement.length - nFilterRandomIdLength);
            nFilterInputTargetElement.value = nFilterInputTargetElement.value.substr(0, nFilterInputTargetElement.value.length - nFilterRandomIdLength);
        }

        
        if (nFilterIsNoSecretKeypad) {
            var temInputDisplayElementValue = "";
            if (nFilterInputDisplayElement.value.length > 0) {
                temInputDisplayElementValue = nFilterInputDisplayElement.value.substr(0, nFilterInputDisplayElement.value.length - 1);

                
                if (temInputDisplayElementValue.substring(temInputDisplayElementValue.length - 1, temInputDisplayElementValue.length) == ",") {
                    nFilterInputDisplayElement.value = temInputDisplayElementValue.substr(0, temInputDisplayElementValue.length - 1);
                } else {
                    nFilterInputDisplayElement.value = temInputDisplayElementValue;
                }

                
                if (nFilterIsElementExist("nfilter_tmp_editview")) {
                    var tmpEditviewNumValue = nFilterInputDisplayElement.value;
                    document.getElementById("nfilter_tmp_editview").innerHTML = tmpEditviewNumValue;
                }
                if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
                    var tmpEditviewNumValue = nFilterInputDisplayElement.value;
                    document.getElementById("nfilter_tmp_editview_num").innerHTML = tmpEditviewNumValue;
                }
            } else {
                
                if (typeof nFilterCallback == "function" && !nFilterMaxLength) {
                    callbackMsg = "delete";
                    nFilterCallback(callbackMsg, nFilterInputDisplayElement.id);
                }
                return false;
            }

        } else { 
            if (nFilterInputDisplayElement.value.length > 0) {
                nFilterInputDisplayElement.value = nFilterInputDisplayElement.value.substr(0, nFilterInputDisplayElement.value.length - 1);
                if (nFilterIsMobileRequest) {
                    if (nFilterIsElementExist("nfilter_tmp_editview")) {
                        if (nFilterInputDisplayElement.value.length >= inputMaxMobile) {
                        } else {
                            document.getElementById("nfilter_tmp_editview").innerHTML = document.getElementById("nfilter_tmp_editview").innerHTML.substr(0, document.getElementById("nfilter_tmp_editview").innerHTML.length - 1);
                        }
                    }
                    if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
                        if (nFilterInputDisplayElement.value.length >= inputMaxMobileNum) {
                        } else {
                            document.getElementById("nfilter_tmp_editview_num").innerHTML = document.getElementById("nfilter_tmp_editview_num").innerHTML.substr(0, document.getElementById("nfilter_tmp_editview_num").innerHTML.length - 1);
                        }
                    }
                } else {
                    if (nFilterIsElementExist("nfilter_tmp_editview")) {
                        if (nFilterInputDisplayElement.value.length >= inputMax) {
                        } else {
                            document.getElementById("nfilter_tmp_editview").innerHTML = document.getElementById("nfilter_tmp_editview").innerHTML.substr(0, document.getElementById("nfilter_tmp_editview").innerHTML.length - 1);
                        }
                    }
                    if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
                        if (nFilterInputDisplayElement.value.length >= inputMaxNum) {
                        } else {
                            document.getElementById("nfilter_tmp_editview_num").innerHTML = document.getElementById("nfilter_tmp_editview_num").innerHTML.substr(0, document.getElementById("nfilter_tmp_editview_num").innerHTML.length - 1);
                        }
                    }
                }
            } else {
                
                if (typeof nFilterCallback == "function" && !nFilterMaxLength) {
                    callbackMsg = "delete";
                    nFilterCallback(callbackMsg, nFilterInputDisplayElement.id);
                }
                return false;
            }
        }

        
        if (typeof nFilterCallback == "function" && !nFilterMaxLength) {
            callbackMsg = "delete";
            nFilterCallback(callbackMsg, nFilterInputDisplayElement.id);
        }
    } else if (inputKeyId.indexOf("nfilter_capslock") > -1) {
        if (nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L || nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U) {
            nFilterIsKeyShiftNow = false;
            if (inputKeyId == "nfilter_capslock_u1" || inputKeyId == "nfilter_capslock_u2") {
                if (nFilterKeypadShowType != 0 && !nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L)) {
                    return false;
                }
                if (nFilterIsElementExist(tmpKeypadIdCharU) && nFilterIsElementExist(tmpKeypadIdCharL)) {
                    document.getElementById(tmpKeypadIdCharU).style.display = "none";
                    document.getElementById(tmpKeypadIdCharL).style.display = "block";
                    nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L;
                    nFilterIsKeyShiftNow = false;
                } else if (nFilterIsElementExist(tmpKeypadIdCharU) && nFilterIsElementExist(tmpKeypadIdCharS)) {
                    document.getElementById(tmpKeypadIdCharU).style.display = "none";
                    document.getElementById(tmpKeypadIdCharS).style.display = "block";
                    nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S;
                    nFilterIsKeyShiftNow = false;
                }
            } else {
                if (nFilterKeypadShowType != 0 && !nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U)) {
                    return false;
                }
                if (nFilterIsElementExist(tmpKeypadIdCharL) && nFilterIsElementExist(tmpKeypadIdCharU)) {
                    document.getElementById(tmpKeypadIdCharL).style.display = "none";
                    document.getElementById(tmpKeypadIdCharU).style.display = "block";
                    nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U;
                    nFilterIsKeyShiftNow = false;
                }
                if (nFilterIsElementExist(tmpKeypadIdCharS) && nFilterIsElementExist(tmpKeypadIdCharU)) {
                    document.getElementById(tmpKeypadIdCharS).style.display = "none";
                    document.getElementById(tmpKeypadIdCharU).style.display = "block";
                    nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U;
                    nFilterIsKeyShiftNow = false;
                }
            }
        }
    } else if (inputKeyId == "nfilter_shift" || inputKeyId == "nfilter_shift_u" ||
        inputKeyId == "nfilter_shift_l_mobile" || inputKeyId == "nfilter_shift_l_mobile_secret" || inputKeyId == "nfilter_shift_u_mobile" ||
        inputKeyId == "nfilter_shift_u_mobile_secret" || inputKeyId == "nfilter_shift_s_mobile" || inputKeyId == "nfilter_shift_s_mobile_secret") {
        if (nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S) {
            return false;
        }
        if (inputKeyId == "nfilter_shift_s_mobile" || inputKeyId == "nfilter_shift_s_mobile_secret") {
            return false;
        }
        if (inputKeyId == "nfilter_shift" || inputKeyId == "nfilter_shift_l_mobile" || inputKeyId == "nfilter_shift_l_mobile_secret") {
            if (nFilterIsElementExist(tmpKeypadIdCharU) && nFilterIsElementExist(tmpKeypadIdCharL)) {
                document.getElementById(tmpKeypadIdCharL).style.display = "none";
                document.getElementById(tmpKeypadIdCharU).style.display = "block";
                nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U;
                nFilterIsKeyShiftNow = true;
            }
        } else {
            if (nFilterKeypadShowType != 0 && !nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L)) {
                return false;
            }
            if (nFilterIsElementExist(tmpKeypadIdCharL) && nFilterIsElementExist(tmpKeypadIdCharU)) {
                document.getElementById(tmpKeypadIdCharU).style.display = "none";
                document.getElementById(tmpKeypadIdCharL).style.display = "block";
                nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L;
                nFilterIsKeyShiftNow = false;
            }
        }
    } else if (inputKeyId == "nfilter_change_eng" || inputKeyId == "nfilter_change_special" || inputKeyId == "nfilter_change_mobile") {
        
        if (nFilterClassActiveState) nFilterClassActive(inputKeyId);
        if (inputKeyId == "nfilter_change_mobile") {
            var nFilterMobileOn = document.getElementById("nfilter_change_mobile").src;
            if (nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S) {
                if (nFilterIsElementExist(tmpKeypadIdCharL)) {
                    if (nFilterKeypadShowType != 0 && !nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L)) {
                        return false;
                    }
                    document.getElementById(tmpKeypadIdCharS).style.display = "none";
                    document.getElementById(tmpKeypadIdCharL).style.display = "block";
                    nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L;

                    
                    document.getElementById(inputKeyId).setAttribute("aria-label", "특수문자버튼");
                } else if (nFilterIsElementExist(tmpKeypadIdCharU)) {
                    if (nFilterKeypadShowType != 0 && !nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U)) {
                        return false;
                    }
                    document.getElementById(tmpKeypadIdCharS).style.display = "none";
                    document.getElementById(tmpKeypadIdCharU).style.display = "block";
                    nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U;

                    
                    document.getElementById(inputKeyId).setAttribute("aria-label", "특수문자버튼");
                }

            } else { 

                if (nFilterIsElementExist(tmpKeypadIdCharL)) {
                    document.getElementById(tmpKeypadIdCharL).style.display = "none";
                    nfilterKeypadState = nfilterKeypadState & ~nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L;
                }
                if (nFilterIsElementExist(tmpKeypadIdCharU)) {
                    document.getElementById(tmpKeypadIdCharU).style.display = "none";
                    nfilterKeypadState = nfilterKeypadState & ~nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U;
                }
                if (nFilterIsElementExist(tmpKeypadIdCharS)) {
                    document.getElementById(tmpKeypadIdCharS).style.display = "block";
                    nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S;
                }

                
                document.getElementById(inputKeyId).setAttribute("aria-label", "영문버튼");
            }
            nFilterIsKeyShiftNow = false;
        } else if (inputKeyId == "nfilter_change_eng") {
            if (nFilterKeypadShowType != 0 && (!nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L) || !nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U))) {
                return false;
            }
            if (nFilterIsElementExist(tmpKeypadIdCharS) && nFilterIsElementExist(tmpKeypadIdCharL)) {
                document.getElementById(tmpKeypadIdCharS).style.display = "none";
                document.getElementById(tmpKeypadIdCharL).style.display = "block";
                nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L;
            } else if (nFilterIsElementExist(tmpKeypadIdCharS) && nFilterIsElementExist(tmpKeypadIdCharU)) {
                document.getElementById(tmpKeypadIdCharS).style.display = "none";
                document.getElementById(tmpKeypadIdCharU).style.display = "block";
                nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U;
            }
        } else {
            if (nFilterKeypadShowType != 0 && !nFilterIsMaskMatch(nFilterKeypadShowType, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S)) {
                return false;
            }
            if (nFilterIsElementExist(tmpKeypadIdCharU) && nFilterIsElementExist(tmpKeypadIdCharS)) {
                document.getElementById(tmpKeypadIdCharU).style.display = "none";
                document.getElementById(tmpKeypadIdCharS).style.display = "block";
            }
            if (nFilterIsElementExist(tmpKeypadIdCharL) && nFilterIsElementExist(tmpKeypadIdCharS)) {
                document.getElementById(tmpKeypadIdCharL).style.display = "none";
                document.getElementById(tmpKeypadIdCharS).style.display = "block";
            }
            nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S;
        }
        nFilterIsKeyShiftNow = false;
    } else {

        
        
        
        

        
        if (inputKeyId.length >= nFilterKeypadIdDummy.length && inputKeyId.indexOf(nFilterKeypadIdDummy) != -1) {

        } else {
            
            
            
            
            
            
            
            if(nFilterInputTargetElement.value.length > 0) {
                nFilterInputTargetElement.value = nFilterInputTargetElement.value + inputKeyId;
                nFilterSecElement = nFilterSecElement + inputKeyId;
            } else {
                nFilterInputTargetElement.value = inputKeyId;
                nFilterSecElement = inputKeyId;
            }
        }

        
        if (nFilterIsNoSecretKeypad == false) {
            nFilterInputDisplayElement.value += "*";
            if (nFilterIsElementExist("nfilter_tmp_editview")) {
                if (nFilterIsMobileRequest) {
                    if (nFilterInputDisplayElement.value.length <= inputMaxMobile) {
                        document.getElementById("nfilter_tmp_editview").innerHTML += "&bull;";
                    }
                } else if (nFilterInputDisplayElement.value.length <= inputMax) {
                    document.getElementById("nfilter_tmp_editview").innerHTML += "&bull;";
                }
            }
            if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
                if (nFilterIsMobileRequest) {
                    if (nFilterInputDisplayElement.value.length <= inputMaxMobileNum) {
                        document.getElementById("nfilter_tmp_editview_num").innerHTML += "&bull;";
                    }
                } else if (nFilterInputDisplayElement.value.length <= inputMaxNum) {
                    document.getElementById("nfilter_tmp_editview_num").innerHTML += "&bull;";
                }
            }
        } else {
            
            inputKeyId = document.getElementById(inputKeyId).getAttribute("nfiltercode");
            if (inputKeyId.indexOf(nFilterKeypadIdDummy) > -1) {
                return true;
            }
            var moneyFormatting = false;
            try {
                
                moneyFormatting = isMoneyFormatting();
            } catch (e) {
            }

            if (moneyFormatting) {
                
                if (nFilterInputDisplayElement.value.charAt(0) == 0) {
                    nFilterInputDisplayElement.value = inputKeyId;
                } else {
                    nFilterInputDisplayElement.value += inputKeyId;
                }
            } else {
                nFilterInputDisplayElement.value += inputKeyId;
            }

            
            nFilterInputDisplayElement.value = planTextToAsterisk(nFilterInputDisplayElement.value);

            if (nFilterIsElementExist("nfilter_tmp_editview")) {
                if (nFilterIsMobileRequest) {
                    var tmpEditviewNumValue = nFilterInputDisplayElement.value;
                    document.getElementById("nfilter_tmp_editview").innerHTML = tmpEditviewNumValue;
                } else if (nFilterInputDisplayElement.value.length <= inputMax) {
                    var tmpEditviewNumValue = nFilterInputDisplayElement.value;
                    document.getElementById("nfilter_tmp_editview").innerHTML = tmpEditviewNumValue;
                }
            }
            if (nFilterIsElementExist("nfilter_tmp_editview_num")) {
                if (nFilterIsMobileRequest) {
                    
                    if (isMoneyFormatting()) {
                        if (nFilterInputDisplayElement.value.charAt(0) == "0" && nFilterInputDisplayElement.value.charAt(1) == "0") {
                            return;
                        } else {
                            nFilterInputDisplayElement.value = currencyComma(nFilterInputDisplayElement.value);
                            var tmpEditviewNumValue = nFilterInputDisplayElement.value;
                            document.getElementById("nfilter_tmp_editview_num").innerHTML = tmpEditviewNumValue;
                        }
                    } else {
                        var tmpEditviewNumValue = nFilterInputDisplayElement.value;
                        document.getElementById("nfilter_tmp_editview_num").innerHTML = tmpEditviewNumValue;
                    }

                } else if (nFilterInputDisplayElement.value.length <= inputMaxNum) {
                    if (isMoneyFormatting()) {
                        if (nFilterInputDisplayElement.value.charAt(0) == "0" && nFilterInputDisplayElement.value.charAt(1) == "0") {
                        } else {
                            nFilterInputDisplayElement.value = currencyComma(nFilterInputDisplayElement.value);
                            var tmpEditviewNumValue = nFilterInputDisplayElement.value;
                            document.getElementById("nfilter_tmp_editview_num").innerHTML = tmpEditviewNumValue;
                        }
                    } else {
                        var tmpEditviewNumValue = nFilterInputDisplayElement.value;
                        document.getElementById("nfilter_tmp_editview_num").innerHTML = tmpEditviewNumValue;
                    }
                }
            }
        }
        

        
        if (nFilterIsKeyShiftNow) {
            if (nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L) {
                if (nFilterIsElementExist(tmpKeypadIdCharU) && nFilterIsElementExist(tmpKeypadIdCharL)) {
                    document.getElementById(tmpKeypadIdCharL).style.display = "none";
                    document.getElementById(tmpKeypadIdCharU).style.display = "block";
                }
            } else {
                if (nFilterIsElementExist(tmpKeypadIdCharL) && nFilterIsElementExist(tmpKeypadIdCharU)) {
                    document.getElementById(tmpKeypadIdCharU).style.display = "none";
                    document.getElementById(tmpKeypadIdCharL).style.display = "block";
                }
            }
            nFilterIsKeyShiftNow = false;
            nfilterKeypadState = nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L;
        }

        var checkElement = nFilterInputDisplayElement.value;

        
        if (typeof nFilterCallback == "function") {
            nFilterCallback(inputKeyId, nFilterInputDisplayElement.id);
        }

        
        if (checkElement.length >= nFilterGetMaxLength(nFilterInputDisplayElement.id)) {
            
            commaNum = 0;

            
            setTimeout(function () {
                if ((nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L) ||
                    (nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U) ||
                    (nfilterKeypadState & nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S)) {
                    if (nFilterIsMobileRequest) {
                        if (nFilterInputDisplayElement.value.length >= nFilterGetMaxLength(nFilterInputDisplayElement.id)) {
                            nFilterClick("nfilter_enter_char_mobile");
                        }
                    } else {
                        if (touchUse && nFilterInputDisplayElement.value.length >= nFilterGetMaxLength(nFilterInputDisplayElement.id)) {
                            return;
                        }
                        nFilterOnKeyClick("nfilter_enter_char");
                    }
                } else {
                    if (nFilterIsMobileRequest) {
                        if (nFilterInputDisplayElement.value.length >= nFilterGetMaxLength(nFilterInputDisplayElement.id)) {
                            nFilterClick("nfilter_enter_num_mobile");
                        }
                    } else {
                        if (touchUse && nFilterInputDisplayElement.value.length >= nFilterGetMaxLength(nFilterInputDisplayElement.id)) {
                            return;
                        }
                        nFilterOnKeyClick("nfilter_enter_num");
                    }
                }
            }, 10);
        }

        
        if (nFilterInputDisplayElement.getAttribute("dType") == "card") {
            nFilterInputDisplayElement.value = cardNumDash(nFilterInputDisplayElement.value);
        } else if (nFilterInputDisplayElement.getAttribute("dType") == "id") {
            nFilterInputDisplayElement.value = idNumDash(nFilterInputDisplayElement.value);
        }
        
    }

    settingKeypadId();

    
    fitKeypadPos('click, for mask');
}


function nFilterCSProcess(targetElementValue, responseElementId) {
    var requestParam = nFilterRequestParamSecretValue + "=" + targetElementValue + "&" + "cs_public_key=" + nFilterCSPublicKey;
    nFilterAsyncRequest(nFilterContextPath + "/" + nFilterServiceNameCSManager, requestParam, function () {
        if (nFilterXmlHttp.readyState == 4 && nFilterXmlHttp.status == 200) {
            if (nFilterResponseErrCdPrefix == nFilterXmlHttp.responseText.substr(0, 8)) {
                if (responseElementId != undefined && responseElementId != "") {
                    if (typeof nFilterExtExceptionCallBack == "function") {
                        nFilterExtExceptionCallBack(nFilterXmlHttp.responseText, responseElementId);
                    }
                } else {
                    document.getElementById("nfilter_document").innerHTML = nFilterXmlHttp.responseText;
                    document.getElementById("nfilter_document").style.display = "block";
                }
            } else {
                try {
                    location.href = nFilterCSReturnURL + "?encdata=" + nFilterXmlHttp.responseText;
                    if (typeof nFilterExtAfterCSForword == "function") {
                        nFilterExtAfterCSForword();
                    }
                } catch (e) {
                    if (responseElementId != "") {
                        if (typeof nFilterExtExceptionCallBack == "function") {
                            nFilterExtExceptionCallBack("ErrCode:120, ErrMsg:CS Module Interface Error", responseElementId);
                        }
                    } else {
                        document.getElementById("nfilter_document").innerHTML = "ErrCode:120, ErrMsg:CS Module Interface Error";
                        document.getElementById("nfilter_document").style.display = "block";
                    }
                }
            }
        }
    });
}


function setNFilterCallBackType(callbackType) {
    nFilterResponseErrCallBackType = callbackType;
}


function setNFilterCSPublicKey(sessionPublicKey) {
    nFilterCSPublicKey = sessionPublicKey;
}


function setNFilterCSReturnURL(csReturnUrl) {
    nFilterCSReturnURL = csReturnUrl;
}


function setNFilterLanguage(requestLanguage) {
    if (requestLanguage != null && requestLanguage != undefined && requestLanguage != "") {
        nFilterLanguage = requestLanguage;
    }
}


function setNFilterLoadingStatusEnable(isEnable) {
    nFilterLoadingStatusEnabled = isEnable;
}


function setNFilterPositionCode(positionCode) {
    nFilterPositionCode = positionCode;
}

function setNFilterEnableNoSecret(isEnable) {
    nFilterEnableNoSecretKeypad = isEnable;
}

function nFilterEncrypted(displayEleementId) {
    var returnSecretValue = "";
    var inputValue = "";
    if (displayEleementId != undefined && displayEleementId != "") {
        var targetElement = document.getElementById(displayEleementId + nFilterKeypadIdTargetSuffix);
        if (targetElement != undefined && targetElement != null) {
            if (nFilterIsEncryptImmediate == true) {
                inputValue = targetElement.value;
            } else {
                if (nFilterIsNoSecretKeypad) {
                    
                    if (nFilterAlgName == "ECDH") {
                        returnSecretValue = nFilterInputEncryptEcdh(nFilterKeypadIdNoSecretPrefix + targetElement.value);
                    } else {
                        returnSecretValue = nFilterInputEncrypt(nFilterKeypadIdNoSecretPrefix + targetElement.value);
                    }
                } else {
                    if (nFilterAlgName == "ECDH") {
                        returnSecretValue = nFilterInputEncryptEcdh(targetElement.value);
                    } else {
                        returnSecretValue = nFilterInputEncrypt(targetElement.value);
                    }
                    
                }
            }
            if (inputValue != "") {
                if (returnSecretValue == "") {
                    returnSecretValue = displayEleementId + "=" + inputValue;
                }
            }
        }
    } else {
        var secElements = document.getElementsByTagName("input");
        for (var i = 0; i < secElements.length; i++) {
            if (secElements[i].type != undefined && secElements[i].type == "hidden" && secElements[i].id != undefined && secElements[i].id.indexOf(nFilterKeypadIdTargetSuffix) > -1) {
                if (secElements[i].value != undefined && secElements[i].value != "") {
                    
                    
                    if (nFilterIsEncryptImmediate == true) {
                        inputValue = secElements[i].value;
                    } else {
                        if (nFilterIsNoSecretKeypad) {
                            
                            if (nFilterAlgName == "ECDH") {
                                inputValue = nFilterInputEncryptEcdh(nFilterKeypadIdNoSecretPrefix + targetElement.value);
                            } else {
                                inputValue = nFilterInputEncrypt(nFilterKeypadIdNoSecretPrefix + targetElement.value);
                            }
                        } else {
                            if (nFilterAlgName == "ECDH") {
                                inputValue = nFilterInputEncryptEcdh(secElements[i].value);
                            } else {
                                inputValue = nFilterInputEncrypt(secElements[i].value);
                            }
                        }
                    }
                } else {
                    inputValue = "";
                }
                if (inputValue != "") {
                    if (returnSecretValue == "") {
                        if (nFilterAlgName == "ECDH") {
                            returnSecretValue = nFilterSecurityPubkey;
                            returnSecretValue += "," + secElements[i].id + "=" + inputValue;
                        } else {
                            returnSecretValue = secElements[i].id + "=" + inputValue;
                        }
                    } else {
                        returnSecretValue += "|" + secElements[i].id + "=" + inputValue;
                    }
                    
                }
            }
        }
        
        

    }
    return returnSecretValue;
}

nFilterMsgKeypadLoading["ko"] = "보안키패드 작동 중";
nFilterMsgKeypadLoading["en"] = "Virtual Keyboard Loading";
nFilterMsgKeypadLoading["ve"] = "Virtual Keyboard Loading";
nFilterMsgKeypadLoading["vn"] = nFilterMsgKeypadLoading["ve"];
nFilterMsgKeypadLoading["ja"] = "Virtual Keyboard Loading";
nFilterMsgMinCheck["ko"] = "[가상키보드] 최소 #1자 이상 입력하셔야합니다.";
nFilterMsgMinCheck["en"] = "[Virtual Keyboard] You must enter at least #1 characters.";
nFilterMsgMinCheck["ve"] = "[Virtual Keyboard] Bạn phải nhập ít nhất #1 ký tự";
nFilterMsgMinCheck["vn"] = nFilterMsgMinCheck["ve"];
nFilterMsgMinCheck["ja"] = "[ソフトウェアキーボード] 最小#1文字以上、入力して下さい。";
nFilterMsgMaxCheck["ko"] = "[가상키보드] 최대 #1자 이하까지 입력하실 수 있습니다.";
nFilterMsgMaxCheck["en"] = "[Virtual Keyboard] You must enter at most #1 characters.";
nFilterMsgMaxCheck["ve"] = "[Virtual Keyboard] Bạn phải nhập lên #1 ký hơn";
nFilterMsgMaxCheck["vn"] = nFilterMsgMaxCheck["ve"];
nFilterMsgMaxCheck["ja"] = "[ソフトウェアキーボード] 最大#1文字以下、入力して下さい。";
var nFilterSubTitle = "Sub Title";



function nFilterExtExceptionCallBack(errorData, responseElementId) {
    nFilterResponseErrorCode = nFilterParseErrorCode(errorData);
    nFilterResponseErrorMessage = nFilterParseErrorMessage(errorData);
    switch (nFilterResponseErrCallBackType) {
        case "alert":
            alert("ErrorCode: " + nFilterResponseErrorCode + "\n" + "ErrorMessage: " + nFilterResponseErrorMessage);
            break;
        case "display":
            if (responseElementId != "") {
                document.getElementById(responseElementId).value = errorData;
                document.getElementById(responseElementId).style.display = "block";
                document.getElementById(responseElementId).style.visibility = "visible";
            } else {
                document.getElementById("nfilter_document").innerHTML = errorData;
                document.getElementById("nfilter_document").style.display = "block";
                document.getElementById("nfilter_document").style.visibility = "visible";
            }
            break;
        case "status":
            window.defaultStatus = errorData;
            break;
        case "customizing":
            if (typeof alertNFilter == "function") {
                alertNFilter();
            } else {
                setTimeout(function () {
                    alert(nFilterResponseErrorCode);
                }, 0);
            }
            break;
        default:
            document.getElementById("nfilter_document").innerHTML = errorData;
            document.getElementById("nfilter_document").style.display = "block";
            document.getElementById("nfilter_document").style.visibility = "visible";
            break;
    }
}


function nFilterExtMessageHandler(message) {
    switch (nFilterResponseErrCallBackType) {
        case "alert":
            setTimeout(function () {
                alert(message);
            }, 0);
            break;
        case "display":
            setTimeout(function () {
                alert(message);
            }, 0);
            break;
        case "status":
            window.defaultStatus = message;
            break;
        case "customizing":
            if (typeof alertNFilter == "function") {
                alertNFilter();
            } else {
                setTimeout(function () {
                    alert(message);
                }, 0);
            }
            break;
        default:
            if (nFilterOSInfo == "iPhone" && nFilterOSInfo == 'iPod' && nFilterOSInfo == "iPad") {
                setTimeout(function () {
                    alert(message);
                }, 0);
            } else {
                alert(message);
            }
            break;
    }
}


function nFilterExtRegistEventOnKeyDownUp() {
    document.onkeydown = function (e) {
        if (window.event) {
            keyCode = window.event.keyCode;
        } else if (e) {
            keyCode = e.which;
        }
        if (keyCode == 27) {
            if (nFilterEscClick == true) {
                nFilterClose();
            }
        }
        return true;
    };
    document.onkeyup = function (e) {
        if (window.event) {
            keyCode = window.event.keyCode;
        } else if (e) {
            keyCode = e.which;
        }
        if (keyCode == 27) {
            if (nFilterEscClick == true) {
                nFilterClose();
            }
        }
        return true;
    };
}

var NFILTERSET = 2;
var nFilterOff = 0;
var nFilterDefault = 1;
var nFilterDefaultClose = 2;
var nFilterDefaultDirect = 3;
var nFilterDefaultDirectButton = 4;
var nFilterDefaultButtonOrDirect = 5;
var nFilterDirectButton = 6;
var nFilterButton = 7;
var nFilterBtnDefOnly = 8;
var nFilterExtKeypadTypeInitBinary = "";
var nFilterExtDisplayElementId = "";
var nFilterExtOption = "";


function setNFilterCommon(obj, strAttribute) {

    
    
    setNFilter(obj.id, "minlengths=" + obj.getAttribute("minlengths") + ",maxlengths=" + obj.getAttribute("maxlength") + ",nfilter=on,padType=type1,keyType=type1," + strAttribute);
}


var nFilterTypeArray = new Array;
var nFilterTypeString = "";

function setNFilter(id, strAttribute) {
    nFilterExtDisplayElementId = id;
    if (!nFilterIsElementExist(id, document)) {
        return false;
    }
    NFILTERSET = 2;
    var input = document.getElementById(id);
    var ary = strAttribute.split(",");
    if (input != null && input != "undefined") {
        var keypadShowTypeBinary = "";
        var keypadIdType = "";
        for (var i = 0; i < ary.length; i++) {

            
            var typeCheck = false;
            if (input.type == "password") {
                typeCheck = true;
            } else {
                typeCheck = false;
            }

            keypadIdType = input.id + "&" + typeCheck + "|";
            var tmp = ary[i];
            var name = tmp.substr(0, tmp.indexOf("="));
            var value = tmp.substr(ary[i].indexOf("=") + 1);

            input.setAttribute(name, value);
            input.blur();
            input.setAttribute("directkey", "off");
            input.readOnly = true;

            var currentKeypadTypeInt = 0;
            if (nFilterExtKeypadTypeInitBinary != "") {
                currentKeypadTypeInt = parseInt(nFilterExtKeypadTypeInitBinary, 2);
            }

            if (name == "mode") {
                if (value == "number" || value == "num") {
                    keypadShowTypeBinary = "1000";
                    nFilterKeypadType = parseInt(keypadShowTypeBinary.toString, 2);

                    
                    if (nFilterIsMaskMatch(currentKeypadTypeInt, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_L) ||
                        nFilterIsMaskMatch(currentKeypadTypeInt, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_U) ||
                        nFilterIsMaskMatch(currentKeypadTypeInt, nfilterEnumObj.KEYPAD_TYPE_MASK.CHAR_S)) {
                        nFilterExtKeypadTypeInitBinary = "1111";
                        nFilterKeypadType = parseInt(nFilterExtKeypadTypeInitBinary, 2);
                    } else {
                        nFilterExtKeypadTypeInitBinary = "1000";
                        nFilterKeypadType = parseInt(nFilterExtKeypadTypeInitBinary, 2);
                    }
                } else {
                    keypadShowTypeBinary = "0111";
                    nFilterKeypadType = parseInt(keypadShowTypeBinary.toString, 2);
                    if (nFilterIsMaskMatch(currentKeypadTypeInt, nfilterEnumObj.KEYPAD_TYPE_MASK.NUM)) {
                        nFilterExtKeypadTypeInitBinary = "1111";
                        nFilterKeypadType = parseInt(nFilterExtKeypadTypeInitBinary, 2);
                    } else {
                        nFilterExtKeypadTypeInitBinary = "0111";
                        nFilterKeypadType = parseInt(nFilterExtKeypadTypeInitBinary, 2);
                    }
                }
            }
            if (name == "lang") {
                if (value == "ko" || value == "en" || value == "ve" || value == "vn" || value == "ja") {
                    setNFilterLanguage(value);
                }
            }
        }

        input.onclick = function () {
            var inputKey = document.getElementsByTagName("input");
            for (i = 0; i < inputKey.length; i++) {
                if (inputKey[i].getAttribute("nfilter") == "on") {
                    if (nFilterSecElement == "") {
                        nFilterClose2(inputKey[i]);
                    } else {
                        if (nFilterIsNoSecretKeypad) {
                            if (nFilterAlgName == "ECDH") {
                                nFilterInputTargetElement.value = nFilterInputEncryptEcdh(nFilterKeypadIdNoSecretPrefix + nFilterSecElement);
                            } else {
                                nFilterInputTargetElement.value = nFilterInputEncrypt(nFilterKeypadIdNoSecretPrefix + nFilterSecElement);
                            }
                        } else {
                            if (nFilterAlgName == "ECDH") {
                                nFilterInputTargetElement.value = nFilterInputEncryptEcdh(nFilterSecElement);
                            } else {
                                nFilterInputTargetElement.value = nFilterInputEncrypt(nFilterSecElement);
                            }
                        }
                        for (j = 0; j < inputKey.length; j++) {
                            if (inputKey[j].getAttribute("nfilter") == "on") {
                                inputKey[j].removeAttribute("disabled");
                            }
                        }
                    }
                    setNFilterHiddenFieldId(id);
                    nFilterKeypadShowExt(keypadShowTypeBinary, nFilterHiddenFieldId, id);

                    
                    if (nfilterBtLocation == true && nFilterNumType == 2) {
                        setNFilterKeypadBottom(input);
                    }

                    
                    if (getNFilterOSInfo() == "Android" || getNFilterOSInfo() == "iPad" || getNFilterOSInfo() == "iPhone" || getNFilterOSInfo() == "iPod") {
                        touchUse = true;
                    }
                    break;
                }
            }
        };

        
        input.onfocus = function () {
            
            var inputKey = document.getElementsByTagName("input");
            for (i = 0; i < inputKey.length; i++) {
                if (inputKey[i].getAttribute("nfilter") == "on") {
                    if (nFilterSecElement == "") {
                        nFilterClose2(inputKey[i]);
                    } else {
                        if (nFilterIsNoSecretKeypad) {
                            if (nFilterAlgName == "ECDH") {
                                nFilterInputTargetElement.value = nFilterInputEncryptEcdh(nFilterKeypadIdNoSecretPrefix + nFilterSecElement);
                            } else {
                                nFilterInputTargetElement.value = nFilterInputEncrypt(nFilterKeypadIdNoSecretPrefix + nFilterSecElement);
                            }
                        } else {
                            if (nFilterAlgName == "ECDH") {
                                nFilterInputTargetElement.value = nFilterInputEncryptEcdh(nFilterSecElement);
                            } else {
                                nFilterInputTargetElement.value = nFilterInputEncrypt(nFilterSecElement);
                            }
                        }
                        for (j = 0; j < inputKey.length; j++) {
                            if (inputKey[j].getAttribute("nfilter") == "on") {
                                inputKey[j].removeAttribute("disabled");
                            }
                        }
                    }
                    setNFilterHiddenFieldId(id);
                    nFilterKeypadShowExt(keypadShowTypeBinary, nFilterHiddenFieldId, id);

                    
                    if (nfilterBtLocation == true && nFilterNumType == 2) {
                        setNFilterKeypadBottom(input);
                    }

                    
                    if (getNFilterOSInfo() == "Android" || getNFilterOSInfo() == "iPad" || getNFilterOSInfo() == "iPhone" || getNFilterOSInfo() == "iPod") {
                        touchUse = true;
                    }
                    break;
                }
            }
        };

        
        if (!nFilterIsElementExist(id + "_nfilter_sec")) {
            var inputTargetElement = document.createElement("input");
            inputTargetElement.setAttribute("type", "hidden");

            
            var decArea = document.getElementById(id).getAttribute("decarea");
            
            if (decArea != undefined && NFILTERSET != null) {
                inputTargetElement.setAttribute("id", id + "_nfilter_sec_" + decArea);
                inputTargetElement.setAttribute("name", id + "_nfilter_sec_" + decArea);
            } else {
                inputTargetElement.setAttribute("id", id + "_nfilter_sec");
                inputTargetElement.setAttribute("name", id + "_nfilter_sec");
            }
        }
    }

    
    nFilterTypeString += keypadIdType;
    nFilterTypeArray = nFilterTypeString.split("|");

    setNFilterHiddenFieldId(id);
}


function setNFilterMobileInit() {
    nFilterExtRegistEventOnKeyDownUp();
    var extCss = document.createElement("link");
    extCss.setAttribute("rel", "stylesheet");
    extCss.setAttribute("type", "text/css");
    extCss.setAttribute("id", "open_nFilter_css");
    extCss.setAttribute("href", nFilterCSSMobilePath + "open_nFilter_mobile.css");
    var headNode = document.getElementsByTagName("head")[0];
    headNode.appendChild(extCss);

    
    setNFilterInitState();
    
    
    nFilterKeypadInitMobile(parseInt(nFilterExtKeypadTypeInitBinary, 2), setInitState, false, nFilterHiddenFieldId, nFilterExtDisplayElementId, "");
}


function setNFilterInit() {
    nFilterExtRegistEventOnKeyDownUp();
    var extCss = document.createElement("link");
    extCss.setAttribute("rel", "stylesheet");
    extCss.setAttribute("type", "text/css");
    extCss.setAttribute("id", "open_nFilter_css");
    extCss.setAttribute("href", nFilterCSSPath + "open_nFilter.css");
    var headNode = document.getElementsByTagName("head")[0];
    headNode.appendChild(extCss);

    
    
    nFilterKeypadInit(parseInt(nFilterExtKeypadTypeInitBinary, 2), true, false, nFilterHiddenFieldId, nFilterExtDisplayElementId, "");
}

var moneyFormatting = new Array();


function setNFilterMoneyFormatting(args) {
    moneyFormatting = args.split('|');
}


function isMoneyFormatting() {
    if (moneyFormatting.length > 0) {
        for (var int = 0; int < moneyFormatting.length; int++) {
            if (moneyFormatting[int] == nFilterInputDisplayElement.id) {
                return true;
            }
        }
    } else {
        return false;
    }
}


function currencyComma(val) {
    var num = val.replace(/,/g, "");
    var num_str = num.toString();
    var result = '';
    for (var i = 0; i < num_str.length; i++) {
        var tmp = num_str.length - (i + 1);
        if (i % 3 == 0 && i != 0) result = ',' + result;
        result = num_str.charAt(tmp) + result;
    }
    return result;
}

var nFilterClassActiveState;
var nFilterClassActiveBackgroundArray;


function nFilterClassActiveBackground(backgroundColor) {
    nFilterClassActiveState = true;
    nFilterClassActiveBackgroundArray = backgroundColor.split("&");
}


function nFilterClassActive(info) {
    
    
    var classBackgroundInfo;
    for (var int = 0; int < nFilterClassActiveBackgroundArray.length; int++) {
        
        if (nFilterClassActiveBackgroundArray[int].indexOf(info) != -1)
        
            classBackgroundInfo = nFilterClassActiveBackgroundArray[int].split("|");
    }

    
    if (classBackgroundInfo != undefined) {
        
        var object = document.getElementById(classBackgroundInfo[0]);
        
        object.style.background = classBackgroundInfo[1];
        
        window.setTimeout(function () {
            object.style.background = classBackgroundInfo[2];
        }, 120);
    }
}


function nFilterExtAfterCSForword() {
}

var isFinishInit = false;

function IsFinishInit() {
    return isFinishInit;
}



function OnInitStart() {
    
    console.log("IsFinishInit >> " + IsFinishInit());
}


function OnInitFinished() {
    
    console.log("IsFinishInit >> " + IsFinishInit());
    
    if (finiahedCallback != null) {
        finiahedCallback();
    }
}




var inputTime = 300;

function setNFilterInputTime(time) {
    inputTime = time;
}




var nFilterJSPublicKey = "";

function setNFilterJSPublicKey(nFilterSeverPublicKey) {
    nFilterJSPublicKey = nFilterSeverPublicKey;
}




function setNFilterJSReturnURL(jsReturnUrl) {
    nFilterJSReturnURL = jsReturnUrl;
}




var nFilterJsEncData = "";
var nFilterSPubKey = "";
var nFilterSecretKey = "";

function nFilterJSProcess(targetElementValue, responseElementId) {
    var requestParam = nFilterRequestParamSecretValue + "=" + targetElementValue + "&" + "js_public_key=" + nFilterJSPublicKey;
    nFilterAsyncRequest(nFilterContextPath + "/" + nFilterServiceNameJSManager, requestParam, function () {
        if (nFilterXmlHttp.readyState == 4 && nFilterXmlHttp.status == 200) {
            if (nFilterResponseErrCdPrefix == nFilterXmlHttp.responseText.substr(0, 8)) {
                if (responseElementId != undefined && responseElementId != "") {
                    if (typeof nFilterExtExceptionCallBack == "function") {
                        nFilterExtExceptionCallBack(nFilterXmlHttp.responseText, responseElementId);
                    }
                } else {
                    document.getElementById("nfilter_document").innerHTML = nFilterXmlHttp.responseText;
                    document.getElementById("nfilter_document").style.display = "block";
                }
            } else {
                try {
                    
                    var nFilterOriginData = nFilterXmlHttp.responseText;
                    nFilterOriginData = nFilterOriginData.split('|');
                    nFilterSPubKey = nFilterOriginData[0];
                    nFilterJsEncData = nFilterOriginData[1];
                    
                    var prikey = keyPair.getPriKey();

                    
                    var sPKey = Base642HexStr(nFilterSPubKey);
                    

                    
                    nFilterSecretKey = DeriveECKey("secp256r1", prikey, sPKey);
                    if (nFilterJSReturnURL == "" || nFilterJSReturnURL == null) {
                        try {
                            nFilterJSresult = HexStr2Utf8(SEEDDecrypt(nSaferJS.mode.CFB, '00000000000000000000000000000000', nFilterSecretKey, nFilterJsEncData));
                        } catch (e) {
                            if (nFilterJSresult == "") {
                                nFilterExtExceptionCallBack("ErrCode:120, ErrMsg:JS Module Interface Error", responseElementId);
                            }
                        }
                        if (typeof nFilterJSdecryptResult == "function") {
                            nFilterJSdecryptResult();
                        }
                    } else {
                        location.href = nFilterJSReturnURL + "?encData=" + nFilterJsEncData + "&nFilterKey=" + nFilterSecretKey;
                    }
                } catch (e) {
                    if (nFilterSPubKey.indexOf("java.lang.ArrayIndexOutOfBoundsException") != 1) {
                        
                    } else {
                        if (responseElementId != "") {
                            if (typeof nFilterExtExceptionCallBack == "function") {
                                nFilterExtExceptionCallBack("ErrCode:120, ErrMsg:JS Module Interface Error", responseElementId);
                            }
                        } else {
                            document.getElementById("nfilter_document").innerHTML = "ErrCode:120, ErrMsg:JS Module Interface Error";
                            document.getElementById("nfilter_document").style.display = "block";
                        }
                    }
                }
            }
        }
    });
}




var setInitState = true;

function setNFilterInitState() {
    if (nFilterJSPublicKey != "") {
        setInitState = false;
    }
}




function setNFilterHiddenFieldId(id) {
    var decArea = document.getElementById(id).getAttribute("decarea");
    if (decArea != undefined && NFILTERSET != null) {
        nFilterHiddenFieldId = id + "_nfilter_sec_" + decArea;
    } else {
        nFilterHiddenFieldId = id + "_nfilter_sec";
    }
}




function setFinancialEcdhPublicKey(key) {
    nFilterFinancialEcdhPublicKey = key;
}




function removeAllKeypad() {
    var inputKey = document.getElementsByTagName("input");
    for (i = 0; i < inputKey.length; i++) {
        if (inputKey[i].getAttribute("nfilter") == "on") {
            if (inputKey[i].getAttribute("decarea") != null) {
                inputKey[i].removeAttribute("decarea");
            }
            nFilterCheckBoxClose(inputKey[i].getAttribute("id"));
            inputKey[i].parentNode.removeChild(inputKey[i].nextSibling);
        }
    }
}




function removeKeypad(elementId) {
    var inputKey = document.getElementById(elementId);
    if (inputKey.getAttribute("nfilter") == "on") {
        if (inputKey.getAttribute("decarea") != null) {
            inputKey.removeAttribute("decarea");
        }
        nFilterCheckBoxClose(elementId);
        inputKey.parentNode.removeChild(inputKey.nextSibling);
    }
}




function nFilterBottomLocation(check) {
    nfilterBtLocation = check;
}

function setNFilterKeypadBottom(inputId) {
    var nowScroll = nFilterGetNowScroll();
    var diviceHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
    var keypadHeight = "";
    if (nFilterIsElementExist("nfilter_char")) var charKeypadStatus = document.getElementById('nfilter_char').style.display;
    if (nFilterIsElementExist("nfilter_num")) var numKeypadStatus = document.getElementById('nfilter_num').style.display;

    
    if (nFilterNumType == 2) {
        if (getNFilterOSInfo() == "Android" || getNFilterOSInfo() == "iPad" || getNFilterOSInfo() == "iPhone" || getNFilterOSInfo() == "iPod") {
            switch (nFilterScreenSize) {
                case 320:
                    if (inputId.getAttribute("mode") == "qwerty" && inputId.getAttribute("disabled") == "disabled") {
                        keypadHeight = 248;
                    } else {
                        keypadHeight = 194;
                    }
                    break;
                case 360:
                    if (inputId.getAttribute("mode") == "qwerty" && inputId.getAttribute("disabled") == "disabled") {
                        keypadHeight = 259;
                    } else {
                        keypadHeight = 218;
                    }
                    break;
                case 400:
                    if (inputId.getAttribute("mode") == "qwerty" && inputId.getAttribute("disabled") == "disabled") {
                        keypadHeight = 269;
                    } else {
                        keypadHeight = 242;
                    }
                    break;
                case 620:
                    if (inputId.getAttribute("mode") == "qwerty" && inputId.getAttribute("disabled") == "disabled") {
                        keypadHeight = 467;
                    } else {
                        keypadHeight = 375;
                    }
                    break;
            }
            var gap = diviceHeight - keypadHeight;
            nFilterMain.style.top = (gap + nowScroll.Y) + "px";
        } else {
            switch (nFilterScreenSize) {
                case 320:
                    if (inputId.getAttribute("mode") == "qwerty" && inputId.getAttribute("disabled") == "disabled") {
                        if (getNFilterBrowerInfo() == "Firefox") {
                            keypadHeight = 251;
                        } else {
                            keypadHeight = 250;
                        }
                    } else {
                        keypadHeight = 195;
                    }
                    var gap = diviceHeight - keypadHeight;
                    nFilterMain.style.top = gap + nowScroll.Y + "px";
                    break;
                case 360:
                    if (inputId.getAttribute("mode") == "qwerty" && inputId.getAttribute("disabled") == "disabled") {
                        if (getNFilterBrowerInfo() == "Firefox") {
                            keypadHeight = 262;
                        } else {
                            keypadHeight = 261;
                        }
                    } else {
                        keypadHeight = 218;
                    }
                    var gap = diviceHeight - keypadHeight;
                    nFilterMain.style.top = gap + nowScroll.Y + "px";
                    break;
                case 400:
                    if (inputId.getAttribute("mode") == "qwerty" && inputId.getAttribute("disabled") == "disabled") {
                        if (getNFilterBrowerInfo() == "Firefox") {
                            keypadHeight = 262;
                        } else {
                            keypadHeight = 271;
                        }
                    } else {
                        keypadHeight = 241;
                    }
                    var gap = diviceHeight - keypadHeight;
                    nFilterMain.style.top = gap + nowScroll.Y + "px";
                    break;
                case 620:
                    if (inputId.getAttribute("mode") == "qwerty" && inputId.getAttribute("disabled") == "disabled") {
                        if (getNFilterBrowerInfo() == "Firefox") {
                            keypadHeight = 470;
                        } else {
                            keypadHeight = 469;
                        }
                    } else {
                        keypadHeight = 376;
                    }
                    var gap = diviceHeight - keypadHeight;
                    nFilterMain.style.top = gap + nowScroll.Y + "px";
                    break;
            }
        }
    }
}




window.addEventListener("orientationchange", function () {
    onorientationchangeStyle();
});




function setFinishiedCallback(callback) {
    finiahedCallback = callback;
}




function hasCookies() {
    return (navigator.cookieEnabled);
}




function nFilterSessionCheckOn(url) {
    nFilterSessionCheck = true;
    if(url != undefined || url != null) {
        nFilterSessionCheckUrl = url;
    }
}




function cardNumDash(val) {
    var num = val.replace(/-/g, "");
    var num_str = num.toString();
    var result = '';
    for (var i = 0; i < num_str.length; i++) {
        var tmp = i;
        if (i % 4 == 0 && i != 0) result = result + '-';
        result = result + num_str.charAt(tmp);
    }
    return result;
}




function idNumDash(val) {
    var num = val.replace(/-/g, "");
    var num_str = num.toString();
    if (num_str.length <= 7) {
        var result = '';
        for (var i = 0; i < num_str.length; i++) {
            var tmp = i;
            if (i % 6 == 0 && i != 0) result = result + '-';
            result = result + num_str.charAt(tmp);
        }
        return result;
    } else {
        return val;
    }
}




function planTextToAsterisk(value) {
    var ptToAste = new Array;
    ptToAste = value;
    try {
        for (var i = ptToAste.length - 1; i < ptToAste.length; i++) {
            if (nFilterInputDisplayElement.getAttribute("dType") == "id" && 6 <= i) {
                var pattern = /.$/;
                var aste = ptToAste[i].replace(pattern, "*");
                ptToAste = ptToAste.substring(0, i) + aste;
            } else if (nFilterInputDisplayElement.getAttribute("dType") == "card" && 9 <= i && i <= 13) {
                var pattern = /.$/;
                var aste = ptToAste[i].replace(pattern, "*");
                ptToAste = ptToAste.substring(0, i) + aste;
            } else if (nFilterInputDisplayElement.getAttribute("dType") == "cvc") {
                var pattern = /.$/;
                var aste = ptToAste[i].replace(pattern, "*");
                ptToAste = ptToAste.substring(0, i) + aste;
            } else if (nFilterInputDisplayElement.getAttribute("dType") == "pw") {
                var pattern = /.$/;
                var aste = ptToAste[i].replace(pattern, "*");
                ptToAste = ptToAste.substring(0, i) + aste;
            }
        }
    } catch (e) {
        e.preventDefault();
    }
    return ptToAste;
}




function setnFilterChangeKey() {
    var changeKey = document.getElementsByTagName("button");
    for (i = 0; i < changeKey.length; i++) {
        if (changeKey[i].getAttribute("class") == "nfilter_keypad_button") {
            var key = changeKey[i].getAttribute("aria-label");
            if (key.indexOf("$nfilter_") != -1) {
                key = key.replace("$nfilter_", "");
                key = key.replace(";", "");
                changeKey[i].setAttribute("aria-label", key);
            }
            if (key.indexOf("!") != -1) {
                changeKey[i].setAttribute("aria-label", "느낌표");
            }
            if (key.indexOf("@") != -1) {
                changeKey[i].setAttribute("aria-label", "골뱅이");
            }
            if (key.indexOf("$") != -1) {
                changeKey[i].setAttribute("aria-label", "달러");
            }
            if (key.indexOf("^") != -1) {
                changeKey[i].setAttribute("aria-label", "위꺽새");
            }
            if (key.indexOf("*") != -1) {
                changeKey[i].setAttribute("aria-label", "별");
            }
            if (key.indexOf("(") != -1) {
                changeKey[i].setAttribute("aria-label", "여는괄호");
            }
            if (key.indexOf(")") != -1) {
                changeKey[i].setAttribute("aria-label", "닫는괄호");
            }
            if (key.indexOf("-") != -1) {
                changeKey[i].setAttribute("aria-label", "빼기");
            }
            if (key.indexOf("=") != -1) {
                changeKey[i].setAttribute("aria-label", "는");
            }
            if (key.indexOf("+") != -1) {
                changeKey[i].setAttribute("aria-label", "플러스");
            }
            if (key.indexOf("{") != -1) {
                changeKey[i].setAttribute("aria-label", "여는중괄호");
            }
            if (key.indexOf("}") != -1) {
                changeKey[i].setAttribute("aria-label", "닫는중괄호");
            }
            if (key.indexOf("[") != -1) {
                changeKey[i].setAttribute("aria-label", "여는대괄호");
            }
            if (key.indexOf("]") != -1) {
                changeKey[i].setAttribute("aria-label", "닫는대괄호");
            }
            if (key.indexOf(":") != -1) {
                changeKey[i].setAttribute("aria-label", "콜론");
            }
            if (key.indexOf(";") != -1) {
                changeKey[i].setAttribute("aria-label", "세미콜론");
            }
            if (key.indexOf("<") != -1) {
                changeKey[i].setAttribute("aria-label", "여는꺽쇠괄호");
            }
            if (key.indexOf(">") != -1) {
                changeKey[i].setAttribute("aria-label", "닫는꺽쇠괄호");
            }
            if (key.indexOf(",") != -1) {
                changeKey[i].setAttribute("aria-label", "쉼표");
            }
            if (key.indexOf(".") != -1) {
                changeKey[i].setAttribute("aria-label", "마침표");
            }
            if (key.indexOf("/") != -1) {
                changeKey[i].setAttribute("aria-label", "슬래쉬");
            }
            if (key.indexOf("?") != -1) {
                changeKey[i].setAttribute("aria-label", "물음표");
            }
            if (key.indexOf("|") != -1) {
                changeKey[i].setAttribute("aria-label", "수직막대");
            }
            if (key.indexOf("~") != -1) {
                changeKey[i].setAttribute("aria-label", "물결");
            }
            if (key.indexOf("_") != -1) {
                changeKey[i].setAttribute("aria-label", "언더바");
            }
            if (key.indexOf("`") != -1) {
                changeKey[i].setAttribute("aria-label", "억음부호");
            }
            if (key.indexOf("apos") != -1) {
                changeKey[i].setAttribute("aria-label", "쌍따옴표");
            }
            if (key.indexOf("quot") != -1) {
                changeKey[i].setAttribute("aria-label", "홑따옴표");
            }
        }
    }
    for (i = 0; i < changeKey.length; i++) {
        if (changeKey[i].getAttribute("class") == "nfilter_keypad_button") {
            var key = changeKey[i].getAttribute("aria-label");
            if (key.indexOf("소문자1") != -1) {
                changeKey[i].setAttribute("aria-label", "1");
            }
            if (key.indexOf("소문자2") != -1) {
                changeKey[i].setAttribute("aria-label", "2");
            }
            if (key.indexOf("소문자3") != -1) {
                changeKey[i].setAttribute("aria-label", "3");
            }
            if (key.indexOf("소문자4") != -1) {
                changeKey[i].setAttribute("aria-label", "4");
            }
            if (key.indexOf("소문자5") != -1) {
                changeKey[i].setAttribute("aria-label", "5");
            }
            if (key.indexOf("소문자6") != -1) {
                changeKey[i].setAttribute("aria-label", "6");
            }
            if (key.indexOf("소문자7") != -1) {
                changeKey[i].setAttribute("aria-label", "7");
            }
            if (key.indexOf("소문자8") != -1) {
                changeKey[i].setAttribute("aria-label", "8");
            }
            if (key.indexOf("소문자9") != -1) {
                changeKey[i].setAttribute("aria-label", "9");
            }
            if (key.indexOf("소문자0") != -1) {
                changeKey[i].setAttribute("aria-label", "0");
            }
            if (key.indexOf("대문자1") != -1) {
                changeKey[i].setAttribute("aria-label", "1");
            }
            if (key.indexOf("대문자2") != -1) {
                changeKey[i].setAttribute("aria-label", "2");
            }
            if (key.indexOf("대문자3") != -1) {
                changeKey[i].setAttribute("aria-label", "3");
            }
            if (key.indexOf("대문자4") != -1) {
                changeKey[i].setAttribute("aria-label", "4");
            }
            if (key.indexOf("대문자5") != -1) {
                changeKey[i].setAttribute("aria-label", "5");
            }
            if (key.indexOf("대문자6") != -1) {
                changeKey[i].setAttribute("aria-label", "6");
            }
            if (key.indexOf("대문자7") != -1) {
                changeKey[i].setAttribute("aria-label", "7");
            }
            if (key.indexOf("대문자8") != -1) {
                changeKey[i].setAttribute("aria-label", "8");
            }
            if (key.indexOf("대문자9") != -1) {
                changeKey[i].setAttribute("aria-label", "9");
            }
            if (key.indexOf("대문자0") != -1) {
                changeKey[i].setAttribute("aria-label", "0");
            }
        }
    }
    for (i = 0; i < changeKey.length; i++) {
        if (changeKey[i].getAttribute("class") == "nfilter_keypad_button") {
            var key = changeKey[i].getAttribute("aria-label");
            if (key.indexOf(" ") != -1) {
                changeKey[i].setAttribute("aria-label", "공백");
            }
            if (key.indexOf("dummy") != -1) {
                changeKey[i].removeAttribute("aria-label");
                changeKey[i].setAttribute("aria-hidden", true);
            }
            var sShift = changeKey[i].getAttribute("id");
            if (sShift.indexOf("nfilter_shift_s") != -1) {
                changeKey[i].removeAttribute("aria-label");
                changeKey[i].setAttribute("aria-hidden", true);
            }
        }
    }
}

