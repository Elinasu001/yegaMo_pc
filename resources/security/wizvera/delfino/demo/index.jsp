<%-- --------------------------------------------------------------------------
 - File Name   : index.jsp(델피노 데모)
 - Include     : delfino.jsp
 - Author      : WIZVERA
 - Last Update : 2020/11/27
-------------------------------------------------------------------------- --%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
%>
<%
    boolean isVeraPortCG = false;
    java.net.URL _clasUrl1 = this.getClass().getResource("/com/wizvera/crypto/pkcs7/PKCS7VerifyWithVpcg.class");
    java.net.URL _clasUrl2 = this.getClass().getResource("/com/wizvera/vpcg/VpcgSignResult.class");
    if (_clasUrl1 != null && _clasUrl2 != null) isVeraPortCG = true;
%>
<%
    if ("on".equals(request.getParameter("debug"))&&"debug".equals(request.getParameter("g4"))) session.setAttribute("delfino_demo_debug", "on");
    if ("on".equals(request.getParameter("mobile"))) {
        session.setAttribute("delfino_mobile_demo", "on");
        response.sendRedirect(request.getRequestURI());
        return;
    } else if ("off".equals(request.getParameter("mobile"))) {
        session.setAttribute("delfino_mobile_demo", "off");
        response.sendRedirect(request.getRequestURI());
        return;
    }
    if (session.getAttribute("delfino_mobile_demo") == null) {
        if (request.getRequestURL().indexOf("https://mts.wizvera.com")==0) session.setAttribute("delfino_mobile_demo", "on");
        if (request.getRequestURL().indexOf("https://mts2.wizvera.com")==0) session.setAttribute("delfino_mobile_demo", "on");
        if (request.getHeader("User-Agent").indexOf("Mobi")>=0) session.setAttribute("delfino_mobile_demo", "on");
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Progma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
<%
    if ("on".equals(session.getAttribute("delfino_mobile_demo"))) {
        out.println("    <meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width' />");
    }
%>
    <title>WizIN-Delfino Sample</title>

    <%@ include file="../svc/delfino.jsp"%>

</head>

<body>
    <h1>
        WizIN-<%=((isVeraPortCG) ? "통합인증" : "Delfino")%> <script type="text/javascript">document.write(DelfinoConfig.module);</script> Sample
        <font size=2><a href="./index.jsp">home</a></font>
    </h1>

    <h2><script type="text/javascript">document.write((Delfino.getModule()=="G3") ? "non-plugin" : ((Delfino.getModule()=="G2") ? "plug-in" : ((Delfino.getModule()=="EA") ? "CertGate" : "html5-" + Delfino.getModule())));</script></h2>
    <ul>
        <li><a href="login.jsp">로그인/본인확인</a>
          <% if ("on".equals(request.getParameter("debug"))) { %>
            <a href="login.jsp?auto=on&debug=on">auto</a>
          <% } else { %>
            <a href="login.jsp?auto=on">auto</a>
          <% } %>
        </li>
        <li><a href="sign.jsp">전자서명</a></li>
      <% if ("on".equals(request.getParameter("debug"))) { %>
        <li><a href="./etc/">확장기능</a></li>
      <% } %>

    </ul>

    <script type="text/javascript">
    var startTime = new Date();
    function result_isInstall(result) {
        var endTime = new Date();
        var ret = ""; result ? ret='정상설치됨' : ret='미설치';
        ret += " execTime[" + Math.floor( endTime.getTime() - startTime.getTime() ) / 1000 + "]\n";
        ret += "\n[" + startTime.getHours() + ":" + startTime.getMinutes() + ":" + startTime.getSeconds() + ":" + startTime.getMilliseconds() + "]";
        ret += "~[" + endTime.getHours() + ":" + endTime.getMinutes() + ":" + endTime.getSeconds() + ":" + endTime.getMilliseconds() + "]";
        ret += " supportSync[" + delfino.conf.handler.supportSync + "," + delfino.conf.handler.checkAjaxto + "]";
        ret += "\n\n" + startTime;
        ret += "\n" + endTime;
        alert(ret);
    }
    </script>
    <h2>etc</h2>
    <ul>
        <li>
          <script type="text/javascript">
            if (document.location.hostname.indexOf("wizvera.com") > 0) {
                document.write(" <a href=\"javascript:Delfino.setModule('EA'); location.href='/wizvera/certgate/test.jsp?mobile=on';\">PC간편인증</a>");
            }
          </script>
        </li>
        <li><a href="javascript:startTime=new Date(); Delfino.isInstall(false, result_isInstall);">installCheck</a>
            <a href="javascript:Delfino.setVersion();alert('버전설정이 변경되었습니다 ['+ window.DC_version.WinIE + ']');">set</a>
        </li>
        <li><a href="javascript:Delfino.manageCertificate();">manageCertificate</a></li>
        <li><a href="javascript:Delfino.getMACAddress(function(mac){alert(mac);});">getMACAddress</a></li>
        <li><a href="javascript:location.href=DelfinoConfig.installPage.WinMoz">installPage</a>
            <a href="javascript:var open_win=window.open(_Delfino_Base+'/install20/install_mini.html', 'install', 'resizable=yes, toolbar=0, menubar =0, height=400, width=320'); open_win.focus();">mini</a>
        </li>
    </ul>

    <h2>svc</h2>
    <ul>
        <li>
            <a href="../svc/delfino_check.jsp">check</a>
            <script type="text/javascript">
            var viewMobile = "PC";
            if ("on" == "<%=session.getAttribute("delfino_mobile_demo")%>") viewMobile = "mobile";
            function fn_selectViewport() {
                var msg = "모바일용 viewport meta 태그를 추가합니다.";
                if (viewMobile=="mobile") msg = "모바일용 viewport meta 태그를 제거합니다.";
                var redirectURL = location.pathname + "?mobile=" + ((viewMobile == "mobile") ? "off" : "on");
                //alert(viewMobile + "\n" + redirectURL);
                if (confirm(msg)) window.location.href = redirectURL;
            }
            document.write("<a href='javascript:fn_selectViewport();'>" + viewMobile + "</a>");
            </script>
        </li>
        <li><a href="../svc/delfino.jsp">delfino.jsp</a></li>
        <li><a href="javascript:location.href=DelfinoConfig.nonceUrl">nonce.jsp</a></li>
        <!-- li><a href="javascript:location.href=DelfinoConfig.urlHanlderServerUrl + '?cmd=init'">handler.jsp</a></li -->
    </ul>


  <% if ("on".equals(request.getParameter("debug"))) { %>
    <ul>
        <li><a href="javascript:location.href=DelfinoConfig.mobileUrlHandlerServerUrl">mobileUrlHandlerServerUrl</a></li>
        <li><a href="javascript:location.href=DelfinoConfig.processingImageUrl">processingImageUrl</a></li>
        <li><a href="javascript:location.href=DelfinoConfig.mobileCloseHtml">mobileCloseHtml</a></li>
        <li><a href="javascript:location.href=DelfinoConfig.g4.signServerUrl + '/ui.jsp?userAgent=_Edge'">signServerUrl</a></li>
        <li><a href="javascript:location.href=delfino.conf.handler.reqUrl + '/cacert.html'">handler SSL Check</a></li>
    </ul>
    <ul>
        <li><a href="./jspinfo.jsp">jspinfo</a></li>
        <li><a href="http://www.motobit.com/util/base64-decoder-encoder.asp">base64</a> <a href="https://holtstrom.com/michael/tools/asn1decoder.php">ASN.1</a></li>
    </ul>
  <% } %>


  <% if ("on".equals(request.getParameter("debug"))) { %>
    <h3><%=com.wizvera.WizveraConfig.getDefaultPropertiesPath()%></h3>
    <ul>
        <li>wizvera.home [<%=System.getProperty("wizvera.home", "")%>]</li>
        <li>delfino.home [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("delfino.home")%>]</li>
    </ul>
    <ul>
        <li>nonce.name [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("nonce.name")%>]</li>
        <li>vid.idn.name [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("vid.idn.name")%>]</li>
    </ul>
    <ul>
        <li>oidfile.path [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("oidfile.path")%>]</li>
        <li>cacertificates.path [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("cacertificates.path")%>]</li>
        <li>error.info.conf.path [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("error.info.conf.path")%>]</li>
        <li>cert.usage.oid.path [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("cert.usage.oid.path")%>]</li>
    </ul>
    <ul>
        <li>crl.use.cache [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("crl.use.cache")%>]</li>
        <li>crl.cache.type [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("crl.cache.type")%>]</li>
        <li>crl.store.root [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("crl.store.root")%>]</li>
    </ul>
    <ul>
        <li>ocsp.responder.host [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.responder.host")%>]</li>
        <li>ocsp.responder.port [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.responder.port")%>]</li>
        <li>ocsp.responder.url.context.directory [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.responder.url.context.directory")%>]</li>
        <li>ocsp.client.certificate.path [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.client.certificate.path")%>]</li>
        <li>ocsp.client.privatekey.path [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.client.privatekey.path")%>]</li>
        <li>ocsp.message.store.path [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.message.store.path")%>]</li>
        <li>ocsp.message.debug.type [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.message.debug.type")%>]</li>
    </ul>
    <ul>
        <li>logging.instance.name [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("logging.instance.name")%>]</li>
        <li>crl.logging [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("crl.logging")%>]</li>
        <li>crl.logging.dir [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("crl.logging.dir")%>]</li>
        <li>ocsp.logging [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.logging")%>]</li>
        <li>ocsp.logging.dir [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("ocsp.logging.dir")%>]</li>
    </ul>
    <ul>
        <%
            int relaySvrCnt = Integer.parseInt(com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("certRelay.server.cnt", "2"));
            out.println("<li>certRelay.server.cnt [" + com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("certRelay.server.cnt") + "]</li>");
            for (int i=0; i<relaySvrCnt; i++) {
                out.println("<li>" + "certRelay.server."+(i+1) + " [" + com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("certRelay.server."+(i+1)) + "]</li>");
            }
        %>
        <%
            String proKey = request.getParameter("property");
            if (proKey!=null && !"".equals(proKey)) out.println("<li>" + proKey + "[" + com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty(proKey) + "]</li>");
        %>
    </ul>
    <ul>
        <li>use.vpcg [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("use.vpcg")%>]</li>
        <li>vpcg.mode [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("vpcg.mode")%>]</li>
        <li>pcg.sdk.prop.file.name [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("vpcg.sdk.prop.file.name")%>]</li>
        <li>vpcg.request.url [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("vpcg.request.url")%>]</li>
        <li>vpcg.result.url [<%=com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("vpcg.result.url")%>]</li>
    </ul>
  <% } %>

<script type="text/javascript">
//<![CDATA[
    function clearModuleTypeCookie() {
        var msg = "delfinoModuleType[" + Delfino_readCookie("delfinoModuleType") + "]이 설정되어 있습니다. 삭제하시겠습니까?";
        if ((Delfino_readCookie("delfinoModuleType") != "") && confirm(msg)) {
            Delfino_eraseCookie("delfinoModuleType");
            location.reload();
        }
    }
    clearModuleTypeCookie();
//]]>
</script>

  <hr />
  <div style="font-size:9pt;" align="left">
    <%=logDate.format(new java.util.Date())%>
    <script type="text/javascript">document.write("["+(DC_platformInfo.Mobile?"mobile,":"")+(DC_platformInfo.x64?DC_platformInfo.name+",":"")+DC_browserInfo.name+","+DC_browserInfo.version+"]");</script>
    Copyright &#169; 2008-2015, <a href='http://help.wizvera.com' target="_new">WIZVERA</a> Co., Ltd. All rights reserved
    <script type="text/javascript">
        top.document.title = "[" + Delfino.getModule() + "]" + top.document.title;
        var hostname = document.location.hostname;
        if (hostname.indexOf("wizvera.com") > 0) {
            var idx = hostname.indexOf(".");
            var oldHost = hostname.substring(0, idx);
            var newHost = oldHost + "2";
            if (hostname.indexOf("2") > 0 || hostname.indexOf("1") > 0) newHost = hostname.substring(0, idx-1);
            document.write("&nbsp;&nbsp;<a href='" + window.location.href.replace(oldHost, newHost) + "'>" + newHost + "</a>");

            var newProtocol = ("https:" == window.location.protocol) ? "http:" : "https:";
            var newSite = window.location.href.replace(window.location.protocol, newProtocol);
            if ("https:" == newProtocol) {
                newSite = newSite.replace(":8080", ":8443");
            } else {
                newSite = newSite.replace(":8443", ":8080");
            }
            document.write(" <a href='" + newSite + "'>" + newProtocol + "</a>");
            document.write(" <br/>[" + navigator.userAgent + "] [<a href='javascript:alert(document.cookie);'>cookie</a>]");
        }
    </script>
  </div>

</body>
</html>
