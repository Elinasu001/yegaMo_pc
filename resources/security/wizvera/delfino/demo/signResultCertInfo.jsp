
<%-- --------------------------------------------------------------------------
 - File Name   : signResult.jsp(전자서명 샘플)
 - Include     : NONE
 - Author      : WIZVERA
 - Last Update : 2019/12/26
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="java.security.cert.X509Certificate" %>

<%@ page import="com.wizvera.crypto.*" %>
<%@ page import="com.wizvera.service.SignVerifier" %>
<%@ page import="com.wizvera.service.SignVerifierResult" %>
<%@ page import="com.wizvera.service.DelfinoServiceException" %>

<%@ page import="com.wizvera.util.*" %>
<%@ page import="com.wizvera.crypto.CertUtil" %>
<%@ page import="com.wizvera.service.DelfinoCert" %>
<%@ page import="com.wizvera.crypto.CRLVerifier" %>
<%
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
    //com.wizvera.WizveraConfig delfinoConfig = new com.wizvera.WizveraConfig(getServletConfig().getServletContext().getRealPath("WEB-INF") + "/lib/delfino.properties");
%>
<%
    out.println("<!-- " + request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]<br/> -->");
    if ("TEST_TEST".equals(request.getParameter("_action"))) return;
%>
<%
    String action = request.getParameter("_action");
    String pkcs7 = request.getParameter(SignVerifier.PKCS7_NAME);
    String vidRandom = request.getParameter(SignVerifier.VID_RANDOM_NAME);
%>
<%
    out.println("<b>전자서명결과</b>[" + action + "]");
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

        signVerifierResult = signVerifier.verifyPKCS7(pkcs7, SignVerifier.CERT_STATUS_CHECK_TYPE_NONE);
        out.println("<br/>-. signVerifier.verifyPKCS7: <b>OK</b>");
        out.println("<br/>-. CRL/OCSP를 통한 인증서 유효성 확인이 필요합니다.");
        out.println("<br/>-. 필요시 업무에 따라 로그인 인증서와 동일여부 확인이 필요합니다.");


            /**************************************************************
            * 전자서명 데이타 확인
            - getOriginSignedRawData(): 전자서명원문데이타
            - getSignedParameter(name): 포맷전자서명시 name에 해당하는 데이타
            ***************************************************************/
            out.println("<p><b>전자서명 데이타</b>");

            List<SignerInfoResult> signerInfoResults = signVerifierResult.getSignerInfoResults();
            SignerInfoResult signerInfoResult = signerInfoResults.get(0);
            String signTime = signerInfoResult.getSigningTimeInLocalTime();
            out.println("<br/><li>서명시간    :" + signTime);

            out.println("<br/><li>RawData     :" + signVerifierResult.getOriginSignedRawData());
            out.println("<br/><font size=2'>[" + signVerifierResult.getSignedRawData() + "]</font>");


            /**************************************************************
            * 인증서 정보 확인
            ***************************************************************/
            X509Certificate userCert = signVerifierResult.getSignerCertificate();   //사용자인증서
            String certStoreMediaType = signVerifierResult.getCertStoreMediaType(); //인증서저장매체(LOCAL_DISK|REMOVABLE_DISK|TOKEN|HSM|PHONE|USIM|SWHSM)
            String pemCert = CertUtil.toPEM(userCert);                              //Base64인코딩된 인증서
            String cerOID = CertUtil.getCertificatePolicyOID(userCert);             //인증서OID
            String certSerial = CertUtil.getSerialDecimal(userCert);                //인증서시리얼(10진수)
            String certHexSerial = CertUtil.getSerialHex(userCert);                 //인증서시리얼(16진수)
            String issuerDN = CertUtil.getIssuerDN(userCert,true,false);            //인증서 발급기관 DN정보(인증서,소문자,역순)
            String issuerCN = CertUtil.getIssuerEntry(userCert, "CN", 0);           //인증서 발급기관 CN정보(인증서,엔트리,순번)
            String certO = CertUtil.getIssuerEntry(userCert, "O", 0);               //인증서 발급기관명(타기관 구분용)(yessign,KICA,SignKorea,NCASign,TradeSign,CrossCert)
            String subjectDN = CertUtil.getSubjectDN(userCert,true,false);          //인증서 발급주체 DN정보(인증서,소문자,역순)
            String subjectCN = CertUtil.getSubjectEntry(userCert, "CN", 0);         //인증서 발급주체 CN정보(인증서,엔트리,순번)
            String ocspurl = CertUtil.getOcspUrl(userCert);                         //OCSP URL
            List<String> crldps = CRLVerifier.getCrlDistributionPoints(userCert);   //CRL DP
            String crldp = crldps.get(0);
            SimpleDateFormat sd = new SimpleDateFormat("yyyy:MM:dd:HH:mm:DD");
            Date notBefore = userCert.getNotBefore();                               //인증서 발급일
            String before = (String)sd.format(notBefore);
            Date notAfter = userCert.getNotAfter();                                 //인증서 만료일
            String after = (String)sd.format(notAfter);
            String bankCode = "";
            String certID = "";
            int index1 = subjectCN.lastIndexOf(")");
            if(index1 != -1) bankCode = subjectCN.substring(index1+1, index1+5);    //은행코드(0045)
            if(index1 != -1) certID = subjectCN.substring(index1+1);                //인증서ID(0045200209260288)
            String certOU = "";                                                     //은행명(KMB)
            if(certO.equals("KICA")) certOU = CertUtil.getSubjectEntry(userCert,"OU",1);
            else certOU = CertUtil.getSubjectEntry(userCert,"OU",0);
            byte[] issueKeyID = CertUtil.getAuthorityKeyIdentifier(userCert);       //발행기관 공개키 해시값
            String hexKeyID = Hex.encode(issueKeyID);
            hexKeyID = hexKeyID.toUpperCase();

/*
            String policyCode = "";                                                 //인증정책식별코드
            DelfinoCert DCERT = new DelfinoCert(userCert);
            if(DCERT.getIssueTarget() == DCERT.CERT_ISSUE_TARGET_PERSONAL && DCERT.getCertUsage() == DCERT.CERT_USAGE_GENERAL) {
                policyCode = "범용 개인(01)";
            } else if(DCERT.getIssueTarget() == DCERT.CERT_ISSUE_TARGET_CORPORATION && DCERT.getCertUsage() == DCERT.CERT_USAGE_GENERAL) {
                policyCode = "범용 기업(05)";
            } else if(DCERT.getIssueTarget() == DCERT.CERT_ISSUE_TARGET_CORPORATION && DCERT.getCertUsage() == DCERT.CERT_USAGE_SPECIAL) {
                policyCode = "용도제한 기업(02)"; // 세금계산서용 포함
            } else if(DCERT.getIssueTarget() == DCERT.CERT_ISSUE_TARGET_PERSONAL && DCERT.getCertUsage() == DCERT.CERT_USAGE_SPECIAL) {
                policyCode = "용도제한 개인(04)";
            } else if(DCERT.getIssueTarget() == DCERT.CERT_ISSUE_TARGET_ETC) {
                policyCode = "기타(06)";
            }
*/
            out.println("<p><b>3. 인증서 정보</b>");
            out.println("<br/><li>저장매체      :" + certStoreMediaType);
            out.println("<br/><li>일련번호      :" + certSerial + "(" + certHexSerial + ")");
            out.println("<br/><li>OID           :" + cerOID);
            //out.println("<br/><li>인증정책        :" + policyCode);
            out.println("<br/><li>유휴기간      :" + before + "~" + after);
            out.println("<br/><li>발급기관      :" + issuerDN);
            out.println("<br/><li>발급기관명    :" + certO);
            out.println("<br/><li>발급대상      :" + subjectDN);
            out.println("<br/><li>인증서ID      :" + certID);
            out.println("<br/><li>은행코드      :" + bankCode);
            out.println("<br/><li>은행명        :" + certOU);
            out.println("<br/><li>발급기관공개키:" + hexKeyID);
            out.println("<br/><li>OCSP URL      :" + ocspurl);
            out.println("<br/><li>CRL DP        :" + crldp);
            //out.println("<br/><li>CRL DP        :" + crldp.substring(crldp.indexOf("://")+3));
            out.println("<p><b>----------------------------------------------------------------------------------</b><p>");

            //BASE64포맷을 HEX포맷으로 변경 샘플
            byte[] imsi = com.wizvera.util.Base64.decode(pkcs7.getBytes());
            String pkcs7Hex = com.wizvera.util.Hex.encode(imsi);
            out.println("<!--\n\n" + pkcs7Hex + "\n-->");
            out.println("<!--\n\n" + pemCert + "\n-->");

            //KNBANK
            out.println("<br/>getBankName : " + this.getBankName(userCert));
            out.println("<br/>getRAType : " + this.getRAType(userCert));
            out.println("<br/>getCertIdentification : " + this.getCertIdentification(userCert));
            out.println("<br/>getCertIssue : " + this.getCertIssue(userCert));
            out.println("<br/>getCertType : " + this.getCertType(userCert));

            //subjectCN에서 이름추출(테스트용이니 업무단에서 사용하면 안됩니다.)
            String cn2Name = subjectCN;
            //cn2Name = "ABC홍길동-TEST1234";
            java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("[(-]|[0-9]"); //(, -, 숫자
            //pattern = java.util.regex.Pattern.compile("\\(|-|[0-9]");
            java.util.regex.Matcher matcher = pattern.matcher(cn2Name);
            if (matcher.find()) cn2Name = cn2Name.substring(0, matcher.start());
            out.println("<br/>cn2Name [<b>" + cn2Name + "</b>]");

    } catch(DelfinoServiceException e) {
        //System.out.println(request.getParameter(SignVerifier.PKCS7_NAME)); //PKCS7 데이타 오류 확인을 위해 로그 저장 필요
        out.println("<br/><hr/><b>DelfinoServiceException - ERR(?)</b>");
        out.println("<br/>getServletPath: " + request.getServletPath());
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
    public String getBankName(X509Certificate userCert) {
        String bankName = "";
        String subjectCN = CertUtil.getSubjectEntry(userCert, CertUtil.NAME_CN, 0);
        int index = subjectCN.indexOf(")");
        String bankCode = subjectCN.substring(index+1, index+5);
        if (bankCode.equals("0025")) {
            bankName = "0025$서울은행";
        } else if (bankCode.equals("0039")) {
            bankName = "0039$경남은행";
        } else if (bankCode.equals("0034")) {
            bankName = "0034$광주은행";
        } else if (bankCode.equals("0004")) {
            bankName = "0004$국민은행";
        } else if (bankCode.equals("0003")) {
            bankName = "0003$기업은행";
        } else if (bankCode.equals("0011")) {
            bankName = "0011$농협중앙회";
        } else if (bankCode.equals("0031")) {
            bankName = "0031$대구은행";
        } else if (bankCode.equals("0055")) {
            bankName = "0055$도이치은행";
        } else if (bankCode.equals("0032")) {
            bankName = "0032$부산은행";
        } else if (bankCode.equals("0002")) {
            bankName = "0002$산업은행";
        } else if (bankCode.equals("0057")) {
            bankName = "0057$상하이은행";
        } else if (bankCode.equals("0007")) {
            bankName = "0007$수협중앙회";
        } else if (bankCode.equals("0026")) {
            bankName = "0026$신한은행";
        } else if (bankCode.equals("0053")) {
            bankName = "0053$시티은행";
        } else if (bankCode.equals("0005")) {
            bankName = "0005$외환은행";
        } else if (bankCode.equals("0071")) {
            bankName = "0071$우체국";
        } else if (bankCode.equals("0037")) {
            bankName = "0037$전북은행";
        } else if (bankCode.equals("0023")) {
            bankName = "0023$제일은행";
        } else if (bankCode.equals("0035")) {
            bankName = "0035$제주은행";
        } else if (bankCode.equals("0021")) {
            bankName = "0021$조흥은행";
        } else if (bankCode.equals("0006")) {
            bankName = "0006$주택은행";
        } else if (bankCode.equals("0083")) {
            bankName = "0083$평화은행";
        } else if (bankCode.equals("0081")) {
            bankName = "0081$하나은행";
        } else if (bankCode.equals("0027")) {
            bankName = "0027$시티은행";
        } else if (bankCode.equals("0020")) {
            bankName = "0020$한빛은행";
        } else if (bankCode.equals("0054")) {
            bankName = "0054$홍콩은행";
        }
        return bankName;
    }

    public String getRAType(X509Certificate userCert) {
        return CertUtil.getIssuerEntry(userCert, CertUtil.NAME_O, 0).toLowerCase();
    }

    public String getCertIdentification(X509Certificate userCert) {
        String certIdentification = "";
        String oid = CertUtil.getCertificatePolicyOID(userCert);
        if (oid.equals("1.2.410.200004.5.2.1.2") || oid.equals("1.2.410.200004.5.1.1.5") || oid.equals("1.2.410.200005.1.1.1") || oid.equals("1.2.410.200004.5.3.1.9") || oid.equals("1.2.410.200004.5.4.1.1") || oid.equals("1.2.410.200012.1.1.1")) {
            certIdentification = "01";
        } else if (oid.equals("1.2.410.200005.1.1.2")) {
            certIdentification = "02";
        } else if (oid.equals("1.2.410.200005.1.1.4") || oid.equals("1.2.410.200004.5.2.1.7.1") || oid.equals("1.2.410.200004.5.4.1.101") || oid.equals("1.2.410.200012.1.1.101")) {
            certIdentification = "04";
        } else if (oid.equals("1.2.410.200004.5.2.1.1") || oid.equals("1.2.410.200004.5.1.1.7") || oid.equals("1.2.410.200005.1.1.5") || oid.equals("1.2.410.200004.5.3.1.1") || oid.equals("1.2.410.200004.5.3.1.2") || oid.equals("1.2.410.200004.5.4.1.2") || oid.equals("1.2.410.200012.1.1.3") || oid.equals("1.2.410.200005.1.1.6.1") || oid.equals("1.2.410.200005.1.1.6.3")) {
            certIdentification = "05";
        } else if (oid.equals("1.2.410.200005.1.1.6.2")) {
            certIdentification = "06";
        } else if (oid.equals("1.2.410.200005.1.1.6.8")) {
            certIdentification = "68";
        }
        return certIdentification;
    }

    public String getCertIssue(X509Certificate userCert) {
        String issuerO = CertUtil.getIssuerEntry(userCert, CertUtil.NAME_O, 0).toLowerCase();
        String certIssuer = "";
        if (issuerO.equals("yessign")) {
            certIssuer = "01";
        } else if (issuerO.equals("tradesign")) {
            certIssuer = "02";
        } else if (issuerO.equals("crosscert")) {
            certIssuer = "03";
        } else if (issuerO.equals("signkorea")) {
            certIssuer = "04";
        } else if (issuerO.equals("kica")) {
            certIssuer = "05";
        } else if (issuerO.equals("ncasign")) {
            certIssuer = "06";
        }
        return certIssuer;
    }

    public String getCertType(X509Certificate userCert) {
        String issuerO = CertUtil.getIssuerEntry(userCert, CertUtil.NAME_O, 0).toLowerCase();
        String certType = "";
        if (issuerO.equals("yessign") || issuerO.equals("tradesign") || issuerO.equals("crosscert") || issuerO.equals("signkorea") || issuerO.equals("kica") || issuerO.equals("ncasign")) {
            certType = "public";
        } else {
            certType = "private";
        }
        return certType;
    }
%>
