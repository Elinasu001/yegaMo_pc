<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="net.nshc.nfilter.openweb.service.OpenWebNFilterKeypadManager" %>

<%
	String nFilterHTML = null;
	String isMobileString = ((String) request.getParameter("nfilter_is_mobile"));
	boolean isMobile = false;
	if (isMobileString != null) isMobile = Boolean.parseBoolean(isMobileString);

	OpenWebNFilterKeypadManager kepadManager = new OpenWebNFilterKeypadManager(getServletConfig(), request, response);

	// TODO token을 생성하는 로직 필요함.

    // 생성된 token을 설정.
	//kepadManager.setToken("aaaaaaaaaaaaa");

    nFilterHTML = kepadManager.initializer(true);

    //String sessionData = OpenWebNFilterSessionManager.getSessionData(session);
    // TODO tokenId와 sessionData를 저장하는 로직 추가 필요함.

    // TODO TEST. 실제 사용시에는 삭제 해야함.
    //OpenWebNFilterSessionManager.sessionData = sessionData;
    //session.invalidate();
    // << TEST.
%>
<%=nFilterHTML%>