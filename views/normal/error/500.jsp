<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="../include/inc_header.jspf" %>
    <script type="text/javascript">var isInstallCheck = false;</script>
</head>
    <%@ include file="../include/inc_body_start.jspf" %>
    <!-- s contentsWrap -->
    <div id="contentsWrap">
        <!-- s:subVisualWrap -->
        <div id="subVisualWrap" class="sub4-1">
            <div class="breadcrumb">
                <a href="#" class="home ir">홈</a>
                <a href="#" class="depth1"></a>
                <a href="#" class="depth2"></a>
            </div>
            <div class="tit-wrap ta-c">
                <h2 class="font50 mb10">사이트 에러</h2>
                <p class="desc">에러페이지 안내</p>
            </div>
        </div>
        <!-- //e:subVisualWrap -->
        <!-- s:contents -->
        <div class="contents default-wrap">
            <div class="error-wrap">
                <p>일시적 오류가 발생하였습니다.<br>메인페이지로 이동 후, 다시 이용해 주시길 바랍니다.<br>서비스 이용에 불편을 드려 죄송합니다.</p>
            </div>
        </div>
        <!-- //e:contents -->
        <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
    </div>
    <!-- //e: contentsWrap -->
    <%@ include file="../include/inc_body_end.jspf" %>
</html>
