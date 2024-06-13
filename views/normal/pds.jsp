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
                location.href = '<c:url value="/${dsrId}/cs/pds?page="/>' + page;
            };
            PageFunc.read = function(elem) {
                var ajax_url = '<c:url value="/${dsrId}/cs/pds/" />' + $(elem).prop('id');
                $.post(ajax_url);
            };
            return PageFunc;
        })(window.PageFunc || {});
    </script>
</head>
<%@ include file="include/inc_body_start.jspf" %>
<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:subVisualWrap -->
    <div id="subVisualWrap" class="sub2-4">
        <div class="breadcrumb">
            <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
            <a href="#" class="depth1 loading"></a>
            <a href="#" class="depth2 loading"></a>
        </div>
        <div class="tit-wrap ta-c">
            <h2 class="font50 mb10">약관&#47;서식 자료실</h2>
            <p class="desc">각종 약관과 서식을 확인 및 다운로드 하실 수 있습니다.</p>
        </div>

    </div>
    <!-- //e:subVisualWrap -->
    <!-- s:contents -->
    <div class="contents default-wrap">
        <div class="reference-wrap">
            <div class="content1 of-hi">
                <div class="table-wrap mb20">
                    <table class="table type1">
                        <caption>신약관&#47;서식 자료실</caption>
                        <colgroup>
                            <col style="width:114px">
                            <col style="width:532px">
                            <col style="width:*">
                            <col style="width:137px">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col" class="ta-c">종류</th>
                            <th scope="col">제목</th>
                            <th scope="col" class="ta-c">다운로드</th>
                            <th scope="col" class="ta-c">등록일</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${pds}">
                        <tr>
                            <td class="ta-c colo">
                                <c:if test="${p.CATEGORY_CD eq 'C000200001'}">
                                <strong>서식</strong>
                                </c:if>
                                <c:if test="${p.CATEGORY_CD eq 'C000200002'}">
                                <strong>약관</strong>
                                </c:if>
                            </td>
                            <td class="font16"><c:out value="${p.TITLE}"/> </td>
                            <td class="ta-c">
                            <a href="<c:url value="/${dsrId}/attach/${p.ATTACH_SEQ}"/>" id="${p.SEQ}" onclick="javascript:PageFunc.read(this)">
                                <button type="button" name="button" class="btn-normal tiny" title="다운로드(예금잔액증명 발급 의뢰서)">파일받기</button>
                            </a>
                            </td>
                            <td class="ta-c"><c:out value="${p.REG_DT}"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="pagination-wrap">
                    <c:if test="${not empty pds}">
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
</div>
<!-- //e: contentsWrap -->

<%@ include file="include/inc_body_end.jspf" %>
</html>

