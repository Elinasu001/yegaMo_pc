<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="../include/inc_header.jspf" %>
    <script type="text/javascript">var isInstallCheck = false;</script>
</head>
<body>
<!-- <body class="color-type2"> 타입별 -->
<!-- ********** Include ********** -->
<!-- s:bg -->
<div class="bg1">
    <img src="<c:url value="../../../../resources/normal/images/common/bg1.gif"/>">
</div>
<div class="bg2">
    <img src="<c:url value="../../../../resources/normal/images/common/bg2.gif"/>">
</div>
<!-- //e:bg -->
<!-- ********** //Include ********** -->
<!-- ********** Include ********** -->
<!-- s:skipnavi -->
<ul id="skipnavi">
    <li><a href="#gnb">메뉴 바로가기</a></li>
    <li><a href="#contentsWrap">본문 바로가기</a></li>
    <li><a href="#footerWrap">하단 바로가기</a></li>
</ul>
<!-- ********** //Include ********** -->
<!-- //e:skipnavi -->
<!-- s:wrap -->
<div id="wrap">
    <!-- ********** Include ********** -->
    <!-- s:header -->
    <div id="headerWrap">
        <div class="header">
            <h1>
                <a href="#">
                    <img src="<c:url value="/resources/normal/images/common/img_logo_20191119.png"/>" alt="Yegaram Savings Bank 예가람저축은행"/>
                </a>
            </h1>
        </div>
    </div>
    <!-- //e:header -->
    <!-- ********** //Include ********** -->

    <!-- s contentsWrap -->
    <div id="contentsWrap">
        <!-- s:subVisualWrap -->
        <div id="subVisualWrap" class="sub4-2">
            <div class="breadcrumb">
                <a href="#" class="home ir">홈</a>
            </div>
            <div class="tit-wrap ta-c">
                <h2 class="font50 mb10">사이트 접속불가</h2>
                <p class="desc">에러페이지 안내</p>
            </div>
        </div>
        <!-- //e:subVisualWrap -->
        <!-- s:contents -->
        <div class="contents default-wrap">
            <div class="error-wrap">
                <p>현재 해당 예가람저축은행 모집인상담사 사이트는 <strong><font color="red">당월 대출 신청건이 초과</font></strong>하여 접속이 불가능합니다.<br>감사합니다.</p>
            </div>
        </div>
        <!-- //e:contents -->
        <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
    </div>
    <!-- //e: contentsWrap -->
    <!-- ********** Include ********** -->
    <!-- s footerWrap -->
    <div id="footerWrap" class="error-footer">
        <div class="footer default-wrap">
            <div class="copyright"> 
                <p>예가람저축은행&nbsp;&nbsp;|&nbsp;&nbsp;사업자등록번호 : <c:out value="${_PROPS.BIZ_NO.VALUE}"/> &nbsp;&nbsp;|&nbsp;&nbsp;주소 : <c:out value="${_PROPS.ADDR.VALUE}"/>&nbsp;&nbsp;|&nbsp;&nbsp;고객지원팀 : <c:out value="${_PROPS.SRVC_CNTR.VALUE}"/>&nbsp;&nbsp;|&nbsp;&nbsp;금융사기 야간콜센터 : <c:out value="${_PROPS.CALL_CENTER.VALUE}"/><br>
                    준법감시인 심의필 <c:out value="${_PROPS.DELIBERATION.VALUE}"/>&nbsp;&nbsp;|&nbsp;&nbsp;Copyright © 2018 Yegaram Savings Bank. All Rights Reserved.</p>
            </div>
            <div class="footer-logo">
                <img src="<c:url value="/resources/normal/images/common/img_footer_logo_20191119.png"/>" alt="Yegaram Savings Bank 예가람저축은행">
            </div>
        </div>
    </div>
    <!-- //e:footerWrap -->
    <!-- ********** //Include ********** -->
</div>
<!-- //e:wrap -->
</body>
</html>
