<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>예가람저축은행 모집인 상담사</title>
    <meta charset="utf-8">
    <meta http-equiv="Content-Script-Type" content="text/javascript">
    <meta http-equiv="Content-Style-Type" content="text/css">
    <meta name="keywords" content="예가람저축은행 모집인 상담사" />
    <meta name="description" content="법인 및 상담사 소개, 고객지원팀, 대출신청" />
    <meta name="apple-mobile-web-app-status-bar-style" content="white" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value="/resources/favicon.ico"/>" />
    <link href="<c:url value="/resources/normal/css/jquery.bxslider.css"/>" rel="stylesheet" />
    <link href="<c:url value="/resources/normal/css/default.css"/>" rel="stylesheet" />
    <link href="<c:url value="/resources/normal/css/layout.css"/>" rel="stylesheet" />
    <link href="<c:url value="/resources/normal/css/contents.css"/>" rel="stylesheet" />
    <script src="<c:url value="/resources/normal/js/jquery-1.11.3.min.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/resources/normal/js/TweenMax.min.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/resources/normal/js/jquery.bxslider.min.js"/>" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script src="<c:url value="/resources/normal/js/respond.min.js"/>"></script>
    <script src="<c:url value="/resources/normal/js/html5.js"/>"></script>
    <![endif]-->
    <script src="<c:url value="/resources/normal/js/default.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/resources/normal/js/ui.js"/>" type="text/javascript"></script>

    <script type="text/javascript" src="<c:url value="/resources/normal/js/common_ajax.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/normal/js/common_pagevalidate.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/resources/normal/js/common_util.js"/>"></script>

    <!-- s:depth setting -->
    <script>
        var depth1 = "사이트 접속불가";//1~3 없는 메뉴는 메뉴명 기입
        var depth2 = 1;//없으면 0
    </script>
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
                <a href="#" class="depth1"></a>
                <a href="#" class="depth2"></a>
            </div>
            <div class="tit-wrap ta-c">
                <h2 class="font50 mb10">안내</h2>
<!--                 <p class="desc">에러페이지 안내</p> -->
            </div>
        </div>
        <!-- //e:subVisualWrap -->
        <!-- s:contents -->
        <div class="contents default-wrap">
            <div class="error-wrap">
                <p style="text-align:left;">안정적인 서비스 제공을 위하여 대출 및 각종 신청/조회, 전자약정 업무가 일시 중단될 예정입니다.</p>
<p style="text-align:left;">이용에 참고하시기 바랍니다.</p><br>
<p style="text-align:left;">서비스 이용에 불편을 드려 죄송합니다.</p>
<p style="text-align:left;">앞으로 더 좋은 서비스로 보답하고자 노력하겠습니다.</p><br>
<p style="text-align:left;color:#ec008c;"> * 업무 중단 시간 </p>
<p style="text-align:left;color:#ec008c;"> - 2019.03.16(토) 09:00 ~ 17:00 (약 8시간)</p> 
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
                <%--<p class="mb15">상시인은 예가람저축은행과 대출모집업무 위탁계약을 체결한 ㈜***** 대출모집법인 소속으로 저축은행중앙회에 등록된 대출상담사 입니다.<br>  또한 대출 진행시 고객에게 별도의 수수료를 요구하거나 수취하지 않으며, 대출이자 또는 원금연체시 신용상의 불이익이 있을 수 있습니다.<br>  대출모집법인 소비자보호 담담자 / 예가람저축은행 소비자보호담당자 : 홍길동 070-1234-1234</p>--%>
                <p>예가람저축은행&nbsp;&nbsp;|&nbsp;&nbsp;사업자등록번호 : 107-86-66267&nbsp;&nbsp;|&nbsp;&nbsp;주소 :  서울시 강남구 테헤란로 419&nbsp;&nbsp;|&nbsp;&nbsp;고객지원팀 : 1877-7788&nbsp;&nbsp;|&nbsp;&nbsp;금융사기 야간콜센터 (02)3978-600,800<br>   준법감시인 심의필 제2018-025호(2018.05.23)&nbsp;&nbsp;|&nbsp;&nbsp;Copyright © 2018 Yegaram Savings Bank. All Rights Reserved.</p>
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
