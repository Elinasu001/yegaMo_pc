<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>

    <script type="text/javascript">

        var currentFullNum = -1;
        var isOpen = false;

        function initBindingEvents() {
            $('.accordion li .question-wrap').off('click');
            $('.accordion li .question-wrap').on('click', function(e) {
                e.preventDefault();
                var num = $('.accordion li').index($(this).parent());
                $('.accordion li').removeClass('active');
                if (currentFullNum == num) {
                    if (isOpen) {
                        $('.accordion > li').removeClass('active');
                        isOpen = false;
                        $(this).next('.answer-wrap').slideUp('fast');
                    } else {
                        $('.accordion > li').eq(num).addClass('active');
                        isOpen = true;
                        $(this).next('.answer-wrap').slideDown('fast');
                    }
                }else {
                    $('.accordion > li').not(':eq(' + num + ')').removeClass('active');
                    $('.accordion > li').eq(num).addClass('active');
                    $('.answer-wrap').slideUp('fast');
                    isOpen = true;
                    $(this).next('.answer-wrap').slideDown('fast');
                }
                currentFullNum = num;
            });
        }

        /**
         * 해당 페이지의 기본 + 주요기능
         */
        var PageFunc = (function(PageFunc) {

            PageFunc.more = function() {

                var ajax_url = '<c:url value="/${dsrId}/cs/faqs" />';

                var morePage = parseInt($('#page').val()) + 1;
                $('#page').val(morePage);

                var ajax_data = $('#frm1').serialize();
                AjaxFunc.ajaxAsync( ajax_url, ajax_data, PageFunc.ajaxSuccess, PageFunc.ajaxError );
            };
            //ajax call result 수신처리(성공)
            PageFunc.ajaxSuccess = function(result) {
                $.each(result.data.article, function(i, faq) {
                    var html = '<li>\n' +
                        '                        <a href="#" class="question-wrap" id="' + faq.SEQ + '" onclick="PageFunc.read(this)">\n' +
                        '                            <span class="category">Q</span>\n' +
                        '                            <span class="con">' + faq.TITLE +'</span>\n' +
                        '                        </a>\n' +
                        '                        <div class="answer-wrap">\n' +
                        '                            <span class="con">' + faq.CONTENTS +'</span>\n' +
                        '                        </div>\n' +
                        '                    </li>';

                    $('.accordion li').last().after(html).slideDown('normal');

                    initBindingEvents();
                    //faq 질문위치
                    $('.reference-wrap .accordion li a').on('click',function(){
                        var topH = $('#headerWrap').height();
                        var index = $('.accordion > li').index($(this).parent());
                        var scrollT = topH + (74*(index));
                        $(window).scrollTop(scrollT-20);
                    });
                });

                if(result.data.paging.finalPageNo == result.data.paging.pageNo) {
                    $('.btn-normal').hide();
                }
            };
            // ajax call result 수신처리(실패)
            PageFunc.ajaxError = function(result) {
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
<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:contents -->
    <div class="sub-contents default-wrap">
        <div class="reference-wrap">
            <h3 class="tit">자주찾는 질문</h3>
            <div class="accordion-wrap mb30">
                <ul class="accordion">
                    <c:forEach var="f" items="${faqs}">
                    <li>
                        <a href="#" class="question-wrap" id="${f.SEQ}" onclick="PageFunc.read(this)">
                            <span class="category">Q</span>
                            <span class="con"><c:out value="${f.TITLE}"/></span>
                        </a>
                        <div class="answer-wrap">
                            <span class="con"><c:out value="${f.CONTENTS}" escapeXml="false"/></span>
                        </div>
                    </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="btn-wrap">
                <form name="frm1" id="frm1">
                <input type="hidden" id="page" name="page" value="${paging.pageNo}" />
                </form>

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
