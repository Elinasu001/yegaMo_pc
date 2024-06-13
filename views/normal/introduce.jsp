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
        <!-- s:subVisualWrap -->
        <div id="subVisualWrap" class="sub1-1">
            <div class="breadcrumb">
                <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
                <a href="#" class="depth1 loading"></a>
                <a href="#" class="depth2 loading"></a>
            </div>
            <div class="tit-wrap ta-c">
                <h2 class="font50 mb10">법인 및 상담사 소개</h2>
                <p class="desc">고객님께 딴딴한 약속을 드리는<br> 흥국금융가족 예가람저축은행이 되겠습니다.</p>
            </div>

        </div>
        <!-- //e:subVisualWrap -->
        <!-- s:contents -->
        <div class="contents default-wrap">
            <div class="introduce-wrap">
                <div class="content1 of-hi mb80">
                    <div class="fl-l">
                        <div class="photo">
                            <c:if test="${not empty dsrUser.PHOTO_SEQ}">
                                <img src="<c:url value="/${dsrId}/attach/${dsrUser.PHOTO_SEQ}"/>" alt="상담사 사진">
                            </c:if>
                            <c:if test="${empty dsrUser.PHOTO_SEQ}">
                                <img src="<c:url value="/resources/normal/images/common/ico_woman.png"/>" alt="상담사 사진">
                            </c:if>
                        </div>
                    </div>

                    <div class="fl-r">
                        <p class="font26 mb45">안녕하세요? 항상 최선을 다하는 자세로
                            <br>상담해 드리도록 노력하겠습니다.
                            <br>예가람저축은행과 대출모집위탁계약을 체결한
                            <br>
                            <span class="color-EC008C">대출모집법인 <c:out value="${dsrUser.CORP_NM}"/> 소속 대출상담사 <c:out value="${dsrUser.NAME}"/>입니다.
                            </span>
                        </p>
                        <div class="info-wrap of-hi">
                            <div class="info">
                                <span class="tit font13 color-351B6F">전화번호</span>
                                <span><c:out value="${dsrUser.REP_TEL_NO}"/></span>
                            </div>
                            <div class="info">
                                <span class="tit color-351B6F">저축은행중앙회 등록번호</span>
                                <span><c:out value="${dsrUser.FSB_REG_NO}"/></span>
                            </div>
                        </div>
                    </div>
                   
                </div>
                <div class="content2 of-hi">
                    <div class="fl-l">
                        <div class="list-tit mb10">위탁사</div>
                        <ul class="list type1 mb40">
                            <li><span class="bar">예가람저축은행</span><span class="telNum"></span></li>
                            <script>
                           		var telNum = "${dsrUser.CORP_NM}" == "(주)준민파트너스"? "02-6906-7072 / 02-6906-7054" :  "${dsrUser.CORP_NM}" == "상승플러스(DSR)" ? "02-6906-7072 / 02-6906-7054" : "070-4570-5017";
                            	$('.telNum').html("관리담당자" + " " + telNum);
                            </script>
                        </ul>
                        <div class="list-tit mb10">대출모집위탁법인(수탁사)</div>
                        <ul class="list type1 mb40">
                            <li><span class="bar">법인명</span><c:out value="${corpUser.NAME}"/></li>
                            <li><span class="bar">등록번호</span><c:out value="${corpUser.FSB_REG_NO}"/> (저축은행중앙회 등록번호)</li>
                            <li><span class="bar">주소</span><c:out value="${corpUser.ADDR}"/> <c:out value="${corpUser.ADDR_DETAIL}"/></li>
                            <li><span class="bar">전화번호</span><c:out value="${corpUser.REP_TEL_NO}"/></li>
                        </ul>
                    </div>
                </div>
                <hr class="mb5">
                <p class="font12">
                    ※ 주의사항<br>
                    - 상기인은 저축은행중앙회에 등록된 대출상담사 입니다.<br>
                    - 대출진행시 대출모집인은 고객에게 별도의 수수료를 요구하거나 수취할수 없습니다. 요구 시 위탁사(예가람저축은행 <c:out value="${_PROPS.SRVC_CNTR.VALUE}"/> 또는 <c:out value="${_PROPS.CALL_CENTER.VALUE}"/>)로 연락주시기 바랍니다.<br>
                    - 대출 취급에 대한 결정은 위탁사(예가람저축은행 대출심사자)의 고유권한으로 대출모집상담사는 취급여부를 결정할 수 없습니다.
                </p>
                <p class="font13 mt20 mb40">준법감시인 심의필 <c:out value="${_PROPS.DELIBERATION.VALUE}"/></p>
                <p class="ta-c"><a href="http://www.loanconsultant.or.kr" class="btn-big pink" title="새창으로" target="_blank">대출모집법인 및 대출상담사 조회</a></p>
            </div>
        </div>
        <!-- //e:contents -->
        <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
    </div>
    <!-- //e: contentsWrap -->
    <%@ include file="include/inc_body_end.jspf" %>
</html>

