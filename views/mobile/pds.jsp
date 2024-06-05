<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>

    <script type="text/javascript">
        $(function() {
        });
        /**
         * 해당 페이지의 기본 + 주요기능
         */

        var PageFunc = (function(PageFunc) {

            PageFunc.more = function() {

                var ajax_url = '<c:url value="/${dsrId}/cs/pds" />';

                var morePage = parseInt($('#page').val()) + 1;
                $('#page').val(morePage);

                var ajax_data = $('#frm1').serialize();
                AjaxFunc.ajaxAsync( ajax_url, ajax_data, PageFunc.ajaxSuccess, PageFunc.ajaxError );
            };
            //ajax call result 수신처리(성공)
            PageFunc.ajaxSuccess = function(result) {
                $.each(result.data.article, function(i, pds) {
                    var categoryCdNm = '';
                    if(pds.CATEGORY_CD == 'C000200001')
                        categoryCdNm = '서식';
                    else if(pds.CATEGORY_CD == 'C000200002')
                        categoryCdNm = '약관';

                    var html =
                        '<tr>\n' +
                        '    <td>\n' +
                        '        <ul class="reference-list">\n' +
                        '            <li class="type">' + categoryCdNm + '</li>\n' +
                        '            <li class="name">' + pds.TITLE + '</li>\n' +
                        '            <li>' + pds.REG_DT + '</li>\n' +
                        '        </ul>\n' +
                        '    </td>\n' +
                        '    <td>' +
                        '       <a href="/${dsrId}/attach/'+ pds.ATTACH_SEQ +'" id="'+ pds.SEQ + '" onclick="javascript:PageFunc.read(this)">' +
                        '       <button type="button" name="button" class="btn-normal tiny reference-btn" title="파일받기(예금잔액증명 발급 의뢰서)">파일받기</button>' +
                        '       </a>' +
                        '    </td>\n' +
                        '</tr>';


                    $('tbody tr').last().after(html).slideDown('normal');
                });

                if(result.data.paging.finalPageNo == result.data.paging.pageNo) {
                    $('.btn-wrap .btn-normal').hide();
                }
            };
            // ajax call result 수신처리(실패)
            PageFunc.ajaxError = function(result) {
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
    <!-- s:contents -->
    <div class="sub-contents default-wrap">
        <div class="reference-wrap">
            <h3 class="tit">약관&#47;서식 다운로드</h3>
            <!-- 180518 table 수정 -->
            <div class="table-wrap mb30">
                <table class="table type1 no-bg">
                    <caption>신약관&#47;서식 자료실</caption>
                    <colgroup>
                        <col style="width:*">
                        <col style="width:100px">
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">제목 및 종류</th>
                        <th scope="col" class="ta-c">다운로드</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${pds}">
                    <tr>
                        <td>
                            <ul class="reference-list">
                                <li class="type">
                                    <c:if test="${p.CATEGORY_CD eq 'C000200001'}">서식</c:if>
                                    <c:if test="${p.CATEGORY_CD eq 'C000200002'}">약관</c:if>
                                </li>
                                <li class="name"><c:out value="${p.TITLE}"/></li>
                                <li><c:out value="${p.REG_DT}"/></li>
                            </ul>
                        </td>
                        <td>
                            <a href="/${dsrId}/attach/${p.ATTACH_SEQ}">
                            <button type="button" name="button" class="btn-normal tiny reference-btn">파일받기</button>
                            </a>
                        </td>
                    </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <form name="frm1" id="frm1">
                <input type="hidden" name="page" id="page" value="${paging.pageNo}">
            </form>
            <div class="btn-wrap">
                <c:if test="${paging.finalPageNo ne paging.pageNo}">
                <button type="button" name="button" class="btn-normal form" onclick="javascript:PageFunc.more();">MORE</button>
                </c:if>
            </div>
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
</div>
<!-- //e: contentsWrap -->
<%@ include file="include/inc_body_end.jspf" %>
</html>
