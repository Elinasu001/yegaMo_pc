<%--
 * (C) Copyright AhnLab, Inc.
 *
 * Any part of this source code can not be copied with
 * any method without prior written permission from
 * the author or authorized person.
 *
 * @version		$Revision: 18097 $
 *
--%>
<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>

<%@page import="com.ahnlab.astx2.servlet.ASTX2Lib"%>

<%
	ASTX2Lib astx2 = new ASTX2Lib(config, request, response);
	//astx2.setUniqueId(uniqid);

	// doGetCert	
	out.println(astx2.doGetCert());
%>