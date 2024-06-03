<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="net.nshc.nfilter.openweb.service.OpenWebNFilterImageManager"%>
<%@ page import="net.nshc.nfilter.openweb.service.OpenWebNFilterSessionManager" %>

<%
    //JSP에서 사용할 때 구현해주세요.
    out.clear();
	out = pageContext.pushBody();
	//====================

    String tokenId = request.getParameter("token");
    if (tokenId == null) {
        new OpenWebNFilterImageManager( getServletConfig(), request, response ).initializer();
    } else {
        String sessionData = null;
        // TODO keypad_manager에서 저장한 sessionData를 가져오는 로직 추가 필요함.

        // TODO TEST. 삭제되어야 하는 코드입니다
        sessionData = OpenWebNFilterSessionManager.sessionData;
        // << TEST.

        // 세션 데이터 설정
        OpenWebNFilterSessionManager.setSessionData(session, sessionData);
        new OpenWebNFilterImageManager( getServletConfig(), request, response ).initializer();

        // TODO TEST. 테스트를 위해 세션을 날려버림.
        session.invalidate();
        // << TEST.
    }
%>