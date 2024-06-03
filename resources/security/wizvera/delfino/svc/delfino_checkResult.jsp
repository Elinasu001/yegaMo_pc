<%-- --------------------------------------------------------------------------
 - File Name   : delfino_checkResult.jsp
 - Author      : WIZVERA
 - Include     : NONE
 - Last Update : 2021/02/08
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="com.wizvera.crypto.*" %>
<%
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
%>
<%!
    public static String _requestEncoding = ""; //"8859_1"
    public static String getRequestValue(String value) {
        try {
            if (value == null || "".equals(value) || "".equals(_requestEncoding)) return value;
            return new String(value.getBytes(_requestEncoding));
        } catch (Exception e) {};
        return value;
    }
    public static String signedData2PKCS7(String pkcs7) throws CryptoException {
        return com.wizvera.service.SignVerifier.toContentInfo(pkcs7);
        /*
        try {
            byte[] der7 = com.wizvera.util.Base64.decode(pkcs7);
            org.bouncycastle.asn1.ASN1InputStream aIn = new org.bouncycastle.asn1.ASN1InputStream(new java.io.ByteArrayInputStream(der7));
            org.bouncycastle.asn1.cms.SignedData sData = org.bouncycastle.asn1.cms.SignedData.getInstance(aIn.readObject());
            org.bouncycastle.asn1.cms.ContentInfo info = new org.bouncycastle.asn1.cms.ContentInfo(org.bouncycastle.asn1.cms.CMSObjectIdentifiers.signedData, sData);
            pkcs7 = new String(com.wizvera.util.Base64.encode(info.getEncoded()));
            return pkcs7;
        }
        catch (Exception e) {
            throw new CryptoException(CryptoException.SIGN_ERROR, "signedData parse error", e);
        }
        */
    }
%>
<%
    request.setCharacterEncoding("utf8");
    com.wizvera.WizveraConfig delfinoConfig = com.wizvera.WizveraConfig.getDefaultConfiguration();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Progma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <title>::: Welcome to Wizvera ::: 전자서명테스트결과</title>
    <style type="text/css">
    body {
      font-family:'dotum';
      font-size:10pt;
    }
    ul {margin:0; padding-left:10px;}
    </style>
</head>

<body>

<div style="font-size:9pt;">
<% try { %>

<%
    boolean isDebug = false;
    if ("on".equals(request.getParameter("debug"))) isDebug = true;

    StringBuffer sb = new StringBuffer();
    StringBuffer sbCert = new StringBuffer();

    //String requestInfo = request.getContextPath() + request.getServletPath();
    //requestInfo = "  <li><b>Request Info: </b>" + request.getRequestURI() + " " + request.getMethod() + "[" + request.getRemoteAddr() + "]</li>\n";
    DateFormat myDate = new SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    sb.append("  <li>Request Info: <b>" + request.getRequestURI() + " " + request.getMethod() + "[" + request.getRemoteAddr() + "]</b> " + myDate.format(new Date()) + "</li>\n");
    {
        sb.append("  <ul>\n");
        Enumeration em = request.getParameterNames();
        while (em.hasMoreElements()) {
            String name = (String)em.nextElement();
            String value[] = request.getParameterValues(name);
            if (value == null) {
                sb.append("    <li>getParameter(\"" + name + "\") = [null]</li>\n");
            } else if ("withoutSignedPkcs7".equals(name) || "withoutSignedPkcs1".equals(name) || "signingTime".equals(name) || "signingCert".equals(name)) {
                //skip
            } else {
                for (int i=0; i<value.length; i++) {
                    if (PKCS7Verifier.PKCS7_NAME.equals(name)) {
                        String SIGN_Delimeter = request.getParameter("SIGN_Delimeter");
                        if (SIGN_Delimeter == null || SIGN_Delimeter.equals("")) SIGN_Delimeter = "|"; //"￡";
                        if ("|".equals(SIGN_Delimeter)) SIGN_Delimeter = "\\" + SIGN_Delimeter;
                        String[] pkcs7Array = value[i].split(SIGN_Delimeter);
                        String[] withoutSignedPkcs7Array = request.getParameter("withoutSignedPkcs7").split(SIGN_Delimeter);
                        String[] withoutSignedPkcs1Array = request.getParameter("withoutSignedPkcs1").split(SIGN_Delimeter);

                        //sb.append("<li>request.getParameter(\"pkcs7Array\") = [???size=" + value[i].length() + "???][" + pkcs7Array.length + "][" + SIGN_Delimeter + "]");
                        //sb.append("<!--\n" + value[i] + "\n-->");

                        String[] detachedDigestArray = request.getParameter("detachedMD").split(SIGN_Delimeter);
                        for(int k=0; k<pkcs7Array.length; k++) {
                            try {
                                String pkcs7 = pkcs7Array[k];
                                String pkcs7Hex = "";
                                try {
                                    if ("hex".equals(request.getParameter("PKCS_TYPE"))) {
                                        pkcs7Hex = pkcs7;
                                        byte[] imsi = com.wizvera.util.Hex.decode(pkcs7Hex);
                                        pkcs7 = com.wizvera.util.Base64.encode(imsi);
                                    } else if ("base64Url".equals(request.getParameter("PKCS_TYPE"))){
                                        String Base64Padding[] = { "", "===", "==", "=" };
                                        pkcs7 = pkcs7.replace('-', '+').replace('_', '/').replaceAll("\\r|\\n", "");
                                        pkcs7 += Base64Padding[pkcs7.length() % 4];
                                        byte[] imsi = com.wizvera.util.Base64.decode(pkcs7.getBytes());
                                        pkcs7Hex = com.wizvera.util.Hex.encode(imsi);
                                    } else if ("signedData".equals(request.getParameter("PKCS_TYPE"))){
                                        //String Base64Padding[] = { "", "===", "==", "=" };
                                        //pkcs7 = pkcs7.replace('-', '+').replace('_', '/').replaceAll("\\r|\\n", "");
                                        //pkcs7 += Base64Padding[pkcs7.length() % 4];
                                        byte[] imsi = com.wizvera.util.Base64.decode(pkcs7.getBytes());
                                        pkcs7Hex = com.wizvera.util.Hex.encode(imsi);
                                        pkcs7 = signedData2PKCS7(pkcs7);
                                    } else {
                                        byte[] imsi = com.wizvera.util.Base64.decode(pkcs7.getBytes());
                                        pkcs7Hex = com.wizvera.util.Hex.encode(imsi);
                                    }
                                } catch (Exception e) {
                                    java.io.StringWriter sw = new java.io.StringWriter();
                                    java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                                    e.printStackTrace(pw);
                                    sb.append("<!--\n" + sw.toString() + "\n-->\n");
                                };

                                sb.append("<!--\n[PKCS7.b64]\n" + pkcs7 + "\n-->\n");
                                sb.append("<!--\n[PKCS7.hex]\n" + pkcs7Hex + "\n-->\n");
                                sb.append("<!--\n[PKCS7Dump.dump]\n" + PKCS7Dump.dumpAsString(pkcs7) + "\n-->\n");
                                sb.append("    <li>getParameter(\"PKCS7\") = [???size=" + pkcs7.length() + "???]["+k+"]</li>\n");
                                System.out.println(PKCS7Dump.dumpAsString(pkcs7));

                                X509Certificate userCert = null;
                                String signingTime = "";
                                sbCert.append("  <li>----------------------------------------------------------------------[" + k + "]</li>\n");
                                if ("mdSign".equals(request.getParameter("PKCS_TYPE"))) {
                                    com.wizvera.service.DetachedSignVerifier detachedSignVerifier = new com.wizvera.service.DetachedSignVerifier(delfinoConfig);
                                    com.wizvera.service.SignVerifierResult signVerifierResult = detachedSignVerifier.verifyPKCS7(pkcs7);
                                    userCert = signVerifierResult.getSignerCertificate();
                                    signingTime = signVerifierResult.getSignerInfoResults().get(0).getSigningTimeInLocalTime();

                                    String detachedDigest = detachedDigestArray[k];
                                    Map<String, byte[]> messageDigestMap = signVerifierResult.getMessageDigestMap();
                                    for(String key : messageDigestMap.keySet()) {
                                        String strValue = com.wizvera.util.Hex.encode(messageDigestMap.get(key));
                                        if (strValue.equals(detachedDigest)) {
                                            sbCert.append("  <li>Detached(mdSign) Check: <b>OK</b>[" + strValue + "]</li>\n");
                                        } else {
                                            sbCert.append("  <li>Detached(mdSign) Check: <b>FAIL</b>[" + strValue + "]</li>\n");
                                        }
                                    }
                                } else {
                                    String encoding = request.getCharacterEncoding();
                                    if ("signedData".equals(request.getParameter("PKCS_TYPE"))) encoding = "euc-kr"; //, ""utf8";
                                    PKCS7Verifier p7verifier = new PKCS7Verifier(pkcs7, encoding);
                                    userCert = p7verifier.getSignerCertificate();
                                    signingTime = p7verifier.getSignerInfoResults().get(0).getSigningTimeInLocalTime();

                                    //TODO: scrapingSign
                                    String withoutSignedPkcs7 = "";
                                    String withoutSignedPkcs1 = "";
                                    try {
                                        if (k < withoutSignedPkcs7Array.length) {
                                            withoutSignedPkcs7 = withoutSignedPkcs7Array[k];
                                        } else if ("scrapingSign".equals(request.getParameter("PKCS_TYPE"))) {
                                            sbCert.append("  <li>withPkcs1 Check: <b>ERROR.withoutSignedPkcs7Array.size</b></li>");
                                        }
                                        if (k < withoutSignedPkcs1Array.length) {
                                            withoutSignedPkcs1 = withoutSignedPkcs1Array[k];
                                        } else if ("scrapingSign".equals(request.getParameter("PKCS_TYPE"))) {
                                            sbCert.append("  <li>withPkcs1 Check: <b>ERROR.withoutSignedPkcs1Array.size</b></li>");
                                        }

                                        if (withoutSignedPkcs7.length() > 0) {
                                            sb.append("    <li>getParameter(\"<b>withoutSignedPkcs7</b>\") = [???size=" + withoutSignedPkcs7.length() + "???]["+k+"]</li>\n");
                                            sb.append("<!--\n[withoutSignedPkcs7.b64]\n" + withoutSignedPkcs7 + "\n-->\n");
                                            sb.append("<!--\n[withoutSignedPkcs7Dump.dump]\n" + PKCS7Dump.dumpAsString(withoutSignedPkcs7) + "\n-->\n");
                                        }
                                        if (withoutSignedPkcs1.length() > 0) {
                                            sb.append("    <li>getParameter(\"<b>withoutSignedPkcs1</b>\") = [???size=" + withoutSignedPkcs1.length() + "???]["+k+"]</li>\n");
                                            sb.append("<!--\n[withoutSignedPkcs1.b64]\n" + withoutSignedPkcs1 + "\n-->\n");
                                        }

                                        if (k == 0 && "scrapingSign".equals(request.getParameter("PKCS_TYPE"))) {
                                            sb.append("    <li>getParameter(<b>\"signingTime\"</b>) = [<b>" + request.getParameter("signingTime") + "</b>]</li>\n");
                                            String signingCert = request.getParameter("signingCert");
                                            if (signingCert != null && signingCert.indexOf("-----BEGIN CERTIFICATE-----") == 0) {
                                                X509Certificate cert = CertUtil.loadCertificateFromString(signingCert);
                                                sb.append("    <li>getParameter(<b>\"signingCert\"</b>) = [???size=" + signingCert.length() + "][" + cert.getSerialNumber().toString() + "]</li>\n");
                                            } else {
                                                sb.append("    <li>getParameter(<b>\"signingCert\"</b>) = [???size=" + signingCert.length() + "]</li>\n");
                                                sb.append("<!--\n[signingCert]\n" + signingCert + "\n-->\n");
                                            }
                                        }
                                    } catch (Exception e) { e.printStackTrace(); }

                                    if (withoutSignedPkcs1.length() > 0) {
                                        String p1Result = "  <li>scrapingSign: ";
                                        try {
                                            String signedRawData = p7verifier.getSignedRawData();
                                            byte[] inPkcs1 = com.wizvera.util.Base64.decode(withoutSignedPkcs1);

                                            com.wizvera.crypto.PKCS1Verifier p1v = new com.wizvera.crypto.PKCS1Verifier();
                                            boolean result = p1v.verifyPKCS1(com.wizvera.crypto.PKCS1SignatureAlgorithm.PKCS1_V15_SHA256, signedRawData.getBytes("UTF-8"), inPkcs1, userCert);
                                            if (result) {
                                                p1Result += "verifyPKCS1(<b>OK</b>): ";
                                            } else {
                                                sbCert.append("<!--\n" + signedRawData + "\n-->\n");
                                                sbCert.append("<!--\n" + withoutSignedPkcs1 + "\n-->\n");
                                                System.out.println("verifyPKCS1(withoutSignedPkcs1): FAIL");
                                                p1Result += "<b>verifyPKCS1(FAIL)</b>: ";
                                            }

                                            if (withoutSignedPkcs7.length() > 0) {
                                                PKCS7Verifier p7verifier2 = new PKCS7Verifier(withoutSignedPkcs7, request.getCharacterEncoding());
                                                byte[] withoutSignedPkcs7Signature = p7verifier2.getSignerInfoResults().get(0).getSignature();
                                                if (java.util.Arrays.equals(inPkcs1, withoutSignedPkcs7Signature)) {
                                                    p1Result += "withoutSignedPkcs7Signature(<b>OK</b>): ";
                                                } else {
                                                    p1Result += "<b>withoutSignedPkcs7Signature(FAIL)</b>: ";
                                                    sbCert.append("<!-- withoutSignedPkcs7Signature\n" + com.wizvera.util.Hex.encode(withoutSignedPkcs7Signature) + "\n-->\n");
                                                    sbCert.append("<!-- inPkcs1\n" + com.wizvera.util.Hex.encode(inPkcs1) + "\n-->\n");
                                                }
                                            }

                                            byte[] pkcs7Signature = p7verifier.getSignerInfoResults().get(0).getSignature();
                                            if (java.util.Arrays.equals(inPkcs1, pkcs7Signature)) {
                                                p1Result += "pkcs7Signature(<b>OK</b>)";
                                            } else {
                                                p1Result += "pkcs7Signature(FAIL)";
                                                sbCert.append("<!-- pkcs7Signature\n" + com.wizvera.util.Hex.encode(pkcs7Signature) + "\n-->\n");
                                                sbCert.append("<!-- inPkcs1\n" + com.wizvera.util.Hex.encode(inPkcs1) + "\n-->\n");
                                            }

                                        } catch (Exception e) {
                                            e.printStackTrace();
                                            java.io.StringWriter sw = new java.io.StringWriter();
                                            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                                            e.printStackTrace(pw);
                                            sbCert.append("<!--\n" + sw.toString() + "\n-->\n");
                                            p1Result += "ERROR: <b>" + e.toString() + "</b>";
                                        }
                                        p1Result += "</li>";
                                        sbCert.append(p1Result);
                                    }


                                    sb.append("<!--\n    <li>PKCS7.getSignedRawData() = [" + p7verifier.getSignedRawData() + "]</li>\n-->\n");

                                    if (!isDebug) sb.append("<!--\n");
                                    sb.append("    <li>PKCS7.getOriginSignedRawData() = ");
                                    try {
                                        sb.append("[" + p7verifier.getOriginSignedRawData() + "]\n <a href=\"javascript:alert('" + java.net.URLDecoder.decode(p7verifier.getOriginSignedRawData(), "UTF-8") + "');\">decode</a>\n <a href=\"javascript:alert('" + p7verifier.getSignedRawData() + "');\">raw</a>");
                                    } catch (Exception e) {sb.append("[" + e.toString() + "]");}
                                    sb.append("    </li>");

                                    if (!isDebug) sb.append("-->\n");

                                    String userConfirmFormat = p7verifier.getSignedParameter(PKCS7Verifier.USER_CONFIRM_FORMAT_NAME);
                                    if (userConfirmFormat != null && !"".equals(userConfirmFormat)) {
                                        sb.append("<!--\n");
                                        sb.append("    <li>PKCS7.getSignedParameter(\"<b>" + PKCS7Verifier.USER_CONFIRM_FORMAT_NAME + "</b>\") = [" + userConfirmFormat + "]</li>\n");
                                        sb.append("    <li>PKCS7.getSignedParameter(\"<b>" + PKCS7Verifier.USER_CONFIRM_FORMAT_NAME + "</b>\") = [" + java.net.URLDecoder.decode(userConfirmFormat, "UTF-8") + "]</li>\n");
                                        sb.append("-->\n");

                                        if (!isDebug) sb.append("<!--\n");
                                        sb.append("    <li>PKCS7.getSignedParameter(\"<b>" + PKCS7Verifier.USER_CONFIRM_FORMAT_NAME + "</b>\") = [???size=" + userConfirmFormat.length() + "???]\n <a href=\"javascript:alert('" + java.net.URLDecoder.decode(userConfirmFormat, "UTF-8") + "');\">view</a></li>\n");
                                        if (!isDebug) sb.append("-->\n");
                                    }

                                    if (!isDebug) sb.append("<!--\n");
                                    Map map = p7verifier.getSignedParameterMap();
                                    Set<String> keySet = map.keySet();
                                    Iterator<String> it = keySet.iterator();
                                    while (it.hasNext()) {
                                        String name2 = it.next();
                                        String value2[] = (String[])map.get(name2);
                                        if (value2 == null) {
                                            sb.append("    <li>PKCS7.getSignedParameter(\"<b>" + name2 + "</b>\") = [null]</li>\n");
                                        } else {
                                            for (int j=0; j<value2.length; j++) {
                                                if (PKCS7Verifier.USER_CONFIRM_FORMAT_NAME.equals(name2)) {
                                                    //sb.append("    <li>PKCS7.getSignedParameter(\"<b>" + name2 + "</b>\") = [???size=" + value2[j].length() + "???]<a href=\"javascript:alert('" + java.net.URLDecoder.decode(value2[j], "UTF-8") + "');\">view</a></li>\n");
                                                } else if (PKCS7Verifier.CERT_STORE_MEDIA_TYPE_NAME.equals(name2)) {
                                                    sb.append("    <li>PKCS7.getSignedParameter(\"<b>" + name2 + "</b>\") = [" + value2[j] + "]</li>\n");
                                                } else {
                                                    sb.append("    <li>PKCS7.getSignedParameter(\"<b>" + name2 + "</b>\") = [" + value2[j] + "]</li>\n");
                                                }
                                            }
                                        }
                                    }
                                    if (!isDebug) sb.append("-->\n");
                                }

                                //TODO: 서명시간을 이용한 nonce검증: 클라이언트 설정의 serverTimeUrl설정 및 delfino_serverTime.jsp에 저장되는 세션값확인
                                if (isDebug) {
                                    String serverTime = (String)session.getAttribute("delfinoServerTime");
                                    //session.removeAttribute("delfinoServerTime"); //반드시 삭제해야함
                                    if (signingTime == null) {
                                        String message = "signed data's signingTime[" + signingTime + "] is null";
                                        System.out.println("SigningTime.checkNonce: " + message);
                                        sbCert.append("  <li><b>SigningTime.checkNonce: FAIL</b>: " + message + "</li>\n");
                                        //에러처리하세요 //throw new com.wizvera.crypto.CryptoException(1902, message);
                                    } else {
                                        String signTime = Long.toString(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(signingTime).getTime()/1000L);
                                        if (!signTime.equals(serverTime)) {
                                            String message = "signed data's signingTime[" + signingTime + "][" + signTime + "] is differentor with serverTime[" + serverTime + "]";
                                            System.out.println("SigningTime.checkNonce: " + message);
                                            sbCert.append("  <li><b>SigningTime.checkNonce: FAIL</b>: " + message + "</li>\n");
                                            //에러처리하세요 //throw new com.wizvera.crypto.CryptoException(1901, message);
                                        } else {
                                            sbCert.append("  <li>SigningTime.checkNonce: <b>OK</b>: " + signingTime + "</li>\n");
                                        }
                                    }
                                } else {
                                    sbCert.append("  <li>SigningTime(서명시간): " + signingTime + "</li>\n");
                                }

                                //인증서 검증  객체 생성
                                CertificateVerifier certVerifier = new CertificateVerifier(userCert, delfinoConfig);

                                //인증서 정책 검증
                                if(!certVerifier.isAllowCertificatePolicy()) {
                                    sbCert.append("  <li>CertificatePolicy(인증서 정책) Check: <b>FAIL</b></li>\n");
                                } else {
                                    sbCert.append("  <li>CertificatePolicy(인증서 정책) Check: <b>OK</b></li>\n");
                                }

                                //인증서 경로 검증
                                sbCert.append("<!--\n[userCertificate.dump]\n" + userCert.toString() + "\n-->\n");
                                sbCert.append("<!--\n[userCertificate]\n"+ CertUtil.toPEM(userCert) + "\n-->\n");
                                try {
                                    certVerifier.verifyPathValidation(false);
                                    sbCert.append("  <li>PathValidation(인증서 경로) Check: <b>OK</b></li>\n");
                                } catch (CryptoException e) {
                                    if (e.getErrorCode() == -1305) {
                                        sbCert.append("  <li>PathValidation(인증서 경로) Check: <b>만료:"+ e.getMessage()+ "(errorCode=" + e.getErrorCode() + ")</b></li>\n");
                                    } else {
                                        sbCert.append("  <li>PathValidation(인증서 경로) Check: <b>"+ e.getMessage()+ "(errorCode=" + e.getErrorCode() + ")</b></li>\n");
                                    }
                                    java.io.StringWriter sw = new java.io.StringWriter();
                                    java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                                    e.printStackTrace(pw);
                                    sbCert.append("<!--\n" + sw.toString() + "\n-->\n");
                                }

                                //VID Check
                                String idn=request.getParameter("idn");
                                if (idn != null && !"".equals(idn)) {
                                    try {
                                        String vidRandom = request.getParameter(CertificateVerifier.VID_RANDOM_NAME);
                                        //if(!VIDChecker.checkVID(userCert, idn, org.bouncycastle.util.encoders.Base64.decode(vidRandom))) {
                                        if(!VIDChecker.checkVID(userCert, idn, com.wizvera.util.Base64.decode(vidRandom))) {
                                            sbCert.append("  <li>Certificate VID check: <b>FAIL</b></li>\n");
                                        } else {
                                            sbCert.append("  <li>Certificate VID check: <b>OK</b></li>\n");
                                        }
                                    } catch (Exception e) {
                                        sbCert.append("  <li>Certificate VID check: <b>" + e.toString() + "</b></li>\n");
                                        java.io.StringWriter sw = new java.io.StringWriter();
                                        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                                        e.printStackTrace(pw);
                                        sbCert.append("<!--\n" + sw.toString() + "\n-->\n");
                                    };
                                } else {
                                    sbCert.append("  <li>Certificate VID check: <b>SKIP</b></li>\n");
                                }

                                //OCSP Check
                                if (!isDebug) {
                                    sbCert.append("  <li>Certificate OCSP check: <b>SKIP</b></li>\n");
                                } else {
                                    com.wizvera.crypto.ocsp.OcspManager ocspManager = null;
                                    com.wizvera.crypto.ocsp.response.OcspResponseResult ocspResponseResult = null;
                                    try {
                                        ocspManager = com.wizvera.crypto.ocsp.OcspManager.getInstance(delfinoConfig);
                                        ocspResponseResult = ocspManager.getCertStatus(userCert);
                                        sbCert.append("  <li>Certificate OCSP check: <b>" + ocspResponseResult.getCertStatusInfo() + "</b></li>\n");
                                    } catch (Exception e) {
                                        sbCert.append("  <li>Certificate OCSP check: <b>" + e.toString() + "</b></li>\n");
                                        java.io.StringWriter sw = new java.io.StringWriter();
                                        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                                        e.printStackTrace(pw);
                                        sbCert.append("<!--\n" + sw.toString() + "\n-->\n");
                                    }
                                }

                                //Cert Info
                                sbCert.append("  <li>User Certificate Info\n    <ul>\n");

                                String subjectDN = userCert.getSubjectX500Principal().getName(javax.security.auth.x500.X500Principal.RFC2253);
                                String cn = subjectDN.split(",")[0];
                                String userName = cn.split("=")[1];
                                userName = userName.split("\\(")[0];
                                sbCert.append("\t  <li>유효기간 [<b>" + new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userCert.getNotBefore()) + "</b>] ~ [<b>" + new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userCert.getNotAfter()) + "</b>]</li>\n");
                                sbCert.append("\t  <li>일련번호 [<b>" + userCert.getSerialNumber().toString() + "</b>]");
                                sbCert.append("  userName [<b>" + userName + "</b>]</li>\n");
                                {
                                    String firstOID = "";
                                    String oidPrintString = "";
                                    try {
                                        firstOID = CertUtil.getCertificatePolicyOID(userCert);
                                        String[] oidArray = CertUtil.getCertificatePolicyOIDs(userCert);
                                        for (int j=0; j<oidArray.length; j++) oidPrintString += "[" + oidArray[j] + "]";
                                    } catch(Exception e) {

                                    }

                                    boolean isPersonal = false;
                                    boolean isCorporation =  false;
                                    if ( "1.2.410.200004.5.1.1.5".equals(firstOID)  //증권전산, 개인, 상호연동
                                          || "1.2.410.200004.5.2.1.2".equals(firstOID)  //정보인증, 개인, 상호연동
                                          || "1.2.410.200004.5.2.1.7.1".equals(firstOID)    //정보인증, 개인, 용도제한(은행)
                                          || "1.2.410.200004.5.3.1.9".equals(firstOID)  //전산원,   개인, 상호연동
                                          || "1.2.410.200004.5.4.1.1".equals(firstOID)  //전자인증, 개인, 상호연동
                                          || "1.2.410.200004.5.4.1.101".equals(firstOID)    //전자인증, 개인, 용도제한(은행)
                                          || "1.2.410.200005.1.1.1".equals(firstOID)        //금결원,  개인, 상호연동
                                          || "1.2.410.200005.1.1.4".equals(firstOID)        //금결원,  개인, 용도제한(은행,보험,카드)
                                          || "1.2.410.200012.1.1.1".equals(firstOID) )  //무역정보, 개인, 상호연동
                                    {
                                        isPersonal = true;
                                    }

                                    if ( "1.2.410.200004.5.1.1.7".equals(firstOID)  //증권전산, 법인, 상호연동
                                          || "1.2.410.200004.5.2.1.1".equals(firstOID)  //정보인증, 법인, 상호연동
                                          || "1.2.410.200004.5.3.1.2".equals(firstOID)  //전산원,        법인, 상호연동
                                          || "1.2.410.200004.5.4.1.2".equals(firstOID)  //전자인증, 법인, 상호연동
                                          || "1.2.410.200005.1.1.5".equals(firstOID)        //금결원,   법인, 상호연동
                                          || "1.2.410.200005.1.1.2".equals(firstOID)        //금결원,   법인, 용도제한(은행,보험,카드)
                                          || "1.2.410.200005.1.1.6.1".equals(firstOID)  //금결원,   법인, 용도제한(기업뱅킹)
                                          || "1.2.410.200012.1.1.101".equals(firstOID)  //무역정보, 법인, 용도제한(은행)
                                          || "1.2.410.200012.1.1.3".equals(firstOID) )  //무역정보, 법인, 상호연동
                                    {
                                        isCorporation = true;
                                    }
                                    if (!"".equals(firstOID)) {
                                        sbCert.append("\t  <li>인증서구분[");
                                        if (isPersonal) {
                                            sbCert.append("<b>개인인증서</b>");
                                        }
                                        if (isCorporation) {
                                            sbCert.append("<b>법인인증서</b>");
                                        }
                                        sbCert.append("] certOIDs" + oidPrintString + "</li>\n");
                                    }
                                }
                                sbCert.append("\t  <li>발급대상 [" + subjectDN + "]</li>\n");
                                sbCert.append("\t  <li>발급자 [" + userCert.getIssuerX500Principal().getName(javax.security.auth.x500.X500Principal.RFC2253) + "]</li>\n");
                                /*
                                String dnTest = "";
                                dnTest += "<br/>11:" + cert.getSubjectDN();
                                dnTest += "<br/>12:" + cert.getSubjectDN().getName();
                                dnTest += "<br/>21:" + cert.getSubjectX500Principal();
                                dnTest += "<br/>22:" + cert.getSubjectX500Principal().getName();
                                dnTest += "<br/>30:" + com.wizvera.crypto.CertUtil.getSubjectDN(cert);
                                dnTest += "<br/><br/>11:" + cert.getIssuerDN();
                                dnTest += "<br/>12:" + cert.getIssuerDN().getName();
                                dnTest += "<br/>21:" + cert.getIssuerX500Principal();
                                dnTest += "<br/>22:" + cert.getIssuerX500Principal().getName();
                                dnTest += "<br/>30:" + com.wizvera.crypto.CertUtil.getIssuerDN(cert);
                                sb.append("\t<li>발급자 [" + dnTest + "]</li>\n");
                                */
                                sbCert.append("    </ul>\n  </li>\n");
                            } catch(CryptoException e) {
                                sb.append("    <li><b>" + e.getMessage() + "(errorCode=" + e.getErrorCode() + ")</b></li>\n");
                                java.io.StringWriter sw = new java.io.StringWriter();
                                java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                                e.printStackTrace(pw);
                                sb.append("<!--\n" + sw.toString() + "\n-->\n");
                            } catch (Exception e) {
                                sb.append("    <li><b>" + e.toString() + "</b></li>\n");
                                java.io.StringWriter sw = new java.io.StringWriter();
                                java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                                e.printStackTrace(pw);
                                sb.append("<!--\n" + sw.toString() + "\n-->\n");
                            }
                        }
                        
                    } else {
                        String strValue = getRequestValue(value[i]);
                        if ("".equals(strValue) || "_".equals(strValue)) {
                            sb.append("<!--<li>getParameter(\"" + name + "\") = [" + getRequestValue(value[i]) + "]</li> -->\n");
                        } else {
                            sb.append("    <li>getParameter(\"" + name + "\") = [" + getRequestValue(value[i]) + "]</li>\n");
                        }
                    }
                }
            }
        }
        sb.append("  </ul>\n");
        out.println("<ul>\n" + sb.toString() + "\n\n" +  sbCert.toString() + "\n</ul>\n");

        {
            String text = request.getParameter("idn");
            if (text != null && !"".equals(text)) out.println("\n<!-- [" + com.wizvera.crypto.GenerateSignTool.encryptRawPassword(text) + "] -->");

            out.println("\n<!-- [" + com.wizvera.WizveraConfig.getDefaultPropertiesPath() + "] -->");
            out.println("<!-- [" + session.getAttribute("delfinoNonce") + "] -->");
            out.println("<!-- [" + session.getAttribute("delfinoServerTime") + "] -->");

            String proKey = request.getParameter("property");
            if (proKey!=null && !"".equals(proKey)) out.println("\n<!--" + proKey + "[" + com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty(proKey) + "]-->");
        }
    }
%>

<% } catch (Exception e) {
    out.println("<br/><hr/><b>(?)WIZVERA Delfino - ERR(?)</b>");
    out.println("<br>FileName = " + request.getServletPath());
    out.println("<br>Exception = " + e.getMessage());
    out.println("<br><br><b>printStackTrace</b><br>");
    java.io.StringWriter sw = new java.io.StringWriter();
    java.io.PrintWriter pw = new java.io.PrintWriter(sw);
    e.printStackTrace(pw);
    out.println(sw.toString());
} %>
</div>

</body>
</html>
