<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>
</head>
<%@ include file="include/inc_body_start.jspf" %>
<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:contents -->
    <div class="sub-contents default-wrap">
        <div class="unfair-wrap">
            <h3 class="tit">신고 연락처 안내</h3>
            <div class="info-txt ta-c mb30">
                <p class="font20 color-333333 mb10">고객님께 딴딴한 약속을<br/>드리는 흥국금융가족<br/>예가람저축은행이 되겠습니다.</p>
                <p class="font12 color-626C74">부당행위 발생시 대출모집법인 소비자보호담당자 또는 예가람저축은행 소비자보호담당자에게 연락바랍니다.</p>
            </div>
            <div class="ta-c">
                <!-- 180424 수정 -->
                <div class="manager-area mb10">
                    <div class="d-inline-block">
                        <p class="color-612885 font20 mb10">대출모집법인<br>소비자보호 담당자</p> <!-- 180504 br태그 추가 -->
                        <p class="color-333333 font26 mb5"><a href="tel:${corpUser.CNSM_PROTECT_CHARGE}"><c:out value="${corpUser.CNSM_PROTECT_CHARGE}"/></a></p> <!-- 180403 a태그 추가 -->
                        <hr class="bg-EC008C">
                        <hr class="bg-EC008C">
                    </div>
                </div>
                <div class="manager-area">
                    <div class="d-inline-block">
                        <p class="color-612885 font20 mb10">예가람저축은행<br>소비자보호 담당자</p> <!-- 180504 br태그 추가 및 띄어쓰기 -->
                        <p class="color-333333 font26 mb5"><a href="tel:${_PROPS.CONSUMER_MGR_TEL.VALUE}"><c:out value="${_PROPS.CONSUMER_MGR_TEL.VALUE}"/></a></p> <!-- 180403 a태그 추가 -->
                        <hr class="bg-EC008C">
                        <hr class="bg-EC008C">
                    </div>
                </div>
                <!-- //180424 수정 -->
            </div>
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
</div>
<!-- //e: contentsWrap -->
<%@ include file="include/inc_body_end.jspf" %>
</html>
