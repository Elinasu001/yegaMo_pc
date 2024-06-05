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
			<h1><a href="#"><img src="<c:url value="/resources/mobile/images/common/img_logo_20191119.png"/>" alt="Yegaram Savings Bank 예가람저축은행"/></a></h1>
		</div>
	</div>
	<!-- //e:header -->
	<!-- ********** //Include ********** -->

	<!-- s contentsWrap -->
	<div id="contentsWrap" class="bg-cts">
		<!-- s:contents -->
		<div class="contents default-wrap">
			<div class="error-wrap">
				<h2 class="font32 color-333333 mb5">사이트 에러</h2>
				<p class="font16 color-495057 mb10">에러페이지 안내</p>
				<hr class="mb30">
				<div class="info-txt bg-error">
					<p class="font18 color-333333">일시적 오류가 발생하였습니다.<br/>메인페이지로 이동 후,<br/>다시 이용해 주시길 바랍니다.<br/><span>서비스 이용에 불편을 드려 죄송합니다.</span></p>
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
				<!-- <p>상기인은 예가람저축은행과 대출모집업무 위탁계약을 체결한 ㈜***** 대출모집법인 소속으로 저축은행중앙회에 등록된 대출상담사 입니다. 또한 대출 진행시 고객에게 별도의 수수료를 요구하거나 수취하지 않으며, 대출이자 또는 원금연체시 신용상의 불이익이 있을 수 있습니다. 대출모집법인 소비자보호 담당자 / 예가람저축은행 소비자보호담당자 : 홍길동 070-1234-1234</p> -->
				<p>예가람저축은행&nbsp;&nbsp;|&nbsp;&nbsp;사업자등록번호 : 107-86-66267&nbsp;&nbsp;|&nbsp;&nbsp;주소 :  서울시 강남구 테헤란로 419&nbsp;&nbsp;|&nbsp;&nbsp;고객지원팀 : 1877-7788&nbsp;&nbsp;|&nbsp;&nbsp;금융사기 야간콜센터 (02)3978-600,800<br>   준법감시인 심의필 제2018-025호(2018.05.23)&nbsp;&nbsp;|&nbsp;&nbsp;Copyright © 2018 Yegaram Savings Bank. All Rights Reserved.</p>
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