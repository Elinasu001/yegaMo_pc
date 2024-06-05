<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="co.kr.yegaramsb.dsr.core.common.Constraints.RequestMappingUri"%>
<c:set var="loan" value="/${dsrId }/loan/01_loan_step2" />
<c:set var="retailLoan" value="/${dsrId }/loan/02_loan_step2" />
<c:set var="ajaxPopupList" value="/${dsrId }/ajaxPopupList"/>

<c:set var="testurl" value="/testurl.ajax"/>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="include/inc_header_non_secure.jspf" %>
<c:if test="${nfilter eq true }">
<%@ include file="../include/loan/loan_nfilter.jsp" %>
</c:if>
<style type="text/css">
/******** layerpopup ********/
.layerpopup .pop-tit { padding-bottom:30px; border-bottom:1px solid #ccc; }
.layerpopup .tit { padding-right:50px; color:#612885; font-size:40px; line-height:48px; letter-spacing:-3px; }
.layerpopup .desc { margin-top:20px; }
.layerpopup .pop-tit + .pop-cts { margin-top:30px; }
.layerpopup .pop-cts .tit-txt { margin-top:40px; padding-bottom:10px; color:#333; font-size:20px; line-height:28px; letter-spacing:-1.8px; }
.layerpopup.small { width:660px; }
.layerpopup.small .pop-wrap { padding:50px; }
.layerpopup.small .btn-menu-close { right:25px; }
.layerpopup .btn-normal:hover, .layerpopup .btn-normal:focus { background:#612885; color:#fff; border:1px solid #612885; }
.noti-layer { position:relative; }
.noti-layer .pop-tit { border-bottom:none; font-weight:bold; }
.noti-layer .accordion-wrap { position:relative; height:420px; overflow:hidden; }
.noti-layer .noti-cookie { position:absolute; bottom:20px; right:0; }
.noti-layer .btn-wrap { position:relative; margin-top:20px; }
.noti-layer .accordion > li { padding-right:40px; }
.noti-layer .accordion li .question-wrap .con { font-weight:bold; }
.noti-layer .accordion li { padding:0; padding-right:40px; padding-left:1px;}
.noti-layer .accordion li .question-wrap { padding:18px 0 18px 19px; box-sizing:content-box; }
.noti-layer .accordion li.active .question-wrap { margin-bottom:0; }
.noti-layer .accordion .answer-wrap { padding-bottom:19px; }
.noti-layer .accordion .answer-wrap a { display:block; }
.noti-layer .accordion .answer-wrap .con { width:100%; padding:0; }
/*공지사항 내용 들여쓰기
.noti-layer .accordion .answer-wrap .con { width:100%; padding:0px 70px; }
*/
.noti-layer .accordion .answer-wrap .con img { max-width:100%; height:auto; }
.btn-wrap { width:100%; margin-top:40px; text-align:center; }
.btn-wrap a, .btn-wrap button { position:relative; display:inline-block; }
.btn-wrap a+a, .btn-wrap a+button, .btn-wrap button+a, .btn-wrap button+button { margin-left:5px; }

/******** pagination ********/
.pagination-wrap { padding-top:20px; text-align:center; }
.pagination { display:inline-block; }
.pagination > a { float:left; }
.pagination ul { float:left; margin:0px 10px; }
.pagination ul li { float:left; }
.pagination ul li + li { margin-left:4px; }
.pagination a { width:36px; height:36px; line-height:34px; }
.pagination a:hover, .pagination a:focus { background-color:transparent; }
.pagination a.active { background:#fff; border:1px solid #495057; }
.pagination a.active:hover,.pagination a.active:focus { border:1px solid #EC008C;}
.pagination a.prev { background-image:url(../images/common/ico_big_prev_off.png); }
.pagination a.prev:hover,.pagination a.prev:focus { background-image:url(../images/common/ico_big_prev_on.png); }
.pagination a.next { background-image:url(../images/common/ico_big_next_off.png); }
.pagination a.next:hover,.pagination a.next:focus { background-image:url(../images/common/ico_big_next_on.png); }


</style>

<script>
	var isMobile=false; 
	$(function() {
		
	    $('#phone_no2').on('keyup', function() {
	        var mch = $(this).val().match(/[0-9]/g);
	        if(mch != null&& mch.length ==4) {
	            $('#phone_no3').focus();
	        }
	    });
	
	    $('#ssn1').on('keyup', function() {
	        var mch = $(this).val().match(/[0-9]/g);
	        if(mch != null&& mch.length ==6) {
	            $('#ssn2').focus();
	        }
	    });
	    
	    
	    
	    $('.noti-layer li').eq(0).find('a').click();
	});
	
	function loan_request() {
	    init_form_data();
	    if(!validate_form(mainProductForm)) {
	        return;
	    }
	    loading();
	    loan_request_user_form(function() {
	        location.href = '<c:url value="${loan }" />';
	    }, on_error);
	}
	var PageFunc = ({
		
		ajaxPopupList : function() {
			AjaxFunc.ajaxAsync('<c:url value="${ajaxPopupList}" />', "", function(res){
				removeLoading();
				if(res.result) {
					if(res.data.length>0){
// 						PageFunc.checkCookie(res.data);
						checkCookie(res.data);
					}
				}else {
					console.log(res);
					
				}
			}, on_error);
	    },
		
// 		setCookie : function (name) {
// 	    	var todayDate = new Date();
// 	    	var value = "done";
// 	    	var expiredays = 1;
// 	    	todayDate.setDate(todayDate.getDate()+expiredays);
// 	    	document.cookie = name +"=" +escape(value) + "; path=/; expires="+todayDate.toGMTString() + ";";
	        	 
// 	   	},
	   
// 	   	checkCookie : function (data) {
// 			if(document.cookie.indexOf("notiLayer=done") === -1) {
// 				PageFuncNotice.printNotiLayer(data);
//                 $('.accordion li').eq(0).find('.question-wrap').trigger('click');
// 	        } 
// 	    },
		
	});
	function setCookie(name) {
    	var todayDate = new Date();
    	var value = "done";
    	var expiredays = 1;
    	todayDate.setDate(todayDate.getDate()+expiredays);
    	document.cookie = name +"=" +escape(value) + "; path=/; expires="+todayDate.toGMTString() + ";";
   	}
	
	function checkCookie(data) {
		if(document.cookie.indexOf("notiLayer=done") === -1) {
			PageFuncNotice.printNotiLayer(data);
            $('.accordion li').eq(0).find('.question-wrap').trigger('click');
        } 
    }
	
	function on_error() {
		removeLoading();
	}
	PageFunc.ajaxPopupList();
	
	function getOS() {
	    var userAgent = window.navigator.userAgent,
	        platform = window.navigator.platform,
	        macosPlatforms = ['Macintosh', 'MacIntel', 'MacPPC', 'Mac68K'],
	        windowsPlatforms = ['Win32', 'Win64', 'Windows', 'WinCE'],
	        iosPlatforms = ['iPhone', 'iPad', 'iPod'],
	        os = null;

	    if (macosPlatforms.indexOf(platform) !== -1) {
	        os = 'Mac OS';
	    } else if (iosPlatforms.indexOf(platform) !== -1) {
	        os = 'iOS';
	    } else if (windowsPlatforms.indexOf(platform) !== -1) {
	        os = 'Windows';
	    } else if (/Android/.test(userAgent)) {
	        os = 'Android';
	    } else if (!os && /Linux/.test(platform)) {
	        os = 'Linux';
	    }
	    return os;
	}
	
	function retailYn(){
		var setupTime = loanCheckTime();		
		var retailYn = "${retailYn}";
		if(setupTime){
			customAlert({title: "알림", message: '${setupPopup.loanStopPopCon1}', btn_txt1: '확인'},
					 function() {
//				window.history.back();
			});
		}else{
			if(retailYn == 'N'){
				location.href =  "<c:url value="${loan }"/>"+"?retailYn=N";
			}else{
				location.href =  "<c:url value="${retailLoan }"/>"+"?retailYn=Y";
			}
		}
	}
		
	function loanCheckTime(){
		var aser = '${setupPopup.loanStopSdt1 }'
		
		var startTime = '${setupPopup.loanStopSdt1}';
		var endTime   = '${setupPopup.loanStopEdt1}';
		
		var result = false;
// 		removeLoading();
		if (UtilFunc.getCurrentDttm() > startTime && UtilFunc.getCurrentDttm() < endTime){
			result = true;
		}
		return result;
		
	}
	function test2() {
		AjaxFunc.ajaxAsync('<c:url value="${testurl}" />', $('#frm1').serialize(), function(res) {
			if(res.result) {
				onSuccess(res);
			}else {
				onFail(res);
			}
		}, onFail);
	}
</script>
</head>
    <%@ include file="include/inc_body_start.jspf" %>
	<%@ include file="../include/loan/loan.jspf" %>
	<%@ include file="home_notice.jsp" %>

    <!-- s contentsWrap -->
    <div id="contentsWrap">
        <div class="main-wrap">
            <div class="top">
                <div class="banner-wrap">
                    <ul>
                        <li>
	                        <a href="#none">
                            <img src="<c:url value="/resources/normal/images/temp/img_main_banner1.png"/>" alt="더 나은 미래를 창조하는 예가람저축은행">
	                        </a>
                        </li>
                        <c:forEach var="product" items="${productList}">
<%--                    <c:if test="${product.NTREE_PROD_CODE ne 'GL999' and product.NTREE_PROD_CODE ne 'GL085' and product.NTREE_PROD_CODE ne 'GL998' and product.NTREE_PROD_CODE ne 'GL094' and product.NTREE_PROD_CODE ne 'GL091'}"> --%>
						<c:if test="${product.NTREE_PROD_CODE ne 'GL999' and product.NTREE_PROD_CODE ne 'GL085' and product.NTREE_PROD_CODE ne 'GL998' }">
                        <li>
                            <a href="#none" onclick="showProduct('${product.CODE}'); return false;" title="${product.NAME} 바로가기">
                                <img src="<c:url value="/${dsrId}/images/${product.IMG_DSR_PC}"/>" alt="${product.DESC_ABBR}">
                            </a>
                        </li>
                        </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <script type="text/javascript">
                    $('.banner-wrap ul').bxSlider({
                        mode: 'fade',
	                    speed:600,
                        auto:true,
                        pager: true,
                        controls: false,
                        autoControls: true,
                        autoHover: true, /* 180424 메인배너 hover 추가 */
                        touchEnabled : false
                    });
                </script>
                <div class="right">
                    <ul class="vertical-tab">
                        <li class="counselor active">
                            <button type="button" name="button" class="ir">상담사정보</button>
                        </li>
                        <li class="quickloan">
                            <button type="button" name="button" class="ir">빠른대출신청</button>
                        </li>
                    </ul>
                    <div class="vertical-tab-content">
                        <div class="con-wrap" style="display:block;">
                            <div class="con mb30">
                                <div class="name-wrap mb25 fl-l">
                                    <hr class="bg-EC008C mb15">
                                    <p class="font12 color-333333">예가람저축은행 <span style="font-size:20px;">대출모집법인</span></p>
                                    <p class="font18 color-333333"><c:out value="${dsrUser.CORP_NM}"/> 대출상담사</p>
                                    <p class="font40 color-333333"><c:out value="${dsrUser.NAME}"/></p>
                                </div>
                                <div class="photo-wrap mb25 fl-r">
                                    <div class="photo">
                                        <c:if test="${not empty dsrUser.PHOTO_SEQ}">
                                        <img src="<c:url value="/${dsrId}/images/${dsrUser.PHOTO_SEQ}"/>" alt="상담사 사진">
                                        </c:if>
                                        <c:if test="${dsrUser eq null or empty dsrUser.PHOTO_SEQ}">
                                        <img src="<c:url value="/resources/normal/images/common/ico_woman.png"/>" alt="상담사 사진">
                                        </c:if>
                                    </div>
                                </div>
                                <div class="number-wrap clear mb30">
                                    <div class="hp-num">
                                        <p class="font13 color-351B6F mb5">전화번호</p>
                                        <p class="font20 color-333333 mb5"><c:out value="${dsrUser.REP_TEL_NO}"/> </p>
                                    </div>
                                    <div class="reg-num">
                                        <p class="font13 color-351B6F mb5">저축은행중앙회등록번호 </p>
                                        <p class="font20 color-333333 mb5"><c:out value="${dsrUser.FSB_REG_NO}"/> </p>
                                        <a href="http://www.loanconsultant.or.kr/" target="_blank"><button type="button" name="button" class="btn-popup has-bg">저축은행 상담사 조회</button></a>
                                    </div>
                                </div>
                                <hr class="mb20">
                                <div class="step-wrap">
                                    <p class="mb30"><img src="<c:url value="/resources/normal/images/main/tit_main_step1.png"/>" alt="예가람저축은행의 신속하고 간편한 대출절차를 만나보세요!"></p>
                                    <ul>
                                        <li class="step1"><p>온라인대출신청</p></li>
                                        <li class="step2"><p>대출심사</p></li>
                                        <li class="step3"><p>대출송금</p></li>
                                    </ul>
                                </div>
                            </div>
                            <p class="btn-wrap">
                               <%--  <a href="<c:url value="${loan }"/>" class="btn bg-EC008C loading"><span>빠른 대출 신청하기</span></a> --%>
                                <%-- <a href="<c:url value="${loan }"/>" class="btn bg-EC008C loading"><span>빠른 대출 신청하기</span></a> --%>
                                <button class="btn bg-EC008C loanBtn" onclick="retailYn()"><span>빠른 대출 신청하기</span></button>
                            </p>
                        </div>
                        <div class="con-wrap" style="display:none;">
                            <form name="frm1" id="frm1">
                                <input type="hidden" id="phone_no" name="phone_no"/>
                                <input type="hidden" name="prod_category_cd" id="prod_category_cd" value="" />
                                <input type="hidden" id="prod_nm" name="prod_nm" value="" />
                                <input type="hidden" name="ntree_auth" value="false" />
                                <input type="hidden" name="encData" id="encData" />
	                            <div class="con mb30">
	                                <div class="name-wrap mb25">
	                                    <hr class="bg-EC008C mb15">
	                                    <p class="font20">빠른 대출신청 간단정보 입력</p>
	                                </div>
	                                <div class="form-wrap mb20">
	                                    <p class="input-tit font13 color-351B6F">대출상품</p>
	                                    <div class="select-wrap">
	                                        <select name="prod_cd" id="prod_cd">
	                                            <option selected="selected" value="">대출상품을 선택하세요</option>
	                                            <c:forEach var="item" items="${productList}">
	                                            <c:if test="${item.NTREE_PROD_CODE eq null }">
	                                        		<c:set target="${item }" property="NTREE_PROD_CODE" value="${ntree_prod1 }"/>
		                                        </c:if>
		                                        <c:if test="${item.USE_YN eq 'Y' }">
		                                        	<option
		                                    			<c:if test="${item.NTREE_PROD_CODE eq null and item.CODE ne prod_cd_hetsal}">value="${ntree_null}"</c:if>
			                                    		<c:if test="${item.NTREE_PROD_CODE eq null and item.CODE eq prod_cd_hetsal}">value="${ntree_prod1 }" id="hetsal_option"</c:if>
		                                    			<c:if test="${item.NTREE_PROD_CODE ne null}">value="${item.NTREE_PROD_CODE}"</c:if>
                                    				><c:if test="${item.NTREE_PROD_CODE eq 'GL056'}"><c:out value="${item.NAME}"/>(+두배론)</c:if><c:if test="${item.NTREE_PROD_CODE ne 'GL056'}"><c:out value="${item.NAME}"/></c:if></option>
		                                        </c:if>
	                                            </c:forEach>
	                                        </select>
	                                    </div>
	                                </div>
	                                <div class="form-wrap mb20">
	                                    <p class="input-tit font13 color-351B6F">이름</p>
	                                    <input type="text" name="cust_nm" id="cust_nm" class="ko-txt" placeholder="고객실명입력">
	                                </div>
	                                <div class="form-wrap mb20">
	                                    <p class="input-tit font13 color-351B6F">핸드폰번호 *</p>
	                                    <div class="hp1 fl-l">
	                                        <div class="select-wrap">
	                                            <select name="telecom" id="telecom">
	                                                <option selected="selected" value="">통신사</option>
	                                                <c:forEach var="item" items="${carrierList}">
	                                                <option value="${item.code}"><c:out value="${item.name}"/></option>
	                                                </c:forEach>
	                                            </select>
	                                        </div>
	                                    </div>
	                                    <div class="hp2 fl-l">
	                                        <div class="select-wrap">
	                                            <select id="phone_no1" id="phone_no1">
	                                            <c:forEach var="tel" items="${telList}">
	                                                <option value="${tel.value}"><c:out value="${tel.name}"/></option>
	                                            </c:forEach>
	                                            </select>
	                                        </div>
	                                    </div>
	                                    <span class="fl-l hyphen">-</span>
	                                    <div class="hp3 fl-l">
	                                        <input type="text" value="" id="phone_no2" placeholder="" title="핸드폰 두번째 자리" maxlength="4">
	                                    </div>
	                                    <span class="fl-l hyphen">-</span>
	                                    <div class="hp4 fl-l">
	                                        <input type="text" value="" id="phone_no3" placeholder="" title="핸드폰 세번째 자리" maxlength="4">
	                                    </div>
	                                </div>
	                                <div class="form-wrap">
	                                    <p class="input-tit font13 color-351B6F">주민등록번호 *</p>
	                                    <div class="idn1 fl-l mb5">
	                                        <input type="text" name="ssn1" value="" id="ssn1" placeholder="" title="주민등록번호 앞번호" maxlength="6">
	                                    </div>
	                                    <span class="fl-l hyphen">-</span>
	                                    <div class="idn2 fl-l mb5">
	                                        <input type="password" name="ssn2" value="" id="ssn2" placeholder="" title="주민등록번호 뒷번호" maxlength="7"
	                                        	<c:if test="${nfilter ne true }">e2e_type="1"</c:if>>
	                                    </div>
	                                    <p class="font12 color-626C74 clear rice">당 저축은행은 신용정보의 이용 및 보호에 관한 법률 시행령 제37조의2에 의거하여 주민등록번호를 수집합니다.</p>
	                                    <p class="font12 color-626C74 rice">고객님께서 입력하신 개인정보는 대출신청 완료 후 수집됩니다.</p>
	                                </div>
	                            </div>
                            </form>
	                            <p class="btn-wrap">
	                                <button onclick="loan_request()" class="btn bg-EC008C"><span>추가정보 입력하기</span></button>
	                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bottom">
                <ul>
                    <li class="etc1"><a class="loading" href="<c:url value="/${dsrId}/cs/protection"/>">상품판매준칙</a></li>
                    <li class="etc2"><a href="http://www.yegaramsb.co.kr/center/privacy_info_policy" target="_blank" title="새창으로">개인정보처리방침</a></li>
                    <li class="etc3"><a class="loading" href="<c:url value="/${dsrId}/cs/branchInfo"/>">지점안내</a></li>
                    <li class="etc4"><a class="loading" href="<c:url value="/${dsrId}/cs/unfair"/>">부당행위 신고안내</a></li>
                    <li class="etc5"><a class="loading" href="<c:url value="/${dsrId}/cs/pds"/>">약관/서식자료실</a></li>
                </ul>
            </div>
        </div>
    </div>
    <%@ include file="include/inc_layer_popup.jspf" %>
    <%@ include file="include/inc_body_end.jspf" %>
</html>
