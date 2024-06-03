<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.nshc.nfilter.openweb.OpenWebNFilterConfig" %>

<!-- ECDHTest 참조 -->
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/jsbn.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/jsbn2.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/prng4.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/rng.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/ec.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/sec.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/core.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/enc-base64.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/cipher-core.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/seed.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/mode-cfb.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/nsjs_api.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/int10.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/asn1.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/base64.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<!-- OWN default script -->
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/open_nFilter.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>
<script language="JavaScript" type="text/javascript" src="<%=request.getContextPath()%>/resources/security/nfilter/js/secretUtil.js" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" ></script>

<script type="text/javascript" charset="<%=OpenWebNFilterConfig.getFileEncoding()%>" >
    // ----------------------------------
    // TODO: You must set - nFilter Variables
    // ----------------------------------
    nFilterSiteCode ="<%=OpenWebNFilterConfig.getSiteCode()%>";
    nFilterContextPath = "<%=request.getContextPath()%>";
    nFilterJSPath = nFilterContextPath + "/resources/security/nfilter/js/";
    nFilterCSSPath = nFilterContextPath + "/resources/security/nfilter/css/" + nFilterSiteCode + "/";
    nFilterCSSMobilePath = nFilterContextPath + "/resources/security/nfilter/css/" + nFilterSiteCode + "/";
    nFilterIsResourceAutoLoad = false;
    nFilterIsNonSecretKeypad = false;
    nFilterFileEncoding = "<%=OpenWebNFilterConfig.getFileEncoding()%>";
    nFilterDefaultLanguage = "<%=OpenWebNFilterConfig.getKeypadDefaultLang()%>"; // Default
    nFilterLanguage = "<%=OpenWebNFilterConfig.getKeypadDefaultLang()%>"; // Default
    nFilterImageRenderType = "<%=OpenWebNFilterConfig.getImageRenderType()%>";
    nFilterRandomIdLength = <%=OpenWebNFilterConfig.getRandomIdLength()%>;
    nFilterUserInputMin = <%=OpenWebNFilterConfig.getUserInputMinLength()%>;
    nFilterUserInputMax = <%=OpenWebNFilterConfig.getUserInputMaxLength()%>;
    nFilterIsKeypadEncode = <%=OpenWebNFilterConfig.getIsKeypadEncode()%>;
    nFilterIsEncryptImmediate = <%=OpenWebNFilterConfig.getIsEncryptImmediate()%>;
    nFilterServiceNameKeypadManager = "<%=OpenWebNFilterConfig.getServiceNameKeypadManager()%>";
    nFilterServiceNameImageManager = "<%=OpenWebNFilterConfig.getServiceNameImageManager()%>";
    nFilterAlgName = "<%=OpenWebNFilterConfig.getAlgName()%>";
    nFilterNumType = "<%=OpenWebNFilterConfig.getKeypadTypeNum()%>";
    nFilterKeyLength = "<%=OpenWebNFilterConfig.getKeyLength()%>";
</script>
