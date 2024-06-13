<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="org.springframework.mobile.device.Device"%>
<%@page import="org.springframework.mobile.device.DeviceUtils"%>
<%
    String systemMode = "real";
    String systemLang = "KOR";
    String siteName = "delfino";
    String moduleType = "";
	Device device = DeviceUtils.getCurrentDevice(request);
	// if (!device.isNormal()) moduleType = "G4";
%>
<script type="text/javascript">
    //<![CDATA[
    var _SITE_SystemMode = "<%=systemMode%>"; //"real", "test"
    var _SITE_SystemLang = "<%=systemLang%>"; //"KOR", "ENG", "CHN", "JPN"
    var _SITE_SiteName = "<%=siteName%>";     //"pc", "mobile", "tablet"
    var _SITE_ModuleType = "<%=moduleType%>"; //"", "G2", "G3", "G4"
    //]]>
</script>
