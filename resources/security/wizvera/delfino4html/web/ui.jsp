<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.util.regex.Pattern" %>
<%!
    public static String getParameter(HttpServletRequest request, String name) {
        String sValid = request.getParameter(name);

        if (sValid == null || sValid.equals("")) return sValid;
        sValid = sValid.replaceAll("&", "&amp;");
        sValid = sValid.replaceAll("<", "&lt;");
        sValid = sValid.replaceAll(">", "&gt;");
        sValid = sValid.replaceAll("\"", "&qout;");
        sValid = sValid.replaceAll("\'", "&#039;");
        sValid = sValid.replaceAll("\\r", "");
        sValid = sValid.replaceAll("\\n", "");
        sValid = sValid.replaceAll("\\\\", "/");
        return sValid;
    }
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <title>델피노 전자 서명</title>
<%
    // ************************************************************* //
    // 설정
    // 이미지(img, css, js) 서버가 별도로 있는 경우 설정
    String staticServer = null;
    //staticServer = "https://oimg1.kbstar.com/js/common/wizvera/html5/";
    //staticServer = "https://help.wizvera.com/wizvera/delfino4html/";
    String serviceJsp = "svc/delfino4html.jsp";

    String originUrl = getParameter(request, "origin");
    String enableOpencertServer = getParameter(request, "opencert");
    String encryptedParams = getParameter(request, "encryptedParams");
    if(encryptedParams != null && !Pattern.matches("^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$", encryptedParams)) {
        encryptedParams = null;
    }
    String enablePreload = getParameter(request, "preload");
    String profileOn = "false";
    String logger = null;
    Date now = new Date();

    // String now = now.getFullYear();
    String year = String.valueOf(1900+now.getYear());
    String month = String.valueOf(now.getMonth()+1);
    if(month.length() == 1) month = "0" + month;
    String date = String.valueOf(now.getDate());
    if(date.length() == 1) date = "0" + date;
    String today = year + month + date;

    // Opencert 주소 설정.
    String opencertTest = "https://fidoweb.yessign.or.kr:3100/v2/opencert.js";
    String opencertReal = "https://www.yessign.or.kr:3100/v2/opencert.js";
    String opencertWizvera = "https://opencert.wizvera.com:3100/v2/opencert.js";

    if("test".equals(enableOpencertServer)) {
        enableOpencertServer = opencertTest;
    } else if("real".equals(enableOpencertServer)) {
        enableOpencertServer = opencertReal;
    } else if("wizvera".equals(enableOpencertServer)) {
        enableOpencertServer = opencertWizvera;
    } else {
        enableOpencertServer = "off";
    }

    String onlyOpencert = getParameter(request, "useOnlyOpencert");

    // String browserType = request.getHeader("User-Agent");

    String delfino_html5_jar_buildDate = null;
    String delfino_html5_jar_buildVersion = null;
    try {
        delfino_html5_jar_buildDate = com.wizvera.delfino.html5.Service.BUILD_DATE;
        delfino_html5_jar_buildVersion = com.wizvera.delfino.html5.Service.BUILD_VERSION;
    } catch(Exception e) {
        delfino_html5_jar_buildDate = "";
        delfino_html5_jar_buildVersion = "";
    }

    String releaseDate = "2023-05-12T06_37_44.694Z";
    String releaseYYMMDD = "230512";
    String delfino4htmlUrl = "delfino4html.compiled.js?" + releaseDate;
    String delfino4htmlUIUrl = "delfino4html-ui.compiled.js?" + releaseDate;
    String licenseDomainUrl = "domain.js?" + releaseDate;
	Boolean g10Enabled = false;

    //delfino4htmlUrl = "../build/delfino4html.min.js?" + releaseDate;
    //delfino4htmlUIUrl = "../build/delfino4html-ui.min.js?" + releaseDate;
    //licenseDomainUrl = "../domain_licensed/domain_delfino4html.js?" + releaseDate;
	
	String vpcgUrl = "vpcg.js?" + releaseDate;
	
	//vpcgUrl = "../vpcg/vpcg.js?" + releaseDate;
%>
    <script type="text/javascript">
        var dynamicBaseURI = window.location.href.substring(0, window.location.href.lastIndexOf('/')+1);
    </script>
<%
    if (staticServer != null) {
        out.println("    <base href='"+ staticServer +  "'/>");
    }

    String mode= getParameter(request, "mode");
    if (mode == null) mode= "desktop";

    // out.println("    <!-- mode=" + mode+ " -->");
	
	String g10 = getParameter(request, "g10");
	if(g10 != null && g10.equals("true")) g10Enabled = true;
    // ************************************************************* //
%>
    <script type="text/javascript">
<% if (staticServer != null) { %>
        var staticBaseURI = "<%=staticServer%>";
<% } else { %>
        var staticBaseURI = dynamicBaseURI;
<% } %>
        var Delfino4HtmlConfig = {
            dynamicBaseURI : dynamicBaseURI,
            staticBaseURI : staticBaseURI
        };
        Delfino4HtmlConfig.serviceURI = dynamicBaseURI + '<%=serviceJsp%>';
        Delfino4HtmlConfig.serviceJsp = '<%=serviceJsp%>';
        Delfino4HtmlConfig.mode = '<%=mode%>';
        Delfino4HtmlConfig.originURI = '<%=originUrl%>';
        Delfino4HtmlConfig.enableOpencertServer = '<%=enableOpencertServer%>';
        if(Delfino4HtmlConfig.enableOpencertServer == 'on') {
            Delfino4HtmlConfig.enableOpencertServer = true;
        } else if(Delfino4HtmlConfig.enableOpencertServer == 'off') {
            Delfino4HtmlConfig.enableOpencertServer = false;
        } else {
            Delfino4HtmlConfig.encryptedParams = '<%=encryptedParams%>';
            Delfino4HtmlConfig.useOpencertV2= true;
            // Delfino4HtmlConfig.enableOpencertServer = false;
        }
        Delfino4HtmlConfig.useOnlyOpencert = "<%=onlyOpencert%>" == "true";
        Delfino4HtmlConfig.releaseYYMMDD = '<%=releaseYYMMDD%>';
        Delfino4HtmlConfig.releaseDate = '<%=releaseDate%>';
        // Delfino4HtmlConfig.certpinServerUrl = 'https://demo.wizvera.com/demo/certpin';
        // Delfino4HtmlConfig.webauthnUrl = 'https://webauthn.wizvera.com/api/resources/js/webauthn-api.js';
        var preload = '<%=enablePreload%>';
        if(preload == "on") {
            preload = true;
        } else {
            preload = false;
        }
		Delfino4HtmlConfig.g10Enabled = "<%=g10Enabled%>" == "true";
        Delfino4HtmlConfig.profileOn = ('<%=profileOn%>'=='true');
<%if(logger!=null){%>Delfino4HtmlConfig.logger = '<%=logger%>';<%}%>

        Delfino4HtmlConfig.enablePreload = preload;
        function authCodeValidator(e){ var k=e.keyCode,l=e.target.value.length;if(k<48||k>57||l>3){e.preventDefault()}; }
    </script>
    <!-- *************************************************************  -->

    <!-- no favicon -->
    <link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
    <!-- dependency for jquery -->
    <link rel="stylesheet" href="jquery/ui-smoothness-1.11.2.css?<%=releaseDate%>"/>
    <script src="jquery/jquery-3.3.1.min.js?20151104"></script>
    <!--[if IE 9]><script src="jquery/jquery.xdomainrequest.min.js?20190724"></script>
    <script>window.isIE9 = true;</script><![endif]-->
    <!-- dependency for Promise -->
    <script src="bluebird/bluebird.min.js?20180413"></script>

<%if(logger!=null){%><script src="logger.js?20180413"></script><%}%>
    <link rel="stylesheet" type="text/css" href="connected/Switch.css?<%=releaseDate%>" />

<% if ( !( "on".equals(enableOpencertServer) || "off".equals(enableOpencertServer) ) ) { %>
    <!--[if gt IE 10]><!--><script src="<%=enableOpencertServer%>?dt=<%=today%>&corp=000"></script><!--<![endif]-->
<% } %>
    <!--[if gt IE 10]><!--<script type="text/javascript" src="https://demo.wizvera.com/demo/certpin/certpin-api.js"></script><![endif]-->
    <!--[if gt IE 10]><!--<script type="text/javascript" src="https://webauthn.wizvera.com/api/resources/js/webauthn-api.js"></script><![endif]-->
<% if (mode.equals("serviceOnly")) { %>

<% } else if (mode.equals("mobile")) { %>
    <!-- mobile -->
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width"/>

	<link id="coreCSS" type="text/css" rel="stylesheet" media="screen" href="web20touch/css/core.css?v2">
	<link id="mainCSS" type="text/css" rel="stylesheet" media="screen" href="web20touch/css/apple.css?v2">

	<script type="text/javascript" src="web20touch/includes/jsTouch.js?v3"></script>
	<script type="text/javascript" src="web20touch/includes/iscroll.js"></script>

    <link rel="stylesheet" type="text/css" href="mobile.css?<%=releaseDate%>" />
<% } else { %>
    <!-- desktop or tablet -->

    <!-- dependency for w2ui -->
    <link rel="stylesheet" type="text/css" href="w2ui/w2ui-1.4.2.css?<%=releaseDate%>" />
    <script type="text/javascript" src="w2ui/w2ui-1.4.2.js?<%=releaseDate%>"></script>
    <script type="text/javascript" src="w2ui/w2ui-popup-multi.js?<%=releaseDate%>"></script>

<%      if (mode.equals("desktop")) { %>
    <link rel="stylesheet" type="text/css" href="desktop.css?<%=releaseDate%>" />
    <!-- dependency for downloadify -->
    <script type="text/javascript" src="qrcode/qrcode.min.js"></script>
    <script type="text/javascript" src="qrcode/uuid.min.js"></script>
<%      } else if (mode.equals("tablet")) { // tablet %>
    <link rel="stylesheet" type="text/css" href="tablet.css?<%=releaseDate%>" />
<%      } %>

<% } %>

	<!-- VPCG script -->
<%
	if(g10Enabled) {
%>
	<script type="text/javascript" src="<%=vpcgUrl%>"></script>
<%
	}
%>

    <!-- delfino4html -->
<% if (!mode.equals("serviceOnly")) { %>
    <script type="text/javascript" src="delfino4html.cp949.min.js?<%=releaseDate%>"></script>
<% } %>
    <script type="text/javascript" src="<%=delfino4htmlUIUrl%>"></script>
    <script type="text/javascript" src="<%=licenseDomainUrl%>"></script>
<%if(logger!=null){%><script>wizvera.logOn=true;</script><%}%>
    <!-- version -->
    <script type="text/javascript">
<%if(delfino_html5_jar_buildVersion!=null){%>
        document.write('<!-- delfino_html5.jar version : <%=delfino_html5_jar_buildVersion%> -->');
<%}%>
<%if(delfino_html5_jar_buildDate!=null){%>
        document.write('<!-- delfino_html5.jar date : <%=delfino_html5_jar_buildDate%> -->');
<%}%>
        document.write('<!-- delfino4thml version : ' + wizvera.version + ' -->');
        document.write('<!-- delfino4thml date : ' + wizvera.buildDate + ' -->');
    </script>

</head>
<body>

<% if (mode.equals("serviceOnly")) { %>
   <!-- serviceOnly mode -->
<% } else if (mode.equals("mobile")) { %>
    <%@ include file="mobile-body.jsp" %>
<% } else if (mode.equals("tablet")) {%>
    <%@ include file="tablet-body.jsp" %>
<% } else {%>
    <%@ include file="desktop-body.jsp" %>
<% } %>
<script>
    if(window.opener) {
        document.body.style = "background-color: rgba(0,0,0,0.3);"
    }
</script>
</body>
</html>
