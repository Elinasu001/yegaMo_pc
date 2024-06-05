<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="co.kr.yegaramsb.dsr.core.common.Constraints"%>
<%-- 페이징 동의목록 페이지 --%>
<c:set var="back" value="/${dsrId }" />
<%-- 페이징 인증페이지 --%>
<c:set var="next" value="/${dsrId }/loan/03_retail_authorization" />
<c:set var="formAjax" value="<%= Constraints.RequestMappingUri.LoanRequestFormAjax %>" />
<c:set var="nfilter" value="true" />
<c:set var="mobile" value="true" />
<%-- Ajax 대출신청정보 등록 --%>
<c:set var="loan_request_form" value="/${dsrId }/loan/ajaxLoanRequestForm"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/inc_header.jspf" %>
<%@ include file="../../include/loan/loan_nfilter.jsp" %>
<%-- <%@ include file="../../include/loan/loan2.jspf" %> --%>
<%@ include file="../../mobile/include/loan2.jspf" %>
<%@include file="/resources/security/nfilter/jsp/open_nFilter.jsp" %>
<script>
var isMobile=true;
function loading() {
	addLoading(Math.round(Math.random() + 1));
}


function next() {
	loading();
	
	$('.warning').removeClass('warning');
	var result = check_step1_validation();
	
	if (!NiceAuthNumUtil.getConfirmNiceAuthNumCheck()) {
		removeLoading();
		return;
	}
	
	if(!result.validation) {
		// 실패.
		removeLoading();
		// radio 체크해제.
		result.index.forEach(function(value, idx) {
			var temp = $('.question-wrap').eq(value);
			temp.addClass('warning');
			temp.find('label').removeClass('r-on');
			temp.find('input').removeProp('checked');
			temp.find('input').val('');
		});
		
		// 메시지 팝업.
		var index = result.index[0];
		var message = '질문내용을 정확히 확인 후 체크해주세요.';
		deleteBlock();
		customAlert({title : '안내', message : message}, function() {
			location.href = '#con' + (index);
			return false;
		});
		
		return;
	}

	if(!setCustTermsFormData()){
		removeLoading(); 
		return;
	}
	
	init_form_data();
	if(!validate_form(mobileProductForm)) {
		removeLoading();
		return;
	}
	
	//대출상품(부동산담보대출) & 담보종류(아파트) 일 경우 대출상품(prod_cd) >> GL094
	//대출상품(부동산담보대출) & 담보종류(나머지) 일 경우 대출상품(prod_cd) >> GL093
	if($("#prod_cd option:selected").val() == 'GL093') {
		if($("input:radio[name=mrgg_tp_cd]:checked").val() == 'H003200001') {
			$("#prod_cd option:selected").val("GL094");
		}else{
			$("#prod_cd option:selected").val("GL094");
		}
	}
	
	validate_product(function() {
		removeLoading();
		loading();
		$('#encData').val(encodeURIComponent(nFilterEncrypted()));
		<%-- 대출신청정보 등록요청 --%>
		loan_request_form(function(res) {
			location.href = '${next}';
		}, on_error);
	}, function(){
		removeLoading();
	});
}


function check_step1_validation() {
	var result = {validation : true, index : []};
	
	// 1로 끝나는 항목(Y)
	$('.question-wrap').find('input[id$=1]').each(function(idx, b) {
		if(idx >= 0 && idx <=4) {
			if(!b.checked) {
				result.validation = false;
				result.index.push(idx);
			}
		}
	});
	// 2로 끝나는 항목(N)
	$('.question-wrap').find('input[id$=2]').each(function(idx, b) {
		if(idx >= 5 && idx <=6) {
			if(!b.checked) {
				result.validation = false;
				result.index.push(idx);
			}
		}
	});
	
	if($('#name').val() != '${sDsrUser.NAME }') {
		result.validation = false;
		result.index.push(7);
	}
	
	return result;
}


function complete_product_list_loading() {
	$('#prod_cd').change();
}

$(function() {
	$.datepicker.regional['ko'] = {
      closeText: '닫기',
      prevText: '이전',
      nextText: '다음',
      currentText: '오늘',
      monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
      monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
      dayNames: ['일','월','화','수','목','금','토'],
      dayNamesShort: ['일','월','화','수','목','금','토'],
      dayNamesMin: ['일','월','화','수','목','금','토'],
      weekHeader: 'Wk',
      dateFormat: 'yymmdd',
      firstDay: 0,
      isRTL: false,
      showMonthAfterYear: true,
      yearSuffix : '년'};
    $.datepicker.setDefaults($.datepicker.regional['ko']);
    $(".calendar").datepicker();
    complete_product_list_loading();
});
</script>
</head>
<%@ include file="../include/inc_body_start.jspf" %>
	<!-- s contentsWrap -->
	<div id="contentsWrap">
		<!-- s:contents -->
		<form id="frm1">
			<input type="hidden" name="CON_CD" id="CON_CD">
			<input type="hidden" name="CUST_TYPE" id="CUST_TYPE">
			<input type="hidden" name="CUST_AGE" id="CUST_AGE">
			<input type="hidden" name="LOAN_AIM" id="LOAN_AIM">
			<input type="hidden" name="LOAN_AIM_TEXT" id="LOAN_AIM_TEXT">
			<input type="hidden" name="INCOM_ANNUAL_RANGE" id="INCOM_ANNUAL_RANGE">
			<input type="hidden" name="INCOM_ANNUAL_TEXT" id="INCOM_ANNUAL_TEXT">
			<input type="hidden" name="WORTH_NET" id="WORTH_NET">
			<input type="hidden" name="DEPT_MT" id="DEPT_MT">
			<input type="hidden" name="CREDIT_SCORE" id="CREDIT_SCORE">
			<input type="hidden" name="LOAN_RM" id="LOAN_RM">
			<input type="hidden" name="LOAN_RM_TEXT" id="LOAN_RM_TEXT">
			<input type="hidden" name="LOAN_PR_EX" id="LOAN_PR_EX">
			<input type="hidden" name="LOAN_PR_UD" id="LOAN_PR_UD">
			<input type="hidden" name="COST_FIX" id="COST_FIX">
			<input type="hidden" name="ADE_REC" id="ADE_REC">
			<input type="hidden" name="ADE_REC_MT" id="ADE_REC_MT">
			<input type="hidden" name="REG_DT" id="REG_DT">
			<input type="hidden" name="TERM_AGREE_YN" id="TERM_AGREE_YN">
	        <input type="hidden" name="phone_no" id="phone_no" value="" />
	        <input type="hidden" name="prod_category_cd" id="prod_category_cd" value="" />
            <input type="hidden" id="prod_nm" name="prod_nm" />
	        <input type="hidden" name="encData" id="encData" value="" />
	        
	        <div class="sub-contents default-wrap">
	        	<div class="loan-wrap">
	        		<ol class="loan-step clear mb30">
	        			<li class="step02 on">개인정보 및 대출정보입력</li>
	        			<li class="step03">약관동의 및 본인인증</li>
	        			<li class="step04">대출신청 완료</li>
	        		</ol>
                    <div class="loan-infomation">
                        <h3 class="tit">대출정보 입력</h3>
						<div class="form-wrap mb20">
							<p class="input-tit font13 color-351B6F">대출상품</p>
							<div class="select-wrap">
								<select name="prod_cd" id="prod_cd" class="loan-product prod_cd_fc">
									<!-- <option value="GL999" selected></option> -->
									<c:forEach var="item" items="${productList }">
									  <c:if test="${item.NTREE_PROD_CODE ne 'GL094'}">
                                      	<option  value="${item.NTREE_PROD_CODE }">${item.NAME }</option>
                                     </c:if>
                                   </c:forEach>
								</select>
							</div>
						</div>
						<div class="form-wrap mb20">
							<p class="input-tit font13 color-351B6F">이름</p>
							<input type="text" class="cust_nm_fc" name="cust_nm" id="cust_nm" value="" placeholder="고객실명 입력" maxlength="20">
						</div>
						<div class="form-wrap  mb20 column-wrap">
							<p class="input-tit font13 color-351B6F">핸드폰번호</p>
							<div class="select-wrap mb5">
								<select class="telecom_fc" name="telecom" id="telecom">
									<option selected="selected" value="">통신사</option>
									<c:forEach var="item" items="${carrierCodeList }">
                                    <option value="${item.code }">${item.name }</option>
                                    </c:forEach>
								</select>
							</div>
							<div class="column3-hp">
								<div class="column">
									<div class="select-wrap">
										<select class="phone_no_fc" id="phone_no1" style="color: rgb(0,0,0);">
											<c:forEach var="item" items="${telCodeList }">
                                            <option value="${item.value }">${item.name }</option>
                                            </c:forEach>
										</select>
									</div>
								</div>
								<span class="fl-l hyphen">-</span>
								<div class="column">
									<input type="tel" class="ssn1_fc" id="phone_no2" placeholder="" title="핸드폰 두번째 자리" maxlength="4" tab="phone_no3">
								</div>
								<span class="fl-l hyphen">-</span>
								<div class="column">
									<input type="tel" class="ssn2_fc" id="phone_no3" placeholder="" title="핸드폰 세번째 자리" maxlength="4" tab="ssn1">
								</div>
							</div>
						</div>
						<div class="form-wrap  mb20 column-wrap">
							<div class="column3-hp">
								<!-- 휴대폰소지인증 -->
								<%@ include file="../include/inc_auth_nice_num.jspf" %>
							</div>
						</div>
						
						
						
                        <div class="form-wrap column-wrap">
                            <p class="input-tit font13 color-351B6F">주민등록번호</p>
                            <div class="column2-hp">
                            <div class="idn1 mb5 column">
                                <input type="tel" id="ssn1" name="ssn1" placeholder="" title="주민등록번호 앞번호" maxlength="6" tab="ssn2">
                            </div>
                            <span class="fl-l hyphen">-</span>
                            <div class="idn2 mb5 column">
                                <input type="password" id="ssn2" value="" placeholder="" title="주민등록번호 뒷번호" maxlength="7">
                            </div>
                            <p class="font12 color-626C74 clear">※ 당 저축은행은 신용정보의 이용 및 보호에 관한 법률 시행령 제37조의2에 의거하여 주민등록번호를 수집합니다.</p>
                            </div>
                        </div>
                        <hr class="mt30 mb30" />
                        <div class="article-con">
                        	<div class="form-wrap" id="div_mrgg_tp_cd">
						        <label for="mrgg_tp_cd" class="inp-tit req">담보종류</label>
						       <div class="inradio">
						        	<c:forEach var="item" items="${mrgg_tp_cd }" varStatus="status">
	                                       <label for="mrgg_tp_cd_${status.count}" class="radio"><input type="radio" name="mrgg_tp_cd" id="mrgg_tp_cd_${status.count}" value="${item.code }">${item.name }</label>
						    		</c:forEach>
						    	</div>
						    </div>
						    
						    <div class="form-wrap">
						    	<label for="loan_tp_cd" class="inp-tit req">대출구분</label>
						        <div class="select-wrap">
						            <select class="car_yn" name="loan_tp_cd" id="loan_tp_cd">
						                <option value="">대출구분을 선택하세요.</option>
						                 <c:forEach var="item" items="${loanTpList }">
                                           	<option  value="${item.code }">${item.name }</option>
                                       	</c:forEach>
						            </select>
						        </div>
						    </div>
						    
						    <div class="form-wrap">
						    	<label for="mod_tp_cd" class="inp-tit req">기기모델</label>
						        <div class="select-wrap">
						            <select class="car_yn" name="mod_tp_cd" id="mod_tp_cd">
						                <option value="">기기모델을 선택하세요.</option>
						                <c:forEach var="item" items="${modTpList }">
                                           	<option  value="${item.code }">${item.name }</option>
                                       	</c:forEach>
						            </select>
						        </div>
						    </div>
                        
                            <div class="form-wrap">
                                <p class="input-tit font13 color-351B6F">대출신청금액</p>
                                <input type="hidden" name="req_amt" id="req_amt" value="">
                                <input type="tel" class="req_amt_format" inputmode="numeric" 
                                	id="req_amt_format"
                                	placeholder="만원 단위로 입력하세요" 
                                	title="대출신청금액" value="">
                                <div id="req_amt_unit" class="unit-txt">만원</div>
                            </div>
                             <div class="form-wrap">
						        <label for="qnt" class="inp-tit req">수량</label>
						        <input type="text" name="qnt" class="incom_annual_format" id="qnt" value="">
						    </div>
						     <div class="form-wrap">
								<label for="comnt" class="inp-tit">비고</label>
								<textarea name="comnt" rows="5" cols="80" id="comnt" placeholder="내용을 입력해주세요"></textarea>
							</div>
                            <div class="form-wrap address-area mb30">
                            	<div class="form-wrap">
									<label for="address-code" class="inp-tit req">주소</label>
									<div class="zipcode">
										<input type="text" name="zip_code" value="" id="zip_code" placeholder="우편번호를 입력하세요" readonly="readonly"> <a href="#" class="btn-normal form" id="find_zip_code">우편번호 찾기</a>
									</div>
								</div>
								<div class="address-detail">
									<input type="text" name="addr" value="" id="address_detail" placeholder="주소를 입력하세요" title="주소" readonly="readonly">
									<input type="text" name="addr_detail" value="" id="address_detail1" placeholder="상세주소를 직접 입력하세요" title="주소 - 상세주소">
								</div>
							</div>
						     
							<hr class="mt30 mb30 hr_hidden" style="display: none;">
                        </div>
                        
                        
							<h3 class="tit">대출상담사 설명확인</h3>
							<div class="line-box">금융회사는 대출모집상담사를 통해 접수된 대출의 경우, “대출모집인 제도 모범규준 제 10조 제 1항 2호”에 따라 대출 실행 이전에 대출신청인에게 아래 각 사항을 확인하여야 합니다. 아래의 질문사항에 대하여 직접 사실대로 작성하여 주시기 바랍니다.</div>
							<hr class="mt30" id="con0">
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
										<span class="form-wrap d-inline-block mt15"><input type="text" id="name"  name="dsrName" placeholder="${sDsrUser.NAME }"></span>
									</p>
								</li>
							</ul>
							
							<h3 class="tit">적합성·적정성원칙 확인서</h3>
							<%@ include file="../loan/include/inc_terms2.jspf" %>
<!-- 							<div class="line-box">금융회사는 대출모집상담사를 통해 접수된 대출의 경우, “대출모집인 제도 모범규준 제 10조 제 1항 2호”에 따라 대출 실행 이전에 대출신청인에게 아래 각 사항을 확인하여야 합니다. 아래의 질문사항에 대하여 직접 사실대로 작성하여 주시기 바랍니다.</div> -->
							<div class="mt30"></div>
                        
                        
                        <div class="btn-wrap">
                        	<span><span onclick="next()" class="btn-normal pink">다음단계 진행</span></span>
                        	<span class="circle-big"><a href="<c:url value='${back }' />" class="btn-circle refresh big ir">취소</a></span>
                        </div>
                    </div>
                </div>
	        </div>
		</form>
		<!-- //e:contents -->
		<button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
	</div>
	<!-- //e: contentsWrap -->
	<!-- ********** Include ********** -->
	<%@ include file="../include/inc_body_end.jspf" %>
	<!-- ********** //Include ********** -->
	<!-- //e:wrap -->
</body>
</html>