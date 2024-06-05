<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="co.kr.yegaramsb.dsr.core.common.Constraints"%>
<%-- 페이징 동의목록 페이지 --%>
<c:set var="back" value="/${dsrId }" />
<%-- 페이징 인증페이지 --%>
<c:set var="next" value="/${dsrId }/loan/03_authorization" />
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
<%-- <%@ include file="../../include/loan/loan.jspf" %> --%>
<%@ include file="../../mobile/include/loan.jspf" %>
<%@include file="/resources/security/nfilter/jsp/open_nFilter.jsp" %>
<script>
var isMobile=true; 
var bizNoTarget = "";
var bizNoAuthYn = false;
var bizNoParam = "";
var mydataParam = {};
// 직업구분별 스크래핑 코드
var mydataScrapTypeItemMap = {
	'C002000001' : { name : '급여소득자', scrapCdList : ['C000970001', 'C000970002', 'C000970003'] },
	'C002000003' : { name : '개인사업자', scrapCdList : ['C000970001', 'C000970002', 'C000970004', 'C000970005', 'C000970008', 'C000970009', 'C000970012'] },
	'C002000004' : { name : '주부',     scrapCdList : ['C000970001', 'C000970002', 'C000970012'] },
	'C002000005' : { name : '프리랜서',  scrapCdList : ['C000970001', 'C000970002', 'C000970012','C000970004'] }, 
	'C002000007' : { name : '연금소득자', scrapCdList : ['C000970001', 'C000970002', 'C000970012'] },
	'C002000008' : { name : '법인사업자', scrapCdList : ['C000970001', 'C000970002', 'C000970004', 'C000970005', 'C000970008', 'C000970009', 'C000970012'] }
	// scrapCd C000970001:주민등록등초본, C000970002:자격득실확인서, C000970003:보험료납부확인서, C000970004:소득금액증명, C000970005:사업자등록증명
}

function loading() {
	addLoading(Math.round(Math.random() + 1));
}
//2021.09.28 상품설명서 상세약관 설정
$(function() {
	$('#ssn1').on('blur', function(){
		//만 31세 이하 체크
		if(calcAge($("#ssn1").val())<=31){
			$('#AGE_CHECK_YN').val("Y");
		}else{
			$('#AGE_CHECK_YN').val("N");
		}
	});
	
	$('#job_cd').on('change', changeMydataList);
	
	
});

function changeMydataList() {
	var jobType = $('#job_cd').val();
	if(jobType != ''){
		ajaxMydataList(jobType);
	}else{
		$('.mydata-box').hide();
	}
}

function next() {
// 	loading();
// 	if($("#job_cd").val()== "C002000003" ){
// 		bizNoParam = $('#bnum1').val() + $('#bnum2').val() + $('#bnum3').val();
// 		location.href = '${next}?retailYn=${retailYn}&jobCd='+$("#job_cd").val()+"&bizNo="+bizNoParam;
// 	}else{
// 		location.href = '${next}?retailYn=${retailYn}&jobCd='+$("#job_cd").val();	
// 	}
	
	
	$('.warning').removeClass('warning');
	var result = check_step1_validation();
	
	init_form_data();
	if(!validate_form(mobileProductForm)) {
		removeLoading();
		return;
	}
	
	if($('#retailYn').val() == 'N'){
		if(!validate_form(mobileCrdeitProductForm)) {
			removeLoading();
			return;
		}
	}
	
	//휴대폰 소지인증
	if (!NiceAuthNumUtil.getConfirmNiceAuthNumCheck()) {
		removeLoading();
		return;
	}
	
	//상담사 설명확인
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
		var message = '질문내용을 정확히 확인 후 체크해주세요.   ';
		deleteBlock();
		customAlert({title : '안내', message : message}, function() {
			location.href = '#con' + (index);
			return false;
		});
		
		return;
	} 
	
	//적합성
	if(!setCustTermsFormData()){
		removeLoading();
		return;
	} 
	
// 	init_form_data();
// 	if(!validate_form(mobileProductForm)) {
// 		removeLoading();
// 		return;
// 	}
	
	validate_product(function() {
		removeLoading();
		loading();
 		$('#encData').val(encodeURIComponent(nFilterEncrypted()));
//  		대출신청정보 등록요청
 		loan_request_form(function(res) {
 			if($("#job_cd").val()== "C002000003" ){
 				bizNoParam = $('#bnum1').val() + $('#bnum2').val() + $('#bnum3').val();
 				location.href = '${next}?retailYn=${retailYn}&jobCd='+$("#job_cd").val()+"&bizNo="+bizNoParam;
 			}else{
 				location.href = '${next}?retailYn=${retailYn}&jobCd='+$("#job_cd").val();	
 			}
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



//사업자번호 체크
function bizNoCheck(){
	var bizNo = $('#bnum1').val() + $('#bnum2').val() + $('#bnum3').val();
	
	if(bizNo.length != 10){
		customAlert({title: "알림", message: "사업자등록번호 10자리를 확인해주세요.", btn_txt1: "닫기"}, '', function () {
			return;
		});
		return;
	}
	
	var data = {
		"b_no": [bizNo]
	};
	AjaxFunc.ajaxAsyncJson('https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=vOANIJ2YeZ6HV4OLRsYxYPcKTZsJlm5D4zUvldGVEC/9D7RTSmPMubPtawLoJ24T84xufBlWEHvErxOHw6J6Jg==', JSON.stringify(data), function(res) {
		if("OK" == res.status_code && "01" == res.data[0].b_stt_cd){
			customAlert({title: "알림", message: '사업자등록번호 조회가 완료되었습니다.', btn_txt1: '확인'}, function () {
				bizNoChkY();
				return;
			});
		}else{
			customAlert({title: "알림", message: "사업자등록정보 또는 등록상태를 확인해주세요.", btn_txt1: "닫기"}, function () {
				return;
			});
		}
	}, function(res) {
		customAlert({title: "알림", message: "사업자등록정보 확인에 실패하였습니다.\n다시 시도해주세요.", btn_txt1: "닫기"}, function () {
			return;
		});
	});
}
function bizNoChkY(){
	$("#bnum1").prop('disabled', true);
	$("#bnum2").prop('disabled', true);
	$("#bnum3").prop('disabled', true);
// 	$('#btnBizNo').html('사업자등록번호 재조회');
	$('#jobsendBtn').attr('onclick', 'bizNoChkN();');
	bizNoAuthYn = true;
}
function bizNoChkN(){
	$("#bnum1").prop('disabled', false);
	$("#bnum2").prop('disabled', false);
	$("#bnum3").prop('disabled', false);
	$('#jobsendBtn').html('사업자등록번호 조회');
	$('#btnBizNo').attr('onclick', 'bizNoCheck();');
	bizNoAuthYn = false;
}

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
	        <input type="hidden" id="retailYn" value="${retailYn}">
	        <!-- 2021.09.28 대학생,청년층확인서 여부(만 31세 이하) -->
	        <input type="hidden" name="AGE_CHECK_YN" id="AGE_CHECK_YN" value="" />
	       
	        <div class="sub-contents default-wrap">
	        	<div class="loan-wrap">
	        		<ol class="loan-step clear mb30">
	        			<li class="step02 on">개인정보 및 대출정보입력</li>
	        			<li class="step03">약관동의 및 본인인증</li>
	        			<li class="step04">대출신청 완료</li>
	        		</ol>
                    <div class="loan-infomation">
                        <h3 class="tit">대출정보 입력</h3>
						<div class="form-wrap mb20" style="display:none;">
							<p class="input-tit font13 color-351B6F">대출상품</p>
							<div class="select-wrap">
								<select name="prod_cd" id="prod_cd" class="loan-product prod_cd_fc">
									<option value="GL999" selected></option>
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
                            <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F">연소득</p>
                                <input type="hidden" name="incom_annual" id="incom_annual" value="">
                                <input type="tel" class="incom_annual_format" inputmode="numeric" 
                                	id="incom_annual_format" name="incom_annual_format" 
                                	placeholder="만원 단위로 입력하세요" 
                                	title="연소득" value="">
                               	<div class="unit-txt">만원</div>
                            </div>
                            <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F">대출신청금액</p>
                                <input type="hidden" name="req_amt" id="req_amt" value="">
                                <input type="tel" class="req_amt_format" inputmode="numeric" 
                                	id="req_amt_format"
                                	placeholder="만원 단위로 입력하세요" 
                                	title="대출신청금액" value="">
                                <div id="req_amt_unit" class="unit-txt">만원</div>
                            </div>
                            
                            <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F">주택소유형태</p>
                                <div class="select-wrap">
                                    <select class="residence_own_type_cd_fc" id="residence_own_type_cd" name="residence_own_type_cd">
                                        <option selected="selected" value="">주택소유형태 구분을 선택하세요</option>
                                        <c:forEach var="item" items="${residenceOwnTypeCodeList }">
						                <option value="${item.code }">${item.name }</option>
						                </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F">고객구분</p>
                                <div class="column2-sel">
	                                <div class="select-wrap column mb5">
	                                    <select class="cust_cd_fc" id="cust_cd" name="cust_cd">
	                                        <option value="">고객구분을 선택하세요</option>
	                                        <c:forEach var="item" items="${custTypeCodeList }">
							                    <option value="${item.code }">${item.name }</option>
							                </c:forEach>
	                                    </select>
	                                </div>
	                            </div>
                            </div>
                            <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F">직업구분</p>
                                <div class="column2-sel">
	                                <div class="select-wrap column mb5">
	                                    <select class="job_cd_fc" id="job_cd" name="job_cd">
	                                        <option value="">직장구분을 선택하세요</option>
	                                        <c:forEach var="item" items="${jobCodeList }">
							                    <option value="${item.code }">${item.name }</option>
							                </c:forEach>
	                                    </select>
	                                </div>
	                            </div>
                            </div>
						    <div class="form-wrap bnum mb30">
                                <p class="input-tit font13 color-351B6F">사업자번호</p>
                                <div class="bnumInputArea">
	                                <div class="hp3 fl-l" style="width:20%;">
	                                    <input type="tel" class="number" id="bnum1" title="사업자번호 첫번째 자리" maxlength="3" tab="bnum1" numberOnly>
	                                </div>
	                                <span class="fl-l hyphen">-</span>
	                                <div class="hp3 fl-l" style="width:20%;">
	                                    <input type="tel" class="number" id="bnum2" title="사업자번호 두번째 자리" maxlength="2" tab="bnum2" numberOnly>
	                                </div>
	                                <span class="fl-l hyphen">-</span>
	                                <div class="hp4 fl-l" style="width:20%;">
	                                    <input type="tel" class="number" id="bnum3" title="사업자번호 세번째 자리" maxlength="5" back="bnum3" numberOnly>
	                                </div>
                                </div>
	                            <div class="">
	                            	<button type="button" class="btn-normal form btn-nice-auth-num" id="jobsendBtn" onclick="bizNoCheck();" style="margin-left: 15px ;padding : 14px 3px 10px ;">사업자번호요청</button>
								</div>
                            </div>
                            <div class="mydata-wrap mb5 mydata-box mt20" style = "background-color: white; padding: 30px; width: 80%; margin: auto;display:none;">
                        		<span style="font-weight:bold;font-size:20px;display: grid;justify-content: center;">공공마이데이터 조회 목록</span>
	                        	<ul class="list-bull" id="mydataScrapSelectList" style="padding: 18px;">
								</ul>
	                        </div>
	                        
                            <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F">직장명</p>
                                <input type="text" id="job_nm" name="job_nm" placeholder="직장명을 입력하세요" title="직장명" value="">
                            </div>                            
                            <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F" id="id_job_join_day">입사일</p>
                                <input type="text" name="job_join_day" id="job_join_day" class="calendar" placeholder="ex) 20101206" title="입사일" maxlength="8" value=""readonly="readonly">
                            </div>
							<div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F" id="id_job_day">재직기간</p>
                                <input type="tel" id="job_period" name="job_period" placeholder="입사일 기준 자동 계산" title="재직기간" readonly="readonly" value="" />
                            </div>
                            <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F">직장의료보험구분</p>
                                <div class="select-wrap">
                                    <select class="job_medical_insurance_cd_fc" id="job_medical_insurance_cd" name="job_medical_insurance_cd">
                                        <option selected="selected" value="">의료보험구분을 선택하세요</option>
                                        <c:forEach var="item" items="${jobInsuranceTypeCodeList }">
						                    <option value="${item.code }">${item.name }</option>
						                </c:forEach>
                                    </select>
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
							<%@ include file="../loan/include/inc_terms.jspf" %>
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