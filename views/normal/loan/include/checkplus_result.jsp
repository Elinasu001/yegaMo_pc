<%@page import="com.google.gson.Gson"%>
<%@page language="java" contentType="text/html;charset=utf-8" %>
<% Gson gson = new Gson(); %>
<html>
<head>
</head>
<body>
<script>
	try{
		opener.auth_result(<%= gson.toJson(request.getAttribute("result"))%>);
	}catch(e) {
		opener.auth_result(e);
	}finally{
		window.close();
	}
</script>
</body>
</html>
