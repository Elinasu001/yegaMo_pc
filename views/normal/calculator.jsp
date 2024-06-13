<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="home" value="/${dsrId }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>
    <link href="<c:url value="/resources/normal/css/jquery-ui.css"/>" rel="stylesheet"/>
    <script src="<c:url value="/resources/normal/js/jquery-ui.js"/>" type="text/javascript"></script>
    <script src="<c:url value="/resources/normal/js/common_bank_calc_util.js"/>" type="text/javascript"></script>
    <script type="text/javascript">
        var pageFunc = {
            /**
             * 계산 결과로 대출 결과 출력
             * @param {Object} result fnCal4의 계산결과
             */
            notifyLoanResult: function (result) {
                // $('#originMoney').html(bankCalcUtils.addComma(result.originMoney));
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
                    trStr += "<td class='ta-c'>" + bankCalcUtils.addComma(row.repaymentOriginMoneySum) + "</td>";
                    trStr += "<td class='ta-c'>" + bankCalcUtils.addComma(row.remainMoney) + "</td>";
                    trStr += "</tr>";
                    $("#loanResult").append(trStr);
                });

                setTimeout(function () {
                    var offset = $("#divResult").offset();
                    $('html, body').animate({scrollTop: offset.top + 20}, 400);
                }, 100);

            },
            isInt: function (val) {
                return val % 1 === 0;
            }
        };
        $(function () {
            //대출금액
            $("#monthMoneySlider").slider({
                range: "min",
                value: removeComma($("#money").val()),
                min: 0,
                max: 1000000000,
                disabled: false,
                step: 10000,
                slide: function (event, ui) {
                    $("#money").val(addComma(ui.value));
                }
            });
            $("#money").change(function () {
                var value = removeComma(this.value);
                $("#monthMoneySlider").slider("value", value);
            });

            //맡기시는기간
            $("#paymentSlider").slider({
                range: "min",
                value: 0,
                min: 0,
                max: 60,
                step: 1,
                slide: function (event, ui) {
                    $("#month").val(addComma(ui.value));
                }
            });
            $("#month").change(function () {
                var value = removeComma(this.value);
                $("#paymentSlider").slider("value", value);
            });
            //이자율
            $("#interestSlider").slider({
                range: "min",
                value: 0,
                min: 0,
                max: 30,
                step: 0.01,
                slide: function (event, ui) {
                    $("#interest").val(ui.value);
                }
            });
            $("#interest").change(function () {
                var value = this.value;
                $("#interestSlider").slider("value", value);
            });
            //상환일
            $("#returnSlider").slider({
                range: "min",
                value: 0,
                min: 0,
                max: 60,
                step: 1,
                slide: function (event, ui) {
                    $("#return").val(ui.value);
                }
            });
            $("#return").change(function () {
                var value = this.value;
                $("#returnSlider").slider("value", value);
            });

            $('#inquiryBtn').on('click', function () {

                //money 대출금
                //month 대출 개월수
                //interest 아자율
                //return 상환일
                // radio1,2,3 : 대출 타입
                //조회하기 버튼 inquiryBtn
                var loanType = $('#radio1:checked').val() | $('#radio2:checked').val() | $('#radio3:checked').val();

                var money = Number(bankCalcUtils.removeComma($('#money').val()));
                var loanPeriod = Number($('#month').val());
                var holdingPeriod = Number($('#return').val());
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

            $('#return').change(function () {
                var val = Number($(this).val());
                $("#returnSlider").slider("value", val);

                if (isNaN(val)) {
                    $(this).val('0')
                }
            });
            $('#interest').change(function () {
                var val = Number($(this).val());
                if (isNaN(val)) {
                    $(this).val('0')
                }
            });
            $('#month').change(function () {
                var val = Number($(this).val());
                if (isNaN(val)) {
                    $(this).val('0')
                }
            });
            $('#radio3').change(function () {
                $('#return').val('0');
                $("#returnSlider").slider("value", 0);
            });
        });
    </script>
</head>
<%@ include file="include/inc_body_start.jspf" %>
<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:subVisualWrap -->
    <div id="subVisualWrap" class="sub2-6">
        <div class="breadcrumb">
            <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
            <a href="#" class="depth1 loading"></a>
            <a href="#" class="depth2 loading"></a>
        </div>
        <div class="tit-wrap ta-c">
            <h2 class="font50 mb10">대출계산기</h2>
            <p class="desc">고객님의 예상 대출이자 및 상환금 등을 계산하실 수 있습니다.</p>
        </div>

    </div>
    <!-- //e:subVisualWrap -->
    <!-- s:contents -->
    <div class="contents default-wrap">
        <div class="calculator-wrap">
            <div class="content1 of-hi">
                <h3 class="tit">대출신청 정보입력</h3>
                
                <div class="grid2 mb30">
                    <div class="form-wrap">
                        <p class="input-tit font13 color-351B6F">상환방법</p>
                        <div class="radio-wrap mt20">
                            <label for="radio1" class="radio r-on"><input type="radio" name="radio" id="radio1"
                                                                          value="1" checked>원금균등상환</label>
                            <label for="radio2" class="radio"><input type="radio" name="radio" id="radio2"
                                                                     value="2">원리금균등상환</label>
                            <label for="radio3" class="radio"><input type="radio" name="radio" id="radio3"
                                                                     value="0">원금만기일시상환</label>
                        </div>
                    </div>
                    <div class="form-wrap" style="display: none;">
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
                </div>
                <div class="grid2 mb30">
                    <div class="form-wrap">
                        <p class="input-tit font13 color-351B6F">대출금액</p>
                        <div class="calculator mb10">
                            <div class="slider-wrap">
                                <div id="monthMoneySlider" class="slider" max="1000000000"></div>
                            </div>
                            <p class="mt10 money-btn-wrap">
                                <button type="button" name="button" class="btn-normal tiny" data="1000000" gubun="2">
                                    +100만
                                </button>
                                <button type="button" name="button" class="btn-normal tiny" data="5000000" gubun="2">
                                    +500만
                                </button>
                                <button type="button" name="button" class="btn-normal tiny" data="10000000" gubun="2">
                                    +1000만
                                </button>
                                <button type="button" name="button" class="btn-normal tiny" data="50000000" gubun="2">
                                    +5000만
                                </button>
                                <button type="button" name="button" class="btn-normal tiny dark">정정</button>
                            </p>
                            <div class="input-wrap mt15">
                                <input type="text" name="" value="" id="money" placeholder="숫자로 입력하세요">
                                <div class="unit-txt" style="right: 10px">원</div><!--단위 텍스트가 있을때-->
                            </div>
                        </div>
                    </div>
                    <div class="form-wrap">
                        <p class="input-tit font13 color-351B6F">대출기간</p>
                        <div class="calculator mb10">
                            <div class="slider-wrap">
                                <div id="paymentSlider" class="slider" max="60"></div>
                            </div>
                            <p class="mt10 money-btn-wrap">
                                <button type="button" name="button" class="btn-normal tiny fix-width" data="12"
                                        gubun="1">12개월
                                </button>
                                <button type="button" name="button" class="btn-normal tiny fix-width" data="24"
                                        gubun="1">24개월
                                </button>
                                <button type="button" name="button" class="btn-normal tiny fix-width" data="36"
                                        gubun="1">36개월
                                </button>
                                <button type="button" name="button" class="btn-normal tiny fix-width" data="48"
                                        gubun="1">48개월
                                </button>
                                <button type="button" name="button" class="btn-normal tiny fix-width" data="60"
                                        gubun="1">60개월
                                </button>
                                <button type="button" name="button" class="btn-normal tiny fix-width dark">정정</button>
                            </p>
                            <div class="input-wrap mt15">
                                <input type="text" name="" value="" id="month" placeholder="개월을 선택하세요">
                                <div class="unit-txt" style="right: 10px">개월</div><!--단위 텍스트가 있을때-->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="grid2 mb30">
                    <div class="form-wrap">
                        <p class="input-tit font13 color-351B6F">이자율</p>
                        <div class="calculator mb10">
                            <div class="slider-wrap">
                                <div id="interestSlider" class="slider" max="30"></div>
                            </div>
                            <div class="input-wrap mt10">
                                <input type="text" name="" value="" id="interest" placeholder="이자율을 선택하세요">
                                <div class="unit-txt" style="right: 10px">%</div><!--단위 텍스트가 있을때-->
                            </div>
                        </div>
                    </div>
                    <div class="form-wrap">
                        <p class="input-tit font13 color-351B6F">거치기간</p>
                        <div class="calculator mb10">
                            <div class="slider-wrap">
                                <div id="returnSlider" class="slider" max="60"></div>
                            </div>
                            <div class="input-wrap mt10">
                                <input type="text" name="" value="" id="return" placeholder="거치기간을 입력하세요.">
                                <div class="unit-txt" style="right: 10px">개월</div><!--단위 텍스트가 있을때-->
                            </div>
                        </div>
                    </div>
                </div>



                <p class="ta-c">
                    <button id="inquiryBtn" type="button" name="button" class="btn-big pink">조회하기</button>
                </p>
                <div id="divResult" class="result-wrap mt40" style="display:none;">
                    <hr class="mb40">
                    <p class="font20 color-333333 mb20">계산결과</p>
                    <div class="table-wrap mb30">
                        <table id="loanResult" class="table type1">
                            <caption>대출계산기 계산결과</caption>
                            <colgroup>
                                <col style="width:80px">
                                <col style="width:120px">
                                <col style="width:150px">
                                <col style="width:150px">
                                <col style="width:107px">
                                <col style="width:130px">
                                <col style="width:130px">
                                <col style="*">
                            </colgroup>
                            <thead>
                            <tr>
                                <th scope="col" class="ta-c">회차</th>
                                <th scope="col" class="ta-c">상환금</th>
                                <th scope="col" class="ta-c">납입원금</th>
                                <th scope="col" class="ta-c">이자</th>
                                <th scope="col" class="ta-c">납입원금 계</th>
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
                                <td class="ta-c">2,038,116</td>
                            </tr>
                            <tr>
                                <td class="ta-c">2</td>
                                <td class="ta-c">238,116</td>
                                <td class="ta-c">230,000</td>
                                <td class="ta-c">7,800</td>
                                <td class="ta-c">2,038,116</td>
                                <td class="ta-c">2,038,116</td>
                            </tr>
                            <tr>
                                <td class="ta-c">3</td>
                                <td class="ta-c">238,116</td>
                                <td class="ta-c">230,000</td>
                                <td class="ta-c">7,800</td>
                                <td class="ta-c">2,038,116</td>
                                <td class="ta-c">2,038,116</td>
                            </tr>
                            <tr>
                                <td class="ta-c">4</td>
                                <td class="ta-c">238,116</td>
                                <td class="ta-c">230,000</td>
                                <td class="ta-c">7,800</td>
                                <td class="ta-c">2,038,116</td>
                                <td class="ta-c">2,038,116</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <p class="ta-c">
                        <button id="reInquiryBtn" type="button" name="button" class="btn-big">다시 계산하기</button>
                    </p>
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

