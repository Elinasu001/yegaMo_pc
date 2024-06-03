<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (mode.equals("tablet")) {
%>
    <!-- tablet -->
    <!-- 전자 서명 작성 -->
    <div id="selectDialogTablet" style="display:none">
        <div id="selectDialogTabletBody"> 
            <div class="titleBarBlock">
                    <div class="dialogTitle">전자 서명 작성</div>
                    <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_tablet_x2.png?<%=releaseDate%>" alt="델피노 로고"></div>
                    <div class="titleUnderline"></div>         
             </div>
            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo-tablet.png?<%=releaseDate%>" alt="로고이미지">
            </div>

            <div class="certificateBlock">
                <div class="certificateTable"> 
                    <table> 
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="createEasyPasswordContainer" style="display: none;">
                <div class="titlePassword">
                    <div class="createEasyPasswordTitle"><span class=textFirstLine>간편 비밀번호 인증 생성을</span><br><span class=textSecondLine>시작합니다.</span></div>
                    <div class="dialogPage">
                        <div class="dialogNowPage" style="display: inline-block;">1</div>
                        <div class="dialogPageSlash" style="display: inline-block;">/</div>
                        <div class="dialogTotalPage" style="display: inline-block;">3</div>
                    </div>
                </div>
            </div>
            <div class="passwordBorder" style="display:none; margin: 17px 0 0 18px; font-size: 17px;">
                <p class="createEasyPasswordCancelLabel keyboardPasswordCheck" style="padding-bottom: 0px;">인증서 암호를 입력해 주세요.</p>
            </div>
            <div class="createPasswordBorder" style="display:none;">
                <p class="createEasyPasswordCancelLabel firstPinCheck">간편비밀번호 6자리를 <b>입력</b>해주세요.</p>
                <p class="createEasyPasswordCancelLabel rePinCheck" style="display: none;">간편비밀번호 6자리를 <b>다시 입력</b>해주세요.</p>
                <p class="createEasyPasswordCancelLabel sameNumberCheckLabel" style="display: none; color: crimson;">같은 숫자를 연속으로 사용할 수 없습니다.</p>
                <p class="createEasyPasswordCancelLabel continuousNumberCheckLabel" style="display: none; color: crimson;">연속된 숫자를 사용할 수 없습니다.</p>
                <div class=lastEasyPasswordTitle style="display: none;"><span>돌아가셔서 간편 비밀번호 인증을</span><br><span>이용해보세요.</span></div>
            </div>

            
            <div class="certpinInputBlock noneCertpinInputs certpinCreate createEasyPasswordDiv" style="display: none;">
                <div class="certpin" style="padding-bottom: 0">
                    <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                </div>
            </div>
            
            <div class="certpinInputBlock noneCertpinInputs certpinConfirm createEasyPasswordDiv" style="display: none;">
                <div class="certpin" style="padding-bottom: 0">
                    <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                    <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                </div>
            </div>

            <div class="certpinContainer" style="display: none;">
                <div id="pinKeypad" class="notEasyPasswordPinKeypad" style="width: 100%; height: 236px; padding: 45px 17px 22px 17px;">
                    <div class="notEasyPassword" style="height: 100%;">
                        <div class="pinKeypadBox" style="padding: 39px 10px">
                            <div style="margin: 0 10px;">
                                <table class="pinKeypadArea">
                                    <tr>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                    </tr>
                                    <tr class="trLine"></tr>
                                    <tr>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button re-order" style="font-size:18px; color:#555555; line-height: 25px; vertical-align: middle;" role="button" onclick="return desktop.pinKeypad.generateKeyboard('.notEasyPassword');"></div></td>
                                        <td><div class="button back-button" style="display: inline-block; height: 18px; background-size: 25px 15px;" role="button" onclick="return desktop.pinKeypad.backspace();"></div></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="okButtonBlock noneEasyPasswordButton">
                    <button class="ok okButton okButtonMsg blueButton">확인</button>
                    <button class="before whiteButton" style="display: none;" onclick="return desktop.pinKeypad.createEasyPasswordDialog();">이전</button>
                    <button class="cancel cancelButton cancelButtonMsg whiteButton">취소</button>
                    <button class="okButton successButton cancel blueButton">확인</button>
                </div>
            </div>

            <div class="confirmDataBlock" style="display:none">
                <div class="tableWrapperDiv">
                <table class="confirmDataTable">
                    <tbody>
                    </tbody>
                </table>
                </div>
            </div>

            <div class="okButtonBlock haveEasyPassword">
                <div class="passwordBorder">
                    <div class="passwordBlockInner">
                        <input class="passwordInput" name="selectDialogPasswordInput" type="password"/>
                        <div class="okButtonBlock">
                            <button class="ok okButton okButtonMsg blueButton">확인</button>
                            <button class="cancel cancelButton cancelButtonMsg whiteButton">취소</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="horizontalLine"></div>
            
            <div class="keyboardTab" style="display: none;">
                <div class="lodingClickPrevention"></div>
                <div class= "virtualKeyboardTab" style="display: table-cell; width: 373px; height: 33px; vertical-align: middle; text-align: center; font-weight: bold; font-size: 12px; background: #ffffff;">가상키보드</div>
                <div class= "easyPasswordTab" style="display: table-cell; width: 373px; height: 33px; vertical-align: middle; text-align: center; font-size: 12px;">간편비밀번호</div>
            </div>

            <div class="pinkeypadCheckLoading" style="display: none;"></div>
            <div class="keyboardBlock">
                <div class="easyPassword" style="display: none;">
                    <div class="easyPasswordTitle">
                        <img src="icons/ic_info.png"></img>
                        <span class="haveEasyPasswordTitle">간편비밀번호 암호를 입력해주세요.</span>
                        <span class="noneEasyPasswordTitle" style="display: none;">간편비밀번호가 없습니다.</span>
                        <span class="noneCloudTitle " style="display: none; width: 310px;">인증서 클라우드에 연결되어 있지 않습니다.</span>
                    </div>
                    <div class="loadingBackground" style=" display: none;">
                        <div class="loadingContainer">
                            <div class="loadingImg"></div>
                            <div class="loadingText">간편비밀번호 로딩 중</div>
                        </div>
                    </div>
                    <div class="passwordContainer">
                        <div class="inputPasswordContainer">
                            <div class="content">
                                <div class="certpinInputBlock haveCertpinInputs">
                                    <div class="certpin haveCertpin">
                                        <label class="certpinLabel">암호 입력</label>
                                        <input class="certpinInput tablet" type="password"></input>
                                        <input class="certpinInput tablet" type="password"></input>
                                        <input class="certpinInput tablet" type="password"></input>
                                        <input class="certpinInput tablet" type="password"></input>
                                        <input class="certpinInput tablet" type="password"></input>
                                        <input class="certpinInput tablet" type="password"></input>
                                    </div>
                                    <span class="changeCertpin" onclick="return desktop.pinKeypad.certificationReset();">초기화</span>
                                </div>
                            </div>
                            <div id="pinKeypad">
                                <div class="haveEasyPassword">
                                    <div class="pinKeypadBox">
                                        <table class="pinKeypadArea">
                                            <tr>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button pin" role="button"></div></td>
                                            </tr>
                                            <tr class="trLine"></tr>
                                            <tr>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button pin" role="button"></div></td>
                                            </tr>
                                            <tr class="trLine"></tr>
                                            <tr>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button re-order" style="font-size:14px; color:#555555; line-height: 25px; vertical-align: middle;" role="button" onclick="return desktop.pinKeypad.generateKeyboard('.haveEasyPassword');"></div></td>
                                                <td><div class="button back-button" style="display: inline-block; height: 18px;" role="button" onclick="return desktop.pinKeypad.backspace();"></div></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="createPasswordContainer " style="display: none;">
                            <span class="createPasswordTitle">6자리 숫자로 인증하는 간편 비밀번호를 이용해보세요.</span>
                            <button class="createPasswordButton" onclick="return desktop.pinKeypad.createEasyPassword();">간편 비밀번호 생성</button>
                        </div>
                        <div class="nonecloudContainer" style="display: none;">
                            <span class="createPasswordTitle">인증서 클라우드 연결 후 간편 비밀번호를 이용할 수 있습니다.</span>
                            <button class="dButton" onclick="return desktop.pinKeypad.cloudConnect();">인증서 클라우드 연결하기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 인증서 제출 -->
    <div id="exportCertificateDialogTablet" style="display:none">
        <div id="extensionCertStoreDialogBodyTablet"> 
            <div class="titleBarBlock">
                    <div class="dialogTitle">전자 서명 작성</div>
                    <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_tablet_x2.png?<%=releaseDate%>" alt="델피노 로고"></div>
                    <div class="titleUnderline"></div>         
             </div>
            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo-tablet.png?<%=releaseDate%>" alt="로고이미지">
            </div>

            <div class="certificateBlock">
                <div class="certificateTable"> 
                    <table> 
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="confirmDataBlock" style="display:none">
                <div class="tableWrapperDiv"> 
                <table class="confirmDataTable">
                    <tbody>
                    </tbody>
                </table>
                </div>
            </div>

            <div class="passwordBlock">
                <div class="passwordBorder">
                    <div class="passwordBlockInner">
                        <input class="passwordInput certificationPassword" name="exportCertificatePasswordInput" type="password"/>
                        <button class="ok okButton okButtonMsg okButtonMsg">확인</button>
                        <button class="cancel cancelButton cancelButtonMsg cancelButtonMsg">취소</button>
                    </div>
                </div>
            </div>

            <div class="keyboardBlock"></div>
        </div>
    </div>

    <!-- 인증서 관리 -->
    <div id="manageDialogTablet" style="display:none">
        <div id="manageDialogTabletBody"> 
            <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 관리</div>
                    <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_tablet_x2.png?<%=releaseDate%>" alt="델피노 로고"></div>
                    <div class="titleUnderline"></div>         
            </div>

            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo-tablet.png?<%=releaseDate%>" alt="로고이미지">
            </div>

            <div class="certificateBlock">
                <div class="certificateTable"> 
                    <table> 
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="horizontalLine"></div>

            <div class="jobsBox">
                <div class="left">
                    <button class="viewButton up">인증서 보기</button>
                    <button class="exportButton down">인증서 내보내기</button>
                </div>
                <div class="center">
                    <div class="line">&nbsp;</div>
                </div>
                <div class="right">
                    <button class="changeButton up">인증서 암호 변경</button>
                    <button class="deleteButton down">인증서 삭제</button>
                </div>
            </div>

            <div class="okButtonBlock">
                <div class="version">v1.0.0.0</div>
                <button class="cancel cancelButton cancelButtonMsg blueButton">닫기</button>
            </div>
        </div>
    </div>

    <!-- 간편 비밀번호 생성 -->
    <div id="kbtamDialog" style="display:none">
        <div id="kbtamDialogBody" data-tab-order="passwordInput, okButton, cancelButton">
            <div class="titleBarBlock">
                    <div class="dialogTitle kbtamPasswordTitle">선택하신 인증서의 비밀번호를 입력해주세요.</div>
            </div>
            <div class="passwordBlock">
                <div class="passwordBorder">
                    <div class="certInfoArea">
                        <div class="certImage"></div>
                        <div class="certInfo">
                            <div class="certInfoSubject">Dummy</div>
                            <div class="certInfoType">개인|기업</div>
                            <div class="certInfoIssuerAndExpire">위즈베라 | 만료일 XXXX-XX-XX</div>
                        </div>
                    </div>
                    <div class="passwordBlockInner createEasyPasswordCancelInput">
                        <label class="certPassword">인증서 비밀번호</label><input class="passwordInput easyPasswordDialogInput" name="kbtamPasswordInput" aria-label="인증서 암호" name="easyPasswordDialogInput" type="password" autocomplete="off" disabled/><button class="keyboardButton" style="display: none"></button>
                    </div>
                    <div class="certpinContainer" style="display: none;">
                        <div class="certpinInputBlock createEasyPasswordDiv">
                            <label>인증번호 설정</label>
                            <div class="certpin kbtamPinCreate">
                                <input class="certpinInput kbtamPinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinCreateInput createEasyPasswordInput" type="password"></input>
                            </div>
                            <label>인증번호 재입력</label>
                            <div class="certpin kbtamPinConfirm">
                                <input class="certpinInput kbtamPinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput kbtamPinConfirmInput createEasyPasswordInput" type="password"></input>
                            </div>
                        </div>
                        <div id="pinKeypad">
                            <div class="kbtamPassword">
                                <div class="pinKeypadBox">
                                    <div>
                                        <table class="pinKeypadArea">
                                            <tr>
                                                <td><div class="button pin" role="button"></div></td>
                                                <td><div class="button pin" role="button"></div></td>
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
                                                <td><div class="button re-order" role="button"></div></td>
                                                <td><div class="button back-button" role="button"></div></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="okButtonBlock">
                <button class="okButton createEasyPasswordButton">확인</button>
                <button class="cancelButton cancelButtonMsg createEasyPasswordCancelButton">취소</button>
            </div>
        </div>
    </div>

    <!-- 인증서 암호 -->
    <div id="passwordDialogTablet" style="display:none">
        <div id="passwordDialogTabletBody">
             <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 암호 변경</div>
                    <div class="titleUnderline"></div>         
             </div>

            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo-tablet.png?<%=releaseDate%>" alt="로고이미지">
            </div>
        
            <div class="passwordMessageBlock">
                <div class="passwordMessageBorder">
                    <div class="inputCertPasswordMsg strongLabel pwmsg">
                        암호는 10자 이상 영문자/숫자/특수기호의 조합으로 사용가능합니다.
                    </div>
                    <div class="passwordInputBlock">
                        <div class="oldPasswordBlock">
                            <span class="strongLabel oldPassword certPasswordLabel pw">암호</span>
                            <input class="oldPasswordInput pwbox" name="passwordDialogInput" type="password"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="passwordButtonBlock">
                <div class="passwordPolicyMsg" role="text">인증서 비밀번호의 안정성을 위해 6개월 마다 변경하실 것을 권고하며, 인증서가 저장된 매체별로 각각 변경하시기 바랍니다.</div>
                <div class="okButtonBlock">
                    <button class="ok okButton okButtonMsg blueButton">확인</button>
                    <button class="cancel cancelButton cancelButtonMsg whiteButton">취소</button>
                </div>
            </div>

            <div class="horizontalLine"></div>

            <div class="keyboardBlock"></div>
        </div>
    </div>

    <!-- 인증서 암호 생성-->
    <div id="passwordCreateDialogTablet" style="display:none">
        <div id="passwordCreateDialogTabletBody">
             <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 암호 생성</div>
                    <div class="titleUnderline"></div>         
             </div>

            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo-tablet.png?<%=releaseDate%>" alt="로고이미지">
            </div>

            <div class="passwordMessageBlock">
                <div class="passwordMessageBorder">
                    <div class="inputCertPasswordMsg strongLabel">
                        암호는 10자 이상 영문자/숫자/특수기호의 조합으로 사용가능합니다.
                    </div>
                    <div class="passwordInputBlock">
                        <div class="newPasswordBlock">
                            <span class="strongLabel newPassword">새 암호</span>
                            <input class="newPasswordInput" name="newPasswordCreateDialogInput" type="password"/>
                        </div>
                        <div class="newPasswordConfirmBlock">
                            <span class="strongLabel newPasswordConfirm">새 암호 확인</span>
                            <input class="newPasswordConfirmInput" name="newPasswordConfirmDialogInput" type="password"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="passwordButtonBlock">
                <div class="passwordPolicyMsg" role="text">인증서 비밀번호의 안정성을 위해 6개월 마다 변경하실 것을 권고하며, 인증서가 저장된 매체별로 각각 변경하시기 바랍니다.</div>
                <div class="okButtonBlock">
                    <button class="ok okButton okButtonMsg blueButton">확인</button>
                    <button class="cancel cancelButton cancelButtonMsg whiteButton">취소</button>
                </div>
            </div>

            <div class="horizontalLine"></div>

            <div class="keyboardBlock"></div>
        </div>
    </div>

    <!-- 인증서 암호 변경-->
    <div id="passwordChangeDialogTablet" style="display:none">
        <div id="passwordChangeDialogTabletBody">
             <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 암호 변경</div>
                    <div class="titleUnderline"></div>         
             </div>

            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo-tablet.png?<%=releaseDate%>" alt="로고이미지">
            </div>
        
            <div class="passwordMessageBlock">
                <div class="passwordMessageBorder">
                    <div class="inputCertPasswordMsg strongLabel">
                        암호는 10자 이상 영문자/숫자/특수기호의 조합으로 사용가능합니다.
                    </div>
                    <div class="passwordInputBlock">
                        <div class="oldPasswordBlock">
                            <span class="strongLabel oldPassword">이전 암호</span>
                            <input class="oldPasswordInput" name="oldPasswordDialogInput" type="password"/>
                        </div>
                        <div class="newPasswordBlock">
                            <span class="strongLabel newPassword">새 암호</span>
                            <input class="newPasswordInput" name="newPasswordChangeDialogInput" type="password"/>
                        </div>
                        <div class="newPasswordConfirmBlock">
                            <span class="strongLabel newPasswordConfirm">새 암호 확인</span>
                            <input class="newPasswordConfirmInput" name="newPasswordConfirmChangeDialogInput" type="password"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="passwordButtonBlock">
                <div class="passwordPolicyMsg">인증서 비밀번호의 안정성을 위해 6개월 마다 변경하실 것을 권고하며, 인증서가 저장된 매체별로 각각 변경하시기 바랍니다.</div>
                <div class="okButtonBlock">
                    <button class="ok okButton okButtonMsg blueButton">확인</button>
                    <button class="cancel cancelButton cancelButtonMsg whiteButton">취소</button>
                </div>
            </div>

            <div class="horizontalLine"></div>

            <div class="keyboardBlock"></div>
        </div>
    </div>

    <!-- 인증번호 출력 다이얼로그 -->
    <div id="authCodeDialog" style="display:none">
        <div id="authCodeDialogBody">
            <div class="titleBarBlock">
                <div class="dialogTitle">인증서 가져오기</div>
                <div class="selectCertStoreMsgTitleLine"></div>         
            </div>

            <div class="authCodeContent">
                <div class="upBlock authCodeBlock">
                    <div class="labels"><span class="authCodeMsg">인증번호</span></div>
                    <div class="inputs">
                        <input type="text" pattern="\d*" inputmode="numeric" class="firstPart" maxlength="4" onkeypress="authCodeValidator(event);">
                        <input type="text" pattern="\d*" inputmode="numeric" class="secondPart" maxlength="4" onkeypress="authCodeValidator(event);">
                        <input type="text" pattern="\d*" inputmode="numeric" class="thirdPart" maxlength="4" onkeypress="authCodeValidator(event);">
                    </div>
                </div>

                <div class="downBlock">
                    <div class="title">
                        <span class="strongLabel" > 다른 기기 브라우저에 저장되어 있는 인증서를 가져옵니다. </span>
                    </div>
                    <div class="image">
                        <img src="images/cert_import_roaming_x2_tablet.png" alt="인증서 가져오기 이미지">
                    </div>
                    <div class="notification">
                        <img src="images/check.png" aria-selected="false">
                        <span> 다른 기기 브라우저에 표시된 인증번호를 확인후 입력해주세요. </span>
                    </div>
                </div>
     
            </div>

            <div class="footer">
                <div class="okButtonBlock">
                    <button class="ok okButtonMsg blueButton">확인</button>
                    <button class="cancel cancelButtonMsg whiteButton">취소</button>
                </div>
            </div>

            <div id="numKeyboard" style="display: none">
                <div class="numKeyboardBox">
                    <div class="numKeyboardCloseDiv">
                        <div class="numKeyboardClose" onclick="return desktop.numKeyboard.close()" role="button" aria-label="가상키패드 닫기"></div>
                    </div>
                    <table >
                        <tr>
                            <td><div class="button" onclick="desktop.numKeyboard.click('1')" role="button">1</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('2')" role="button">2</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('3')" role="button">3</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('4')" role="button">4</div></td>
                        </tr>
                        <tr>
                            <td><div class="button" onclick="desktop.numKeyboard.click('5')" role="button">5</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('6')" role="button">6</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('7')" role="button">7</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('8')" role="button">8</div></td>
                        </tr>
                        <tr>
                            <td><div class="button" onclick="desktop.numKeyboard.click('9')" role="button">9</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('0')" role="button">0</div></td>
                            <td></td><td><div class="button back-button" onclick="desktop.numKeyboard.click(8)" role="button" aria-label="지우기"></div></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- 인증서 찾기 -->
    <div id="importLocalDialog" style="display:none">
        <div id="importLocalDialogBody">
            <div class="titleBarBlock">
                <div class="dialogTitle">인증서 찾기</div>
                <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_tablet_x2.png?<%=releaseDate%>" alt="델피노 로고"></div>
                <div class="selectCertStoreMsgTitleLine"></div>         
            </div>
            <div class="content">
                <div class="messagebox" role="text">
                <div class="message">NPKI 폴더내에 인증서와 개인키 파일을 직접 선택하여 인증서를 저장합니다.</div>
                <img src="images/cert_search.png?<%=releaseDate%>" alt="인증서 설명 이미지">
                </div>
                <div class="cert" role="button">
                    <span class="certLabel">인증서(signCert.der)</span>
                    <button class="importButton" onclick="desktop.loadPKCS8('.der')">가져오기</button>
                    <img src="images/check.png?<%=releaseDate%>">
                </div>
                <div class="key" role="button"><span class="keyLabel">개인키(signPri.key)</span>
                    <button class="importButton" onclick="desktop.loadPKCS8('.key')">가져오기</button>
                    <img src="images/check.png?<%=releaseDate%>">
                </div>
                <div class="passwordInputBlock">
                    <div>
                        <label class="passwordLabel">인증서 암호</label>
                        <input class="password" name="importLocalPasswordInput" type="password"></input>
                    </div>
                    <div class="okButtonBlock">
                        <button class="ok okButton okButtonMsg blueButton">확인</button>
                        <button class="cancel cancelButton cancelButtonMsg whiteButton">취소</button>
                    </div>
                </div>
            </div>
            <div class="horizontalLine"></div>

            <div class="keyboardBlock"></div>
        </div>
    </div>

    <!-- 인증서 가져오기--> 
    <div id="importCertificatePopup" style="display:none">
        <div id="importCertificatePopupBody" style="overflow:hidden">
            <div class="importMessageBlock">
<!--                 <div class="innerBlock">
                </div>
 -->            </div>
        </div>
    </div>

    <!-- 인증서 원사인에서 가져오기 -->
    <div id="importOneSignDialog" style="display:none">
        <div id="importOneSignDialogBody">
            <div class="titleBarBlock">
                <div class="dialogTitle">인증서 찾기</div>
                <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_tablet_x2.png?<%=releaseDate%>" alt="델피노 로고"></div>
                <div class="selectCertStoreMsgTitleLine"></div>         
            </div>
            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo-tablet.png?<%=releaseDate%>" alt="로고이미지">
            </div>
            <div class="content">
                <div class="message"><span class="pasteMessage">아래 영역을 꾹 눌러 복사한 인증서를 붙여넣기 해 주세요.</span> <div class="rightAlign"><a href="" class="openOneSignDirect">원싸인앱 직접 열기</a></div></div>
                <!-- <img src="images/cert_search.png?<%=releaseDate%>"> -->
                <div class="pasteArea">
                    <input id="pasteForm" class="pasteForm" contenteditable="true"></input>
                </div>
                <div class="horizontalLine"></div>
                <div class="okButtonBlock">
                    <button class="cancel cancelButton cancelButtonMsg whiteButton">취소</button>
                </div>
            </div>

            <div class="horizontalLine"></div>
        </div>
    </div>

    <div id="importTransferCertDialog" style="display:none">
        <div id="importTransferCertDialogBody">
            <div class="titleBarBlock">
                <div class="dialogTitle">인증서 찾기</div>
                <div class="dolphinLogo"><img class="img" src="images/dolphin-logo_tablet_x2.png?<%=releaseDate%>" alt="델피노 로고"></div>
                <div class="selectCertStoreMsgTitleLine"></div>         
            </div>
            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo-tablet.png?<%=releaseDate%>" alt="로고이미지">
            </div>
            <div class="content">
                <div class="detailImportNotice">
                    <span class="importMessage">스마트폰에 저장된 인증서를 앱을 이용하여 현재 사용 중인 브라우저로 가져옵니다.</span>
                </div>
                <div class="detailImportLogo"><img class="img" src="images/cert_import_relayserver_mobile.png?<%=releaseDate%>" alt></div>
                <div class="detailImportMobile">
                    <span class="importHelpMsg"><img src="icons/cert_import_info_check.png" alt><span class="importHelpMsgLabel">"인증서 복사 앱"이 실행되면 가져올 인증서를 선택 후 인증서 비밀번호를 입력해 주십시오.</span></span>
                    <span class="importHelpMsgError"><img src="icons/cert_import_info_check.png" alt><span class="importHelpMsgErrorLabel">"인증서 복사 앱"이 정상적으로 실행되지 않았습니다. 처음 설치 하셨을 경우 아래 [가져오기]를 다시 선택하여 주시기 바랍니다.</span></span>
                </div>
                <div class="okButtonBlock importMobileFooter">
                    <div class="importMobileFooter"> 
                        <button class="cancel cancelButton cancelButtonMsg whiteButton" role="button">취소</button>
                        <div class="importCertRetry">
                            <a class="ok okButton importButton" onclick="mobile.importCert('relayServerRetry'); return false" role="button">가져오기</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="horizontalLine"></div>
        </div>
    </div>
    <!-- 인증서 자세히 보기 -->
    <div id="certDetailDialog" style="display:none">
        <div id="certDetailDialogBody">
        <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 자세히 보기</div>
                    <div class="selectCertStoreMsgTitleLine"></div>         
             </div>
            <div class="tabHead"></div>
            <div class="tabBody">
                <!-- 일반 탭 -->
                <div class="tab1" role="tabpanel">
                    <div class="tab1_block" >
                        <div role="text">[상태검증] : 지원되지 않는 기능입니다.</div>
                        <div role="text">[발급대상] : </div>
                        <div role="text">[ 발급자 ] : </div>
                        <div role="text">[유효기간] : </div>
                        <div role="text">[ PC시간 ] : </div>
                    </div>
                </div>
                <!-- 자세히 탭 -->
                <div class="tab2"  role="tabpanel" style="display:none">
                    <div> 
                        <table class="header">
                            <tr> <td class="name">이름</td> <td class="value">값</td> </tr>
                        </table>
                        <div class="tableWrapperDiv"> <!-- for scroll -->
                            <table class="body">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                        <div class="moreDetail">
                           &nbsp; 
                        </div>
                    </div>
                </div>
            </div>
            <div class="okButtonBlock">
                <button class="ok okButton okButtonMsg blueButton">확인</button>
            </div>
        </div>
    </div>

	<!-- G10 providers menu section -->
	<div id="certificateProviderList" class="g10_nav_shadow" style="display:none">
		<div class="g10_folding" role="button"></div>
		<div id="g10_navMenu" class="g10_navMenu"></div>
		<div class="version_text"></div>
	</div>
	
	<!-- G10 content section -->
	<div id="providerContent" class="providerContent">
		<fieldset id="delfino-section" class="rightContent"></fieldset>
		<fieldset id="providers-section" class="rightContent">
			<div class="titleBarBlock section">
				<div class="dialogTitle" id="selectDialogTitle section-title">전자 서명 작성</div>
            </div>
			<div id="vpcg_content">
				<span class="vpcg_btn_close" title="닫기"></span>
				<div class="vpcg_section_user_auth vpcg_section_right_on">
					<form class='formData' name="vpcg_formLogin" onsubmit="return false;">
						<div class="vpcg_section_sign_logo"></div>
						<div class="vpcg_inputfield name">
							<input type="text" class="vpcg_login_data vpcg_user_name" name="name" maxlength="10" placeholder="이름 입력"></input>
							<label></label>
						</div>
						<div class="vpcg_inputfield birthday">
							<input type="tel" class="vpcg_login_data vpcg_user_birthday" name="birthday" maxlength="14" placeholder="생년월일 입력 (1985 / 01 / 30)"></input>
							<label></label>
						</div>
						<div class="vpcg_inputfield phone">
							<input type="tel" class="vpcg_login_data vpcg_user_phone" name="phone" maxlength="17" placeholder="휴대폰 번호 입력"></input>
							<label></label>
						</div>
						<div class="vpcg_terms">
							<div class="all_terms">
								<div class="all_terms_check" tabindex="-1">
									<input class="vpcg_all_terms_check" id="vpcg_all_terms_check" type="checkbox" />
									<label htmlFor="vpcg_all_terms_check"></label><span class="allTerm">필수약관 전체동의</span>
								</div>
							</div>
							<div class="service_terms">
								<div class="service_terms_check" tabindex="-1">
									<input class="vpcg_service_terms_check small" id="vpcg_service_terms_check" type="checkbox" />
									<label htmlFor="vpcg_service_terms_check"></label><span class="serviceTerm">서비스 이용약관 동의</span><span class="essential">(필수)</span>
								</div>
								<a class="service_terms_view termView" id="serviceView" target="_blank">보기></a>
							</div>
							<div class="privacy_terms">
								<div class="privacy_terms_check" tabindex="-1">
									<input class="vpcg_privacy_terms_check small" id="vpcg_privacy_terms_check" type="checkbox" />
									<label htmlFor="vpcg_privacy_terms_check"></label><span class="privacyTerm">개인정보 이용 동의</span><span class="essential">(필수)</span>
								</div>
								<a class="privacy_terms_view termView" id="privacyView" target="_blank">보기></a>
							</div>
							<div class="info_terms">
								<div class="info_terms_check" tabindex="-1">
									<input class="vpcg_info_terms_check small" id="vpcg_info_terms_check" type="checkbox" />
									<label htmlFor="vpcg_info_terms_check"></label><span class="_3rdPartyTerm">제3자 정보제공 동의</span><span class="essential">(필수)</span>
								</div>
								<a class="info_terms_view termView" id="infoView" target="_blank">보기></a>
							</div>
						</div>
						<button class="vpcg_btn_login vpcg_ok_button" disabled>확인</button>
					</form>
				</div>
				<div class="vpcg_section_pinsign"></div>
				<div class="vpcg_section_popup">
					<div class="vpcg_popup_banner1">
						<div class="popup_banner1_box">
							<span class="title checkPopup"><span class="l1"><span class="name">팝업창</span>을 </span>확인해주세요.</span>
						</div>
					</div>
					<div class="vpcg_popup_banner2">
						<div class="popup_banner2_box">
							<span class="title name">금융인증서</span><span class="title">를 선택하셨습니다.</span>
							<div class="desc"><span class="popup_disable"><span class="name">금융인증서</span>의 팝업창이 열리지 않았다면 </span><u>아래 버튼</u>을 눌러 인증을 진행해주세요.</div>
						</div>
					</div>
					<div class='vpcg_popup_open' tabindex='-1' role='button'>
						<div class='button_title vpcg_ok_button'>확인</div>
					</div>
				</div>
				<div class="vpcg_section_wait vpcg_info_screen_normal">
					<div class="vpcg_img_loading">
						<img class="loading_gif" src="images/g10/icon/img_send_blue.gif"/>
					</div>
					<div class="vpcg_info_top_text">인증요청이 휴대폰으로 전송되었습니다.</div>
					<div class="vpcg_info_bottom_text vpcgInfoFirst">선택한 인증수단의 <span class="fs-13 color-06 fw-b">모바일앱 알람</span>을 확인해주세요.</div>
				</div>
				<div class="vpcg_section_wait_btn vpcg_info_screen_normal with_button">
					<div class="vpcg_img_loading">
						<img class="loading_gif" src="images/g10/icon/img_send_blue.gif"/>
					</div>
					<div class="vpcg_info_top_text">인증요청이 휴대폰으로 전송되었습니다.</div>
					<div class="vpcg_info_bottom_text vpcgInfoSecond">선택한 인증수단의 <span class="fs-13 color-06 fw-b">모바일앱에서 인증을 완료</span>한 후,<br/>아래의 <span class="fs-13 color-06 fw-b"><u>확인버튼</u></span>을 눌러주세요.</div>
					<button class='vpcg_wait_button' disabled>확인</button>
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
					<div class="vpcg_btn_sign vpcg_ok_button" tabindex="-1">확인</div>
				</div>
			</div>
		</fieldset>
		<div id="g10-loading-section" class="rightContent">
			<div class="vpcg_img_loading">
				<img src="images/g10/icon/loading_blue.gif"/>
				<span class="vpcg_loading">로딩중입니다.</span>
			</div>
		</div>
		<div id="g10-intro-section" class="rightContent">
			<span class="vpcg_btn_close" role="button" aria-label="닫기" tabindex='-1'></span>
			<div class="intro_new_title_box">통합 인증 플랫폼</div>
			<div class="intro_provider_box">
				<div class="provider_row first_row"></div>
				<div class="provider_row second_row"></div>
			</div>
			<div class="intro_desc_box">
				<div class="intro_title_label"><span class="label title_label">공동/금융/간편 인증서</span></div>
				<div class="intro_title_main"><span class="title name">인증수단</span>을<br/>선택해주세요</div>
				<div class="intro_title_description"><span class="description">왼쪽 리스트에서 인증수단을 선택하시면 인증입력 화면으로 이동합니다.</span></div>
			</div>
		</div>
	</div>
<%
    }
%>
