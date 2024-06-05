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
				<h2 class="font32 color-333333 mb5">안내</h2>
<!-- 				<p class="font16 color-495057 mb10">에러페이지 안내</p> -->
				<hr class="mb30">
				<div class="info-txt bg-not">
					<p style="text-align:left;">안정적인 서비스 제공을 위하여 대출 및 각종 신청/조회, 전자약정 업무가 일시 중단될 예정입니다.</p>
<p style="text-align:left;">이용에 참고하시기 바랍니다.</p><br>
<p style="text-align:left;">서비스 이용에 불편을 드려 죄송합니다.</p>
<p style="text-align:left;">앞으로 더 좋은 서비스로 보답하고자 노력하겠습니다.</p><br>
<p style="text-align:left;color:#ec008c;"> * 업무 중단 시간 </p>
<p style="text-align:left;color:#ec008c;"> - 2019.03.16(토) 09:00 ~ 17:00 (약 8시간)</p> 
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
				<!-- <p>상시인은 예가람저축은행과 대출모집업무 위탁계약을 체결한 ㈜***** 대출모집법인 소속으로 저축은행중앙회에 등록된 대출상담사 입니다. 또한 대출 진행시 고객에게 별도의 수수료를 요구하거나 수취하지 않으며, 대출이자 또는 원금연체시 신용상의 불이익이 있을 수 있습니다. 대출모집법인 소비자보호 담당자 / 예가람저축은행 소비자보호담당자 : 홍길동 <a href="tel:07012341234">070-1234-1234</a></p> --> <!-- 180412 삭제 -->
				<p>예가람저축은행 | 사업자등록번호 : 107-86-66267 | 주소 : 서울시 강남구 테헤란로 419 | 고객지원팀 : <a href="tel:1877-7788">1877-7788</a> | 금융사기 야간콜센터 <a href="tel:023978600">(02)3978-600</a>,800 준법감시인 심의필 제2018-025호(2018.05.23) | Copyright © 2018 Yegaram Savings Bank. All Rights Reserved.</p> <!-- 180412  class="mt10" 삭제 -->
			</div> <!-- 180403 a태그 추가 -->
			<!-- s:family-site-wrap -->
			<!-- <div class="family-site mt20 of-hi clear">
                <div class="fl-r">
                    <label class="blind" for="family-site">관련사이트</label>
                    <div class="select-wrap fl-l">
                        <select name="" id="family-site">
                        <option selected="selected" value="">관련사이트</option>
                        <option value="">관련사이트1</option>
                        </select>
                    </div>
                    <button type="button" name="button" onclick="goFamilySite()" class="fl-l">Go</button>
                </div>
            </div> --> <!-- 180412 삭제 -->
			<!-- //e:family-site-wrap -->
		</div>
	</div>
	<!-- //e:footerWrap -->
	<!-- ********** //Include ********** -->
</div>
<!-- //e:wrap -->
</body>
</html>