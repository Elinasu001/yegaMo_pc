<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="home" value="/${dsrId }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>
    <script type="text/javascript">
        function completeExportCB(result) {
            if(result.status==0)  {
                customAlert({title : '안내', message : '내보내기 취소' }, function() {});
            } else if(result.status==1) {
                customAlert({title : '안내', message : '내보내기 성공' }, function() {});
            } else {
                customAlert({title : '안내', message : result.message + "[" + result.status + "]" }, function() {});
            }
        }
    </script>

</head>
<%@ include file="include/inc_body_start.jspf" %>
<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:subVisualWrap -->
    <div id="subVisualWrap" class="sub2-7">
        <div class="breadcrumb">
            <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
            <a href="#" class="depth1 loading"></a>
            <a href="#" class="depth2 loading"></a>
        </div>
        <div class="tit-wrap ta-c">
            <h2 class="font50 mb10">인증센터</h2>
            <p class="desc">전자거래를 안심하고 사용할 수 있도록 해주는 사이버 신분증입니다.</p>
        </div>

    </div>
    <!-- //e:subVisualWrap -->
    <!-- s:contents -->
    <div class="contents default-wrap">
        <div class="auth-center-wrap">
            <div class="content1 of-hi">
                <h3 class="tit">공동인증서란</h3>
                <p>인터넷 창에서 발생하는 모든 전자거래를 안심하고 사용할 수 있도록 해주는 사이버 신분증입니다.</p>
                <p class="list-tit mt60">기업고객용 공동인증서</p>
                <div class="table-wrap">
                    <table class="table type1">
                        <caption>기업고객용 공동인증서</caption>
                        <colgroup>
                            <col style="width:25%">
                            <col style="width:25%">
                            <col style="width:25%">
                            <col style="width:25%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col" class="ta-c">공동인증서종류</th>
                            <th scope="col" class="ta-c">발급대상</th>
                            <th scope="col" class="ta-c">용도</th>
                            <th scope="col" class="ta-c">수수료</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="ta-c">저축은행용</td>
                            <td class="ta-c">기업뱅킹가입고객</td>
                            <td class="ta-c">저축은행 인터넷뱅킹 거래용</td>
                            <td class="ta-c">무료</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <p class="list-tit mt60">개인고객용 공동인증서</p>
                <div class="table-wrap">
                    <table class="table type1">
                        <caption>개인고객용 공동인증서</caption>
                        <colgroup>
                            <col style="width:25%">
                            <col style="width:25%">
                            <col style="width:25%">
                            <col style="width:25%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col" class="ta-c">공동인증서종류</th>
                            <th scope="col" class="ta-c">발급대상</th>
                            <th scope="col" class="ta-c">용도</th>
                            <th scope="col" class="ta-c">수수료</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- 180420(2) 추가 -->
                        <tr>
                            <td class="ta-c va-m">은행/신용카드/보험용</td>
                            <td class="ta-c va-m">개인뱅킹 가입고객</td>
                            <td class="ta-c">
                                인터넷뱅킹, 국세청 연말정산용, 온라인보험거래, 전자민원서비스, 온라인 신용카드 결제
                            </td>
                            <td class="ta-c va-m">무료</td>
                        </tr>
                        <!-- //180420(2) 추가 -->
                        <tr>
                            <td class="ta-c va-m">범용개인</td>
                            <td class="ta-c va-m">개인뱅킹 가입고객</td>
                            <td class="ta-c">
                                인증서가 필요한 모든 거래
                                <ul class="mt10">
                                    <li>- 인터넷뱅킹</li>
                                    <li>- 온라인 주식거래</li>
                                    <li>- 온라인 신용카드 결제</li>
                                    <li>- 전자민원서비스 등</li>
                                </ul>
                            </td>
                            <td class="ta-c va-m">4,400원/연간</td> <!-- 180420(2) 텍스트수정 -->
                        </tr>
                        </tbody>
                    </table>
                </div>
                <!-- 180420(2) 추가 -->
                <div class="list-tit mt60">PC→스마트폰 공동인증서 내보내기</div>
                <img src="<c:url value="/resources/normal/images/page/img_auth_center1.png"/>" alt="1단계:스마트기기에서 예가람저축은행 논스탑대출 어플리케이션 실행 / 2단계: '공동인증서 내보내기(PC→스마트폰)' 선택 / 3단계:PC에서 복사할 인증서 선택 후 생성된 승인번호를 어플리케이션 화면에 입력 / 4단계:공동인증서를 PC에서 스마트기기로 복사완료" class="mt20">
                <p class="ta-c mt40"><button type="button" name="button" class="btn-big pink" onclick="javascript:Delfino.exportCertificate(completeExportCB);">공동인증서 내보내기(PC→스마트폰)</button></p>
                <!-- //180420(2) 추가 -->
            </div>
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
</div>
<!-- //e: contentsWrap -->
<%@ include file="include/inc_body_end.jspf" %>
</html>

