<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="home" value="/${dsrId }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="../include/inc_header.jspf" %>
<style>
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

</style>
</head>
<%@ include file="../include/inc_body_start.jspf" %>
        <!-- s contentsWrap -->
        <div id="contentsWrap">
            <!-- s:subVisualWrap -->
            <div id="subVisualWrap" class="sub3-1">
                <div class="breadcrumb">
                    <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
                    <a href="#" class="depth1 loading"></a>
                    <a href="#" class="depth2 loading"></a>
                </div>
                <div class="tit-wrap ta-c">
                    <h2 class="font50 mb10">대출신청</h2>
                    <p class="desc">예가람저축은행의 대출신청 프로세스입니다.</p>
                </div>
            </div>
            <!-- //e:subVisualWrap -->
            <!-- s:contents -->
            <div class="contents default-wrap">
                <div class="loan-wrap">
                    <div class="content1 of-hi">
                        <div class="step-wrap mb60">
                            <ul>
                                <li class="step02"><span>01<strong>신청정보 입력</strong></span></li>
                        		<li class="step03 active"><span>02<strong>대출신청 완료</strong></span></li>
                            </ul>
                        </div>
                        <h3 class="tit">대출신청 완료</h3>
                        <!-- 180615 추가 -->
                        <div class="cts-box mb40">
	                        <p class="box-info"><span class="accent3">${name }</span> 고객님의 <span class="accent3">대출신청</span>이 <span class="accent3">완료</span>되었습니다</p>
	                        <p class="box-txt">입력해 주신 연락처로 빠른 시일내에 연락드리겠습니다.</p>
	                        <p class="box-desc">자세한 사항은 <strong class="accent2">고객지원팀 1877-7788</strong>로 연락부탁드립니다. ( 상담가능시간 09:00~18:00 )</p>
                        </div>
                        <!-- 180615 추가 -->
                        <!-- 180615 div.comp-wrap 삭제 -->
                        <p class="ta-c">
                            <button type="button" name="button" class="btn-big pink" onclick="location.href='<c:url value="${home}" />'">확인</button>
                        </p>
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
