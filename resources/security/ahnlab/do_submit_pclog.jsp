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

<%@page import="java.util.*"%>
<%@page import="java.util.Map"%>
<%@page import="com.ahnlab.astx2.servlet.ASTX2LibCompact"%>
<%@page import="com.ahnlab.astx2.util.Util"%>

<!DOCTYPE HTML> <!-- HTML5 -->
<html>
<head>
<meta charset="utf-8" />
<title>astx2</title>

<link rel="stylesheet" href="inc/common.css" />

</head>
<body>

<p>AhnLab Safe Transaction</p>

<p>
<%
	//astx2.setUniqueId(uniqid);
	
	String pincode = request.getParameter("pin");
	if(true == pincode.equalsIgnoreCase("ahnlab-315"))
	{
		String name, value;
		ASTX2LibCompact astx2 = new ASTX2LibCompact(request);
		
		out.println("<hr/>");
		out.println("#IP address<br/><br/>");
		out.println("<b>RemoteAddr</b>="+Util.getNC(request.getRemoteAddr())+"<br/>");
		out.println("<b>ClientIPAddr</b>="+Util.getNC(astx2.getClientIPAddress())+"<br/>");
		
		out.println("<hr/>");

		/*
		@SuppressWarnings("unchecked")
		Enumeration<String> names1 = request.getHeaderNames();
		while(names1.hasMoreElements()) 
		{
	  	 name = (String)names1.nextElement();
		   value = request.getHeader(name);
		   
			out.println("<b>"+name+"</b>="+Util.getNC(value)+"<br/>");
		}
		out.println("<hr/>");
		
		@SuppressWarnings("unchecked")
		Enumeration<String> names2 = session.getAttributeNames();
		while (names2.hasMoreElements())
		{
				name  = (String)names2.nextElement();
			  value = (String)session.getAttribute(name);
		  
				out.println("<b>"+name+"</b>="+Util.getNC(value)+"<br/>");
		}
		out.println("<hr/>");
		*/
					
		Map<String, String> mapPCLOG = astx2.getPCLOGMap();
		if(mapPCLOG.size() > 0) 
		{
			for(Map.Entry<String, String> elm: mapPCLOG.entrySet())
			{
				name  = elm.getKey();
				value = elm.getValue();
		 		out.println(name+"="+value+"<br/>");
			}
		}
		else
		{
			out.println("errno="+astx2.getLastError());
		} // end of if
		
	} // end of if
%>
</p>

</body>
</html>
