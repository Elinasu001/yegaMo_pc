<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    static java.security.SecureRandom random = new java.security.SecureRandom();
%>
<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", -1);
%>
<%
    byte[] nonceBuf = new byte[20];
    random.nextBytes(nonceBuf);
    //String nonce = new String(org.bouncycastle.util.encoders.Base64.encode(nonceBuf));
    //String nonce = new String(com.wizvera.provider.util.encoders.Base64.encode(nonceBuf));
    String nonce = new String(com.wizvera.util.Base64.encode(nonceBuf));
    session.setAttribute("delfinoNonce", nonce);
%>
<%=nonce%>