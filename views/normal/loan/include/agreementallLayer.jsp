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
				
				<!-- s:(필수)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(서민금융진흥원) -->
				<div class="con T000800007" id="all-agree-check3">
					<div class="tit color-612885 font40 mb30">(필수) 개인(신용)정보 수집 ·이용 ·제공 동의서<br>(서민금융진흥원用)</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(필수)개인(신용)정보 수집ㆍ이용ㆍ제공 동의서(서민금융진흥원) -->
				
				<!-- s:(필수)개인(신용)정보 및 기업(신용)정보 조회․수집․이용․제공과 행정정보공동이용, 전자금융거래확인서 발급을 위한 동의서 -->
				<div class="con T000800008" id="all-agree-check4">
					<div class="tit color-612885 font40 mb30">(필수) 개인(신용)정보 및 기업(신용)정보 조회 ·수집 ·이용·제공과 행정정보공동이용, 전자금융거래확인서 발급을 위한 동의서</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(필수)개인(신용)정보 및 기업(신용)정보 조회․수집․이용․제공과 행정정보공동이용, 전자금융거래확인서 발급을 위한 동의서  -->
				
				<!-- s:(필수)계약 체결·이행 등을 위한 필수 동의서 (개인금융성 신용보험용) -->
				<div class="con T000800009" id="all-agree-check8">
					<div class="tit color-612885 font40 mb30">(필수) 계약 체결·이행을 위한 상세 동의서<br>(개인금융성 신용보험용)</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(필수)계약 체결·이행 등을 위한 필수 동의서 (개인금융성 신용보험용)  -->
				
				<!-- s:상품설명서 레이어팝업 -->
	            <div class="con T000800004" id="all-productdetail">
	                <div class="tit color-612885 font40 mb30">가계대출 상품설명서</div>
					<p class="desc mb30">본인은 예가람저축은행과 대출거래에 있어 저축은행 직원과 상담하여 아래에서 설명한 내용을 포함하여 대출거래의 주요내용 및 고객부담 비용에 대하여 충분히 설명을 듣고 이해하였음을 확인합니다.</p>
					<hr class="mb30"> 
	               	<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
            	</div>
            	
				<!-- s:(필수)CMS 출금이체 동의 -->
				<div class="con T000800010" id="all-agree-check11">
					<div class="tit color-612885 font40 mb30">(필수) CMS 출금이체 동의</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(필수)CMS 출금이체 동의 -->
				
				<!-- s:(필수)CMS 출금이체 동의 -->
				<div class="con T000800018" id="all-agree-check18">
					<div class="tit color-612885 font40 mb30">(필수) 개인(신용)정보 제3자 제공 동의서 <br>[신용대출, 담보대출, 정책자금대출]</div>
					<hr class="mb30">
					<div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
				</div>
				<!-- //e:(필수)CMS 출금이체 동의 -->
				
				
				
        		<!-- //e:상품설명서 레이어팝업 -->
				<!-- s:사잇돌 상품설명서 레이어팝업 -->
				<!-- <div class="con T000800012" id="all-saitdoldetail">
	                <div class="tit color-612885 font40 mb30">사잇돌 상품설명서</div>
	                <hr class="mb30">
	                <div class="agreement">
						<div class="pop-cts">
						</div>
					</div>
            	</div> -->
				<!-- //e:사잇돌 상품설명서 레이어팝업 -->
				
	        	<!-- s:햇살론상품설명서 레이어팝업 -->
	            <!-- <div class="con T000800015" id="all-agree-check13">
	                <div class="tit color-612885 font40 mb30">(필수)개인(신용)정보 제3자 제공동의서(추가동의사항)</div>
	                <hr class="mb30">
	                <div class="agreement">
						<div class="pop-cts">
						</div>
					</div>           
	            </div> -->
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