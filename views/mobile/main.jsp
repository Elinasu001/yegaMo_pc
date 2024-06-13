<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="include/inc_header.jspf" %>
	<link href="<c:url value="/resources/mobile/css/swiper.min.css"/>" rel="stylesheet" />
	<link href="<c:url value="/resources/mobile/css/main.css?v=20201013"/>" rel="stylesheet" />
	<script src="<c:url value="/resources/mobile/js/swiper.min.js"/>" type="text/javascript"></script>
</head>
<script type="text/javascript">
$(function() {
	PageFunc.ajaxPopupList();
});

var PageFunc = ({
	
	
	ajaxPopupList : function() {
		AjaxFunc.ajaxAsync('<c:url value="${ajaxPopupList}" />', "", function(res){
			removeLoading();
			if(res.result) {
				if(res.data.length>0){
					PageFunc.checkCookie(res.data);
				}
			}else {
				console.log(res);
				
			}
		}, on_error);
    },
	
	
    checkCookie : function (data) {
		if(document.cookie.indexOf("popupList=done") === -1) {
        	PageFuncPopup.init(data);
        } 
    },
    
    setCookie : function (name) {
        var todayDate = new Date();
        var value = "done";
        var expiredays = 1;
        todayDate.setDate(todayDate.getDate()+expiredays);
        document.cookie = name +"=" +escape(value) + "; path=/; expires="+todayDate.toGMTString() + ";";
        closePopup("popupLayer");
		$("#popup_btn").hide();
   },
});


function on_error() {
	removeLoading();
}

function retailYn(){
	var retailYn = "${retailYn}";
	if(retailYn == 'N'){
		location.href =  "<c:url value="${loanRequest }"/>"+"?retailYn=N";
	}else{
		location.href =  "<c:url value="${retailLoanRequest }"/>"+"?retailYn=Y";
	}
}

</script>
<style type="text/css">
/* notice */
.noti-wrap { margin:25px 0; }
.noti-wrap .noti-area{ position:relative; }
.noti-wrap .tit { position:relative; height:20px; }
.noti-wrap .tit img { width:auto; height:100%; vertical-align:top; }
.noti-wrap .noti-area .more { position:absolute; top:3px; right:0; width:14px; height:14px; background:url('../images/common/btn_more.png') no-repeat 0 0; background-size:auto 14px;; }
.noti-wrap .noti-banner {  margin-top:5px; line-height:1.4; }
.noti-wrap a span { display:inline-block; vertical-align:middle; }
.noti-wrap a .title { overflow:hidden; text-overflow:ellipsis; white-space:nowrap; width:calc(100% - 80px); font-size:14px; }
.noti-wrap a .date { margin-left:10px; font-size:14px;}
.noti-banner .bx-wrapper { margin: 0; width:calc(100% - 35px);}
.noti-banner .bx-viewport { background:transparent; }
.noti-banner .bx-wrapper .bx-controls.bx-has-controls-auto { width:35px; height:12px; position:absolute; top:50%; right:0; /*margin-top:-6px;*/ }
.noti-banner .bx-controls-auto { right:-35px; bottom: 0; left:inherit; }
.noti-wrap .app-info { margin-top:25px; }
.noti-wrap .app-info .btn-popup { display:block; padding-right:0; }
.noti-wrap .customer { margin-top:25px; }
.noti-wrap .info-cts { display:table; width:100%; margin-top:10px; }
.noti-wrap .info-num, .noti-wrap .info-txt { display:table-cell; width:52%; vertical-align:middle; }
.noti-wrap .info-txt { padding-left:10px; font-size:12px; line-height:18px; }

#popup_btn { height:45px; margin-top:0; background:#464646; display:none;}
#popup_btn button { position:relative; width:49%; margin:0; color:#fff; font-size:12px; text-align:center; line-height:45px; }
#popup_btn button + button:before { display:block; content:""; position:absolute; top:50%; left:0; width:1px; height:20px; margin-top:-10px; background:#787878; }

/* 공지사항 팝업 */
.noti-layer { width:90%; padding:0; border-width:2px; outline:none;}
.noti-layer .btn-menu-close { background-size:90% auto; }
.noti-layer .bx-wrapper .bx-has-pager { bottom:3%; }
.noti-layer .bx-wrapper .bx-pager.bx-default-pager a,
.noti-layer .bx-wrapper .bx-controls-auto .bx-start,
.noti-layer .bx-wrapper .bx-controls-auto .bx-stop { width:10px; height:10px; background-size:100% auto; }
.noti-layer .bx-wrapper .bx-pager.bx-default-pager a:hover, .noti-layer .bx-wrapper .bx-pager.bx-default-pager a.active { background:#787878; }
.noti-layer .btn-wrap { height:45px; margin-top:0; background:#464646; }
.noti-layer .btn-wrap button { position:relative; width:50%; margin:0; color:#fff; font-size:12px; text-align:center; line-height:45px; }
.noti-layer .btn-wrap button + button:before { display:block; content:""; position:absolute; top:50%; left:0; width:1px; height:20px; margin-top:-10px; background:#787878; }



/******** button ********/
.btn-wrap { width:100%; margin-top:30px; text-align:center; }
.btn-wrap a, .btn-wrap button { position:relative; display:inline-block; }
.btn-wrap a+a, .btn-wrap a+button, .btn-wrap button+a, .btn-wrap button+button { margin-left:5px; }
.btn-wrap.full a, .btn-wrap.full button { display:block; width:100%; }
.btn-wrap.full a+a, .btn-wrap.full a+button, .btn-wrap.full button+a, .btn-wrap.full button+button { margin-left:0; margin-top:10px; }


/******** layerpopup ********/
.layerpopup_noti { position:absolute; display:none; overflow-y:auto; width:90%;z-index:20; background:#fff; border-top:2px solid #EC008C; -webkit-overflow-scrolling:touch; }
.layerpopup_noti .pop-wrap { /*padding:70px 80px;*/ }
.layerpopup_noti .pop-tit {  }
.layerpopup_noti .tit { color:#612885; font-size:2.5rem; line-height:3rem; letter-spacing:-2px; }
.layerpopup_noti .desc { margin-top:20px; }
.layerpopup_noti .pop-tit + .pop-cts { margin-top:20px; padding-top:20px; border-top:1px solid #ccc; }
.layerpopup_noti .pop-cts .tit-txt { margin-top:40px; padding-bottom:10px; color:#333; font-size:2rem; line-height:2.8rem; letter-spacing:-1.8px; }
.layerpopup_noti .btn-menu-close { position:absolute; top:15px; right:20px; z-index:25; width:35px; height:35px; background-image:url(../images/common/btn_close.png); background-repeat:no-repeat; background-size:100% auto; text-indent:-9999px; }


/* bx 공통 */
.bx-wrapper { margin:0; }
.bx-wrapper .bx-viewport { background:transparent; }
.bx-wrapper .bx-controls.bx-has-controls-auto.bx-has-pager .bx-controls-auto { display:inline-block; position:relative; bottom:auto; right:auto; width:auto; }
.bx-wrapper .bx-controls.bx-has-controls-auto.bx-has-pager .bx-pager { position:relative; bottom:auto; width:auto; text-align:center; }
.bx-wrapper .bx-pager { display:inline-block; padding:0; margin-left:10px; height:12px; vertical-align:top; }
.bx-wrapper .bx-pager.bx-default-pager a { background:#b3bbc0; width:12px; height:12px; margin:0 4px; -moz-border-radius:10px; -webkit-border-radius:10px; border-radius:10px; }
.bx-wrapper .bx-pager.bx-default-pager a:hover, .bx-wrapper .bx-pager.bx-default-pager a.active { background:#ec008c; }
.bx-wrapper .bx-controls-auto .bx-start { width:12px; height:12px; background:url(../resources/mobile/images/main/ico_play.png) no-repeat; margin:0; }
.bx-wrapper .bx-controls-auto .bx-stop { width:12px; height:12px; background:url(../resources/mobile/images/main/ico_pause.png) no-repeat; margin:0; }
.bx-wrapper li a { display: block; }
.bx-wrapper .bx-controls-auto .bx-start, .bx-wrapper .bx-controls-auto .bx-stop { display:block; }
.bx-wrapper .bx-controls-auto .bx-start.active, .bx-wrapper .bx-controls-auto .bx-stop.active { display:none; }
.bx-wrapper .bx-has-pager { position:absolute; width:100%;  left:0; bottom:5%; text-align:center; }

</style>

	<!-- 공지사항 -->
    <%@ include file="home_popup.jsp" %>
	<%@ include file="include/inc_body_start.jspf" %>
	    <!-- s contentsWrap -->
	    <div id="contentsWrap" class="bg-cts">
	        <!-- s:contents -->
    		<div class="default-wrap">
    			<div class="counselor-area">
    				<div class="counselor">
    	    			<div class="intro">
						<a class="loading" href="<c:url value="/${dsrId}/introduce"/>">
    	    				<span class="company">예가람저축은행 <font style="font-size:20px;">대출모집법인</font></span>
    	    				<span><c:out value="${dsrUser.CORP_NM}"/> 대출상담사</span>
    	    				<span class="name"><c:out value="${dsrUser.NAME}"/></span>
						</a>
    	    			</div>
    	    			<div class="thumb">
							<a class="loading" href="<c:url value="/${dsrId}/introduce"/>">
								<c:if test="${not empty dsrUser.PHOTO_SEQ}">
									<img src="<c:url value="/${dsrId}/images/${dsrUser.PHOTO_SEQ}"/>" alt="상담사 사진">
								</c:if>
								<c:if test="${empty dsrUser.PHOTO_SEQ}">
									<img src="<c:url value="/resources/normal/images/common/ico_woman.png"/>" alt="상담사 사진">
								</c:if>
							</a>
						</div>
    	    		</div>
    	    		<dl class="info">
    	    			<dt>전화번호</dt>
    	    			<dd class="phone"><a href="tel:${dsrUser.REP_TEL_NO}"><c:out value="${dsrUser.REP_TEL_NO}"/></a></dd>
    	    			<dd class="time">평일 09:00~18:00 상담가능 (국경일 및 토,일요일 휴무)</dd>
    	    			<dt>저축은행중앙회 등록번호</dt>
    	    			<dd><c:out value="${dsrUser.FSB_REG_NO}"/> <a class="inquire" target="_blank" title="새창으로" href="http://www.loanconsultant.or.kr/source/index.jsp">저축은행 상담사 조회</a></dd>
    	    		</dl>
    			</div>
            </div>

            <div class="loan-apply linet-c">
                <div class="loan-step">
                    <div class="btn-shortcuts">
                        <a class="de-mobile loading" onclick="retailYn()"><img src="<c:url value="/resources/mobile/images/main/text_apply_btn01.png"/>" alt="간편 대출신청 바로가기" /></a>
                        <a class="de-tablet loading" onclick="retailYn()"><img src="<c:url value="/resources/mobile/images/main/text_apply_btn02.png"/>" alt="간편 대출신청 바로가기" /></a>
                    </div>
                    <div class="step-img">
                        <span class="de-mobile"><img src="<c:url value="/resources/mobile/images/main/img_step.png"/> " alt="예가람저축은행의 신속하고 간편한 대출절차" /></span>
                        <div class="de-tablet">
                            <span class="pink"><img src="<c:url value="/resources/mobile/images/main/img_step_pink.png"/>" alt="예가람저축은행의 신속하고 간편한 대출절차" /></span>
                            <span class="purple"><img src="<c:url value="/resources/mobile/images/main/img_step_purple.png"/>" alt="예가람저축은행의 신속하고 간편한 대출절차" /></span>
                            <p class="blind">예가람저축은행의 신속하고 간편한 대출절차를 만나보세요!</p>
                        </div>
                        <ol class="blind">
                            <li>온라인대출신청</li>
                            <li>대출심사</li>
                            <li>대출송금</li>
                        </ol>
                    </div>
                </div>
                <div class="btn-apply">
                    <a class="pink loading" onclick="retailYn()"><img src="<c:url value="/resources/mobile/images/main/btn_loan_apply_magenta.png"/>" alt="간편 대출신청하기" /></a>
                    <a class="purple loading" onclick="retailYn()"><img src="<c:url value="/resources/mobile/images/main/btn_loan_apply_purple.png"/>" alt="간편 대출신청하기" /></a>
                </div>
            </div>

    		<div class="main-prod swiper-container">
    		    <div class="swiper-wrapper">
					<div class="swiper-slide"><a href="#none"><img src="<c:url value="/resources/mobile/images/main/img_bnn_intro_2.png"/>" alt="은행소개" /></a></div>
					<c:forEach var="product" items="${productList}">
					<c:if test="${product.NTREE_PROD_CODE ne 'GL999' and product.NTREE_PROD_CODE ne 'GL085' and product.NTREE_PROD_CODE ne 'GL998' }">
					<div class="swiper-slide">
						<a href="#none" onclick="showProduct('${product.CODE}'); return false;">
							<img src="<c:url value="/${dsrId}/images/${product.IMG_DSR_MOBILE}"/>" alt="${product.NAME}" />
						</a>
					</div>
					</c:if>
					</c:forEach>
    		    </div>
    		    <!-- Add Pagination -->
    		    <div class="swiper-pagination"></div>
    		</div>

    		<ul class="etc-menu">
    			<li>
					<a class="loading" href="<c:url value="/${dsrId}/cs/protection"/>">
						<img src="<c:url value="/resources/mobile/images/main/text_menu01.png"/>" alt="금융소비자보호" />
					</a>
				</li>
    			<li><a class="loading" href="<c:url value="/${dsrId}/cs/unfair"/>"><img src="<c:url value="/resources/mobile/images/main/text_menu02.png"/>" alt="부당행위 신고" /></a></li>
    			<li><a class="loading" href="<c:url value="/${dsrId}/cs/branchInfo"/>"><img src="<c:url value="/resources/mobile/images/main/text_menu03.png" />" alt="지점안내" /></a></li>
    			<li><a class="loading" href="<c:url value="/${dsrId}/cs/pds"/>"><img src="<c:url value="/resources/mobile/images/main/text_menu04.png" />" alt="약관&#47;서식자료실" /></a></li>
    		</ul>

            <div class="btn-loan-apply">
                <a class="pink loading" onclick="retailYn()"><img src="<c:url value="/resources/mobile/images/main/btn_loan_apply_magenta.png"/>" alt="간편 대출신청하기" /></a>
                <a class="purple loading" onclick="retailYn()"><img src="<c:url value="/resources/mobile/images/main/btn_loan_apply_purple.png"/>" alt="간편 대출신청하기" /></a>
            </div>
	        <!-- //e:contents -->
	    </div>
	    <!-- //e: contentsWrap -->

		<!-- ********** //Include ********** -->

	<%@ include file="include/inc_layer_popup.jspf" %>
	<%@ include file="include/inc_body_end.jspf" %>

</html>