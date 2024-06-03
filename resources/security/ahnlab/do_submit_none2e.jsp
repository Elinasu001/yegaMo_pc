<%--
 * (C) Copyright AhnLab, Inc.
 *
 * Any part of this source code can not be copied with
 * any method without prior written permission from
 * the author or authorized person.
 *
 * @version		$Revision: 14352 $
 *
--%>
<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>

<%@page import="java.util.*"%>

<!DOCTYPE HTML> <!-- HTML5 -->
<html>
<head>
<meta charset="utf-8" />
<title>astx2</title>

<link rel="stylesheet" href="inc/common.css" />

</head>
<body>

<p>AhnLab Safe Transaction</p>

<div>
<hr/>
<%
	String value;
	out.println("#params<br/><br/>\n");
	
	@SuppressWarnings("unchecked")
	Enumeration<String> list = request.getParameterNames();
	
	while(list.hasMoreElements())
	{
		String name = list.nextElement().toString();

		value = request.getParameter(name);
		out.println(name+"="+value+"<br/>\n");
	}
%>
<hr/>
</div>

</body>
</html>
