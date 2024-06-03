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

<!DOCTYPE HTML> <!-- HTML5 -->
<html>
<head>
<meta charset="utf-8" />
<title>astx2</title>

<script src="include.js"></script>

</head>
<body>

<p>AhnLab Safe Transaction</p>

<div>
<%
	ASTX2LibCompact astx2 = new ASTX2LibCompact(request);

	//astx2.setUniqueId(uniqid);
	
	String value;

	out.println("<hr/>");
	out.println("<span class='params'>#e2e names1</span><br/><br/>");
	
	value = astx2.getE2ENames();
	out.println("errno="+astx2.getLastError()+"<br/><br/>");	

	if(value.length() > 0)
	{	
		String[] names1 = value.split(",");
	 	for(String name: names1) {
	 		value = astx2.getE2EValue(name);
	 		out.println(name+"="+value+"<br/>");
		}
	}

	out.println("<hr/>");
	out.println("<span class='params'>#e2e names2</span><br/><br/>");
	value = astx2.getE2ENames2();
	out.println("errno="+astx2.getLastError()+"<br/><br/>");
	
	if(value.length() > 0)
	{
		String[] names2 = value.split(",");
	 	for(String name: names2) {
	 		value = astx2.getE2EValue2(name);
	 		out.println(name+"="+value+"<br/>");
		}
	}
%>
</div>

<div>
<%
	out.println("<hr/>");
	out.println(String.format("input1[<b>%s</b>]-input2[<b>%s</b>]-input3[<b>%s</b>]-input4[<b>%s</b>]<br/><br/>", 
		astx2.getE2EValue("cardno1"), astx2.getE2EValue2("cardno2"), astx2.getE2EValue2("cardno3"), astx2.getE2EValue("cardno4")));	

	out.println(String.format("userid[<b>%s</b>], passwd[<b>%s</b>]<br/>", 
			astx2.getE2EValue("userid"), astx2.getE2EValue("passwd")));	
	out.println("<hr/>");			
%>
</div>

<script>
window.onload = function() 
{
	checkInstallASTX2();
}
</script>

</body>
</html>
