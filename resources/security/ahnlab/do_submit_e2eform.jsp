<%--
 * (C) Copyright AhnLab, Inc.
 *
 * Any part of this source code can not be copied with
 * any method without prior written permission from
 * the author or authorized person.
 *
 * @version		$Revision: 18635 $
 *
--%>
<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>

<%@page import="java.util.*,com.ahnlab.astx2.servlet.ASTX2LibCompact"%>
<%ASTX2LibCompact astx2 = new ASTX2LibCompact(request);%>

<!DOCTYPE HTML> <!-- HTML5 -->
<html>
<head>
<meta charset="utf-8" />
<title>astx2</title>

<link rel="stylesheet" href="inc/common.css" />

</head>
<body>

<p>AhnLab Safe Transaction</p>

<hr/>
<div>
<%
	String value;

	out.println("<span class='params'>#params</span><br/><br/>");
	
	@SuppressWarnings("unchecked")
	Enumeration<String> lists = request.getParameterNames();
	while(lists.hasMoreElements())
	{
		String name = lists.nextElement();
		if(name.indexOf("e2e_") >= 0) continue; // skip e2e hiddend fields
		
		value = request.getParameter(name);
		out.println(name+"="+value+"<br/>\n");
	}
%>
</div>
<hr/>

<div>
<%
	out.println("<span class='params'>#e2e_form names1</span><br/><br/>");

	value = astx2.getE2EFormNames();
	if(value.length() > 0) 
	{	
		String[] names1 = value.split(",");
	 	for(String name: names1) {
 			value = astx2.getE2EFormValue(name);
 			out.println("<b>"+name+"</b>="+value+"<br/>");
		}
	}

	out.println("<br/>");
	out.println("<span class='params'>#e2e_form names2</span><br/><br/>");
	
	value = astx2.getE2EFormNames2();
	if(value.length() > 0) 
	{	
		String[] names2 = value.split(",");
	 	for(String name: names2) {
 			value = astx2.getE2EFormValue2(name);
 			out.println("<b>"+name+"</b>="+value+"<br/>");
		}
	}	
%>
</div>

<hr/>
<div>
<%
	out.println("<span class='params'>#e2e_form raw</span><br/><br/>");

	String e2e_forminit = request.getParameter("_e2e_forminit_e2e_1__");
	
	boolean result = astx2.setE2EFormInitRaw(e2e_forminit);
	if(false == result)
	{
		int errno = astx2.getLastError();
		out.println("<br/>setE2EFormInitRaw failed(errno="+errno+")<br/>");
	}
	else
	{
		value = request.getParameter("userid_e2e_1__");
		String userid = astx2.getE2EFormValueRaw(value);
		out.println("<b>userid</b>="+userid+"<br/>");
		
		value = request.getParameter("passwd_e2e_1_pwd__");
		String passwd = astx2.getE2EFormValueRaw(value);
		out.println("<b>passwd</b>="+passwd+"<br/>");
	}
%>
</div>
<hr/>

<script>
window.onload = function() 
{

}
</script>

</body>
</html>
