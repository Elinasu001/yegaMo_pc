<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@
page import="java.net.*, java.io.*, java.util.*, java.text.SimpleDateFormat" %><%@
page session="false"%><%!
    //Last Update: 2017/02/27 WIZVERA
    private static final boolean DEBUG_MODE = true;
    private static final boolean TRACE_MODE = true;

    private static final boolean USE_WIZVERA_CONFIG = true;
    private static final String PATTERN = "yyyy/MM/dd HH:mm:ss";

    private static String[] CERT_RELAY_SERVERS;
    public void jspInit() {
        boolean useWizveraConfig = USE_WIZVERA_CONFIG;
        if (useWizveraConfig == false) {
            Properties conf = new Properties();
            ServletConfig servletConfig = getServletConfig();
            ServletContext context = servletConfig.getServletContext();
            try{
                conf.load(context.getResourceAsStream("/WEB-INF/lib/delfino.properties"));
                //conf.load(new java.io.FileInputStream("/fsutil/security/wizvera/lib/delfino.properties"));
                String server1 = conf.getProperty("certRelay.server.1", "http://127.0.0.1");
                String server2 = conf.getProperty("certRelay.server.2", "http://127.0.0.1");
                printTraceMessage("certRelay.jspInit[" + server1 + "][" + server2 + "]");
                String[] certRelayServers = {server1, server2};
                CERT_RELAY_SERVERS = certRelayServers;
            }
            catch(Exception e){ }
        }
    }
    public static String[] getCertRelayServers(){
        boolean useWizveraConfig = USE_WIZVERA_CONFIG;
        if (useWizveraConfig == false && CERT_RELAY_SERVERS != null) return CERT_RELAY_SERVERS;

        String server1 = com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("certRelay.server.1", "http://127.0.0.1");
        String server2 = com.wizvera.WizveraConfig.getDefaultConfiguration().getProperty("certRelay.server.2", "http://127.0.0.1");
        printTraceMessage("certRelay.wizConfig[" + server1 + "][" + server2 + "]");
        String[] certRelayServers = {server1, server2};
        return certRelayServers;
    }

    public static Map parseUrlEncodedParameters(String urlEncodedParams, String encoding) throws UnsupportedEncodingException {
        if ( encoding == null ) encoding = "UTF-8";

        Map map = new HashMap();
        String[] entries = urlEncodedParams.split("&");
        for (String entry : entries) {
            String[] keyValue = entry.split("=");
            if ( keyValue.length == 2 ) {
                map.put(URLDecoder.decode(keyValue[0], encoding), URLDecoder.decode(keyValue[1], encoding));
            }
        }
        return map;
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
                sb.append(URLEncoder.encode(value, encoding));
            }
        }
        return sb.toString();
    }

    public static final void printDebugMessage(String message){
        if(!DEBUG_MODE) return;
        String logDate = new SimpleDateFormat(PATTERN).format(new Date());
        System.out.println(String.format("[%s][RELAY][ERORR] %s", logDate, message));
    }
    public static final void printTraceMessage(String message){
        if(!TRACE_MODE) return;
        String logDate = new SimpleDateFormat(PATTERN).format(new Date());
        System.out.println(String.format("[%s][RELAY][TRACE] %s", logDate, message));
    }
    public static final String convertServerUrl(String serverUrl){
        return serverUrl.replace("certMove.do", "certMoveCheck.do");
    }
%><%
    //printTraceMessage(request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
    String[] certRelayServers = getCertRelayServers();
    boolean isCheck = false;
%><%
    String errMsg = null;
    Map<String, String[]> paramMap = request.getParameterMap();

    String inputString = encodeParameterMap(paramMap, "UTF-8");
    byte[] inputData = inputString.getBytes("UTF-8");
    printTraceMessage("request: " + inputString);

    if(paramMap == null || paramMap.size() == 0){
        errMsg = "cert relay request message is malformed.";
        printDebugMessage(errMsg);
        response.sendError(500, errMsg);
        return;
    }

    int index = 0;
    String cmd = "";
    try {
        index = Math.abs(Integer.parseInt(request.getParameter("index")));
        cmd = request.getParameter("cmd");
    } catch (Exception e) {}

    String serverUrl = null;

    int serverUrlIndex = index % certRelayServers.length;
    serverUrl = certRelayServers[serverUrlIndex];

    if ("check".equals(request.getParameter("cmd"))) isCheck = true;
    if (isCheck) serverUrl = convertServerUrl(serverUrl);
    printTraceMessage(String.format("index[%s,%d,%d], serverUrl[%s]", cmd, index, serverUrlIndex, serverUrl));

    URL url = null;
    try {
        url = new URL(serverUrl);   // Wizin-Relay Server URL
    }
    catch (MalformedURLException e) {
        errMsg = "cert relay server url[" + serverUrl + " ] is malformed.";
        printDebugMessage(errMsg);
        response.sendError(500, errMsg);
        return;
    }

    HttpURLConnection conn = null;

    try {
        conn = (HttpURLConnection) url.openConnection();
    }
    catch (IOException e) {
        errMsg = "cannot open the connection with [" + serverUrl +"]";
        printDebugMessage(errMsg);
        response.sendError(500, errMsg);
        return;
    }
    conn.setConnectTimeout(3000);
    conn.setDoInput(true);
    conn.setDoOutput(true);
    conn.setUseCaches(false);

    try {
        conn.setRequestMethod("POST");
    }
    catch (ProtocolException e) {
        response.sendError(500);
        return;
    }

    OutputStream os = null;
    try {
        os = conn.getOutputStream();
    }
    catch (IOException e) {
        errMsg = "cannot get the output stream from the remote server[" + serverUrl +"]";

        conn.disconnect();

        // next server로 이동
        if( serverUrlIndex + 1 == certRelayServers.length){
            serverUrlIndex = 0;
        }else{
            serverUrlIndex = serverUrlIndex + 1;
        }
        serverUrl = certRelayServers[serverUrlIndex];
        if (isCheck) serverUrl = convertServerUrl(serverUrl);

        errMsg += " next server[" + serverUrl + "][" + cmd + "]";
        printTraceMessage(errMsg);

        URL retryUrl = null;
        try {
            retryUrl = new URL(serverUrl);  // Wizin-Relay Server URL
        }
        catch (MalformedURLException e1) {
            errMsg = "retry server url[" + serverUrl + "] is malformed.";
            printDebugMessage(errMsg);
            response.sendError(500, errMsg);
            return;
        }

        try {
            conn = (HttpURLConnection) retryUrl.openConnection();
        }
        catch (IOException e1) {
            errMsg = "cannot open the connection with retry server[" + serverUrl +"]";
            printDebugMessage(errMsg);
            response.sendError(500, errMsg);
            return;
        }
        conn.setConnectTimeout(3000);
        conn.setDoInput(true);
        conn.setDoOutput(true);
        conn.setUseCaches(false);

        try {
            conn.setRequestMethod("POST");
        }
        catch (ProtocolException e1) {
            response.sendError(500);
            return;
        }

        try {
            os = conn.getOutputStream();
        }catch (IOException e1) {
            errMsg = "cannot get the output stream from the remote retry relay server[" + serverUrl + "]";
            printDebugMessage(errMsg);
            response.sendError(500, errMsg);
            return;
        }
        //printTraceMessage("forward the request to retry server[" + serverUrl +"]");
    }

    try {
        os.write(inputData, 0, inputData.length);
    }
    catch (IOException e) {
        errMsg = "error has occured while writing the data to remote server[" + serverUrl + "]";
        printDebugMessage(errMsg);
        response.sendError(500, errMsg);
    }finally {
        try { os.close(); } catch (IOException e) { e.printStackTrace();}
    }

    int responseCode = -1;
    try {
        responseCode = conn.getResponseCode();
    }
    catch (IOException e) {
        errMsg = "error has occurred connecting to the remote server to get response code[" + serverUrl + "]";
        printDebugMessage(errMsg);
        response.sendError(500, errMsg);
        return;
    }

    String responseData = null;
    byte[] byteData = null;

    if ( responseCode == HttpURLConnection.HTTP_OK ) {
        InputStream is2 = null;
        try {
            is2 = conn.getInputStream();
        }
        catch (IOException e) {
            errMsg = "cannot get the input stream from remote server[" + serverUrl + "]";
            printDebugMessage(errMsg);
            response.sendError(500, errMsg);
            return;
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] byteBuffer = new byte[1024];
        int respLength = 0;
        try {
            while ((respLength = is2.read(byteBuffer, 0, byteBuffer.length)) != -1) {
                baos.write(byteBuffer, 0, respLength);
            }
        }
        catch (IOException e) {
            errMsg = "error has occured while reading the data from remote server[" + serverUrl + "]";
            printDebugMessage(errMsg);
            response.sendError(500, errMsg);
            return;
        }finally {
            try { is2.close(); }    catch (IOException e) { e.printStackTrace();}
        }
        byteData = baos.toByteArray();

        response.setContentType(conn.getContentType());
        response.setContentLength(byteData.length);
        response.setHeader("Access-Control-Allow-Origin", "*");
        try {
            String resultString = new String(byteData, "UTF-8");
            printTraceMessage("response: " + resultString);
            response.getWriter().write(resultString);
        }
        catch (Exception e) {
            errMsg = "error has occured while writing the data to response.";
            printDebugMessage(errMsg);
            response.sendError(500, errMsg);
            return;
        }

        try { baos.close(); } catch (Exception e) {}
    } else {
        errMsg = "cert relay server responseCode: " + responseCode;
        printDebugMessage(errMsg);
        response.sendError(responseCode, errMsg);
    }
%>