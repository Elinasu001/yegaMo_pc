<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!-- 20210726 레이어팝업 제목 수정 및 약관추가 -->
		<!-- s:전체 레이어팝업 -->
		<div id="agreementallLayer" class="layerpopup agreementall-layer" tabindex="0" data-tooltip-con="agreementall-layer" data-focus="agreementall-layer" data-focus-prev="btn-menu-close">
			<div class="pop-wrap">
				<div class="all-agree font26 mt20 mb20">* 필수 약관 전체 보기 ( <span class="view"></span> / <span class="total"></span> )</div>
				
				<!-- s:(필수)개인(신용)정보조회 동의서 레이어팝업 -->
				<div class="con T000800001" id="all-agree-check1">
					<div class="tit color-612885 font40 mb30">(필수) 개인(신용)정보 수집·이용·제공·조회 동의서</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(필수)개인(신용)정보조회 동의서 레이어팝업 -->
				
				<!-- s:(필수)개인(신용)정보 수집·이용·제공 동의서(여신금융거래) -->
				<div class="con T000800002" id="all-agree-check6">
					<div class="tit color-612885 font40 mb30">(필수) 개인(신용)정보 수집·이용·제공 동의서<br>(여신금융거래)</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(필수)개인(신용)정보 수집·이용·제공 동의서(여신금융거래)  -->
	        	
				<!-- s:(필수)개인(신용)정보 조회동의서(서민금융진흥원) -->
				<div class="con T000800006" id="all-agree-check2">
					<div class="tit color-612885 font40 mb30">(필수) 개인(신용)정보 조회동의서<br>(서민금융진흥원用)</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(필수)개인(신용)정보 조회동의서(서민금융진흥원) -->
				
				<!-- s:상품설명서 레이어팝업 -->
	            <div class="con T000800005" id="all-productdetail">
	                <div class="tit color-612885 font40 mb30">기업대출 상품설명서</div>
					<p class="desc mb30">본인은 예가람저축은행과 대출거래에 있어 저축은행 직원과 상담하여 아래에서 설명한 내용을 포함하여 대출거래의 주요내용 및 고객부담 비용에 대하여 충분히 설명을 듣고 이해하였음을 확인합니다.</p>
					<hr class="mb30"> 
	               	<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
            	</div>
            	
				
	        	<!-- s:햇살론상품설명서 레이어팝업 -->
	            <div class="con T000800015" id="all-agree-check13">
	                <div class="tit color-612885 font40 mb30">(필수)개인(신용)정보 제3자 제공동의서<br>(동산 담보대출, 부동산 담보대출)</div>
	                <hr class="mb30">
	                <div class="agreement">
						<div class="pop-cts">
						</div>
					</div>           
	            </div>
	        	<!-- //e:햇살론상품설명서 레이어팝업 -->
	        	
				<p class="ta-c mt20"><button type="button" name="button" class="btn-normal tooltip-close">닫기</button></p>
				<button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="agreementall-layer">닫기</button>
				<div class="ctrl-box">
					<button type="button" name="button" class="btn-prev">이전</button>
					<button type="button" name="button" class="btn-next">다음</button>
				</div>
			</div>
		</div>
		<!-- //e:전체 레이어팝업 -->
		<div id="agreementChallLayer" class="layerpopup agreementall-layer" tabindex="0" data-tooltip-con="agreementChall-layer" data-focus="agreementChall-layer" data-focus-prev="btn-menu-close">
			<div class="pop-wrap">
				<div class="all-agree font26 mt20 mb20">* 선택 약관 전체 보기 ( <span class="view1"></span> / <span class="total1"></span> )</div>
				
				<!-- s:(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(상품서비스 안내) -->
				<div class="con T000800003" id="all-agree-check5">
					<div class="tit color-612885 font40 mb30">(선택) 개인(신용)정보 수집·이용·제공 동의서<br>(상품서비스 안내)</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(선택)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(상품서비스 안내)  -->
				
				<!-- s:(선택) 대출거절사유 고지에 관한 사항 -->
				<div class="con T000800016" id="all-agree-check16">
					<div class="tit color-612885 font40 mb30">(선택) 개인정보 수집이용제공 동의서 (보증료우대서비스)</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(선택) 대출거절사유 고지에 관한 사항 -->
				
				<!-- s:(선택) 개인(신용)정보 선택적 동의서(통신정보 활용 동의) -->
				<div class="con T000800017" id="all-agree-check17">
					<div class="tit color-612885 font40 mb30">(선택) 개인정보 수집이용제공 동의서 (상품서비스 안내)</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(선택) 개인(신용)정보 선택적 동의서(통신정보 활용 동의) -->
				
				<p class="ta-c mt20"><button type="button" name="button" class="btn-normal tooltip-close">닫기</button></p>
				<button type="button" name="button" class="btn-menu-close tooltip-close" data-focus="btn-menu-close" data-focus-next="agreementChall-layer">닫기</button>
				<div class="ctrl-box">
					<button type="button" name="button" class="btn-prev">이전</button>
					<button type="button" name="button" class="btn-next">다음</button>
				</div>
			</div>
		</div>