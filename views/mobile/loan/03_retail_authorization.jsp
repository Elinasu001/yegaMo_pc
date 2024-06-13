<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %> 
<%@page import="com.wizvera.service.SignVerifier"%>
<c:set var="complete" value="/${dsrId }/loan/04_retail_completed" />
<c:set var="limitFail" value="/${dsrId }/loan/limit_fail" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="../include/inc_header.jspf" %>
</head>
<%@ include file="../include/inc_body_start.jspf" %>
<%@include file="include/delfino.jsp" %>
<%-- <%@ include file="../../include/loan/loan2.jspf" %> --%>
<%@ include file="../../mobile/include/loan2.jspf" %>
<style type="text/css">
/******** table ********/
.table-wrap .table-style { margin-top:45px; }
.table-wrap .table-style:first-child { margin-top:0; }
.table-style { border-bottom:1px solid #ccc; }
.table-style tbody { background:#fff; }
.table-style thead th { /*font-size:1.6rem; line-height:2rem;*/ }
.table-style th, .table-style td { padding:12px 5px; color:#626C74; text-align:left; }
.table-style tbody tr:first-child th, .table-style tbody tr:first-child td { border-top:1px solid #495057; }
.table-style tbody th, .table-style tbody td, .table-style tfoot th, .table-style tfoot td { border-top:1px solid #ccc; font-size:1.4rem; line-height:1.8rem; vertical-align:middle; }
.table-style td a { color:#626C74; }
.table-style thead + tbody th { font-weight:normal; }
.tbl-txt { overflow:hidden; margin-top:5px; font-size:1.2rem; line-height:1.6rem; letter-spacing:-0.7px; text-align:left;  clear: both; }
.tbl-txt span { float:right; text-align:right; }
.table-style .nodata { padding:10px 0; text-align:center; }
.table-style.caption-tit caption { width:auto; height:auto; text-indent:0; position:inherit; left: inherit; margin-bottom:10px; font-size:1.8rem; color:#333; line-height:2.6rem; text-align:left; letter-spacing:-1px; }

.table-style.all-c th, .table-style.all-c td { text-align:center; vertical-align:middle }
.table-style.th-c th { text-align:center; vertical-align:middle; }
.table-style.th-l tbody th { text-align:left; vertical-align:middle; }
.table-style.th-vc tbody th { vertical-align:middle; }
.table-style.td-c td { text-align:center; }
.table-style.td-r td { text-align:right; }

.table-tit { margin-bottom:15px; font-size:1.8rem; letter-spacing:-0.08em; text-align:left; }
.table-scroll { width:100%; overflow-x:auto; }
.table-scroll .table-style { table-layout:auto; font-size:1.4rem; }
.table-scroll + .table-tit, .tbl-txt + .table-tit, .tbl-txt + .table-scroll, .table-scroll + .table-scroll { margin-top:45px; }
.table-fixed { width:120px; overflow-x:hidden; float:left; }
.table-scroll.with { width:calc(100% - 120px); overflow-x:auto; float:left; }
.table-scroll.with .table-style {  width: 300% !important; }
.table-scroll.with .table-style.w350 {  width: 350% !important; }
.table-scroll.with .table-style.w400 {  width: 400% !important; }
.table-scroll.with .table-style.w500 {  width: 500% !important; }
.table-scroll.with .table-style.w600 {  width: 600% !important; }
.table-fixed .big th, .table-scroll.with .big th { color:#000; font-weight:bold; border-bottom: 1px solid #495057; }
.table-fixed thead .rowspan2{ height:84px; }
.table-scroll tbody  .rowspan2 ,.table-scroll tfoot  .rowspan2 { height:61px; }
.table-scroll tbody  .rowspan3 ,.table-scroll tfoot  .rowspan3 { height:79px; }
.table-scroll tbody  .rowspan4 ,.table-scroll tfoot  .rowspan4 { height:97px; }
.table-fixed  thead th, .table-fixed  thead td, .table-fixed  tbody th, .table-fixed  tbody td, .table-fixed  tfoot th, .table-fixed  tfoot td { letter-spacing:-2px; }


/******** list ********/
.list.type1 { padding-left:5px; }
.list.type1 li { position:relative; padding:0 10px; color:#495057; font-size:1.4rem; line-height:2.2rem; }
.list.type1 li:first-child { margin-top:0; }
.list.type1 li:before { position:absolute; left:0px; top:0px; content:"•"; }
.list.type1 li > span { display:block; font-weight:bold; }
.list.type1 li .bar { position:relative; padding-right:10px; margin-right:10px; }
.list.type1 li .bar:after { content:""; width:1px; height:10px; position:absolute; right:0; top:7px; background-color:#B3BBC0; }
.define-list { margin-left:5px; }
.define-list > li { margin-top:17px; }
.define-list > li:first-child { margin-top:0; }
.define-list .de-tit, .define-list .de-cts { position:relative; display:block; width:100%; margin-top:5px; line-height:1.5; }
.define-list .de-tit { padding-left:15px; font-weight:bold; }
.define-list .de-tit:before { position:absolute; left:0; top:0; content:"•"; }
.define-list .de-cts { padding-left:15px; }
.define-list .de-cts.in-tbl { margin-top:0; padding-left:0; }
.define-list .de-cts .tbl-info { margin-top:25px; }
.define-area {}
.define-area .info-txt { margin-top:25px; padding:0 12px; font-size:1.2rem; font-weight:bold; color:#626c74; }
.define-area .info-txt:first-child { margin-top:0; }
.define-area .info-txt + dl { margin-top:10px; }
.define-area dl { background:#fff; border-top:1px solid #495057; }
.define-area dt, .define-area dd { padding:0 16px; line-height:1.4; }
.define-area dt { padding-top:20px; font-weight:bold; }
.define-area dd { padding-top:5px; padding-bottom:20px; border-bottom:1px solid #ccc; }
.rice { position:relative; margin-top:5px; padding-left:15px; color:#626c74; font-size:1.2rem; line-height:1.6rem; letter-spacing:-0.7px; }
.rice:before { position:absolute; left:0px; top:0px; content:"※"; }
.rice + .rice { margin-top:0px; }
.star { position:relative; padding-left:10px; }
.star:before { position:absolute; left:0px; top:0px; content:"*"; }
.mark-kdic { margin-top:20px; }

.list.type2 > li { padding-left:9px; text-indent:-9px; }
.list.type2 li + li { margin-top:5px; }
.list.type2 li .rice { margin-left:12px; }
.list.type3 > li { padding-left:15px; text-indent:-15px; }
.list.type4 > li { padding-left:12px; text-indent:-12px; }

.list li > * { text-indent:initial; }

p.indent2 { display:block; padding-left:5px; text-indent:-5px; }
p.indent3 { display:block; padding-left:15px; text-indent:-15px; }
p.indent4 { display:block; padding-left:10px; text-indent:-10px; }

.sub-list { padding-left:10px; }
.sub-txt { padding-left:10px; text-indent:-10px !important; }

div.indent01, p.indent01, ul.indent01 li { padding-left:30px; text-indent:-17px; }
div.indent02, p.indent02, ul.indent02 li { padding-left:10px; text-indent:-10px; }
div.indent03, p.indent03, ul.indent03 li { padding-left:20px; }
div.indent04, p.indent04, ul.indent04 li { padding-left:15px; text-indent:-17px; }

.list-bul2 { position:relative; top:0; font-size:12px; color:#ec008c; font-family:'돋움'; font-weight:bold; }

#loan_list table tbody{border-top:1px solid #3d3d3d; border-bottom:1px solid #3d3d3d;}
#loan_list table td{color:#555; background-color:#fff;border:1px solid #b3bbc0;padding:10px 10px; border-left:0px; border-right:0px;}
.chk_td {text-align:center;vertical-align:middle;}
#loan_list table th{color:#555; background-color:#fff;font-weight:bold; border:1px solid #b3bbc0;padding:7px 10px; border-left:0px; border-right:0px;}

/* 대출신청 사전문진 */
.question-wrap .question-list { background:#fff; margin:20px 0;}
.question-wrap .question-list li { padding:30px 0 40px; border-top:2px solid #e6e6e6; }
.question-wrap .question-list li:first-child { border-top:none; }
.question-wrap .question-list span { display:inline-block; vertical-align:top; }
.question-wrap .question-list .num { width:36px; height:36px; border:1px solid #575e64; border-radius:50%; text-align:center; line-height:36px; z}
.question-wrap .question-list .cont { width:70%; margin-left:30px; }
.question-wrap .question-list .radio-area { margin:10px 10px; float:right;}
.question-wrap .question-list .warning .num { border:1px solid #DC0082; color:#DC0082; }
.question-wrap .question-list .warning .cont { color:#DC0082; }
.question-wrap .sign-area { margin-top:40px; text-align:center; }
.question-wrap .sign-area .sign-input { margin-top:25px; }
.question-wrap .sign-area .sign-input .date { margin-right:50px; }
.question-wrap .sign-area .sign-input input[type='text'] { width:260px; margin-left:15px; }

.agreementall-layer { padding: 20px 10px 10px 10px; height: auto !important; }
.manual-layer { padding: 70px 10px 10px 10px; } 
.agreementall-layer > .pop-wrap .all-agree { font-size: 2.0rem; color: #333; line-height: 3.4rem; letter-spacing: -2px; }
.layerpopup .btn-menu-close { background-size: contain; top: 11px;right: 13px;width: 25px;height: 25px;}
.agreementall-layer .ctrl-box { position: absolute;top: 11px;right: 50px; }
.agreementall-layer .ctrl-box button { background-size: contain;width: 25px;height: 25px; }
.agreementall-layer .ctrl-box button { margin: 0 3px; }

</style>
<script>
var isMobile=true;
var streamdocsAdd = "";
var isImportantCheck = false;
var isProdCheck = false;
var checkArg = '';

$(function() {
	//forms_by_product_code('GL999', 'GL999');
	streamdocsAdd =  '<spring:eval expression="@prop.getProperty('streamDocs.url')" />';
});
<%-- 인증별 함수 수행. --%>
function next() {
	
	valueSetting();
	
	if(!validate_terms()) {
		return;
	}
	if(!validate_topTerms()){
		return;
	}
	//2021.09.14 가계대출상품설명서 약관 체크
	if(!checkReqTerms()){
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
	
	//2021-12-28 본인인증 미선택 시 알람 호출
	if($('input[name=auth_type]:checked').val() == '' || $('input[name=auth_type]:checked').val() == null){
		customAlert({title : '안내', message : "본인인증 방법을 선택해주세요."});	
		return false;
	}
	loan_request_terms(function() {
		var authType = $('input[name=auth_type]:checked').val();
		
		if(authType == 'phone') {
			auth_nice_mobile();
		} else if(authType == 'delfino' || authType == 'fincert') {
			auth_cert(authType);
		} else if(authType == 'ipin') {
			auth_ipin();
		} else if(authType == 'kakao') {
			auth_kakao('kakaoLayer');
		} else if(authType == 'creditCard') {
			auth_nice_credit_card();
		}
	}, on_error);
}

//레이어팝업 라디오박스
function termsRadioChangeEvent(na){
	 var radioNm ;
	 var radioId_1 ;
	 var radioId_2 ;
	 var codeI ;
	 var chkVal ;
	 
	 var textVal= "국세체납정보, (담보대출) 담보물권 정보";
	 
	 if($("img[name=barImg]").css("width") =="500px"){
		 $("img[name=barImg]").css("width","280");
		 $("img[name=barImg]").css("float","left");
		 $("img[name=qrImg]").before("<br>");
	 }
	
		var dataTooltip = $(na).attr("data-tooltip");
		var layerId;
		if(dataTooltip == "agreement1-layer"){
			layerId = "agreement1Layer";
			radioNm = "T000800001_1_1";
			radioId_1 ="T000800001_2_1";
			radioId_2 ="T000800001_2_2";
			codeI = "T000800001";
		}else if(dataTooltip == "agreement6-layer"){
			layerId = "agreement6Layer";
			radioNm = "T000800002_1_1";
			radioId_1 = "T000800002_2_1";
			radioId_2 = "T000800002_2_2";
			codeI = "T000800002";
			$("#agreement6Layer").find(".T000800002").find(".T000800002_2").find("#changeTextVal").text(textVal);
		}else if(dataTooltip == "agreement5-layer"){
			layerId = "agreement5Layer";
			radioNm = "T000800003_1_1";
			radioId_1 = "T000800003_2_1";
			radioId_2 = "T000800003_2_2";
			codeI = "T000800003";
		}else if(dataTooltip == "agreement13-layer"){
			layerId = "agreement13Layer";
			radioNm = "T000800015_1_1";
			radioId_1 = "T000800015_2_1";
			radioId_2 = "T000800015_2_2";
			codeI = "T000800015";
		}else{
			layerId = '';
		}
		
		if(layerId != undefined && codeI !=''){
			
			$("#"+radioId_1+" ").parent().addClass("radio r-on");
			$("#"+radioId_2+" ").parent().addClass("radio");
			$("#"+radioId_1+" ").attr("checked","checked");
			
			$("input:radio[name='"+radioNm+"']").on("click", function(){
				
				if($("input:radio[name='"+radioNm+"']").is(':checked')){
					
					if($("#"+radioId_1+"").is(':checked')){
						$("#"+radioId_2+" ").parent().removeClass("r-on");
						$("#"+radioId_1+" ").parent().addClass("r-on");
						$("#"+radioId_2+" ").attr("checked","");
						$("#"+radioId_1+" ").attr("checked","checked");
					}else{
						
						$("#"+radioId_1+" ").parent().removeClass("r-on");
						$("#"+radioId_2+" ").parent().addClass("r-on");
						$("#"+radioId_1+" ").attr("checked","");
						$("#"+radioId_2+" ").attr("checked","checked");
						$("."+codeI+"_2"+"").css("display","block");
						$("."+codeI+"_1"+"").css("display","none");
						
					}
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
$(window).load(function(){
	$('#prod_cd').change();
});
</script>
<form id="delfinoForm" name="delfinoForm" method="post">
<input type="hidden" name="PKCS7" />
<input type="hidden" name="VID_RANDOM" />
<input type="hidden" name="certType" id = "certType" value=""/>
</form>
<%-- 약관 체크를 위함 --%>
<input type="hidden" id="prod_cd" value="${prod_cd}"/>	<%--  ${prod_cd} --%>
<%-- 약관체크 테스트 위함 --%>
<%-- <input type="hidden" id="prod_cd" value="GL094"/>${prod_cd} --%> 
<input type="hidden" id="prod_nm" value="${prod_nm }"/><%-- ${prod_nm} --%>
<input type="hidden" id="jsdsrCorpNm" value="${sDsrUser.CORP_NM }">
<input type="hidden" id="jsDsrUserNm" value="${sDsrUser.NAME }">  
	    <!-- s contentsWrap -->
	    <div id="contentsWrap">
	        <!-- s:contents -->
	        <div class="sub-contents default-wrap">
	        	<div class="loan-wrap">
	        		<ol class="loan-step clear mb30">
	        			<li class="step02">개인정보 및 대출정보입력</li>
	        			<li class="step03 on">약관동의 및 본인인증</li>
	        			<li class="step04">대출신청 완료</li>
	        		</ol>
					<form id="frm_terms">
					<h3 class="tit mt40">약관동의</h3>
					<div class="line-box">대출신청을 위한 약관에 동의하시겠습니까?</div>
					<div class = "agree-box">
						<dl class="agree-wrap mt30">
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
						<dd id="T000800025" style="margin-left: 0px !important;padding-left: 0px !important;">
							<label for="importantdetail" class="check2" style="font-weight:bold;"><input type="checkbox" id="importantdetail" value="" onclick="fn_DivMainOpen();" >(필수)금융상품 중요사항 안내(유의사항 포함)</label>
                            <button type="button" name="button" class="btn-normal tiny agree-wrap-btn" title="중요사항안내 확인하기" style="margin-left:25px;" onclick="fn_DivMainOpen()">자세히보기</button>
						</dd>
						<%@ include file="./include/inc_loan_important.jsp" %>
						<dd id="N000805001" style="margin-left: 0px !important;padding-left: 0px !important; margin-bottom:10px;]">
							<input type="hidden" name="terms_agreement_detail" value="Y"/>
					        <label for="retaildetail" class="check productdetail-default"  style="font-weight:bold;">
					        <input type="checkbox" id="retaildetail" value="">
					        <span>(필수)기업대출상품설명서</span>
				            <button class="btn-normal tiny detail-layer-popup" data-tooltip="manual011-layer" title="상품설명서 확인하기">자세히보기</button>
					        </label>
					        <div class="subcheck-area add_class2">
					        	<div class="sub-box">
					        		<p class="check-tit"><label for="prod_terms_agree0" class="check "><input type="checkbox" name="prod_terms_agree0" id="prod_terms_agree0" value="" disabled="disabled">금리인하요구권에 대한 상기의 설명을 확인하였습니다.</label></p>
					        		<!-- <p class="check-tit"><label for="prod_terms_agree1" class="check "><input type="checkbox" name="prod_terms_agree1" id="prod_terms_agree1" value="" disabled="disabled">청약철회권에 대한 상기의 설명을 확인하였습니다.</label></p>
					        		<p class="check-tit"><label for="prod_terms_agree2" class="check "><input type="checkbox" name="prod_terms_agree2" id="prod_terms_agree2" value="" disabled="disabled">위법계약해지권에 대한 상기의 설명을 확인하였습니다.</label></p>
					        		<p class="check-tit"><label for="prod_terms_agree6" class="check"><input type="checkbox" name="prod_terms_agree6" id="prod_terms_agree6" value="" disabled="disabled">자료열람요구권에 대한 상기의 설명을 확인하였습니다.</label></p> -->
					        		<!-- <div>
					        			<p class="check-tit">대출모집인 설명확인서</p>
										<p class="radio-area mt15">
											<label for="prod_terms_agree3_1" class="radio"><input type="radio" name="prod_terms_agree3" id="prod_terms_agree3_1" value="Y" disabled="disabled" checked>설명 받았음</label>
											<label for="prod_terms_agree3_2" class="radio"><input type="radio" name="prod_terms_agree3" id="prod_terms_agree3_2" value="N" disabled="disabled">설명 받지 않았음</label>
										</p>
					        		</div>  --> 
					        		<div>
					        			<p class="check-tit">대출거절사유 고지신청서</p>
										<p class="radio-area mt15">
											<label for="prod_terms_agree4_1" class="radio"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_1" value="Y">신청</label>
											<label for="prod_terms_agree4_2" class="radio"><input type="radio" name="prod_terms_agree4" id="prod_terms_agree4_2" value="N" checked>신청하지 않음</label>
										</p>
					        		</div>  
					        		<!-- <div>
					        			<p class="check-tit">대학생·청년층확인서</p>
										<p class="radio-area mt15">
											<label for="prod_terms_agree5_1" class="radio"><input type="radio" name="prod_terms_agree5" id="prod_terms_agree5_1" value="Y" disabled="disabled" checked>설명 받았음</label>
											<label for="prod_terms_agree5_2" class="radio"><input type="radio" name="prod_terms_agree5" id="prod_terms_agree5_2" value="N" disabled="disabled">설명 받지 않았음</label>
										</p>
					        		</div>   -->
						      	</div>
					        </div>
					     </dd>
						<dt>
							<label for="all-check" class="check"><input type="checkbox" name="all-check" id="all-check" value="">다음의 필수약관에 모두 동의합니다.
								<a href="#" class="btn-normal tiny hide" data-tooltip="agreementall-layer">자세히보기</a>
							</label>
						</dt>
						<dd id="T000800001">
							<label for="agree-check1" class="check"><input type="checkbox" name="terms_agreement_1" id="agree-check1" value="">
								<span>(필수)개인(신용)정보 조회동의서</span> 
								<button class="btn-normal tiny" data-tooltip="manual011-layer" onclick="javascript:termsRadioChangeEvent(this);">자세히보기</button>
							</label>
						</dd>
						<dd id="T000800002">
							<label for="agree-check6" class="check">
								<input type="checkbox" id="agree-check6" name="terms_agreement_6" value="">
								<span>(필수)개인(신용)정보 수집·이용·제공 동의서(여신금융거래) </span>
								<button class="btn-normal tiny" data-tooltip="manual011-layer" onclick="javascript:termsRadioChangeEvent(this);">자세히보기</button>
							</label>
						</dd>
						<dd id="T000800006">
							<label for="agree-check2" class="check">
								<input type="checkbox" id="agree-check2" name="terms_agreement_2" value="">
								<span>(필수)개인(신용)정보 조회동의서(서민금융진흥원)</span>
								<button class="btn-normal tiny" data-tooltip="manual011-layer">자세히보기</button>
							</label>
						</dd>
						<dd id="T000800007">
							<label for="agree-check3" class="check">
								<input type="checkbox" id="agree-check3" name="terms_agreement_3" value="">
								<span>(필수)개인(신용)정보 수집ㆍ이용ㆍ제공동의서(서민금융진흥원)</span>
								<button class="btn-normal tiny" data-tooltip="manual011-layer">자세히보기</button>
							</label>
						</dd>
						<dd id="T000800008">
							<label for="agree-check4" class="check">
								<input type="checkbox" id="agree-check4" name="terms_agreement_4" value="">
								<span>(필수)개인(신용)정보 및 기업(신용)정보조회․수집․이용․제공과 행정정보공동이용, 전자금융거래확인서 발급을 위한 동의서</span>
								<button class="btn-normal tiny" data-tooltip="manual011-layer">자세히보기</button>
							</label>
						</dd>
						<!-- 180426 약관추가 -->
						<dd id="T000800009">
							<label for="agree-check8" class="check">
								<input type="checkbox" id="agree-check8" name="terms_agreement_8" value=""> <span>(필수)계약 체결·이행 등을 위한 필수 동의서 (개인금융성 신용보험용) </span> 
								<button class="btn-normal tiny" data-tooltip="manual011-layer">자세히보기</button>
							</label>
						</dd>
						<!-- //180426 약관추가 -->
						
						<dd id="T000800010">
							<label for="agree-check11" class="check">
							<input type="checkbox" name="terms_agreement_11" id="agree-check11" value="" >
							<span>CMS 출금이체 동의</span>
							<button class="btn-normal tiny" data-tooltip="manual011-layer">자세히보기</button>
							</label>
						</dd>
						<dd id="T000800015">
							<label for="agree-check13" class="check">
								<input type="checkbox" name="terms_agreement_13" id="agree-check13" value="">
								<span>(필수)개인(신용)정보 제3자 제공동의서 (동산 담보대출, 부동산 담보대출) </span>
								<button class="btn-normal tiny" data-tooltip="manual011-layer" onclick="javascript:termsRadioChangeEvent(this);">자세히보기</button>
							</label>
						</dd>
						
					     <dd id="sunshinedetail1">
					         <label for="sunshinedetail" class="check productdetail-sunshine">
					             <input type="checkbox" id="sunshinedetail" value="">
					             <span>가계대출상품설명서 확인하기</span>
				                 <button class="btn-normal tiny detail-layer-popup" data-tooltip="manual011-layer" title="햇살론 상품설명서 확인하기">자세히보기</button>
					         </label>
                         </dd>
						<dd id="saitdoldetail1">
							<label for="saitdoldetail" class="check productdetail-saitdol">
								<input type="checkbox" id="saitdoldetail" value="">
								<span>가계대출상품설명서 확인하기</span>
								<button class="btn-normal tiny detail-layer-popup" data-tooltip="manual011-layer" title="사잇돌 상품설명서 확인하기">자세히보기</button>
							</label>
						</dd>
						
						<!-- //180612 약관추가 -->
						<dd>
                            <hr class="line mt20">
                        </dd>
                        <dt>
							<label for="all-ch-check" class="check"><input type="checkbox" name="all-ch-check" id="all-ch-check" value="">다음의 선택약관에 모두 동의합니다.
								<a href="#" class="btn-normal tiny hide" data-tooltip="agreementChall-layer">자세히보기</a>
							</label>
						</dt>
                        <dd id="T000800003">
							<label for="agree-check5" class="check">
								<input type="checkbox" id="agree-check5" value="">
								<span>(선택)개인(신용)정보 수집ㆍ이용ㆍ제공동의서(상품서비스 안내 등)</span>
								<button class="btn-normal tiny" data-tooltip="manual011-layer" onclick="javascript:termsRadioChangeEvent(this);">자세히보기</button>
							</label>
							<div class="subcheck-area add_class1">
					        		<p class="check-tit"><label for="apply_yn_agree" class="check"><input type="checkbox" name="apply_yn_agree" id="apply_yn_agree" value="" >위 개인(신용)정보 수집·이용에 동의하십니까?&nbsp;<img style="width:30px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_1.gif" alt="수집, 이용에 관한사항  평가등급 보통"/></label></p>
					        	<div class="sub-box">
					        		<p class="check-tit subbox-all"><label for="marketing_yn" class="check"><input type="checkbox" name="marketing_yn" id="marketing_yn" value="" >전자적 전송매체를 통한 광고성 정보의 수신을 동의하십니까?</label></p>  
					        		<div class="sub-check">
							          <span class="txt">상품서비스 안내수단</span>
							          <span class="subcheck-all"><label for="service" class="check"><input type="checkbox" id="service" value="" class="sub-all">전체</label></span>
							          <span class="type">
							            <label for="marketing_yn_sms" class="check"><input type="checkbox" name="marketing_yn_sms" id="marketing_yn_sms" value="" >문자메세지</label>
							            <label for="marketing_yn_email" class="check"><input type="checkbox" name="marketing_yn_email" id="marketing_yn_email" value="" >이메일</label>
							            <label for="marketing_yn_tel" class="check"><input type="checkbox" name="marketing_yn_tel" id="marketing_yn_tel" value="" >전화</label>
							            <label for="marketing_yn_dm" class="check"><input type="checkbox" name="marketing_yn_dm" id="marketing_yn_dm" value="" >DM</label>
							          </span>
							          <input type="hidden" id="marketing_yn_tok" name="marketing_yn_tok" value="N" ><!-- 20210608 전체선택 체크를 위해 자리이동 -->
							        </div>
						      	</div>
						      	
						      	<input type="hidden" name="CRDT_AGR_DTL_YN" id="CRDT_AGR_DTL_YN"><!-- 개인(신용)정보 조회 동의서 상세여부 -->
								<input type="hidden" name="PROD_AGR_DTL_YN" id="PROD_AGR_DTL_YN"><!-- 개인(신용)정보 수집·이용·제공 동의서(여신 금융 거래) 상세여부 -->
								<input type="hidden" name="SRVC_AGR_DTL_YN" id="SRVC_AGR_DTL_YN"><!-- 개인(신용)정보 수집·이용·제공 동의서(상품서비스 안내) 상세여부 -->
								<input type="hidden" name="THIRD_AGR_DTL_YN" id="THIRD_AGR_DTL_YN" value=""><!-- 개인(신용)정보 제3자 제공동의서[동산담보대출] -->
								
								<!-- 2021.09.29 상품설명서 동의여부 -->
								<input type="hidden" name="PRODUCT_DESC_YN" id="PRODUCT_DESC_YN" value="">
								<!-- 2022.03.31 개인(신용)정보 수집·이용·제공 동의서 (맞춤형 정보제공) 상세여부 -->
								<input type="hidden" name="SRVC_PRVD_AGR_DTL_YN" id="SRVC_PRVD_AGR_DTL_YN" value = 'N'>
								<!-- 2022.03.31  개인(신용)정보 수집·이용·제공 동의서 (맞춤형 정보제공) -->
								<input type="hidden" name="PRODUCT_SERVICE_PROVIDE_YN" id="PRODUCT_SERVICE_PROVIDE_YN">
								
					          	<div class="sub-box">					          
						          	<p class="check-tit">
						          		<label for="marketing_apply_yn_agree" class="check">
						          		<input type="checkbox" id="marketing_apply_yn_agree" name="marketing_apply_yn_agree" value="" >위 개인신용정보 제공에 동의하십니까?&nbsp;<img style="width:60px; height: 20px; float: right;" src="/resources/normal/images/common/T000800003_icon_3.jpg" alt="제공에 관한 사항 평가등급 다소안심"/></label>
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
						<dd id="T000800011">
							<label for="agree-check9" class="check">
								<input type="checkbox" name="terms_agreement_9" id="agree-check9" value="">
								<span>(선택)대출거절사유 고지에 관한 사항 </span>
								<button class="btn-normal tiny" data-tooltip="manual011-layer">자세히보기</button>
							</label>
						</dd>
						<!-- 2022-03-31 (선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(맟춤형 상품 제공) 추가 -->
						<dd id="T000800022">
							<label for="agree-check14" class="check">
								<input type="checkbox" id="agree-check14" value=""  onclick="termsCheckBoxChangeEvent('agree-check14');">
								<span>(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(맟춤형 상품 제공)</span>
								<button class="btn-normal tiny" data-tooltip="manual011-layer">자세히보기</button>
							</label>
							<div class="subcheck-area add_class5">
	                           	<div class="sub-box">
	                           		<p class="check-tit">
	                           			<label for="yn_agree" class="check" >
										<input type="checkbox" name="yn_agree" id="yn_agree" value="" >위 개인(신용)정보 수집·이용에 동의하십니까?</label>
									</p>
							  		<p class="check-tit">
							  			<label for="yn_agree2" class="check">
                               				<input type="checkbox" name="yn_agree2" id="yn_agree2" value="" >위 개인(신용)정보 제공에 동의하십니까?
                               			</label>
	                               	</p>
								</div>
							</div>
						</dd>
					</dl>
					</div>
					<h3 class="tit mt20">본인인증 방법 선택</h3>
					<div class="line-box">대출신청 진행을 위해서는 본인인증이 필요합니다. <br>
					아래의 인증 방식 중 하나를 선택해 인증을 진행해 주시기 바랍니다. 
					<span id="warnCartText" style="color:#DC0082;">
<!-- 					<br>일부 카드의 경우 해당 카드사의 정보미제공으로 본인인증이 불가 합니다.(신한, 현대카드) -->
					</span>
                	<span id="warnText" style="display:none;color:#DC0082;"><br>"사잇돌2"상품은 SGI서울보증보험의 정책에 따라 아래 두가지 방식을 통한 인증만 유효합니다.</span>
					</div>
					<ul class="auth-type">
						<c:if test="${phoneYn eq 'Y' }">
							<li class="type1 auth1">
								<label for="radio1" class="radio r-on"><input type="radio" name="auth_type" id="radio1" value="phone">휴대폰인증</label>
							</li>
						</c:if>
						<c:if test="${certYn eq 'Y' }">
							<li class="type2 auth2">
								<label for="radio2" class="radio r-on"><input type="radio" name="auth_type" id="radio2" value="delfino">공동인증서</label>
							</li>
						</c:if>
						<c:if test="${certYn eq 'Y' }">
							<li class="type6 auth6">
								<label for="radio6" class="radio r-on"><input type="radio" name="auth_type" id="radio6" value="fincert">금융인증서</label>
							</li>
						</c:if> 
						<c:if test="${ipinYn eq 'Y' }">
							<li class="type3 auth3">
								<label for="radio3" class="radio r-on"><input type="radio" name="auth_type" id="radio3" value="ipin">아이핀인증</label>
							</li>
						</c:if>
						<%-- <c:if test="${kakaoYn eq 'Y' }">
							<li class="type4 auth4">
								<label for="radio4" class="radio r-on"><input type="radio" name="auth_type" id="radio4" value="kakao">카카오페이인증</label>
							</li>
						</c:if> --%>
						<c:if test="${creditCardYn eq 'Y' }">
							<li class="type5 auth5">
								<label for="radio5" class="radio r-on"><input type="radio" name="auth_type" id="radio5" value="creditCard">신용카드인증</label>
							</li>
						</c:if>
					</ul>
					 <input type="hidden" id="terms_prod_cd" name="terms_prod_cd"  value="GL091">
					</form>
					<hr class="mt20 mb5 auth_1">
					<p class="font12 mb40 auth_2">
                        ※ 고객님께서 입력하신 개인정보는 대출신청 완료 후 수집됩니다.<br>
						※ 대출신청하기 클릭 시 본인인증팝업으로 넘어갑니다.
					</p>

					<div class="btn-wrap auth_3">
						<span><button class="btn-normal pink" onclick="next();">다음단계 진행</button></span>
      					<span class="circle-big"><a href="02_realname" class="btn-circle refresh big ir">취소</a></span>
					</div>
					
                </div>
	        </div>
	        <!-- //e:contents -->
	        <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
	    </div>
	    <!-- //e: contentsWrap -->

		<!-- s:카카오페이 인증 -->
        <div id="kakaoLayer" class="layerpopup kakao-layer" tabindex="0" data-tooltip-con="kakao-layer" data-focus="kakao-layer" data-focus-prev="btn-menu-close">
            <!-- s:layer-con -->
            <div class="layer-con">
                <div class="tit color-612885 font26 mb10">카카오페이 인증</div>
                <p class="font14">고객님의 스마트폰으로 카카오톡 메시지가 전송되었습니다.<br>카카오톡에서 전자서명 인증 완료 후 아래 완료버튼을 클릭해주세요.</p>
				<hr class="mt30">
				<div class="pay-time">
					<p>인증 마감시간</p>
					<span id="kakao_timelimit">0:00</span>
				</div>
				<div class="btn-wrap mt30">
					<a href="#" id="btn_complete" class="btn-normal wide">인증완료</a>
				</div>
            </div>
            <!-- //e:layer-con -->
            <button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="kakao-layer">닫기</button>
        </div>
        
        <div id="limitLayer"></div>
            
        <!-- s:전체 레이어팝업 -->
		<div id="agreementallLayer" class="layerpopup agreementall-layer pdf-alllayer" tabindex="0" data-tooltip-con="agreementall-layer" data-focus="agreementall-layer" data-focus-prev="btn-menu-close" style = "left: 0px;right: 0px;max-height: 695px;overflow-y: auto;top: -80.5px;">
			<div class="pop-wrap"> 
				<div class="all-agree">* 필수 약관 전체 보기 ( <span class="view"></span> / <span class="total"></span> )</div>
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
		<div id="agreementChallLayer" class="layerpopup agreementall-layer pdf-alllayer" tabindex="0" data-tooltip-con="agreementChall-layer" data-focus="agreementChall-layer" data-focus-prev="btn-menu-close" style = "left: 0px;right: 0px;max-height: 695px;overflow-y: auto;top: -80.5px;">
			<div class="pop-wrap">
				<div class="all-agree">* 선택 약관 전체 보기 ( <span class="view1"></span> / <span class="total1"></span> )</div>
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
        <div id="manualLayer011" class="layerpopup manual-layer" tabindex="0" data-tooltip-con="manual011-layer" data-focus="manual011-layer" data-focus-prev="btn-menu-close" style = "top: 20.5px; left: 0px; right: 0px;">
			<div class="pop-wrap">
				<iframe id="viewer" src="" style="width: 100%;height: 450px;margin-top:-27px;"></iframe>
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
				<iframe id="dutyViewer" src="" style="width: 100%;height: 450px;margin-top:-27px;"></iframe>
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
	//						importantCheck(showIndex);
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
        <!-- //e:카카오페이 인증 -->
<%--         <%@include file="include/agreementRetailAllLayer.jsp" %> --%>
<%--         <%@include file="include/agreementLayer.jsp" %> --%>
<%--         <%@include file="include/productAgreementLayer.jsp" %> --%>
	    <!-- ********** Include ********** -->
	    <%@ include file="../include/inc_body_end.jspf" %>
	    <!-- ********** //Include ********** -->
	<!-- //e:wrap -->
</html>