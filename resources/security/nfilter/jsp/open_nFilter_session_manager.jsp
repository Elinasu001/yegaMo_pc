<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /**
     * 세션에 임의의 값을 세팅하기 위해 Open_nFilter.js 에서 keypad생성 ajax통신 전에 먼저 시행된다.
     * Open_nFilter.js 에서 세션에 set한 sesCheck4iframe 값을 get에서 null이 아닌 경우
     * keypad생성 ajax통신을 태우고 null인 경우 동일한 세션이 아니라고 판단하여
     * callback함수를 이용하여 후처리를 할 수 있게 구성되어 있음
     */
    session.setAttribute("sesCheck4iframe", "sesCheck4iframe");
%>
