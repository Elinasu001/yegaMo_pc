<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>

    <script src="<c:url value="/resources/mobile/js/common_bank_calc_util.js"/>" type="text/javascript"></script>
    <script type="text/javascript">
        var pageFunc = {
            /**
             * 계산 결과로 대출 결과 출력
             * @param {Object} result fnCal4의 계산결과
             */
            notifyLoanResult: function (result) {
                    $('#totalLoanMoney').val(bankCalcUtils.addComma(result.originMoney));
                // $('#loanPeriod').html(result.loanPeriod + '개월');
                // $('#holdingPeriod').html(result.holdingPeriod + '개월');
                // $('#loanRate').html(result.loanRate * 100 + '%');
                // $('#repaymentMoney').html(bankCalcUtils.addComma(result.repaymentMoney));
                // $('#interestMoney').html(bankCalcUtils.addComma(result.interestMoney));
                // $('#totalMoney').html(bankCalcUtils.addComma(result.totalMoney));

                $("#loanResult").find("> tbody").remove();	//리스트 초기화


                result.table.forEach(function (row, i) {
                    var trStr = "<tr>";
                    trStr += "<td class='ta-c' scope='row'>" + (i + 1) + "</td>";
                    trStr += "<td class='ta-c'>" + bankCalcUtils.addComma(row.repaymentTotalMoney) + "</td>";
                    trStr += "<td class='ta-c'>" + bankCalcUtils.addComma(row.repaymentOriginMoney) + "</td>";
                    trStr += "<td class='ta-c'>" + bankCalcUtils.addComma(row.repaymentInterestMoney) + "</td>";
                    trStr += "<td class='ta-c'>" + bankCalcUtils.addComma(row.remainMoney) + "</td>";
                    trStr += "</tr>";
                    $("#loanResult").append(trStr);
                });
            },
            isInt: function (val) {
                return val % 1 === 0;
            }
        };

        $(function () {
            $('#inquiryBtn').on('click', function () {
                var loanType = $('#loanType option:selected').val();
                var money = Number(bankCalcUtils.removeComma($('#money').val()));
                var loanPeriod = Number($('#month option:selected').val());
                var holdingPeriod = Number($('#holdingPeriod option:selected').val());
                var rate = Number($('#interest').val());

                if (isNaN(money) || money === 0) {
                    customAlert({title: "알림", message: "대출금액을 입력해주세요."});
                    return;
                } else if (isNaN(loanPeriod) || loanPeriod === 0) {
                    customAlert({title: "알림", message: "대출기간을 입력해주세요."});
                    return;
                } else if (!pageFunc.isInt(loanPeriod)) {
                    customAlert({title: "알림", message: "대출기간을 정수로 입력해주세요."});
                    return;
                } else if (money > 1000000000) {
                    customAlert({title: "알림", message: "대출원금을 10억 이하로 입력해 주세요."});
                    return;
                } else if (loanPeriod > 60) {
                    customAlert({title: "알림", message: "대출기간은 최대 60개월까지 입력가능합니다."});
                    return;
                } else if (isNaN(rate) || rate === 0) {
                    customAlert({title: "알림", message: "대출금리을 입력해주세요."});
                    return;
                } else if (rate > 30) {
                    customAlert({title: "알림", message: "대출금리는 최대 30%입니다."});
                    return;
                } else if (isNaN(holdingPeriod)) {
                    customAlert({title: "알림", message: "거치기간을 정확히 입력해주세요."});
                    return;
                } else if (!pageFunc.isInt(holdingPeriod)) {
                    customAlert({title: "알림", message: "거치기간을 정수로 입력해주세요."});
                    return;
                } else if (holdingPeriod > 60) {
                    customAlert({title: "알림", message: "거치기간은 최대 60개월까지 입력가능합니다."});
                    return;
                } else if (loanType == '0' && holdingPeriod > 0) {
                    customAlert({title: "알림", message: "원금만기일시상환은 거치기간 입력이 불가능합니다."});
                    return;
                } else if (holdingPeriod >= loanPeriod) {
                    customAlert({title: "알림", message: "거치기간이 대출기간보다 크거나 같을 수 없습니다."});
                    return;
                }

                var result = bankCalcUtils.fnCal4(loanType, money, loanPeriod, holdingPeriod, rate / 100);

                pageFunc.notifyLoanResult(result);

                $('.result-wrap').show();
            });
            $('#reInquiryBtn').on('click', function () {
                $('.result-wrap').hide();
            });

            $('#money').change(function () {
                $(this).val(bankCalcUtils.addComma($(this).val()))
            });
        });
    </script>

</head>
<%@ include file="include/inc_body_start.jspf" %>
<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:contents -->
    <div class="sub-contents default-wrap">
        <div class="calculator-wrap">
            <h3 class="tit">대출계산기 정보입력</h3>
            <div class="form-wrap">
                <p class="input-tit font13 color-351B6F">상환방법</p>
                <div class="select-wrap">
                    <select id="loanType" name="">
                        <option selected="selected" value="1">원금균등상환</option>
                        <option value="2">원리금균등상환</option>
                        <option value="0">원금만기일시상환</option>
                    </select>
                </div>
            </div>
            <div class="form-wrap">
                <p class="input-tit font13 color-351B6F">대출금액</p>
                <input type="text" name="" value="" id="money" placeholder="숫자로 입력하세요">
                <div class="unit-txt">원</div><!--단위 텍스트가 있을때-->
            </div>
            <div class="form-wrap">
                <p class="input-tit font13 color-351B6F">이자율</p>
                <input type="number" name="" value="" id="interest" placeholder="숫자로 입력하세요">
                <div class="unit-txt">%</div><!--단위 텍스트가 있을때-->
            </div>
            <div class="form-wrap date-wrap of-hi" style="display:none">
                <p class="input-tit font13 color-351B6F">대출일</p>
                <div class="date1 fl-l mr10">
                    <div class="select-wrap">
                        <select name="">
                            <option selected="selected" value="">2018년</option>
                            <option value="">2018년</option>
                        </select>
                    </div>
                </div>
                <div class="date2 fl-l mr10">
                    <div class="select-wrap">
                        <select name="">
                            <option selected="selected" value="">2월</option>
                            <option value="">1월</option>
                        </select>
                    </div>
                </div>
                <div class="date3 fl-l">
                    <div class="select-wrap">
                        <select name="">
                            <option selected="selected" value="">13일</option>
                            <option value="">13일</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="form-wrap">
                <p class="input-tit font13 color-351B6F">대출기간</p>
                <div class="select-wrap">
                    <select id="month" name="">
                        <option selected="selected" value="">개월을 선택하세요</option>
                        <option value="3">3개월</option>
                        <option value="6">6개월</option>
                        <option value="9">9개월</option>
                        <option value="12">12개월</option>
                        <option value="24">24개월</option>
                        <option value="36">36개월</option>
                        <option value="48">48개월</option>
                        <option value="60">60개월</option>
                    </select>
                </div>
            </div>
            <div class="form-wrap">
                <p class="input-tit font13 color-351B6F mt20">거치기간</p>
                <div class="select-wrap">
                    <select id="holdingPeriod" name="">
                        <option selected="selected" value="">거치기간을 선택해주세요.</option>
                        <option value="3">3개월</option>
                        <option value="6">6개월</option>
                        <option value="9">9개월</option>
                        <option value="12">12개월</option>
                        <option value="24">24개월</option>
                        <option value="36">36개월</option>
                        <option value="48">48개월</option>
                        <option value="60">60개월</option>
                    </select>
                </div>
            </div>
            <p class="ta-c mt30">
                <button type="button" name="button" id="inquiryBtn" class="btn-normal pink">조회하기</button>
            </p>

            <!-- s:계산결과 -->
            <div class="result-wrap mt30" style="display: none"> <!-- 결과영역 숨길경우 class명 추가 : 'hide' -->
                <p class="font20 color-333333 mb20">계산결과</p>
                <div class="form-wrap mt20">
                    <p class="input-tit font13 color-351B6F">대출원금</p>
                    <input type="text" name="" value="200,000,000" id="totalLoanMoney" disabled>
                    <div class="unit-txt">원</div><!--단위 텍스트가 있을때-->
                </div>
                <div class="table-wrap mt10 mb30">
                    <table id="loanResult" class="table type1">
                        <caption>대출계산기 계산결과</caption>
                        <colgroup>
                            <col style="width:14%">
                            <col style="width:19%">
                            <col style="width:23%">
                            <col style="width:17%">
                            <col style="width:*">
                            <col style="*">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col" class="ta-c">회차</th>
                            <th scope="col" class="ta-c">상환금</th>
                            <th scope="col" class="ta-c">납입원금</th>
                            <th scope="col" class="ta-c">이자</th>
                            <th scope="col" class="ta-c">대출잔액</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="ta-c">1</td>
                            <td class="ta-c">238,116</td>
                            <td class="ta-c">230,000</td>
                            <td class="ta-c">7,800</td>
                            <td class="ta-c">2,038,116</td>
                        </tr>
                        <tr>
                            <td class="ta-c">2</td>
                            <td class="ta-c">238,116</td>
                            <td class="ta-c">230,000</td>
                            <td class="ta-c">7,800</td>
                            <td class="ta-c">2,038,116</td>
                        </tr>
                        <tr>
                            <td class="ta-c">3</td>
                            <td class="ta-c">238,116</td>
                            <td class="ta-c">230,000</td>
                            <td class="ta-c">7,800</td>
                            <td class="ta-c">2,038,116</td>
                        </tr>
                        <tr>
                            <td class="ta-c">4</td>
                            <td class="ta-c">238,116</td>
                            <td class="ta-c">230,000</td>
                            <td class="ta-c">7,800</td>
                            <td class="ta-c">2,038,116</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <p class="ta-c">
                    <button type="button" name="button" id="reInquiryBtn" class="btn-normal gray">다시 계산하기</button>
                </p>
            </div>
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
</div>
<!-- //e: contentsWrap -->

<%@ include file="include/inc_body_end.jspf" %>

</html>

