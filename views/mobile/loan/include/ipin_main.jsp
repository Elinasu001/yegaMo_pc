<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form id="form_chk" name="form_chk" method="post">
	<input type="hidden" name="m" />
    <input type="hidden" name="enc_data" />
    <input type="hidden" name="param_r1" value="">
    <input type="hidden" name="param_r2" value="">
    <input type="hidden" name="param_r3" value="">
</form>
<script>
document.form_chk.enc_data.value = '${encData}';
document.form_chk.m.value = '${m}';
document.form_chk.action = "<c:url value='${url}' />";
document.form_chk.submit();
</script>
</body>
</html>
