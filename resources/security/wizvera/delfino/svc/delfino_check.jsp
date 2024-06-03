<%-- --------------------------------------------------------------------------
 - File Name   : delfino_check.jsp
 - Include     : delfino.jsp
 - Author      : WIZVERA
 - Last Update : 2021/02/24
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
    String action = "delfino_checkResult.jsp";
%>
<%!
    public static String getParameter(HttpServletRequest request, String name) {
        String sValid = request.getParameter(name);
        if (sValid == null || sValid.equals("")) return sValid;
        sValid = sValid.replace("&", "&amp;");
        sValid = sValid.replace("<", "&lt;");
        sValid = sValid.replace(">", "&gt;");
        sValid = sValid.replace("\"", "&qout;");
        sValid = sValid.replace("\'", "&#039;");
        return sValid;
    }
%>
<%
    if ("on".equals(getParameter(request, "mobile"))) {
        session.setAttribute("delfino_mobile_demo", "on");
        response.sendRedirect(request.getRequestURI());
        return;
    } else if ("off".equals(getParameter(request, "mobile"))) {
        session.removeAttribute("delfino_mobile_demo");
        response.sendRedirect(request.getRequestURI());
        return;
    }
%>
<%
    String systemMode = "real";
    String systemLang = "KOR";
    String siteName = "delfino";
    {
        String imsi = getParameter(request, "systemMode");
        if ("test".equals(imsi)) systemMode = "test";

        imsi = getParameter(request, "systemLang");
        if (imsi != null && !"".equals(imsi) ) systemLang = imsi;
    }
%>
<%
    String rIP = request.getHeader("X-Forwarded-For");
    if (rIP==null || rIP.length()==0 || "unknown".equalsIgnoreCase(rIP)) rIP = request.getHeader("Proxy-Client-IP");
    if (rIP==null || rIP.length()==0 || "unknown".equalsIgnoreCase(rIP)) rIP = request.getHeader("WL-Proxy-Client-IP");
    if (rIP==null || rIP.length()==0 || "unknown".equalsIgnoreCase(rIP)) rIP = request.getHeader("HTTP_CLIENT_IP");
    if (rIP==null || rIP.length()==0 || "unknown".equalsIgnoreCase(rIP)) rIP = request.getHeader("HTTP_X_FORWARDED_FOR");
    if (rIP==null || rIP.length()==0 || "unknown".equalsIgnoreCase(rIP)) rIP = request.getRemoteAddr();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Progma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <!-- meta http-equiv="X-UA-Compatible" content="requiresActiveX=true" / -->
<%
    String ieMode = request.getParameter("ieMode");
    if (ieMode == null || "".equals(ieMode)) {
        out.println("    <meta http-equiv=\"X-UA-Compatible\" content=\"requiresActiveX=true\" />");
    } else {
        out.println("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=" + ieMode + "\" />");
    }
%>
<%
    if ("on".equals(session.getAttribute("delfino_mobile_demo"))) {
        out.println("    <meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width' />");
    }
%>

<% if ("test".equals(getParameter(request, "openCert")) || "real".equals(getParameter(request, "openCert"))) {
    String url = "https://www.yessign.or.kr:3300";
    if ("test".equals(getParameter(request, "openCert"))) url = "https://fidoweb.yessign.or.kr:3300";
    String relayUrl = url + "/certrelay/certrelay.jsp";
    String demoUrl = url + "/wizvera/delfino/demo/";
    out.println("    <title>브라우저 인증서 이동/복사: " + getParameter(request, "openCert") + "</title>");
    out.println("</head>\n");
    out.println("<body onload='this.focus();'>");
    out.println("    <h2>브라우저 인증서 이동/복사 <font size=2>[" + url + "] <a href='" + demoUrl + "' target='openCert'>데모</a> <a href='javascript:window.close();'>닫기</a></font></h2>");
    out.println("    <iframe name='openCert' src='" + relayUrl + "' title='브라우저인증서 이동/복사' width='800px' height='700px' scrolling='yes' frameborder='1' marginheight='0' marginwidth='0'></iframe>");
    out.println("</body></html>");
    return;
} %>

    <title>::: Welcome to Wizvera ::: 전자서명테스트</title>

<% if ("on".equals(session.getAttribute("delfino_mobile_demo"))) { %>
    <style type="text/css">
    body        {font-family:'dotum'; font-size:10pt;}
    td          {font-size:9pt;}
    textarea    {width:260px; height:40px; font-size:9pt;}
    table.body  {width: 350px;}
    td.head     {background-color: #EDF8F8; text-align: center; display:none;}
    td.body     {background-color: #FFFFFF; text-align: center;}
    td.body_l   {background-color: #FFFFFF; text-align: left; line-height:150%}
    td.body_r   {background-color: #FFFFFF; text-align: right;}
    </style>
<% } else { %>
    <style type="text/css">
    body        {font-family:'dotum'; font-size:10pt;}
    td          {font-size:9pt;}
    textarea    {width:410px; height:40px; font-size:9pt;}
    table.body  {width: 640px;}
    td.head     {background-color: #EDF8F8; text-align: center;}
    td.body     {background-color: #FFFFFF; text-align: center;}
    td.body_l   {background-color: #FFFFFF; text-align: left; line-height:150%}
    td.body_r   {background-color: #FFFFFF; text-align: right;}
    </style>
<% } %>


    <script type="text/javascript">
    //<![CDATA[
        var _SITE_SystemMode = "<%=systemMode%>"; //"real", "test"
        var _SITE_SystemLang = "<%=systemLang%>"; //"KOR", "ENG", "CHN", "JPN"
        var _SITE_SiteName = "<%=siteName%>";     //"pc", "mobile", "tablet"
    //]]>
    </script>

    <% long _delfinoNoCache = System.currentTimeMillis(); %>
    <script src="../jquery/jquery-1.6.4.min.js" charset="utf-8"></script>
    <script src="../delfino_config.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
    <script src="../delfino_internal.min.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
    <script src="../delfino.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
    <script src="../delfino_site.js?<%=_delfinoNoCache%>" charset="utf-8"></script>

    <!--
    <script src="../../certgate/certgate_config.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
    <script src="../../certgate/certgate_common.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
    <script src="../../certgate/certgate.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
    -->

    <script type="text/javascript">
    if (typeof(Delfino.setVersion) == "function") {
        var test_version_g2 = {
            WinIE   : "1,2,3,1",
            WinMoz  : "1.2.3.1",
            Mac     : "1.2.3.1",
            Linux   : "1.2.3.1"
        };
        var test_version_g3 = {
            WinIE   : "3,1,0,2",
            WinMoz  : "3,1,0,2",
            Mac     : "3,1,0,2",
            Linux   : "3,1,0,2"
        };
        Delfino.setVersion(test_version_g2, test_version_g3);
    }
    </script>

    <script type="text/javascript">Delfino.resetRecentModule();Delfino.setModule();</script>
    <script type="text/javascript">
    //<![CDATA[
    DelfinoConfig.forceScreenKeyboard = false;
    if (typeof(DelfinoConfig.cg) == "object") DelfinoConfig.cg.VPCGClientConfig.defaultProvider = "delfino";

    var viewExt = "";
    if ("on" == "<%=getParameter(request, "viewExt")%>") viewExt = "on";

    DelfinoConfig.uiType = "";
    if ("senior" == "<%=getParameter(request, "uiType")%>") DelfinoConfig.uiType = "senior";

    var skeyboard = "<%=getParameter(request, "skeyboard")%>";
    if (skeyboard != "null" && "" != skeyboard) {
        secureKeyboardConfig.enable = "true";
        secureKeyboardConfig.product = skeyboard;
        if (skeyboard == "none") secureKeyboardConfig.enable = "false";
        if (skeyboard == "G10_astx") {
            var sKeyboard = {};
            sKeyboard.enable = true;
            sKeyboard.name = "astx";
            sKeyboard.src = ["../../astx/astx2.min.js","../../astx/astx2_custom.js"];
            DelfinoConfig.g4.secureKeyboard = sKeyboard;
            DelfinoConfig.cg.secureKeyboard = DelfinoConfig.g4.secureKeyboard;
        }
    }

    function fn_reload() {
        location.href = location.pathname + "?systemMode=" + _Delfino_SystemMode + "&systemLang=" + _Delfino_SystemLang + "&uiType=" + DelfinoConfig.uiType + "&viewExt=" + viewExt + "&skeyboard=" + secureKeyboardConfig.product;
    }

    var viewMobile = "PC";
    if ("on" == "<%=session.getAttribute("delfino_mobile_demo")%>") viewMobile = "mobile";
    function fn_selectViewport() {
        var msg = "모바일용 viewport meta 태그를 추가합니다.";
        if (viewMobile=="mobile") msg = "모바일용 viewport meta 태그를 제거합니다.";
        var redirectURL = location.pathname + "?mobile=" + ((viewMobile == "mobile") ? "off" : "on");
        //alert(viewMobile + "\n" + redirectURL);
        //if (confirm(msg)) window.location.href = redirectURL;
        if (confirm(msg)) clearModuleTypeCookie(redirectURL);
    }

    function fn_selectEXT() {
        var _viewExt  = (viewExt == "on") ? "" : "on";
        clearModuleTypeCookie(location.pathname + "?viewExt=" + _viewExt);
        /*
        viewExt = _viewExt;
        clearModuleTypeCookie();
        fn_reload();
        */
    }

    function fn_selectKeyboard() {
        var _skeyboard = document.getElementById("selected_keyboard").value;
        secureKeyboardConfig.product = _skeyboard;
        fn_reload();
    }
    function fn_selectUiType() {
        var _uiType  = (DelfinoConfig.uiType == "senior") ? "" : "senior";
        DelfinoConfig.uiType = _uiType;
        fn_reload();
    }
    function fn_selectSystemMode() {
        var _systemMode = (_Delfino_SystemMode == "real") ? "test" : "real";
        _Delfino_SystemMode = _systemMode;
        fn_reload();
    }
    function fn_selectSystemLang() {
        var _systemLang = _Delfino_SystemLang;
        if      (_systemLang == "KOR") _systemLang = "ENG";
        else if (_systemLang == "ENG") _systemLang = "CHN";
        else if (_systemLang == "CHN") _systemLang = "JPN";
        else if (_systemLang == "JPN") _systemLang = "VNM";
        else if (_systemLang == "VNM") _systemLang = "KOR";
        _Delfino_SystemLang = _systemLang;
        fn_reload();
    }
    function fn_downlaodKeyboard() {
        var selected_keyboard = document.getElementById("selected_keyboard").value;
        var productArray = selected_keyboard.split(',');
        var product = productArray[0]; //v3140 below
        //var product = productArray[productArray.length-1]; //v3140 below

        if (product == "scsk") {
            document.location = "http://download.kbstar.com/security/SCSK/403196/SCSKInstTotal.exe";
        } else if (product == "touchennxkey") {
            document.location = "https://img.nonghyup.com/install/so/raon/TouchEnNxKey/TouchEn_nxKey_Installer_32bit.exe";
        } else if (product == "astx") {
            document.location = "http://safetx.ahnlab.com/master/win/default/all/astx_setup.exe";
        } else if (product == "nosk") {
            document.location = "https://supdate.nprotect.net/nprotect/nos_service/windows/install/nos_setup.exe";
        } else if (product == "kos") {
            document.location = "https://www.samsungfire.com/download/kdfense/KOS_Setup.exe";
        } else if (product == "kings") {
            document.location = "http://www.kings.co.kr/k/installkdf8.exe";
        } else if (product == "touchenkey") {
            if (DC_platformInfo.x64) {
                document.location = "https://open.keb.co.kr/product_new/TouchEn/nxKey/module/TouchEn_nxKey_Installer_64bit.exe";
            } else {
                document.location = "https://open.keb.co.kr/product_new/TouchEn/nxKey/module/TouchEn_nxKey_Installer_32bit.exe";
            }
        } else {
            alert(product);
        }
    }

    //]]>
    </script>

    <script type="text/javascript">
    //<![CDATA[

    function TEST_checkExpireWarning(certExpireDate) {
        var beforeDay = 180;
        if (certExpireDate == null) return;

        var year = certExpireDate.substring(0,4);
        var month = certExpireDate.substring(5,7);
        var day = certExpireDate.substring(8,10);

        var toDay = new Date();
        var expireDate = new Date(year, month-1, day, "23", "59", "59");
        var betweenDay = (expireDate.getTime()-toDay.getTime())/1000/60/60/24;

        //alert(year + ":" + month + ":"+ day + "\n" + parseInt(betweenDay, 10));
        if (betweenDay <= beforeDay) alert("인증서 만료일은 " +  certExpireDate + " 입니다. " + parseInt(betweenDay, 10) + "일 남았습니다.");
    }

    //전자서명시 호출되는  CallBack 함수
    var __result = null;
    function TEST_complete(result){
        __result = result;
        if(result.status==0) return;
        if(result.status==1){
            document.delfinoForm.PKCS7.value = result.signData;
            if (document.delfinoForm.PKCS_TYPE.value == "mdSign" && jQuery.isArray(result.signData)) document.delfinoForm.PKCS7.value = result.signData.join(document.delfinoForm.SIGN_Delimeter.value);
            document.delfinoForm.VID_RANDOM.value = result.vidRandom;

            document.delfinoForm.MACAddress.value = "_";
            document.delfinoForm.tokenSerialNumber.value = "_";
            document.delfinoForm.CONFIRM_PKCS7.value = "";

            //TODO: scrapingSign 결과값
            document.delfinoForm.signingCert.value = "";
            document.delfinoForm.signingTime.value = "";
            document.delfinoForm.withoutSignedPkcs7.value = "";
            document.delfinoForm.withoutSignedPkcs1.value = "";
            if(result.cert!=null) document.delfinoForm.signingCert.value = result.cert;
            if (document.delfinoForm.PKCS_TYPE.value == "scrapingSign") {
                if (jQuery.isArray(result.signData)) {
                    var pkcs7 = "";
                    var withoutSignedPkcs7 = "";
                    var withoutSignedPkcs1 = "";
                    var signingTime = "";
                    for (var i=0; i<result.signData.length; i++) {
                        pkcs7 += result.signData[i].p7 + document.delfinoForm.SIGN_Delimeter.value;
                        withoutSignedPkcs7 += result.signData[i].p7WithoutSignedAttribute + document.delfinoForm.SIGN_Delimeter.value;
                        withoutSignedPkcs1 += result.signData[i].p1 + document.delfinoForm.SIGN_Delimeter.value;
                        signingTime += result.signData[i].signingTime + document.delfinoForm.SIGN_Delimeter.value;
                    }
                    document.delfinoForm.PKCS7.value = pkcs7;
                    document.delfinoForm.withoutSignedPkcs7.value = withoutSignedPkcs7;
                    document.delfinoForm.withoutSignedPkcs1.value = withoutSignedPkcs1;
                    document.delfinoForm.signingTime.value = signingTime;
                } else {
                    //document.delfinoForm.PKCS7.value = result.signData;
                    document.delfinoForm.withoutSignedPkcs7.value = result.signData;
                    if(result.pkcs1SignData!=null) document.delfinoForm.withoutSignedPkcs1.value = result.pkcs1SignData;
                    if(result.signingTime!=null) document.delfinoForm.signingTime.value = result.signingTime;
                }
            }

            if(result.confirmSignData!=null) document.delfinoForm.CONFIRM_PKCS7.value = result.confirmSignData;
            if(result.MACAddress!=null) document.delfinoForm.MACAddress.value = result.MACAddress;
            if(result.tokenSerialNumber!=null) document.delfinoForm.tokenSerialNumber.value = result.tokenSerialNumber;
            if(result.certExpireDate!=null) TEST_checkExpireWarning(result.certExpireDate);

            //CertGate
            document.delfinoForm.EA_serviceType.value = "_";
            document.delfinoForm.EA_signSubjectDN.value = "_";
            if(result.serviceType!=null) document.delfinoForm.EA_serviceType.value = result.serviceType;
            if(result.signSubjectDN!=null) document.delfinoForm.EA_signSubjectDN.value = result.signSubjectDN;

            document.delfinoForm.submit();
        }
        else{
            //if (Delfino.isPasswordError(result.status)) alert("비밀번호 오류 횟수 초과됨"); //v1.1.6,0 over & DelfinoConfig.passwordError = true
            alert("error:" + result.message + "[" + result.status + "]");
        }
    }

    //인증서로그인: Delfino.login()
    function TEST_certLogin(){
        document.delfinoForm.PKCS_TYPE.value = "base64";
        var signOptions = {'withMACAddressAll':true, policyOidCertFilter: ""};
        //signOptions = {'withMACAddress':true};

        Delfino.login("login=certLogin", TEST_complete, signOptions);
    }

    //사용자 확인 전자서명: 문자열
    function TEST_confirmSign_string() {
        document.delfinoForm.PKCS_TYPE.value = "base64";
        var signFormat = "출금계좌번호:이체금액:입금은행:입금계좌번호:받는분";
        var signData = "524902-01-055983:10,000:홍콩은행:097-21-0441-120:김모군";
        var signOptions = {policyOidCertFilter: ""};

        //Delfino.confirmSign({data:signData, dataType:'strings'}, signFormat, TEST_complete);
        Delfino.confirmSign({data:signData, dataType:'strings'}, signFormat, signOptions, TEST_complete);
    }

    //전문형태의 사용자 미확인 전자서명
    function TEST_withoutConfirmSign() {
        document.delfinoForm.PKCS_TYPE.value = "base64";
        var signData = "param=전문형태의 전자서명&데이타=201금융 보험 부동산 서비스 04";
        var signOptions = {cacheCert:false, policyOidCertFilter:""};
        //signOptions = {resetCertificate:false, cacheCert:false, policyOidCertFilter:""};
        //signOptions = {policyOidCertFilter: ""};

        //Delfino.sign(signData, TEST_complete);
        Delfino.sign(signData, signOptions, TEST_complete);
    }

    //<h2>다중전자서명</h2>
    //한번의 패스워드 입력으로 여러개의 서명(PKCS7)값을 생성 하고 싶은 경우 사용된다.<br/>
    //서버에서는 여러개를 각각 잘라내 PKCS7값을 검증해야한다. <br/>
    function TEST_multiSign(){
        document.delfinoForm.PKCS_TYPE.value = "base64";
        var data1 = "델피노 test 다중전자서명1";
        var data2 = "두번째 test 다중전자서명2";
        var signData = data1 + DelfinoConfig.multiSignDelimiter + data2
        var signOptions = {policyOidCertFilter: ""};

        //Delfino.multiSign(signData, TEST_complete);
        Delfino.multiSign(signData, signOptions, TEST_complete);
    }

    //]]>
    </script>

    <script type="text/javascript">
    //<![CDATA[
    /*
    //전자서명:다중서명:  Delfino.sign()
    function TEST_multiSign(){
        var inData = "01:201금융 보험 부동산 서비스04:전자서명원문데이타|전자서명 원본데이타2";
        Delfino.sign(inData, TEST_complete,
            {
                cacheCertFilter:false,
                cacheCert:false,
                //issuerCertFilter:"cn=CrossCertTestCA2,ou=AccreditedCA,o=CrossCert,c=KR|cn=CrossCertTestCA,ou=AccreditedCA,o=CrossCert,c=KR",
                multiSign:true,
                //encoding: "euckr",
                multiSignDelimeter:"|"
            }
        );
        //return false;
    }
    */

    //전자서명: KB투자증권: Delfno.sign()
    function TEST_signNoCache(){
        document.delfinoForm.PKCS_TYPE.value = "base64";
        var inData = "Y";
        var inFormat = "투자증권약관에동의합니다.";
        Delfino.sign(inData, TEST_complete,
            {
                dataType:           "strings",
                format:             inFormat,
                delimeter:          ":",
                cacheCertFilter:    false,
                cacheCert:          false
                //policyOidCertFilter:CERT_Accept_Koscom
            }
        );
        //return false;
    }

<%
    String stringifyFormat = "";
    stringifyFormat = "[{\\\"location\\\":32,\\\"length\\\":10,\\\"label\\\":\\\"이  름\\\",\\\"format\\\":\\\"bold\\\"},{\\\"location\\\":14,\\\"length\\\":8,\\\"label\\\":\\\"날  짜\\\",\\\"format\\\":\\\"insert+####-##-##\\\"},{\\\"location\\\":57,\\\"length\\\":12,\\\"label\\\":\\\"계좌번호1\\\",\\\"format\\\":\\\"lastHide 2\\\"},{\\\"location\\\":57,\\\"length\\\":12,\\\"label\\\":\\\"계좌번호2\\\",\\\"format\\\":\\\"mask **##########\\\"}]";
    /* {
        com.wizvera.service.util.FixedLengthDataFormat fldf = new com.wizvera.service.util.FixedLengthDataFormat();
        fldf.addItem(32, 10, "이  름",  "bold");
        fldf.addItem(14,  8, "날  짜",  "insert+####-##-##");
        fldf.addItem(57, 12, "계좌번호1", "lastHide 2");
        fldf.addItem(57, 12, "계좌번호2", "mask **##########");
        stringifyFormat = fldf.getStringyfyFormat();
        String defaultFormat = fldf.getFormat();
        session.setAttribute("confirmSign.format", defaultFormat);
    } */
%>

    //전자서명: 전자채권: Delfno.sign()
    function TEST_bondsSign(isMulti){
        document.delfinoForm.PKCS_TYPE.value = "signedData";
        var inData = "000000000070002011112420111129YN테스트성명　　　　　　　　　　　　　　　10581450342098120581";

        if (isMulti) {
            inData    += DelfinoConfig.multiSignDelimiter;
            inData    += "0000000000700-2012132420111129YN홍  길성명123　　　　　　　　　　　　10581450342098120581";
            var confirmFormat = "<%=stringifyFormat%>";
            //elfino.confirmMultiSign(inData, confirmFormat, {dataType:'fixedLengthData', signType:'signedData', encoding:'euckr'}, TEST_complete);
            Delfino.sign(inData, TEST_complete,
                {
                    signType:"signedData",
                    dataType:"fixedLengthData",
                    format:confirmFormat,
                    multiSign:true,
                    multiSignDelimeter:DelfinoConfig.multiSignDelimiter,
                    addCertStoreType: false,
                    encoding: "euckr"
                }
            );
            return;
        }

        Delfino.sign(inData, TEST_complete,
            {
                signType:"signedData",
                addCertStoreType: false,
                encoding: "euckr"
            }
        );
        //return false;
    }

    //Delfino.mdSign()
    function TEST_mdSign(isMulti) {
        document.delfinoForm.PKCS_TYPE.value = "mdSign";
        var detachedDigest = "b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7";
        if (isMulti) detachedDigest = ['b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7', '22e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7'];
        alert("messageDigest값이 아래와 같아야합니다.\n" + detachedDigest);

        if (isMulti) {
            document.delfinoForm.detachedMD.value = detachedDigest.join(document.delfinoForm.SIGN_Delimeter.value);
            Delfino.mdMultiSign(detachedDigest, TEST_complete);
            //Delfino.mdMultiSign(detachedDigest, TEST_complete, {cacheCertFilter:false, cacheCert:false});
        } else {
            document.delfinoForm.detachedMD.value = detachedDigest;
            //Delfino.mdSign(detachedDigest, TEST_complete);
            Delfino.mdSign(detachedDigest, TEST_complete, {cacheCertFilter:false, cacheCert:false});
        }
    }

    //Delfino.scrapingSign()
    function TEST_scrapingSign(isMulti) {
        if (document.delfinoForm.SIGN_Delimeter.value == "") isMulti = false;
        document.delfinoForm.PKCS_TYPE.value = "scrapingSign";

        var tbsData = "델피노 test 스크래핑용 서명원문1";
        if (isMulti) tbsData = ["델피노 test 스크래핑용 서명원문1", "두번째 test 스크래핑용 서명원문2"];

        var signOptions = {};
        signOptions.cacheCert = false;
        signOptions.resetCertificate = true;
        signOptions.policyOidCertFilter = "";

        alert("스크래핑용서명원문\n[" + tbsData + "]");
        Delfino.scrapingSign(tbsData, signOptions, TEST_complete);
    }
    //사용하지 마세요.
    function TEST_cooconSign(isMulti) {
        if (document.delfinoForm.SIGN_Delimeter.value == "") isMulti = false;
        document.delfinoForm.PKCS_TYPE.value = "scrapingSign";
        var tbsData = "델피노 test 스크래핑용 서명원문1";
        if (isMulti) tbsData = ["델피노 test 스크래핑용 서명원문1", "두번째 test 스크래핑용 서명원문2"];

        var signOptions = {};
        signOptions.cacheCert = false;
        signOptions.resetCertificate = true;
        signOptions.policyOidCertFilter = "";

        signOptions.withPkcs1 = true;
        signOptions.certInResult = true;
        //signOptions.signingTimeInResult = true;
        //signOptions.withoutSigningTime = true;

        if (isMulti) {
            signOptions.multiSign = true;
            signOptions.multiSignDelimiter = document.delfinoForm.SIGN_Delimeter.value;
            tbsData = tbsData.join(document.delfinoForm.SIGN_Delimeter.value);
        }
        alert("쿠콘 스크래핑용서명원문\n[" + tbsData + "]");
        Delfino.sign(tbsData, signOptions, TEST_complete);
    }


    //전자서명: signKeyValue
    function TEST_signKeyValue() {
        document.delfinoForm.PKCS_TYPE.value = "base64";
        var delimeter = ":";
        var keys = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용:출금계좌번호";
        var values = "1234-1234-1234:10,000:100::국민은행:4321-4321-4321:아무개::2234-1234-1234";
        var formats = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용:출금계좌번호2";
        Delfino.signKeyValue(keys, values, formats, delimeter, TEST_signKeyValueCallback);
    }
    function TEST_signKeyValueCallback(pkcs7, vid_random) {
        var result = {};
        result.status = 1;
        result.signData = pkcs7;
        result.vidRandom = vid_random;
        TEST_complete(result);
    }
    //]]>
    </script>

    <script type="text/javascript">
    //<![CDATA[
    var yessignCaHost_real    = DelfinoConfig.yessignCaHost;
    var yessignCaPort_real    = DelfinoConfig.yessignCaPort;
    var crosscertCaPort_real  = DelfinoConfig.crosscertCaPort;
    var crosscertCaHost_real  = DelfinoConfig.crosscertCaHost;
    var signkoreaCaHost_real  = DelfinoConfig.signkoreaCaHost;
    var signkoreaCaPort_real  = DelfinoConfig.signkoreaCaPort;
    var kicaCaHost_real       = DelfinoConfig.kicaCaHost;
    var kicaCaPort_real       = DelfinoConfig.kicaCaPort;
    var kicaCaHost_real       = DelfinoConfig.kicaCaHost;
    var kicaCaPort_real       = DelfinoConfig.kicaCaPort;
    var yessignWebCmpUrl_real = DelfinoConfig.yessignWebCmpUrl;
    function TEST_selectCA(caType, caName) {
        if (caType == "real") {
            DelfinoConfig.yessignCaHost    = yessignCaHost_real;
            DelfinoConfig.yessignCaPort    = yessignCaPort_real;
            DelfinoConfig.crosscertCaPort  = crosscertCaPort_real;
            DelfinoConfig.crosscertCaHost  = crosscertCaHost_real;
            DelfinoConfig.signkoreaCaHost  = signkoreaCaHost_real;
            DelfinoConfig.signkoreaCaPort  = signkoreaCaPort_real;
            DelfinoConfig.kicaCaHost       = kicaCaHost_real;
            DelfinoConfig.kicaCaPort       = kicaCaPort_real;
            DelfinoConfig.yessignWebCmpUrl = yessignWebCmpUrl_real;
        } else {
            DelfinoConfig.yessignCaHost    = DelfinoConfig.yessignCaHost_test;
            DelfinoConfig.yessignCaPort    = DelfinoConfig.yessignCaPort_test;
            DelfinoConfig.crosscertCaPort  = DelfinoConfig.crosscertCaPort_test;
            DelfinoConfig.crosscertCaHost  = DelfinoConfig.crosscertCaHost_test;
            DelfinoConfig.signkoreaCaHost  = DelfinoConfig.signkoreaCaHost_test;
            DelfinoConfig.signkoreaCaPort  = DelfinoConfig.signkoreaCaPort_test;
            DelfinoConfig.kicaCaHost       = DelfinoConfig.kicaCaHost_test;
            DelfinoConfig.kicaCaPort       = DelfinoConfig.kicaCaPort_test;
            DelfinoConfig.yessignWebCmpUrl = DelfinoConfig.yessignWebCmpUrl_test;
        }
        if (caName == "yessign") {
            alert("[" + caType + "," + caName + "][" + DelfinoConfig.yessignCaHost + ":" + DelfinoConfig.yessignCaPort + "]");
        } else if (caName == "crosscert") {
            alert("[" + caType + "," + caName + "][" + DelfinoConfig.crosscertCaHost + ":" + DelfinoConfig.crosscertCaPort + "]");
        } else if (caName == "signkorea") {
            alert("[" + caType + "," + caName + "][" + DelfinoConfig.signkoreaCaHost + ":" + DelfinoConfig.signkoreaCaPort + "]");
        } else if (caName == "kica") {
            alert("[" + caType + "," + caName + "][" + DelfinoConfig.kicaCaHost + ":" + DelfinoConfig.kicaCaPort + "]");
        } else if (caName == "yessignWebCmp") {
            alert("[" + caType + "," + caName + "][" + DelfinoConfig.yessignWebCmpUrl + "]");
        }
    }
    function TEST_certComplete(code, msg){
        if(code!=1){
          if(code==0){
            alert("사용자가 취소하였습니다.");
            return;
          } else {
            //발급/갱신 에러
            alert("발급오류:" + code + ":" + msg);
          }
          return;
        }
        alert("인증서 발급에 성공하였습니다.");
    }
    function TEST_certComplete2(result){
        TEST_certComplete(result.status, result.message);
    }

    function TEST_requestCertificate(){
        var sendForm = document.getElementById('certForm');
        var caType = sendForm.caType.value;
        var caName = sendForm.caName.value;
        var referenceValue = sendForm.referenceValue.value;
        var secretValue = sendForm.secretValue.value;
        TEST_selectCA(caType, caName);

        if (caName == "kica") {
            Delfino.requestCertificate2(caName, referenceValue, secretValue, TEST_certComplete2, {enableKmCert:true}); //정보인증 발급
            //Delfino.requestCertificate2(caName, referenceValue, secretValue, TEST_certComplete, {recovery:true, enableKmCert:true}); //정보인증 재발급
        } else if (caName == "yessignWebCmp") {
            Delfino.requestCertificate2(caName, referenceValue, secretValue, TEST_certComplete2, {browserCertificate:true}); //브라우저인증서 발급
        } else {
            Delfino.requestCertificate(caName, referenceValue, secretValue, TEST_certComplete);
        }
    }

    function TEST_updateCertificate(){
        var sendForm = document.getElementById('certForm');
        var caType = sendForm.caType.value;
        var caName = sendForm.caName.value;
        var referenceValue = sendForm.referenceValue.value;
        var secretValue = sendForm.secretValue.value;
        TEST_selectCA(caType, caName);

        //Delfino.resetCertificate(); //인증서캐쉬 초기화
        //Delfino.setIssuerCertFilter(''); //인증서 필터링

        if (caName == "kica") {
            Delfino.updateCertificate2(caName, TEST_certComplete2, {resetCertificate:true, cacheCert:false, enableKmCert:true}); //정보인증 갱신
        } else if (caName == "yessignWebCmp") {
            Delfino.updateCertificate2(caName, TEST_certComplete2, {cacheCert:false, policyOidCertFilter:"1.2.410.200005.1.1.1-B|1.2.410.200005.1.1.5-B"}); //브라우저인증서 갱신
        } else {
            //Delfino.updateCertificate(caName, TEST_certComplete);
            Delfino.updateCertificate2(caName, TEST_certComplete2, {cacheCert:false, policyOidCertFilter:""}); //인증서캐쉬정보 사용하기
        }
    }

    function TEST_getDeviceID(){
        DelfinoConfig.useRecentModule = false;
        Delfino.setModule("G4");
        if (!Delfino.isSupportedG4()) {
            alert("Delfino G4(브라우저 인증서)가 지원하지 않는 환경입니다.");
            return;
        }
        if (Delfino.getModule() != "G4") {
            alert("Delfino G4에서만 사용가능합니다.");
            return;
        }
        Delfino.getDeviceID(function(err, deviceID) {
            if (err) alert("Error occured:\n" + err);
            alert("deviceID [" + deviceID + "]");
        });
    }
    function TEST_importCertificateG4(){
        DelfinoConfig.useRecentModule = false;
        Delfino.setModule("G4");
        if (!Delfino.isSupportedG4()) {
            alert("Delfino G4(브라우저 인증서)가 지원하지 않는 환경입니다.");
            return;
        }
        if (Delfino.getModule() != "G4") {
            alert("Delfino G4에서만 사용가능합니다.");
            return;
        }
        Delfino.importCertificate({place:"DelfinoG4"},TEST_completeImport);
    }
    function TEST_exportCertificateG4(){
        DelfinoConfig.useRecentModule = false;
        Delfino.setModule("G4");
        if (!Delfino.isSupportedG4()) {
            alert("Delfino G4(브라우저 인증서)가 지원하지 않는 환경입니다.");
            return;
        }
        if (Delfino.getModule() != "G4") {
            alert("Delfino G4에서만 사용가능합니다.");
            return;
        }
        Delfino.exportCertificate({place:"DelfinoG4"}, TEST_completeExport);
    }

    function TEST_importCheck() {
        document.relayForm.cmd.value = "deviceAuth";
        document.relayForm.index.value = "168";
        document.relayForm.pubKey.value = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4A577nBWpsnjQ0hbURGA2Ol1O+w5mE+Bi+bBuoVLtxuUW1P5RG5skKvh6gFnG/1A2PBwNaNNBB5U8Dh8mBjpxQQovNx6qzSAGNz9Tbwu7+kfRZLR8MMol6So55otgMZ9+9viIaRSmTrkdAHaex/EJMIvcaWutpFKFpPb6y+78s9oEkESR61fqcH4xC54vnZDNIW0warcI1lJElS0HdmG26ta5JnCIq92/gyGyCCGYhn7B4fYHdDcFg+ahH5jXfAWFDQWe4W25nIK8Tg6qRFRg+zdqak4dAffwXr7Q/dSNpuy5+QoqnjB5j6GyoiMPDs4S9lwc0tDCNqPEBu2BpgNvQIDAQAB";
        document.relayForm.clientAuth.value = "m3k6rN9VL8HHVoLpEKQMiMXNcmRJ/XQyrmMG79UCtDxccsFSVWmMr4aDoRBGzO5N";
        document.relayForm.serverAuth.value = "Dlblmscimifdm4vesG50rg==";
        document.relayForm.sessionKey.value = "SzfO+wkYBd2PjA2kSxa5Bgo3ZS7wjkgvdkoa248//WiTPLujzCEqNSFHmGIqFoxecPKUUyN8p2huPg5GaNB22cNISGnxm5XWYdA4vkCDlU5Ye0X7krWxA3dSITCN8Fc5wIHMZ8/BtF/1Yru0GedxDj/i5hbCuW2PTSmtVci93j0N3NZqkCv+IOGiWetbPk6YdiW7RDv7pmwXNUvce/D4cRFlbya5F5w1FKppGhrTTSEN/6BHLQ1pTrdCaB38PxfE3+QYCw8nA6Rd4t14CiujErN9qNkN5gLHacRplTyIBiQHYGmbjJZi43W+A7fok3f+s8ifa7NIEdHZasDcw0cW5Q==";
        document.relayForm.signedData.value = "fgR4wXbTRLMiUf2o44WMtlW1V/RnAq4bfLWwwOf4hNf/Cj5uPJK4w6YJW4NoKFDZ9FxY6EV9cuuCNsW00S6Zd89ZUSATsnFstJukVBGaMHNr/eSjVVt6xtV9vN9ORP/7rXxDAUwwHQoZ0L55VWlUBL3GliDZUzHBX189TX0el+KOvmPoCF6HUTuGfZVEhqfSStEPlfKaeEIIKzdfb743ATLXCEhSMaB3ogPEq5PkUesJQTfzJC8vzpke9yW55pp2g4ihhWw1CljwLeJArdmUz/Z2Vm67h4s3txBmZPlMQbb5q12DCxmi7DwMB7dgNVeMl1vMDtc++YroHkNHHP/Ehw==";
        document.relayForm.method="post";
        document.relayForm.target="testResult";
        document.relayForm.action = DelfinoConfig.certRelay.providerUrl;
        document.relayForm.submit();
    }
    function TEST_relayCheck() {
        document.relayForm.cmd.value = "check";
        document.relayForm.index.value = "";
        document.relayForm.pubKey.value = "";
        document.relayForm.clientAuth.value = "";
        document.relayForm.serverAuth.value = "";
        document.relayForm.sessionKey.value = "";
        document.relayForm.signedData.value = "";
        document.relayForm.method="get";
        document.relayForm.target="testResult";
        document.relayForm.action = DelfinoConfig.certRelay.providerUrl;
        document.relayForm.submit();
    }

    function TEST_importCertificate(){
        Delfino.importCertificate(TEST_completeImport);
    }
    function TEST_exportCertificate(){
        Delfino.exportCertificate(TEST_completeExport);
        //Delfino.exportCertificate({disableExpireFilter:true}, TEST_completeExport); //만료된 인증서 보이기
    }
    function TEST_completeImport(result) {
        if(result.status==0) {
            alert("가져오기 취소"); //사용자취소
        } else if(result.status==1) {
            alert("가져오기 성공");
        } else {
            alert(result.message + "[" + result.status + "]");
        }
    }
    function TEST_completeExport(result) {
        if(result.status==0) {
            alert("내보내기 취소"); //사용자취소
        } else if(result.status==1) {
            alert("내보내기 성공");
        } else {
            alert(result.message + "[" + result.status + "]");
        }
    }
    //]]>
    </script>
</head>

<body>


<table class="body" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <% if (!"on".equals(session.getAttribute("delfino_mobile_demo"))) { %>
    <td align="left"><img src="../sitelogo/delfino_logo.png" width="214" /></td>
  <% } %>
    <td align="right"><h3>WIZVERA Delfino 전자서명 테스트  <font size=2><a href="javascript:clearModuleTypeCookie('../demo/index.jsp');">sample</a></font></h3></td>
  </tr>
</table>


<table class="body" align="center" border="0" cellpadding="6" cellspacing="1" bgcolor="#E3E3E3">
  <tr>
    <td width="120" class="head"><b>테스트항목</b></td>
    <td class="head">
      <b>세부내용</b>
        [ 키보드보안<a href="javascript:fn_downlaodKeyboard();">:</a>
        <select name="selected_keyboard" id="selected_keyboard" onchange="javascript:fn_selectKeyboard()">
            <option value="scsk">scsk</option>
            <option value="touchenkey">touchenkey</option>
            <option value="npkcx">npkcx</option>
            <option value="kings">kings</option>
            <option value="_line1_" disabled >--------------</option>
            <option value="touchennxkey">touchennx</option>
            <option value="astx">astx</option>
            <option value="nosk">nosk</option>
            <option value="kos">kos</option>
            <option value="npkfx">npkfx</option>
            <option value="_line2_" disabled >--------------</option>
            <option value="astx,scsk">astx,scsk</option>
            <option value="scsk,astx">scsk,astx</option>
            <option value="_line3_" disabled >--------------</option>
            <option value="G10_astx">G10_astx</option>
            <option value="none">사용안함</option>
        </select>
        ]
        [
        <script type="text/javascript">
        //<![CDATA[
        document.write((Delfino.getModule()=="G3") ? "non-plugin" : ((Delfino.getModule()=="G4") ? "html5-G4" : (Delfino.getModule()=="G5") ? "html5-G5" : ((Delfino.getModule()=="EA") ? "CertGate" : "plug-in")));
        document.getElementById("selected_keyboard").value = secureKeyboardConfig.product;
        //]]>
        </script>
        ]
    </td>
  </tr>

  <tr>
    <td class="head"><b>브라우저 점검</b><br/>[<%=rIP%>]<br/><script type="text/javascript">document.write((!navigator.userAgent.match(/NT 5./i) && !navigator.userAgent.match(/NT 6.0/i)) ? "[sha256]" : "[sha1]");</script></td>
    <td class="body_l">
      ■ 브라우저(<script type="text/javascript">document.write(DC_browserInfo.name);</script>)의 기본기능인 POST를 이용한  대용량 테이타 전송테스트 입니다.<br/>정상적으로 결과가 나오지 않으면 PC(브라우저)점검이 필요합니다.

      <form name="delfinoForm" method="post" target="testResult" action="<%=action%>">
        <input type=hidden name="MACAddress" value="" />
        <input type=hidden name="tokenSerialNumber" value="" />
        <input type=hidden name="CONFIRM_PKCS7"/>

        <input type=hidden name="signingCert"/>
        <input type=hidden name="signingTime"/>
        <input type=hidden name="withoutSignedPkcs7"/>
        <input type=hidden name="withoutSignedPkcs1"/>

        <input type="hidden" name="detachedMD" />
        <input type="hidden" name="EA_serviceType" />
        <input type="hidden" name="EA_signSubjectDN" />

        PKCS7: <textarea name="PKCS7">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</textarea><br/>
        VID_R:&nbsp; <input type="text" name="VID_RANDOM"  size="36" style="font-size:9pt;" value="LvRWH51fyhltWJk/Pb9my5CNX3M=" />
          <input type=text name="SIGN_Delimeter" size="1" value="" />
          <select name="PKCS_TYPE">
          <option value="base64">base64</option>
          <option value="hex">hex</option>
          <option value="base64Url">base64Url</option>
          <option value="signedData">signedData</option>
          <option value="mdSign">mdSign</option>
          <option value="scrapingSign">scrapingSign</option>
        </select><input type="checkbox" name="debug" /><br/>
                주민번호: <input type="text" name="idn" value="" size="14" />
        <input type="submit" /> <input type="reset" />
      </form>
      <script type="text/javascript">
      //<![CDATA[
      document.delfinoForm.SIGN_Delimeter.value = DelfinoConfig.multiSignDelimiter;
      //]]>
      </script>
    </td>
  </tr>

  <tr>
    <td class="head"><b>인증서관리 확인</b></td>
    <td class="body_l">
      ■ 개인<a href="javascript:Delfino.getMACAddress(function(mac){alert(mac);});">P</a><a href="javascript:TEST_getDeviceID();">C</a>에 저장된 공인인증서를 확인합니다.
      <input type="button" value="인증서관리" onclick="javascript:Delfino.manageCertificate();"/>

      <script type="text/javascript">
      function popupOpenCert(type) {
          if (type == "") {
              type = "real";
              if (DelfinoConfig.g4.opencert.relaySrc.indexOf("fidoweb.yessign.or.kr")>0) type = "test";
          }
          var url = "https://www.yessign.or.kr:3300//certrelay/certrelay.jsp";
          if (type == "test") url = "https://fidoweb.yessign.or.kr:3300//certrelay/certrelay.jsp";
          window.open(url+"?openCert="+type, "openCert"+type, 'scrollbars=yes,toolbar=yes,resizable=yes,width=800,height=800');
      }
      </script>
      <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("<!--"); %>
      &nbsp;&nbsp;OpenCert:
      <a href="javascript:popupOpenCert('test');">test</a> <a href="javascript:popupOpenCert('real');">real</a>
      <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("-->"); %>

      <% if ("on".equals(getParameter(request, "viewExt"))) out.println("<!--"); %>
      &nbsp;&nbsp;OpenCert:
      <a href="javascript:popupOpenCert('');">open</a>
      <% if ("on".equals(getParameter(request, "viewExt"))) out.println("-->"); %>
    </td>
  </tr>
  <tr>
    <td class="head"><b>인증서로그인 확인</b></td>
    <td class="body_l">
      ■ 유효기간이 만기된 인증서는 보이지 않습니다. 정상적으로 보이지 않으면 인증서관리에서 인증서가 있는지 확인하시기 바랍니다 <a href="javascript:TEST_certLogin();TEST_certLogin();" >.</a>
      <a href="javascript:setTimeout(function(){TEST_certLogin();}, 500); TEST_certLogin();" >.</a>
      <input type="button" value="인증서로그인" onclick="javascript:TEST_certLogin();" />
      <a href="javascript:Delfino.setPolicyOidCertFilter('');Delfino.setIssuerCertFilter('');alert('인증서필터링이 제거되엇습니다.');" >setFilter</a>

      <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("<!--"); %>
      <a href="javascript:Delfino.setModule('G2');TEST_certLogin();" >G2</a>
      <a href="javascript:Delfino.setModule('G3');TEST_certLogin();" >G3</a>
      <a href="javascript:Delfino.setModule('G4');TEST_certLogin();" >G4</a>
      <a href="javascript:Delfino.setModule('G5');TEST_certLogin();" >G5</a>
      <a href="javascript:Delfino.setModule('G10');TEST_certLogin();" >G10</a>
      <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("-->"); %>
    </td>
  </tr>

  <tr>
    <td class="head"><b>전자서명 확인</b></td>
    <td class="body_l">
      ■ 이체나 약관동의시 사용되는 전자서명 기능을 확인합니다. 로그인시 사용된 인증서만 보여집니다<a href="javascript:Delfino.resetCertificate();alert('인증서 캐쉬가 초기화되었습니다.');" >.</a>
      <input type="button" value="서명(confirm)" onclick="javascript:TEST_confirmSign_string();" />
      <input type="button" value="서명(sign)"    onclick="javascript:TEST_withoutConfirmSign();" />
      <input type="button" value="다중서명"       onclick="javascript:TEST_multiSign();" />
      <a href="javascript:TEST_signKeyValue();" >KB</a>
      <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("<!--"); %>
      <a href="javascript:TEST_signNoCache();" >증권</a>
      <a href="javascript:TEST_bondsSign(false);" >채권</a>
      <a href="javascript:TEST_bondsSign(true);" >멀티</a>
      <a href="javascript:TEST_mdSign(true);" >MD</a>
      <a href="javascript:TEST_cooconSign(true);" >C</a>
      <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("-->"); %>
      <a href="javascript:TEST_scrapingSign(true);" >#P1</a>
    </td>
  </tr>
  <tr>
    <td class="head"><b>인증서이동하기</b></td>
    <td class="body_l">
      ■ 중계서버를 이용한 인증서 로밍기능을 <a href="javascript:TEST_relayCheck();" >확인</a>합니다.
      <input type="button" value="내보내기" onclick="javascript:TEST_exportCertificate();" />
      <input type="button" value="가져오기" onclick="javascript:TEST_importCertificate();" />
  <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("<!--"); %>
      <a href="javascript:TEST_importCheck();" >test</a>
      <br/>
      ■ 브라우저 인증서 이동기능을 확인합니다.(G4전용)
      <input type="button" value="내보내기" onclick="javascript:TEST_exportCertificateG4();" />
      <input type="button" value="가져오기" onclick="javascript:TEST_importCertificateG4();" />
  <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("-->"); %>

      <form id="relayForm" name="relayForm">
          <input type="hidden" name="index" value="" />
          <input type="hidden" name="cmd" value="" />
          <input type="hidden" name="pubKey" value="" />
          <input type="hidden" name="clientAuth" value="" />
          <input type="hidden" name="serverAuth" value="" />
          <input type="hidden" name="sessionKey" value="" />
          <input type="hidden" name="signedData" value="" />
      </form>
    </td>
  </tr>

  <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("<!--"); %>
  <tr>
    <td class="head"><b>인증서 발급/갱신</b></td>
    <td class="body_l">
      ■ 참조번호/인가코드를 입력하여 인증서 발급/갱신을 테스트합니다.

      <form id="certForm" name="certForm">
          &nbsp;&nbsp;- 참조번호: <input type="text" name="referenceValue" value="93613" size=10 />
          &nbsp;&nbsp;
          <select name="caType">
            <option selected value="test">개발CA</option><option value="real">운영CA</option>
          </select>
          <select name="caName">
            <option selected value="yessign">금결원</option>
            <option value="crosscert">전자인증</option>
            <option value="signkorea">코스콤</option>
            <option value="kica">정보인증</option>
            <option value="yessignWebCmp">WebCmp</option>
            <option value="pincert">금융인증</option>
          </select>
          <br/>&nbsp;&nbsp;- 인가코드: <input type="text" name="secretValue" value="0912978800814393922" size=20 />
          &nbsp;&nbsp;
          <input type="button" value="인증서발급" onclick="javascript:TEST_requestCertificate();" />
          <input type="button" value="갱신"      onclick="javascript:TEST_updateCertificate();" />
      </form>
    </td>
  </tr>
  <% if (!"on".equals(getParameter(request, "viewExt"))) out.println("-->"); %>

</table>


<br/>
<table class="body" align="center" border="0" cellpadding="6" cellspacing="1" bgcolor="#E3E3E3">
  <tr>
    <td class="head">
      <b>테스트결과</b>
      <script type="text/javascript">document.write("[<b>"+DC_platformInfo.type+","+DC_platformInfo.name+","+DC_platformInfo.Mobile+"</b>][<b>"+DC_browserInfo.name+","+DC_browserInfo.version+"</b>]["+navigator.appName+"]");</script>
    </td>
  </tr>
  <tr>
    <td class="body" height="240">
      <iframe name='testResult' id='testResult' frameborder='0' width='100%' height='100%' src='<%=action%>'></iframe>
    </td>
  </tr>
</table>


<br/>
<hr width="80%" />
<table class="body" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40"><div style="font-size:9pt;" align="center">
      Copyrigh<a href="javascript:alert(document.cookie);">t</a> &#169; 2008-2014, <a href='http://www.wizvera.com' target="_new">WIZVERA</a> Co.,
      Ltd. All rights reserved.

        <script type="text/javascript">
        //<![CDATA[
        top.document.title = "[" + Delfino.getModule() + "]" + top.document.title;

        document.write(" <a href='javascript:fn_selectViewport();'>" + viewMobile + "</a>");
        document.write(" <a href='javascript:fn_selectEXT();'>"        + ((viewExt == "on") ? "EXT" : "HOME") + "</a>");
        document.write(" <a href='javascript:fn_selectSystemLang();'>" + _Delfino_SystemLang + "</a>");
        document.write(" <a href='javascript:fn_selectUiType();'>"     + ((DelfinoConfig.uiType == "senior") ? "senior" : "default") + "</a>");
        document.write(" <a href='javascript:fn_selectSystemMode();'>" + _Delfino_SystemMode + "</a>");
        document.write(" <a href='javascript:changeModuleTypeCookie();'>" + Delfino.getModule() + "</a>");
        if (Delfino.getModule() == "G3") {
            //document.write(" <a href=\"javascript:location.href=delfino.conf.handler.reqUrl + '/cacert.html'\">cacert</a>");
            //document.write(" <a href='" + _Delfino_Base + "/install/wizvera_ca.cer'>cacert</a>");
            //document.write(" <a href='javascript:delfino.handler.execute()'>exec</a>]");
        }
        //]]>
        </script>

    </div></td>
  </tr>
</table>

<script type="text/javascript">
//<![CDATA[
    //var cookieExpires = null;
    var cookieExpires = 365;
    var enableEA = false;
    var enableG5 = false;
    if (window.EA && ('object' === typeof window.EA)) enableEA = true;
    if (typeof(DelfinoConfig.g5) == "object") enableG5 = true;
    function changeModuleTypeCookie() {
        if (Delfino.getModule() == "G2") {
            var msg = "plug-in으로 동작하도록 설정되어 있습니다.\nnon-plugin으로 동작하도록 설정 하시겠습니까";
            if (confirm(msg)) {
                if (DelfinoConfig.module_org == "G3") {
                    Delfino_eraseCookie("delfinoModuleType");
                } else {
                    Delfino_createCookie('delfinoModuleType', 'G3', cookieExpires);
                }
            }
        }
        else if (Delfino.getModule() == "G3") {
            var msg = "non-plugin으로 동작하도록 설정되어 있습니다.\nhtml5(G4)으로 동작하도록 설정 하시겠습니까?";
            if (confirm(msg)) {
                if (DelfinoConfig.module_org == "G4") {
                    Delfino_eraseCookie("delfinoModuleType");
                } else {
                    Delfino_createCookie('delfinoModuleType', 'G4', cookieExpires);
                }
            }
        }
        else if (Delfino.getModule() == "G4" && enableG5) {
            var msg = "html5(G4)으로 동작하도록 설정되어 있습니다.\nhtml5(G5)으로 동작하도록 설정 하시겠습니까?";
            if (confirm(msg)) {
                if (DelfinoConfig.module_org == "G5") {
                    Delfino_eraseCookie("delfinoModuleType");
                } else {
                    Delfino_createCookie('delfinoModuleType', 'G5', cookieExpires);
                }
            }
        }
        else if (Delfino.getModule() == "G4" || Delfino.getModule() == "G5") {
            var msg = "html5(" + Delfino.getModule() + ")으로 동작하도록 설정되어 있습니다.\n통합인증(G10)으로 동작하도록 설정 하시겠습니까?";
            if (confirm(msg)) {
                if (DelfinoConfig.module_org == "G10") {
                    Delfino_eraseCookie("delfinoModuleType");
                } else {
                    Delfino_createCookie('delfinoModuleType', 'G10', cookieExpires);
                }
            }
        }
        else if (Delfino.getModule() == "G10" && enableEA) {
            var msg = "통합인증(G10)으로 동작하도록 설정되어 있습니다.\nCertGate으로 동작하도록 설정 하시겠습니까?";
            if (confirm(msg)) {
                if (DelfinoConfig.module_org == "EA") {
                    Delfino_eraseCookie("delfinoModuleType");
                } else {
                    Delfino_createCookie('delfinoModuleType', 'EA', cookieExpires);
                }
            }
        }
        else {
            var msg = "html5(" + Delfino.getModule() + ")으로 동작하도록 설정되어 있습니다.\nplug-in으로 동작하도록 설정 하시겠습니까?";
            if (confirm(msg)) {
                if (DelfinoConfig.module_org == "G2") {
                    Delfino_eraseCookie("delfinoModuleType");
                } else {
                    Delfino_createCookie('delfinoModuleType', 'G2', cookieExpires);
                }
            }
        }
        location.reload();
    }
    function clearModuleTypeCookie(goURL) {
        var msg = "delfinoModuleType[" + Delfino_readCookie("delfinoModuleType") + "]이 설정되어 있습니다. 삭제하시겠습니까?";
        if ((Delfino_readCookie("delfinoModuleType") != "") && confirm(msg)) {
            Delfino_eraseCookie("delfinoModuleType");
        }
        if (goURL) window.location.href = goURL;
    }
    //clearModuleTypeCookie();
    //window.onunload = function() {clearModuleTypeCookie();};

    if ((Delfino.getModule() == "G4" && !Delfino.isSupportedG4()) || (Delfino.getModule() == "G5" && !Delfino.isSupportedG4())) {
        var notice = DC_platformInfo.type + " " + DC_browserInfo.name  + "(" + DC_browserInfo.version + ") 으로 접속하셨습니다.";
        notice += "\nDelfino G4가 지원하지 않은 환경 입니다.";
        notice += "\n\n지원가능 브라우저 정보";
        notice += "\n  - MSIE 11 이상";
        notice += "\n  - Edge 12 이상";
        notice += "\n  - Chrome 38 이상";
        notice += "\n  - Firefox 38 이상";
        notice += "\n  - Opera 30 이상";
        notice += "\n  - Safari 10 이상";
        /*
        if (DC_platformInfo.Windows) {
            notice += "\n  - Safari 7.1 이상";
            //notice += "\n  - Safari 5.1.7 이상";
        } else {
            notice += "\n  - Safari 7.1 이상";
        }
        */

        /*
        if (DC_browserInfo.MSIE) {
            notice += "\n\n지원가능버전: " + DC_browserInfo.name + " 10  이상";
        } else if (DC_browserInfo.Chrome) {
            notice += "\n\n지원가능버전: " + DC_browserInfo.name + " 31  이상";
        } else if (DC_browserInfo.Firefox) {
            notice += "\n\n지원가능버전: " + DC_browserInfo.name + " 38  이상";
        } else if (DC_browserInfo.Safari) {
            var ver = "7.1";
            //if (DC_platformInfo.Windows) ver = "5.1.7";
            notice += "\n\n지원가능버전: " + DC_browserInfo.name + " " + ver + "  이상";
        } else if (DC_browserInfo.Opera) {
            notice += "\n\n지원가능버전: " + DC_browserInfo.name + " 30  이상";
        }
        */

        alert(notice);
    }
//]]>
</script>

<script type="text/javascript">
    function insertOpenCertJs() {
        try {
            var opencertSrc = DelfinoConfig.g4.opencert.relaySrc.replace("relay.js", "opencert.js");
            var script = document.createElement("script");
            script.src = opencertSrc + "?"+(new Date()).getTime();;
            document.body.appendChild(script);
        } catch (e) { alert(e); }
    }
    jQuery(document).ready(function() {
        if (Delfino.isSupportedG4() && DC_browserInfo.MSIE) insertOpenCertJs();
        if (viewExt == "on" && Delfino.isSupportedG4() && !ArrayBuffer.prototype.slice) alert("ArrayBuffer.prototype.slice is undefined");
    });

    jQuery(document).ready(function() {
        if (DC_browserInfo.MSIE && (Delfino.getModule()=="G3") && !Delfino_readCookie("delfino.preInstallCheck")) {
            setTimeout(function(){
                Delfino.isInstall(false, function(result){Delfino_createCookie("delfino.preInstallCheck", ""+result, 0);});
                //function tempError(param) { Delfino_createCookie("delfino.preInstallCheck", "false", 0); }
                //function tempSuccess()    { Delfino_createCookie("delfino.preInstallCheck", "true", 0);  }
                //delfino.handler.helper.isInstall({"ctx":{ajaxto:1000},"error":tempError,"success":tempSuccess});
            }, 100);
        }
    });

</script>

</body>
</html>
