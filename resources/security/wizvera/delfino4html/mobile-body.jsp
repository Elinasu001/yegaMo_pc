<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (mode.equals("mobile")) {
%>
    <!-- mobile -->
    <!-- 전자 서명 작성 -->
    <div id="selectPage" class="jsTouchPanel">
        <div class="toolbar">
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.close();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1>
                <span class="signTitle">인증서 선택</span>
            </h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
            
        </div>
        <div class="content">
            <ul class="certview edgetoedge">
            </ul>
        </div>
    </div>

    <!-- 인증서 이동 -->
    <div id="exportCertificatePage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.close();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1>
                <span class="exportTitle">인증서 이동</span>
            </h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
            
        </div>
        <div class="content">
            <ul class="certview edgetoedge">
            </ul>
        </div>
    </div>

    <!-- 인증서 갱신 -->
    <div id="updateCertificatePage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.close();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1>
                <span class="updateTitle">인증서 갱신</span>
            </h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <ul class="certview edgetoedge">
            </ul>
        </div>
    </div>

    <!-- 전자 서명 작성 - confirmData -->
    <div id="confirmDataPage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.close();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="confirmDataTitle">서명 데이타 확인</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <table class="confirmDataTable"> 
                <tbody>
                </tbody>
            </table>
        </div>
        <div class="footer">
            <a class="button-gray buttonOKMsg" onclick="mobile.changeTo(undefined, '#selectPage'); return false;" role="button">확인</a>
        </div>
    </div>

    <!-- 인증서 관리 -->
    <div id="managementPage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.close();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1>
                <span class="managementPageTitle managementPageTitleReal">인증서 관리</span>
            </h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <ul class="certview edgetoedge">
            </ul>
        </div>
    </div>

    <!-- 인증서 관리 / 인증서 보기 -->
    <div id="certificatePage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.back();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="managementPageTitle">인증서 관리</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content" style="font-size:14px;">
            <div class="certificateBlockSetting">
                <img style="margin: 30px auto; display:block;" src="icons/mobile_cert_x1.png" srcset="icons/mobile_cert_x1.png 1x, icons/mobile_cert_x2.png 2x, icons/mobile_cert_x3.png 3x" aria-label="인증서 이미지" alt>
                  <table style="width:100%; table-layout:fixed;">
                  <tr role="text">
                    <td class="cert_td subject">발급대상</td>
                    <td style=" text-overflow: ellipsis; overflow: hidden; white-space:nowrap;" class="subjectCN"></td></tr>
                 
                  <tr role="text">
                    <td class="cert_td issuer">발급자</td>
                    <td class="issuerCN"></td></tr>
                  
                  <tr role="text">
                    <td class="cert_td notBefore">시작일자</td>
                    <td class="startDate"></td></tr>
                  
                  <tr role="text">
                    <td class="cert_td notAfter">만료일자</td>
                    <td class="endDate"></td></tr>
                  
                  <tr role="text" class="certSourceArea">
                    <td class="cert_td source">인증서위치</td>
                    <td class="certSource"></td></tr>

                </table>

            </div>
        </div>
        <div class="footer">
            <div navbar>
                <ul class="tabs">
                    <li><a onclick="mobile.remove();return false;" role="button" aria-label="삭제"><img src="icons/delete_certificate_x2.png" alt></a> </li>
                    <li><a onclick="mobile.changeTo(undefined, '#passwordChangePage'); return false;" role="button" aria-label="암호 변경"><img src="icons/change_password_x2.png" alt></a> </li>
                    <li><a onclick="mobile.changeTo(undefined, '#certificateDetailPage'); return false;" role="button" aria-label="인증서 상세보기"><img src="icons/detail_certificate_x2.png" alt></a> </li>
                    <li><a onclick="mobile.exportCert(); return false;" role="button" aria-label="다른 기기로 내보내기"><img src="icons/export_certificate_x2.png" alt></a> </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 인증서 암호 -->
    <div id="passwordInputPage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.back();mobile.selectPasswordType.show(true);return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt><span class="changePasswordInput" style="display:none;">인증방식변경</span></div>
            <h1><span class="passwordInputPageTitle">인증서 암호 입력</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content passwordInputPage">
            <div class="passwordInputBlock">
                <div>
                    <label for="password1" class="passwordLabel">인증서 암호</label><br/>
                    <input id="password1" class="password" type="password" readonly></input>
                </div>
                <!-- <span class="desc warningPassword" role="text">안전한 금융거래를 위해 6개월마다<br/> 인증서 암호를 변경하시기 바랍니다.</span> <br/> -->
                <a class="button-gray ok buttonOKMsg" onclick="mobile.passwordComplete(); return false;" role="button">확인</a>
            </div>
        </div>
    </div>

    <!-- 인증서 암호 변경 -->
    <div id="passwordChangePage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.back();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="passwordChangePageTitle">인증서 암호 변경</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
        <div class="certificateBlockSetting">
            <div class="certificateBlock" role="text"> 
                <img src="icons/mobile_cert_x1.png" srcset="icons/mobile_cert_x1.png 1x, icons/mobile_cert_x2.png 2x, icons/mobile_cert_x3.png 3x" width="52px" height="60px" alt>
                <span class="strong heading subjectCN"></span>
                <span class="desc issuerCN"></span>
                <span class="desc endDate"></span>
            </div>
            <div class="passwordInputBlock">
                <div >
                    <label for="oldPassword" class="oldPasswordLabel">기존 암호</label>
                    <input id="oldPassword" class="password" type="password" readonly></input> 
                </div>
                <div >
                    <label for="newPassword1" class="newPasswordLabel">암호</label>
                    <input id="newPassword1" class="newPassword" type="password" readonly></input>
                </div>
                <div >
                    <label for="newPasswordConfirm1" class="newPasswordConfirmLabel">암호 확인</label>
                    <input id="newPasswordConfirm1" class="newPasswordConfirm" type="password" readonly></input>
                </div>
          </div>
           </div>      <a class="button-gray buttonOKMsg" onclick="mobile.passwordChange(); return false;" role="button">확인</a>
           
        </div>
    </div>

    <!-- 인증서 암호 생성 -->
    <div id="passwordCreatePage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.passwordCreate(false); return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="passwordCreatePageTitle">인증서 생성</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <div style="text-align:center"><h2 class="newPasswordNotification">새 인증서에서 사용할 암호를 입력하세요</h2></div>
            <div class="passwordInputBlock">
                <span class="desc newPasswordNotificationSecond">암호는 10자 이상 영문자/숫자/특수기호</br> 조합으로 사용 가능합니다. </span><br/>
                <div >
                    <label for="newPassword2" class="newPasswordLabel">새 암호</label>
                    <input id="newPassword2" class="newPassword" type="password" disabled readonly></input>
                </div>
                <div >
                    <label for="newPasswordConfirm2" class="newPasswordConfirmLabel">새 암호 확인</label>
                    <input id="newPasswordConfirm2" class="newPasswordConfirm" type="password" disabled readonly></input>
                </div>
                <span class="desc warningPassword">안전한 금융거래를 위해 6개월마다<br/> 인증서 암호를 변경하시기 바랍니다.</span> <br/>
                <a class="button-gray buttonOKMsg" onclick="mobile.passwordCreate(true); return false;" role="button">확인</a>
            </div>
        </div>
    </div>

    <!-- 인증서 자세히 보기 -->
    <div id="certificateDetailPage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.back();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="certificateDetailPageTitle">인증서 보기</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <table style="width:96%; table-layout:fixed; font-size:13px; overflow:hidden;" class="detailTable">
            </table>
        </div>
    </div>

	<!-- 보안 키보드 -->
    <div id="keyboardPage" style="display: none;" aria-label="가상키패드">
        <div class="keyboardCloseDiv">
            <div class="keyboardClose" ontouchstart="return mobile.keyboard.close()" role="button" aria-label="가상키패드 닫기"></div>
        </div>
        <div class="keyboardDiv">
            <div class="keyboard">
            </div>
        </div>
    </div>

    <!-- 간편비밀번호 암호 -->
    <div id="certpinInputPage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.back();mobile.selectPasswordType.show(true);return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt><span class="changePasswordInput" style="display:none;">인증방식변경</span></div>
            <h1><span class="certpinInputPageTitle">간편 비밀번호</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <div class="certpinInputBlock">
                <div class="certpin">
                    <label class="certpinLabel">간편비밀번호 암호를 입력해주세요</label><br/>
                    <input class="certpinInput" type="password"></input>
                    <input class="certpinInput" type="password"></input>
                    <input class="certpinInput" type="password"></input>
                    <input class="certpinInput" type="password"></input>
                    <input class="certpinInput" type="password"></input>
                    <input class="certpinInput" type="password"></input>
                </div>
            </div>
        </div>
    </div>

    <!-- 생체인증 입력 페이지 -->
    <div id="webauthnPage" class="jsTouchPanel">
        <div class="toolbar"></div>
        <div class="content webauthnBackground">
            <div class="webauthn closeButton" onclick="return mobile.back(true);"></div>
            <div class="passwordArea webauthnPasswordArea" style="display: none;">
                <div class="passwordInputBlock webauthnPasswordInputBlock" style="display: none;">
                    <div>
                        <label for="password2" class="webauthnCreateLabel">인증서 암호를 확인한 후 생체 인증을 진행합니다.</label>
                        <input id="password2" class="password" placeholder=" " type="password" readonly></input>
                        <a onclick="mobile.webauthnPage.passwordComplete(); return false;" role="button">확인</a>
                    </div>
                </div>
            </div>
            <div class="webauthnBackgroundInner">
                <span class="webauthnLabel"></span>
                <button class="webauthnButton" onclick="mobile.webauthnPage.auth();">인증하기</button>
            </div>
        </div>
    </div>

    <!-- 간편인증 비밀번호 생성 -->
    <div id="certpinCreatePage" class="modal" style="display: none;">
        <div class="certpinCreateWrapper">
            <div class="descArea">
                <div class="closeButton" onclick="return mobile.certpinCreatePage.close();"></div>
                <div class="descWrapper">
                    <div class="descDiv"></div>
                    <div class="progressDiv"></div>
                </div>
            </div>
            <div class="passwordArea">
                <div class="passwordInputBlock passwordInputPage content" style="display: none;">
                    <div>
                        <label for="password3" class="certpinLabel">인증서 암호를 입력해주세요.</label>
                        <input id="password3" class="password" placeholder=" " type="password" readonly></input>
                        <a class="button-gray ok buttonOKMsg" onclick="mobile.certpinCreatePage.done(); return false;" role="button">확인</a>
                        <!-- <a onclick="mobile.certpinCreatePage.done(); return false;" role="button">확인</a> -->
                    </div>
                </div>
                <div class="certpinCreateInputBlock" style="display: none;">
                    <div class="certpinCreate">
                        <label class="certpinLabel">간편비밀번호 6자리를 <b>입력</b>해주세요.</label><br/>
                        <input class="certpinCreateInput" type="password"></input>
                        <input class="certpinCreateInput" type="password"></input>
                        <input class="certpinCreateInput" type="password"></input>
                        <input class="certpinCreateInput" type="password"></input>
                        <input class="certpinCreateInput" type="password"></input>
                        <input class="certpinCreateInput" type="password"></input>
                    </div>
                </div>
                <div class="certpinConfirmInputBlock" style="display: none;">
                    <div class="certpinConfirm">
                        <label class="certpinLabel">간편비밀번호 6자리를 <b>다시 입력</b>해주세요.</label><br/>
                        <input class="certpinConfirmInput" type="password"></input>
                        <input class="certpinConfirmInput" type="password"></input>
                        <input class="certpinConfirmInput" type="password"></input>
                        <input class="certpinConfirmInput" type="password"></input>
                        <input class="certpinConfirmInput" type="password"></input>
                        <input class="certpinConfirmInput" type="password"></input>
                    </div>
                </div>
                <div class="certpinCompleteBlock" style="display: none;">
                    <div class="certpinLabel">돌아가셔서 간편 비밀번호 인증을<br/>이용해보세요.</div>
                    <a class="button-gray ok buttonOKMsg" onclick="mobile.certpinCreatePage.close(); return false;" role="button">확인</a>
                </div>
            </div>
        </div>
    </div>

    <!-- KBTAM -->
    <div id="kbtamPage" class="jsTouchPanel" style="display: none;">
        <div class="toolbar">
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.close();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1>
                <span class="kbtamTitle">인증서 제출</span>
            </h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content certpinCreateWrapper">
            <div class="passwordArea content">
                <div class="passwordInputBlock passwordInputPage" style="display: none;">
                    <div class="certInfoArea">
                        <div class="certImage"></div>
                        <div class="certInfo">
                            <div class="certInfoSubject">Dummy</div>
                            <div class="certInfoType">개인|기업</div>
                            <div class="certInfoIssuerAndExpire">위즈베라 | 만료일 XXXX-XX-XX</div>
                        </div>
                    </div>
                    <div>
                        <label for="kbtamPassword" class="kbtamPasswordLabel certpinLabel">인증서 암호를 입력해주세요.</label>
                        <input id="kbtamPassword" class="password" placeholder=" " type="password" readonly></input>
                        <!-- <a onclick="mobile.certpinCreatePage.done(); return false;" role="button">확인</a> -->
                    </div>
                </div>
                <div class="kbtamCreateInputBlock" style="display: none;">
                    <label class="kbtamLabel certpinLabel">간편비밀번호 6자리를 <b>입력</b>해주세요.</label><br/>
                    <div class="kbtamCreate certpinCreate kbtampinInput">
                        <input class="kbtamCreateInput" type="password"></input>
                        <input class="kbtamCreateInput" type="password"></input>
                        <input class="kbtamCreateInput" type="password"></input>
                        <input class="kbtamCreateInput" type="password"></input>
                        <input class="kbtamCreateInput" type="password"></input>
                        <input class="kbtamCreateInput" type="password"></input>
                    </div>
                    <div class="kbtamConfirm certpinConfirm kbtampinInput">
                        <input class="kbtamConfirmInput" type="password"></input>
                        <input class="kbtamConfirmInput" type="password"></input>
                        <input class="kbtamConfirmInput" type="password"></input>
                        <input class="kbtamConfirmInput" type="password"></input>
                        <input class="kbtamConfirmInput" type="password"></input>
                        <input class="kbtamConfirmInput" type="password"></input>
                    </div>
                </div>
                <div class="buttonBlock">
                    <a class="button-gray ok" onclick="mobile.kbtam.done(); return false;" role="button">확인</a>
                     <a class="button-gray cancel cancelButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button">취소</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 인증서 입력 선택 창 -->
    <div id="passwordTypeSelectPageWrapper" ontouchstart="return mobile.selectPasswordType.close(event)" style="display: none;">
        <div id="passwordTypeSelectPage" class="passwordTypeSelectPage">
            <div class="passwordTypeSelectLabel">인증 방식 선택</div>
            <div class="passwordTypeSelectManage" role="button" aria-label="인증 방식 관리" ontouchstart="return mobile.selectPasswordType.edit();"></div>
            <div class="passwordTypeSelectDiv">
                <div class="passwordTypeSelect" id="webauthn" ontouchstart="return mobile.selectPasswordType.choose(event);" style="display:none;">
                    <img src="images/webauthn_menu@2x.png" srcset="images/webauthn_menu.png 1x, images/webauthn_menu@2x.png 2x, images/webauthn_menu@3x.png 3x"><span class="webauthnLabel label">생체인증</span>
                </div>
                <div class="passwordTypeSelect" id="certpin" ontouchstart="return mobile.selectPasswordType.choose(event);" style="display:none;">
                    <img src="images/certpin_menu@2x.png" srcset="images/certpin_menu.png 1x, images/certpin_menu@2x.png 2x, images/certpin_menu@3x.png 3x"><span class="certpinLabel label">간편 비밀번호</span>
                </div>
                <div class="passwordTypeSelect" id="keyboard" ontouchstart="return mobile.selectPasswordType.choose(event);" style="display:none;">
                    <img src="images/keyboard_menu@2x.png" srcset="images/keyboard_menu.png 1x, images/keyboard_menu@2x.png 2x, images/keyboard_menu@3x.png 3x"><span class="keyboardLabel label">보안 키보드</span>
                </div>
                <div class="passwordTypeSelectClose" ontouchstart="return mobile.selectPasswordType.close()" role="button" aria-label="닫기">닫기</div>
            </div>
        </div>
        <div id="passwordTypeSelectPageConfirm" class="passwordTypeSelectPage confirmCloud" style="display:none;">
            <div class="passwordTypeSelectWarningIcon" role="img" aria-label="경고 아이콘"></div>
            <div class="passwordTypeSelectConfirmTitle">클라우드를 사용하시겠습니까?</div>
            <div class="passwordTypeSelectDescription">간편비밀번호를 사용하려면 클라우드에 인증서를 저장해야합니다.</div>
            <div class="passwordTypeSelectDiv passwordTypeSelectButtonArea">
                <div class="passwordTypeSelectConfirm" ontouchstart="return mobile.selectPasswordType.ok()" role="button" aria-label="확인">확인</div>
                <div class="passwordTypeSelectClose" ontouchstart="return mobile.selectPasswordType.close()" role="button" aria-label="닫기">닫기</div>
            </div>
        </div>
        <div id="passwordTypeSelectPageWebauthn" class="passwordTypeSelectPage continueWebauthn" style="display:none;">
            <div class="passwordTypeSelectWarningIcon" role="img" aria-label="생체인증 아이콘"></div>
            <div class="passwordTypeSelectConfirmTitle">생체인증을 진행합니다.</div>
            <div class="passwordTypeSelectDescription">아래의 "확인" 버튼을 클릭하여 다음 화면에서 생체인증을 계속 진행하여 주시기 바랍니다.</div>
            <div class="passwordTypeSelectDiv passwordTypeSelectButtonArea">
                <div class="passwordTypeSelectClose" ontouchstart="return mobile.selectPasswordType.okHandler()" role="button" aria-label="닫기">닫기</div>
            </div>
        </div>
    </div>

    <div id="pinKeypad" style="display: none;">
        <div class="pinKeypadBox">
            <table class="pinKeypadArea">
                <tr>
                    <td><div class="button pin" role="button"></div></td>
                    <td><div class="button pin" role="button"></div></td>
                    <td><div class="button pin" role="button"></div></td>
                    <td><div class="button pin" role="button"></div></td>
                </tr>
                <tr>
                    <td><div class="button pin" role="button"></div></td>
                    <td><div class="button pin" role="button"></div></td>
                    <td><div class="button pin" role="button"></div></td>
                    <td><div class="button pin" role="button"></div></td>
                </tr>
                <tr> 
                    <td><div class="button pin" role="button"></div></td>
                    <td><div class="button pin" role="button"></div></td>
                    <td><div class="button re-order" role="button" onclick="return mobile.pinKeypad.generateKeyboard();"></div></td>
                    <td><div class="button back-button" role="button" onclick="return mobile.pinKeypad.backspace();"></div></td>
                </tr>
            </table>
        </div>
    </div>

    <!-- 인증번호 출력 다이얼로그 -->
    <div id="authCodePage" class="jsTouchPanel">
        <div class="toolbar">
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="authCodePageTitle">인증서 이동</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <div class="authCodeContent">
                <div class="upBlock authCodeBlock">
                    <div class="labels"><span class="strongLabel authCodeLabel" aria-labelledby="importRoamingMsg">인증번호</span></div>
                    <div class="inputs">
                        <input type="text" pattern="\d*" inputmode="numeric" class="firstPart" maxlength="4" onkeypress="authCodeValidator(event);" aria-label="인증번호 첫번째칸" tabindex="1" readonly>
                        <input type="text" pattern="\d*" inputmode="numeric" class="secondPart" maxlength="4" onkeypress="authCodeValidator(event);" aria-label="인증번호 두번째칸" tabindex="3" readonly>
                        <input type="text" pattern="\d*" inputmode="numeric" class="thirdPart" maxlength="4" onkeypress="authCodeValidator(event);" aria-label="인증번호 세번째칸" tabindex="5" readonly>
                    </div>
                </div>

                <div class="downBlock">
                    <div class="title">
                        <span class="strongLabel importRoamingMsg" id="importRoamingMsg">다른 기기 브라우저에 저장되어 있는 인증서를 가져옵니다.</span>
                    </div>
                    <div class="image">
                        <img src="images/cert_import_roaming_x2_mobile.png" alt>
                    </div>
<!--                     <div class="notification">
                        <img src="images/check.png" alt>
                        <span class="importRoamingDetailMsg"> 다른 기기 브라우저에 표시된 인증번호를 확인후 입력해주세요. </span>
                    </div> -->
                </div>
     
            </div>
        </div>
        <div class="footer authCode" style="border-top:none;">
            <div> 
                 <a class="button-gray ok importCertificate" style="display: none;" onclick="mobile.authCodeComplete(true); return false" role="button">인증서 가져오기</a>
                 <a class="button-gray cancel cancelButton" onclick="mobile.authCodeComplete(false); return false" role="button">취소</a>
            </div>
        </div>

        <div id="numKeyboard" style="display: none">
            <div class="numKeyboardBox">
                <div class="numKeyboardCloseDiv">
                    <div class="numKeyboardClose" onclick="return mobile.numKeyboard.close()" role="button" aria-label="가상키패드 닫기"></div>
                </div>
                <table >
                    <tr>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('1');" role="button">1</div></td>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('2');" role="button">2</div></td>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('3');" role="button">3</div></td>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('4');" role="button">4</div></td>
                    </tr>
                    <tr>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('5');" role="button">5</div></td>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('6');" role="button">6</div></td>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('7');" role="button">7</div></td>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('8');" role="button">8</div></td>
                    </tr>
                    <tr>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('9');" role="button">9</div></td>
                        <td><div class="button" onclick="return mobile.numKeyboard.click('0');" role="button">0</div></td>
                        <td></td><td><div class="button back-button" onclick="return mobile.numKeyboard.click(8)" aria-label="지우기" role="button"></div></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <!-- 인증서 암호 -->
    <div id="passwordInput4ImportCertificatePage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="passwordInput4ImportCertificatePageTitle">인증서 저장</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content passwordInputPage">
            <div class="passwordInputBlock">
                <div>
                    <label for="password4" class="passwordLabel passwordLabelImport">인증서 암호</label>
                    <input id="password4" class="password" type="password" readonly></input>
                </div>
                <a class="button-gray buttonOKMsg" onclick="mobile.passwordComplete(); return false;" role="button">확인</a>
            </div>
        </div>
    </div>

    <!-- 인증서 찾기 방법 선택창 -->
    <div id="selectImportCertTypePage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.back();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="certificateDetailPageTitle">인증서 붙여넣기</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <div class="oneSignArea"></div>
            <div class="localArea"></div>
        </div>
    </div>

    <!-- 인증서 찾기 -->
    <div id="importLocalPage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="importLocalPageTitle">인증서 찾기</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <div class="messagebox">
                <div class="message npkiMessage">NPKI 폴더내에 인증서와 개인키 파일을 직접 선택하여 인증서를 저장합니다.</div>
                <div class="message npkiDetailMessage">경로: /NPKI/발급기관/사용자이름/</div>
                <img src="images/cert_search.png?<%=releaseDate%>" alt>
            </div>
            <div class="certWrapper importWrapper">
                <span class="cert">인증서(signCert.der)</span>
                <button onclick="mobile.loadPKCS8('.der')" class="importButton">가져오기<img src="images/check.png?<%=releaseDate%>" alt></button>
            </div>
            <div class="keyWrapper importWrapper">
                <span class="key">개인키(signPri.key)</span>
                <button onclick="mobile.loadPKCS8('.key')" class="importButton">가져오기<img src="images/check.png?<%=releaseDate%>" alt></button>
            </div>
<!--             <div class="passwordInputBlock">
                <div>
                    <label class="passwordOnFindLabel">인증서 암호</label>
                    <input class="password" type="password"></input>
                </div>
                <a class="button-gray buttonOKMsg" onclick="mobile.passwordComplete(); return false;" role="button">확인</a>
            </div>
 -->        </div>
    </div>

	<!-- 모바일 인증서 가져오기 화면(팝업대체) -->
    <div id="mobileImportCertMenu" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1> <span class="mobileImportCertMenuTitle">인증서 가져오기</span> </h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content mobileImportCertMenu">
            <ul class="edgetoedge menulist">
            </ul>
        </div>
    </div>
	
    <!-- oneSign에서 인증서 가져오기 -->
    <div id="importCertFromOneSignPage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="certificateDetailPageTitle">인증서 붙여넣기</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
            <div class="pasteAreaLabel">복사한 인증서를 붙여넣기 해주세요.</div>
            <div class="pasteArea">
                <input id="pasteForm"></input>
            </div>
            <div class="detailPaste">
                <img src="icons/alert_paste_mobile.png"><span class="reopenMsg" alt>처음 설치하셨거나 인증서 복사 앱이 실행되지 않을 경우 이전 페이지로 돌아가 다시 진행하시기 바랍니다.</span><br/>
            </div>
        </div>
        <div class="footer">
             <a class="button-gray cancel cancelButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button">취소</a>
        </div>
    </div>

    <!-- g4 모바일 로컬 인증서 이동 -->
    <div id="importCertMobileTransferPage" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock importCertMobileTransfer"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="importCertMobileTransferPageTitle">앱에서 인증서 가져오기</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content">
			<div class="detailImportNotice">
				<span class="importMessage">스마트폰에 저장된 인증서를 앱을 이용하여 현재 사용 중인 브라우저로 가져옵니다.</span>
			</div>
			<div class="detailImportLogo"><img class="img" src="images/cert_import_relayserver_mobile.png?<%=releaseDate%>" alt></div>
            <div class="detailImportMobile">
                <span class="importHelpMsg"><img src="icons/cert_import_info_check.png" alt><span class="importHelpMsgLabel">"내보내기 앱"이 실행되면 가져올 인증서를 선택 후 인증서 비밀번호를 입력해 주십시오.</span></span>
				<span class="importHelpMsgError"><img src="icons/cert_import_info_check.png" alt><span class="importHelpMsgErrorLabel">"내보내기 앱"이 정상적으로 실행되지 않았습니다. 처음 설치 하셨을 경우 아래 [가져오기]를 다시 선택하여 주시기 바랍니다.</span></span>
            </div>
        </div>
        <div class="footer">
            <div class="importMobileFooter"> 
				<a class="button-gray cancel cancelButton" onclick="mobile.done({status:0, message: 'User Cancel'});return false;" role="button">취소</a>
				<div class="importCertRetry">
					<a class="button-gray ok" onclick="mobile.importCert('relayServerRetry'); return false" role="button">가져오기</a>
				</div>
			</div>
        </div>
    </div>	
	
    <!-- g4 모바일 로컬 인증서 이동 저장시 인증서 암호 -->
    <div id="passwordInputPage4ImportCertRelay" class="jsTouchPanel">
        <div class="toolbar"> 
            <div class="logoBlock"><img class="img" src="images/wizvera-logo-mobile_x2.png?<%=releaseDate%>" alt></div>
            <div class="backButton" onclick="mobile.back();return false;" role="button" aria-label="뒤로가기 버튼"><img class="back" src="icons/back.png" alt></div>
            <h1><span class="passwordInputPageTitle">인증서 암호 입력</span></h1>
            <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_x2.png?<%=releaseDate%>" aria-label="델피노 로고" alt></div>
        </div>
        <div class="content passwordInputPage">
            <div class="certificateBlock"> 
                <img src="icons/mobile_cert_x1.png" srcset="icons/mobile_cert_x1.png 1x, icons/mobile_cert_x2.png 2x, icons/mobile_cert_x3.png 3x" alt>
                <span class="strong heading subjectCN"></span>
                <span class="desc issuerCN"></span>
                <span class="desc endDate"></span>
            </div>
            <div class="passwordInputBlock">
                <div>
                    <label for="password5" class="passwordLabel">인증서 암호</label>
                    <input id="password5" class="password" type="password" readonly></input>
                </div>
                <span class="desc warningPassword">안전한 금융거래를 위해 6개월마다<br/> 인증서 암호를 변경하시기 바랍니다.</span> <br/>
                <a class="button-gray ok buttonOKMsg" onclick="mobile.passwordComplete(); return false;" role="button">확인</a>
            </div>
        </div>
    </div>	

    <div id="certificateProviderList" class="g10_nav_shadow" style="display:none">
        <div id="g10_navCurtain" class="g10_navCurtain"></div>
        <div id="g10_wrapper" class="g10_wrapper">
            <div id="g10_folding" class="g10_folding"></div>
            <div id="g10_navMenu" class="g10_navMenu">
            </div>
        </div>
    </div>

    <div id="providerContent" style="display: none;">
        <fieldset id="delfino-section" class="rightContent"></fieldset>
        <fieldset id="providers-section" class="rightContent">
            <div id="vpcg_content" class="content">
                <span class="vpcg_btn_close" title="닫기"></span>
                <div class="vpcg_section_user_auth vpcg_section_right_on">
                    <form class='formData' name="vpcg_formLogin" onsubmit="return false;">
                        <div class="vpcg_section_sign_logo"></div>
                        <div class="vpcg_inputfield name">
                            <input type="text" class="vpcg_login_data vpcg_user_name" name="name" maxlength="10" placeholder="이름 입력"></input>
                            <label aria-hidden=true></label>
                        </div>
                        <div class="vpcg_inputfield birthday">
                            <input type="tel" class="vpcg_login_data vpcg_user_birthday" name="birthday" maxlength="14" placeholder="생년월일 입력 (1985 / 01 / 30)"></input>
                            <label aria-hidden=true></label>
                        </div>
                        <div class="vpcg_inputfield phone">
                            <input type="tel" class="vpcg_login_data vpcg_user_phone" name="phone" maxlength="17" placeholder="휴대폰 번호 입력"></input>
                            <label aria-hidden=true></label>
                        </div>
                        <button class="vpcg_btn_login" disabled>확인</button>
                    </form>
                </div>
                <div class="vpcg_section_pinsign"></div>
                <div class="vpcg_section_popup">
					<div class="vpcg_popup_banner1">
						<div class="popup_banner1_box">
							<span class="title"><span class="l1"><span class="name">팝업창</span>을 </span>확인해주세요.</span>
						</div>						
					</div>
					<div class="vpcg_popup_banner2">
						<div class="popup_banner2_box">
							<span class="title name">금융인증서</span><span class="title">를 선택하셨습니다.</span>
							<div class="desc"><span class="popup_disable"><span class="name">금융인증서</span>의 팝업창이 열리지 않았다면 </span><u>아래 버튼</u>을 눌러 인증을 진행해주세요.</div>
						</div>
					</div>
					<div class='vpcg_popup_open' tabindex='-1'>
						<div class='button_title'>확인</div>
					</div>
				</div>
                <div class="vpcg_section_wait m_vpcg_info_screen_normal">
                    <div class="m_vpcg_img_lodding">
                        <img class="lodding_gif" src="images/g10/icon/img_send_blue.gif"/>
                    </div>
                    <div class="m_vpcg_info_top_text">인증요청이 휴대폰으로 전송되었습니다.</div>
                    <div class="m_vpcg_info_bottom_text">선택한 인증수단의 <span class="color-06 fw-b">모바일앱 알람</span>을 확인해주세요.</div>
                </div>
				<div class="vpcg_section_wait_btn m_vpcg_info_screen_normal with_button">
                    <div class="m_vpcg_img_lodding">
                        <img class="lodding_gif" src="images/g10/icon/img_send_blue.gif"/>
                    </div>
                    <div class="m_vpcg_info_top_text">인증요청이 휴대폰으로 전송되었습니다.</div>
                    <div class="m_vpcg_info_bottom_text">선택한 인증수단의 <span class="color-06 fw-b">모바일앱에서 인증을<br/>완료</span>한 후, 아래의 <span class="color-06 fw-b"><u>확인버튼</u></span>을 눌러주세요.</div>
					<div class='vpcg_wait_button' tabindex='-1'>
						<div class='button_title'>확인</div>
					</div>
                </div>
				<div class="vpcg_section_reauth">
					<div class="vpcg_reauth_logo"></div>
					<div class="vpcg_sign_banner1">
						<span class="m1"><span class="title">카카오페이 인증서</span>에</span>
						<span class="m2">전자서명을 요청합니다.</span>
					</div>
					<div class="vpcg_sign_banner2">
						<div class="desc"><u>아래 확인 버튼</u>을 눌러 전자서명을 진행해주세요.</div>
					</div>
					<div class="vpcg_btn_sign" tabindex="-1">확인</div>
				</div>
            </div>
        </fieldset>
        <div id="g10-loading-section" class="rightContent">
            <!-- <div class="vpcg_img_loading_wrapper"> -->
                <div class="vpcg_img_loading">
                    <img src="images/g10/icon/loading_blue.gif"/>
                    <span>로딩중입니다.</span>
                </div>
            <!-- </div> -->
        </div>
        <div id="g10-intro-section" class="rightContent">
            <span class="vpcg_btn_close" title="닫기"></span>
            <div class="intro_title_box">
                <span class="title name">인증수단</span><span class="title">을 선택해주세요</span>
            </div>
            <div class="intro_provider_box">
                <div class="provider_row">
                </div>
            </div>
        </div>
    </div>

<%
    }
%>
