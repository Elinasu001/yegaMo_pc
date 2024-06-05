<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="home" value="/${dsrId }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>

    <script type="text/javascript">
        /**
         * 해당 페이지의 기본 + 주요기능
         */
        var PageFunc = (function(PageFunc) {
            //[기본버튼]로그인
            PageFunc.goPage = function(page) {
                location.href = '<c:url value="/${dsrId}/cs/faqs?page="/>' + page;
            };
            PageFunc.read = function(elem) {
                var ajax_url = '<c:url value="/${dsrId}/cs/faqs/" />' + $(elem).prop('id');
                $.post(ajax_url);
            };
            return PageFunc;
        })(window.PageFunc || {});
    </script>
</head>
<%@ include file="include/inc_body_start.jspf" %>
<div id="contentsWrap">
    <!-- s:subVisualWrap -->
    <div id="subVisualWrap" class="sub2-5">
        <div class="breadcrumb">
            <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
            <a href="#" class="depth1 loading"></a>
            <a href="#" class="depth2 loading"></a>
        </div>
        <div class="tit-wrap ta-c">
            <h2 class="font50 mb10">FAQ</h2>
            <p class="desc">궁금하신 문제를 가장 빨리 해결해 드리기 위해 제공합니다.</p>
        </div>

    </div>
    <!-- //e:subVisualWrap -->
    <!-- s:contents -->
    <div class="contents default-wrap">
        <div class="reference-wrap">
            <div class="content1 of-hi">
                <div class="accordion-wrap mb20">
                    <ul class="accordion">
                        <c:forEach var="faq" items="${faqs}">
                        <li>
                            <a href="#" class="question-wrap" id="${faq.SEQ}" onclick="PageFunc.read(this)">
                                <span class="category">Q</span>
                                <span class="con"><c:out value="${faq.TITLE}"/></span>
                            </a>
                            <div class="answer-wrap">
                                <span class="con"><c:out value="${faq.CONTENTS}" escapeXml="false"/></span>
                            </div>
                        </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="pagination-wrap">
                    <c:if test="${not empty faqs}">
                    <div class="pagination">
                        <a href="javascript:PageFunc.goPage(${paging.prevPageNo})" class="btn-circle prev nb ir">이전</a>
                        <ul>
                        <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
                        <c:choose>
                            <c:when test="${i eq paging.pageNo}">
                            <li>
                                <a href="javascript:PageFunc.goPage(${i})" class="btn-circle nb active"><c:out value="${i}"/></a>
                            </li>
                            </c:when>
                            <c:otherwise>
                            <li>
                                <a href="javascript:PageFunc.goPage(${i})" class="btn-circle nb"><c:out value="${i}"/></a>
                            </li>
                            </c:otherwise>
                        </c:choose>
                        </c:forEach>
                        </ul>
                        <a href="javascript:PageFunc.goPage(${paging.nextPageNo})" class="btn-circle next nb ir">다음 페이지</a>
                    </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
    <form id="frm1"></form>
</div>

<%@ include file="include/inc_body_end.jspf" %>
</html>


