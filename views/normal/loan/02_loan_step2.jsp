<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<%-- 페이징 완료페이지 --%>
<c:set var="complete" value="/${dsrId }/loan/02_loan_comp"/>
<c:set var="home" value="/${dsrId }" />
<%-- <c:set var="limitFail" value="/${dsrId }/loan/limit_fail" /> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/inc_header.jspf" %>
<%@ include file="../../include/loan/loan_nfilter.jsp" %>
<%@ include file="../../include/loan/loan2.jspf" %>
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
/* #limit_list table td{border:1px solid #b3bbc0;padding:7px 10px; border-left:0px; border-right:0px;} */
.chk_td {text-align:center;vertical-align:middle;}
/* #limit_list table th{color:#333333;font-weight:bold; border:1px solid #b3bbc0;padding:7px 10px; border-left:0px; border-right:0px;} */

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
	
	function next() {
    	// 사용자 정보 및 약관정보 처리 시작.
		loading();
		
		$('.warning').removeClass('warning');
		
		//상담사 실명확인 목록 20210420 테스트 종료시 해제
		
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
		
		//적합성 적정성 확인 20210420 테스트 종료시 해제
		if(!setCustTermsFormData()){
			removeLoading();
			return;
		}
		
		//2021.09.14 가계대출상품설명서 약관 체크
		if(!checkReqTerms()){
			removeLoading();
			return;
		}
		
		if(!impotantValidation()){
			customAlert({title : "알림" , message : "금융상품 중요사항 안내 항목을 체크해주세요." }, function() {
				removeLoading();
				$( "#importantdetail" ).focus();
			});
			return;
		}
		
		//2022.03.31 파라미터 설정
		valueSetting();
		
		init_form_data();
    	
    	if(!validate_form(commonProductForm)) {
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
    	
		validate_product(function(){
			removeLoading();
			loading();
			if(!validate_topTerms()){
				return;
			}
			if(!validate_terms()) {
				return;
			}
			
			loan_request_form(function() {
				
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
			//forms_by_product_code();
		}else {
			//if(hetsal_option) {
			//	$('#hetsal_option').prop('selected', true);
			//}
			//$('#prod_cd').val('${userInfo.PROD_CD}');
			//$('#prod_cd').change();
		}
		// 재직기간 0으로 표시되는 항목 수정.
   		//$('#job_join_day').trigger('keyup');
   		selectWidth();
	}
	
	$(function() {
		streamdocsAdd =  '<spring:eval expression="@prop.getProperty('streamDocs.url')" />';
        complete_product_list_loading();
        prod_change();
	});
	
	 //레이어팝업 라디오박스
	 function termsRadioChangeEvent(na,lab){
		 var radioNm ;
		 var radioId_1 ;
		 var radioId_2 ;
		 var chkVal ;
		 var codeI= na;
		
		 var textVal= "국세체납정보, (담보대출) 담보물권 정보";
		 
	 		if(codeI != undefined && codeI !=''){
				radioNm = codeI+"_1_1";
				radioId_1 = codeI+"_2_1";
				radioId_2 = codeI+"_2_2";
			 	
				$("#agreement6Layer").find(".agree-wrap").find(".agreement").find("#changeTextVal").text(textVal);
				
				if(na == "T000800015"){//20210811 필수약관 변경
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
						}/* else if(codeI == 'T000800015'){
							$("#THIRD_AGR_DTL_YN").val(chkVal);
						} */
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
				}/* else if(codeI == 'T000800015'){
					$("#THIRD_AGR_DTL_YN").val(chkVal);
				} */
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
            <div class="contents default-wrap">
                <div class="loan-wrap">
                    <div class="content1" id="loan_input">
                        <form id="frm1" name="frm1">
				            <input type="hidden" name="phone_no" id="phone_no" value="" />
				            <input type="hidden" name="prod_category_cd" id="prod_category_cd" value="" />
				            <input type="hidden" id="prod_nm" name="prod_nm" value="" />
				            <input type="hidden" name="encData" id="encData" />
				            
				            
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
			            	<input type="hidden" name="retailYn" id="retailYn" value="Y">
                        <div class="step-wrap mb60">
                            <ul>
                            	<li class="step02 active"><span>01<strong>신청정보 입력</strong></span></li>
                        		<li class="step02"><span>02<strong>대출신청 완료</strong></span></li>
                            </ul>
                        </div>
                        <h3 class="tit">대출신청 정보입력</h3>
                        <div class="prod_cd_fc"></div>
                       	<div class="telecom_fc"></div>
                       	<div class="phone_no_fc"></div>
                       	
                       	<div class="grid2 mb30">
                            <div class="form-wrap" >
                                <p class="input-tit font13 color-351B6F">대출상품</p>
                                <div class="select-wrap">
                                    <select name="prod_cd" id="prod_cd" class="loan-product">
                                        <!--  <option value="" >선택</option> -->
                                         <c:forEach var="item" items="${productList }">
                                         	<c:if test="${item.NTREE_PROD_CODE ne 'GL094'}">
		                                     	<option  value="${item.NTREE_PROD_CODE }">${item.NAME }</option>
                                         	</c:if>
                                         </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                       	
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
                        <div class="residence_own_cd_fc"></div>

                        <div class="residence_cd_fc"></div>
                        <div class="car_own_cd_fc"></div>
                        <div class="mrgg_tp_cd_fc"></div>
                        
                        <div class="article-con">
							
							<div class="grid1 mb30">
							    <div class="form-wrap" id="div_mrgg_tp_cd">
							        <p class="input-tit font13 color-351B6F">담보종류</p>
							        <div class="inradio">
							        	<c:forEach var="item" items="${mrgg_tp_cd }" varStatus="status">
	                                        <label for="mrgg_tp_cd_${status.count}" class="radio"><input type="radio" name="mrgg_tp_cd" id="mrgg_tp_cd_${status.count}" value="${item.code }">${item.name }</label>
							    		</c:forEach>
							    	</div>
							    </div>
							</div>
							<div class="grid2 mb30">
							    <div class="form-wrap" style="display: block;">
						        	<label for="loan_tp_cd" class="inp-tit req">대출구분</label>
							       	<div class="select-wrap">
							           <select name="loan_tp_cd" id="loan_tp_cd" title="대출구분 선택">
							                <option value="">대출구분을 선택하세요.</option>
							                <c:forEach var="item" items="${loanTpList }">
                                            	<option  value="${item.code }">${item.name }</option>
                                        	</c:forEach>
							            </select>
							        </div>
							    </div>
							    <div class="form-wrap" style="display: block;">
							        <label for="mod_tp_cd" class="inp-tit req">기기모델</label>
							        <div class="select-wrap">
							            <select name="mod_tp_cd" id="mod_tp_cd"  title="기기모델 선택">
							                <option value="">기기모델을 선택하세요.</option>
							                 <c:forEach var="item" items="${modTpList }">
                                            	<option  value="${item.code }">${item.name }</option>
                                        	</c:forEach>
							            </select>
							        </div>
							    </div>
							</div>
							<div class="grid2 mb30">
							    <div class="form-wrap">
							        <p class="input-tit font13 color-351B6F">대출신청금액</p>
							        <input type="hidden" name="req_amt" id="req_amt" value="">
							        <input type="text" class="req_amt_format" id="req_amt_format" value="" placeholder="만원 단위로 입력하세요" title="대출신청금액">
							        <div id="req_amt_unit" class="unit-txt">만원</div>
							    </div>
							    <div class="form-wrap" style="display: block;">
							        <label for="qnt" class="inp-tit req font13 color-351B6F">수량</label>
							        <input type="text" class="incom_annual_format" name="qnt" id="qnt" value="" title="수량">
							    </div>
							</div>
							
							<div class="grid2 address-area ">
								<div class="form-wrap">
                                    <span class="inp-tit req font13 color-351B6F" id="loan_zip_code">주소</span>
									<div class="zipcode">
										<!--s : 20180724 pm - label태그 추가, hide 클래스 추가 -->
                                        <label for="address-code" class="hide">우편번호</label>
                                        <!--//e : 20180724 pm - label태그 추가, hide 클래스 추가 -->
										<input type="text" name="zip_code" value="" id="zip_code" placeholder="우편번호를 입력하세요" readonly="readonly"  title="우편번호 입력">
										<a href="#" class="btn-normal form" title="새창 열림" id="find_zip_code">우편번호 찾기</a>
									</div>
								</div>
							</div>
							<div class="grid2 address-detail mb30">
								<div class="form-wrap">
									<input type="text" name="addr" value="" id="address_detail" placeholder="주소를 입력하세요" title="주소" readonly="readonly">
								</div>
								<div class="form-wrap">
									<input type="text" name="addr_detail" value="" id="address_detail1" placeholder="상세주소를 직접 입력하세요" title="주소 - 상세주소">
								</div>
							</div>
							
							<div class="grid1">
							    <div class="form-wrap" style="display: block;">
							    	<label for="comnt" class="inp-tit req font13 color-351B6F">비고</label>
							        <textarea name="comnt" rows="6" id="comnt" placeholder="내용을 입력해주세요"></textarea>
							    </div>
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
		                                    <span class="con fl-l">
		                                        대출계약을 체결하기 전에 대출상담사로부터 대출상품의 조건 및 대출내용 등에 관하여 충분한 설명을 받으셨나요? 대출계약 중요사항(금리, 대출금액, 대출기간, 중도상환수수료 등)에 대한 설명 포함
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree11" class="radio r-on"><input type="radio" name="desc-agree1" id="desc-agree11" value="Y">예</label>
		                                        <label for="desc-agree12" class="radio"><input type="radio" name="desc-agree1" id="desc-agree12" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con2" class="category fl-l">Q</span>
		                                    <span class="con fl-l">
		                                        대출상담사로부터 대출모집인은 금융회사의 업무위탁을 받아 대출모집 및 소개등의 섭외 활동을 한다는 사실에 대하여 사전에 고지 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree21" class="radio r-on"><input type="radio" name="desc-agree2" id="desc-agree21" value="Y">예</label>
		                                        <label for="desc-agree22" class="radio"><input type="radio" name="desc-agree2" id="desc-agree22" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con3" class="category fl-l">Q</span>
		                                    <span class="con fl-l">
		                                        대출모집상담사로부터 고객에게 별도의 수수료를 요구하거나 수취할 수 없다는 사실에 대하여 사전에 고지 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree31" class="radio r-on"><input type="radio" name="desc-agree3" id="desc-agree31" value="Y">예</label>
		                                        <label for="desc-agree32" class="radio"><input type="radio" name="desc-agree3" id="desc-agree32" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con4" class="category fl-l">Q</span>
		                                    <span class="con fl-l">
		                                        대출상담사로부터 여신심사 등을 통한 대출실행의 결정은 금융회사가 한다는 사실에 대하여 사전에 고지 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree41" class="radio r-on"><input type="radio" name="desc-agree4" id="desc-agree41" value="Y">예</label>
		                                        <label for="desc-agree42" class="radio"><input type="radio" name="desc-agree4" id="desc-agree42" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con5" class="category fl-l">Q</span>
		                                    <span class="con fl-l">
		                                        대출상담사로부터 귀하의 소득재산, 부채상환, 신용 및 변제계획 등을 고려하여 적합한 대출상품을 권유 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree51" class="radio r-on"><input type="radio" name="desc-agree5" id="desc-agree51" value="Y">예</label>
		                                        <label for="desc-agree52" class="radio"><input type="radio" name="desc-agree5" id="desc-agree52" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con6" class="category fl-l">Q</span>
		                                    <span class="con fl-l">
		                                        대출상담사로부터 귀하가 필요한 자금의 범위를 초과하여 대출을 받도록 권유 또는 유도 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree61" class="radio r-on"><input type="radio" name="desc-agree6" id="desc-agree61" value="Y">예</label>
		                                        <label for="desc-agree62" class="radio"><input type="radio" name="desc-agree6" id="desc-agree62" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <li class="question-wrap">
		                                    <span id="con7" class="category fl-l">Q</span>
		                                    <span class="con fl-l">
		                                        대출상담사로부터 귀하가 원하지 않는 고금리 대출로 변경하도록 권유 또는 유도 받으셨나요?
		                                    </span>
		                                    <span class="radio-wrap fl-r">
		                                        <label for="desc-agree71" class="radio r-on"><input type="radio" name="desc-agree7" id="desc-agree71" value="Y">예</label>
		                                        <label for="desc-agree72" class="radio"><input type="radio" name="desc-agree7" id="desc-agree72" value="N">아니오</label>
		                                    </span>
		                                </li>
		                                <!-- TODO 180424 추가 -->
		                                <li class="question-wrap">
		                                    <span id="con8" class="category fl-l">Q</span>
		                                    <span class="con fl-l pt10 d-inline-b">
		                                        대출 상담을 받은 모집상담사 이름은 무엇인가요?
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
		                        <%@ include file="../loan/include/inc_terms2.jspf" %>
		                    </div>
		                </div>
                        
                        <form id="frm_terms">
                        <p class="font20 color-333333 ta-c mb20">대출신청을 위한 약관에 동의하시겠습니까?</p>
                        <div id="terms_focus"></div>
                         <input type="hidden" id="terms_prod_cd" name="terms_prod_cd"  value="">
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
							
							<!-- 2023-11-21 온라인 설명의무 -->
							<dl>
								<dd id="T000800025" style="margin-left: 0px !important;">
									<label for="importantdetail" class="check2" style="font-weight:bold;"><input type="checkbox" id="importantdetail" value="" onclick="fn_DivMainOpen();" >(필수)금융상품 중요사항 안내(유의사항 포함)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" title="중요사항안내 확인하기" onclick="fn_DivMainOpen()">자세히보기</button>
								</dd>
						        <%@ include file="./include/inc_loan_important.jsp" %>
								
								<dd id="N000805001" style="margin-left: 0px !important;">
                                    <label for="retaildetail" class="check2" onclick="checkDuty(this);"  style="font-weight:bold;"><input type="checkbox" id="retaildetail" value="">(필수)기업대출상품설명서 확인하기</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual012-layer" title="상품설명서 확인하기" onclick="openDetail(this);">자세히보기</button>
                                    
                                    <div class="subcheck-area add_class2">
                                    	<div class="sub-box">
                                        	<p class="check-tit"><label for="prod_terms_agree0" class="check"><input type="checkbox" name="prod_terms_agree0" id="prod_terms_agree0" value="" disabled="disabled">금리인하요구권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                       		<div style="margin-top:20px;">
                                       			<p class="check-tit">대출거절사유 고지신청서 <br>
	                                        		<span class="radio-wrap fl-l" style="height: 20px;">
				                                        <label for="prod_terms_agree4_1" class="radio"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_1" value="Y">신청</label>
				                                        <label for="prod_terms_agree4_2" class="radio r-on"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_2" value="N" checked>신청하지 않음</label>
				                                    </span>
	                                        	</p>
                                       		</div>
                                        	<br>
	                                    </div>
                                    </div>
                                </dd>
							</dl>
                            <dl>
                                <dt>
                                	<label id="all-check-lb" for="all-check" class="check" style="font-weight:bold;"><input type="checkbox" id="all-check" value="">다음의 필수약관에 모두 동의합니다.</label>
                                    <button type="button" name="button" class="btn-normal tiny done hide" data-tooltip="agreementall-layer" title="전체약관 자세히보기" tabindex="-1">자세히보기</button>
                                </dt>
                                <dd id="T000800001">
                                    <label for="agree-check1" class="check"><input type="checkbox" name="terms_agreement_1" id="agree-check1" value="" onclick="javascript:termsRadioChangeEvent('T000800001','lab');">(필수)개인(신용)정보 조회동의서</label>
                                    <button type="button" name="button" class="btn-normal tiny " data-tooltip="manual011-layer" title="(필수)개인(신용)정보 조회동의서 자세히보기"  onclick="javascript:termsRadioChangeEvent('T000800001');">자세히보기</button> 
                                </dd>
                                <dd id="T000800006">
                                    <label for="agree-check2" class="check"><input type="checkbox" name="terms_agreement_2" id="agree-check2" value="" >(필수)개인(신용)정보 조회동의서(서민금융진흥원)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)개인(신용)정보 조회동의서(서민금융진흥원) 자세히보기">자세히보기</button>
                                </dd>
                                <dd id="T000800007">
                                    <label for="agree-check3" class="check"><input type="checkbox" name="terms_agreement_3" id="agree-check3" value="" >(필수)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(서민금융진흥원)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(서민금융진흥원) 자세히보기">자세히보기</button>
                                </dd>
                                <!-- <dd>
                                    <label for="agree-check12" class="check"><input type="checkbox" name="terms_agreement_12" id="agree-check12" value="" >(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(서민금융진흥원)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="agreement12-layer" title="(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(서민금융진흥원) 자세히보기">자세히보기</button>
                                    <div class="subcheck-area" id="agree31_sub">
	                                    <div class="sub-box">
                                            <p class="check-tit" style="font-weight:normal"><label for="agree33" class="check">
                                            	<input type="checkbox" id="agree33" name="agree33" value="" >위 목적으로 본인의 [선택적 정보]를 수집.이용하는것에 동의합니다.</label>
                                            </p>
                                            <p class="check-tit" style="font-weight:normal"><label for="agree34" class="check">
                                            	<input type="checkbox" id="agree34" name="agree34" value="" >서민금융상품.서비스안내, 홍보 등의 목적으로 개인(신용)정보를 수집.이용하는것에 동의합니다.</label>
                                            </p>
                                            <p class="check-tit" style="font-weight:normal"><label for="agree35" class="check">
                                            	<input type="checkbox" id="agree35" name="agree35" value="" >서민금융상품.서비스안내,홍보 등의 목적으로 개인(신용)정보를 제공하는것에 동의합니다.</label>
                                            </p>
	                                    </div>
                                    </div>
                                </dd> -->
                                <dd id="T000800008">
                                    <label for="agree-check4" class="check"><input type="checkbox" name="terms_agreement_4" id="agree-check4" value="" >(필수)개인(신용)정보 및 기업(신용)정보 조회․수집·이용·제공과 행정정보공동이용, 전자금융거래확인서 발급을 위한 동의서</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)개인(신용)정보 및 기업(신용)정보 수집·이용·제공과 행정정보공동이용, 전자금융거래확인서 발급을 위한 동의서 자세히보기">자세히보기</button>
                                </dd>
                                <dd id="T000800002">
                                    <label for="agree-check6" class="check"><input type="checkbox" name="terms_agreement_6" id="agree-check6" value=""  onclick="javascript:termsRadioChangeEvent('T000800002','lab');">(필수)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(여신금융거래)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)개인(신용)정보 수집·이용·제공 동의서(여신금융거래)" onclick="javascript:termsRadioChangeEvent('T000800002');">자세히보기</button>
                                </dd>
                                <dd id="T000800009">
                                    <label for="agree-check8" class="check"><input type="checkbox" name="terms_agreement_8" id="agree-check8" value="" >(필수)계약 체결·이행 등을 위한 필수 동의서 (개인금융성 신용보험용)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(필수)계약 체결·이행 등을 위한 필수 동의서 (개인금융성 신용보험용) 자세히보기">자세히보기</button>
                                </dd>
                                
                                
                                <!-- <dd id="N000805001">
                                    <label for="retaildetail" class="check"><input type="checkbox" id="retaildetail" value="">(필수)기업대출상품설명서 확인하기</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="상품설명서 확인하기">자세히보기</button>
                                    
                                    <div class="subcheck-area add_class2">
                                    	<div class="sub-box">
                                        	<p class="check-tit"><label for="prod_terms_agree0" class="check"><input type="checkbox" name="prod_terms_agree0" id="prod_terms_agree0" value="" disabled="disabled">금리인하요구권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	2021.09.14
                                        	<p class="check-tit"><label for="prod_terms_agree1" class="check"><input type="checkbox" name="prod_terms_agree1" id="prod_terms_agree1" value="" disabled="disabled">청약철회권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	<p class="check-tit"><label for="prod_terms_agree2" class="check"><input type="checkbox" name="prod_terms_agree2" id="prod_terms_agree2" value="" disabled="disabled">위법계약해지권에 대한 상기의 설명을 확인하였습니다.</label></p>
                                        	<p class="check-tit"><label for="prod_terms_agree6" class="check"><input type="checkbox" name="prod_terms_agree6" id="prod_terms_agree6" value="" disabled="disabled">자료열람요구권에 대한 상기의 설명을 확인하였습니다.</label></p>
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
				                                        <label for="prod_terms_agree4_2" class="radio r-on"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_2" value="N" checked>신청하지 않음</label>
				                                    </span>
	                                        	</p>
                                       		</div>
                                        	<br>
	                                    </div>
                                    </div>
                                </dd> -->
                                <dd id="sunshinedetail1">
                                    <label for="sunshinedetail" class="check"><input type="checkbox" id="sunshinedetail" value="">(필수)가계대출상품설명서 확인하기</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="햇살론 상품설명서 확인하기">자세히보기</button>
                                </dd>
	                            <dd id="saitdoldetail1">
		                            <label for="saitdoldetail" class="check"><input type="checkbox" id="saitdoldetail" value="">(필수)가계대출상품설명서 확인하기</label>
		                            <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="상품설명서 확인하기">자세히보기</button>
	                            </dd>
	                            <dd id="T000800015">
									<label for="agree-check13" class="check"><input type="checkbox" name="terms_agreement_13" id="agree-check13" value="" onclick="javascript:termsRadioChangeEvent('T000800015','lab');">(필수)개인(신용)정보 제3자 제공동의서(동산 담보대출, 부동산 담보대출)</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="개인(신용)정보 제3자 제공동의서(추가동의사항)" onclick="javascript:termsRadioChangeEvent('T000800015');">자세히보기</button>
								</dd>
								<dd id="T000800010">
									<label for="agree-check11" class="check"><input type="checkbox" name="terms_agreement_11" id="agree-check11" value="" >(필수)CMS 출금이체 동의</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="CMS 출금이체 동의">자세히보기</button>
								</dd>
								<!-- //180612 약관추가 -->
                                <dd>
                                	<hr class="line mt20">
                                </dd>
                                <dd class="mt20">
                                </dd>
                             </dl>
                             <dl>
                              	<dt>
                                	<label id="all-ch-check-lb" for="all-ch-check" class="check" style="font-weight:bold;"><input type="checkbox" id="all-ch-check" value="">다음의 선택약관에 모두 동의합니다.</label>
                                    <button type="button" name="button" class="btn-normal tiny done hide" data-tooltip="agreementChall-layer" title="전체약관 자세히보기" tabindex="-1">자세히보기</button>
                                </dt>
                                <dd id="T000800003">
                                    <label for="agree-check5" class="check"><input type="checkbox" id="agree-check5" value=""  onclick="javascript:termsRadioChangeEvent('T000800003','lab');">(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(상품서비스 안내 등)</label>
                                    <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(상품서비스 안내 등) 자세히보기" onclick="javascript:termsRadioChangeEvent('T000800003');">자세히보기</button>
                                    <div class="subcheck-area add_class1">
                                    	<div class="sub-box">
                                    		<label for="apply_yn_agree" class="check" style="font-weight:bold;"><input type="checkbox" name="apply_yn_agree" id="apply_yn_agree" value="" >위 개인(신용)정보 수집·이용에 동의하십니까? &nbsp;&nbsp;<img style="width:30px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_1.gif" alt="수집, 이용에 관한사항  평가등급 보통"/></label>
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
                                            	<input type="checkbox" id="marketing_apply_yn_agree" name="marketing_apply_yn_agree" value="" >위 개인신용정보 제공에 동의하십니까? &nbsp;&nbsp;<img style="width:60px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_3.jpg" alt="제공에 관한 사항 평가등급 다소안심"/></label>
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
								<dd id="T000800011">
									<label for="agree-check9" class="check"><input type="checkbox" name="terms_agreement_9" id="agree-check9" value="" >(선택)대출거절사유 고지에 관한 사항</label>
									<button type="button" name="button" class="btn-normal tiny agree-wrap-btn" data-tooltip="manual011-layer" title="(선택)대출거절사유 고지에 관한 사항 자세히보기">자세히보기</button>
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
                            </dl>
                            <%-- 상품설명서 확인여부. --%>
                           	<input type="hidden" name="terms_agreement_detail" value="Y"/>
			            
			            	<input type="hidden" name="CRDT_AGR_DTL_YN" id="CRDT_AGR_DTL_YN"><!-- 개인(신용)정보 조회 동의서 상세여부 -->
							<input type="hidden" name="PROD_AGR_DTL_YN" id="PROD_AGR_DTL_YN"><!-- 개인(신용)정보 수집·이용·제공 동의서(여신 금융 거래) 상세여부 -->
							<input type="hidden" name="SRVC_AGR_DTL_YN" id="SRVC_AGR_DTL_YN"><!-- 개인(신용)정보 수집·이용·제공 동의서(상품서비스 안내) 상세여부 -->
					      	<input type="hidden" name="THIRD_AGR_DTL_YN" id="THIRD_AGR_DTL_YN"><!-- 개인(신용)정보 제3자 제공동의서[동산담보대출] -->
							
							<!-- 2021.09.29 상품설명서 동의여부 -->
							<input type="hidden" name="PRODUCT_DESC_YN" id="PRODUCT_DESC_YN">
							
							<!-- 2022.03.31 개인(신용)정보 수집·이용·제공 동의서 (맞춤형 정보제공) 상세여부 -->
							<input type="hidden" name="SRVC_PRVD_AGR_DTL_YN" id="SRVC_PRVD_AGR_DTL_YN" value = 'N'>
							<!-- 2022.03.31  개인(신용)정보 수집·이용·제공 동의서 (맞춤형 정보제공) -->
							<input type="hidden" name="PRODUCT_SERVICE_PROVIDE_YN" id="PRODUCT_SERVICE_PROVIDE_YN">
							
                        </div>
                        </form>
                        <p class="font12 color-626C74 mb30">
                            ※ 고객님께서 입력하신 개인정보는 대출신청 완료 후 수집됩니다.<br> ※ 대출신청하기 클릭 시 본인인증팝업으로 넘어갑니다.
                        </p>
                        <p class="ta-c">
                            <button type="button" name="button" class="btn-big pink" onclick="next()">다음단계</button>
                            <button type="button" name="button" class="btn-big re ir" onclick="location.href='<c:url value="${home}"/>'">이전페이지로</button>
                        </p>
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
            <div class="con">
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
                <c:if test="${certYn eq 'Y' }">
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
                </c:if>
                <%-- <c:if test="${kakaoYn eq 'Y' }">
                    <li class="auth4">
                        <a href="#" onclick="auth_kakao('kakaoLayer')">
                            <p>카카오페이인증</p>
                        </a>
                    </li>
                </c:if> --%>
                <c:if test="${creditCardYn eq 'Y' }">
                    <li class="auth5">
                        <a href="#" onclick="auth_nice_credit_card()">
                            <p>신용카드인증</p>
                        </a>
                    </li>
                </c:if>
                </ul>
                <form id="delfinoForm" name="delfinoForm" method="post">
			        <input type="hidden" name="PKCS7" value=""/>
			        <input type="hidden" name="VID_RANDOM" value=""/>
			    </form>
            </div>
            <!-- //e:con -->
            <button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="desc-layer">닫기</button>
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
		<script>
			$(function(){
				//20211203 약관 PDF 적용 
				$(".contents").find(".agree-wrap").find("button").on("click", function (){
					var btnId = $(this).prev().attr("for");
					
					if( (btnId == "all-check") || (btnId == "all-ch-check") ){
						return;
					}
					
					if(!(btnId == 'importantdetail' || btnId == 'retaildetail')){
						var value = $(this).val();
						var viewerElement = document.getElementById("viewer"); 
						var streamdocs = new StreamDocs({
							element : viewerElement,
						});
						console.log(streamdocs);
						$("#viewer").attr("src", streamdocsAdd);
						
						if(value !=""){
							streamdocs.document.open({ streamdocsId : value});	
						}/* else{
							customAlert({title : "알림" , message : "등록된 문서가 없습니다." }, function() {});	
						} */
					}else if(btnId == 'importantCheck'){
// 						importantCheck(showIndex);
					}
				});
			});
			
			//pdf 방식 >> html방식으로 변경해서 안쓰임
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
						$('#retaildetail').prop('checked', true);
						$('#retaildetail').parent().addClass('c-on');
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
<%--          <%@ include file="include/agreementRetallLayer.jsp" %> --%>
        <!-- //e:전체 레이어팝업 -->
        <!-- // 180425 전체 레이어팝업 추가 -->
        <!-- ********** Include ********** -->
        <%@ include file="../include/inc_body_end.jspf" %>
        <!-- ********** //Include ********** -->
    <!-- //e:wrap -->
    
   
</html>
