<%--
 * (C) Copyright AhnLab, Inc.
 *
 * Any part of this source code can not be copied with
 * any method without prior written permission from
 * the author or authorized person.
 *
 * @version		$Revision: 15612 $
 *
--%>

<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>


<%@page import="java.io.*,java.util.*"%>

<!DOCTYPE HTML> <!-- HTML5 -->
<html>
<head>
<meta charset="utf-8" />
<title>astx2</title>


<script src="astx2.min.js"></script>
<script src="astx2_custom.js"></script>
<style>

</style>

</head>
<body>

<div id="spinner"></div>
	
<div id="content">
	<p>ASTx를 실행하여 주십시오...</p>
</div>


<p>&nbsp;</p>
<p><strong>[ASTx 설치파일 다운로드]</strong> <br>
<a href='http://safetx.ahnlab.com/master/win/default/all/astx_setup.exe'>다운로드(CDN)</a><br><br>
<a href='./astx_setup_offline_ygr.exe'>다운로드(오프라인)</a><br><br>
<script>
window.onload = function() 
{
	
		
	doATX2CheckRun();
}

function gotoRedirectPage()
{
	<%
		String url = request.getParameter("page");
		if(null == url) url = "";
	%>
	
	window.location.href = "<%=url%>";
}

function doATX2CheckRun()
{
	$ASTX2.init(
		function onSuccess() {
			$_astxu.log('ASTX.init() success');
			gotoRedirectPage()
		},
		function onFailure() {
			var errno = $ASTX2.getLastError();
			$_astxu.log('ASTX.init() failure: errno='+errno);
			
			if(errno == $ASTX2_CONST.ERROR_NOTINST)	{
				setTimeout(function(){
					doATX2CheckRun();
				}, 500); // 0.5 seconds
			}
		}
	);
}
</script>

</body>
</html>
