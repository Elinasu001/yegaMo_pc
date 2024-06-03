<%--
 * (C) Copyright AhnLab, Inc.
 *
 * Any part of this source code can not be copied with
 * any method without prior written permission from
 * the author or authorized person.
 *
 * @version		$Revision: 13486 $
 *
--%>
<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page isErrorPage="true"%>

<!DOCTYPE HTML> <!-- HTML5 -->
<html>
<head>
<meta charset="utf-8" />
<title>astx2 error</title>

<link rel="stylesheet" href="inc/common.css" />

</head>

<body>

<p>요청 처리 과정에서 에러가 발생하였습니다.</p>
<p>에러 타입 : <%= exception.getClass().getName() %><br/><p>

</body>
</html>
