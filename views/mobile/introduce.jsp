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
            <div class="introduce-wrap">
                <div class="counselor mb30">
                    <div class="photo">
                    <c:if test="${not empty dsrUser.PHOTO_SEQ}">
                        <img src="<c:url value="/${dsrId}/attach/${dsrUser.PHOTO_SEQ}"/>" alt="상담사 사진">
                    </c:if>
                    </div>
                    <p class="info-txt font20">안녕하세요?<br/>저는 예가람저축은행과<br/>대출모집위탁계약을 체결한<br/>
                        <span class="color-EC008C">대출모집법인 <c:out value="${dsrUser.CORP_NM}"/><br/>소속 대출상담사
                            <br/> <c:out value="${dsrUser.NAME}"/>입니다.</span></p>
                </div>
                <div class="counselor-info">
                    <div class="list-tit mb10">상담사 정보</div>
                    <ul class="list type1 mb30">
                        <li><span>전화번호</span><a href="tel:${dsrUser.REP_TEL_NO}"><c:out value="${dsrUser.REP_TEL_NO}"/></a></li>
                        <li><span>저축은행중앙회 등록번호</span><c:out value="${dsrUser.FSB_REG_NO}"/></li>
                    </ul>
                    <div class="list-tit mb10">위탁사</div>
                    <ul class="list type1 mb30">
                        <li><span>예가람저축은행</span>관리담당자 <a href="tel:${_PROPS.CONSUMER_MGR_TEL.VALUE}">
                            <c:out value="${_PROPS.CONSUMER_MGR_TEL.VALUE}"/>
                        </a></li>
                    </ul>
                    <div class="list-tit mb10">대출모집위탁법인(수탁사)</div>
                    <ul class="list type1 mb20">
                        <li><span>법인명</span><c:out value="${corpUser.NAME}"/></li>
                        <li><span>등록번호</span><c:out value="${corpUser.FSB_REG_NO}"/> (저축은행중앙회 등록번호)</li>
                        <li><span>주소</span><c:out value="${corpUser.ADDR}"/> <c:out value="${corpUser.ADDR_DETAIL}"/></li>
                        <li><span>전화번호</span><a href="tel:${corpUser.REP_TEL_NO}"><c:out value="${corpUser.REP_TEL_NO}"/></a></li>
                    </ul>
                </div>
                <hr class="mb5">
                <p class="font12">
                    ※ 주의사항<br>
                    - 상기인은 저축은행중앙회에 등록된 대출상담사 입니다.<br>
                    <span>- 대출진행시 대출모집인은 고객에게 별도의 수수료를 요구하거나 수취할수 없습니다. 요구 시 위탁사(예가람저축은행 <a href="tel:<c:out value="${_PROPS.SRVC_CNTR.VALUE}"/>"><c:out value="${_PROPS.SRVC_CNTR.VALUE}"/></a> 또는 <a href="tel:<c:out value="${_PROPS.CALL_CENTER.VALUE}"/>"><c:out value="${_PROPS.CALL_CENTER.VALUE}"/></a>)로 연락주시기 바랍니다.</span><br>
                    <span>- 대출 취급에 대한 결정은 위탁사(예가람저축은행 대출심사자)의 고유권한으로 대출모집상담사는 취급여부를 결정할 수 없습니다.</span>
                </p>
                <p class="font13 mt20 mb40">준법감시인 심의필 <c:out value="${_PROPS.DELIBERATION.VALUE}"/></p>
                <div class="btn-wrap">
                    <a href="http://www.loanconsultant.or.kr" class="btn-normal pink" title="새창으로" target="_blank">대출모집법인 및 상담사 조회</a>
                </div>
            </div>
        </div>
        <!-- //e:contents -->
        <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
    </div>
    <!-- //e: contentsWrap -->

    <%@ include file="include/inc_body_end.jspf" %>
</html>
