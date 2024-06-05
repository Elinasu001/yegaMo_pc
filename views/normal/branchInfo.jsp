<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="home" value="/${dsrId }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="include/inc_header.jspf" %>
    <!--다음 지도 services 라이브러리 (GeoLocation Service) -->
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3ac00ffd1c6eebdb9a9bd3b8949179d1&libraries=services"></script>
    <script type="text/javascript" src="<c:url value="/resources/normal/js/common_bank_map_util.js"/>"></script>

    <script type="text/javascript">
        var centers = ${centersJson};
        var pageFunc = {
            getSelectedCenterIndex: function () {
                var hash = window.location.hash.replace('#', '').replace(/\?.*/g, '');
                var index = hash.length === 0 ? 0 : Number(hash);

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
                centers.forEach(function (center, index) {
                    daumMap.addMarkBank(center.name, center.address, index === 0);
                });
                try {
                    daumMap.init('daumMap');
                    pageFunc.notifyCenterMapChanged();
                } catch (e) {
                }
            });
            $(window).on('hashchange', function (e) {
                pageFunc.notifyCenterChanged();
                if (daumMap.map) {
                    pageFunc.notifyCenterMapChanged();
                }
            });

        });
    </script>
</head>
<%@ include file="include/inc_body_start.jspf" %>

<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:subVisualWrap -->
    <div id="subVisualWrap" class="sub2-2">
        <div class="breadcrumb">
            <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
            <a href="#" class="depth1 loading"></a>
            <a href="#" class="depth2 loading"></a>
        </div>
        <div class="tit-wrap ta-c">
            <h2 class="font50 mb10">지점안내</h2>
            <p class="desc">예가람저축은행의 지점정보를 안내드립니다.</p>
        </div>

    </div>
    <!-- //e:subVisualWrap -->
    <!-- s:contents -->
    <div class="contents default-wrap">
        <div class="branch-wrap">
            <div class="content1 of-hi">
                <div class="tab-wrap mb40">
                    <ul id="centerTitles">
                        <c:forEach var="center" items="${centers}" varStatus="status">
                            <li class=""><a href="#${status.index}">${center.get('name')}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="map-wrap mb40">
                    <div class="map" id="daumMap">
                    </div>
                </div>
                <!--D : mb10 삭제 -->
                <div class="list-tit" id="centerName">.</div>
                <!--D : list type1 -> define-list 구조 변경-->
                <ul class="define-list">
                    <li>
                        <span class="de-tit">주소</span>
                        <div class="de-cts ta-l" id="centerAddress">.</div>
                    </li>
                    <li>
                        <span class="de-tit">대표 전화번호</span>
                        <div class="de-cts ta-l" id="centerPhone">.</div>
                    </li>
                    <li>
                        <span class="de-tit">대표 FAX번호</span>
                        <div class="de-cts ta-l" id="centerFax">.</div>
                    </li>
                    <li>
                        <span class="de-tit">교통수단</span>
                        <div class="de-cts ta-l" id="branchDesc">.</div>
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

