<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="home" value="/${dsrId }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>
</head>
<%@ include file="include/inc_body_start.jspf" %>
<div id="contentsWrap">
    <!-- s:subVisualWrap -->
    <div id="subVisualWrap" class="sub2-3">
        <div class="breadcrumb">
            <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
            <a href="#" class="depth1 loading"></a>
            <a href="#" class="depth2 loading"></a>
        </div>
        <div class="tit-wrap ta-c">
            <h2 class="font50 mb10">부당행위 신고안내</h2>
            <p class="desc">부당행위 발생시 연락할 수 있는 <br>담당자 연락처를 제공하고 있습니다.</p>
        </div>

    </div>
    <!-- //e:subVisualWrap -->
    <!-- s:contents -->
    <div class="contents default-wrap">
        <div class="unfair-wrap">
            <div class="content1 of-hi">
                <h3 class="tit">신고 연락처 안내</h3>
                <div class="ta-c unfair">
                    <div class="group mb30">
                        <div class="manager-box">
                            <p class="color-612885 font20 mb10">대출모집법인 소비자보호 담당자</p>
                            <p class="color-333333 font26 mb5"><c:out value="${corpUser.CNSM_PROTECT_CHARGE}"/></p>
                            <hr class="bg-EC008C">
                        </div>
                        <div class="manager-box">
                            <p class="color-612885 font20 mb10">예가람저축은행 소비자보호 담당자</p>
                            <p class="color-333333 font26 mb5"><c:out value="${_PROPS.CONSUMER_MGR_TEL.VALUE}"/></p>
                            <hr class="bg-EC008C">
                        </div>
                    </div>
                    <p class="font20 color-333333 mb20">고객님께 딴딴한 약속을 드리는 흥국금융가족 예가람저축은행이 되겠습니다.</p>
                    <p class="font14 color-626C74">부당행위 발생시 대출모집법인 소비자보호담당자 또는 예가람저축은행 소비자보호담당자에게 연락바랍니다.</p>
                </div>
            </div>
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
</div>

<%@ include file="include/inc_body_end.jspf" %>
</html>

