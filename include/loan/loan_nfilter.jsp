<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- OS가 Windows가 아닌경우 nFilter 사용. --%>
<c:if test='${nfilter eq true }'>
	<%@include file="/resources/security/nfilter/jsp/open_nFilter.jsp" %>
	<script>
	function resetInit() {
	    var css = document.getElementById("open_nFilter_css");
	    var nfilter = document.getElementById("nfilter_document");

	    if (css != null || nfilter != null) {
	        nFilterIsMobileRequest = null;
	        css.remove();
	        document.body.removeChild(nfilter);
	    }
	}
	/**  Open Web nFilter 초기화  **/
	function initializedNFilter() {
	    OnInitStart();
	
	    // 디바이스 사이즈 체크 후 키패드 사이즈 설정
	    var deviceWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
	    setNFilterScreenSize(deviceWidth);
	
	    // 터치 속도 지정 api
	    setNFilterInputTime("200");
	
	    // Open Web nFilter 키패드 설정
	    //setNFilterMoneyFormatting("sample4_display_element");
	    setNFilterEnableNoSecret(true);
	    setNFilterCommon(document.getElementById('ssn2'), "mode=number");
	    if(${mobile eq true}) {
	    	setNFilterMobileInit();	// 모바일가상키보드
	    }else {
	    	setNFilterInit();	// PC가상키보드
	    }
	}
	
	function encryptedNFilter() {
	    /** 암호화 **/
	    $('#encData').val(encodeURIComponent(nFilterEncrypted()));
	}
	$(function() {
		initializedNFilter();
		
		/* 
		resetInit();
        initializedNFilter();
        setNFilterInit(); 
        */
	});
	</script>
</c:if>
