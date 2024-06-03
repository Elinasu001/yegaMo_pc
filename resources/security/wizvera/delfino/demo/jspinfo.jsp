<%-- --------------------------------------------------------------------------
 - File Name   : jspinfo.jsp
 - Author      : WIZVERA
 - Last Update : 2020/11/16
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.text.*,java.lang.*,java.net.*" %>
<%
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
    boolean changeProvider = false;
%>

<%
/*
    changeProvider = true;
    if ("top".equals(request.getParameter("action"))) {
        java.security.Security.removeProvider("Wizvera");
        java.security.Security.insertProviderAt(new  com.wizvera.provider.jce.provider.WizveraProvider(), 1);
        out.println("<script type='text/javascript'>window.location.replace('" + request.getRequestURI() + "');</script>");
        return;
    }
    if ("add".equals(request.getParameter("action"))) {
        java.security.Security.addProvider(new  com.wizvera.provider.jce.provider.WizveraProvider());
        out.println("<script type='text/javascript'>window.location.replace('" + request.getRequestURI() + "');</script>");
        return;
    }
    if ("remove".equals(request.getParameter("action"))) {
        java.security.Security.removeProvider("Wizvera");
        out.println("<script type='text/javascript'>window.location.replace('" + request.getRequestURI() + "');</script>");
        return;
    }
*/
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Progma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <title>jspinfo()</title>
    <style type="text/css"> td { font-family : 굴림; font-size : 9pt; color:#000000; } </style>
    <script type="text/javascript">
    function findClass()  {
        var frm = document.getElementById('mainform');
        var findClass = frm.findClass.value;
        var sendUrl = location.pathname + "?findClass=" + findClass;
        alert(sendUrl);
        location.href=sendUrl;
    }
    </script>

</head>

<body>

<!-- DEMO HEAD start -->
<div style="font-size:10pt;">
  <script type="text/javascript">
  //<![CDATA[
    var color = "blue";
    document.write(" <span style='background-color:" + color + "'>　</span>");
    document.write(" <a href='./'>home</a> <a href='javascript:history.back();'>back</a> <a href='javascript:location.reload();'>reload</a>");
    document.write(" <a target='_new' href='" + window.location.href + "'>open</a>");
    document.write(" "+document.location.protocol+"//"+document.location.host+location.pathname);

  <% if (changeProvider) { %>
    document.write(" <a href='" + location.pathname  + "?action=add'>add</a>");
    document.write(" <a href='" + location.pathname  + "?action=remove'>remove</a>");
    document.write(" <a href='" + location.pathname  + "?action=top'>top</a>");
  <% } %>

  //]]>
  </script>
<hr/></div>
<!-- DEMO HEAD end -->

<%
    String _HostName_ = "local";
    String _HostAddr_ = "127.0.0.1";
    try {
        InetAddress inet = InetAddress.getLocalHost();
        _HostName_ = inet.getHostName();
        _HostAddr_ = inet.getHostAddress();
    } catch (Exception e) {
        //e.printStackTrace();
    }
    String _RemoteAddr_ = request.getRemoteAddr();
    String _ClientAddr_ = request.getHeader("Proxy-Client-IP");
    {
        if (_ClientAddr_ == null) _ClientAddr_ = request.getHeader("X-Forwarded-For");
        if (_ClientAddr_ == null) _ClientAddr_ = request.getHeader("WL-Proxy-Client-IP");
        if (_ClientAddr_ == null) _ClientAddr_ = _RemoteAddr_;
    }

    long _MaxMemory_ = Runtime.getRuntime().maxMemory()/1024/1024;
    long _TotalMemory_ = Runtime.getRuntime().totalMemory()/1024/1024;
    long _FreeMemory_ = Runtime.getRuntime().freeMemory()/1024/1024;
    DateFormat myDate = new SimpleDateFormat("yyyy-MM-dd HH:mm ss");
    Date currentTime = new Date();
    String _CurrentTime_ =  myDate.format(currentTime);
    String realPath = request.getSession().getServletContext().getRealPath("/");
    String resourcePath = "";

    try {
        URL resourceuri=null;
        resourceuri = request.getSession().getServletContext().getResource("/WEB-INF");
        if (resourceuri != null) resourcePath = resourceuri.getPath();
    } catch (Exception e) {
        e.printStackTrace();
        resourcePath = "";
    }
    String log4jConfig = request.getSession().getServletContext().getInitParameter("log4jConfigLocation");
    String acsConfig = request.getSession().getServletContext().getInitParameter("ACSManagerConfigFile");
%>
<%
    StringBuffer sb_provider = new StringBuffer();
    java.security.Provider [] provider = java.security.Security.getProviders();
    for (int i=0;i<provider.length;i++) {
        sb_provider.append("# ");
        sb_provider.append("<b>");
//      sb_provider.append((i+1)+ "[" + provider[i].getName() + "]");
        sb_provider.append((i+1)+ "[" + provider[i].toString() + "]");
        sb_provider.append("</b></font> : ");
        sb_provider.append(provider[i].getInfo());
//      sb_provider.append("key = " + provider[i].keySet());
//      sb_provider.append(" = " + provider[i].values());
//      java.security.Security.removeProvider(provider[i].getName());
        sb_provider.append("<br></font>\n");

    }
%>
<%
    StringBuffer sb_path = new StringBuffer();
    String classpath = System.getProperty("java.class.path");
    StringTokenizer st = new StringTokenizer(classpath, ";");
    //out.println("<br>");
    while(st.hasMoreTokens()) {
        String key = st.nextToken();
        sb_path.append("# ");
        if (    (key.indexOf("INIC") >-1) || (key.indexOf("jCert") >-1) || (key.indexOf("INIT") >-1)
             || (key.indexOf("INIS") >-1)  || (key.indexOf("Plugin") >-1) || (key.indexOf("jOCS") >-1)
             || (key.indexOf("jVID") >-1)  || (key.indexOf("jCERT") >-1) || (key.indexOf("jCRL") >-1)
             || (key.indexOf("KFTC") >-1)  || (key.indexOf("Xenon") >-1) || (key.indexOf("Sign") >-1)
             || (key.indexOf("IniD") >-1)  || (key.indexOf("PKCS") >-1) || (key.indexOf("jSVS") >-1)
             || (key.indexOf("CSP") >-1)  || (key.indexOf("Double") >-1) || (key.indexOf("INIL") >-1)
             || (key.indexOf("CA") >-1)  || (key.indexOf("RA") >-1) || (key.indexOf("Artemis") >-1)


            )
            sb_path.append("<b>" + key + "</b><br>");
        else
            sb_path.append(key + "<br>");
    }
%>

<%
    StringBuffer sb_pkg      = new StringBuffer();
    String findClass = request.getParameter("findClass");
    String[] pkgName =  {   "hsqldb.jar",
                            "ojdbc14.jar",
                            "db2jcc.jar",
                            "sqljdbc4.jar",
                            "ACSManager-lib.jar",
                            "bcprov-jdk1X-xxx.jar",
                            "bcmail-jdk1X-xxx.jar",
                            "",

                            //"CertZone-lib.jar",
                            //"xmldap-1.0.0.1-kr.jar",
                            //"ca-core.jar",
                            //"applicationConfig.xml",
                            //"ca.p12",
                            //"avod.properties",
                            //"ocsp.properties",

                            "wizvera_prov.jar",
                            "wizvera_pkix.jar",
                            "delfino.jar",
                            "delfino-g4.jar",
                            "",
                            "delfino-v3.jar",
                            "delfino-vpcg-agent.jar",
                            "delfino-vpcg-server.jar",
                            "httpcore-4.2.4.jar",
                            "httpclient-4.1.jar",
                            "commons-logging-1.1.1.jar",
                            "commons-codec-1.4.jar",
                            "json-20200518.jar",
                            "",

                            //"WizveraConfig",
                            //"CertificateVerifier",
                            //"CertUtil",
                            //"PolicyChecker",
                            //"CACerts",
                            //"Base64",

                            "pinsign.jar",
                            "pinsign25.jar",
                            "wizvera_jose4j.jar",
                            "wizvera_jsonrpc.jar",
                            "wizvera_jackson.jar",
                            "jackson-core.jar",
                            "jackson-databind.jar",
                            "jackson-annotations.jar",
                            "commons-lang.jar",

                            "INICrypto.jar",
                        };
    String[] clasName = {   "/org/hsqldb/jdbcDriver.class",
                            "/oracle/jdbc/OracleDriver.class",
                            "/com/ibm/db2/jcc/DB2Driver.class",
                            "/com/microsoft/sqlserver/jdbc/SQLServerDriver.class",
                            "/com/wizvera/acs/config/web/ACSManagerConfigInit.class",
                            "/org/bouncycastle/jce/provider/BouncyCastleProvider.class",
                            "/org/bouncycastle/cms/CMSProcessable.class",
                            "",

                            //"/com/wizvera/certzone/config/web/ApplicationConfigInit.class",
                            //"/org/xmldap/util/KeystoreUtil.class",
                            //"/com/wizvera/deviceca/core/util/CertUtil.class",
                            //"/config/applicationconfig.xml",
                            //"/config/key/ca.p12",
                            //"/config/profile/avod.properties",
                            //"/config/profile/ocsp.properties",

                            "/com/wizvera/provider/jce/provider/WizveraProvider.class",
                            "/com/wizvera/cms/CMSProcessable.class",
                            "/com/wizvera/crypto/PKCS7Verifier.class",
                            "/com/wizvera/delfino/html5/Service.class",
                            "",
                            "/com/wizvera/crypto/pkcs7/PKCS7VerifyWithVpcg.class",
                            "/com/wizvera/vpcg/VpcgSignResult.class",
                            "/com/wizvera/vpcg/VpcgConfig.class",
                            "/org/apache/http/HttpResponse.class",
                            "/org/apache/http/client/HttpClient.class",
                            "/org/apache/commons/logging/Log.class",
                            "/org/apache/commons/codec/Encoder.class",
                            "/org/json/JSONString.class",
                            "",

                            //"/com/wizvera/WizveraConfig.class",
                            //"/com/wizvera/crypto/CertificateVerifier.class",
                            //"/com/wizvera/crypto/CertUtil.class",
                            //"/com/wizvera/crypto/PolicyChecker.class",
                            //"/com/wizvera/crypto/CACerts.class",
                            //"/com/wizvera/util/Base64.class",

                            "/com/wizvera/pinsign/PinSignManager.class",
                            "/com/wizvera/pinsign25/PinSignManager.class",
                            "/com/wizvera/jose4j/jws/JsonWebSignature.class",
                            "/com/wizvera/jsonrpc/JsonRpcClient.class",
                            "/com/wizvera/jackson/core/JsonFactory.class",
                            "/com/fasterxml/jackson/core/JsonParser.class",
                            "/com/fasterxml/jackson/databind/ObjectMapper.class",
                            "/com/fasterxml/jackson/annotation/JacksonAnnotation.class",
                            "/org/apache/commons/lang/StringUtils.class",

                            "/com/initech/provider/crypto/InitechProvider.class",
                        };

    if (findClass == null) findClass = "";
    clasName[clasName.length-1] = findClass;

    for (int i=0; i<clasName.length; i++) {
        if ("".equals(clasName[i])) {
            sb_pkg.append("");
            sb_pkg.append("<hr/>");
            continue;
        }
        java.net.URL clasUrl = this.getClass().getResource(clasName[i]);
        sb_pkg.append("# ");
        if (clasUrl != null) {
            sb_pkg.append("");
            if (clasName[i].indexOf("/com/wizvera/")==0) sb_pkg.append("<font color='#2E2EFE'>");
            sb_pkg.append("<b>" + pkgName[i] + "</b>");
            if (clasName[i].indexOf("/com/wizvera/")==0) sb_pkg.append("</font>");
            sb_pkg.append(" [" + clasName[i] + "]\n");

            sb_pkg.append("<br>&nbsp;&nbsp;&nbsp;");
            sb_pkg.append("<font face='돋움' color='#2F83C3'><span style='font-size:8pt;'>");
            sb_pkg.append("<img src='rp_bullet.gif' width='7' height='7' border='0'> </span></font>");
            sb_pkg.append("<font size='2' color='navy'>");
            String clsFile = clasUrl.getFile();
            sb_pkg.append(clsFile.substring(0, clsFile.lastIndexOf("!")));
            //sb_pkg.append(clasUrl.getFile());
            sb_pkg.append("</font>");

        } else {
            sb_pkg.append("");
            sb_pkg.append(pkgName[i] + " [" + clasName[i] + "] not found");
        }
        sb_pkg.append("<br>");
    }
%>

<%
    StringBuffer sb_crypto = new StringBuffer();
    String[] pkgName2 =  {"Cipher", "PBEKeySpec", "SUN JCE", "Base64Util",
                         //"Sunrsasign", "Forge",  "JCE", "Cryptix-jce12-provider",
                         "X509Certificate", "PKIXCertPathBuilderResult", "CertPath"
    };
    String[] clasName2 = {
              "/javax/crypto/Cipher.class",
              "/javax/crypto/spec/PBEKeySpec.class",
              "/sun/security/provider/Sun.class",
              "/sun/misc/BASE64Encoder.class",

              //"/com/sun/rsajca/Provider.class",
              //"/au/com/forge/provider/ForgeProvider.class",
              //"/au/net/aba/crypto/provider/ABAProvider.class",
              //"/cryptix/jce12/provider/Cryptix.class",

              "/java/security/cert/X509Certificate.class",
              "/java/security/cert/PKIXCertPathBuilderResult.class",
              "/java/security/cert/CertPath.class"
    };
    for (int i=0; i<clasName2.length; i++) {
        java.net.URL clasUrl = this.getClass().getResource(clasName2[i]);
        sb_crypto.append("# ");
        if (clasUrl != null) {
            sb_crypto.append("");
            sb_crypto.append("<b>" + pkgName2[i] + "</b>: " + clasName2[i] + "</font>\n");

            sb_crypto.append("<br>&nbsp;&nbsp;&nbsp;");
            sb_crypto.append("<font face='돋움' color='#2F83C3'><span style='font-size:8pt;'>");
            sb_crypto.append("<img src='rp_bullet.gif' width='7' height='7' border='0'> </span></font>");
            sb_crypto.append("<font size='2' color='navy'>");
            String clsFile = clasUrl.getFile();
            sb_crypto.append(clsFile.substring(0, clsFile.lastIndexOf("!")));
            //sb_crypto.append(clasUrl.getFile());
            sb_crypto.append("</font>");

        } else {
            sb_crypto.append("");
            sb_crypto.append(pkgName2[i] + ": " + clasName2[i] + ": not found");
        }
        sb_crypto.append("<br>");
    }
%>


<div style="font-size:9pt;">
<form id="mainform">

<table border='0' cellpadding='2' cellspacing='0' width='800'>
    <tr>
        <td colspan='2' bgcolor='silver'><p align='center'><b>Server Info[<%=_ClientAddr_%>][<%=request.getServerName()%>][<%=request.getServerPort()%>][<%=request.getLocalPort()%>]</b></p></td>
    </tr>
    <tr>
        <td bgcolor='#F5F6F4'>
            <table cellpadding='0' cellspacing='0'>
              <tr>
                <td width=350>
                    # HostName : <b><%=_HostName_%></b><br>
                    # HostAddress : <b><%=_HostAddr_%></b><br>
                    # RemoteAddr : <b><%=_RemoteAddr_%></b><br>
                </td>
                <td>
                    # currentDate : <b><%=_CurrentTime_%></b><br>
                    # totalMemory : <b><%=_TotalMemory_%> </b>MB : maxMemory(<%=_MaxMemory_%> MB)<br>
                    # freeMemory : <b><%=_FreeMemory_%> </b>MB<br>
                </td>
              </tr>
            </table>
        </td>
    </tr>

    <tr>
        <td colspan='2' bgcolor='silver'><p align='center'><b>ACSManager Info</b></p></td>
    </tr>
    <tr>
        <td bgcolor='#F5F6F4'>
            <table cellpadding='0' cellspacing='0'>
              <tr>
                <td colspan=2>
                    # user.home : <b>[<%=System.getProperty("user.home")%>]</b><br>
                    # wizvera.home : <b>[<%=System.getProperty("wizvera.home")%>]</b><br>
                    # wizvera.name : <b>[<%=System.getProperty("wizvera.name")%>]</b><br>
                    # acsConfig : <b>[<%=acsConfig%>]</b><br>
                    # log4jConfig : <b>[<%=log4jConfig%>]</b><br>
                    # reapPath : <b>[<%=realPath%>]</b><br>
                    # resourcePath : <b>[<%=resourcePath%>]</b><br>
                </td>
              </tr>
            </table>
        </td>
    </tr>

    <tr><td colspan='2' bgcolor='silver'><p align='center'>
        <b>Provider Check</b></p>
    </td></tr>
    <tr><td bgcolor='#F5F6F4'>
        <%=sb_provider.toString()%>
    </td></tr>

    <tr><td colspan='2' bgcolor='silver'><p align='center'>
        <b>JAVA Default JCE Search</b></p>
    </td></tr>
    <tr><td bgcolor='#F5F6F4'>
        <%=sb_crypto.toString()%>
    </td></tr>

    <tr><td colspan='2' bgcolor='silver'><p align='center'>
        <b>WIZVERA Package Search</b></p>
    </td></tr>
    <tr><td bgcolor='#F5F6F4'>
        <%=sb_pkg.toString()%>
        input find Class : <input size="80" type="text" name="findClass" value="<%=findClass%>">
                    <a href="javascript:findClass();">findClass()</a>
    </td></tr>

    <tr><td colspan='2' bgcolor='silver'>
        <p align='center'><b>java.class.path</b></p>
    </td></tr>
    <tr><td bgcolor='#F5F6F4'>
        <%=sb_path.toString()%>
    </td></tr>

    <tr><td colspan='2' bgcolor='silver'>
        <p align='center'><b>Server Environment</b></p>
    </td></tr>
    <tr><td bgcolor='#F5F6F4'><table>

<%
    Enumeration e = System.getProperties().propertyNames();
    while(e.hasMoreElements())
    {
        String key = (String)e.nextElement();
        String tmp = System.getProperty(key);
        String value = "";
        int j = 77;
        int ii = 0;
        for (ii=0; ii<tmp.length()-j; ii=ii+j) {
            value += tmp.substring(ii, j+ii) + "<br>";
        }
        value += tmp.substring(ii, tmp.length());
        if (key.equals("java.class.path")) continue;

%>
    <tr>
        <td bgcolor='#F5F6F4'># <%=key%></td>
        <td bgcolor='#F5F6F4'><%=value%></td>
    </tr>
<%
    } /* end of while */
%>
    </table></td></tr>

</table>
</form>
</div>

<!-- DEMO TAIL start -->
<div style="font-size:9pt;" align="left"><hr>
    <script>document.write(document.cookie);</script><br/>
</div>
<div style="font-size:9pt;" align="left">
    Copyright &#169; 2008-2020, <a href='http://www.wizvera.com' target="_new">WIZVERA</a> Co., Ltd. All rights reserved
</div>
<!-- DEMO TAIL end -->

<div style="font-size:10pt;" align="left">
<%
    out.println("<!--");
    String originalStr = "테스트";
    //originalStr = "Å×½ºÆ®";
    String [] charSet = {"UTF-8","EUC-KR","KSC5601","ISO-8859-1","X-WINDOWS-949"};
    for (int i=0; i<charSet.length; i++) {
      for (int j=0; j<charSet.length; j++) {
        try {
          //System.out.println("[" + charSet[i] +"," + charSet[j] +"] = " + new String(originalStr.getBytes(charSet[i]), charSet[j]));
          out.println("<br/>[" + charSet[i] +"," + charSet[j] +"] = " + new String(originalStr.getBytes(charSet[i]), charSet[j]));
        } catch (Exception ee) {
          ee.printStackTrace();
        }
      }
    }
    out.println("-->");
%>
</div>

</body>
</html>
