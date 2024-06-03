
<%-- --------------------------------------------------------------------------
 - File Name   : signResult.jsp(전자서명 샘플)
 - Include     : NONE
 - Author      : WIZVERA
 - Last Update : 2020/09/15
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="java.security.NoSuchProviderException" %>
<%@ page import="java.security.cert.CertificateException" %>

<%@ page import="com.wizvera.crypto.CertUtil" %>
<%@ page import="com.wizvera.service.SignVerifier" %>
<%@ page import="com.wizvera.service.SignVerifierResult" %>
<%@ page import="com.wizvera.service.DelfinoServiceException" %>
<%
    request.setCharacterEncoding("utf8");
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
    //com.wizvera.WizveraConfig delfinoConfig = new com.wizvera.WizveraConfig(getServletConfig().getServletContext().getRealPath("WEB-INF") + "/lib/delfino.properties");
%>
<%
    //out.println("<!-- " + request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "] -->");
    out.println("<!-- " + getRequestParameter(request, "\n") + "\n-->") ;
    if ("TEST_TEST".equals(request.getParameter("_action"))) return;
%>
<%
    /**************************************************************
     * 인증서 유효성 검증 타입설정 샘플
     - SignVerifier.CERT_STATUS_CHECK_TYPE_NONE: 유효성검증안함
     - SignVerifier.CERT_STATUS_CHECK_TYPE_CRL:  CRL을 이용한 유효성 확인
     - SignVerifier.CERT_STATUS_CHECK_TYPE_OCSP: OCSP를 이용한 유효성 확인(delfino.propertie에서 OCSP키값 및 서버 설정필요)
     ***************************************************************/
    int certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_NONE;
    {
        String imsi = request.getParameter("certStatusCheckType");
        if ("OCSP".equals(imsi)) {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_OCSP;
        } else if ("CRL".equals(imsi)) {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_CRL;
        } else {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_NONE;
        }
    }
%>
<%
    String action = request.getParameter("_action");
    String pkcs7 = request.getParameter(SignVerifier.PKCS7_NAME);
    String vidRandom = request.getParameter(SignVerifier.VID_RANDOM_NAME);
%>
<%
    out.println("<b>전자서명결과</b>[" + action + "] " + logDate.format(new java.util.Date()));
    try{
        /**************************************************************
        * PKCS7을 이용한 서명검증,인증서소유자 및 유효성확인
        - verifyPKCS7WithNonce:       인증서로그인:  서명확인 + Nonce확인 + 인증서유효성검증
        - verifyPKCS7WithVIDAndNonce: 본인확인로그인:서명확인 + Nonce확인 + 인증서유효성검증
        - verifyPKCS7WithUserConfirm: 포맷전자서명:  서명확인 + 사용자포맷확인 + 인증서유효성검증
        - verifyPKCS7:                일반서명:     서명확인 + 인증서유효성검증
        ***************************************************************/
        SignVerifier signVerifier = new SignVerifier(); //서명검증 객체
        SignVerifierResult signVerifierResult = null; //서명검증 결과

        if ("TEST_certLogin".equals(action)) {
            String sessionNonce = (String)session.getAttribute("delfinoNonce");
            session.removeAttribute("delfinoNonce"); //TODO: 반드시 삭제해야함
            signVerifierResult = signVerifier.verifyPKCS7WithNonce(pkcs7, sessionNonce, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7WithNonce: <b>OK</b>");
        }
        else if ("TEST_vidLogin".equals(action)) {
            String idn = request.getParameter("idn");
            String sessionNonce = (String)session.getAttribute("delfinoNonce");
            session.removeAttribute("delfinoNonce"); //TODO: 반드시 삭제해야함
            signVerifierResult = signVerifier.verifyPKCS7WithVIDAndNonce(pkcs7, vidRandom, idn, sessionNonce, certStatusCheckType);
            //signVerifierResult = signVerifier.verifyPKCS7WithVID(pkcs7, vidRandom, idn, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7WithVIDAndNonce: <b>OK</b>");
        }
        else if ("TEST_confirmSign_string".equals(action)) {
            String expectedUserConfirmFormat = (String)session.getAttribute("TEST_confirmSign_string");
            signVerifierResult = signVerifier.verifyPKCS7WithUserConfirm(pkcs7, expectedUserConfirmFormat, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7WithUserConfirm: <b>OK</b>");
        }
        else if ("TEST_confirmSign_form".equals(action) || "TEST_confirmSign_formString".equals(action)) {
            String expectedUserConfirmFormat = (String)session.getAttribute("TEST_confirmSign_form");
            signVerifierResult = signVerifier.verifyPKCS7WithUserConfirm(pkcs7, expectedUserConfirmFormat, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7WithUserConfirm: <b>OK</b>");
        }
        else if ("TEST_multiSign".equals(action)) {
            String SIGN_Delimeter = request.getParameter("SIGN_Delimeter");
            if (SIGN_Delimeter == null || SIGN_Delimeter.equals("")) SIGN_Delimeter = "|"; //"￡";
            if ("|".equals(SIGN_Delimeter)) SIGN_Delimeter = "\\" + SIGN_Delimeter;
            String[] pkcs7Array = pkcs7.split(SIGN_Delimeter);
            for(int k=0; k<pkcs7Array.length; k++) {
                pkcs7 = pkcs7Array[k];
                System.out.println(pkcs7 + "\n");
                signVerifierResult = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
                out.println("<br/>-. signVerifier.verifyPKCS7[" + k + "]=[<font size='2'>" + signVerifierResult.getOriginSignedRawData() + "</font>]");
            }
        }
        else if ("TEST_pkcs7".equals(action)) {
            if (certStatusCheckType == SignVerifier.CERT_STATUS_CHECK_TYPE_NONE) {
                signVerifierResult = signVerifier.verifyPKCS7WithoutCertValidation(pkcs7);
                out.println("<br/>-. signVerifier.verifyPKCS7WithoutCertValidation: <b>OK</b>");
            } else {
                signVerifierResult = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
                out.println("<br/>-. signVerifier.verifyPKCS7: <b>OK</b>");
            }
        }
        else {
            signVerifierResult = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7: <b>OK</b>");

            //업무단에서 전자서명 원본 확인(세션에 저장된 값과 전자서명원본값 비교)
            String session_SignData = (String)session.getAttribute(action);
            if (session_SignData == null) session_SignData = "";
            String pkcs7_SignData = signVerifierResult.getOriginSignedRawData();

            if ("TEST_confirmSign_formattedText".equals(action)) {
                //pkcs7_SignData = pkcs7_SignData.replace("\r", ""); //window,unix CR(0x0D),LF(0x0A)보정
                pkcs7_SignData = pkcs7_SignData.replace("\n", "\\n");
            }

            if (pkcs7_SignData.equals(session_SignData)) {
                out.println("<br/>-. 전자서명데이타원본확인: <b>OK</b>");
            } else {
                out.println("<br/>-. 전자서명데이타원본확인: <b>FAIL</b>");
                out.println("<!--" + session_SignData + "-->");
                out.println("<!--" + pkcs7_SignData + "-->");
                out.println("<!--" + com.wizvera.util.Hex.encode(session_SignData.getBytes()) + "-->");
                out.println("<!--" + com.wizvera.util.Hex.encode(pkcs7_SignData.getBytes()) + "-->");
            }
        }

        //TODO: 전자서명옵션에서 addNonce사용시  nonce검증: delfino_config.js의 useNonceOption=true일 경우(nonce검증함수를 사용하지 않을경우 필요시 사용)
        if ("true".equals(request.getParameter("addNonce")) && !("TEST_certLogin".equals(action) || "TEST_vidLogin".equals(action)) ) {
            String delfinoNonce = signVerifierResult.getDelfinoNonce();
            String sessionNonce = (String)session.getAttribute("delfinoNonce");
            session.removeAttribute("delfinoNonce"); //TODO: 반드시 삭제해야함
            if (delfinoNonce == null || "".equals(delfinoNonce)) {
                String message = "signed data's delfinoNonce[" + delfinoNonce + "] is null";
                System.out.println("checkNonce: " + message);
                out.println("<br/>-. checkNonce: <b>FAIL</b>: " + message);
                //에러처리하세요 //throw new DelfinoServiceException(new com.wizvera.crypto.CryptoException(1902, message));
            } else if (!delfinoNonce.equals(sessionNonce)) {
                String message = "signed data's delfinoNonce[" + delfinoNonce + "] is differentor with sessionNonce[" + sessionNonce + "]";
                System.out.println("checkNonce: " + message);
                out.println("<br/>-. checkNonce: <b>FAIL</b>: " + message);
                //에러처리하세요 //throw new DelfinoServiceException(new com.wizvera.crypto.CryptoException(1901, message));
            } else {
                out.println("<br/>-. checkNonce: <b>OK</b>");
            }
        }

        //TODO: 서명시간을 이용한 nonce검증: 클라이언트 설정의 serverTimeUrl설정 및 delfino_serverTime.jsp에 저장되는 세션값확인
        if (true) {
            String signingTime = signVerifierResult.getSignerInfoResults().get(0).getSigningTimeInLocalTime();
            String serverTime = (String)session.getAttribute("delfinoServerTime");
            session.removeAttribute("delfinoServerTime"); //TODO: 반드시 삭제해야함
            if (signingTime == null) {
                String message = "signed data's signingTime[" + signingTime + "] is null";
                System.out.println("checkNonce.SigningTime: " + message);
                out.println("<br/>-. <b>checkNonce.SigningTime: FAIL</b>: " + message);
                //에러처리하세요 //throw new com.wizvera.crypto.CryptoException(1902, message);
            } else {
                String signTime = Long.toString(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(signingTime).getTime()/1000L);
                if (!signTime.equals(serverTime)) {
                    String message = "signed data's signingTime[" + signingTime + "][" + signTime + "] is differentor with serverTime[" + serverTime + "]";
                    System.out.println("checkNonce.SigningTime: " + message);
                    out.println("<br/>-. <b>checkNonce.SigningTime: FAIL</b>: " + message);
                    //에러처리하세요 //throw new com.wizvera.crypto.CryptoException(1901, message);
                } else {
                    out.println("<br/>-. checkNonce.SigningTime: <b>OK</b>: " + signingTime);
                }
            }
        }


        if (SignVerifier.CERT_STATUS_CHECK_TYPE_OCSP == certStatusCheckType) {
            out.println("<br/>-. 인증서 유효성확인(OCSP): <b>OK</b>");
        } else if (SignVerifier.CERT_STATUS_CHECK_TYPE_CRL == certStatusCheckType) {
            out.println("<br/>-. 인증서 유효성확인(CRL): <b>OK</b>");
        } else if (SignVerifier.CERT_STATUS_CHECK_TYPE_NONE == certStatusCheckType) {
            out.println("<br/>-. CRL/OCSP를 통한 인증서 유효성 확인이 필요합니다.");
        }
        out.println("<br/>-. 필요시 업무에 따라 로그인 인증서와 동일여부 확인이 필요합니다.");


        /**************************************************************
        * 전자서명 데이타 확인
        - getOriginSignedRawData(): 전자서명원문데이타
        - getSignedParameter(name): 포맷전자서명시 name에 해당하는 데이타
        ***************************************************************/
        out.println("<br/><br/><b>전자서명데이타</b> [" + signVerifierResult.getCertStoreMediaType() + "]");
        out.println("<font size='2'>");
        out.println("<!-- <br/>[" + signVerifierResult.getSignedRawData() + "] -->");
        out.println("<br/>[" + signVerifierResult.getOriginSignedRawData() + "]");
        if ("TEST_confirmSign_form".equals(action) || "TEST_confirmSign_formString".equals(action)) {
            out.println("<br/>- account     [" + signVerifierResult.getSignedParameter("account")     + "]");
            out.println("<br/>- amount      [" + signVerifierResult.getSignedParameter("amount")      + "]");
            out.println("<br/>- recvUser    [" + signVerifierResult.getSignedParameter("recvUser")    + "]");
            out.println("<br/>- etc         [" + signVerifierResult.getSignedParameter("etc")         + "]");
        }
        out.println("</font>");


        /**************************************************************
        * 인증서 정보 확인
        ***************************************************************/
        X509Certificate userCert = signVerifierResult.getSignerCertificate(); //사용자인증서(BC);
        //X509Certificate userCert = convertX509Cert(signVerifierResult.getSignerCertificate()); //사용자인증서(SUN)
        out.println("<!--\n[userCertificate.dump]\n" + userCert.toString() + "\n-->\n");
        out.println("<!--\n[userCertificate]\n"+ CertUtil.toPEM(userCert) + "\n-->\n");

        //String issuerDN = userCert.getIssuerX500Principal().getName(); //인증서 발급기관 DN정보
        //String subjectDN = userCert.getSubjectX500Principal().getName(); //인증서 발급주체 DN정보
        String issuerDN = CertUtil.getIssuerDN(userCert,false,false); //인증서 발급기관 DN정보(인증서,대문자,cn부터): X509기본설정
        String subjectDN = CertUtil.getSubjectDN(userCert,true,true); //인증서 발급주체 DN정보(인증서,소문자,역순): 고객사별로 확인필요: INITECH호환(새마을금고)

        String subjectCN = CertUtil.getSubjectEntry(userCert, CertUtil.NAME_CN, 0); //인증서 발급주체 CN정보(인증서,엔트리,순번)
        String issuerO = CertUtil.getIssuerEntry(userCert, CertUtil.NAME_O, 0);     //인증서 발급기관명(타기관 구분용)(yessign,KICA,SignKorea,NCASign,TradeSign,CrossCert)
        //String issuerO = CertUtil.getIssuerEntry(userCert, CertUtil.NAME_O, 0).toLowerCase();

        //금결원일경우 은행코드 추출
        String bankCode = "";
        if ("yessign".equals(issuerO)) {
            int idx = subjectCN.lastIndexOf(")");
            if(idx != -1) bankCode = subjectCN.substring(idx+1, idx+5);
        }

        //String certSerial = userCert.getSerialNumber().toString(16); //인증서시리얼
        //if ((certSerial.length()%2) == 1) certSerial = "0" + certSerial;
        String certSerial = CertUtil.getSerialDecimal(userCert); //인증서시리얼(10진수)
        String certSerialHex = CertUtil.getSerialHex(userCert);  //인증서시리얼(16진수) 0A10

        String certBefore = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userCert.getNotBefore()); //인증서유효기간:시작일
        String certAfter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userCert.getNotAfter());   //인증서유효기간:종료일

        out.println("<br/><br/><b>인증서 정보</b>");
        out.println("<br/>- 인증서발급기관 [" + issuerDN + "]");
        out.println("<br/>- 인증서발급주체 [" + subjectDN + "]");
        out.println("<br/>- 인증서부가정보 [" + issuerO + "][" + subjectCN + "][" + bankCode + "]");
        out.println("<br/>- 인증서일련번호 [<b>" + certSerial + "</b>][" + certSerialHex + "]");
        out.println("<br/>- 인증서유효기간 [<b>" + certBefore + " ~ " + certAfter + "</b>]");


        //인증서 OID로 개인/법인 구분(아래는 샘플입니다. OID리스트를 가지고 담당자와 정책을 정해서 처리해야함)
        //String[] oidArray = CertUtil.getCertificatePolicyOIDs(userCert);
        String firstOID = CertUtil.getCertificatePolicyOID(userCert);
        boolean isPersonal = false;
        boolean isCorporation =  false;
        if ( "1.2.410.200004.5.1.1.5".equals(firstOID)      //증권전산, 개인, 상호연동
              || "1.2.410.200004.5.2.1.2".equals(firstOID)  //정보인증, 개인, 상호연동
              || "1.2.410.200004.5.2.1.7.1".equals(firstOID)//정보인증, 개인, 용도제한(은행)
              || "1.2.410.200004.5.3.1.9".equals(firstOID)  //전산원,   개인, 상호연동
              || "1.2.410.200004.5.4.1.1".equals(firstOID)  //전자인증, 개인, 상호연동
              || "1.2.410.200004.5.4.1.101".equals(firstOID)//전자인증, 개인, 용도제한(은행)
              || "1.2.410.200005.1.1.1".equals(firstOID)    //금결원,  개인, 상호연동
              || "1.2.410.200005.1.1.4".equals(firstOID)    //금결원,  개인, 용도제한(은행,보험,카드)
              || "1.2.410.200012.1.1.1".equals(firstOID)    //무역정보, 개인, 상호연동
              || "1.2.410.200004.5.5.1.1".equals(firstOID) )//이니텍,  개인, 상호연동
        {
            isPersonal = true;
        }

        if ( "1.2.410.200004.5.1.1.7".equals(firstOID)      //증권전산, 법인, 상호연동
              || "1.2.410.200004.5.2.1.1".equals(firstOID)  //정보인증, 법인, 상호연동
              || "1.2.410.200004.5.3.1.2".equals(firstOID)  //전산원,        법인, 상호연동
              || "1.2.410.200004.5.4.1.2".equals(firstOID)  //전자인증, 법인, 상호연동
              || "1.2.410.200005.1.1.5".equals(firstOID)    //금결원,   법인, 상호연동
              || "1.2.410.200005.1.1.2".equals(firstOID)    //금결원,   법인, 용도제한(은행,보험,카드)
              || "1.2.410.200005.1.1.6.1".equals(firstOID)  //금결원,   법인, 용도제한(기업뱅킹)
              || "1.2.410.200012.1.1.101".equals(firstOID)  //무역정보, 법인, 용도제한(은행)
              || "1.2.410.200012.1.1.3".equals(firstOID)    //무역정보, 법인, 상호연동
              || "1.2.410.200004.5.5.1.2".equals(firstOID) )//이니텍,  법인, 상호연동
        {
            isCorporation = true;
        }
        out.println("<br/>- 인증서용도구분  [<b>" + firstOID + "</b>] 개인용[" + isPersonal + "] 법인용[" + isCorporation + "]");

        //BASE64포맷을 HEX포맷으로 변경 샘플
        if (pkcs7 != null && !"".equals(pkcs7)) {
            byte[] imsi = com.wizvera.util.Base64.decode(pkcs7.getBytes());
            String pkcs7Hex = com.wizvera.util.Hex.encode(imsi);
            out.println("<!--\n\n" + pkcs7Hex + "\n-->");
        }

    } catch(DelfinoServiceException e) {
        //System.out.println(request.getParameter(SignVerifier.PKCS7_NAME)); //PKCS7 데이타 오류 확인을 위해 로그 저장 필요
        out.println("<br/><hr/><b>DelfinoServiceException - ERR(?)</b>");
        out.println("<br/>getServletPath: " + request.getServletPath() + "?action=" + action);
        out.println("<br/>getMessage: " + e.getMessage());
        out.println("<br/>getErrorCode: " + e.getErrorCode());
        out.println("<br/>getErrorUserMessage(kr): " + e.getErrorUserMessage());
        out.println("<br/>getErrorUserMessage(en): " + e.getErrorUserMessage(com.wizvera.service.util.ErrorConvert.LOCALE_EN));
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");
    } catch(Exception e) {
        out.println("<br/><hr/><b>Exception - ERR(?)</b>");
        out.println("<br/>FileName: " + request.getServletPath());
        out.println("<br/>getMessage: " + e.getMessage());
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");
    } finally {
        out.println("<!--\n" + pkcs7 + "\n-->");
        if (pkcs7 != null && !"".equals(pkcs7)) out.println("<!--\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7) + "\n-->");
    }
%>
<%!
    public static X509Certificate convertX509Cert(X509Certificate cert) throws CertificateException, NoSuchProviderException, java.security.cert.CertificateException {
        return convertX509Cert(cert,  "SUN");
    }
    public static X509Certificate convertX509Cert(X509Certificate cert, String provider) throws CertificateException, NoSuchProviderException, java.security.cert.CertificateException {
        java.io.ByteArrayInputStream in = new java.io.ByteArrayInputStream(cert.getEncoded());
        java.security.cert.CertificateFactory certFactory = java.security.cert.CertificateFactory.getInstance("X.509", provider);
        return (X509Certificate)certFactory.generateCertificate(in);
    }
    public static String getRequestParameter(HttpServletRequest request, String tag) {
        StringBuffer sb = new StringBuffer();
        java.util.Enumeration he3 = request.getParameterNames();
        sb.append(tag); //request.getContextPath() + request.getServletPath();
        sb.append("###########################################################################" + tag);
        sb.append("#" + request.getRequestURI() + " " + request.getMethod() + "][" + request.getRemoteAddr() + "]" + tag);
        //request.getContextPath() + request.getServletPath()

        while (he3.hasMoreElements()) {
            String name = (String)he3.nextElement();
            String[] value = request.getParameterValues(name);
            if (value == null) {
                sb.append("#   [" + name + "] = [null]" + tag);
            } else {
                for (int i=0; i<value.length; i++) {
                    sb.append("#   [" + name + "] = [" + value[i] + "]" + tag);
                }
            }
        }
        sb.append("###########################################################################");
        return sb.toString();
    }
%>
