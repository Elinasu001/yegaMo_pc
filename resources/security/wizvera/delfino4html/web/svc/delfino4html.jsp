<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.delfino.html5.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.IOException" %>
<%!
    public void jspInit() {
        Properties g4conf = new Properties();

        ServletConfig servletConfig = getServletConfig();
        ServletContext context = servletConfig.getServletContext();
        InputStream in = null;
        try{
            in = context.getResourceAsStream("/WEB-INF/lib/delfino.properties");
            //in = new java.io.FileInputStream("/fsutil/security/wizvera/lib/delfino.properties");
            g4conf.load(in);
            
            //if (g4conf.getProperty("g4.storageSecret.bfa.allowIntervalTimeSec") == null) g4conf.setProperty("g4.storageSecret.bfa.allowIntervalTimeSec", "3");
            //if (g4conf.getProperty("g4.storageSecret.bfa.allowCountInDay") == null) g4conf.setProperty("g4.storageSecret.bfa.allowCountInDay", "100");
            //if (g4conf.getProperty("g4.storageSecret.bfa.lockTimeSec") == null) g4conf.setProperty("g4.storageSecret.bfa.lockTimeSec", "300");

            java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss]");
            System.out.println("##############################################################################");
            System.out.println("### Delfino-G4(delfino4html.jsp) load " + logDate.format(new java.util.Date()));
            System.out.println("### storageSecret[" + g4conf.getProperty("g4.storageSecret") + "]");
            System.out.println("### g4.storageSecret.bfa.allowIntervalTimeSec[" + g4conf.getProperty("g4.storageSecret.bfa.allowIntervalTimeSec") + "]");
            System.out.println("### g4.storageSecret.bfa.allowCountInDay[" + g4conf.getProperty("g4.storageSecret.bfa.allowCountInDay") + "]");
            System.out.println("### g4.storageSecret.bfa.lockTimeSec[" + g4conf.getProperty("g4.storageSecret.bfa.lockTimeSec") + "]");
            System.out.println("### certTransferDataServiceURL[" + g4conf.getProperty("g4.certTransferDataServiceURL") + "]");
            System.out.println("##############################################################################");
        }catch(Exception e){
            throw new RuntimeException("delfino-g4.properties not found");
        }finally{
            try{
                if(in!=null) in.close();
            }catch(IOException ignore){}
        }
        Service.setConfig(g4conf, context);
        //Service.setLoggingLevel(3);//0:none 1: error 2:info 3:debug
        //Service.setLoggingDir("file:/opt/delfino_g4/");
        //Service.setUseSession(false);
    }

%>
<%
    //response.setHeader("Access-Control-Allow-Origin","*");
    //System.out.println("service request:" + request.getParameter("service") + ", cmd:" + request.getParameter("cmd"));
    out.write(Service.service(request));
    //out.write(Service.service(request, getServletConfig().getServletContext()));
    //System.out.println("service response:" + request.getParameter("service") + ", cmd:" + request.getParameter("cmd"));
%>
