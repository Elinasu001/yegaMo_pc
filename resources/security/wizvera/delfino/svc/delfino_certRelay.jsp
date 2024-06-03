<%-- --------------------------------------------------------------------------
- File Name   : delfino_certRelay.jsp (N server)
- Include     : none
- Author      : WIZVERA
- Last Update : 2020/09/15
-------------------------------------------------------------------------- --%><%@
page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@
page import="java.net.*, java.io.*, java.util.*, java.text.SimpleDateFormat" %><%@
page session="true"%><%!

    private static final boolean ERROR_MODE = true;
    private static final boolean DEBUG_MODE = false; //TODO: 취약점점검시 false로 설정
    private static final String VERSION_INFO = "v3.20200604";
    private static final String LOG_PATTERN = "[yyyy/MM/dd HH:mm:ss]";
    private static final String LOG_TAG = "[RELAY]";

    private static final int HTTP_readTimeout = 3000;
    private static final int HTTP_connectTimeout = 3000;
    private static final int HTTP_relayTimeout = HTTP_connectTimeout*2 + 1000;

    private static final boolean USE_WIZVERA_CONFIG = true;
    private static final int DEFAULT_RELAY_SVR_CNT = 2;
    private static final String RELAY_CNT_PROP = "certRelay.server.cnt";
    private static final String RELAY_SVR_PROP = "certRelay.server.";
    public static String[] CERT_RELAY_SERVERS = null;

    public void jspInit() {
        boolean useWizveraConfig = USE_WIZVERA_CONFIG;
        if (useWizveraConfig == false) {
            Properties conf = new Properties();
            ServletConfig servletConfig = getServletConfig();
            ServletContext context = servletConfig.getServletContext();
            try{
                conf.load(context.getResourceAsStream("/WEB-INF/lib/delfino.properties"));
                //conf.load(new java.io.FileInputStream("/fsutil/security/wizvera/lib/delfino.properties"));

                int relaySvrCnt = Integer.parseInt(conf.getProperty(RELAY_CNT_PROP, Integer.toString(DEFAULT_RELAY_SVR_CNT)));
                CERT_RELAY_SERVERS = new String[relaySvrCnt];
                for (int i=0; i<relaySvrCnt; i++) {
                    CERT_RELAY_SERVERS[i] = conf.getProperty(RELAY_SVR_PROP + (i+1), "");
                    printDebugMessage("jspInit", "certRelay.jspInit: SVR." + (i+1) + "[" + CERT_RELAY_SERVERS[i] + "]");
                }
            } catch(Exception e){
                printErrorMessage("jspInit", e.toString());
                if (DEBUG_MODE) e.printStackTrace();
            }
        }
    }

    public static String[] getCertRelayServers() {
        boolean useWizveraConfig = USE_WIZVERA_CONFIG;
        if (useWizveraConfig == false && CERT_RELAY_SERVERS != null) return CERT_RELAY_SERVERS;

        int relaySvrCnt = Integer.parseInt(com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty(RELAY_CNT_PROP, Integer.toString(DEFAULT_RELAY_SVR_CNT)));
        String[] servers = new String[relaySvrCnt];
        for (int i=0; i<relaySvrCnt; i++) {
            servers[i] = com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty(RELAY_SVR_PROP + (i+1), "");
        }
        //return servers;

        boolean changeConfig = false;
        if (CERT_RELAY_SERVERS == null || CERT_RELAY_SERVERS.length != servers.length) {
            changeConfig = true;
            CERT_RELAY_SERVERS = new String[relaySvrCnt];
            //for (int i=0; i<relaySvrCnt; i++) CERT_RELAY_SERVERS[i] = "";
        } else {
            for (int i=0; i<relaySvrCnt; i++) {
                if (!servers[i].equals(CERT_RELAY_SERVERS[i])) changeConfig = true;
            }
        }

        if (changeConfig) {
            for (int i=0; i<relaySvrCnt; i++) {
                CERT_RELAY_SERVERS[i] = servers[i];
                printDebugMessage("local", "certRelay.jspInit: SVR." + (i+1) + "[" + CERT_RELAY_SERVERS[i] + "]");
            }
        }

        return CERT_RELAY_SERVERS;
    }

    public static final String convertCheckUrl(String serverUrl){
        return serverUrl.replace("certMove.", "certMoveCheck.");
    }

    public static String cleanXSS(String value) {
        String sValid = value;
        if (sValid == null || sValid.equals("")) return sValid;
        sValid = sValid.replaceAll("&", "&amp;");
        sValid = sValid.replaceAll("<", "&lt;");
        sValid = sValid.replaceAll(">", "&gt;");
        sValid = sValid.replaceAll("\"", "&qout;");
        sValid = sValid.replaceAll("\'", "&#039;");
        sValid = sValid.replaceAll("\\r", "");
        sValid = sValid.replaceAll("\\n", "");
        //if (true) return value;
        return sValid;
    }
    public static String getParameter(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        if (value == null) value = "";
        return cleanXSS(value);
    }
    public static final String getRemoteAddr(HttpServletRequest request) {
        String clientIP = request.getHeader("X-Forwarded-For");
        if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getHeader("Proxy-Client-IP");
        if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getHeader("WL-Proxy-Client-IP");
        if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getHeader("HTTP_CLIENT_IP");
        if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getHeader("HTTP_X_FORWARDED_FOR");
        if (clientIP==null || clientIP.length()==0 || "unknown".equalsIgnoreCase(clientIP)) clientIP = request.getRemoteAddr();
        return clientIP;
    }
    public static final String getHostAddr(boolean isLastIp) {
        String hostAddr = "99";
        try {
            InetAddress inet = InetAddress.getLocalHost();
            hostAddr = InetAddress.getLocalHost().getHostAddress();
            if (isLastIp) hostAddr = hostAddr.substring(hostAddr.lastIndexOf(".")+1);
        } catch (Exception e) {}
        return hostAddr;
    }

    public static String encodeParameterMap(Map<String, String[]> map, String encoding) throws UnsupportedEncodingException {
        if ( encoding == null ) encoding = "UTF-8";

        StringBuffer sb = new StringBuffer();
        for (Map.Entry<String, String[]> entry : map.entrySet()) {
            String key = entry.getKey();
            for(String value : entry.getValue()){
                if (sb.length() > 0) sb.append("&");
                sb.append(URLEncoder.encode(key, encoding));
                sb.append("=");
                sb.append(URLEncoder.encode(cleanXSS(value), encoding));
            }
        }
        return sb.toString();
    }

    private static void trustAllHosts() {
        //Create a trust manager that does not validate certificate chains
        javax.net.ssl.TrustManager[] trustAllCerts = new javax.net.ssl.TrustManager[] { new javax.net.ssl.X509TrustManager() {
            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                return new java.security.cert.X509Certificate[] {};
            }
            public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType) throws java.security.cert.CertificateException {
            }
            public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType) throws java.security.cert.CertificateException {
            }
        }};

        //Install the all-trusting trust manager
        try {
            javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("TLS");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        } catch (Exception e) {
            if (DEBUG_MODE) e.printStackTrace();
        }
    }

    final static javax.net.ssl.HostnameVerifier DO_NOT_VERIFY = new javax.net.ssl.HostnameVerifier() {
        public boolean verify(String hostname, javax.net.ssl.SSLSession session) {
            //TODO: DEBUG_MODE_취약점오류
            if (!DEBUG_MODE) {
                String[] certRelayServers = getCertRelayServers();
                for (int i=0; i<certRelayServers.length; i++) {
                    if (certRelayServers[i].startsWith("https://" + hostname)) return true;
                }
                return false;
            }
            return true;
        }
    };

    public static Map<String, String> requestPost(String serverUrl, String requestParam, String requestContentType, String requestClientIp) {
        int responseCode = HttpURLConnection.HTTP_INTERNAL_ERROR;
        String contentType = "text/html;charset=UTF-8";
        String responseData = "";

        URL url = null;
        HttpURLConnection http = null;
        OutputStream os = null;
        InputStream is = null;
        ByteArrayOutputStream baos = null;
        try {
            url = new URL(serverUrl);
            http = (HttpURLConnection) url.openConnection();
            if (url.getProtocol().toLowerCase().equals("https")) {
                trustAllHosts();
                javax.net.ssl.HttpsURLConnection https = (javax.net.ssl.HttpsURLConnection) url.openConnection();
                https.setHostnameVerifier(DO_NOT_VERIFY);
                http = https;
            } else {
                http = (HttpURLConnection) url.openConnection();
            }
            byte[] postData = requestParam.getBytes("UTF-8");

            if (HTTP_connectTimeout > 0) http.setConnectTimeout(HTTP_connectTimeout);
            if (HTTP_readTimeout > 0) http.setReadTimeout(HTTP_readTimeout);

            http.setDoInput(true);
            http.setDoOutput(true);
            http.setUseCaches(false);
            http.setRequestMethod("POST");
            if (!"".equals(requestContentType)) http.setRequestProperty("content-type", requestContentType);
            if (!"".equals(requestClientIp)) http.setRequestProperty("X-Forwarded-For", requestClientIp);

            os = http.getOutputStream();
            os.write(postData, 0, postData.length);

            responseCode = http.getResponseCode();
            contentType = http.getContentType();

            //if (responseCode == HttpURLConnection.HTTP_OK) {}
            is = http.getInputStream();
            baos = new ByteArrayOutputStream();
            byte[] byteBuffer = new byte[1024];
            int respLength = 0;
            while ((respLength = is.read(byteBuffer, 0, byteBuffer.length)) != -1) {
                baos.write(byteBuffer, 0, respLength);
            }
            responseData = new String(baos.toByteArray(), "UTF-8");

        } catch (ConnectException e) {
            responseCode = HttpURLConnection.HTTP_BAD_GATEWAY;
            responseData = serverUrl + ": ConnectException";
            if (DEBUG_MODE) responseData += ":" + e.toString(); //e.getMessage(); //TODO: DEBUG_MODE_취약점오류
            printErrorMessage(requestClientIp, e.toString() + ": " + serverUrl);
            //if (DEBUG_MODE) e.printStackTrace();
        } catch (Exception e) {
            responseData = serverUrl + ": Exception";
            if (DEBUG_MODE) responseData += ":" + e.toString(); //e.getMessage(); //TODO: DEBUG_MODE_취약점오류
            printErrorMessage(requestClientIp, e.toString() + ": " + serverUrl);
            //if (DEBUG_MODE) e.printStackTrace();
        } finally {
            if (baos != null) try { baos.close(); } catch (Exception e) {};
            if (is != null)   try { is.close();   } catch (Exception e) {};
            if (os != null)   try { os.close();   } catch (Exception e) {};
            if (http != null) try { http.disconnect(); } catch (Exception e) {};
        }

        Map<String, String> resultMap = new HashMap<String, String>();
        resultMap.put("responseCode", Integer.toString(responseCode));
        resultMap.put("contentType", contentType);
        resultMap.put("responseData", responseData);
        return resultMap;
    }

    public static void responseWrite(HttpServletResponse response, int responseCode, String contentType, String responseData) {
        try {
            if (HttpURLConnection.HTTP_OK != responseCode) {
                //String errMsg = "responseWrite: " + responseData;
                //printDebugMessage(errMsg);
                response.sendError(responseCode, responseData);
                return;
            }

            //response.reset();
            //response.setContentType(contentType);
            response.setContentType(cleanXSS(contentType));
            response.setContentLength(responseData.getBytes("UTF-8").length);
            response.setHeader("Access-Control-Allow-Origin", "*");
            response.getWriter().write(responseData);
        } catch (Exception e) {
            printErrorMessage("responseWrite", e.toString());
        }
    }

    public static final void printErrorMessage(String label, String message){
        if(!ERROR_MODE) return;
        String logDate = new SimpleDateFormat(LOG_PATTERN).format(new Date());
        System.out.println(String.format("%s" + LOG_TAG + "[ERROR][%s] %s", logDate, label, message));
    }
    public static final void printWarnMessage(String label, String message){
        if(!ERROR_MODE) return;
        String logDate = new SimpleDateFormat(LOG_PATTERN).format(new Date());
        System.out.println(String.format("%s" + LOG_TAG + "[ WARN][%s] %s", logDate, label, message));
    }
    public static final void printDebugMessage(String label, String message){
        if(!DEBUG_MODE) return;
        String logDate = new SimpleDateFormat(LOG_PATTERN).format(new Date());
        System.out.println(String.format("%s" + LOG_TAG + "[DEBUG][%s] %s", logDate, label, message));
    }

    public static String getRequestParameter(HttpServletRequest request) {
        return getRequestParameter(request, "\n");
    }

    public static String getRequestParameter(HttpServletRequest request, String tag) {
        StringBuffer sb = new StringBuffer();
        java.util.Enumeration he3 = request.getParameterNames();
        sb.append(tag); //request.getContextPath() + request.getServletPath();
        sb.append("###########################################################################" + tag);
        sb.append("#" + request.getRequestURI() + " " + request.getMethod() + "][" + request.getRemoteAddr() + "]" + tag);
        sb.append("#   [Content-Type] = [" + request.getHeader("Content-Type") + "]" + tag);
        //request.getContextPath() + request.getServletPath()

        while (he3.hasMoreElements()) {
            String name = (String)he3.nextElement();
            String[] value = request.getParameterValues(name);
            if (value == null) {
                sb.append("#   [" + name + "] = [null]" + tag);
            } else {
                for (int i=0; i<value.length; i++) {
                    sb.append("#   [" + name + "] = [" + cleanXSS(value[i]) + "]" + tag);
                }
            }
        }
        sb.append("###########################################################################");
        return sb.toString();
    }

%><%

    request.setCharacterEncoding("UTF-8");
    boolean enableDebug = DEBUG_MODE;
    //enableDebug = false;
    String[] certRelayServers = getCertRelayServers();

    String cmd = getParameter(request, "cmd");
    Map<String, String[]> paramMap = request.getParameterMap();
    String requestParam = encodeParameterMap(paramMap, "UTF-8");
    String requestClientIp = getRemoteAddr(request);
    //String requestContentType = ""; //request.getHeader("Content-Type");
    //if (enableDebug) System.out.println(getRequestParameter(request));


    //서버URL이 HTTP 프로토콜이 아닐경우 에러처리
    boolean isError = false;
    String errMsg = "serverUrl is Not supported Protocol:";
    for (int i=0; i<certRelayServers.length; i++) {
        if (!certRelayServers[i].startsWith("http://")) {
            isError = true;
            errMsg += "<br/> certRelay.server." + (i+1) + "." + getHostAddr(true) + "[" + certRelayServers[i] + "]";
        }
    }
    if (isError && !"check".equals(cmd)) {
        printErrorMessage(requestClientIp, errMsg);
        responseWrite(response, HttpURLConnection.HTTP_INTERNAL_ERROR, "", errMsg);
        return;
    }


    //중계서버 상태 확인
    if ("check".equals(cmd)) {
        out.println("version: <b>" + VERSION_INFO + "</b>[" + USE_WIZVERA_CONFIG + "]<br/><br/>");
        if (isError) out.println("<b>" + errMsg + "</b><br/><br/>");
        for (int i=0; i<certRelayServers.length; i++) {
            String checkUrl = convertCheckUrl(certRelayServers[i]);
            Map<String, String> resultMap = requestPost(checkUrl, "", "", "99.99.99.99");
            int responseCode = Integer.parseInt(resultMap.get("responseCode"));
            //String contentType = resultMap.get("contentType");
            String responseData = resultMap.get("responseData");
            if (!DEBUG_MODE) responseData = cleanXSS(responseData.replaceAll("\"", "")); //TODO: DEBUG_MODE_취약점오류
            String resultMessage = "certRelay.server." + (i+1) + "." + getHostAddr(true) + " [" + checkUrl + "]<br/>responseCode [HTTP_" + responseCode + "]<br/> responseData [" + responseData + "]</br></br>";
            printDebugMessage(requestClientIp, resultMessage);
            out.println(resultMessage);
        }
        return;
    }

%><%

    int index = 0;
    int retryNum = 0;
    try {
        //index = Math.abs(Integer.parseInt(getParameter(request, "index")));
        index = Integer.parseInt(getParameter(request, "index"));
        if(index < 0) index = index & 0xff; //android fixed
    } catch (Exception e) { index = 0; }

    //serverAuth에서 오류로 인하여 NEXT서버로 접속될경우 수신대기(폴링)시 NEXT서버 사용하도록 index변경
    if (!"serverAuth".equals(cmd) && !"deviceAuth".equals(cmd) && Integer.toString(index).equals((String)session.getAttribute("certRelay_index")) && session.getAttribute("retryNum") != null) {
        try { retryNum = (Integer)session.getAttribute("retryNum"); } catch (Exception e) { retryNum = 0; }
        index = index + retryNum;
    } else if ("serverAuth".equals(cmd) || "deviceAuth".equals(cmd)) {
        session.removeAttribute("certRelay_index");
        session.removeAttribute("retryNum");
    }

    //처리결과 수신대기(폴링)시 로깅 설정: 최초 1번만 로깅처리
    if ("pubKeyReq".equals(cmd) && cmd.equals((String)session.getAttribute("certRelay_cmd"))) enableDebug = false;
    if (!"".equals(cmd) && DEBUG_MODE) session.setAttribute("certRelay_cmd", cmd); //TODO: DEBUG_MODE_취약점오류

    int serverUrlIndex = index % certRelayServers.length;
    String serverUrl = certRelayServers[serverUrlIndex];
    String retryMsg = "";

    long startTime = System.currentTimeMillis();
    if (enableDebug) printDebugMessage(requestClientIp, retryMsg+"REQ: svr."+ (serverUrlIndex+1) + "[" + index + "]["+ serverUrl + "] param[" + requestParam + "]");
    Map<String, String> resultMap = requestPost(serverUrl, requestParam, "", requestClientIp);
    int responseCode = Integer.parseInt(resultMap.get("responseCode"));
    String contentType = resultMap.get("contentType");
    String responseData = resultMap.get("responseData");

    //HTTP응답코드가 200이 아닐 경우 다음 서버로 재시도 처리
    while (HttpURLConnection.HTTP_OK != responseCode && retryNum < (certRelayServers.length-1)) {

        if ((HTTP_relayTimeout>1000) && ((System.currentTimeMillis()-startTime) > HTTP_relayTimeout)) break; //지정된 시간을 초과할경우 재시도 안함

        retryNum++;
        if (enableDebug) printDebugMessage(requestClientIp, retryMsg+"RES: svr."+ (serverUrlIndex+1) + "[" + index + "] code[HTTP_"+ responseCode + "] data[" + responseData + "]");
        if ("serverAuth".equals(cmd) || "deviceAuth".equals(cmd)) session.setAttribute("certRelay_index", Integer.toString(index));

        serverUrlIndex = (index+retryNum) % certRelayServers.length;
        serverUrl = certRelayServers[serverUrlIndex];
        retryMsg = retryNum + "re";

        if (enableDebug) printDebugMessage(requestClientIp, retryMsg+"REQ: svr."+ (serverUrlIndex+1) + "[" + index + "]["+ serverUrl + "] param[...]");
        resultMap = requestPost(serverUrl, requestParam, "", requestClientIp) ;
        responseCode = Integer.parseInt(resultMap.get("responseCode"));
        contentType = resultMap.get("contentType");
        responseData = resultMap.get("responseData");
    }

    session.setAttribute("retryNum", retryNum);

    //처리결과 수신대기(폴링)시 로깅 설정: 응답코드 변경시 다시 로깅
    if (!responseData.equals((String)session.getAttribute("certRelay_responseData"))) {
        session.removeAttribute("certRelay_cmd");
        enableDebug = DEBUG_MODE;
    }
    if (DEBUG_MODE) session.setAttribute("certRelay_responseData", responseData); //TODO: DEBUG_MODE_취약점오류

    long checkTime = System.currentTimeMillis()-startTime;
    if (checkTime > (HTTP_readTimeout+2000)) {
        printWarnMessage (requestClientIp, retryMsg+"RES: svr."+ (serverUrlIndex+1) + "[" + index + "] code[HTTP_"+ responseCode + "][" + checkTime/1000.0 + "] data[" + responseData + "]");
    } else if (enableDebug) {
        printDebugMessage(requestClientIp, retryMsg+"RES: svr."+ (serverUrlIndex+1) + "[" + index + "] code[HTTP_"+ responseCode + "][" + checkTime/1000.0 + "] data[" + responseData + "]");
    }
    responseWrite(response, responseCode, contentType, responseData);
%>