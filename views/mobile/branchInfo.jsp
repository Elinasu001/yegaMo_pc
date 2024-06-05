<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>
    <!--다음 지도 services 라이브러리 (GeoLocation Service) -->
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ac00ffd1c6eebdb9a9bd3b8949179d1&libraries=services"></script>
    <script type="text/javascript" src="<c:url value="/resources/mobile/js/common_bank_map_util.js"/>"></script>

    <script type="text/javascript">
        var centers = ${centersJson};
        var pageFunc = {
            getSelectedCenterIndex: function () {
                var index = Number($('#centerTitles').find('option:selected').val());
                if (isNaN(index)) {
                    index = 0;
                }
                return index;
            },
            notifyCenterChanged: function () {
                var index = this.getSelectedCenterIndex();
                var center = centers[index];
                if (!center) {
                    customAlert({title: '알림', message: '존재하지 않는 지점입니다.'});
                    return;
                }

                var titleButtons = $("#centerTitles").find("> li");
                titleButtons.removeClass("active");
                $(titleButtons[index]).addClass("active");

                $('#centerAddress').html(center.address);
                $('#centerName').html(center.name);
                $('#centerPhone').html(UtilFunc.getPhoneNumberWithHyphen(center.phone));
                $('#centerFax').html(UtilFunc.getPhoneNumberWithHyphen(center.fax));
                $('#branchDesc').html(center.branchDesc);
            },
            notifyCenterMapChanged: function () {
            	var index = this.getSelectedCenterIndex();
            	var center = centers[index];
                if (!center) {
                    return;
                }
                daumMap.goMarker(center.address);
            }
        };

        $(function () {
            pageFunc.notifyCenterChanged();
            $(window).ready(function () {
                try {
                    daumMap.init('daumMap');
                    centers.forEach(function (center, index) {
                        daumMap.addMarkBank(center.name, center.address, index === 0);
                    });
                    pageFunc.notifyCenterMapChanged();
                } catch (e) {
                }
            });
            $('#centerTitles').change(function (e) {
                pageFunc.notifyCenterChanged();
                pageFunc.notifyCenterMapChanged();
            });
        });
    </script>
</head>
<%@ include file="include/inc_body_start.jspf" %>

<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:contents -->
    <div class="sub-contents">
        <div class="branch-wrap">
            <div class="default-wrap mb15">
                <h3 class="tit">예가람저축은행 지점정보</h3>
                <div class="select-wrap">
                    <select id="centerTitles">
                        <c:forEach var="center" items="${centers}" varStatus="status">
                            <option value="${status.index}">${center.get('name')}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="map-wrap mb30">
                <div class="map" id="daumMap"></div>
            </div>
            <div class="default-wrap">
                <div class="list-tit mb10" id="centerName">.</div>
                <ul class="list type1">
                    <li><span>주소</span>
                        <div id="centerAddress">.</div>
                    </li>
                    <li><span>대표 전화번호</span>
                        <div id="centerPhone">.</div>
                    </li>
                    <li><span>대표 FAX번호</span>
                        <div id="centerFax">.</div>
                    </li>
                    <li>
                        <span>교통수단</span>
                        <div id="branchDesc"></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
</div>
<!-- //e: contentsWrap -->

<%@ include file="include/inc_body_end.jspf" %>

</html>

