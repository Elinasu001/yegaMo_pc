<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.delfino.html5.*" %>
<%!
static {
	//10분동안 저장하고 5분바다 timer 돌면서 10분이 지난 데이터 삭제
	//CertTransferDataService.setConfig(10*60*1000, 5*60*1000); 
}
%>
<%=CertTransferDataService.service(request)%>