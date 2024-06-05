<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<%-- 페이징 완료페이지 --%>
<c:set var="complete" value="/${dsrId }/loan/01_loan_comp"/>
<c:set var="home" value="/${dsrId }" />
<c:set var="limitFail" value="/${dsrId }/loan/limit_fail" />
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/inc_header.jspf" %>
<%@ include file="../../include/loan/loan_nfilter.jsp" %>
<%@ include file="../../include/loan/loan.jspf" %>
<style type="text/css">
/******** table ********/
.table-wrap .table-style, .table-wrap .table-tit { margin-top:60px; }
.table-wrap .table-style:first-child, .table-wrap .table-tit:first-child { margin-top:0; }
.table-style { border-bottom:1px solid #ccc; }
.table-style tbody { background:#fff; }
.table-style thead th { font-size:16px; line-height:20px; }
.table-style th, .table-style td { padding:12px 15px; color:#626C74; text-align:left; vertical-align:middle; }
.table-style tbody tr:first-child th, .table-style tbody tr:first-child td { border-top:1px solid #495057; }
.table-style tbody th, .table-style tbody td, .table-style tfoot th, .table-style tfoot td { border-top:1px solid #ccc; font-size:14px; line-height:18px; /*vertical-align:top;*/ }
.table-style td a { color:#626C74; }
.table-style thead + tbody th { font-weight:normal; }
.table-style.wide thead th { padding:15px 30px; }
.table-style.wide tbody th, .table-style.wide tbody td { padding:20px 30px; }
.table-style.all-c th, .table-style.all-c td { text-align:center; vertical-align:middle }
.table-style.th-c th { text-align:center; vertical-align:middle; }
.table-style.th-l tbody th { text-align:left; vertical-align:middle; }
.table-style.th-vc tbody th { vertical-align:middle; }
.table-style.td-c td { text-align:center; }
.table-style.td-line td { border-left:1px solid #ccc; }
.table-style.td-r td { text-align:right; }
.tbl-txt { overflow:hidden; margin-top:5px; font-size:12px; line-height:16px; letter-spacing:-0.7px; text-align:left; }
.tbl-txt span { float:right; text-align:right; }
.table-style .nodata { padding:10px 0; text-align:center; }
.table-style.caption-tit caption, .table-tit { width:auto; height:auto; text-indent:0; position:inherit; left: inherit; margin-bottom:30px; font-size:20px; color:#333; line-height:26px; text-align:left;}
.layerpopup .pop-cts { text-align: center;}
.layerpopup .pop-cts .tit-txt { margin-top:40px; padding-bottom:10px; color:#333; font-size:20px; line-height:28px; letter-spacing:-1.8px; }

/******** list ********/
.list-tit + .list.type1 { padding-left:25px; }
.list.type1 li { position:relative; padding-left:10px; color:#495057; font-size:16px; line-height:26px; margin:3px 0px; }
.list.type1 li:before { position:absolute; left:0px; top:-1px; content:"•"; }
.list.type1 li > span { float:left; display:block; }
.list.type1 li .bar { position:relative; width:140px; display:block; float:left; }
.list.type1 li .bar:after { content:""; width:1px; height:10px; position:absolute; right:20px; top:7px; background-color:#B3BBC0; }
.define-list { margin-left:25px; }
.define-list > li { display:table; width:100%; margin-top:40px; }
.define-list > li:first-child { margin-top:0; }
.define-list .de-tit, .define-list .de-cts { position:relative; display:table-cell; vertical-align:top; }
.define-list .de-tit { width:20%; padding-left:15px; font-weight:bold; }
.define-list .de-tit:before { position:absolute; left:0; top:0; content:"•"; }
.define-list .de-stit { display:block; font-size: 15px; }
.define-list .de-cts { width:80%; padding-left:20px; }
.define-list .de-cts:before { position:absolute; left:0px; top:8px; width:1px; height:10px; background:#b3bbc0; content:""; }
.define-list .de-cts .table-wrap { margin-top:15px; }
.rice { position:relative; margin-top:5px; padding-left:15px; color:#626c74; font-size:12px; line-height:16px; letter-spacing:-0.7px; }
.rice:before { position:absolute; left:0px; top:0px; content:"※"; }
.rice + .rice { margin-top:0px; }
.star { position:relative; padding-left:15px; }
.star:before { position:absolute; left:0px; top:0px; content:"*"; }
.mark-kdic { margin-top:20px; }

.list.type2 > li { padding-left:10px; text-indent:-10px; }
.list.type2 li + li { margin-top:5px; }
.list.type2 li .rice { margin-left:12px; }
.list.type3 > li { padding-left:20px; text-indent:-20px; }
.list.type4 > li { padding-left:15px; text-indent:-15px; }

.list li > * { text-indent:initial; }

p.indent2 { padding-left:10px; text-indent:-10px; }
p.indent3 { padding-left:20px; text-indent:-20px; }
p.indent4 { padding-left:15px; text-indent:-15px; }

.sub-list { padding-left:10px; }
.sub-txt { padding-left:10px; text-indent:-10px !important; }

.list-bul2 { position:relative; top:-1px; font-size:12px; color:#ec008c; font-family:'돋움'; font-weight:bold; }


.step-wrap { margin-bottom:60px; text-align:center; }
.step-wrap li { display:inline-block; position:relative; text-align:left; }
.step-wrap li:before { display:block; content:""; clear:both; position:absolute; top:15px; left:-38px; width:12px; height:23px; background:url(../images/page/img_step_arrow.png) no-repeat 0 0; }
.step-wrap li:first-child { margin-left:0; }
.step-wrap li:first-child:before { display:none; }
.step-wrap li span { display:block; opacity:.5; height:52px; padding-left:60px; font-size:30px; }
.step-wrap li strong { display:block; font-size:12px; }
.step-wrap li.active span { opacity:1; }
.step-wrap li.step01 span { background:url('/resources/normal/images/page/img_ratecut_step1.png') no-repeat 0 0; }
.step-wrap li.step02 span { background:url('/resources/normal/images/page/img_ratecut_step2.png') no-repeat 0 0; }
.step-wrap li.step03 span { background:url('/resources/normal/images/page/img_ratecut_step3.png') no-repeat 0 0; }
#limit_list table td{border:1px solid #b3bbc0;padding:7px 10px; border-left:0px; border-right:0px;}
.chk_td {text-align:center;vertical-align:middle;}
#limit_list table th{color:#333333;font-weight:bold; border:1px solid #b3bbc0;padding:7px 10px; border-left:0px; border-right:0px;}

.agree-wrap .subcheck-area1 { margin-top:17px; margin-left:25px; border-top:1px solid #ccc; }
.agree-wrap .subcheck-area1 .check-tit { padding-top:10px; font-size:14px; font-weight:bold; color:#495057; }

.agree-wrap .subcheck-area1 label { margin-right:20px; margin-bottom:5px;}
.agree-wrap .subcheck-area1 .sub-check { margin-left:25px; }
.agree-wrap .subcheck-area1 .sub-check .txt { display:block; margin-bottom:10px; font-size:14px; }

/* 대출신청 사전문진 */
.question-wrap .question-list { background:#fff; margin:20px 0; padding:0 30px; }
.question-wrap .question-list li { padding:30px 0 40px; border-top:2px solid #e6e6e6; }
.question-wrap .question-list li:first-child { border-top:none; }
.question-wrap .question-list span { display:inline-block; vertical-align:top; }
.question-wrap .question-list .num { width:46px; height:46px; border:1px solid #575e64; border-radius:50%; text-align:center; line-height:44px; z}
.question-wrap .question-list .cont { width:475px; margin-left:30px; }
.question-wrap .question-list .radio-area { margin:15px 0 0 60px; }
.question-wrap .question-list .warning .num { border:1px solid #DC0082; color:#DC0082; }
.question-wrap .question-list .warning .cont { color:#DC0082; }
.question-wrap .sign-area { margin-top:40px; text-align:center; }
.question-wrap .sign-area .sign-input { margin-top:25px; }
.question-wrap .sign-area .sign-input .date { margin-right:50px; }
.question-wrap .sign-area .sign-input input[type='text'] { width:260px; margin-left:15px; }

.manual-layer { padding: 50px 10px 0 10px; }
.agreementall-layer { padding: 0 10px 0 10px; }
.manual-layer .btn-menu-close {     top: -30px;right: 10px;width:24px;height:25px;background-size: contain; }
.agreementall-layer .btn-menu-close { top: 31px; right: 21px;width:24px;height:25px;background-size: contain; }
.agreementall-layer .ctrl-box button { width: 14px;height: 25px;right: -31px;background-size: contain; }
.agreementall-layer > .pop-wrap { padding: 40px 0px 0; }
.agreementall-layer > .pop-wrap .all-agree { margin: 0px 0 0 30px; font-size: 26px; color: #333; line-height: 34px; letter-spacing: -2px; }

@media(min-height:850px){
	.layerpopup  .iScrollVerticalScrollbar{ display: none; }
}
</style>
<script>
var isMobile=false; 
var reqFlag = false;
var streamdocsAdd = "";
var isImportantCheck = false;
var isProdCheck = false;
var checkArg = '';
var bizNoTarget = "";
var bizNoAuthYn = false;

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
	
//2021.09.28 상품설명서 상세약관 설정
$(function() {
	$('#prod_cd').val("TERMSALL");
	streamdocsAdd =  '<spring:eval expression="@prop.getProperty('streamDocs.url')" />';
	$('#ssn1').on('blur', function(){
		//만 31세 이하 체크
		if(calcAge($("#ssn1").val())<=31){
			$('#prod_terms_agree5_1').prop('checked', true);
			$('#prod_terms_agree5_1').parent().addClass('r-on');
			$('#prod_terms_agree5_2').prop('checked', false);
			$('#prod_terms_agree5_2').parent().removeClass('r-on');
		}else{
			$('#prod_terms_agree5_1').prop('checked', false);
			$('#prod_terms_agree5_1').parent().removeClass('r-on');
			$('#prod_terms_agree5_2').prop('checked', true);
			$('#prod_terms_agree5_2').parent().addClass('r-on');
		}
	});
	
	
	$('#job_cd').on('selectmenuchange', changeMydataList);
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
    	// 사용자 정보 및 약관정보 처리 시작.
		loading();
		
		
//입력항목 validation
   	if(!validate_form(commonProductForm)) {
   		removeLoading();
   		return;
   	}

//휴대폰 인증 validation
	if (!NiceAuthNumUtil.getConfirmNiceAuthNumCheck()) {
		removeLoading();
		return;
	}

//연소득부터 고객구분 체크
	if(!validate_form(crdeitProductForm)) {
		removeLoading();
		return;
	}
	
//사업자 번호	
	var JOB_CD = $('#job_cd').val(); 
	if( (JOB_CD === 'C002000003' || JOB_CD === 'C002000008') || "Y" == bizNoTarget){
		if ($('#bnum1').val() == '') {
			customAlert({title: "알림", message: "사업자 등록번호를 입력해 주세요.", btn_txt1: "닫기"}, function () {
				focus_to('#bnum1');
				removeLoading();
				return;
			});
			return;
		}
		
		if ($('#bnum2').val() == '') {
			customAlert({title: "알림", message: "사업자 등록번호를 입력해 주세요.", btn_txt1: "닫기"}, function () {
				focus_to('#bnum2');
				removeLoading();
				return;
			});
			return;
		}
		if ($('#bnum3').val() == '') {
			customAlert({title: "알림", message: "사업자 등록번호를 입력해 주세요.", btn_txt1: "닫기"}, function () {
				focus_to('#bnum3');
				removeLoading();
				return;
			});
			return;
		}
		if (!bizNoAuthYn) {
			customAlert({title: "알림", message: "사업자등록번호 조회 버튼으로 사업자번호를 조회해 주세요.", btn_txt1: "닫기"}, function () {
				focus_to('#btnBizNo');
				removeLoading();
				return;
			});
			return;
		}
		
	}


//상담사 설명확인 validation
	$('.warning').removeClass('warning');
	var result = check_step1_validation();

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
	

//적합성 확인
	if(!setCustTermsFormData()){
		removeLoading();
		return;
	}
	//edd 확인
	if(!setIndvTrnCnfrFormData()){
		removeLoading();
		return;
	}    	
	//edd value 세팅
	setEddValue();
			
	
//금융상품 중요사항	
	if(!impotantValidation()){
		customAlert({title : "알림" , message : "금융상품 중요사항 안내 항목을 체크해주세요." }, function() {
			removeLoading();
			$( "#importantdetail" ).focus();
		});
		return;
	}

//		2021.09.14 가계대출상품설명서 약관 체크 사용안함
//		if(!checkReqTerms()){
//			removeLoading();
//			return;
//		}
	
//가계대출상품설명서 약관 체크
	if(!$("input:checkbox[id='productdetail']").is(":checked")){
		customAlert({title : '안내', message : "가계대출상품설명서 약관에 동의해주세요"}, function() {
			removeLoading();
			$("input:checkbox[id='productdetail']").focus();
			});	
		return ;
	}
	
	if(!validate_terms()) {
		return;
	}
		
//		 마이데이터 약관 체크 
	if(!$("input:checkbox[id='agree-check44']").is(":checked")){
		customAlert({title : '안내', message : "공공 마이데이터 개인(신용)정보 수집·이용·제공 동의서 약관에 동의해주세요"}, function() {
			removeLoading();
			$("input:checkbox[id='agree-check44']").focus();
			});	
		return ;
	}
	if(!$("input:checkbox[id='agree-check45']").is(":checked")){
		customAlert({title : '안내', message : "본인 행정정보 제3자 제공 요구서 약관에 동의해주세요"}, function() {
			removeLoading();
			$("input:checkbox[id='agree-check45']").focus();
			});	
		return;
	}		
	if(!$("input:checkbox[id='agree-check47']").is(":checked")){
		customAlert({title : '안내', message : "본인정보 제3자 제공 요구서 약관에 동의해주세요"}, function() {
			removeLoading();
			$("input:checkbox[id='agree-check47']").focus();
			});	
		return;
	}		
		
//2022.03.31 파라미터 설정
	valueSetting();
	init_form_data();
   	
	var prodCd = $('#prod_cd').val();
	if(prodCd == ''){
		$('#prod_cd').val("TERMSALL");
	}
		
	validate_product(function(){
		removeLoading();
		loading();
		if(!validate_topTerms()){
			return;
		}
		if(!validate_terms()) {
			return;
		}
		
		// 대출신청. 
		if($('#prod_cd').val() == '${employee_cd_1}') {
			$('#hetsal_option').val('${ntree_prod2}');
		}else if(this.value == '${employee_cd_2}'){
			// 자영업자.
			$('#hetsal_option').val('${ntree_prod1}');
		}
			
		loan_request_form(function() {
// 				end 대출신청정보 등록요청
			loan_request_terms(function() {
					// 사용자 정보 및 약관정보 처리 종료.
				removeLoading();
				openPopup('authLayer');
			}, on_error);
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
	
	// 상품 로딩 후 콜백.
function complete_product_list_loading() {
	// 상품이 있을경우 설정.
	var hetsal_option = ${userInfo.PROD_CD eq ntree_prod1 or userInfo.PROD_CD eq ntree_prod2};
	var has_user_info = ${userInfo ne null};
	if(!has_user_info) {
		// 약관목록 숨김
		forms_by_product_code();
	}else {
		if(hetsal_option) {
			$('#hetsal_option').prop('selected', true);
		}
		$('#prod_cd').val('${userInfo.PROD_CD}');
		$('#prod_cd').change();
	}
	// 재직기간 0으로 표시되는 항목 수정.
  		$('#job_join_day').trigger('keyup');
  		selectWidth();
}
	
function setLimitList(res){
// 		$("#INSP_NO").val(res.data.INSP_NO);
								
	$("#loan_list").empty();
	var html ='<table>';
	html += '<tr>';
	html += '<th colspan="2" class="ta-c">상품구분</th><th class="ta-c">한도</th><th class="ta-c">금리</th><th class="ta-c">선택</th>';
	html += '</tr>';
	var tempList = res.data.LOAN_LIMIT_INFO;
	var creditList = '';
	var pubList ='';
	var creditCnt =0;
	var pubCnt=0;
	
	for(var i=0; i<tempList.length;i++){
		if(tempList[i].PROD_TYPE=='Y'){
			creditCnt++;
		}else{
			pubCnt++;
		}
	}
	for(var i=0; i<tempList.length;i++){
		if(tempList[i].PROD_TYPE=='Y'){
			if(creditList==""){
				creditList +='<tr><td rowspan="'+creditCnt+'" style="width:140px">신용대출</td><td>'+tempList[i].PROD_NM2+'</td><td class="ta-c">'+UtilFunc.gridFormatterThousandNumber((parseInt(tempList[i].APPR_AMT)/10000).toString())+' 만원</td><td class="ta-c">'+tempList[i].APPR_RT+'%</td><td class="chk_td"><label for="credit_check'+i+'" class="check"><input type="checkbox" name="credit_check" id="credit_check'+i+'" value="'+tempList[i].PROD_CD+'"></label></td></tr>';	
			}else{
				creditList +='<tr><td>'+tempList[i].PROD_NM2+'</td><td class="ta-c">'+UtilFunc.gridFormatterThousandNumber((parseInt(tempList[i].APPR_AMT)/10000).toString())+' 만원</td><td class="ta-c">'+tempList[i].APPR_RT+'%</td><td class="chk_td"><label for="credit_check'+i+'" class="check"><input type="checkbox" name="credit_check" id="credit_check'+i+'" value="'+tempList[i].PROD_CD+'"></label></td></tr>';
			}
		}else{
			if(pubList==""){
				pubList +='<tr><td rowspan="'+pubCnt+'" style="width:140px">정책자금</td><td>'+tempList[i].PROD_NM2+'</td><td class="ta-c">'+UtilFunc.gridFormatterThousandNumber((parseInt(tempList[i].APPR_AMT)/10000).toString())+' 만원</td><td class="ta-c" style="text-align:center" >'+tempList[i].APPR_RT+'%</td><td class="chk_td"><label for="pub_check'+i+'" class="check"><input type="checkbox" name="pub_check" id="pub_check'+i+'" value="'+tempList[i].PROD_CD+'"></label></td></tr>';	
			}else{
				pubList +='<tr><td>'+tempList[i].PROD_NM2+'</td><td class="ta-c">'+UtilFunc.gridFormatterThousandNumber((parseInt(tempList[i].APPR_AMT)/10000).toString())+' 만원</td><td class="ta-c">'+tempList[i].APPR_RT+'%</td><td class="chk_td"><label for="pub_check'+i+'" class="check"><input type="checkbox" name="pub_check" id="pub_check'+i+'" value="'+tempList[i].PROD_CD+'"></label></td></tr>';
			}
		}
	}
		
	html += creditList+pubList;
	html += '</table>';
	$("#loan_list").html(html);
	$("#loan_input").hide();
	$("#limit_list").show();
		
// 		openPopup('limitLayer');
}
	
function openPopupLimit(id) {
    var _target = $('#' + id);
// 	    _target.fadeIn(300);
    layerFunc(_target);
    _target.focus();
}
function closePopupLimit(id) {
    deleteBlock();
    $('#' + id).scrollTop(0);
    deleteBlock();
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
       prod_change();
      // termsRadioChangeEvent()
});

	 //레이어팝업 라디오박스
function termsRadioChangeEvent(na,lab){
 var radioNm ;
 var radioId_1 ;
 var radioId_2 ;
 var chkVal ;

	var codeI= na;
	
	if(na == "T000800018"){//20210726 필수약관 신규 추가
		$("#dsrCorpNm").text('${sDsrUser.CORP_NM }');
    	$("#dsrUserNm").text('${sDsrUser.NAME }');
	}
	
	if(lab != null || lab != undefined){
		$("#"+radioId_1+"").parent().addClass("radio");
		$("#"+radioId_2+"").parent().addClass("radio");
		$("#"+radioId_1+"").addClass("r-on");
		$("#"+radioId_1+"").prop("checked",true);
	}else{
		$("#"+radioId_1+"").parent().addClass("radio");
		$("#"+radioId_2+"").parent().addClass("radio");
		$("#"+radioId_1+"").parent().addClass("r-on");
	}
	
	if(codeI != undefined && codeI !=''){
		radioNm = codeI+"_1_1";
		radioId_1 = codeI+"_2_1";
		radioId_2 = codeI+"_2_2";
		
		if(lab != null || lab != undefined){
			$("#"+radioId_1+"").parent().addClass("radio");
			$("#"+radioId_2+"").parent().addClass("radio");
			$("#"+radioId_1+"").addClass("r-on");
			$("#"+radioId_1+"").prop("checked",true);
		}else{
			$("#"+radioId_1+"").parent().addClass("radio");
			$("#"+radioId_2+"").parent().addClass("radio");
			$("#"+radioId_1+"").parent().addClass("r-on");
		}

		$("input:radio[name='"+radioNm+"']").on("click", function(){
			
			if($("input:radio[name='"+radioNm+"']").is(':checked')){
				
				if($("#"+radioId_1+"").is(':checked')){
					
					$("#"+radioId_2+"").parent().removeClass("r-on");
					$("#"+radioId_1+"").parent().addClass("r-on");
					$("#"+radioId_2+"").prop("checked",false);
					$("#"+radioId_1+"").prop("checked",true);
				}else{
					
					$("#"+radioId_1+"").parent().removeClass("r-on");
					$("#"+radioId_2+"").parent().addClass("r-on");
					$("#"+radioId_1+"").prop("checked",false);
					$("#"+radioId_2+"").prop("checked",true);
					$("."+codeI+"_2"+"").css("display","block");
					$("."+codeI+"_1"+"").css("display","none");
				}
				$(".layerpopup").find(".tooltip-close").click();
				chkVal = $("input:radio[name='"+radioNm+"']:checked").val();
				if(codeI == 'T000800001'){
					$("#CRDT_AGR_DTL_YN").val(chkVal);
					
				}else if(codeI == 'T000800002'){
					$("#PROD_AGR_DTL_YN").val(chkVal);
				}else if(codeI == 'T000800003'){
					$("#SRVC_AGR_DTL_YN").val(chkVal);
				}else if(codeI == 'T000800015'){
					$("#THIRD_AGR_DTL_YN").val(chkVal);
				}
				$("#"+codeI+"").find(".tiny").click();
			}
		});
		chkVal = $("input:radio[name='"+radioNm+"']:checked").val();
		if(codeI == 'T000800001'){
			$("#CRDT_AGR_DTL_YN").val(chkVal);
		}else if(codeI == 'T000800002'){
			$("#PROD_AGR_DTL_YN").val(chkVal);
		}else if(codeI == 'T000800003'){
			$("#SRVC_AGR_DTL_YN").val(chkVal);
		}else if(codeI == 'T000800015'){
			$("#THIRD_AGR_DTL_YN").val(chkVal);
		}else if(codeI == 'T001700001'){
				$("#MYDT_CRDT_AGR_DTL_YN").val(chkVal);
		}else if(codeI == 'T001700002'){
			$("#MYDT_SRVC_AGR_DTL_YN").val(chkVal);
		}
	
	}
 }
	 
	 
//2022-03-31 체크박스 value 설정
function termsCheckBoxChangeEvent(na){
	var chkVal ;
	var codeI= na;
	if(codeI != undefined && codeI !=''){
		chkVal = $("#" + codeI).prop('checked');
		if(codeI == 'agree-check14'){	//(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(맟춤형 상품 제공)
			if(chkVal){
				$("#PRODUCT_SERVICE_PROVIDE_YN").val('Y');
			}else{
				$("#PRODUCT_SERVICE_PROVIDE_YN").val('N');
			}
		}
	}
}

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
			customAlert({title: "알림", message: "사업자등록정보 또는 등록상태를 확인해주세요.", btn_txt1: "닫기"},  function () {
				return;
			});
		}
	}, function(res) {
		customAlert({title: "알림", message: "사업자등록정보 확인에 실패하였습니다.\n다시 시도해주세요.", btn_txt1: "닫기"},  function () {
			return;
		});
	});
}

function bizNoChkY(){
	$("#bnum1").prop('disabled', true);
	$("#bnum2").prop('disabled', true);
	$("#bnum3").prop('disabled', true);
// 	$('#jobsendBtn').html('재조회');
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

function agrchkk(){ 		
        if (!$("#agree-check46_1").is(':checked')) {
        	$('#agree-check46').prop('checked', false);
      		$('#agree-check46').parent().removeClass("c-on");
      		$('.add_class6').hide();
        }
}

$(function(){
	makeIndvTrnPrpsCdSelectBox();
});
	
function setIndvTrnCnfrFormData(){
		if(typeof($("input:radio[name='indv_trn_prps_radio']:checked").val()) == "undefined") {
			customAlert({title : "알림" , message : "개인거래목적을 선택해주세요." }, function() {
				$('#indv_trn_prps_radio_1').focus();
				return false;
			});
			return false;
		} else {
			if ($("input:radio[name='indv_trn_prps_radio']:checked").val() == 3120
					&& $('input:checkbox[id="INDV_TRN_PRPS_APV_ONE_CNTN"]').is(":checked") == false
					&& $('input:checkbox[id="INDV_TRN_PRPS_APV_TWO_CNTN"]').is(":checked") == false
					&& $('input:checkbox[id="INDV_TRN_PRPS_APV_THR_CNTN"]').is(":checked") == false)
			{
				customAlert({title : "알림" , message : "결제 하위 항목을 최소 1개 이상 선택해주세요." }, function() {
					$('#indv_trn_prps_radio_1').focus();
					return false;
				});
				return false;
			}
		}
		
		if(typeof($("input:radio[name='indv_trn_cpt_radio']:checked").val()) == "undefined") {
			customAlert({title : "알림" , message : "거래자금의 원천 및 출처를 선택해주세요." }, function() {
				$('#indv_trn_cpt_radio_1').focus();
				return false;
			});
			return false;
		}
		return true;
}

function makeIndvTrnPrpsCdSelectBox() {		
	$("input:radio[name='indv_trn_prps_radio']").unbind("change").bind("change",function(){
		if($("input:radio[name='indv_trn_prps_radio']:checked").val() == "3120"){
			$('.apv-check').show();		
		}else{
			$('input:checkbox[id="INDV_TRN_PRPS_APV_ONE_CNTN"]').attr('checked', false).parent().removeClass("checked");
			$('input:checkbox[id="INDV_TRN_PRPS_APV_TWO_CNTN"]').attr('checked', false).parent().removeClass("checked");
			$('input:checkbox[id="INDV_TRN_PRPS_APV_THR_CNTN"]').attr('checked', false).parent().removeClass("checked");
			$('.apv-check').hide();
		}
	});
}

function setEddValue() {
	$("#INDV_NEW_TRN_PRPS_DVCD").val($("input:radio[name='indv_trn_prps_radio']:checked").val());
	$("#INDV_TRN_CPT_DVCD").val($("input:radio[name='indv_trn_cpt_radio']:checked").val());
	$("#INDV_NEW_TRN_PRPS_APV_ONE_CNTN").val($('input:checkbox[id="INDV_TRN_PRPS_APV_ONE_CNTN"]').is(":checked") ? "Y" : "N");
	$("#INDV_NEW_TRN_PRPS_APV_TWO_CNTN").val($('input:checkbox[id="INDV_TRN_PRPS_APV_TWO_CNTN"]').is(":checked") ? "Y" : "N");
	$("#INDV_NEW_TRN_PRPS_APV_THR_CNTN").val($('input:checkbox[id="INDV_TRN_PRPS_APV_THR_CNTN"]').is(":checked") ? "Y" : "N");
}
</script>
</head>
<%@ include file="../include/inc_body_start.jspf" %>
        <!-- s contentsWrap -->
        <div id="contentsWrap">
            <!-- s:subVisualWrap -->
            <div id="subVisualWrap" class="sub3-1">
                <div class="breadcrumb">
                    <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
                    <a href="#" class="depth1 loading" ></a>
                    <a href="#" class="depth2 loading" ></a>
                </div>
                <div class="tit-wrap ta-c">
                    <h2 class="font50 mb10">대출신청</h2>
                    <p class="desc">예가람저축은행의 대출신청 프로세스입니다.</p>
                </div>
            </div>
            <!-- //e:subVisualWrap -->
            <!-- s:contents -->
   <input type="hidden" id="jsdsrCorpNm" value="${sDsrUser.CORP_NM }">
   <input type="hidden" id="jsDsrUserNm" value="${sDsrUser.NAME }">         
            <%-- 인증수단 파라미터 --%>
            <div class="contents default-wrap">
                <div class="loan-wrap">
                    <div class="content1" id="loan_input">
                        <form id="frm1" name="frm1">
			            <input type="hidden" name="phone_no" id="phone_no" value="" />
			            <input type="hidden" name="prod_category_cd" id="prod_category_cd" value="" />
			            <input type="hidden" id="prod_nm" name="prod_nm" value="" />
			            <input type="hidden" name="encData" id="encData" />
			            <input type="hidden" name="prod_cd" id="prod_cd" value=""/>
			            
			            
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
			            <input type="hidden" name="retailYn" id="retailYn" value="N">
			            
                        <div class="step-wrap mb60">
                            <ul>
                            	<li class="step02 active"><span>01<strong>신청정보 입력</strong></span></li>
                        		<li class="step02"><span>02<strong>상품선택</strong></span></li>
                        		<li class="step03"><span>03<strong>대출신청 완료</strong></span></li>
                            </ul>
                        </div>
                        <h3 class="tit">대출신청 정보입력</h3>
                        <div class="prod_cd_fc"></div>
                       	<div class="telecom_fc"></div>
                       	<div class="phone_no_fc"></div>
                       	
                       	<div class="grid2 mb30">
                            <div class="form-wrap">
                                <p class="input-tit font13 color-351B6F">이름</p>
                                <input type="text" name="cust_nm" value="${userInfo.CUST_NM }" id="cust_nm" placeholder="고객실명 입력" maxlength="20" class="ko-txt">
                            </div>
                            <div class="form-wrap">
                                <p class="input-tit font13 color-351B6F">주민등록번호</p>
                                <div class="idn1 fl-l mb5">
                                    <input type="text" id="ssn1" name="ssn1" value="${userInfo.SSN1 }" placeholder="" title="주민등록번호 앞번호" maxlength="6" tab="ssn2">
                                </div>
                                <span class="fl-l hyphen">-</span>
                                <div class="idn2 fl-l mb5">
                                    <input type="password" id="ssn2" name="ssn2" value=""
                                    	<c:if test='${userInfo ne null }' >placeholder="*******"</c:if> title="주민등록번호 뒷번호" maxlength="7" <c:if test="${nfilter ne true }"> e2e_type="1"</c:if> >
                                </div>
                                <p class="font12 color-626C74 clear">※ 당 저축은행은 신용정보의 이용 및 보호에 관한 법률 시행령<br>제37조의2에 의거하여 주민등록번호를 수집합니다.</p>
                            </div>
                        </div>
                        <div class="grid2 mb30">
                            <!-- <div class="form-wrap" style="display:none;">
                                <p class="input-tit font13 color-351B6F">대출상품</p>
                                <div class="select-wrap">
                                    <select name="prod_cd" id="prod_cd" class="loan-product">
                                        <option value="GL999" selected></option>
                                    </select>
                                </div>
                            </div> -->
                            <div class="form-wrap">
                                <p class="input-tit font13 color-351B6F">핸드폰번호</p>
                                <div class="hp1 fl-l mr10">
                                    <div class="select-wrap">
                                        <select name="telecom" id="telecom">
                                            <option value="">통신사</option>
                                            <c:forEach var="item" items="${carrierCodeList }">
                                            <option <c:if test="${userInfo.TELECOM eq item.code }">selected="selected"</c:if> value="${item.code }">${item.name }</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="hp2 fl-l">
                                    <div class="select-wrap">
                                        <select id="phone_no1">
                                            <c:forEach var="item" items="${telCodeList }">
                                            <option <c:if test="${userInfo.PHONE_NO1 eq item.value }">selected="selected"</c:if> value="${item.value }">${item.name }</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <span class="fl-l hyphen">-</span>
                                <div class="hp3 fl-l">
                                    <input type="text" class="number" value="${userInfo.PHONE_NO2 }" id="phone_no2" title="핸드폰 두번째 자리" maxlength="4" tab="phone_no3">
                                </div>
                                <span class="fl-l hyphen">-</span>
                                <div class="hp4 fl-l">
                                    <input type="text" class="number" value="${userInfo.PHONE_NO3 }" id="phone_no3" title="핸드폰 세번째 자리" maxlength="4" back="phone_no2">
                                </div>
                            </div>
                            <!-- 휴대폰소지인증 -->
							<%@ include file="../include/inc_auth_nice_num.jspf" %>
                        </div>
                        <div class="cust_nm_fc"></div>
                        <div class="ssn_fc"></div>
                        <div class="ssn1_fc"></div>
                        <div class="ssn2_fc"></div>
                        
                        <hr class="mb40">
                        <div class="incom_cd_fc"></div>
                        <div class="employee_cd_fc"></div>
                       	<div class="residence_own_type_cd_fc"></div>
                        <div class="residence_own_cd_fc"></div>
                        <div class="job_medical_insurance_cd_fc"></div>
                        <div class="job_cd_fc"></div>
                        <div class="job_cd2_fc"></div>
                        <div class="residence_cd_fc"></div>
                        <div class="car_own_cd_fc"></div>
                        <div class="mrgg_tp_cd_fc"></div>
                        
                        <div class="article-con">
                            <div class="grid2">
							    <div class="form-wrap">
							        <p class="input-tit font13 color-351B6F">연소득</p>
							        <input type="hidden" name="incom_annual" id="incom_annual" value="">
							        <input type="text" class="incom_annual_format" id="incom_annual_format" value="" placeholder="만원 단위로 입력하세요" title="연소득">
							        <div class="unit-txt">만원</div>
							        <!--단위 텍스트가 있을때-->
							    </div>
							    <div class="form-wrap">
							        <p class="input-tit font13 color-351B6F">주택소유형태</p>
							        <div class="select-wrap">
							            <select name="residence_own_type_cd" id="residence_own_type_cd">
							                <option selected="selected" value="">주택소유형태 구분을 선택하세요</option>
							                <c:forEach var="item" items="${residenceOwnTypeCodeList }">
							                <option value="${item.code }">${item.name }</option>
							                </c:forEach>
							            </select>
							        </div>
							    </div>
							    
							</div>
							
							<div class="grid1">
							    <div class="form-wrap" id="div_mrgg_tp_cd">
							        <p class="input-tit font13 color-351B6F">담보종류</p>
							        <div class="inradio">
							        	<c:forEach var="item" items="${mrgg_tp_cd }" varStatus="status">
	                                        <label for="mrgg_tp_cd_${status.count}" class="radio"><input type="radio" name="mrgg_tp_cd" id="mrgg_tp_cd_${status.count}" value="${item.code }">${item.name }</label>
							    		</c:forEach>
							    	</div>
							    </div>
							</div>
							
							<div class="grid2">
							    <div class="form-wrap" style="display: none;">
							        <p class="input-tit font13 color-351B6F">대출신청금액</p>
							        <input type="hidden" name="req_amt" id="req_amt" value="">
							        <input type="text" class="req_amt_format" id="req_amt_format" value="" placeholder="만원 단위로 입력하세요" title="대출신청금액">
							        <div id="req_amt_unit" class="unit-txt">만원</div>
							    </div>
							    <div class="form-wrap" style="display: none;">
							        <p class="input-tit font13 color-351B6F">직장의료보험구분</p>
							        <div class="select-wrap" >
							            <select name="job_medical_insurance_cd" id="job_medical_insurance_cd">
							                <option selected="selected" value="">의료보험구분을 선택하세요</option>
							                <c:forEach var="item" items="${jobInsuranceTypeCodeList }">
							                    <option value="${item.code }">${item.name }</option>
							                </c:forEach>
							            </select>
							        </div>
							    </div>
							</div>
							
							<div class="grid2">
							    <div class="form-wrap">
							    	<p class="input-tit font13 color-351B6F">직업구분</p>
							        <div class="select-wrap">
							            <select class="job_type0" name="job_cd" id="job_cd">
							                <option selected="selected" value="">선택</option>
							                <c:forEach var="item" items="${jobCodeList }">
							                    <option value="${item.code }">${item.name }</option>
							                </c:forEach>
							            </select>
							        </div>
							    </div>
							    <div class="form-wrap">
							        <p class="input-tit font13 color-351B6F">직장명</p>
							        <input type="text" name="job_nm" id="job_nm" placeholder="직장명을 입력하세요" title="직장명" value="">
							    </div>
							</div>
							<div class="grid2">
							    <div class="form-wrap bnum mb30">
	                                <p class="input-tit font13 color-351B6F">사업자번호</p>
	                                <div class="hp3 fl-l">
	                                    <input type="tel" class="number" id="bnum1" title="사업자번호 첫번째 자리" maxlength="3" tab="bnum1" numberOnly>
	                                </div>
	                                <span class="fl-l hyphen">-</span>
	                                <div class="hp3 fl-l">
	                                    <input type="tel" class="number" id="bnum2" title="사업자번호 두번째 자리" maxlength="2" tab="bnum2" numberOnly>
	                                </div>
	                                <span class="fl-l hyphen">-</span>
	                                <div class="hp4 fl-l">
	                                    <input type="tel" class="number" id="bnum3" title="사업자번호 세번째 자리" maxlength="5" back="bnum3" numberOnly>
	                                </div>
		                            <div class="">
		                            	<button type="button" class="btn-normal form btn-nice-auth-num" id="jobsendBtn" onclick="bizNoCheck();" style="">사업자번호요청</button>
									</div>
	                            </div>
							</div>
							<div class="grid2">
							    <div class="form-wrap">
							        <p class="input-tit font13 color-351B6F" id="id_job_join_day">입사일</p>
							        <input type="text" class="calendar" name="job_join_day" id="job_join_day"  placeholder="ex) 20101206" title="입사일" maxlength="8" value="" >
							    </div>
							    <div class="form-wrap">
							        <p class="input-tit font13 color-351B6F" id="id_job_day">재직기간</p>
							        <input type="text" name="job_period" id="job_period" placeholder="입사일 기준 자동 계산" title="재직기간" readonly="readonly" value="0"/>
							        <div class="unit-txt">개월</div>
							        <!--단위 텍스트가 있을때-->
							    </div>
							</div>
							<div class="cust_cd_fc"></div>
							<div class="grid2">
							    <div class="form-wrap" style="display: none;">
							    	<p class="input-tit font13 color-351B6F">고객구분</p>
							        <div class="select-wrap">
							            <select class="job_type0" name="cust_cd" id="cust_cd">
							                <option selected="selected" value="">선택</option>
							                <c:forEach var="item" items="${custTypeCodeList }">
							                    <option value="${item.code }">${item.name }</option>
							                </c:forEach>
							            </select>
							        </div>
							    </div>
							</div>
	                        <div class="mydata-wrap mb5 mydata-box mb30">
                        		<span style="font-weight:bold;font-size:20px;display: grid;justify-content: center;padding-bottom: 15px;">공공마이데이터 조회 목록</span>
	                        	<ul class="list-bull" id="mydataScrapSelectList">
								</ul>
	                        </div>
						</div>
                        </form>
                        
		                <div class="loan-wrap">
		                    <div class="content1 of-hi">
		                        <h3 class="tit">상담사 설명확인</h3>
		                        <p class="ta-c font20 color-333333 mb40">
		                            금융회사는 대출모집상담사를 통해 접수된 대출의 경우, “대출모집인 제도 모범규준 <br>
		                            제 10조 제 1항 2호”에 따라 대출 실행 이전에 대출신청인에게 아래 각 사항을 확인하여야 합니다.<br>
		                            아래의 질문사항에 대하여 직접 사실대로 작성하여 주시기 바랍니다.</p>
		                        <form id="frm2"><!-- onsubmit="return false" -->
		                        <div id="con0" class="q-wrap mb40">
		                            <ul>
		                                <li class="question-wrap">
		                                    <span id="con1" class="category fl-l">Q</span>
		                                    <span class="con fl-l"> 대출계약을 체결하기 전에 대출상담사로부터 대출상품의 조건 및 대출내용 등에 관하여 충분한 설명을 받으셨나요? 대출계약 중요사항(금리, 대출금액, 대출기간, 중도상환수수료 등)에 대한 설명 포함
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree11" class="radio r-on"><input type="radio" name="desc-agree1" id="desc-agree11" value="Y">예</label>
		                                        <label for="desc-agree12" class="radio"><input type="radio" name="desc-agree1" id="desc-agree12" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con2" class="category fl-l">Q</span>
		                                    <span class="con fl-l"> 대출상담사로부터 대출모집인은 금융회사의 업무위탁을 받아 대출모집 및 소개등의 섭외 활동을 한다는 사실에 대하여 사전에 고지 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree21" class="radio r-on"><input type="radio" name="desc-agree2" id="desc-agree21" value="Y">예</label>
		                                        <label for="desc-agree22" class="radio"><input type="radio" name="desc-agree2" id="desc-agree22" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con3" class="category fl-l">Q</span>
		                                    <span class="con fl-l"> 대출모집상담사로부터 고객에게 별도의 수수료를 요구하거나 수취할 수 없다는 사실에 대하여 사전에 고지 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree31" class="radio r-on"><input type="radio" name="desc-agree3" id="desc-agree31" value="Y">예</label>
		                                        <label for="desc-agree32" class="radio"><input type="radio" name="desc-agree3" id="desc-agree32" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con4" class="category fl-l">Q</span>
		                                    <span class="con fl-l"> 대출상담사로부터 여신심사 등을 통한 대출실행의 결정은 금융회사가 한다는 사실에 대하여 사전에 고지 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree41" class="radio r-on"><input type="radio" name="desc-agree4" id="desc-agree41" value="Y">예</label>
		                                        <label for="desc-agree42" class="radio"><input type="radio" name="desc-agree4" id="desc-agree42" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con5" class="category fl-l">Q</span>
		                                    <span class="con fl-l"> 대출상담사로부터 귀하의 소득재산, 부채상환, 신용 및 변제계획 등을 고려하여 적합한 대출상품을 권유 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree51" class="radio r-on"><input type="radio" name="desc-agree5" id="desc-agree51" value="Y">예</label>
		                                        <label for="desc-agree52" class="radio"><input type="radio" name="desc-agree5" id="desc-agree52" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con6" class="category fl-l">Q</span>
		                                    <span class="con fl-l">  대출상담사로부터 귀하가 필요한 자금의 범위를 초과하여 대출을 받도록 권유 또는 유도 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree61" class="radio r-on"><input type="radio" name="desc-agree6" id="desc-agree61" value="Y">예</label>
		                                        <label for="desc-agree62" class="radio"><input type="radio" name="desc-agree6" id="desc-agree62" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con7" class="category fl-l">Q</span>
		                                    <span class="con fl-l">  대출상담사로부터 귀하가 원하지 않는 고금리 대출로 변경하도록 권유 또는 유도 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree71" class="radio r-on"><input type="radio" name="desc-agree7" id="desc-agree71" value="Y">예</label>
		                                        <label for="desc-agree72" class="radio"><input type="radio" name="desc-agree7" id="desc-agree72" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <!-- TODO 180424 추가 -->
		                                <li class="question-wrap">
		                                    <span id="con8" class="category fl-l">Q</span>
		                                    <span class="con fl-l pt10 d-inline-b">  대출 상담을 받은 모집상담사 이름은 무엇인가요?
		                                    </span>
		                                    <span class="fl-r">
		                                        <span class="form-wrap"><input type="text" id="name" name="dsrName" placeholder="${sDsrUser.NAME }" class="ko-txt"></span>
		                                    </span>
		                                </li>
		                                <!-- //180424 추가 -->
		                            </ul>
		                        </div>
		                        </form>
		                    </div>
		                </div>

                        <div class="loan-wrap" style="margin-top:40px;margin-bottom:40px;padding-top:40px;padding-bottom:40px;border-top:1px solid #ccc;border-bottom:1px solid #ccc;">
		                    <div class="content1 of-hi">
		                        <h3 class="tit">적합성·적정성원칙 확인서</h3>
		                        <%@ include file="../loan/include/inc_terms.jspf" %>
		                    </div>
		                </div>
		                 <div class="line-box" id="inc_indv_trn_cnfr_div">
                        	<div>
<!--                         		<p class="tit-txt">고객거래확인</p> -->
                        	<h3 class="tit">고객거래확인</h3>
                        	</div>
                        	<div class="cust_terms_contents" style="margin-top:20px;padding:40px;background-color:#fff;">
<%--                        			<%@ include file="../loan/include/inc_indv_trn_cnfr.jspf" %> --%>
								<div class="class_cust_terms">
									<div class="sign-area">
										<p>『특정금융거래정보의 보고 및 이용 등에 관한 법률』, 『공중 등 협박목적 및  대량살상무기확산을 위한 자금조달행위의 금지에 관한 법률』에 따라 고객은 당사와 거래 시 고객확인 및 검증을 위하여 아래의 내용을 기재하셔야  합니다. 
										당사는 기재된 정보를 검증하기 위하여 추가적인 자료를 요구할 수 있으며, 고객이 금융거래제한대상자이거나 요청된 정보 제출을 거부  또는 고객확인 및 검증이 충분히 이루어지지 않을 경우 요청하신 금융거래가 지연되거나 거절될 수 있습니다. 
										고객이 제공하신 정보 또는 자료는  ‘금융실명거래 및 비밀보장에 관한 법률’과 '신용정보의 보호 및 이용에 관한 법률' 등 관련법령에 따라 보호됩니다.</p>
									</div>

									<div class="">
										<table class="table-style td-r" style="margin-top: 20px;">
											<caption>고객거래확인</caption>
											<colgroup>
												<col style="width:25%;">
												<col style="width:*;">
											</colgroup>
								
											<tbody>
												<tr>
													<th><span class="cust_terms_accent">Q </span>개인거래목적</th>
													<td scope="row" style="text-align: left;padding: 10px;" id="indv_trn_prps_area">
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_1" value="3010">
															<label for="indv_trn_prps_radio_1">급여 및 생활비</label>
														</span>
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_2" value="3020">
															<label for="indv_trn_prps_radio_2">저축 및 투자</label>
														</span>
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_3" value="3030">
															<label for="indv_trn_prps_radio_3">사업상 거래</label>
														</span>
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_4" value="3040">
															<label for="indv_trn_prps_radio_4">부동산 매매</label>
														</span>
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_5" value="3050">
															<label for="indv_trn_prps_radio_5">상속, 증여성 거래</label>
														</span>
														<div class="mt10">
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_6" value="3060">
																<label for="indv_trn_prps_radio_6">타금융회사 상품가입</label>
															</span>
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_7" value="3070">
																<label for="indv_trn_prps_radio_7">대출담보제공</label>
															</span>
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_8" value="3080">
																<label for="indv_trn_prps_radio_8">대출보증</label>
															</span>
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_9" value="3090">
																<label for="indv_trn_prps_radio_9">대출연장</label>
															</span>
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_10" value="3100">
																<label for="indv_trn_prps_radio_10">대출원리금상환</label>
															</span>
														</div>
														<div class="mt10">
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_11" value="3110">
																<label for="indv_trn_prps_radio_11">차입, 부채 상환</label>
															</span>
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_13" value="3120">
																<label for="indv_trn_prps_radio_13">결제</label>
															</span>
															<span class="ctm-check apv-check">
																<input type="checkbox" name="INDV_TRN_PRPS_APV_ONE_CNTN" id="INDV_TRN_PRPS_APV_ONE_CNTN" value="">
																<label for="INDV_TRN_PRPS_APV_ONE_CNTN">보험료납부</label>
															</span>
															<span class="ctm-check apv-check">
																<input type="checkbox" name="INDV_TRN_PRPS_APV_TWO_CNTN" id="INDV_TRN_PRPS_APV_TWO_CNTN" value="">
																<label for="INDV_TRN_PRPS_APV_TWO_CNTN">공과금납부</label>
															</span>
															<span class="ctm-check apv-check">
																<input type="checkbox" name="INDV_TRN_PRPS_APV_THR_CNTN" id="INDV_TRN_PRPS_APV_THR_CNTN" value="">
																<label for="INDV_TRN_PRPS_APV_THR_CNTN">카드대금</label>
															</span>
															<!-- <span class="ctm-radio">
																<input type="radio" name="indv_trn_prps_radio" id="indv_trn_prps_radio_12" value="3999">
																<label for="indv_trn_prps_radio_12">기타</label>
															</span>
															<input type="text" id="INDV_TRN_PRPS_ETC_TEXT_CUST" style="width:250px;min-height:28px;" maxlength="30" disabled="disabled" title="기타"> -->
														</div>
													</td>
												</tr>
												<tr>
													<th><span class="cust_terms_accent">Q </span>거래자금의 원천 및 출처</th>
													<td scope="row" style="text-align: left;padding: 10px;" id="indv_trn_cpt_area">
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_1" value="7010">
															<label for="indv_trn_cpt_radio_1">근로 및 연금소득</label>
														</span>
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_2" value="7020">
															<label for="indv_trn_cpt_radio_2">퇴직소득</label>
														</span>
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_3" value="7030">
															<label for="indv_trn_cpt_radio_3">사업소득</label>
														</span>
														<span class="ctm-radio">
															<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_4" value="7040">
															<label for="indv_trn_cpt_radio_4">부동산 임대소득</label>
														</span>
														<div class="mt10">
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_5" value="7050">
																<label for="indv_trn_cpt_radio_5">부동산 양도소득</label>
															</span>
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_6" value="7060">
																<label for="indv_trn_cpt_radio_6">금융소득(이자 및 배당)</label>
															</span>
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_7" value="7070">
																<label for="indv_trn_cpt_radio_7">상속/증여</label>
															</span>
															<span class="ctm-radio">
																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_8" value="7080">
																<label for="indv_trn_cpt_radio_8">일시 재산양도로 인한 소득</label>
															</span>
														</div>
<!-- 														<div class="mt10"> -->
<!-- 															<span class="ctm-radio"> -->
<!-- 																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_9" value="7100"> -->
<!-- 																<label for="indv_trn_cpt_radio_9">대출(차입)</label> -->
<!-- 															</span> -->
<!-- 															<span class="ctm-radio"> -->
<!-- 																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_10" value="7110"> -->
<!-- 																<label for="indv_trn_cpt_radio_10">보증 및 담보제공</label> -->
<!-- 															</span> -->
<!-- 															<span class="ctm-radio"> -->
<!-- 																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_11" value="7120"> -->
<!-- 																<label for="indv_trn_cpt_radio_11">가계소득(장학금/용돈 등)</label> -->
<!-- 															</span> -->
<!-- 															<span class="ctm-radio"> -->
<!-- 																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_12" value="7130"> -->
<!-- 																<label for="indv_trn_cpt_radio_12">모임단체재정(회비/현금/기부금 등)</label> -->
<!-- 															</span> -->
<!-- 														</div> -->
														<div class="mt10">
															<!-- <span class="ctm-radio">
																<input type="radio" name="indv_trn_cpt_radio" id="indv_trn_cpt_radio_13" value="7090">
																<label for="indv_trn_cpt_radio_13">기타</label>
															</span>
															<input type="text" id="INDV_TRN_CPT_ETC_TEXT_CUST" style="width:250px;min-height:28px;" maxlength="30" disabled="disabled" title="기타"> -->
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
                        	</div>
                        </div>
                        <div class="class_line_box"></div>
                        <form id="frm_terms">
                        <p class="font20 color-333333 ta-c mb20" style="margin-top: 30px; margin-bottom: 10px;">
                        	대출신청을 위한 약관에 동의하시겠습니까?
                        </p>
                        <div id="terms_focus"></div>
                        <div class="agree-wrap mb5 agree-box">
	                        <div class="txt-box"> ※ 열람하실 동의서 유형을 선택해 주시기 바랍니다. <br>	 
								<span class="radio-wrap">
									<label for="detailAgree" class="radio r-on">
									<input type="radio" name="detailSumAgree" id="detailAgree" value="N" checked>요약동의서</label> 
								</span>
								<span class="radio-wrap">
									<label for="sumAgree" class="radio">
									<input type="radio" name="detailSumAgree" id="sumAgree" value="Y"> 상세동의서</label> 				
								</span> 
							</div>	<br>
							<dl>
								<dd id="T000800025" style="margin-left: 0px !important;">
									<label for="importantdetail" class="check2" style="font-weight:bold;"><input type="checkbox" id="importantdetail" value="" onclick="fn_DivMainOpen();" >(필수)금융상품 중요사항 안내(유의사항 포함)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" title="중요사항안내 확인하기" onclick="fn_DivMainOpen()">자세히보기</button>
								</dd>
						        <%@ include file="./include/inc_loan_important.jsp" %>
								<!-- 가계대출상품설명서 최신으로 변경 -->
<!-- 								<dd id="N000804001" style="margin-left: 0px !important;"> -->
								<dd id="T000800004" style="margin-left: 0px !important;">
									<label for="productdetail" class="check2" onclick="checkDuty(this);" style="font-weight:bold;"><input type="checkbox" id="productdetail" value="">(필수)가계대출상품설명서 확인하기</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual012-layer" title="상품설명서 확인하기">자세히보기</button>    
                                    <div class="subcheck-area add_class2">
                                    	<div class="sub-box">
                                        	<p class="check-tit"><label for="prod_terms_agree0" class="check"><input type="checkbox" name="prod_terms_agree0" id="prod_terms_agree0" value=""  disabled="disabled">금리인하요구권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	<!-- 2021.09.14 -->
                                        	<!-- <p class="check-tit"><label for="prod_terms_agree1" class="check"><input type="checkbox" name="prod_terms_agree1" id="prod_terms_agree1" value=""  disabled="disabled">청약철회권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	<p class="check-tit"><label for="prod_terms_agree2" class="check"><input type="checkbox" name="prod_terms_agree2" id="prod_terms_agree2" value=""  disabled="disabled">위법계약해지권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	<p class="check-tit"><label for="prod_terms_agree6" class="check"><input type="checkbox" name="prod_terms_agree6" id="prod_terms_agree6" value=""  disabled="disabled">자료열람요구권에 대한 상기의 설명을 확인하였습니다.</label></p> -->
                                       		<!-- <div>
	                                        	<p class="check-tit">대출모집인 설명확인서 <br>
                                        			<span class="radio-wrap fl-l" style="height: 20px;">
				                                        <label for="prod_terms_agree3_1" class="radio r-on"><input type="radio" name="prod_terms_agree3" id="prod_terms_agree3_1" value="Y" checked disabled="disabled">설명 받았음</label>
				                                        <label for="prod_terms_agree3_2" class="radio"><input type="radio" name="prod_terms_agree3" id="prod_terms_agree3_2" value="N"disabled="disabled">설명 받지 않았음</label>
				                                    </span>
                                        		
    	                                    	</p>
                                       		</div> -->
                                       		<div style="margin-top:20px;">
                                       			<p class="check-tit">대출거절사유 고지신청서 <br>
	                                        		<span class="radio-wrap fl-l" style="height: 20px;">
				                                        <label for="prod_terms_agree4_1" class="radio"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_1" value="Y">신청</label>
				                                        <label for="prod_terms_agree4_2" class="radio r-on"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_2" value="N" checked >신청하지 않음</label>
				                                    </span>
	                                        	</p>
                                       		</div>
                                        	<div style="margin-top:20px;">
                                        		<p class="check-tit">대학생·청년층확인서 <br>
	                                        		<span class="radio-wrap fl-l" style="height: 20px;">
				                                        <label for="prod_terms_agree5_1" class="radio"><input type="radio" name="prod_terms_agree5" id="prod_terms_agree5_1" value="Y" disabled="disabled">설명 받았음</label>
				                                        <label for="prod_terms_agree5_2" class="radio r-on"><input type="radio" name="prod_terms_agree5" id="prod_terms_agree5_2" value="N" checked disabled="disabled">설명 받지 않았음</label>
				                                    </span>
	                                        	</p>
                                        	</div>
                                        	<br>
	                                    </div>
                                    </div>
                                </dd>
                            </dl>
                            <dl class ="allChk">
                                <dt>
                                	<label id="all-check-lb" for="all-check" class="check" style="font-weight:bold;"><input type="checkbox" id="all-check" value="">다음의 필수약관에 모두 동의합니다.</label>
                                    <button type="button" name="button" class="btn-normal tiny done hide" data-tooltip="agreementall-layer" title="전체약관 자세히보기" tabindex="-1">자세히보기</button>
                                </dt>
                                <dd id="T000800001">
                                    <label for="agree-check1" class="check"><input type="checkbox" name="terms_agreement_1" id="agree-check1" value="" onclick="javascript:termsRadioChangeEvent('T000800001','lab');">(필수)개인(신용)정보 수집·이용·제공·조회 동의서</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip=manual011-layer title="(필수)개인(신용)정보 수집·이용·제공·조회 동의서 자세히보기" onclick="javascript:termsRadioChangeEvent('T000800001');">자세히보기</button><!--  onclick="javascript:termsRadioChangeEvent(this);" -->
                                </dd>
                                <dd id="N000802001">
                                    <label for="agree-check6" class="check"><input type="checkbox" name="terms_agreement_6" id="agree-check6" value="" onclick="javascript:termsRadioChangeEvent('N000802001','lab');">(필수)개인(신용)정보 수집·이용·제공 동의서(여신 금융거래)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)개인(신용)정보 수집·이용·제공 동의서(여신금융거래)" onclick="javascript:termsRadioChangeEvent('N000802001');">자세히보기</button><!--  onclick="javascript:termsRadioChangeEvent(this);" -->
                                </dd>
                                <dd id="T000800006">
                                    <label for="agree-check2" class="check"><input type="checkbox" name="terms_agreement_2" id="agree-check2" value="" >(필수)개인(신용)정보 조회동의서 (서민금융진흥원用)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)개인(신용)정보 조회동의서 (서민금융진흥원用) 자세히보기">자세히보기</button>
                                </dd>
                                <dd id="T000800007">
                                    <label for="agree-check3" class="check"><input type="checkbox" name="terms_agreement_3" id="agree-check3" value="" >(필수)개인(신용)정보 수집·이용·제공 동의서 (서민금융진흥원用)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)개인(신용)정보 수집·이용·제공 동의서 (서민금융진흥원用) 자세히보기">자세히보기</button>
                                </dd>
<!--                                 <dd id="T000800008"> -->
<!--                                     <label for="agree-check4" class="check"><input type="checkbox" name="terms_agreement_4" id="agree-check4" value="" >(필수)개인(신용)정보 및 기업(신용)정보 조회․수집·이용·제공과 행정정보공동이용, 전자금융거래확인서 발급을 위한 동의서</label> -->
<!--                                     <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)개인(신용)정보 및 기업(신용)정보 수집·이용·제공과 행정정보공동이용, 전자금융거래확인서 발급을 위한 동의서 자세히보기">자세히보기</button> -->
<!--                                 </dd> -->
                                
                                <dd id="T000800009">
                                    <label for="agree-check8" class="check"><input type="checkbox" name="terms_agreement_8" id="agree-check8" value="" >(필수)계약 체결·이행을 위한 상세 동의서(개인금융성 신용보험용)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)계약 체결·이행을 위한 상세 동의서(개인금융성 신용보험용) 자세히보기">자세히보기</button>
                                </dd>
                                <!-- <dd id="N000804001">
                                    <label for="productdetail" class="check"><input type="checkbox" id="productdetail" value="">(필수)가계대출상품설명서 확인하기</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="상품설명서 확인하기">자세히보기</button>    
                                    <div class="subcheck-area add_class2">
                                    	<div class="sub-box">
                                        	<p class="check-tit"><label for="prod_terms_agree0" class="check"><input type="checkbox" name="prod_terms_agree0" id="prod_terms_agree0" value=""  disabled="disabled">금리인하요구권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	2021.09.14
                                        	<p class="check-tit"><label for="prod_terms_agree1" class="check"><input type="checkbox" name="prod_terms_agree1" id="prod_terms_agree1" value=""  disabled="disabled">청약철회권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	<p class="check-tit"><label for="prod_terms_agree2" class="check"><input type="checkbox" name="prod_terms_agree2" id="prod_terms_agree2" value=""  disabled="disabled">위법계약해지권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	<p class="check-tit"><label for="prod_terms_agree6" class="check"><input type="checkbox" name="prod_terms_agree6" id="prod_terms_agree6" value=""  disabled="disabled">자료열람요구권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                       		<div>
	                                        	<p class="check-tit">대출모집인 설명확인서 <br>
                                        			<span class="radio-wrap fl-l" style="height: 20px;">
				                                        <label for="prod_terms_agree3_1" class="radio r-on"><input type="radio" name="prod_terms_agree3" id="prod_terms_agree3_1" value="Y" checked disabled="disabled">설명 받았음</label>
				                                        <label for="prod_terms_agree3_2" class="radio"><input type="radio" name="prod_terms_agree3" id="prod_terms_agree3_2" value="N"disabled="disabled">설명 받지 않았음</label>
				                                    </span>
                                        		
    	                                    	</p>
                                       		</div>
                                       		<div style="margin-top:20px;">
                                       			<p class="check-tit">대출거절사유 고지신청서 <br>
	                                        		<span class="radio-wrap fl-l" style="height: 20px;">
				                                        <label for="prod_terms_agree4_1" class="radio"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_1" value="Y">신청</label>
				                                        <label for="prod_terms_agree4_2" class="radio r-on"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_2" value="N" checked >신청하지 않음</label>
				                                    </span>
	                                        	</p>
                                       		</div>
                                        	<div style="margin-top:20px;">
                                        		<p class="check-tit">대학생·청년층확인서 <br>
	                                        		<span class="radio-wrap fl-l" style="height: 20px;">
				                                        <label for="prod_terms_agree5_1" class="radio"><input type="radio" name="prod_terms_agree5" id="prod_terms_agree5_1" value="Y" disabled="disabled">설명 받았음</label>
				                                        <label for="prod_terms_agree5_2" class="radio r-on"><input type="radio" name="prod_terms_agree5" id="prod_terms_agree5_2" value="N" checked disabled="disabled">설명 받지 않았음</label>
				                                    </span>
	                                        	</p>
                                        	</div>
                                        	<br>
	                                    </div>
                                    </div>
                                </dd> -->
                                <dd id="sunshinedetail1">
                                    <label for="sunshinedetail" class="check"><input type="checkbox" id="sunshinedetail" value="">(필수)가계대출 상품설명서 확인하기</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="햇살론 상품설명서 확인하기">자세히보기</button>
                                </dd>
	                            <dd id="saitdoldetail1">
		                            <label for="saitdoldetail" class="check"><input type="checkbox" id="saitdoldetail" value="">(필수)가계대출상품설명서 확인하기</label>
		                            <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="상품설명서 확인하기">자세히보기</button>
	                            </dd>
	                            
								<dd id="T000800010">
									<label for="agree-check11" class="check"><input type="checkbox" name="terms_agreement_11" id="agree-check11" value="" >(필수)CMS 출금이체 동의</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="CMS 출금이체 동의 확인하기">자세히보기</button>
								</dd>
								<!-- //180612 약관추가 -->
								<dd id="T000800018">
									<label for="agree-check18" class="check"><input type="checkbox" name="terms_agreement_18" id="agree-check18" value=""  onclick="javascript:termsRadioChangeEvent('T000800018');">(필수)개인(신용)정보 제3자 제공 동의서 [신용대출, 담보대출, 정책자금대출]</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="개인(신용)정보 제3자 제공 동의서 [신용대출, 담보대출, 정책자금대출] 확인하기" onclick="javascript:termsRadioChangeEvent('T000800018');">자세히보기</button>
								</dd>
								
                                <dd>
                                	<hr class="line mt20">
                                </dd>
                                <dd class="mt20">
                                </dd>
                             </dl>
                        
                             <dl class="mdChk">
                                <dt>
                                	<label id="all-md-check-lb" for="all-md-check" class="check" style="font-weight:bold;"><input type="checkbox" id="all-md-check" value="" >다음의 공공 마이데이터 필수약관에 모두 동의합니다.</label>
                                    <button type="button" name="button" class="btn-normal tiny done hide" data-tooltip="mdagreementall-layer" title="전체약관 자세히보기" tabindex="-1">자세히보기</button>
                                </dt>
								<dd id="T001700001" >
									<label for="agree-check44" class="check"><input type="checkbox" name="terms_agreement_44" class="agree-check44" id="agree-check44" value="" >(필수)공공 마이데이터 개인(신용)정보 수집·이용·제공 동의서</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="공공 마이데이터 개인(신용)정보 수집·이용·제공 동의서" >자세히보기</button>
								</dd>
								<dd id="T001700002"  >
									<label for="agree-check45" class="check"><input type="checkbox" name="terms_agreement_45" class="agree-check45" id="agree-check45"  value="" >(필수)본인 행정정보 제3자 제공 요구서</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="공공 마이데이터 개인(신용)정보 수집·이용·제공 동의서" >자세히보기</button>
								</dd>
								<dd id="T001700003"  >
									<label for="agree-check47" class="check"><input type="checkbox" name="terms_agreement_47" class="agree-check47" id="agree-check47"  value="" >(필수)본인정보 제3자 제공 요구서</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="공공 마이데이터 개인(신용)정보 수집·이용·제공 동의서" >자세히보기</button>
								</dd>
										<dd>
                                	<hr class="line mt20">
                                </dd>
                                <dd class="mt20">
                                </dd>
								
								</dl>
							
                             
                             <dl class="chChk">
                              	<dt>
                                	<label id="all-ch-check-lb" for="all-ch-check" class="check" style="font-weight:bold;"><input type="checkbox" id="all-ch-check" value="">다음의 선택약관에 모두 동의합니다.</label>
                                    <button type="button" name="button" class="btn-normal tiny done hide" data-tooltip="agreementChall-layer" title="전체약관 자세히보기" tabindex="-1">자세히보기</button>
                                </dt>
                                <dd id="T000800003">
                                    <label for="agree-check5" class="check"><input type="checkbox" id="agree-check5" value=""  onclick="javascript:termsRadioChangeEvent('T000800003','lab');">(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(상품서비스 안내 등)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(상품서비스 안내 등) 자세히보기" onclick="javascript:termsRadioChangeEvent('T000800003');">자세히보기</button> <!--  onclick="javascript:termsRadioChangeEvent(this);" -->
                                    <div class="subcheck-area add_class1">
                                        	<p class="check-tit"><label for="apply_yn_agree" class="check" style="font-weight:bold;"><input type="checkbox" name="apply_yn_agree" id="apply_yn_agree" value="" >위 개인(신용)정보 수집·이용에 동의하십니까? &nbsp;&nbsp;<img style="width:30px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_1.gif" alt="수집, 이용에 관한사항  평가등급 보통"/></label></p>
                                    	<div class="sub-box">
                                        	<p class="check-tit subbox-all"><label for="marketing_yn" class="check"><input type="checkbox" name="marketing_yn" id="marketing_yn" value="" >전자적 전송매체를 통한 광고성 정보의 수신을 동의하십니까?</label></p>
                                        	<div class="sub-check">
	                                    	<p class="txt">상품서비스 안내수단</p>
	                                    	<span class="subcheck-all"><label for="service" class="check"><input type="checkbox" id="service" value="" class="sub-all">전체</label></span>
		                                        <span class="type">
		                                            <label for="marketing_yn_sms" class="check"><input type="checkbox" 	id="marketing_yn_sms" name="marketing_yn_sms" value="" >문자메세지</label>
		                                            <label for="marketing_yn_email" class="check"><input type="checkbox" id="marketing_yn_email" name="marketing_yn_email" value="" >이메일</label>
		                                            <label for="marketing_yn_tel" class="check"><input type="checkbox" id="marketing_yn_tel" name="marketing_yn_tel" value="" >전화</label>
		                                            <label for="marketing_yn_dm" class="check"><input type="checkbox" id="marketing_yn_dm" name="marketing_yn_dm" value="" >DM</label>
		                                        </span>
		                                        <input type="hidden" id="marketing_yn_tok" name="marketing_yn_tok" value="N" ><!-- 20210608 전체선택 체크를 위해 자리이동 -->
	                                        </div>
	                                    </div>
	                                    <div class="sub-box">
                                            <p class="check-tit"><label for="marketing_apply_yn_agree" class="check">
                                            	<input type="checkbox" id="marketing_apply_yn_agree" name="marketing_apply_yn_agree" value="" >위 개인신용정보 제공에 동의하십니까?&nbsp;&nbsp;<img style="width:60px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_3.jpg" alt="제공에 관한 사항 평가등급 다소안심"/></label>
                                            </p>
                                            <div class="sub-check">
                                                <label for="marketing_apply_yn" class="check">
                                                    <input type="checkbox" id="marketing_apply_yn" name="marketing_apply_yn" value="" >제공에 관한 목적별 동의여부
                                                </label>
                                            </div>
	                                    </div>
                                    </div>
                                </dd>
                                <!-- 180612 약관추가 -->
								<!-- <dd>
									<label for="agree-check10" class="check"><input type="checkbox" name="terms_agreement_10" id="agree-check10" value="" >(선택) 개인(신용)정보 선택적 동의서(통신정보 활용 동의)</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="agreement10-layer" title="(선택) 개인(신용)정보 선택적 동의서(통신정보 활용 동의)">자세히보기</button>
									<div class="subcheck-area" id="agree10_sub">
                                    	<div class="sub-box">
                                    		<div>
                                    			<div style="width:50%;float:left;"><span class="check-tit subbox-all" style="font-weight:normal !important;">개인(신용)정보 수집ㆍ이용 동의여부</span></div>
                                    			<div style="width:50%;float:left;"><span class="check-tit subbox-all" style="font-weight:normal !important;">고유식별정보 수집ㆍ이용 동의여부</span></div>
                                    		</div>
                                    		<div>
                                    			<div style="width:50%;float:left;"><span class="check-tit subbox-all" style="font-weight:normal !important;">개인(신용)정보 수집 제공ㆍ조회 동의여부</span></div>
                                    			<div style="width:50%;float:left;"><span class="check-tit subbox-all" style="font-weight:normal !important;">고유식별정보 제공ㆍ조회 동의여부</span></div>
                                    		</div>
                                    		<div>
                                    			<div style="width:50%;float:left;"><span class="check-tit subbox-all" style="font-weight:normal !important;">개인(신용)정보 제공 동의여부</span></div>
                                    			<div style="width:50%;float:left;"><span class="check-tit subbox-all" style="font-weight:normal !important;">개인(신용)정보 처리위탁 동의여부</span></div>
                                    		</div>
	                                    </div>
                                    </div>
								</dd> -->
								<!-- <dd id="T000800011">
									<label for="agree-check9" class="check"><input type="checkbox" name="terms_agreement_9" id="agree-check9" value="" >(선택)대출거절사유 고지에 관한 사항</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="agreement9-layer" title="(선택)대출거절사유 고지에 관한 사항 자세히보기">자세히보기</button>
								</dd> -->
                                <dd id="T000800016">
                                    <label for="agree-check16" class="check"><input type="checkbox" id="agree-check16" value=""  >(선택)개인(신용)정보 수집·이용 동의서(보증료 우대 서비스)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(선택)개인정보 수집이용제공 동의서 (보증료우대서비스) 자세히보기">자세히보기</button>
                                    <div class="subcheck-area1 add_class3">
                                   	<div class="sub-box">
                                       	<p class="check-tit"><label for="agree-check16_1" class="check"><input class="agree-check16" type="checkbox" name="agree-check16" id="agree-check16_1_1" value="">고유식별정보 수집·이용에 동의하십니까?</label></p>
                                       	<p class="check-tit"><label for="agree-check16_2" class="check"><input class="agree-check16" type="checkbox" name="agree-check16" id="agree-check16_2_1" value="">개인(신용)정보 수집·이용에 동의하십니까?&nbsp;&nbsp;<img style="width:30px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_2.gif" alt="일반 개인정보 수집,이용에 관한 사항 평가등급 안심"/></label></p>
                                        <p class="check-tit"><label for="agree-check16_3" class="check"><input class="agree-check16" type="checkbox" name="agree-check16" id="agree-check16_3_1" value="">개인정보 수집·이용에 동의하십니까?&nbsp;&nbsp;<img style="width:30px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_2.gif" alt="건강정보 수집,이용에 관한 사항 평가등급 안심"/></label></p>
                                    </div>
                                    </div>
                                </dd>
                                <dd id="T000800017">
                                    <label for="agree-check17" class="check"><input type="checkbox" id="agree-check17" value="">(선택)개인(신용)정보 수집·이용 동의서(상품서비스 안내 등)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(선택)개인정보 수집이용제공 동의서 (상품서비스 안내) 자세히보기">자세히보기</button>
                                   	<div class="subcheck-area1 add_class4">
                                       	<p class="check-tit"><label for="agree-check17_1" class="check"><input type="checkbox" name="agree-check17" id="agree-check17_1_1" value="" >개인(신용)정보 수집·이용에 동의하십니까?&nbsp;&nbsp;<img style="width:30px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_1.gif" alt="일반 개인정보 수집,이용에 관한 사항 평가등급 보통"/></p>
                                       	<p class="check-tit"><label for="agree-check17_2" class="check"><input type="checkbox" name="agree-check17" id="agree-check17_2_1" value="" >광고성 정보의 수신을 동의 하시겠습니까?</label></p>
                                    </div>
                                </dd>
                                 <!-- 2022-03-31 (선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(맟춤형 상품 제공) 추가 -->
                                <dd id="T000800022">
                                    <label for="agree-check14" class="check"><input type="checkbox" id="agree-check14" value=""  onclick="termsCheckBoxChangeEvent('agree-check14');">(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(맟춤형 상품 제공)</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(맟춤형 상품 제공)자세히보기">자세히보기</button>
									<div class="subcheck-area add_class5">
                                    	<div class="sub-box">
                                    		<p class="check-tit"><label for="yn_agree" class="check" style="font-weight:bold;">
                                    			<input type="checkbox" name="yn_agree" id="yn_agree" value="" >위 개인(신용)정보 수집·이용에 동의하십니까?</label>
                                    		</p>
                                        	<p class="check-tit"><label for="yn_agree2" class="check" style="font-weight:bold;">
                                        		<input type="checkbox" name="yn_agree2" id="yn_agree2" value="" >위 개인(신용)정보 제공에 동의하십니까?</label>
                                        	</p>
	                                    </div>
                                    </div>
								</dd>  
								<dd id="T001000002">
                                    <label for="agree-check46" class="check"><input type="checkbox" id="agree-check46" value="">(선택)개인(신용)정보 수집·이용·제공·조회 동의서 [멤버십 회원가입 동의]</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(선택)개인정보 수집이용제공 동의서 (상품서비스 안내) 자세히보기">자세히보기</button>
                                </dd>
								   <div class="subcheck-area1 add_class6">
	                          	<dd id="T001000001" onclick="agrchkk();">             
									<label for="agree-check46_1" class="check"><input type="checkbox" id="agree-check46_1" value="" >예가람저축은행 멤버쉽 회원 약관</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="예가람저축은행 멤버쉽 회원 약관">자세히보기</button>
                               	</dd>
                                </div>
                            </dl>
                            
                            <%-- 상품설명서 확인여부. --%>
                           	<input type="hidden" name="terms_agreement_detail" value="Y"/>
                           	
                           	<input type="hidden" name="CRDT_AGR_DTL_YN" id="CRDT_AGR_DTL_YN"><!-- 개인(신용)정보 조회 동의서 상세여부 -->
							<input type="hidden" name="PROD_AGR_DTL_YN" id="PROD_AGR_DTL_YN"><!-- 개인(신용)정보 수집·이용·제공 동의서(여신 금융 거래) 상세여부 -->
							<input type="hidden" name="SRVC_AGR_DTL_YN" id="SRVC_AGR_DTL_YN"><!-- 개인(신용)정보 수집·이용·제공 동의서(상품서비스 안내) 상세여부 -->
                           	<input type="hidden" name="THIRD_AGR_DTL_YN" id="THIRD_AGR_DTL_YN"><!-- 개인(신용)정보 제3자 제공동의서[동산담보대출] -->
                           	<input type="hidden" name="GUARANTEE_SERVICE_YN" id="GUARANTEE_SERVICE_YN"><!-- (선택)개인정보 수집이용제공 동의서 (보증료우대서비스) -->
							<input type="hidden" name="PRODUCT_SERVICE_YN" id="PRODUCT_SERVICE_YN"><!-- (선택)개인정보 수집이용제공 동의서 (상품서비스 안내) -->
							
							<input type="hidden" name="MYDT_CRDT_AGR_DTL_YN"" id="MYDT_CRDT_AGR_DTL_YN"><!-- [필수]공공 마이데이터 개인(신용)정보 수집·이용·제공 동의서) -->
							<input type="hidden" name="MYDT_SRVC_AGR_DTL_YN" id="MYDT_SRVC_AGR_DTL_YN"><!-- [필수]본인 행정정보 제3자 제공 요구서 -->
							<!-- 2021.09.29 상품설명서 동의여부 -->
			            	<input type="hidden" name="PRODUCT_DESC_YN" id="PRODUCT_DESC_YN">
			            	
				            <!-- 2022.03.31 개인(신용)정보 수집·이용·제공 동의서 (맞춤형 정보제공) 상세여부 -->
							<input type="hidden" name="SRVC_PRVD_AGR_DTL_YN" id="SRVC_PRVD_AGR_DTL_YN" value = 'N'>
							<!-- 2022.03.31  개인(신용)정보 수집·이용·제공 동의서 (맞춤형 정보제공) -->
							<input type="hidden" name="PRODUCT_SERVICE_PROVIDE_YN" id="PRODUCT_SERVICE_PROVIDE_YN">
							
							
                        </div>
                        </form>
                        <p class="font12 color-626C74 mb30">※ 고객님께서 입력하신 개인정보는 대출신청 완료 후 수집됩니다.<br> ※ 대출신청하기 클릭 시 본인인증팝업으로 넘어갑니다.</p>
                        <p class="ta-c">
                            <button type="button" name="button" class="btn-big pink" onclick="next()">다음단계</button>
                            <button type="button" name="button" class="btn-big re ir" onclick="location.href='<c:url value="${home}"/>'">이전페이지로</button>
                        </p>
                    </div>
                    
                    
                   	<div class="content1" style="display:none;" id="limit_list">
                   		<div class="step-wrap mb60">
                            <ul>
                            	<li class="step02"><span>01<strong>신청정보 입력</strong></span></li>
                            	<li class="step02 active"><span>02<strong>상품선택</strong></span></li>
                        		<li class="step03"><span>03<strong>대출신청 완료</strong></span></li>
                            </ul>
                        </div>
                        <h3 class="tit">대출진행 가능상품</h3>
<!-- 		            	<div class="tit color-612885 font40 mb30"></div> -->
		                <div id="loan_list">
		                
		                </div>
		                <div class="mb30"></div>
		                <p class="ta-c">
		                     <button type="button" name="button" class="btn-big pink" onclick="req_next();">대출신청</button>
		                </p>
			            <form id="req_frm" name="req_frm" method="post">
					        <input type="hidden" name="INSP_NO" id="INSP_NO" value=""/>
					        <input type="hidden" name="PROD_CD" id="PROD_CD" value=""/>
					        <input type="hidden" name="MEMBER_SERVICE_PROVIDE_YN" id="MEMBER_SERVICE_PROVIDE_YN" value=""/>
					        <input type="hidden" name="INDV_NEW_TRN_PRPS_DVCD" id="INDV_NEW_TRN_PRPS_DVCD" value=""/>
					        <input type="hidden" name="INDV_NEW_TRN_PRPS_APV_ONE_CNTN" id="INDV_NEW_TRN_PRPS_APV_ONE_CNTN" value=""/>
					        <input type="hidden" name="INDV_NEW_TRN_PRPS_APV_TWO_CNTN" id="INDV_NEW_TRN_PRPS_APV_TWO_CNTN" value=""/>
					        <input type="hidden" name="INDV_NEW_TRN_PRPS_APV_THR_CNTN" id="INDV_NEW_TRN_PRPS_APV_THR_CNTN" value=""/>
					        <input type="hidden" name="INDV_TRN_CPT_DVCD" id="INDV_TRN_CPT_DVCD" value=""/>
					    </form>
		            </div>
                    
                    
                </div>
            </div>
            <!-- //e:contents -->
            <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
        </div>
        <!-- //e: contentsWrap -->
        
        <!-- s:본인인증방법 레이어팝업 -->
        <div id="authLayer" class="layerpopup auth-layer">
            <!-- s:con -->
            <div class="con authArea">
                <div class="tit color-612885 font40 mb30">본인인증 방법 선택</div>
                <p class="mb40">대출신청 진행을 위해서는 본인인증이 필요합니다. <br>아래의 인증 방식 중 하나를 선택해 인증을 진행해주세요.<br> 
                	<span id="warnCartText" style="color:#DC0082;">
<!--                 	일부 카드의 경우 해당 카드사의 정보미제공으로 본인인증이 불가 합니다.(신한, 현대카드)<br> -->
                	</span>
                	<span id="warnText" style="display:none;color:#DC0082;">"사잇돌2"상품은 SGI서울보증보험의 정책에 따라 아래 두가지 방식을 통한 인증만 유효합니다.</span></p>
                <hr class="mb30">
                <ul class="auth-wrap">
                <c:if test="${phoneYn eq 'Y' }">
                    <li class="auth1">
                        <a href="#" onclick="auth_nice_mobile()">
                            <p>휴대폰인증</p>
                        </a>
                    </li>
                </c:if>
                <!-- 공마데 때문에 휴대폰 인증만 남겨둠 -->
                <%-- <c:if test="${certYn eq 'Y' }">
                    <li class="auth2">
                        <a href="#" onclick="auth_cert('delfino')">
                            <p>공동인증서</p>
                        </a>
                    </li>
                </c:if>
                <c:if test="${certYn eq 'Y' }">
                    <li class="auth6">
                        <a href="#" onclick="auth_cert('fincert')">
                            <p>금융인증서</p>
                        </a>
                    </li>
                </c:if>
                <br>
                <c:if test="${ipinYn eq 'Y' }">
                    <li class="auth3">
                        <a href="#" onclick="auth_ipin()">
                            <p>아이핀인증</p>
                        </a>
                    </li>
                </c:if> --%>
                <%-- <c:if test="${kakaoYn eq 'Y' }">
                    <li class="auth4">
                        <a href="#" onclick="auth_kakao('kakaoLayer')">
                            <p>카카오페이인증</p>
                        </a>
                    </li>
                </c:if> --%>
                <%-- <c:if test="${creditCardYn eq 'Y' }">
                    <li class="auth5">
                        <a href="#" onclick="auth_nice_credit_card()">
                            <p>신용카드인증</p>
                        </a>
                    </li>
                </c:if> --%>
                </ul>
                <form id="delfinoForm" name="delfinoForm" method="post">
			        <input type="hidden" name="PKCS7" value=""/>
			        <input type="hidden" name="VID_RANDOM" value=""/>
			        <input type="hidden" name="certType" id = "certType" value=""/>
			    </form>
            <!-- //e:con -->
            <button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="desc-layer">닫기</button>
            </div>
            
            <div class="con mydataArea"  style="display:none;">
                <div class="tit color-612885 font40 mb30">공공마이데이터 조회 중</div>
                <p class="mb40">직접 서류를 제출하지 않아도 마이데이터로 간편하게 금융서비스를 이용할 수 있습니다.<br> 
                <hr class="mb30">
				<div style="width: 100%; text-align: center; padding-block: 50px;">
					<img src="/resources/normal/images/page/ico-mydata-pc.gif" style="width: 500px;">
				</div>
            </div>
            
            
        </div>
        <!-- //e:본인인증방법 레이어팝업 -->
        
        <!-- s:카카오페이인증 확인 레이어팝업 -->
        <div id="kakaoLayer" class="layerpopup kakao-layer small">
            <!-- s:con -->
            <div class="con">
                <div class="tit color-612885 font40 mb30">카카오페이 인증</div>
                <p class="mb40">고객님의 스마트폰으로 카카오톡 메시지가 전송되었습니다.<br>카카오톡에서 전자서명 인증 완료 후 아래 완료버튼을 클릭해주세요.</p>
                <hr class="mb30">
                <p class="mb40 ta-c">
                	<div class="pay-time">
	                    <p>인증 마감시간</p>
	                    <span id="kakao_timelimit">0:00</span>
	                </div>
                        <p class="ta-c">
                            <button id="btn_complete" type="button" name="button" class="btn-normal form">네, 인증 완료하였습니다.</button>
                            <button type="button" name="button" class="btn-normal form close">취소</button>
                        </p>
            </div>
            <!-- //e:con -->
            <button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="desc-layer">닫기</button>
        </div>
        
        
        
        <!-- s:전체 레이어팝업 -->
		<div id="agreementallLayer" class="layerpopup agreementall-layer" tabindex="0" data-tooltip-con="agreementall-layer" data-focus="agreementall-layer" data-focus-prev="btn-menu-close">
			<div class="pop-wrap">
				<div class="all-agree">* 필수 약관 전체 보기 ( <span class="view"></span> / <span class="total"></span> )</div>
				<iframe id="allViewer" src="" style="width: 100%;height: 75vh;margin-top:15px;"></iframe>
				<!-- s:con -->
				
				<!-- //e:con -->
				<button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="agreementall-layer">닫기</button>
				<div class="ctrl-box">
					<button type="button" name="button" class="btn-prev">이전</button>
					<button type="button" name="button" class="btn-next">다음</button>
				</div>
			</div>
		</div>

		<!-- //e:전체 레이어팝업 -->
		
		 <!-- s:전체 레이어팝업 -->
		<div id="mdagreementallLayer" class="layerpopup agreementall-layer" tabindex="0" data-tooltip-con="mdagreementall-layer" data-focus="mdagreementall-layer" data-focus-prev="btn-menu-close">
			<div class="pop-wrap">
				<div class="all-agree">*공공마이데이터 필수 약관 전체 보기 ( <span class="view2"></span> / <span class="total2"></span> )</div>
				<iframe id="mdallViewer" src="" style="width: 100%;height: 75vh;margin-top:15px;"></iframe>
<!-- 				s:con -->
				
<!-- 				//e:con -->
				<button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="mdagreementall-layer">닫기</button>
				<div class="ctrl-box">
					<button type="button" name="button" class="btn-prev">이전</button>
					<button type="button" name="button" class="btn-next">다음</button>
				</div>
			</div>
		</div>
		<!-- //e:전체 레이어팝업 -->		

		<!-- //s:선택약관 전체 레이어팝업 -->
		<div id="agreementChallLayer" class="layerpopup agreementall-layer" tabindex="0" data-tooltip-con="agreementChall-layer" data-focus="agreementChall-layer" data-focus-prev="btn-menu-close">
			<div class="pop-wrap">
				<div class="all-agree">* 선택 약관 전체 보기 ( <span class="view1"></span> / <span class="total1"></span> )</div>
				<iframe id="allOptViewer" src="" style="width: 100%;height: 75vh;margin-top:15px;"></iframe>
				<!-- s:con -->
				<!-- <iframe class="con" id="viewerChallL" src="" style="width: 100%;height: 650px;margin-top:30px;"></iframe> -->
				<!-- //e:con -->
<!-- 				<br><br><br> -->
				<!-- <div class="pop-cts">
					<div class="btn-wrap" style="margin-top:-30px;">
						<button type="button" name="button" class="btn-normal tooltip-close">닫기</button>
					</div>
				</div> -->
				
				<button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="agreementChall-layer">닫기</button>
				<div class="ctrl-box">
					<button type="button" name="button" class="btn-prev">이전</button>
					<button type="button" name="button" class="btn-next">다음</button>
				</div>
			</div>
		</div>
        <div id="manualLayer011" class="layerpopup manual-layer" tabindex="0" data-tooltip-con="manual011-layer" data-focus="manual011-layer" data-focus-prev="btn-menu-close" style="height: 100%;">
			<div class="pop-wrap">
				<iframe id="viewer" src="" style="width: 100%;height: 75vh;margin-top:15px;"></iframe>
<!-- 				<br><br><br> -->
<!-- 				<div class="pop-cts"> -->
<!-- 					<div class="btn-wrap" style = "margin-top:-10px;"> -->
<!-- 						<button type="button" name="button" class="btn-normal tooltip-close">닫기</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<!-- //e:con -->
				<button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="manual011-layer">닫기</button>
			</div>
		</div>
		<div id="manualLayer012" class="layerpopup manual-layer" tabindex="0" data-tooltip-con="manual012-layer" data-focus="manual012-layer" data-focus-prev="btn-menu-close" style="height: 100%;">
			<div class="pop-wrap">
				<iframe id="dutyViewer" src="" style="width: 100%;height: 75vh;margin-top:15px;"></iframe>
				<button type="button" name="button" class="btn-menu-close" data-focus="btn-menu-close" onclick="closePdf('manualLayer012');" data-focus-next="manual012-layer">닫기</button>
			</div>
			<div style="text-align: center;"> 
				<button type="button" class="agreeBtn" id="agreeBtn" value="N" onclick="importantAgree(this);">아래로 이동</button>
			</div>
		</div>
		<div id="manualLayer013" class="layerpopup manual-layer" tabindex="0" data-tooltip-con="manual013-layer" data-focus="manual013-layer" data-focus-prev="btn-menu-close" style="height: 100%;">
			<div class="pop-wrap">
				<iframe id="viewer" src="" style="width: 100%;height: 75vh;margin-top:15px;"></iframe>
<!-- 				<br><br><br> -->
<!-- 				<div class="pop-cts"> -->
<!-- 					<div class="btn-wrap" style = "margin-top:-10px;"> -->
<!-- 						<button type="button" name="button" class="btn-normal tooltip-close">닫기</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
				<!-- //e:con -->
				<button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="manual011-layer">닫기</button>
			</div>
		</div>
		<script>
			$(function(){
				//20211203 약관 PDF 적용 
				$(".contents").find(".agree-wrap").find("button").on("click", function (){
					var btnId = $(this).prev().attr("for");
					
// 					if( (btnId == "all-check") || (btnId == "all-ch-check") ||  (btnId == "all-md-check")){
					if( (btnId == "all-check") || (btnId == "all-ch-check") ){
						return;
					}
					
					if(!(btnId == 'importantdetail' || btnId == 'productdetail')){
						var value = $(this).val();
						var viewerElement = document.getElementById("viewer"); 
						var streamdocs = new StreamDocs({
							element : viewerElement,
						});
						
						$("#viewer").attr("src", streamdocsAdd);
						
						if(value !=""){
							streamdocs.document.open({ streamdocsId : value});	
							$('body').css("overflow","hidden");
						}/* else{
							customAlert({title : "알림" , message : "등록된 문서가 없습니다." }, function() {});	
						} */
					}else if(btnId == 'importantCheck'){
// 						importantCheck(showIndex);
					}
				});
			});
			
			function checkDuty(_this) {
				if(!$(_this).find('input[type=checkbox]').prop('checked')){
					var value = _this.nextElementSibling.value;
					var viewerElement = document.getElementById("dutyViewer"); 
					var streamdocs = new StreamDocs({
						element : viewerElement,
					});
					$("#dutyViewer").attr("src", streamdocsAdd);
					
					var btnId = $(_this).attr("for");
					checkArg = btnId == 'importantdetail' ? 'important' : 'prod';
					
					$('#agreeBtn').show();
					if(value !=""){
						streamdocs.document.open({ 
							streamdocsId : value
						}).then(function(){
							var cnt = 0;
							//페이지 1페이지로
							streamdocs.viewer.scrollTo({
								type:"PAGE",
								value:0
							});
							//pdf 페이지 수 가져오기
							streamdocs.document.getPageCount().then((result) => {
								cnt=result.pageCount;
								if(cnt > 1){
									//동의버튼 비활성화
									$('#agreeBtn').css('background-color', '#464646');
									$('#agreeBtn').css('border', '1px solid #464646');
									$('#agreeBtn').prop("disabled", true);
									$('#agreeBtn').html('아래로 이동');							
								}
								streamdocs.addEventListener('currentPageIndexChange', (event) => { 
									//마지막페이지에 도달 시 동의버튼 활성화
									if( (event.data.currentPageIndex+1) == cnt ){
										$('#agreeBtn').css('background-color', '#DC0082');
										$('#agreeBtn').css('border', '1px solid #DC0082');
										$('#agreeBtn').prop("disabled", false);
										$('#agreeBtn').val('Y');
										$('#agreeBtn').html('동의');
									}
								});
							});
							
						});
						$('body').css("overflow","hidden");
						openPopup('manualLayer012');
					}
					
					/* else{
						customAlert({title : "알림" , message : "등록된 문서가 없습니다." }, function() {});	
					} */
				}else{
					if(checkArg == 'important'){
						isImportantCheck = false;
						$('#'+_this.lastElementChild.id).prop('checked', false);
						$('#'+_this.lastElementChild.id).parent().removeClass('c-on');
					}else if(checkArg == 'prod'){
						isProdCheck = false;
						$('#'+_this.lastElementChild.id).prop('checked', false);
						$('#'+_this.lastElementChild.id).parent().removeClass('c-on');
					}
				}
			}
			
			function importantAgree(_this) {
				var value = _this.value;
				
				if(value == 'Y'){
					if(checkArg == 'important'){
						isImportantCheck = true;
						$('#importantdetail').prop('checked', true);
						$('#importantdetail').parent().addClass('c-on');
					}else if(checkArg == 'prod'){
						isProdCheck = true;
						$('#productdetail').prop('checked', true);
						$('#productdetail').parent().addClass('c-on');
					}
					closePdf('manualLayer012');
				}
			}
			
			function closePdf(_target){
				closePopup(_target);
			}
			
			function openDetail(_this){
				var value = _this.value;
				var viewerElement = document.getElementById("dutyViewer"); 
				var streamdocs = new StreamDocs({
					element : viewerElement,
				});
				$("#dutyViewer").attr("src", streamdocsAdd);
				$('#agreeBtn').hide();
				streamdocs.document.open({ 
					streamdocsId : value
				}).then(function(){
					var cnt = 0;
					//페이지 1페이지로
					streamdocs.viewer.scrollTo({
						type:"PAGE",
						value:0
					});
					
				});
				$('body').css("overflow","hidden");
				openPopup('manualLayer012');
			}
		</script>
        <!-- //e:카카오페이인증 확인 레이어팝업  -->
        <!-- s:상품설명서 레이어팝업 -->
        <!-- 상품설명서 -->
<%--         <%@ include file="include/productAgreementLayer.jsp" %> --%>
        <!-- //e:상품설명서 -->
        <!-- 약관동의서 -->
<%--         <%@ include file="include/agreementLayer.jsp" %> --%>
        <!-- //e:약관동의서 -->
        <!-- 180425 전체 레이어팝업 추가 -->
        <!-- s:전체 레이어팝업 -->
<%--         <%@ include file="include/agreementallLayer.jsp" %> --%>
        <!-- //e:전체 레이어팝업 -->
        <!-- // 180425 전체 레이어팝업 추가 -->
        <!-- ********** Include ********** -->
        <%@ include file="../include/inc_body_end.jspf" %>
        <!-- ********** //Include ********** -->
    <!-- //e:wrap -->
</html>
