<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../include/inc_header.jspf" %>
</head>
<body>
<!-- ********** Include ********** -->
<!-- s:bg -->
<div class="bg1">
	<svg version="1.1" xmlns="http://www.w3.org/2000/svg" id="motion1">
		<defs>
			<filter id="goo">
				<feGaussianBlur in="SourceGraphic" result="blur" stdDeviation="10" />
				<feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 18 -7" result="goo" />
				<feBlend in2="goo" in="SourceGraphic" result="mix" />
			</filter>
			<linearGradient id="MyGradient">
				<stop offset="5%"  stop-color="#EFF8FF"/>
				<stop offset="40%" stop-color="#EFF8FF"/>
				<stop offset="100%" stop-color="#EFF8FF"/>
			</linearGradient>
		</defs>
		<mask id="maska">
			<g class="bg-blobs">
				<circle class="bg-blob" cx="400" cy="380" r="100"  transform="rotate(0) translate(0, 0) rotate(0)"/>
				<circle class="bg-blob" cx="570" cy="480" r="140"  transform="rotate(0) translate(0, 0) rotate(0)"/>
			</g>
		</mask>
		<rect x="0" y="0"  mask="url(#maska)" fill="url(#MyGradient)" width="100%" height="100%">
	</svg>
</div>
<!-- //e:bg -->
<!-- ********** //Include ********** -->
<!-- ********** Include ********** -->
<!-- s:bg -->
<div class="bg1">
	<svg version="1.1" xmlns="http://www.w3.org/2000/svg" id="motion1">
		<defs>
			<filter id="goo">
				<feGaussianBlur in="SourceGraphic" result="blur" stdDeviation="10" />
				<feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 18 -7" result="goo" />
				<feBlend in2="goo" in="SourceGraphic" result="mix" />
			</filter>
			<linearGradient id="MyGradient">
				<stop offset="5%"  stop-color="#EFF8FF"/>
				<stop offset="40%" stop-color="#EFF8FF"/>
				<stop offset="100%" stop-color="#EFF8FF"/>
			</linearGradient>
		</defs>
		<mask id="maska">
			<g class="bg-blobs">
				<circle class="bg-blob" cx="400" cy="380" r="100"  transform="rotate(0) translate(0, 0) rotate(0)"/>
				<circle class="bg-blob" cx="580" cy="490" r="150"  transform="rotate(0) translate(0, 0) rotate(0)"/>
			</g>
		</mask>
		<rect x="0" y="0"  mask="url(#maska)" fill="url(#MyGradient)" width="100%" height="100%">
	</svg>
</div>
<!-- //e:bg -->
<!-- ********** //Include ********** -->
<!-- ********** Include ********** -->
<!-- s:skipnavi -->
<ul id="skipnavi">
	<li><a href="#contentsWrap">본문 바로가기</a></li>
	<li><a href="#footerWrap">하단 바로가기</a></li>
</ul>
<!-- ********** //Include ********** -->
<!-- //e:skipnavi -->
<!-- s:wrap -->
<div id="wrap">
	<!-- ********** Include ********** -->
	<!-- s:header -->
	<div id="headerWrap">
		<div class="header">
			<h1><a href="/main/main.do"><img src="<c:url value="/resources/mobile/images/common/img_logo_20191119.png"/>" alt="Yegaram Savings Bank 예가람저축은행"/></a></h1>
		</div>
	</div>
	<!-- //e:header -->
	<!-- ********** //Include ********** -->

	<!-- s contentsWrap -->
	<div id="contentsWrap" class="bg-cts">
		<!-- s:contents -->
		<div class="contents default-wrap">
			<div class="error-wrap">
				<h2 class="font32 color-333333 mb5">사이트 접속불가</h2>
				<p class="font16 color-495057 mb10">에러페이지 안내</p>
				<hr class="mb30">
				<div class="info-txt bg-not">
					<p class="error-msg bg-not font18 color-333333">현재 해당 예가람저축은행<br/>모집인상담사 사이트는 접속이 불가능합니다.<br/><span>상담사 연락을 통해,<br/> 사이트 URL을 다시한번 확인해주세요<br/>감사합니다.</span></p>
				</div>
			</div>
		</div>
		<!-- //e:contents -->
	</div>
	<!-- //e: contentsWrap -->

	<!-- ********** Include ********** -->
	<!-- s footerWrap -->
	<div id="footerWrap">
		<div class="default-wrap">
			<div class="copyright"> 
                <p>예가람저축은행&nbsp;&nbsp;|&nbsp;&nbsp;사업자등록번호 : <c:out value="${_PROPS.BIZ_NO.VALUE}"/> &nbsp;&nbsp;|&nbsp;&nbsp;주소 : <c:out value="${_PROPS.ADDR.VALUE}"/>&nbsp;&nbsp;|&nbsp;&nbsp;고객지원팀 : <c:out value="${_PROPS.SRVC_CNTR.VALUE}"/>&nbsp;&nbsp;|&nbsp;&nbsp;금융사기 야간콜센터 : <c:out value="${_PROPS.CALL_CENTER.VALUE}"/><br>
                    준법감시인 심의필 <c:out value="${_PROPS.DELIBERATION.VALUE}"/>&nbsp;&nbsp;|&nbsp;&nbsp;Copyright © 2018 Yegaram Savings Bank. All Rights Reserved.</p>
			</div>
			<!-- s:family-site-wrap -->
			<%@ include file="../include/inc_body_family_site.jspf" %>
			<!-- //e:family-site-wrap -->
		</div>
	</div>
	<!-- //e:footerWrap -->
	<!-- ********** //Include ********** -->
</div>
<!-- //e:wrap -->
</body>
</html>