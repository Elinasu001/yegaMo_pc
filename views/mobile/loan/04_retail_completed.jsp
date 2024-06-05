<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="main" value="/${dsrId }" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="../include/inc_header.jspf" %>
</head>
<%@ include file="../include/inc_body_start.jspf" %>
	    <!-- s contentsWrap -->
	    <div id="contentsWrap">
	        <!-- s:contents -->
	        <div class="sub-contents default-wrap">
	        	<div class="loan-wrap">
	        		<ol class="loan-step clear mb30">
	        			<li class="step02">개인정보 및 대출정보입력</li>
	        			<li class="step03">약관동의 및 본인인증</li>
	        			<li class="step04 on">대출신청 완료</li>
	        		</ol>
                    <div class="completed-wrap">
                        <h3 class="tit">대출신청 완료</h3>
	                    <div class="cts-box">
		                    <p class="box-info"><span class="accent3">${cust_nm }</span> 고객님의<br><span class="accent3">대출신청</span>이 <span class="accent3">완료</span> 되었습니다</p>
		                    <p class="box-txt">입력해 주신 연락처로 빠른 시일내에 연락드리겠습니다.</p>
	                    </div>
                        <div class="info-txt ta-c mb30">
	                        <%--<p class="font20 color-333333 mb10">고객님의 예가람저축은행<br/>인터넷 대출신청이 완료되었습니다.<br/><span>입력해 주신 연락처로 빠른<br/>시일내에 연락드리겠습니다.</span></p>--%>
	                        <p>자세한 사항은 <strong class="accent2">고객지원팀 1877-7788</strong>로 연락부탁드립니다.<br/>( 상담가능시간 09:00~18:00 )</p>
                        </div>
                        <hr class="mb30">
                        <div class="btn-wrap">
                        	<a href="<c:url value="${main }"/>" class="btn-normal pink">메인으로 돌아가기</a>
                        </div>
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