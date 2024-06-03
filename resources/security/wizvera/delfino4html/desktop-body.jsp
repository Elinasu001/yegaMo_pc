<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (mode.equals("desktop")) {
        String dataenc = "data-enc=\"off\"";
        if(touchenKeyJs != null)
            dataenc = "data-enc=\"on\"";
%>
    <!-- desktop -->
    <!-- 전자 서명 작성 -->
    <div id="selectDialog" style="display:none">
        <div id="selectDialogBody" aria-labelledby="selectDialogTitle"
            data-tab-order="browserButton, cloudButton, localDiskButton, extensionMediaButton, certificateTable, viewButton, importButton, deleteButton, passwordInput, okButton, cancelButton">
            <div class="titleBarBlock section">
                    <div class="dialogTitle" id="selectDialogTitle section-title">전자 서명 작성</div>
                    <div class="float-right"><img class="img" src="images/dolphin-logo.png?<%=releaseDate%>" aria-label="델피노 로고" alt="델피노 로고"></div>
                    <div class="selectCertStoreMsgTitleLine"></div>
            </div>
            <div class="logoBlock section">
                <img class="logo" src="images/wizvera-logo1.png?<%=releaseDate%>">
                <div align="right">
                    <span class="html5Intro">
                        <span class="browserCertificate">브라우저 인증서</span>
                        <img src="images/question_x1.png?<%=releaseDate%>" aria-label="물음표 이미지" alt="물음표 이미지">
                    </span>
                </div>
            </div>
            <div class="confirmDataBlock section" style="display:none">
                <div class="confirmSignLogoBlock" style="display:none">
                    <img class="confirmSignLogo" src="images/wizvera-logo1.png?<%=releaseDate%>">
                </div>
                <div class="strongLabel confirmSignDataLabel section-title">해당 내용을 확인하신후 서명해주세요.</div>
                <div class="tableWrapperDiv"> <!-- for scroll -->
                <table class="confirmDataTable">
                    <tbody>
                    </tbody>
                </table>
                </div>
            </div>
            <div class="storageBlock section">
                <div class="selectCertStoreMsg strongLabel section-title">인증서 저장 위치를 선택해주세요</div>
                <div class="nativeSupportOff">
                    <div class="storageButtonBlock">
                        <button class="browserButton" aria-label="브라우저" alt="브라우저">브라우저</button>
                        <button class="cloudButton" aria-label="클라우드" alt="클라우드">클라우드</button>
                        <button class="localDiskButton" aria-label="로컬디스크" alt="로컬디스크">로컬디스크</button>
                        <button class="extensionMediaButton" aria-label="확장매체" alt="확장매체">확장매체</button>
                    </div>
                </div>
                <div align="right" class="need_g3_message" style="display:none"></div>
            </div>
            <div class="certificateBlock section">
                <div class ="selectCertificateMsg strongLabel section-title">사용할 인증서를 선택해주세요</div>
                <div class = "certificateTableOuter" style="position:relative">
                    <div class="certificateTable" aria-label="인증서 목록" alt="인증서 목록"></div>
                    <div class="certExpireNotification" style="display:none">
                        <div class="header" style="relative">
                            <img src="images/warning.png" aria-label="경고 이미지" alt="경고 이미지">
                            <span></span>
                            <img class="close" src="images/close.png" aria-lable="경고창 닫기 버튼" style="position:absolute; right:0;">
                        </div>
                        <div class="body"> </div>
                    </div>
                </div>
                <div class="certButtonBlock">
                    <button class="manageButton certManageMsg" style="display:none">인증서 관리</button>
                    <button class="deleteButton certDeleteMsg">인증서 삭제</button>
                    <button class="importButton certSearchMsg">인증서 찾기</button>
                    <button class="viewButton certViewMsg">인증서 보기</button>
                </div>
            </div>
            <div class="passwordBlock section">
                <div class="inputCertPasswordMsg strongLabel section-title">인증서 암호를 입력해 주세요</div>
                <div class="passwordBorder">
                    <div class="passwordBlockInner">
                        <div class="lodingClickPrevention" style="position: absolute; width: 100%; height: 33px; z-index: 1;"></div>
                        <input class="passwordInput" aria-label="인증서 암호" alt="인증서 암호" name="selectDialogPasswordInput" type="password" autocomplete="off" disabled  <%=dataenc%> ><button class="keyboardButton" style="display: none;"></button><button class="qrPasswordButton" style="display: none;"></button>
                    </div>
                    <div class="passwordPolicyMsg">안전한 금융거래를 위해 6개월마다 인증서 암호를 변경하시기 바랍니다.</div>
                </div>
            </div>
            <div class="okButtonBlock section">
                <button class="okButton okButtonMsg">확인</button>
                <button class="cancelButton cancelButtonMsg">취소</button>
            </div>
            <div class ="opencertWarningLabel section"></div>
        </div>
    </div>

    <!-- 인증서 제출 -->
    <div id="exportCertificateDialog" style="display:none">
        <div id="exportCertificateDialogBody"
            data-tab-order="browserButton, cloudButton, localDiskButton, extensionMediaButton, certificateTable, viewButton, importButton, deleteButton, okButton, cancelButton">
            <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 내보내기</div>
                    <div class="float-right"><img class="img" src="images/dolphin-logo.png?<%=releaseDate%>" aria-label="델피노 로고" alt="델피노 로고"></div>
                    <div class="selectCertStoreMsgTitleLine"></div>
             </div>
            <div class="logoBlock">
                <img class="logo" src="images/wizvera-logo1.png?<%=releaseDate%>">
            </div>
            <div class="confirmDataBlock" style="display:none">
                <div class="strongLabel confirmSignDataLabel">해당 내용을 확인하신후 서명해주세요.</div>
                <div class="tableWrapperDiv"> <!-- for scroll -->
                <table class="confirmDataTable">
                    <tbody>
                    </tbody>
                </table>
                </div>
            </div>
            <div class="storageBlock">
                <div class="selectCertStoreMsg strongLabel">인증서 저장 위치를 선택해주세요</div>
                <div class="nativeSupportOff">
                    <div class="storageButtonBlock">
                        <button class="browserButton" aria-label="브라우저" alt="브라우저">브라우저</button>
                        <button class="cloudButton" aria-label="클라우드" alt="클라우드">클라우드</button>
                        <button class="localDiskButton" aria-label="로컬디스크" alt="로컬디스크">로컬디스크</button>
                        <button class="extensionMediaButton" aria-label="확장매체" alt="확장매체">확장매체</button>
                    </div>
                </div>
                <div align="right" class="need_g3_message" style="display:none"></div>
            </div>
            <div class="certificateBlock">
                <div class ="selectCertificateMsg strongLabel">사용할 인증서를 선택해주세요</div>
                <div class="certificateTable" aria-label="인증서 목록" alt="인증서 목록"></div>
                <div class="certButtonBlock">
                    <button class="deleteButton certDeleteMsg">인증서 삭제</button>
                    <button class="importButton certSearchMsg">인증서 찾기</button>
                    <button class="viewButton certViewMsg">인증서 보기</button>
                </div>
            </div>
            <div class="okButtonBlock">
                <button class="okButton okButtonMsg">확인</button>
                <button class="cancelButton cancelButtonMsg">취소</button>
            </div>
            <div class ="opencertWarningLabel"></div>
        </div>
    </div>

    <!-- 인증서 관리 -->
    <div id="manageDialog" style="display:none">
        <div id="manageDialogBody"
            data-tab-order="browserButton, cloudButton, localDiskButton, extensionMediaButton, certificateTable, copyButton, deleteButton, viewButton, changeButton, importButton, exportButton, closeButton">
            <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 관리</div>
                    <div class="float-right"><img class="img" src="images/dolphin-logo.png?<%=releaseDate%>" aria-label="델피노 로고" alt="델피노 로고"></div>
                    <div class="selectCertStoreMsgTitleLine"></div>
            </div>

            <div class="storageBlock">
                <div class="strongLabel certStoreLocation">인증서 위치</div>
                <div class="nativeSupportOff">
                    <div class="storageButtonBlock">
                        <button class="browserButton" aria-label="브라우저" alt="브라우저">브라우저</button>
                        <button class="cloudButton" aria-label="클라우드 " alt="클라우드 ">클라우드</button>
                        <button class="localDiskButton" aria-label="로컬디스크" alt="로컬디스크">로컬디스크</button>
                        <button class="extensionMediaButton" aria-label="확장매체" alt="확장매체">확장매체</button>
                    </div>
                </div>
                <div align="right" class="need_g3_message" style="display:none"></div>
            </div>
            <div class="certificateBlock">
                <div class ="strongLabel selectCertLabel">인증서 선택</div>
                <div class="certificateTable" aria-label="인증서 목록" alt="인증서 목록"></div>
            </div>
            <div class="certificateJobs">
                <div class="strongLabel certJobs">인증서 작업들</div>
                <div class="jobsBox">
                    <div class="left">
                        <button class="copyButton">인증서 복사</button>
                        <button class="deleteButton">인증서 삭제</button>
                        <button class="viewButton">인증서 보기</button>
                    </div>
                    <div class="center">
                        <div class="line">&nbsp;</div>
                    </div>
                    <div class="right">
                        <button class="changeButton">암호변경</button>
                        <button class="importButton">가져오기</button>
                        <button class="exportButton">내보내기</button>
                    </div>
                </div>
            </div>
            <div class="okButtonBlock">
                <div class="version">v1.0.0.0</div>
                <button class="closeButton">닫기</button>
            </div>
            <div class ="opencertWarningLabel"></div>
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
                        <label class="certPassword">인증서 비밀번호</label><input class="passwordInput easyPasswordDialogInput" aria-label="인증서 암호" alt="인증서 암호" name="easyPasswordDialogInput" type="password" autocomplete="off" disabled  <%=dataenc%> /><button class="keyboardButton" style="display: none"></button>
                    </div>
                    <div class='certpinContainer' style="display: none;">
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

    <!-- 간편 비밀번호 생성 -->
    <div id="createEasyPasswordDialog" style="display:none">
        <div id="createEasyPasswordDialogBody" data-tab-order="passwordInput, okButton, cancelButton">
             <div class="titleBarBlock">
                    <div class="closeButton"><img src="icons/creatEasyPasswordCloseButton.png" onclick="return desktop.pinKeypad.createEasyPasswordClose();" ></div>
                    <div class="dialogTitle createEasyPasswordTitle"><span class=textFirstLine>간편 비밀번호 인증</span><br><span class=textSecondLine>생성을 시작합니다.</span></div>
                    <div class="selectCertStoreMsgTitleLine"></div>
             </div>

            <div class="passwordBlock">
                <div class="passwordBorder">
                    <p class="createEasyPasswordCancelLabel keyboardPasswordCheck" style="padding-bottom: 0px;">인증서 암호를 입력해 주세요.</p>
                    <p class="createEasyPasswordCancelLabel firstPinCheck" style="display: none;">간편비밀번호 6자리를 <b>입력</b>해주세요.</p>
                    <p class="createEasyPasswordCancelLabel rePinCheck" style="display: none;">간편비밀번호 6자리를 <b>다시 입력</b>해주세요.</p>
                    <p class="createEasyPasswordCancelLabel sameNumberCheckLabel" style="display: none; color: crimson;">같은 숫자를 연속으로 사용할 수 없습니다.</p>
                    <p class="createEasyPasswordCancelLabel continuousNumberCheckLabel" style="display: none; color: crimson;">연속된 숫자를 사용할 수 없습니다.</p>
                    <div class=lastEasyPasswordTitle style="display: none;"><span>돌아가셔서 간편 비밀번호 인증을</span><br><span>이용해보세요.</span></div>
                    <div class="passwordBlockInner createEasyPasswordCancelInput">
                        <input class="passwordInput" aria-label="인증서 암호" alt="인증서 암호" name="easyPasswordDialogInput" type="password" autocomplete="off" disabled  <%=dataenc%> /><button class="keyboardButton" style="display: none"></button>
                    </div>
                    <div class='certpinContainer' style="display: none;">
                        <div class="certpinInputBlock createEasyPasswordDiv">
                            <div class="certpin certpinCreate" style="padding-bottom: 10px">
                                <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinCreateInput createEasyPasswordInput" type="password"></input>
                            </div>
                            <div class="certpin certpinConfirm" style="padding-bottom: 0">
                                <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                                <input class="certpinInput certpinConfirmInput createEasyPasswordInput" type="password"></input>
                            </div>
                        </div>
                        <div id="pinKeypad" style="width: 100%; padding: 0 23px;">
                            <div class="notEasyPassword">
                                <div class="pinKeypadBox" style="padding: 25px 10px">
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
                                                <td><div class="button re-order" style="font-size:11px; color:#555555; line-height: 25px; vertical-align: middle;" role="button" onclick="return desktop.pinKeypad.generateKeyboard();"></div></td>
                                                <td><div class="button back-button" style="display: inline-block; height: 13px; background-size: 25px 15px;" role="button" onclick="return desktop.pinKeypad.backspace();"></div></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="okButtonBlock nextButtonBlock">
                <button class="okButton createEasyPasswordButton nextButton">다음</button>
                <button class="createEasyPasswordButton beforeButton" style="display:none" onclick="return desktop.pinKeypad.createEasyPasswordDialog();">이전</button>
                <button class="createEasyPasswordButton sucessButton" style="display:none" onclick="return desktop.pinKeypad.createEasyPasswordClose();">확인</button>
                <button class="cancelButton cancelButtonMsg createEasyPasswordCancelButton" onclick="return desktop.pinKeypad.createEasyPasswordClose();">취소</button>
            </div>
        </div>
    </div>

    <!-- 인증서 암호 -->
    <div id="passwordDialog" style="display:none">
        <div id="passwordDialogBody" data-tab-order="passwordInput, okButton, cancelButton">
             <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 암호</div>
                    <div class="selectCertStoreMsgTitleLine"></div>
             </div>

            <div class="passwordBlock">
                <div class="passwordBorder">
                    <div class="inputCertPasswordMsg strongLabel">인증서 암호를 입력해 주세요.</div>
                    <div class="passwordBlockInner">
                        <span class="certPasswordLabel">인증서 암호</span>
                        <input class="passwordInput" aria-label="인증서 암호" alt="인증서 암호" name="passwordDialogInput" type="password" autocomplete="off" disabled  <%=dataenc%> /><button class="keyboardButton" style="display: none"></button>
                    </div>
                    <div class="saveToBrowser" style="display:none">
                        <input type="checkbox" id="saveToBrowser" name="saveToBrowser" checked><label for="saveToBrowser" class="saveToBrowserLabel">인증서를 브라우저에 저장합니다.</label><br>
                    </div>
                </div>
            </div>
            <div class="passwordPolicyMsg">인증서 비밀번호의 안정성을 위해 <span class="strongLabel">6개월 마다 변경할실 것을 권고</span>하며, 인증서가 <span class="strongLabel">저장된 매체별로 각각 변경</span> 하시기 바랍니다.</div>
            <div class="okButtonBlock">
                <button class="okButton okButtonMsg">확인</button>
                <button class="cancelButton cancelButtonMsg">취소</button>
            </div>
        </div>
    </div>

    <!-- 인증서 암호 변경-->
    <div id="passwordChangeDialog" style="display:none">
        <div id="passwordChangeDialogBody" data-tab-order="oldPasswordInput, newPasswordInput, newPasswordConfirmInput, okButton, cancelButton">
                <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 암호 변경</div>
                    <div class="selectCertStoreMsgTitleLine"></div>
             </div>

            <div class="passwordBlock">
                <div class="passwordBorder">
                    <div class="inputCertPasswordMsg strongLabel">암호는 10자 이상 영문자/숫자/특수기호의 조합으로 사용가능합니다.
                    </div>
                    <div class="passwordBlockInner">
                        <span class="strongLabel oldPassword">이전 암호</span>
                        <input class="oldPasswordInput" name="oldPasswordDialogInput" aria-label="이전 암호" alt="이전 암호" type="password" autocomplete="off" disabled  <%=dataenc%> /><button class="keyboardButton" style="display: none;"></button>
                    </div>
                    <div class="passwordBlockInner">
                        <span class="strongLabel newPassword">새 암호</span>
                        <input class="newPasswordInput" name="newPasswordDialogInput" aria-label="새 암호" alt="새 암호" type="password" autocomplete="off" disabled  <%=dataenc%> /><button class="keyboardButton" style="display: none;"></button>
                    </div>
                    <div class="passwordBlockInner">
                        <span class="strongLabel newPasswordConfirm">새 암호 확인</span>
                        <input class="newPasswordConfirmInput" name="newConfirmPasswordDialogInput" aria-label="새 암호 확인" alt="새 암호 확인" type="password" autocomplete="off" disabled  <%=dataenc%> /><button class="keyboardButton" style="display: none;"></button>
                    </div>
                </div>
            </div>
            <div class="passwordPolicyMsg">인증서 비밀번호의 안정성을 위해 <span class="strongLabel">6개월 마다 변경할실 것을 권고</span>하며, 인증서가 <span class="strongLabel">저장된 매체별로 각각 변경</span> 하시기 바랍니다.</div>
            <div class="okButtonBlock">
                <button class="okButton okButtonMsg">확인</button>
                <button class="cancelButton cancelButtonMsg">취소</button>
            </div>
        </div>
    </div>

    <!-- 인증서 자세히 보기 -->
    <div id="certDetailDialog" style="display:none">
        <div id="certDetailDialogBody" data-tab-order="tab1, tab2, okButton">
        <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 자세히 보기</div>
                    <div class="selectCertStoreMsgTitleLine"></div>
             </div>
            <div class="tabHead"></div>
            <div class="tabBody">
                <!-- 일반 탭 -->
                <div class="tab1">
                    <div class="tab1_block" >
                        <div>[상태검증] : 지원되지 않는 기능입니다.</div>
                        <div>[발급대상] : </div>
                        <div>[ 발급자 ] : </div>
                        <div>[유효기간] : </div>
                        <div>[ PC시간 ] : </div>
                    </div>
                </div>
                <!-- 자세히 탭 -->
                <div class="tab2" style="display:none">
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
                <button class="okButton okButtonMsg">확인</button>
            </div>
        </div>
    </div>

    <!-- 인증서 저장 -->
    <div id="saveToDiskDialog" style="display:none">
        <div id="saveToDiskDialogBody" data-tab-order="saveButton, cancelButton">
            <div class="titleBarBlock">
                <div class="dialogTitle">인증서 저장</div>
                <div class="selectCertStoreMsgTitleLine"></div>
             </div>

             <div class="saveToDiskDialogBlock">
                 <div class="saveToDiskMsg">인증서를 로컬 디스크에 저장하시겠습니까?</div>
              </div>

              <div class="saveToDiskDialogBlockButton">
                  <span id="saveToDisk" class="save">
                      <button class="saveButton">저장</button>
                  </span>
                  <span class="cancel">
                      <button class="cancelButton">취소</button>
                  </span>
              </div>

        </div>
    </div>

    <!-- 인증서 발급후 저장 -->
    <div id="oneMoreSaveToDiskDialog" style="display:none">
        <div id="oneMoreSaveToDiskDialogBody" data-tab-order="saveButton, cancelButton">
            <div class="titleBarBlock">
                    <div class="dialogTitle">인증서 로컬 디스크 저장</div>
                    <div class="selectCertStoreMsgTitleLine"></div>
            </div>
            <div class="saveToDiskDialogBlock">
                <div class="saveToDiskMsg">
                    인증서는 브라우저 저장소에 저장되었습니다. <br/>
                    인증서를 추가로 pfx(p12)형태로 로컬 디스크에 저장합니다.
                </div>
            </div>
            <div class="saveToDiskDialogBlockButton">
                <span id="oneMoreSaveToDisk" class="save">
                    <button class="saveButton okButtonMsg">저장</button>
                </span>
                <span class="cancel">
                    <button class="cancelButton cancelButtonMsg">취소</button>
                </span>
            </div>
        </div>
    </div>

    <!-- 암호 생성 -->
    <div id="passwordCreateDialog" style="display:none">
        <div id="passwordCreateDialogBody" data-tab-order="newPasswordInput, newPasswordConfirmInput, okButton, cancelButton">
         <div class="titleBarBlock">
                    <div class="passwordCreateTitle dialogTitle">인증서 암호 생성</div>
                    <div class="passwordCreateTitleLine"></div>
             </div>
            <div class="passwordBlock">
                <div class="passwordBorder">
                    <div class="inputCertPasswordMsg strongLabel">새 인증서 암호를 입력해 주세요.<br/>
                    암호는 10자 이상 영문자/숫자/특수기호의 조합으로 사용가능합니다.
                    </div>
                    <div class="passwordBlockInner">
                        <span class="strongLabel newPassword">암호</span>
                        <input class="newPasswordInput" aria-label="암호" alt="암호" name="newCreatePasswordDialogInput" type="password" autocomplete="off" disabled  <%=dataenc%> /><button class="keyboardButton" style="display: none"></button>
                    </div>
                    <div class="passwordBlockInner">
                        <span class="strongLabel newPasswordConfirm">암호 확인</span>
                        <input class="newPasswordConfirmInput" aria-label="암호 확인" alt="암호 확인" name="newCreateConfirmPasswordDialogInput" type="password" autocomplete="off" disabled  <%=dataenc%> /><button class="keyboardButton" style="display: none"></button>
                    </div>
                </div>
            </div>
            <div class="passwordPolicyMsg">인증서 비밀번호의 안정성을 위해 <span class="strongLabel">6개월 마다 변경할실 것을 권고</span>하며, 인증서가 <span class="strongLabel">저장된 매체별로 각각 변경</span> 하시기 바랍니다.</div>
            <div class="okButtonBlock">
                <button class="okButton okButtonMsg">확인</button>
                <button class="cancelButton cancelButtonMsg">취소</button>
            </div>
        </div>
    </div>

    <!-- 가상키보드 -->
    <div id="keyboardDialog" style="display:none">
        <div class="keyboardTab" style="display: none; margin: -4px; cursor: pointer;">
            <div class= "virtualKeyboardTab" style="display: table-cell; width: 373px; height: 33px; vertical-align: middle; text-align: center; font-weight: bold; font-size: 12px;">가상키보드</div>
            <div class= "easyPasswordTab" style="display: table-cell; width: 373px; height: 33px; vertical-align: middle; text-align: center; font-size: 12px; background: #eeeeee">간편비밀번호</div>
        </div> 
        <div class="easyPassword" style="display: none;">
            <div class="easyPasswordTitle">
                <img src="icons/ic_info.png"></img>
                <span class="haveEasyPasswordTitle">간편비밀번호 암호를 입력해주세요.</span>
                <span class="noneEasyPasswordTitle" style="display: none;">간편비밀번호가 없습니다.</span>
                <span class="noneCloudTitle " style="display: none; width: 267px;">인증서 클라우드에 연결되어 있지 않습니다.</span>
            </div>
            <div class="loadingBackground" style="display: none;">
                <div class="loadingContainer">
                    <div class="loadingImg"></div>
                    <div class="loadingText">간편비밀번호 로딩 중</div>
                </div>
            </div>
            <div class="passwordContainer">
                <div class="inputPasswordContainer">
                    <div class="content">
                        <div class="certpinInputBlock">
                            <div class="certpin haveCertpin">
                                <label class="certpinLabel">암호 입력</label>
                                <input class="certpinInput desktop" type="password"></input>
                                <input class="certpinInput desktop" type="password"></input>
                                <input class="certpinInput desktop" type="password"></input>
                                <input class="certpinInput desktop" type="password"></input>
                                <input class="certpinInput desktop" type="password"></input>
                                <input class="certpinInput desktop" type="password"></input>
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
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                    </tr>
                                    <tr class="trLine"></tr>
                                    <tr>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button pin" role="button"></div></td>
                                        <td><div class="button re-order" style="font-size:14px; color:#555555; line-height: 25px; vertical-align: middle;" role="button" onclick="return desktop.pinKeypad.generateKeyboard();"></div></td>
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
        <div id="keyboardDialogBody">
            <div class="titleBarBlock">
            </div>
            <div class="keyboard" style="padding:0;margin:0;position:relative;">
            <div class="keyboardLoading">
                <img src="images/keyboard_loading_progress.gif" class="keybaordLoadingProgress"/>
            </div>
            <img src="images/selectedkey_34.png?<%=releaseDate%>"  style="position:absolute; top:0; left:0;display:none" class="selectedkey selectedkey_34">
            <img src="images/selectedkey_54.png?<%=releaseDate%>"  style="position:absolute; top:0; left:0;display:none" class="selectedkey selectedkey_54">
            <img src="images/selectedkey_74.png?<%=releaseDate%>"  style="position:absolute; top:0; left:0;display:none" class="selectedkey selectedkey_74">
            <img src="images/selectedkey_114.png?<%=releaseDate%>" style="position:absolute; top:0; left:0;display:none" class="selectedkey selectedkey_114">
            <img src="images/selectedkey_354.png?<%=releaseDate%>" style="position:absolute; top:0; left:0;display:none" class="selectedkey selectedkey_354">
            </div>
            <div class="qrArea" style="display:none;" tabindex="-1">
                <a class="qrcodeLink" target="_blank"><div class="qrcode">
                    <div class="loading" style="width:65px;height:65px;background-image: url('images/default_qrcode.png');"></div>
                    <img class="loading" src="images/keyboard_loading_progress.gif" style="left:18px;top:18px;">
                </div></a>
                <div class="qrcodeDetail">QR로 모바일에서<br/>암호 입력가능</div>
            </div>
        </div>
    </div>

    <!-- 미디어 리스트 -->
    <div id="certStorePopup" style="display:none">
        <div id="certStorePopupBody" style="overflow:hidden">
           <ul></ul>
        </div>
    </div>

    <!-- 확장 매체 -->
    <div id="extensionCertStoreDialog" style="display:none">
        <div id="extensionCertStoreDialogBody" aria-label="확장매체 선택창" alt="확장매체 선택창"
            data-tab-order="secureTokenButton, phoneButton, smartAuthButton, closeImg">
            <div style="text-align:right">
                <img class="closeImg" aria-label="닫기" alt="닫기" src="images/close.png?<%=releaseDate%>">
            </div>
            <div class="storageBlock">
                <div class="storageButtonBlock">
                    <button class="secureTokenButton">보안토큰</button>
                    <button class="phoneButton">휴대폰</button>
                    <button class="smartAuthButton">스마트인증</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 복사 대상 다이얼로그 -->
    <div id="copyTargetDialog" style="display:none">
        <div id="copyTargetDialogBody" aria-label="저장 매체 선택창" alt="저장 매체 선택창"
            data-tab-order="browserButton, cloudButton, localDiskButton, secureTokenButton, phoneButton, smartAuthButton, closeImg">
            <div class="title">
                <span class="selectCertStoreMsg strongLabel">인증서 저장 위치를 선택해주세요</span>
                <img class="closeImg" aria-label="닫기" alt="닫기" src="images/close.png?<%=releaseDate%>">
            </div>
            <div class="storageBlock">
                <div class="storageButtonBlock">
                    <button class="browserButton">브라우저</button>
                    <button class="cloudButton">클라우드</button>
                    <button class="localDiskButton">로컬디스크</button>
                    <button class="secureTokenButton">보안토큰</button>
                    <button class="phoneButton">휴대폰</button>
                    <button class="smartAuthButton">스마트인증</button>
                </div>
                <div align="right" class="need_g3_message" style="display:none"></div>
            </div>
        </div>
    </div>

    <!-- 인증번호 출력 다이얼로그 -->
    <div id="authCodeDialog" style="display:none">
        <div id="authCodeDialogBody" data-tab-order="firstPart, secondPart, thirdPart, ok, cancel">
           <div class="titleBarBlock">
                   <div class="dialogTitle">인증서 가져오기</div>
                   <div class="selectCertStoreMsgTitleLine"></div>
            </div>

            <div class="authCodeContent">
                <div class="upBlock authCodeBlock">
                    <div class="labels"><span class="authCodeMsg">인증번호</span></div>
                    <div class="inputs">
                        <input type="text" class="firstPart" maxlength="4" onkeypress="authCodeValidator(event);">
                        <input type="text" class="secondPart" maxlength="4" onkeypress="authCodeValidator(event);">
                        <input type="text" class="thirdPart" maxlength="4" onkeypress="authCodeValidator(event);">
                    </div>
                </div>

                <div class="downBlock">
                    <div class="title">
                        <span class="strongLabel" > 다른 기기 브라우저에 저장되어 있는 인증서를 가져옵니다. </span>
                    </div>
                    <div class="image">
                        <img src="images/cert_import_roaming_x1.png">
                    </div>
                    <div class="notification">
                        <img src="images/check_x1.png" aria-label="체크 이미지" alt="체크 이미지">
                        <span> 다른 기기 브라우저에 표시된 인증번호를 확인후 입력해주세요. </span>
                    </div>

                </div>

            </div>

            <div class="footer">
                <div class="okButtonBlock">
                    <button class="ok okButton okButtonMsg">확인</button>
                    <button class="cancel cancelButton cancelButtonMsg">취소</button>
                </div>
            </div>

            <div id="numKeyboard" style="display: none" role="alertDialog" aria-label="인증번호 입력키패드" alt="인증번호 입력키패드">
                <div class="numKeyboardBox">
                    <div class="numKeyboardClose" onclick="desktop.numKeyboard.close()" role="button" tabindex="-1"></div>
                    <table >
                        <tr>
                            <td><div class="button" onclick="desktop.numKeyboard.click('1')" role="button" tabindex="-1">1</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('2')" role="button" tabindex="-1">2</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('3')" role="button" tabindex="-1">3</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('4')" role="button" tabindex="-1">4</div></td>
                        </tr>
                        <tr>
                            <td><div class="button" onclick="desktop.numKeyboard.click('5')" role="button" tabindex="-1">5</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('6')" role="button" tabindex="-1">6</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('7')" role="button" tabindex="-1">7</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('8')" role="button" tabindex="-1">8</div></td>
                        </tr>
                        <tr>
                            <td><div class="button" onclick="desktop.numKeyboard.click('9')" role="button" tabindex="-1">9</div></td>
                            <td><div class="button" onclick="desktop.numKeyboard.click('0')" role="button" tabindex="-1">0</div></td>
                            <td colspan="2"><div class="button back-button" onclick="desktop.numKeyboard.click(8)" role="button" tabindex="-1">&nbsp;</div></td>
                        </tr>
                    </table>
                </div>
                <hr/>
            </div>

        </div>
    </div>

    <!-- 인증서 열기 다이얼로그 -->
    <div id="certificateOpenDialog" style="display:none">
        <div id="certificateOpenDialogBody" data-tab-order="certOpen, downCertConverter, close">
            <div> <img class="close" src="images/close.png?<%=releaseDate%>" aria-label="닫기 버튼 이미지" alt="닫기 버튼 이미지"> </div>
            <button class="certOpen"> 인증서(*.pfx, *.p12) 열기</button>
            <div>
                <span class="message">인증서(*.pfx,*.p12)가 없으면 인증서 변환<br/> 프로그램을 이용해 주세요.</span><br/>
                <div class="dragArea">
                    <div class=dragImage></div><div class=dragDetail>인증서 파일(*.pfx, *.p12 또는 signCert.der/signPri.key 묶음)을 끌어다 놓으면 인증서 복사 및 서명이 가능합니다.</div>
                </div>
                <div class="gray_line"></div>
                <img class="img" src="images/download.png?<%=releaseDate%>" aria-label="다운로드 이미지" alt="다운로드 이미지">
                    <a id="certConverter" href="#" target="_certConvert" class="downCertConverter">인증서 변환 프로그램 다운로드</a>
            </div>
        </div>
    </div>
	
	<!-- G10 providers menu section -->
	<div id="certificateProviderList" class="g10_nav_shadow" style="display:none">
		<div class="g10_folding"></div>
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
							<input type="text" class="vpcg_login_data vpcg_user_birthday" name="birthday" maxlength="14" placeholder="생년월일 입력 (1985 / 01 / 30)"></input>
							<label></label>
						</div>
						<div class="vpcg_inputfield phone">
							<input type="text" class="vpcg_login_data vpcg_user_phone" name="phone" maxlength="17" placeholder="휴대폰 번호 입력"></input>
							<label></label>
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
				<div class="vpcg_section_wait vpcg_info_screen_normal">
					<div class="vpcg_img_loading">
						<img class="loading_gif" src="images/g10/icon/img_send_blue.gif"/>
					</div>
					<div class="vpcg_info_top_text">인증요청이 휴대폰으로 전송되었습니다.</div>
					<div class="vpcg_info_bottom_text">선택한 인증수단의 <span class="fs-13 color-06 fw-b">모바일앱 알람</span>을 확인해주세요.</div>
				</div>
				<div class="vpcg_section_wait_btn vpcg_info_screen_normal with_button">
					<div class="vpcg_img_loading">
						<img class="loading_gif" src="images/g10/icon/img_send_blue.gif"/>
					</div>
					<div class="vpcg_info_top_text">인증요청이 휴대폰으로 전송되었습니다.</div>
					<div class="vpcg_info_bottom_text">선택한 인증수단의 <span class="fs-13 color-06 fw-b">모바일앱에서 인증을 완료</span>한 후,<br/>아래의 <span class="fs-13 color-06 fw-b"><u>확인버튼</u></span>을 눌러주세요.</div>
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
			<div class="vpcg_img_loading">
				<img src="images/g10/icon/loading_blue.gif"/>
				<span>로딩중입니다.</span>
			</div>
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
