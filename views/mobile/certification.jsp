<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>
    <script type="text/javascript">
        function completeExportCB(result) {
            if(result.status==0)  {
                customAlert({title : '안내', message : '가져오기 취소' }, function() {});
            } else if(result.status==1) {
                customAlert({title : '안내', message : '가져오기 성공' }, function() {});
            } else {
                customAlert({title : '안내', message : result.message + "[" + result.status + "]" }, function() {});
            }
        }
    </script>
    <a href=””>인증서내보내기</a>
</head>
<%@ include file="include/inc_body_start.jspf" %>
<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:contents -->
    <div class="sub-contents default-wrap">
        <div class="auth-center-wrap">
            <h3 class="tit">브라우저 인증서 가져오기</h3>
            <div class="ta-c">
                <p class="auth-tit font20">브라우저 인증서 복사는?</p>
                <ol class="mt15">
                    <li class="font13">1.PC나 스마트폰에서 인증서 프로그램의 별도 설치없이, PC에서 스마트폰 브라우저별로 인증서 복사가 가능합니다.</li>
                    <li class="font13 mt15">2.브라우저 방식의 인증서 복사기능은 HTML5방식을 지원하는 경우에만 이용이 가능합니다.</li>
                    <li class="font13 mt15">3.웹브라우저 초기화를 하시면 저장된 인증서는 삭제됩니다.</li>
                    <li class="font13 mt15">4.웹브라우저는 타 브라우저간에 인증서 연동이 불가합니다.</li>
                </ol>
            </div>
            <hr class="mt40">
            <p class="font20 ta-c mt40">PC→스마트폰 브라우저<br>인증서 가져오기</p>
            <div class="form-wrap  mt20 column-wrap" style="display: none;">
                <p class="input-tit font13 color-351B6F">승인번호입력(13자리)</p>
                <div class="column3-hp">
                    <div class="column">
                        <input type="tel" name="" value="" id="" placeholder="" title="승인번호 앞번호">
                    </div>
                    <span class="fl-l hyphen">-</span>
                    <div class="column">
                        <input type="tel" name="" value="" id="" placeholder="" title="승인번호 가운데번호">
                    </div>
                    <span class="fl-l hyphen">-</span>
                    <div class="column">
                        <input type="tel" name="" value="" id="" placeholder="" title="승인번호 뒷번호">
                    </div>
                </div>
            </div>
            <p class="ta-c mt30">
                <button type="button" name="button" id="inquiryBtn" class="btn-normal pink" onclick="javascript:Delfino.importCertificate(completeExportCB);">브라우저 인증서 가져오기</button>
            </p>
            <img src="<c:url value="/resources/mobile/images/page/txt_auth_center.png"/>" alt="다음과 같은 단계를 거치세요." class="mt35">
            <img src="<c:url value="/resources/mobile/images/page/img_auth_center.png"/>" alt="1단계:모바일 모집인 상담사 사이트 접속 / 2단계: 공동인증센터 &gt; '브라우저 공동인증서 내보내기 (PC→스마트폰)'를 클릭 / 3단계:'공동인증서 이동'창에서 복사할 인증서를 선택 및 비밀번호 입력 후 생성된 인증번호(12자리)를 스마트폰에 입력 / 4단계:스마트폰 브라우저에서 인증서 복사 완료 확인" class="mt20"> <!-- 180509 alt값 수정 -->
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
</div>
<!-- //e: contentsWrap -->
<%@ include file="include/inc_body_end.jspf" %>
</html>
