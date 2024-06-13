<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="home" value="/${dsrId }" />
<c:set var="next" value="/${dsrId }/loan/01_loan_step2" />
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/inc_header.jspf" %>
<%@ include file="../../include/loan/step1.jspf" %>
</head>
<%@ include file="../include/inc_body_start.jspf" %>
        <!-- s contentsWrap -->
        <div id="contentsWrap">
            <!-- s:subVisualWrap -->
            <div id="subVisualWrap" class="sub3-1">
                <div class="breadcrumb">
                    <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
                    <a href="#" class="depth1 loading"></a>
                    <a href="#" class="depth2 loading"></a>
                </div>
                <div class="tit-wrap ta-c">
                    <h2 class="font50 mb10">대출신청</h2>
                    <p class="desc">예가람저축은행의 대출신청 프로세스입니다.</p>
                </div>
            </div>
            <!-- //e:subVisualWrap -->
            <!-- s:contents -->
            <div class="contents default-wrap">
                <div class="loan-wrap">
                    <div class="content1 of-hi">
                        <div class="step-wrap mb60">
                            <ul>
                                <li class="step1"><img src="<c:url value="/resources/normal/images/page/img_step1_on.png"/>" alt="상담사 설명확인"></li>
                                <li class="step2"><img src="<c:url value="/resources/normal/images/page/img_step2_off.png"/>" alt="신청정보 입력"></li>
                                <li class="step3"><img src="<c:url value="/resources/normal/images/page/img_step3_off.png"/>" alt="대출신청완료"></li>
                            </ul>
                        </div>
                        <h3 class="tit">상담사 설명확인</h3>
                        <p class="ta-c font20 color-333333 mb40">
                            금융회사는 대출모집상담사를 통해 접수된 대출의 경우, “대출모집인 제도 모범규준 <br>
                            제 10조 제 1항 2호”에 따라 대출 실행 이전에 대출신청인에게 아래 각 사항을 확인하여야 합니다.<br>
                            아래의 질문사항에 대하여 직접 사실대로 작성하여 주시기 바랍니다.</p>
                        <form id="frm1" onsubmit="next(); return false;">
                            <div class="question-list bor-line-gray">
                                <ol>
                                    <li>
                                        <span class="num">1.</span>
                                        <span class="cont">혹시 지금 진행하시는 대출이, 금융회사직원이라며 전화나 문자를 받아진행하고 계신가요?</span>
                                        <span class="radio-area">
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio1" id="radio1Y" value="Y">
                                                <label for="radio1Y">예</label>
                                            </span>
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio1" id="radio1N" value="N">
                                                <label for="radio1N">아니오</label>
                                            </span>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="num">2.</span>
                                        <span class="cont">햇살론 등 저금리의 서민지원대출로 바꿔준다고 해서 대출을 받으라고 하던가요?</span>
                                        <span class="radio-area">
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio2" id="radio2Y" value="Y">
                                                <label for="radio2Y">예</label>
                                            </span>
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio2" id="radio2N" value="N">
                                                <label for="radio2N">아니오</label>
                                            </span>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="num">3.</span>
                                        <span class="cont">혹시 대출을 받고 바로 상환하면 신용등급이 올라 저금리로 대출이 가능하다고 하던가요?</span>
                                        <span class="radio-area">
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio3" id="radio3Y" value="Y">
                                                <label for="radio3Y">예</label>
                                            </span>
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio3" id="radio3N" value="N">
                                                <label for="radio3N">아니오</label>
                                            </span>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="num">4.</span>
                                        <span class="cont">출처가 불분명한 어플리케이션을 설치하셨습니까?</span>
                                        <span class="radio-area">
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio4" id="radio4Y" value="Y">
                                                <label for="radio4Y">예</label>
                                            </span>
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio4" id="radio4N" value="N">
                                                <label for="radio4N">아니오</label>
                                            </span>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="num">5.</span>
                                        <span class="cont">검찰 등을 사칭하는 자에게 개인정보를 제공하셨습니까?</span>
                                        <span class="radio-area">
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio5" id="radio5Y" value="Y">
                                                <label for="radio5Y">예</label>
                                            </span>
                                            <span class="ctm-radio">
                                                <input type="radio" name="radio5" id="radio5N" value="N">
                                                <label for="radio5N">아니오</label>
                                            </span>
                                        </span>
                                    </li>
                                </ol>
                            </div>
                        </form>
                        <p class="ta-c">
                            <button id="btn_next" name="button" class="btn-big" onclick="next()">다음단계</button>
                            <button type="button" name="button" class="btn-big re ir" onclick="location.href = '<c:url value="${home}"/>'">메인으로</button>
                        </p>
                    </div>
                </div>
            </div>
            <!-- //e:contents -->
            <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
        </div>
        <!-- //e: contentsWrap -->
        <!-- ********** Include ********** -->
        <%@ include file="../include/inc_body_end.jspf" %>
        <!-- ********** //Include ********** -->
    <!-- //e:wrap -->
</html>
