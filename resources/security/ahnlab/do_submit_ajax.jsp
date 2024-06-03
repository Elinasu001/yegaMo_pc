<%--
 * (C) Copyright AhnLab, Inc.
 *
 * Any part of this source code can not be copied with
 * any method without prior written permission from
 * the author or authorized person.
 *
 * @version		$Revision: 15649 $
 *
--%>
<%   
response.setHeader("Cache-Control","no-store");   
response.setHeader("Pragma","no-cache");   
response.setDateHeader("Expires",0);   
%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>

<%@page import="java.util.*,com.ahnlab.astx2.util.*,com.ahnlab.astx2.servlet.ASTX2LibCompact"%>
<%ASTX2LibCompact astx2 = new ASTX2LibCompact(request);%>

<%
	//astx2.setUniqueId(uniqid);
	
	JsonMap json = new JsonMap();
	json.set("result", "1");
		
	String value;
	
	value = astx2.getE2ENames();
	if(value.length() > 0) {	
		String[] names = value.split(",");
		Arrays.sort(names);
		
	 	for(String name: names) {
	 		value = astx2.getE2EValue(name);
	 		
	 		json.set(name, value);
	 		
			Trace.d("[do_submit_ajax] "+name+"="+value);
		}
	}

	out.println(json.toString());
%>
