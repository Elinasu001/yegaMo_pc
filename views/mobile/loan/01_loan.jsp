<%@page import="co.kr.yegaramsb.dsr.core.common.Constraints.RequestMappingUri"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="next" value="/${dsrId }/loan/02_realname" />
<c:set var="home" value="/${dsrId }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/inc_header.jspf" %>
<%@ include file="../../include/loan/step1.jspf" %>
</head>
<%@ include file="../include/inc_body_start.jspf" %>
	    <!-- s contentsWrap -->
	    <div id="contentsWrap">
	        <!-- s:contents -->
	        <div class="sub-contents default-wrap">
	        	<div class="loan-wrap">
	        		<ol class="loan-step clear mb30">
	        			<li class="step01 on">대출상담사 실명확인</li>
	        			<li class="step02">개인정보 및 대출정보입력</li>
	        			<li class="step03">약관동의 및 본인인증</li>
	        			<li class="step04">대출신청 완료</li>
	        		</ol>
					<h3 class="tit">대출상담사 설명확인</h3>
					<div class="line-box">금융회사는 대출모집상담사를 통해 접수된 대출의 경우, “대출모집인 제도 모범규준 제 10조 제 1항 2호”에 따라 대출 실행 이전에 대출신청인에게 아래 각 사항을 확인하여야 합니다. 아래의 질문사항에 대하여 직접 사실대로 작성하여 주시기 바랍니다.</div>
					<hr class="mt30" id="con0">
					<form id="frm1" onsubmit="next(); return false;">
					<ul class="confirm-wrap mb30">
						<li class="question-wrap" id="con1">
							<p class="question">대출계약을 체결하기 전에 대출상담사로부터 대출상품의 조건 및 대출내용 등에 관하여 충분한 설명을 받으셨나요? 대출계약 중요사항(금리, 대출금액, 대출기간, 중도상환수수료 등)에 대한 설명 포함</p>
							<p class="radio-area mt15 ta-r">
								<label for="radio11" class="radio"><input type="radio" name="desc-agree1" id="radio11" value="Y">예</label>
								<label for="radio12" class="radio"><input type="radio" name="desc-agree1" id="radio12" value="N">아니오</label>
							</p>
						</li>
						<li class="question-wrap" id="con2">
							<p class="question">대출상담사로부터 대출모집인은 금융회사의 업무위탁을 받아 대출모집 및 소개등의 섭외 활동을 한다는 사실에 대하여 사전에 고지 받으셨나요?</p>
							<p class="radio-area mt15 ta-r">
								<label for="radio21" class="radio"><input type="radio" name="desc-agree2" id="radio21" value="Y">예</label>
								<label for="radio22" class="radio"><input type="radio" name="desc-agree2" id="radio22" value="N">아니오</label>
							</p>
						</li>
						<li class="question-wrap" id="con3">
							<p class="question">대출모집상담사로부터 고객에게 별도의 수수료를 요구하거나 수취할 수 없다는 사실에 대하여 사전에 고지 받으셨나요?</p>
							<p class="radio-area mt15 ta-r">
								<label for="radio31" class="radio"><input type="radio" name="desc-agree3" id="radio31" value="Y">예</label>
								<label for="radio32" class="radio"><input type="radio" name="desc-agree3" id="radio32" value="N">아니오</label>
							</p>
						</li>
						<li class="question-wrap" id="con4">
							<p class="question">대출상담사로부터 여신심사 등을 통한 대출실행의 결정은 금융회사가 한다는 사실에 대하여 사전에 고지 받으셨나요?</p>
							<p class="radio-area mt15 ta-r">
								<label for="radio141" class="radio"><input type="radio" name="desc-agree4" id="radio141" value="Y">예</label>
								<label for="radio142" class="radio"><input type="radio" name="desc-agree4" id="radio142" value="N">아니오</label>
							</p>
						</li>
						<li class="question-wrap" id="con5">
							<p class="question">대출상담사로부터 귀하의 소득재산, 부채상환, 신용 및 변제계획 등을 고려하여 적합한 대출상품을 권유 받으셨나요?</p>
							<p class="radio-area mt15 ta-r">
								<label for="radio51" class="radio"><input type="radio" name="desc-agree5" id="radio51" value="Y">예</label>
								<label for="radio52" class="radio"><input type="radio" name="desc-agree5" id="radio52" value="N">아니오</label>
							</p>
						</li>
						<li class="question-wrap" id="con6">
							<p class="question">대출상담사로부터 귀하가 필요한 자금의 범위를 초과하여 대출을 받도록 권유 또는 유도 받으셨나요?</p>
							<p class="radio-area mt15 ta-r">
								<label for="radio61" class="radio"><input type="radio" name="desc-agree6" id="radio61" value="Y">예</label>
								<label for="radio62" class="radio"><input type="radio" name="desc-agree6" id="radio62" value="N">아니오</label>
							</p>
						</li>
						<li class="question-wrap" id="con7">
							<p class="question">대출상담사로부터 귀하가 원하지 않는 고금리 대출로 변경하도록 권유 또는 유도 받으셨나요?</p>
							<p class="radio-area mt15 ta-r">
								<label for="radio71" class="radio"><input type="radio" name="desc-agree7" id="radio71" value="Y">예</label>
								<label for="radio72" class="radio"><input type="radio" name="desc-agree7" id="radio72" value="N">아니오</label>
							</p>
						</li>
						<li class="question-wrap" id="con8">
							<p class="question pt10">대출 상담을 받은 모집상담사 이름은 무엇인가요?</p>
							<p class="mt15 ta-r">
								<span class="form-wrap d-inline-block mt15"><input type="text" id="name" placeholder="${sDsrUser.NAME }"></span>
							</p>
						</li>
					</ul>
					</form>
					<div class="btn-wrap">
						<button type="button" id="btn_next" class="btn-normal" onclick="next()">다음단계 진행</button>
						<span class="circle-big"><a href="<c:url value='${home }' />" class="btn-circle refresh big ir">취소</a></span>
					</div>
                </div>
	        </div>
	        <!-- //e:contents -->
	        <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
	    </div>
	    <!-- //e: contentsWrap -->

	    <!-- ********** Include ********** -->
	    <%@ include file="../include/inc_body_end.jspf" %>
	    <!-- ********** //Include ********** -->
	</div>
	<!-- //e:wrap -->
</body>
</html>