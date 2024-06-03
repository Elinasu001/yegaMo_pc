<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String systemMode = "test";
    String systemLang = "KOR";
    String siteName = "delfino";
    String moduleType = "";

    //아래코드는 테스트용입니다. 다국어 적용시 아래코드를 업무에 맞게 변경하세요.
    /*
    {
        String imsi = "";
        imsi = (String)session.getAttribute("systemMode");
        if ("test".equals(imsi)) systemMode = "test";

        imsi = (String)session.getAttribute("systemLang");
        if (imsi != null && !"".equals(imsi) ) systemLang = imsi;
    }
    */

    //아래코드는 html5 테스트를 위한 임시 설정입니다. 업무에 맞게 변경하세요.
    {
        //데모페이지일경우
        if (request.getRequestURI().indexOf("/demo/") >= 0) {
            //파라메터에 html5=on이 입력될경우 설정된 값을 무시하고 html5로 강제로 설정됨
            if ("on".equals(request.getParameter("html5"))) moduleType = "G4";
        }
        //데모페이지가 아닐 경우
        else {
            //특정브라우저(크롬)만 html5로 강제 설정하기 위한 샘플
            String userAgent = request.getHeader("User-Agent");
            //if (userAgent.indexOf("Chrome")>=0) moduleType = "G4";

            //특정IP만 html5로 강제 설정하기 위한 샘플
            String clientIP = request.getHeader("X-Forwarded-For");
            if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getHeader("Proxy-Client-IP");
            if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getHeader("WL-Proxy-Client-IP");
            if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getHeader("HTTP_CLIENT_IP");
            if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getHeader("HTTP_X_FORWARDED_FOR");
            if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getRemoteAddr();
            //out.println("<!--" + clientIP + "-->");
            //if ("127.0.0.1".equals(clientIP)) moduleType = "G4";
        }
    }

%>
<script type="text/javascript">
//<![CDATA[
    var _SITE_SystemMode = "<%=systemMode%>"; //"real", "test"
    var _SITE_SystemLang = "<%=systemLang%>"; //"KOR", "ENG", "CHN", "JPN"
    var _SITE_SiteName = "<%=siteName%>";     //"pc", "mobile", "tablet"
    var _SITE_ModuleType = "<%=moduleType%>"; //"", "G2", "G3", "G4"
//]]>
</script>

<%
    String _delfinoNoCache = "20210726";
    //_delfinoNoCache = new java.text.SimpleDateFormat("yyMMdd_HHmm").format(new java.util.Date());
%>
<%
    boolean _useDelfinoLoader = false; //script 동적로딩 기능 사용여부
    //if ("true".equals(request.getParameter("useDelfinoLoader"))) _useDelfinoLoader = true;
%>
<script src="/resources/security/wizvera/delfino/jquery/jquery-1.6.4.min.js" charset="utf-8"></script>
<% if (!_useDelfinoLoader) { %>
<script src="/resources/security/wizvera/delfino/delfino_config.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
<script src="/resources/security/wizvera/delfino/delfino_internal.min.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
<script src="/resources/security/wizvera/delfino/delfino.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
<script src="/resources/security/wizvera/delfino/delfino_site.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
<% } else { %>
<script src="/resources/security/wizvera/delfino/delfino_loader.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
<% } %>

<!--
<script src="/wizvera/certgate/certgate_config.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
<script src="/wizvera/certgate/certgate_common.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
<script src="/wizvera/certgate/certgate.js?<%=_delfinoNoCache%>" charset="utf-8"></script>
-->
