<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="Expires" content="-1"/>
    <meta http-equiv="Progma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <link href="<c:url value="/resources/normal/css/jquery-ui.css"/>" rel="stylesheet"/>
    <%@ include file="include/inc_header_non_secure.jspf" %>

    <script type="text/javascript"> var isInstallCheck = false;</script>

    <!-- 통합설치_커스트마이징용JS -->
	<!--델피노 보안 솔루션-->
	<script src="<c:url value="/resources/security/wizvera/delfino/delfino_config.js?20191113"/>"
	        type="text/javascript"></script>
	<script src="<c:url value="/resources/security/wizvera/delfino/delfino_internal.min.js?20170417"/>"
	        type="text/javascript"></script>
	<script src="<c:url value="/resources/security/wizvera/delfino/delfino.js?20170417"/>" type="text/javascript"></script>
	<script src="<c:url value="/resources/security/wizvera/delfino/delfino_site.js?20160912"/>"
	        type="text/javascript"></script>
	
	<!--안랩 보안 솔루션-->
	<script src="<c:url value="/resources/security/ahnlab/astx2/astx2.min.js?r=13284"/>" type="text/javascript"></script>
	<script src="<c:url value="/resources/security/ahnlab/astx2/astx2_custom.js?r=13284"/>" type="text/javascript"></script>
	<script src="<c:url value="/resources/security/ahnlab/astx2/astx2_jq.min.js?r=13284"/>" type="text/javascript"></script>

    <!-- 베라포트: 공통 -->
    <script type="text/javascript">_SITE_CreateObject = false;</script>
    <!-- script type="text/javascript" src="../jquery/json_parse.js"></script -->
    <script type="text/javascript" src="<c:url value="/resources/security/wizvera/veraport/veraport20.js?v=20190226"/>"></script>
    <!-- 베라포트공통JS -->
    <script type="text/javascript"
            src="<c:url value="/resources/security/wizvera/veraport/veraport20_multi.js?v=20190226"/>"></script>
    <!-- 베라포트공통JS -->
    <script type="text/javascript"
            src="<c:url value="/resources/security/wizvera/veraport/veraport20_handler.js"/>"></script>
    <!-- 베라포트공통JS -->
    <script type="text/javascript"
            src="<c:url value="/resources/security/wizvera/veraport/install20/install_internal.js"/>"></script>
    <script type="text/javascript"
            src="<c:url value="/resources/security/wizvera/veraport/install20/install_internal.js"/>"></script>
    <!-- 베라포트공통JS -->

    <!-- 베라포트공통JS -->
    <script type="text/javascript"
            src="<c:url value="/resources/security/wizvera/veraport/install20/install_config.js"/>"></script>
    <!-- 베라포트공통JS -->

    <!-- 아래 내용은 필요시 공통 스크립트(ex install_download.js)로 만들어서 사용하세요 -->
    <script type="text/javascript">
        //통할설치 초기화 완료후 베라포트 설치여부 확인: G3만해당됨: 미사용시 지워주세요.
        function SITE_vpInstalCheckResult(isInstall) {
            //if (!isInstall) alert("통합설치프로그램이 설치되지 않았습니다.\n'통합설치프로그램다운로드'를 클릭하여 설치하시기 바랍니다.");
            if (!isInstall && !(VP_platformInfo.Linux && !VP_platformInfo.Fedora && !VP_platformInfo.Ubuntu)) {
//             	if (typeof(fn_download_Veraport) == "function") fn_download_Veraport(''); //미설치시 설치파일 다운로드 처리
            }else{
            	isVeraportInstalling = false;
            	if (isASTxInstall && isNXiBASEInstall && isDelfinoG3Install && !isVeraportInstalling) {
            		customAlert({
                        title: '알림',
                        message: instMsg.result[instCode.RESULT_INST_OK],
                        type: 'confirm'
                    }, function () {
                        fn_goHomePage(false);
                    });
                }
            }
            
            
        }

        function fn_download_noitce(objectName, pkgType, downURL) {
            var notice = "설치 후에는 반드시 새로고침을 하거나 다시 접속해주세요.";
            if (instConfig.isDebug) notice += "\n\n설치파일다운로드정보[" + objectName + "][" + VP_platformInfo.type + "," + VP_platformInfo.name + "][" + pkgType + "]\n" + downURL;

            //alert(notice);
            if (downURL != "") document.location = downURL;
        }

        //Veraport 다운로드 URL 설정
        function fn_download_Veraport(pkgType) {
            if ((pkgType == "RPM" || VP_platformInfo.Fedora) && VP_config.useHandler) {
                alert("브라우저를 종료 한후, 어플리케이션 메뉴에서 베라포트(Veraport)를 실행하세요.\n(또는 커맨드라인에서 veraport를 입력하여 실행하세요.)");
            }
            document.location = fn_getVpDownloadURL(pkgType, true);
        }


        //DelfinoG3 다운로드 URL 설정 샘플
        function fn_download_DelfinoG3(pkgType) {
            var _baseURL = document.location.protocol + "//" + document.location.host + "/resources/security/wizvera/delfino/down";
            var downURL = _baseURL + "/delfino-g3.exe";
            //if (VP_platformInfo.x64) downURL = _baseURL + "/delfino-g3.exe";

            //멀티OS용 다운로드 설정
            if ((pkgType == "DEV") || (pkgType == "" && VP_platformInfo.Ubuntu)) {
                downURL = _baseURL + "/delfino-g3_i386.deb";
                if (VP_platformInfo.x64) downURL = _baseURL + "/delfino-g3_amd64.deb";
            }
            else if ((pkgType == "RPM") || (pkgType == "" && VP_platformInfo.Fedora)) {
                downURL = _baseURL + "/delfino-g3.i386.rpm";
                if (VP_platformInfo.x64) downURL = _baseURL + "/delfino-g3.x86_64.rpm";
            }
            else if (VP_platformInfo.Mac) {
                downURL = _baseURL + "/delfino-g3.pkg";
            }

            fn_download_noitce("DelfinoG3", pkgType, downURL);
        }

        //ASTx 다운로드 URL 설정 샘플
        function fn_download_ASTx(pkgType) {
            if (fn_getUrlParameter("test") == "on") {
                var _baseURL = "/resources/security/ahnlab/down";
                var downURL = _baseURL + "/astx_setup_offline_ygr.exe";
                //if (VP_platformInfo.x64) downURL = _baseURL + "/win/default/all/astx_setup.exe";

                //멀티OS용 다운로드 설정
                if ((pkgType == "DEV") || (pkgType == "" && VP_platformInfo.Ubuntu)) {
                    downURL = _baseURL + "/linux/astx_u32.deb";
                    if (VP_platformInfo.x64) downURL = _baseURL + "/linux/astx_u64.deb";
                }
                else if ((pkgType == "RPM") || (pkgType == "" && VP_platformInfo.Fedora)) {
                    downURL = _baseURL + "/linux/astx_f32.rpm";
                    if (VP_platformInfo.x64) downURL = _baseURL + "/linux/astx_f64.rpm";
                }
                else if (VP_platformInfo.Mac) {
                    downURL = _baseURL + "/mac/astx.dmg";
                }
                fn_download_noitce("ASTx", pkgType, downURL);
            } else {
                var _baseURL = "http://safetx.ahnlab.com/master";
                var downURL = _baseURL + "/win/default/all/astx_setup.exe";
                //if (VP_platformInfo.x64) downURL = _baseURL + "/win/default/all/astx_setup.exe";

                //멀티OS용 다운로드 설정
                if ((pkgType == "DEV") || (pkgType == "" && VP_platformInfo.Ubuntu)) {
                    downURL = _baseURL + "/linux/astx_u32.deb";
                    if (VP_platformInfo.x64) downURL = _baseURL + "/linux/astx_u64.deb";
                }
                else if ((pkgType == "RPM") || (pkgType == "" && VP_platformInfo.Fedora)) {
                    downURL = _baseURL + "/linux/astx_f32.rpm";
                    if (VP_platformInfo.x64) downURL = _baseURL + "/linux/astx_f64.rpm";
                }
                else if (VP_platformInfo.Mac) {
                    downURL = _baseURL + "/mac/astx.dmg";
                }
                fn_download_noitce("ASTx", pkgType, downURL);
            }

        }

    </script>

    <script type="text/javascript">
        var isASTxInstall = false;
        var isDelfinoG3Install = false;
        var isVeraportInstalling = true;

        setInterval(function () {
            if (!isASTxInstall) {
                $ASTX2.init(
                    function onSuccess() {
                        isASTxInstall = true;
                        fn_objectUpdate("ASTx", instCode.STATUS_INST_OK, "설치됨", true);

                        if (isDelfinoG3Install && !isVeraportInstalling) {
                            customAlert({
                                title: '알림',
                                message: instMsg.result[instCode.RESULT_INST_OK],
                                type: 'confirm'
                            }, function () {
                                fn_goHomePage(false);
                            });
                        }
                    },
                    function onFailure() {
                        isASTxInstall = false;
                        fn_objectUpdate("ASTx", instCode.STATUS_INST_NO, "미설치", true);
                    },
                    750
                );
            }

            if (!isDelfinoG3Install) {
                Delfino.isInstall(false, function onResult(result) {
                    if (result) {
                        isDelfinoG3Install = true;
                        fn_objectUpdate("DelfinoG3", instCode.STATUS_INST_OK, "설치됨", true);
                        if (isASTxInstall && !isVeraportInstalling) {
                            customAlert({
                                title: '알림',
                                message: instMsg.result[instCode.RESULT_INST_OK],
                                type: 'confirm'
                            }, function () {
                                fn_goHomePage(false);
                            });
                        }
                    } else {
                        isDelfinoG3Install = false;
                        fn_objectUpdate("DelfinoG3", instCode.STATUS_INST_NO, "미설치", true);
                    }
                });
            }
        }, 3000);
    </script>
</head>
<%@ include file="include/inc_body_start.jspf" %>
<!-- s contentsWrap -->
<div id="contentsWrap">
    <!-- s:subVisualWrap -->
    <div id="subVisualWrap" class="sub4-3">
        <div class="breadcrumb">
            <a href="<c:url value="${home }"/>" class="home ir loading">홈</a>
            <a href="#" class="depth1 loading"></a>
            <a href="#" class="depth2 loading"></a>
        </div>
        <div class="tit-wrap ta-c">
            <h2 class="font50 mb10">보안프로그램 설치</h2>
            <p class="desc">안전한 서비스 이용을 위해 <br>보안프로그램을 다운로드 받아 사용하시기 바랍니다.</p>
        </div>

    </div>
    <!-- //e:subVisualWrap -->
    <!-- s:contents -->
    <div class="contents default-wrap">
        <div class="default-wrap">
            <div class="content1 of-hi">
                <div id="VP_object_load"></div>
                <div id="VP_object_info"></div>
                <h3 class="tit">보안프로그램 설치</h3>
                <ul class="list type1">
                    <li>설치 전 각 프로그램의 기능을 확인하시기 바라며, 전체설치 버튼을 클릭하시면 자동으로 설치가 진행됩니다.</li>
                    <li>프로그램 설치 후에도 오류가 발생하면 장애 시 문의 번호를 통하여 문의하여 주시기 바랍니다.</li>
                    <li>설치가 완료된 이후에는 반드시 새로고침을 하여, 정상 설치여부를 체크해 보시기 바랍니다.</li>
                </ul>
                <p class="ta-c mt40">
                    <button type="button" name="button" class="btn-big pink" id="VP_btn_install"
                            onclick="javascript:SITE_axInstallVP(instConfig.objectDefType, false);">전체설치
                    </button>
                </p>
                <div class="table-wrap mt65">
                    <table class="table type1">
                        <caption></caption>
                        <colgroup>
                            <col style="width:25%">
                            <col style="width:*">
                            <col style="width:7%">
                            <col style="width:10%">
                            <col style="width:15%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th scope="col" class="ta-c">프로그램명</th>
                            <th scope="col" class="ta-c">설치현황</th>
                            <th scope="col" class="ta-c">구분</th>
                            <th scope="col" class="ta-c">설치현황</th>
                            <th scope="col" class="ta-c">다운로드</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="ta-c">예가람 통합설치 프로그램<br/>
                                (VeraPort 3.0)
                            </td>
                            <td class="ta-c">예가람에서 제공하는 보안프로그램을 한번에 다운받기 위한<br>프로그램입니다.</td>
                            <td class="ta-c va-m">필수</td>
                            <td id="object_status_Veraport" class="ta-c va-m">
                                <div id="status_message_Veraport"><span class='install_no'>checking</span></div>
                            </td>
                            <td class="ta-c va-m">
                                <span style="display:none;" id="status_installed_Veraport"></span>
                                <span style="display:none;" id="status_unsupported_Veraport"></span>
                                <span style="display:none;" id="status_checking_Veraport"></span>
                                <button style="display:none;" id="object_download_Veraport" class="btn-normal tiny"
                                        onclick="javascript:fn_download_Veraport('');">다운로드
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td class="ta-c">공동인증서 보안<br> (WizIN-Delfino G3)</td>
                            <td class="ta-c">공동인증서 로그인과 거래내역에 대한 전자서명을 위한<br>프로그램입니다.</td>
                            <td class="ta-c va-m">필수</td>
                            <td id="object_status_DelfinoG3" class="ta-c va-m">
                                <div id="status_message_DelfinoG3"><span class='install_no'>checking</span></div>
                            </td>
                            <td class="ta-c va-m">
                                <button style="display:none;" id="object_download_DelfinoG3" class="btn-normal tiny"
                                        onclick="javascript:fn_download_DelfinoG3('');">다운로드
                                </button>

                                <span style="display:none;" id="status_installed_DelfinoG3"></span>
                                <span style="display:none;" id="status_unsupported_DelfinoG3"></span>
                                <span style="display:none;" id="status_checking_DelfinoG3"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="ta-c">키보드보안 / 개인PC방화벽<br/>(Ahnlab Safe Trasaction)</td>
                            <td class="ta-c">키보드로 입력되는 정보가 유출되거나 변조되지 않도록 보호하고<br>비인가된 접근 차단 및 바이러스를 검색하여 치료해 주는
                                프로그램입니다.
                            </td>
                            <td class="ta-c va-m">필수</td>
                            <td id="object_status_ASTx" class="ta-c va-m">
                                <div id="status_message_ASTx"><span class='install_no'>checking</span></div>
                            </td>
                            <td class="ta-c va-m">
                                <button style="display:none;" id="object_download_ASTx" class="btn-normal tiny"
                                        onclick="javascript:fn_download_ASTx('');">다운로드
                                </button>

                                <span style="display:none;" id="status_installed_ASTx"></span>
                                <span style="display:none;" id="status_unsupported_ASTx"></span>
                                <span style="display:none;" id="status_checking_ASTx"></span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <p class="font12 mt10">예가람 저축은행 ☎ 1877-7788 ( 상담시간 : 평일 09:00 ~ 18:00 )</p>
                

            </div>
        </div>
    </div>
    <!-- //e:contents -->
    <button type="button" name="button" class="btn-circle top ir btn-top">위로</button>
</div>
<div style="display: none">
    <div id="VP_msg_installed" style="display:block;"> <!-- VeraPort 설치완료 -->
        <ul>
            <h3>고객님의 안전한 서비스 이용을 위한 보안프로그램들을 통합관리할 수 있습니다.</h3>
            <li>우선 각 프로그램의 ‘자세히보기’를 클릭하시어 기능을 확인하시기 바랍니다.</li>
            <li><span style="color:#0074B7;">[전체설치]</span>를 클릭하시면 자동으로 설치가 진행됩니다.</li>
        </ul>
    </div>
    <div id="VP_msg_notinstall" style="display:none;"> <!-- VeraPort 미설치 -->
        <ul>
            <h3>고객님의 안전한 서비스 이용을 위한 보안프로그램들을 통합관리할 수 있습니다.</h3>
            <li>우선 각 프로그램의 ‘자세히보기’를 클릭하시어 기능을 확인하시기 바랍니다.</li>
            <li><span style="color:#0074B7;">[통합설치프로그램 다운로드]</span>를 클릭하시면 자동으로 설치가 진행됩니다.</li>
            <li>사용자 환경에 따라 오류 메세지가 발생할 경우에는 다운로드 안내창에서 '저장'을 눌러 PC에 다운로드 하여 실행하시기 바랍니다.</li>
        </ul>
    </div>
    <div id="VP_msg_unsupported" style="display:none;"> <!-- VeraPort 미지원 -->
        <ul>
            <h3>고객님의 안전한 서비스 이용을 위한 보안프로그램들을 통합관리할 수 있습니다.</h3>
            <li>우선 각 프로그램의 ‘자세히보기’를 클릭하시어 기능을 확인하시기 바랍니다.</li>
            <li>접속하신 브라우저는 통합설치를 지원하지 않습니다. 아래의 '접속PC정보'를 확인하시기 바랍니다.</li>
        </ul>
    </div>
    <button id="VP_btn_download" style="display:none;" class="installVP" type="button"
            onclick="javascript:fn_download_Veraport('');">통합설치프로그램다운로드
    </button>
</div>

<!-- [필수]베라포트: 멀티OS용 설치화면/START -->
<div id="dialog" style="display:none"></div>
<div id="dialogex" style="display:none"></div>
<script type="text/javascript">SITE_vpmInstallDialog();</script>
<!-- [필수]베라포트: 멀티OS용 설치화면/END -->


<!-- [필수]베라포트: 자동설치 및 차단감지/START-->
<div id="VP_object_install"></div>
<script type="text/javascript">SITE_vpObjectInstall();</script>
<!-- [필수]베라포트: 자동설치 및 차단감지/END -->


<!-- [필수]베라포트: non-Plugin 설치 확인/START-->
<script type="text/javascript">if (VP_config.useHandler) execVP_isInstall(timer_vpHandlerLoad);</script>
<!-- [필수]베라포트: non-Plugin 설치 확인/END -->

<!-- //e: contentsWrap -->
<%@ include file="include/inc_body_end.jspf" %>
<%--<script type="text/javascript">timer_vpBtnUpdate();</script><!-- [필수]베라포트: 설치여부별 /전체설치,다운로드 버튼 변경 함수 -->--%>
<script type="text/javascript">timer_objectUpdate(instCode.VERAPORT);</script> <!-- 베라포트: 설치여부별 /상태,다운로드 버튼 변경 함수 -->
<%--<script type="text/javascript">timer_objectUpdate("DelfinoG3");</script> <!-- 공동인증: 설치여부별 /상태,다운로드 버튼 변경 함수 -->--%>
<%--<script type="text/javascript">timer_objectUpdate("ASTx");</script> <!-- 제품별: 설치여부별 /상태,다운로드 버튼 변경 함수 -->--%>


</html>

