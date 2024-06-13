<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="KcbOffPhoneAjax" value="/${dsrId }/loan/ajaxKcbOffPhone"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<link href="<c:url value="/resources/normal/css/layout.css"/>" rel="stylesheet" />
<link href="<c:url value="/resources/normal/css/jquery-ui.css"/>" rel="stylesheet" /><!-- 180424 추가 -->
<script src="<c:url value="/resources/normal/js/jquery-1.11.3.min.js"/>" type="text/javascript"></script>
<script src="<c:url value="/resources/normal/js/jquery-ui.js"/>" type="text/javascript"></script><!-- 180424 추가 -->
<script src="<c:url value="/resources/normal/js/default.js"/>" type="text/javascript"></script>
<script src="<c:url value="/resources/normal/js/ui.js?v=20190624"/>" type="text/javascript"></script>
</head>
<body>
<form name="form1">
	<!-- 인증 요청 정보 -->
	<!--// 필수 항목 -->
	<input type="hidden" name="tc" value="kcb.oknm.online.safehscert.popup.cmd.P931_CertChoiceCmd"/>	<!-- 변경불가-->
	<input type="hidden" name="cp_cd" value="${CP_CD}">	<!-- 회원사코드 -->
	<input type="hidden" name="mdl_tkn">	<!-- 토큰 --> 
	<input type="hidden" name="target_id" value="">	
	<!-- 필수 항목 //-->	
</form>
<script>
	var step= "${step}";
	// 해당 페이지에서 처리할 이벤트
	//	$(function(){
		
	//		if(step == "2"){
	//			try{
	//				var resultData = JSON.parse('${result}');
	//				var resultCode = resultData.resultCode;
	//				if(resultCode === 0){
	//						opener.AuthUtil.successAuthCallBack(resultData);
	//						window.close();
	//				}else{
	//					customAlert({title : '알림', message : resultData.resultMessage},function(){
	//						opener.AuthUtil.failAuthCallBack(resultData);
	//						window.close();
	//					});
	//				}
	//			}catch(e) {
	//				customAlert({title : '알림', message : "인증에 실패했습니다."},function(){
	//					window.close();
	//				});
	//			}
	//		}
	//	});
	
	var OkCert3info = {
		serverURL :  '${KcbOffPhoneAjax}',
		KCBgatewayURL : '${KCBgatewayURL}',
		CP_CD : '${CP_CD}',
		target : '${target}',
		svcnm : '${svcnm}',
		service : '${service}',
		param : '${pubParam}'
	}
	
	function OkCert3_setResult(result) {	// AJAX 통신이 성공 처리된 경우 호출되는 함수
		console.log("responseJson  >>> " + result);
		
		var responseJson = JSON.parse(result);
		
		if (responseJson.RSLT_CD == "B000") { 	// 거래 성공인 경우
			document.getElementsByName("mdl_tkn")[0].value = responseJson.MDL_TKN;
			
			document.form1.action = '${popupUrl}';
			document.form1.method = "post";
	
			document.form1.submit();
		} else {								// 거래 실패인 경우
			customAlert({title : '알림', message : "인증에 실패했습니다."},function(){
				window.close();
			});
		}
	}
	
	function authResult(result) {	// AJAX 통신이 성공 처리된 경우 호출되는 함수
		try{
			var resultData = JSON.parse(result);
			var resultCode = resultData.resultCode;
			if(typeof(resultCode)=='undefined'){
				customAlert({title : '알림', message : "인증에 실패했습니다."},function(){
						window.close();
				});
			}else{
				if(resultCode === 0){
					opener.auth_result(JSON.parse(JSON.stringify(resultData.data)));
					window.close();
				}else{
					customAlert({title : '알림', message : "인증에 실패했습니다."},function(){
	//						opener.auth_result(JSON.parse(resultData.data));
						window.close();
					});
				}
			}
			
		}catch(e) {
			customAlert({title : '알림', message : "인증에 실패했습니다."},function(){
				window.close();
			});
		}
	}
	
	
	function OkCert3_errorCallback(error, sequence) {	// AJAX 통신이 실패 처리된 경우 호출되는 함수 -> 회원사 처리 필요
		customAlert({title : '알림', message : "인증에 실패했습니다."},function(){
			window.close();
		});
	}
	
	function OkCert3_start() {
		if( location.protocol != "https:" && window.XDomainRequest	
		&& navigator.appVersion.indexOf("MSIE 10") == -1) {	// 회원사 페이지 프로토콜이 HTTPS 가 아닌 경우, IE 9 이하는 미지원 
			//return;
		}
		if ( ${hasServerPubKey} ) var sequence = 2; // KCB Gateway 서버의 RSA 공개키 보유 중인 경우, 2 부터 시작
		else 									var sequence = 1;
		OkCert3_sendServer(sequence, "", "");	//-> 재귀 반복 호출 후 최종적으로 OkCert3_setResult 실행됨. 오류시 OkCert3_errorCallback 실행됨.
	}
	
	
	try {			// Modern Browser
		document.addEventListener("DOMContentLoaded", function() {	// DOM 로드 완료(= $(window).load 등) 이벤트 리스너
			OkCert3_start(); // 페이지 로드 완료되면 진행
		});
	} catch(e) {	// IE8 이하 버전 지원용
		document.attachEvent("onreadystatechange", function() {		// DOM 로드 완료(= $(window).load 등) 이벤트 리스너
			if(document.readyState === "complete"){				
				document.detachEvent("onreadystatechange", arguments.callee); // 이벤트 리스너 제거
				OkCert3_start(); // 페이지 로드 완료되면 진행
			}
		});
	}
	
	// KCB Gateway 서버와의 통신 함수
	function OkCert3_sendKCBGateway(sequence, response) {
		var responseArr = response.split("$!");
		console.log("OkCert3_sendKCBGateway   >>  " + sequence + "  >>   " + response);
		var responseObj = {
			kcbrqstmsg : responseArr[0],
			encinfo : responseArr[1]
		};
		if( window.XDomainRequest && navigator.appVersion.indexOf("MSIE 10") == -1) { // IE 8, 9 처리
			var xdr = new XDomainRequest();
			xdr.onload = function() {
				OkCert3_sendServer(sequence+1, this.responseText, responseObj.encinfo);	// 정상 : 다음 단계 진행
			}
			xdr.onerror = function () {
				OkCert3_errorCallback("OkCert3_sendKCBGateway - xdr Error. responseText: " + xdr.responseText, sequence);
				return;
			}
			try {
				xdr.open("post", OkCert3info.KCBgatewayURL);	// async
			} catch (err) {
				OkCert3_errorCallback("OkCert3_sendKCBGateway - xdr Open Fail. Error description: " + err.description, sequence);
				return;
			}
			try {
				xdr.send(responseObj.kcbrqstmsg);
			} catch (err) {
				OkCert3_errorCallback("OkCert3_sendKCBGateway - xdr Send Fail. Error description: " + err.description, sequence);
				return;
			}
		}
		else {
			if (window.XMLHttpRequest)	var xhttp = new XMLHttpRequest();
			else 						var xhttp = new ActiveXObject("Microsoft.XMLHTTP");	// IE5,6 처리
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4) {
					if(this.status == 200) OkCert3_sendServer(sequence+1, this.responseText, responseObj.encinfo);	// 정상 : 다음 단계 진행
					else {
						OkCert3_errorCallback("OkCert3_sendKCBGateway - xhttp Request Fail. status: "	// 오류 (400에러, 404에러 등)
												+ this.status + " , statusText: " + this.statusText, sequence);
						return;
					}
				}
			};
			try {
				xhttp.open("post", OkCert3info.KCBgatewayURL);	// async
			} catch (err) {
				OkCert3_errorCallback("OkCert3_sendKCBGateway - xhttp Open Fail. Error description: " + err.description, sequence);
				return;
			}
			try {
				xhttp.send(responseObj.kcbrqstmsg);
			} catch (err) {
				OkCert3_errorCallback("OkCert3_sendKCBGateway - xhttp Send Fail. Error description: " + err.description, sequence);
				return;
			}
		}
	}
	// Ajax 처리해주는 회원사 서버 페이지와의 통신 함수
	function OkCert3_sendServer(sequence, kcbresponse, encinfo) {
		console.log(sequence +" >> "+kcbresponse +" ,,, " + encinfo);
		kcbresponse = kcbresponse.replace(/-/gi,"$1").replace(/_/gi,"$2"); // 회원사 서버 필터링 회피용
	
		if (window.XMLHttpRequest)	var xhttp = new XMLHttpRequest();
		else 						var xhttp = new ActiveXObject("Microsoft.XMLHTTP");		// IE5,6 처리
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4) {
				if (this.status == 200) {
					console.log(" >>> " + step + " , sequence   >>> " + sequence + " , this.responseText >>>" + this.responseText );
					if(step=="2" && sequence == 4) {
						authResult(this.responseText);				// sequence=4 최종단계의 경우 완료처리
					} else if (step=="1" && sequence == 4) {
						var temp = JSON.parse(this.responseText).data;
						OkCert3_setResult(temp);				// sequence=4 최종단계의 경우 완료처리
					} else { 			
						var temp = JSON.parse(this.responseText).data;
						OkCert3_sendKCBGateway(sequence, temp );	// 정상 : KCB에 요청
					}
				}
				else {
					OkCert3_errorCallback("OkCert3_sendServer - xhttp Request Fail. status: "	// 오류 (400에러, 404에러 등)
											+ this.status + " , statusText: " + this.statusText, sequence);
					return;
				}
			} 
		};
		try {
			xhttp.open("post", OkCert3info.serverURL);			// async
		} catch (err) {
			OkCert3_errorCallback("OkCert3_sendServer - xhttp Open Fail. Error description: " + err.description, sequence);
			return;
		}
		xhttp.setRequestHeader( 'Content-Type', 'application/x-www-form-urlencoded' );
		try {
			xhttp.send("sequence="+sequence+"&kcbresponse="+kcbresponse+"&encinfo="+encinfo
						+"&svcnm="+OkCert3info.svcnm+"&service="+OkCert3info.service+"&target="+OkCert3info.target
						+"&CP_CD="+OkCert3info.CP_CD+"&param="+OkCert3info.param+"&step="+step);
		} catch (err) {
			OkCert3_errorCallback("OkCert3_sendServer - xhttp Send Fail. Error description: " + err.description, sequence);
			return;
		}
	}

</script>
</body>
</html>
