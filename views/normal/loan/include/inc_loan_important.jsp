<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
.class_line_box{margin-top:20px;padding-top:20px;border-top: 1px solid #ccc;}
.class_terms_box .radio-area{margin-top:5px;}
.cust_terms_accent {color:#ec008c; font-weight:bold;}
.class_line_box .sub_1{padding-left:20px;margin-top:8px;}
.apv-check {display: none; }


.parentDiv {border-bottom: 0.5px solid #ec008c; height: 30px;margin-bottom: 5px;display: flex; flex-direction: column;}
.DivInSpanTag {float: right;margin-right: 20px;}
/* .subDiv {margin: 30px 0 30px 0;width: 90%;padding-left: 10px;} */
.subDiv {display: flex; flex-direction: column; flex-wrap: wrap; align-content: center;margin-top: 2rem;}
.subDiv p { width:70%; }
.subDiv table { width:70% !important; }

.paddingPTag {padding: 0 5px;}
/* .infobtn{margin-left: 40%;margin-top: 25px;margin-bottom: 10px;} */
.infobtn { background-color: #EC008C; line-height: 35px;border-radius: 50px; color: #fff; width:20%;}
.img1 { width:fit-content;}
.class_cust_terms2{font-family: "흥국씨앗L"}

.emphasized {position: fixed;
			box-shadow: rgba(0,0,0,0.5)0 0 0 9999px,rgba(0,0,0,0.5) 2px 2px 3px 3px;
			z-index: 100;
			}
.fwb {font-weight: bold;}

.tblTrHeght>tbody>tr {height: 55px;}




</style>
<script type="text/javascript">
var mainDivOpenFlag = false;
var checkArray = [false, false, false, false, false, false, false, false];
var isImportant = false;
var showIndex = 1;

$(function(){
	$('.class_cust_terms2').hide();
	$(".subDiv").hide();
	
// 	$('input[name="mrgg_tp_cd"]').on('change', () => {
	$('input[name="mrgg_tp_cd"]').on('change', function () {		//IE 때문에 람다 변경....
		var value = $('input[name="mrgg_tp_cd"]:checked').val();
// 		if( value == "H003200001"){
// 			$('.estate').removeClass('subDiv');
// 			$('.estate').hide();
// 			$('.apart').show();
// 			$('.apart').addClass('subDiv');
// 		}else{
// 			$('.apart').removeClass('subDiv');
// 			$('.apart').hide();
// 			$('.estate').show();
// 			$('.estate').addClass('subDiv');
// 		}
	})
});

function fn_DivMainOpen(){
	var show = $('.class_cust_terms2').is(':visible');
	if(!show){
		$(".class_cust_terms2").show();
		if(showIndex == 1){
			$('#divList'+showIndex).show();
			$('#divList'+showIndex).focus();
		}
	}else{
		$(".class_cust_terms2").hide();
	}
}

function importantCheck(index){
// 	$.each($('.subDiv'), (_index) => {		//IE 때문에 람다 변경....
	$.each($('.subDiv'), function(_index) {
				
		$('.subDiv').eq(_index).hide();
	});
	$('.subDiv').eq(index+1).show();
	$('.check1').eq(index).show();
	$('.check1').eq(index).focus();
	checkArray[index] = true;
	showIndex = (index+1);
	if(index == "7"){
		$('#importantdetail').prop('checked', true);
		$('#importantdetail').parent().addClass('c-on');
	}
}

function impotantValidation() {
	var cnt = 0; 
	for(var i = 0; i < checkArray.length; i++){
		if(!checkArray[i]){
			cnt ++;
		}
	}
	if(cnt <= 0){
		isImportant = true;
		return true;
	}
	
	if(!isImportant){
		return false;
	}
	return false;
}

function fn_toGgle(idVal){
	var cnt = 0; 
	for(var i = 0; i < checkArray.length; i++){
		if(!checkArray[i]){
			cnt ++;
		}
	}
	
	if(cnt <= 0){
		var $this = $("#divList"+idVal);
		
		$(".subDiv").hide();
		
		var clickId = $this.attr("id");
		$(".subDiv").each(function( index, element ){
			var selectedElment = $(element)
			var selectedId = selectedElment.attr("id");
			
			if(clickId == selectedId){
				$("#"+clickId+"").css("display","flex");
			}
			
		});
	}
	
}

</script>

<div class="class_cust_terms2" style="padding-bottom:20px;">

	<!-- 신용 -->
<!--  	<div class="parentDivMain" style="display: none;">
		<div class="area_cust">
			<p style="padding: 10px 10px 10px 10px;"><span class="fwb">「금융소비자 보호에 관한 법률」 제 19조 제1항에서 규정하고 있는 중요한 사항</span> 입니다. 모든 내용을 확인하시면 다음 단계로 넘어갈 수 있습니다.</p>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(1);">
					<p>중요사항 확인 - 금리 및 변동여부                                                                                        <span class="DivInSpanTag"> 1/8</span></p>
				</div>
				<div id="divList1" class="subDiv">
					<p class="paddingPTag fwb">대출금리의 종류</p><br>
					<img src="/resources/normal/images/common/img_fixed_rate.png" alt="" >
					<p class="paddingPTag">고정금리란? <br>
						대출 실행시 결정된 금리가 대출만기까지 동일하게 유지
					</p><br><br>
					<img src="/resources/normal/images/common/img_variable_rate.png" alt="" class="img1>
					<p class="paddingPTag">변동금리란? <br>
						일정주기 (3/6/12개월등) 마다 대출 기준금리의 변동에 따라 대출금리가 변동 (생계자금에 한하여)
					</p><br>
					<p class="paddingPTag fwb">유의사항</p>
					<p class="paddingPTag fwb">대출금리는 아래의 경우 <span style="color: red;"> 변동될 수 있습니다.</span></p>
					<br>
					<p class="paddingPTag">1. 약정한 항목 관련</p>
					<p class="paddingPTag" style="font-size: 13px;">- 대출기준금리의 변동,거래실적 변동 등</p><br>
					<p class="paddingPTag">2. 대출조건의 변경관련</p>
					<p class="paddingPTag" style="font-size: 13px;">- 신용등급 변동,기간연장,채무자 변경 등</p>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(2);">
					<p>중요사항 확인 - 중도상환해약금                                                                                        <span class="DivInSpanTag"> 2/8</span></p>
				</div>
				<div id="divList2" class="subDiv">
					<p class="paddingPTag fwb">중도상환해약금의 정의</p>
					<p class="paddingPTag">대출의 상환 기익이 오기 전에 대출금을 상환할  경우 고객님이 부담하는 금액입니다.</p>
					<br>
					<p class="paddingPTag fwb">1.산식</p>
					<p class="paddingPTag">중도상환해약금 = 중도상환대출금 X 해약금률 X (대출잔여일수÷대출기간)</p><br><br>
					<p class="paddingPTag">ㆍ 중도상환해약금은 상품에 따라 <span style="color: red">최대1.9%</span> 입니다.</p><br>
					<p class="paddingPTag">ㆍ 최초 대출실행일로부터 <span style="color: red">2년간 </span> 적용됩니다.</p><br>
					<p class="paddingPTag">ㆍ 대출금액이 클수록,대출잔여일수가 많이 남아있을수록 중도상환해약금 부담이 커집니다.</p><br>
					<p class="paddingPTag">ㆍ 햇살론은 서민금융진흥원의 보증부대출로 중도상환수수료가 없습니다.</p><br>
					<p class="paddingPTag">ㆍ 사잇돌대출은 서울보증보험의 보증서발행으로 이루어지는 보증부 대출상품으로 중도상환수수료가 없습니다.</p>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(3);" style="height: 45px;">
					<p>중요사항 확인 - 상환금액ㆍ이자율ㆍ 시기                                                                                     <br>   <span class="DivInSpanTag"> 3/8</span></p>
				</div>
				<div id="divList3" class="subDiv">
					<p class="paddingPTag fwb">상환 방법별 특징</p><br>
					
					<p class="paddingPTag fwb">1. 원리금 균등상환</p>

					<p class="paddingPTag">원금과 이자의 합을 매월 동일한 금액으로 상환합니다.매월 상환금액이 동일합니다.</p><br>
					<img src="/resources/normal/images/common/img_graph_equal.png" alt="">
					<br>
					<br>
					<p class="paddingPTag fwb">2. 원금 균등상환</p>
					<p class="paddingPTag fwb">대출 원금을 대출 상환기간 동안 지속적으로 일정금액으로 상환하는 방식입니다.</p><br>
					<img src="/resources/normal/images/common/img_graph_equal2.png" alt=""><br><br>
					<p class="paddingPTag fwb">3. 만기일시 상환</p>
					<p class="paddingPTag">약정기간동안 대출 원금에 대한 상환 없이 <span class="fwb" style="text-decoration: underline;">이자만 부담</span>하는 방식입니다. 만기일자에 대출 원금을 모두 상환해야 하므로 상환 부담이 증가할 수 있습니다.</p><br>
					<img src="/resources/normal/images/common/img_graph_equal3.png" alt=""><br><br>
					
					<p class="paddingPTag fwb">상환금액ㆍ이자율ㆍ시기</p>
					<p class="paddingPTag fwb">동일한 금리ㆍ한도로 대출을 진행하더라도 <span style="color: red;">상환방법에 따라 만기까지 부담해야하는 총 원리금 부담액이 달라질 수 있습니다.</span></p><br>
					
					
					<p class="paddingPTag fwb">유의사항</p><br>
					<p class="paddingPTag fwb">1. 거치식 분할상환 방식의 상환부담</p>
					<p class="paddingPTag">거치기간이 종료되면 <span style="color: blue;">거치기간 연장이 어려울 수 있으며,</span> 분할상환이 개시되어 이자와 함께 원금도 갚아나가야 하므로 상환부담이 증가 할 수 있습니다.</p><br>
					<p class="paddingPTag fwb">2. 만기 일시상환 방식의 상환부담</p>
					<p class="paddingPTag">대출만기가 되면  <span style="color: blue;">원금을 한꺼번에 상환</span> 상환해야 하며, <span style="color: red;">만기연장이 되지 않을 수</span> 있습니다.</p>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(4);">
					<p>중요사항 확인 - 담보물에 관한 사항                                                                                   <span class="DivInSpanTag"> 4/8</span></p>
				</div>
				<div id="divList4" class="subDiv">
					<p class="paddingPTag fwb">담보권 제공 대출 실행에 따른 <br>재산상 손실</p><br>
					<p class="paddingPTag">대출 변제가 도래 또는 기한이익 상실에도 불구하고 대출이 상환되지 않는 경우,저축은행은 법적절차*에 따라 담보물을 처분하여 대출을 상환할 수 있으며, 이경우 담보 제공자는 담보물의 소유권을 잃을 수 있습니다.</p><br>
					<p class="paddingPTag">*법적절차 : 민사집행법에 따라 담보물을 경매(매각 및 급전으로 환가)한 후 그 경매대금에 대하여 다른 채권자에 우선하여 변제</p>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(5);" style="height: 45px;">
					<p>중요사항 확인 - 금융소비자의 부담금액                                                                                   <span class="DivInSpanTag"> 5/8</span></p>
				</div>
				<div id="divList5" class="subDiv">
					<p class="paddingPTag fwb">원금 및 이자</p>
							<p class="paddingPTag">대출 유지기간 동안에는 아래에 정한 시점에 고객님의 원리금 상환부담이 있습니다.</p><br>
							<table id="" style="width: 120%;text-align: center;">
								<colgroup>
									<col style="width:30%;">
									<col style="width:*;">
								</colgroup>
								<thead>
									<tr style="background-color: #f8f8f8;">
										<th>구분</th>
										<th>부담시점</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="background-color: #f8f8f8;">원금</td>
										<td>만기일 및 분할상환기일</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">이자</td>
										<td>매 이자납입일(통상 매월 납부)</td>
									</tr>
								</tbody>
							</table>
							<br>
							<p class="paddingPTag fwb">수수료 및 비용</p>
							<p class="paddingPTag fwb">1.인지세</p>
							<p class="paddingPTag">대출약정 체결 시 <span style="color: red;">인지세법에 의해 세금 납부 의무가 발생</span>합니다. 인지세는 <span style="color: red;">대출금액에 따라 차등 적용되며 저축은행과 고객이 각 50%씩 부담</span>합니다.</p><br>
							<table id="" style="width: 140%;text-align: center;" class="tblTrHeght">
								<colgroup>
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:20%">
									<col style="width:20%;">
								</colgroup>
								<thead>
									<tr style="background-color: #f8f8f8;">
										<th>대출금액</th>
										<th>5천만원 이하</th>
										<th>5천만원 초과<br>1억원 이하</th>
										<th>1억원원 초과<br>10억원 이하</th>
										<th>10억원 초과</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="background-color: #f8f8f8;">인지세액</td>
										<td>비과세</td>
										<td>7만원</td>
										<td>15만원</td>
										<td>35만원</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">고객부담</td>
										<td>-</td>
										<td>3만 5천원</td>
										<td>7만 5천원</td>
										<td>17만 5천원</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">회사부담</td>
										<td>-</td>
										<td>3만 5천원</td>
										<td>7만 5천원</td>
										<td>17만 5천원</td>
									</tr>
								</tbody>
							</table>
							<br>
							<br>
							<p class="paddingPTag fwb">2.보증료</p><br>
							<p class="paddingPTag">보증시 담보대출의 경우 <span style="color: red;">보증 기관에 납부할 소정의 보증료가 발생할 수 있으며</span>,상품별로 보증로율은 상이합니다.</p>
							<p class="paddingPTag">햇살론- 서민금융진흥원의 보증부 대출</p>
							<p class="paddingPTag">보증요율 연2%이내(사회적배려대상자의 경우 연1% 저소득청년읙 경우 연1.5%)</p>
							<p class="paddingPTag">보증료 수납:보증료는 보증 실행 시 일괄 납부 하거나 매월분할납부 중 고객 선택</p>
							<br>
							<p class="paddingPTag fwb">3.중도상환해약금</p><br>
							<p class="paddingPTag">중요사항 설명보기 『②중도상환해약금』을 참고해 주시기 바랍니다.</p><br>
							<p class="paddingPTag fwb">4.기타 유의사항</p><br>
							<p class="paddingPTag">ㆍ 상품에 따라 상기에 열거되지 않은 수수료나 비용이 추가로 발생 할 수 있습니다.</p><br>
							<p class="paddingPTag">ㆍ고객님의 채무불이행으로 발생한 비용은 『상호저축은행여신거래기본약관 제4조』에 따라 고객님이 부담하셔야 합니다.</p><br>
							<p class="paddingPTag">ㆍ대출계약을 철회하는 경우 저축은행이 부담한 인지세 등 제세공과금,저당권 설정에 따른 등기비용  등은 『금융소비자 보호에 관한 법률』 제 46조 및 관련 규정에 따라 고객님이 반환하셔야 합니다.</p>
							<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(6);">
					<p>중요사항 확인 - 발생 가능한 불이익                                                                                   <span class="DivInSpanTag"> 6/8</span></p>
				</div>
				<div id="divList6" class="subDiv">
					<p class="paddingPTag fwb">연체이자부담</p><br>
						<table id="" style="width: 60%;text-align: center;">
							<tbody>
								<tr style="height: 60px;">
									<td style="background-color: #f8f8f8;font-weight: bold;"><span style="color: red">연체이자율</span> = 대출이자율 + 연체가산이자율</td>
								</tr>
							</tbody>
						</table><br>
						<p class="paddingPTag">ㆍ최고연체이자율 : 연 20%</p>
						<p class="paddingPTag">ㆍ연체가산이자율 : 3%</p>
						<br>
						<p class="paddingPTag fwb">1. 연체이자 납부사유</p>
						<p class="paddingPTag">① 이자납부일에 이자 미납</p>
						<p class="paddingPTag"> - 이자미납 익일~1개월까지는 약정이자에 대해 연체이자 부과</p>
						<p class="paddingPTag"> - 1개월 경과 (기한이익상실)부터는 대출원금에 대해 연체이자 부과</p><br>
						<p class="paddingPTag">② 대출만기일에 원금미납</p>
						<p class="paddingPTag"> - 원금 미납 익일부터 대출원금에 대해 연체이자 부과</p><br>
						<p class="paddingPTag">③ 분할상환일에 분할상환원리금 미납</p>
						<p class="paddingPTag"> - 분할상환원리금 미납 익일부터는 해당 분할상환원리금에 대해 연체이자 부과</p>
						<p class="paddingPTag"> - <span style="color: red">2회이상 (주택담보대출의 경우3회)</span>에는 연속지체시 기한의 이익상실로 인하여  대출원금잔액에 대해     연체이자 부과</p><br>
						<p class="paddingPTag">④ 기한이익상실(상호저축은행여신거래기본약관 제 7조)</p>
						<p class="paddingPTag"> - 기한이익상실(대출금 즉시상환 및 신용불이익)익일부터 대출원금에 대해 연체이자 부과</p>
						<p class="paddingPTag"> * 기한이익상실사유 예시 : 당행 예금에 대해 압류통지 등 도달 ,제공한 담보물에 강제집행 등 개시</p>
						<br>
						<p class="paddingPTag fwb">2. 그 밖의 불이익</p>
						<p class="paddingPTag">①단기연체 (5영업일 이상 연체)</p>
						<p class="paddingPTag"> -신용정보회사에 단기연체정보 제공->금융거래제한(신용카드 정지 등)ㆍ신용평점하락->등록사유 해제에도 불구,하락한 신용평점 회복 난항</p><br>
						<p class="paddingPTag">② 장기연체(3개월 이상연체)</p>
						<p class="paddingPTag"> -『일반신용정보관리규약』에 따른 장기연체정보 등록->금융거래제한(대출신규ㆍ연기제한 등)ㆍ신용평점하락->등록사유 해제에도 불구,해제기록 최대 1년 및 하락한 신용평점 회복난항</p>
						<br>
						<p class="paddingPTag fwb">신용과 관련한 불이익</p>
						<p class="paddingPTag">ㆍ대출계약 체결 사실만으로 <span style="color: red">개인신용평점 하락 가능</span></p>
						<p class="paddingPTag">ㆍ대출계약 완제 후에도 <span style="color: red">일정기간 개인신용평점에 영향</span></p>
						<br>
						<p class="paddingPTag fwb">기타 불이익 </p>
						<p class="paddingPTag">금리,중도상환,상환방법,담보,비용,상품에 따른 특수한 불이익은 각 중요사항 설명보기 항목을 참고 바랍니다.</p>
						
						<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(7);">
					<p>중요사항 확인 - 금융소비자의 권리                                                                                   <span class="DivInSpanTag"> 7/8</span></p>
				</div>
				<div id="divList7" class="subDiv">
					<p class="paddingPTag fwb">14일 이내라면 <span style="color: blue;">대출 계약을 철회 </span>할 수 있습니다.</p>
					<p class="paddingPTag">계약체결일, 계약서류를 받은 날,대출금 수령일 중 가장 늦은 날로부터 14일 이내에 계약을 철회할 수 있습니다.</p>
					<p class="paddingPTag">대출 계약 철회 시 에는 중도상환 수수료가 발생하지 않습니다.</p><br>
					<p class="paddingPTag fwb">위법한 대출 계약이라면 수수료 없이 <span style="color: blue;">대출 계약을 해지 </span>할 수 있습니다.</p>
					<p class="paddingPTag">금융회사가 금융소비자 보호에 관한 법률을 위반한 경우 계약체결일로부터 5년 이 내,법 위반 사실을 안 날로부터 1년 이내에 계약 해지를 요구할 수 있습니다.</p><br>
					<p class="paddingPTag fwb">금리인하요구권</p>
					<p class="paddingPTag">저축은행과 신용공여계약을 체결한 고객은 상호저축은행법 제14조의2에 따라 <span style="color: blue;">본인의 신용상태가 개선되었다고 판단되는 경우 금리인하를 요구 할 수 있습니다.</span></p>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(8);">
					<p>중요사항 확인 - 상품별 유의사항                                                                                  <span class="DivInSpanTag"> 8/8</span></p>
				</div>
				<div id="divList8" class="subDiv">
					<p class="paddingPTag fwb">『가계대출』은 가계가 생계유지 등 기타 사용목적으로 받는 대출상품을 총칭합니다.</p>
					<p class="paddingPTag">ㆍ개인(신용)정보 조회는 고객님의 개인신용평점에 영향을 주지 않습니다.</p>
					<p class="paddingPTag">ㆍ대출 계약의 체결만으로도 개인신용평점이 하락할 수 있으며 대출계약이 변제 혹은 이에 준하는 방식으로 거래가 종료된 경우에도 일정기간 개인신용평점의 산정에 영향을 줄 수 있습니다.</p>
					<br>
					<table id="" style="width: 100%;text-align: center;">
						<colgroup>
							<col style="width:40%;">
							<col style="width:30%;">
							<col style="width:30%;">
						</colgroup>
						<thead>
							<tr style="background-color: #f8f8f8;">
								<th>구분</th>
								<th>대출한도 조회</th>
								<th>대출계약 체결</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="background-color: #f8f8f8;">개인신용평점 변동</td>
								<td>X</td>
								<td>O</td>
							</tr>
						</tbody>
					</table>
					<br>
					<p class="paddingPTag">ㆍ대출 실행전,취급 거절사유 발생 시 대출 실행이 불가할 수 있습니다.</p><br>
					<p class="paddingPTag">  -예시)신용상태악화, 보유대출금 증가 등</p><br>
					<p class="paddingPTag">ㆍ시장금리 변동 등으로 상품설명 단계에서 고객님께 적용될 것으로 예상되는 금리와 최종적으로 적용되는 금리는 달라질 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ대출금을 중도에 상환하는 경우, <span style="color: red;">중도상환해약금</span>이 부과될 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ대출 만기 도래 시 고객님의 의사를 확인 후 계약기간 연장이 진행됩니다.</p><br>
					<p class="paddingPTag"> *단,신용점수가 하락되거나 연체 등이 발생하는 경우,<span style="color: red;">대출계약 연장이 거절될 수 있습니다.</span></p><br><br>
					<p class="paddingPTag fwb">『신용대출』은 고객님의 소득 등에 따라 평가되는 개인 신용도에 기반하여 대출한도 및 금리가 산정되는 대출상품입니다.</p><br>
					<p class="paddingPTag">ㆍ신용점수가 하락하거나,대출기간 중 대출금을 충분히 사용하지 않은 경우(한도거래) 대출계약 연장 시 한도가 감액될 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ일정한 자격을 갖춘 고객을 대상으로 한 대출(직장인신용대출,공무원대출 등)의 경우,퇴직/이직/폐업 등 자격상실 사유 발생시 기한연장이 불가할 수 있습니다.</p>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
					<br><br>
					<p class="paddingPTag fwb">궁금하거나 불편한 점이 있다면?</p>
					<p class="paddingPTag fwb">문의는 인터넷 홈페이지(www.yegaramsb.co.kr)또는 고객센터(1877-7788)로 문의 부탁드립니다.</p>
				</div>
			</div>
		</div>
	</div> -->
	
	<!-- 부동산담보대출 -->
<!-- 	<div class="parentDivMain" style="display: none;">
		<div class="area_cust">
			<p style="padding: 10px 10px 10px 10px;"><span class="fwb">「금융소비자 보호에 관한 법률」 제 19조 제1항에서 규정하고 있는 중요한 사항</span> 입니다. 모든 내용을 확인하시면 다음 단계로 넘어갈 수 있습니다.</p>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(1);">
					<p>중요사항 확인 - 금리 및 변동여부                                                                                        <span class="DivInSpanTag"> 1/8</span></p>
				</div>
				<div id="divList1" class="subDiv">
					<p class="paddingPTag fwb">이 상품은 <span style="color: red;">고정금리</span>를 적용합니다. </p>
					<p class="paddingPTag">	기준금리가 변동되어도 대출 금리는 변경되지 않습니다.</p><br>
					<img src="/resources/normal/images/common/img_fixed_rate.png" alt="" >
					
					
					<p class="paddingPTag fwb">유의사항 <br>
						대출금리는 아래의 경우 변동될 수 있습니다.</p>
					<br>
					<p class="paddingPTag">1. 약정한 항목 관련</p>
					<p class="paddingPTag" style="font-size: 13px;">대출기준금리의 변동,거래실적 변동 등</p>
					<br>
					<p class="paddingPTag">2. 대출조건의 변경관련</p>
					<p class="paddingPTag" style="font-size: 13px;">신용등급 변동,기간연장,채무자 변경 등</p>
					<br>
					
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(2);">
					<p>중요사항 확인 - 중도상환해약금                                                                                        <span class="DivInSpanTag"> 2/8</span></p>
				</div>
				<div id="divList2" class="subDiv">
					<p class="paddingPTag fwb">중도상환해약금의 정의</p>
					<p class="paddingPTag">대출의 상환 기익이 오기 전에 대출금을 상환할  경우 고객님이 부담하는 금액입니다.</p><br>
					<p class="paddingPTag fwb">1.산식</p>
					<p class="paddingPTag">중도상환해약금 = 중도상환대출금 X 해약금률 X (대출잔여일수÷대출기간)</p>
				<br><br>
					<p class="paddingPTag fwb">만기 전에 대출을 상환하는 경우 <span style="color: red;">중도상환 수수료가 발생</span>합니다.</p><br>
					<p class="paddingPTag">최초 대출취급일로부터  <span style="font-weight: bold;text-decoration: underline;">3년 이내</span>에 대출금을 중도상환할 경우 최대 <span style="font-weight: bold;text-decoration: underline;">2%</span>의 중도상환수수료가 발생하며 대출의 잔여일수 및 상환금액에 따라 달라집니다.</p>
					<br><br>
					
					
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(3);" style="height: 45px;">
					<p>중요사항 확인 - 상환금액ㆍ이자율ㆍ 시기                                                                                     <br>   <span class="DivInSpanTag"> 3/8</span></p>
				</div>
				<div id="divList3" class="subDiv">
					<p class="paddingPTag fwb"><span style="color: red">만기 일시 상환</span> 방식으로 대출을 갚습니다.</p>
					<p class="paddingPTag">약정기간동안 대출 원금에 대한 상환 없이 <span style="font-weight: bold;text-decoration: underline;">이자만 부담</span>하는 방식입니다. 만기일자에 대출 원금을 모두 상환해야 하므로 상환 부담이 증가할 수 있습니다.</p><br>
					<img src="/resources/normal/images/common/img_graph_equal3.png" alt=""><br><br>
					
					<p class="paddingPTag fwb">상환금액ㆍ이자율ㆍ시기</p>
					<p class="paddingPTag fwb">동일한 금리ㆍ한도로 대출을 진행하더라도 상환방법에 따라 만기까지 부담해야하는 총 원리금 부담액이 달라질 수 있습니다.</p><br>
					<p class="paddingPTag fwb">유의사항</p>
					<p class="paddingPTag fwb">1. 거치식 분할상환 방식의 상환부담</p>
					<p class="paddingPTag">거치기간이 종료되면 거치기간 연장이 어려울 수 있으며, 분할상환이 개시되어 이자와 함께 원금도 갚아나가야 하므로 상환부담이증가할 수 있습니다.</p><br>
					<p class="paddingPTag fwb">2. 만기 일시상환 방식의 상환부담</p>
					<p class="paddingPTag">대출만기가 되면 원금을 한꺼번에 상환해야 하며, 만기연장이 되지 않을 수 있습니다.</p><br>
					
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(4);">
					<p>중요사항 확인 - 담보물에 관한 사항                                                                                   <span class="DivInSpanTag"> 4/8</span></p>
				</div>
				<div id="divList4" class="subDiv">
					<p class="paddingPTag fwb">고객님의 부동산을 담보로 제공 하는 대출 상품입니다.</p>
					<p class="paddingPTag"><span style="text-decoration: underline;">대출의 변제기가 도래</span>하였거나 <span style="text-decoration: underline;">기한의 이익이 상실</span>되었음에도 채무가 상환되지 않는 경우, 은행은 담보로 제공된 주택을 처분하여 대출금을 상환하는데 이를 사용할 수 있으며, 이 경우 담보물의 <span style="font-weight: bold;text-decoration: underline;">소유권을 상실</span> 할 수 있습니다.</p><br>
					<p class="paddingPTag fwb">관련 규정에 의한 제한사항을 준수 하여야 합니다.</p>
					<p class="paddingPTag"> 부동산담보대출은 LTV, DTI, DSR 등 관련 규정의 적용을 받으며 이는 담보물의 지역과 담보가치, 채무자의 연소득에 따라 대출의 한도와 기간에 영향을 미치게 됩니다.</p><br>
					<p class="paddingPTag fwb">주택의 위치·시세, 개인의 소득 등에 따라 담보대출의 가능 여부 및 범위가 다를 수 있습니다.</p>
					<p class="paddingPTag">  주택이 위치한 지역, 시세, 개인의 소득 등에 따라 대출이 다르게 적용될 수 있으므로, 대출가능 여부 및 금리, 한도와 관련하여서는 담당자와 상담을 받으시기 바랍니다. </p><br>
					<p class="paddingPTag fwb">담보권 제공 대출 실행에 따른 <br>재산상 손실</p>
					<p class="paddingPTag">대출 변제가 도래 또는 기한이익 상실에도 불구하고 대출이 상환되지 않는 경우,은행은 법적절차*에 따라 담보물을 처분하여 대출을 상환할 수 있으며, 이경우 담보 제공자는 담보물의 소유권을 잃을 수 있습니다.<br>
						*법적절차 : 민사집행법에 따라 담보물을 경매(매각 및 급전으로 환가)한 후 그 경매대금에 대하여 다른 채권자에 우선하여 변제</p><br>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(5);" style="height: 45px;">
					<p>중요사항 확인 - 금융소비자의 부담금액                                                                                   <span class="DivInSpanTag"> 5/8</span></p>
				</div>
				<div id="divList5" class="subDiv">
					<p class="paddingPTag fwb">원금 및 이자</p>
							<p class="paddingPTag">대출 유지기간 동안에는 아래에 정한 시점에 고객님의 원리금 상환부담이 있습니다.</p><br>
							<table id="" style="width: 120%;text-align: center;">
								<colgroup>
									<col style="width:30%;">
									<col style="width:*;">
								</colgroup>
								<thead>
									<tr style="background-color: #f8f8f8;">
										<th>구분</th>
										<th>부담시점</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="background-color: #f8f8f8;">원금</td>
										<td>만기일 및 분할상환기일</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">이자</td>
										<td>매 이자납입일(통상 매월 납부)</td>
									</tr>
								</tbody>
							</table>
							<br>
							<p class="paddingPTag fwb">수수료 및 비용</p>
							<p class="paddingPTag fwb">1.인지세</p>
							<p class="paddingPTag">대출약정 체결 시 인지세법에 의해 세금 납부 의무가 발생합니다. 인지세는 대출금액에 따라 차등 적용되며 저축은행과 고객이 각 50%씩 부담합니다.</p><br>
							<table id="" style="width: 140%;text-align: center;">
								<colgroup>
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:20%">
									<col style="width:20%;">
								</colgroup>
								<thead>
									<tr style="background-color: #f8f8f8;">
										<th>대출금액</th>
										<th>5천만원 이하</th>
										<th>5천만원 초과<br>1억원 이하</th>
										<th>1억원원 초과<br>10억원 이하</th>
										<th>10억원 초과</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="background-color: #f8f8f8;">인지세액</td>
										<td>비과세</td>
										<td>7만원</td>
										<td>15만원</td>
										<td>35만원</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">고객부담</td>
										<td>-</td>
										<td>3만 5천원</td>
										<td>7만 5천원</td>
										<td>17만 5천원</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">회사부담</td>
										<td>-</td>
										<td>3만 5천원</td>
										<td>7만 5천원</td>
										<td>17만 5천원</td>
									</tr>
								</tbody>
							</table>
							<br>
							<p class="paddingPTag">※ 개업일로부터 2년 이내의 사업자대출인 경우 면제</p><br>
							<p class="paddingPTag fwb"><span style="color: red">근저당권</span>과 관련된 비용이 발생 될 수도 있습니다.</p>
							<p class="paddingPTag"> 해당 담보물에 설정하는 근저당 채권최고액에 대하여 국민주택채권 매입비용이 발생되며 기존 근저당권 설정 및 말소에 대한 비용이 발생할 수도 있습니다.<br> 
							※ 채권매입비용의 면제 대상 및 정확한 금액은 대출심사 후에 확인 가능하며, 담당자의 안내를 받으시기 바랍니다.</p>
							<br>
							<p class="paddingPTag fwb">2.중도상환해약금</p><br>
							<p class="paddingPTag">중요사항 설명보기 『②중도상환해약금』을 참고해 주시기 바랍니다.</p><br><br>
							<p class="paddingPTag fwb">3.기타 유의사항</p><br>
							<p class="paddingPTag">ㆍ <span class="fwb">상품에 따라 상기에</span> 열거되지 않은 수수료나 비용이 추가로 발생 할 수 있습니다.</p><br>
							<p class="paddingPTag">ㆍ고객님의 채무불이행으로 발생한 비용은 『상호저축은행여신거래기본약관 제4조』에 따라 고객님이 부담하셔야 합니다.</p><br>
							<p class="paddingPTag">ㆍ대출계약을 철회하는 경우 저축은행이 부담한 인지세 등 제세공과금,저당권 설정에 따른 등기비용  등은 『금융소비자 보호에 관한 법률』 제 46조 및 관련 규정에 따라 고객님이 반환하셔야 합니다.</p>
							<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(6);">
					<p>중요사항 확인 - 발생 가능한 불이익                                                                                   <span class="DivInSpanTag"> 6/8</span></p>
				</div>
				<div id="divList6" class="subDiv">
					<p class="paddingPTag fwb">연체이자부담</p><br>
						<table id="" style="width: 60%;text-align: center;">
							<tbody>
								<tr style="height: 60px;">
									<td style="background-color: #f8f8f8;font-weight: bold;"><span style="color: red">연체이자율</span> = 대출이자율 + 연체가산이자율</td>
								</tr>
							</tbody>
						</table><br>
						<p class="paddingPTag">ㆍ최고연체이자율 : 연 20%</p>
						<p class="paddingPTag">ㆍ연체가산이자율 : 3%</p>
						<br>
						<p class="paddingPTag fwb">1. 연체이자 납부사유</p>
						<p class="paddingPTag">① 이자납부일에 이자 미납</p>
						<p class="paddingPTag"> - 이자미납 익일~1개월까지는 약정이자에 대해 연체이자 부과</p>
						<p class="paddingPTag"> - 1개월 경과 (기한이익상실)부터는 대출원금에 대해 연체이자 부과</p><br>
						<p class="paddingPTag">② 대출만기일에 원금미납</p>
						<p class="paddingPTag"> - 원금 미납 익일부터 대출원금에 대해 연체이자 부과</p><br>
						<p class="paddingPTag">③ 분할상환일에 분할상환원리금 미납</p>
						<p class="paddingPTag"> - 분할상환원리금 미납 익일부터는 해당 분할상환원리금에 대해 연체이자 부과</p>
						<p class="paddingPTag"> - <span style="color: red">2회이상 (주택담보대출의 경우3회)</span>에는 연속지체시 기한의 이익상실로 인하여  대출원금잔액에 대해     연체이자 부과</p><br>
						<p class="paddingPTag">④ 기한이익상실(상호저축은행여신거래기본약관 제 7조)</p>
						<p class="paddingPTag"> - 기한이익상실(대출금 즉시상환 및 신용불이익)익일부터 대출원금에 대해 연체이자 부과</p>
						<p class="paddingPTag"> * 기한이익상실사유 예시 : 당행 예금에 대해 압류통지 등 도달 ,제공한 담보물에 강제집행 등 개시</p>
						<br>
						<p class="paddingPTag fwb">2. 그 밖의 불이익</p>
						<p class="paddingPTag">①단기연체 (5영업일 이상 연체)</p>
						<p class="paddingPTag"> -신용정보회사에 단기연체정보 제공->금융거래제한(신용카드 정지 등)ㆍ신용평점하락->등록사유 해제에도 불구,하락한 신용평점 회복 난항</p><br>
						<p class="paddingPTag">② 장기연체(3개월 이상연체)</p>
						<p class="paddingPTag"> -『일반신용정보관리규약』에 따른 장기연체정보 등록->금융거래제한(대출신규ㆍ연기제한 등)ㆍ신용평점하락->등록사유 해제에도 불구,해제기록 최대 1년 및 하락한 신용평점 회복난항</p>
						<br>
						<p class="paddingPTag fwb">신용과 관련한 불이익</p>
						<p class="paddingPTag">ㆍ대출계약 체결 사실만으로 <span style="color: red">개인신용평점 하락 가능</span></p>
						<p class="paddingPTag">ㆍ대출계약 완제 후에도 <span style="color: red">일정기간 개인신용평점에 영향</span></p>
						<br>
						<p class="paddingPTag fwb">기타 불이익 </p>
						<p class="paddingPTag">금리,중도상환,상환방법,담보,비용,상품에 따른 특수한 불이익은 각 중요사항 설명보기 항목을 참고 바랍니다.</p>
						
						<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(7);">
					<p>중요사항 확인 - 금융소비자의 권리                                                                                   <span class="DivInSpanTag"> 7/8</span></p>
				</div>
				<div id="divList7" class="subDiv">
					<p class="paddingPTag fwb">14일 이내라면 <span style="color: blue;">대출 계약을 철회</span> 할 수 있습니다.</p>
					<p class="paddingPTag">계약체결일, 계약서류를 받은 날,대출금 수령일 중 가장 늦은 날로부터 14일 이내에 계약을 철회할 수 있습니다.</p>
					<p class="paddingPTag">대출 계약 철회 시 에는 중도상환 수수료가 발생하지 않습니다.</p><br>
					<p class="paddingPTag fwb">위법한 대출 계약이라면 수수료 없이 <span style="color: blue">대출 계약을 해지</span> 할 수 있습니다.</p>
					<p class="paddingPTag">금융회사가 금융소비자 보호에 관한 법률을 위반한 경우 계약체결일로부터 5년 이 내,법 위반 사실을 안 날로부터 1년 이내에 계약 해지를 요구할 수 있습니다.</p><br>
					<p class="paddingPTag fwb"><span style="color: blue">금리인하를 요구 할 수 있는 권리</span>가 있습니다.</p>
					<p class="paddingPTag">금융소비자가 본인의 신용상태가 개선 되었다고 판단되는 경우(재무상태 개선, 개인신용평점 상승 등) 금리인하를 요구할 수 있습니다. 신용상태의 개선이 경미하거나 신용상태가 금리에 영향을 미치지 않는 상품에 대해 금리인하를 요구하는 </p>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(8);">
					<p>중요사항 확인 - 상품별 유의사항                                                                                  <span class="DivInSpanTag"> 8/8</span></p>
				</div>
				<div id="divList8" class="subDiv">
					<p class="paddingPTag fwb">『가계대출』은 가계가 생계유지 등 기타 사용목적으로 받는 대출상품을 총칭합니다.</p>
					<p class="paddingPTag fwb">『기업대출』은 기업을 대상으로 기업 운영에 필요한 자금 대출을 목적으로 하는 상품이라는점에서 생계유지 목적으로 제공되는 가계대출 상품과 구분이 됩니다.</p><br>
					<p class="paddingPTag">ㆍ개인(신용)정보 조회는 고객님의 개인신용평점에 영향을 주지 않습니다.</p>
					<p class="paddingPTag">ㆍ대출 계약의 체결만으로도 개인신용평점이 하락할 수 있으며 대출계약이 변제 혹은 이에 준하는 방식으로 거래가 종료된 경우에도 일정기간 개인신용평점의 산정에 영향을 줄 수 있습니다.</p>
					<br>
					<table id="" style="width: 100%;text-align: center;">
						<colgroup>
							<col style="width:40%;">
							<col style="width:30%;">
							<col style="width:30%;">
						</colgroup>
						<thead>
							<tr style="background-color: #f8f8f8;">
								<th>구분</th>
								<th>대출한도 조회</th>
								<th>대출계약 체결</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="background-color: #f8f8f8;">개인신용평점 변동</td>
								<td>X</td>
								<td>O</td>
							</tr>
						</tbody>
					</table>
					<br>
					<p class="paddingPTag">ㆍ대출 실행전,취급 거절사유 발생 시 대출 실행이 불가할 수 있습니다.</p><br>
					<p class="paddingPTag">  -예시)신용상태악화, 보유대출금 증가 등</p><br>
					<p class="paddingPTag">ㆍ시장금리 변동 등으로 상품설명 단계에서 고객님께 적용될 것으로 예상되는 금리와 최종적으로 적용되는 금리는 달라질 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ 대출금을 중도에 상환하는 경우, 중도상환해약금이 부과될 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ대출 만기 도래 시 고객님의 의사를 확인 후 계약기간 연장이 진행됩니다.</p><br>
					<p class="paddingPTag"> *단,신용점수가 하락되거나 연체 등이 발생하는 경우,대출계약 연장이 거절될 수 있습니다.</p><br><br>
					<p class="paddingPTag fwb">『신용대출』은 고객님의 소득 등에 따라 평가되는 개인 신용도에 기반하여 대출한도 및 금리가 산정되는 대출상품입니다.</p><br>
					<p class="paddingPTag">ㆍ신용점수가 하락하거나,대출기간 중 대출금을 충분히 사용하지 않은 경우(한도거래) 대출계약 연장 시 한도가 감액될 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ일정한 자격을 갖춘 고객을 대상으로 한 대출(직장인신용대출,공무원대출 등)의 경우,퇴직/이직/폐업 등 자격상실 사유 발생시 기한연장이 불가할 수 있습니다.</p>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn">확인</button>
					</div>
					<br><br>
					<p class="paddingPTag fwb">궁금하거나 불편한 점이 있다면?</p>
					<p class="paddingPTag fwb">문의는 인터넷 홈페이지(www.yegaramsb.co.kr)또는 고객센터(1877-7788)로 문의 부탁드립니다.</p>
				</div>
			</div>
		</div>
	</div> -->
	
	<!-- 아파트 담보대출 -->
	<div class="parentDivMain">
		<div class="area_cust">
			<p style="padding: 10px 10px 10px 10px;"><span class="fwb">「금융소비자 보호에 관한 법률」 제 19조 제1항에서 규정하고 있는 중요한 사항</span> 입니다. 모든 내용을 확인하시면 다음 단계로 넘어갈 수 있습니다.</p>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(1);">
					<p>중요사항 확인 - 금리 및 변동여부<span class="DivInSpanTag"> 1/8</span><span class="check1" style="color:blue;display:none;float:right;margin-right:15px;">확인</span></p>
				</div>
				<div id="divList1" class="subDiv estate">
					<img src="/resources/normal/images/common/img_variable_rate1.png" alt="" class="img1" id="prodImage">
					<p class="paddingPTag">	고정금리란?</p><br>
					<p class="paddingPTag">	대출 실행 시 결정된 금리가 대출만기까지 동일하게 유지</p>
					<img src="/resources/normal/images/common/img_variable_rate2.png" alt="" class="img1" id="prodImage">
					<p class="paddingPTag">	변동금리란?</p><br>
					<p class="paddingPTag">	일정주기 (3/6/12개월등) 마다 대출 기준금리의 변동에 따라 대출금리가 변동 </p><br>
 					<p class="paddingPTag fwb">유의사항 <br><br>대출금리는 아래의 경우 <span style="color: red"> 변동될 수 있습니다.</span>
					</p><br>
					<p class="paddingPTag">1. 약정한 항목 관련</p>
					<p class="paddingPTag" style="font-size: 13px;">대출기준금리의 변동,거래실적 변동 등</p><br>
					<p class="paddingPTag">2. 대출조건의 변경관련</p>
					<p class="paddingPTag" style="font-size: 13px;">신용등급 변동,기간연장,채무자 변경 등	</p><br>
					<div class="divList1" style="text-align:center;">
						<button type="button" name="button" class="infobtn" onclick="importantCheck(0);">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(2);">
					<p>중요사항 확인 - 중도상환해약금 <span class="DivInSpanTag"> 2/8</span><span class="check1" style="color:blue;display:none;float:right;margin-right:15px;">확인</span></p>
				</div>
				<div id="divList2" class="subDiv">
					<p class="paddingPTag fwb">만기 전에 대출을 상환하는 경우 <span style="color: red;">중도상환 수수료가 발생</span>합니다.</p><br>
					<p class="paddingPTag">최초 대출취급일로부터  <span style="font-weight: bold;text-decoration: underline;">3년 이내</span>에 대출금을 중도상환할 경우 최대 <span style="font-weight: bold;text-decoration: underline;">2%</span>의 중도상환수수료가 발생하며 대출의 잔여일수 및 상환금액에 따라 달라집니다.</p>
					<br><br>
					<p class="paddingPTag fwb">중도상환해약금의 정의</p>
					<p class="paddingPTag">대출의 상환 기익이 오기 전에 대출금을 상환할  경우 고객님이 부담하는 금액입니다.</p><br>
					<p class="paddingPTag fwb">1.산식</p>
					<p class="paddingPTag">중도상환해약금 = 중도상환대출금 X 해약금률 X (대출잔여일수÷대출기간)</p>
					<br><br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn" onclick="importantCheck(1);">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(3);">
					<p>중요사항 확인 - 상환금액ㆍ이자율ㆍ 시기<span class="DivInSpanTag"> 3/8</span><span class="check1" style="color:blue;display:none;float:right;margin-right:15px;">확인</span></p>
				</div>
				<div id="divList3" class="subDiv">
					<p class="paddingPTag fwb"><span style="color: red">만기 일시 상환</span> 방식으로 대출을 갚습니다.</p>
					<p class="paddingPTag">약정기간동안 대출 원금에 대한 상환 없이 <span style="font-weight: bold;text-decoration: underline;">이자만 부담</span>하는 방식입니다. 만기일자에 대출 원금을 모두 상환해야 하므로 상환 부담이 증가할 수 있습니다.</p><br>
					<img src="/resources/normal/images/common/loan3.png" alt="">
					<br><br>
					<p class="paddingPTag fwb">상환금액ㆍ이자율ㆍ시기</p>
					<p class="paddingPTag fwb">동일한 금리ㆍ한도로 대출을 진행하더라도 상환방법에 따라 만기까지 부담해야하는 총 원리금 부담액이 달라질 수 있습니다.</p><br>
					<p class="paddingPTag fwb">유의사항</p>
					<p class="paddingPTag fwb">1. 거치식 분할상환 방식의 상환부담</p>
					<p class="paddingPTag">거치기간이 종료되면 거치기간 연장이 어려울 수 있으며, 분할상환이 개시되어 이자와 함께 원금도 갚아나가야 하므로 상환부담이 증가할 수 있습니다.</p><br>
					<p class="paddingPTag fwb">2. 만기 일시상환 방식의 상환부담</p>
					<p class="paddingPTag">대출만기가 되면 원금을 한꺼번에 상환해야 하며, 만기연장이 되지 않을 수 있습니다.</p><br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn" onclick="importantCheck(2);">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(4);">
					<p>중요사항 확인 - 담보물에 관한 사항 <span class="DivInSpanTag"> 4/8</span><span class="check1" style="color:blue;display:none;float:right;margin-right:15px;">확인</span></p>
				</div>
				<div id="divList4" class="subDiv">
					<p class="paddingPTag fwb">고객님의 부동산을 담보로 제공 하는 대출 상품입니다.</p>
					<p class="paddingPTag"><span style="text-decoration: underline;">대출의 변제기가 도래</span>하였거나 <span style="text-decoration: underline;">기한의 이익이 상실</span>되었음에도 채무가 상환되지 않는 경우, 은행은 담보로 제공된 주택을 처분하여 대출금을 상환하는데 이를 사용할 수 있으며, 이 경우 담보물의 <span style="font-weight: bold;text-decoration: underline;">소유권을 상실</span> 할 수 있습니다.</p><br>
					<p class="paddingPTag fwb">관련 규정에 의한 제한사항을 준수 하여야 합니다.</p>
					<p class="paddingPTag"> 부동산담보대출은 LTV, DTI, DSR 등 관련 규정의 적용을 받으며 이는 담보물의 지역과 담보가치, 채무자의 연소득에 따라 대출의 한도와 기간에 영향을 미치게 됩니다.</p><br>
					<p class="paddingPTag fwb">주택의 위치·시세, 개인의 소득 등에 따라 담보대출의 가능 여부 및 범위가 다를 수 있습니다.</p>
					<p class="paddingPTag">  주택이 위치한 지역, 시세, 개인의 소득 등에 따라 대출이 다르게 적용될 수 있으므로, 대출가능 여부 및 금리, 한도와 관련하여서는 담당자와 상담을 받으시기 바랍니다. </p><br>
					<p class="paddingPTag fwb">담보권 제공 대출 실행에 따른 <br>재산상 손실</p>
					<p class="paddingPTag">대출 변제가 도래 또는 기한이익 상실에도 불구하고 대출이 상환되지 않는 경우,은행은 법적절차*에 따라 담보물을 처분하여 대출을 상환할 수 있으며, 이경우 담보 제공자는 담보물의 소유권을 잃을 수 있습니다.<br>
						*법적절차 : 민사집행법에 따라 담보물을 경매(매각 및 급전으로 환가)한 후 그 경매대금에 대하여 다른 채권자에 우선하여 변제</p><br>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn" onclick="importantCheck(3);">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(5);">
					<p>중요사항 확인 - 금융소비자의 부담금액<span class="DivInSpanTag"> 5/8</span><span class="check1" style="color:blue;display:none;float:right;margin-right:15px;">확인</span></p>
				</div>
				<div id="divList5" class="subDiv">
					<p class="paddingPTag fwb">원금 및 이자</p>
							<p class="paddingPTag">대출 유지기간 동안에는 아래에 정한 시점에 고객님의 원리금 상환부담이 있습니다.</p><br>
							<table id="" style="width: 120%;text-align: center;">
								<colgroup>
									<col style="width:30%;">
									<col style="width:*;">
								</colgroup>
								<thead>
									<tr style="background-color: #f8f8f8;">
										<th>구분</th>
										<th>부담시점</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="background-color: #f8f8f8;">원금</td>
										<td>만기일 및 분할상환기일</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">이자</td>
										<td>매 이자납입일(통상 매월 납부)</td>
									</tr>
								</tbody>
							</table>
							<br>
							<p class="paddingPTag fwb">수수료 및 비용</p>
							<p class="paddingPTag fwb">1.인지세</p>
							<p class="paddingPTag">대출약정 체결 시 인지세법에 의해 세금 납부 의무가 발생합니다. 인지세는 대출금액에 따라 차등 적용되며 저축은행과 고객이 각 50%씩 부담합니다.</p><br>
							<table id="" style="width: 140%;text-align: center;" class="tblTrHeght">
								<colgroup>
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:20%">
									<col style="width:20%;">
								</colgroup>
								<thead>
									<tr style="background-color: #f8f8f8;">
										<th>대출금액</th>
										<th>5천만원 이하</th>
										<th>5천만원 초과<br>1억원 이하</th>
										<th>1억원원 초과<br>10억원 이하</th>
										<th>10억원 초과</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="background-color: #f8f8f8;">인지세액</td>
										<td>비과세</td>
										<td>7만원</td>
										<td>15만원</td>
										<td>35만원</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">고객부담</td>
										<td>-</td>
										<td>3만 5천원</td>
										<td>7만 5천원</td>
										<td>17만 5천원</td>
									</tr>
									<tr>
										<td style="background-color: #f8f8f8;">회사부담</td>
										<td>-</td>
										<td>3만 5천원</td>
										<td>7만 5천원</td>
										<td>17만 5천원</td>
									</tr>
								</tbody>
							</table>
							<br>
							<p class="paddingPTag">※ 개업일로부터 2년 이내의 사업자대출인 경우 면제</p><br>
							<p class="paddingPTag fwb"><span style="color: red">근저당권</span>과 관련된 비용이 발생 될 수도 있습니다.</p>
							<p class="paddingPTag"> 해당 담보물에 설정하는 근저당 채권최고액에 대하여 국민주택채권 매입비용이 발생되며 기존 근저당권 설정 및 말소에 대한 비용이 발생할 수도 있습니다.<br> 
							※ 채권매입비용의 면제 대상 및 정확한 금액은 대출심사 후에 확인 가능하며, 담당자의 안내를 받으시기 바랍니다.</p>
							<br>
							<p class="paddingPTag fwb">2.중도상환해약금</p><br>
							<p class="paddingPTag">중요사항 설명보기 『②중도상환해약금』을 참고해 주시기 바랍니다.</p><br><br>
							<p class="paddingPTag fwb">3.기타 유의사항</p><br>
							<p class="paddingPTag">ㆍ<span class="fwb"> 상품에 따라 상기에</span> 열거되지 않은 수수료나 비용이 추가로 발생 할 수 있습니다.</p><br>
							<p class="paddingPTag">ㆍ고객님의 채무불이행으로 발생한 비용은 『상호저축은행여신거래기본약관 제4조』에 따라 고객님이 부담하셔야 합니다.</p><br>
							<p class="paddingPTag">ㆍ대출계약을 철회하는 경우 저축은행이 부담한 인지세 등 제세공과금,저당권 설정에 따른 등기비용  등은 『금융소비자 보호에 관한 법률』 제 46조 및 관련 규정에 따라 고객님이 반환하셔야 합니다.</p>
							<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn" onclick="importantCheck(4);">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(6);">
					<p>중요사항 확인 - 발생 가능한 불이익 <span class="DivInSpanTag"> 6/8</span><span class="check1" style="color:blue;display:none;float:right;margin-right:15px;">확인</span></p>
				</div>
				<div id="divList6" class="subDiv">
					<p class="paddingPTag fwb">연체이자부담</p><br>
						<table id="" style="width: 60%;text-align: center;">
							<tbody>
								<tr style="height: 60px;">
									<td style="background-color: #f8f8f8;font-weight: bold;"><span style="color: red">연체이자율</span> = 대출이자율 + 연체가산이자율</td>
								</tr>
							</tbody>
						</table><br>
						<p class="paddingPTag">ㆍ최고연체이자율 : 연 20%</p>
						<p class="paddingPTag">ㆍ연체가산이자율 : 3%</p>
						<br>
						<p class="paddingPTag fwb">1. 연체이자 납부사유</p>
						<p class="paddingPTag">① 이자납부일에 이자 미납</p>
						<p class="paddingPTag"> - 이자미납 익일~1개월까지는 약정이자에 대해 연체이자 부과</p>
						<p class="paddingPTag"> - 1개월 경과 (기한이익상실)부터는 대출원금에 대해 연체이자 부과</p><br>
						<p class="paddingPTag">② 대출만기일에 원금미납</p>
						<p class="paddingPTag"> - 원금 미납 익일부터 대출원금에 대해 연체이자 부과</p><br>
						<p class="paddingPTag">③ 분할상환일에 분할상환원리금 미납</p>
						<p class="paddingPTag"> - 분할상환원리금 미납 익일부터는 해당 분할상환원리금에 대해 연체이자 부과</p>
						<p class="paddingPTag"> - <span style="color: red">2회이상 (주택담보대출의 경우3회)</span>에는 연속지체시 기한의 이익상실로 인하여  대출원금잔액에 대해     연체이자 부과</p><br>
						<p class="paddingPTag">④ 기한이익상실(상호저축은행여신거래기본약관 제 7조)</p>
						<p class="paddingPTag"> - 기한이익상실(대출금 즉시상환 및 신용불이익)익일부터 대출원금에 대해 연체이자 부과</p>
						<p class="paddingPTag"> * 기한이익상실사유 예시 : 당행 예금에 대해 압류통지 등 도달 ,제공한 담보물에 강제집행 등 개시</p>
						<br>
						<p class="paddingPTag fwb">2. 그 밖의 불이익</p>
						<p class="paddingPTag">①단기연체 (5영업일 이상 연체)</p>
						<p class="paddingPTag"> -신용정보회사에 단기연체정보 제공->금융거래제한(신용카드 정지 등)ㆍ신용평점하락->등록사유 해제에도 불구,하락한 신용평점 회복 난항</p><br>
						<p class="paddingPTag">② 장기연체(3개월 이상연체)</p>
						<p class="paddingPTag"> -『일반신용정보관리규약』에 따른 장기연체정보 등록->금융거래제한(대출신규ㆍ연기제한 등)ㆍ신용평점하락->등록사유 해제에도 불구,해제기록 최대 1년 및 하락한 신용평점 회복난항</p>
						<br>
						<p class="paddingPTag fwb">신용과 관련한 불이익</p>
						<p class="paddingPTag">ㆍ대출계약 체결 사실만으로 <span style="color: red">개인신용평점 하락 가능</span></p>
						<p class="paddingPTag">ㆍ대출계약 완제 후에도 <span style="color: red">일정기간 개인신용평점에 영향</span></p>
						<br>
						<p class="paddingPTag fwb">기타 불이익 </p>
						<p class="paddingPTag">금리,중도상환,상환방법,담보,비용,상품에 따른 특수한 불이익은 각 중요사항 설명보기 항목을 참고 바랍니다.</p>
						
						<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn" onclick="importantCheck(5);">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(7);">
					<p>중요사항 확인 - 금융소비자의 권리<span class="DivInSpanTag"> 7/8</span><span class="check1" style="color:blue;display:none;float:right;margin-right:15px;">확인</span></p>
				</div>
				<div id="divList7" class="subDiv">
					<p class="paddingPTag fwb">14일 이내라면 <span style="color: blue;">대출 계약을 철회</span> 할 수 있습니다.</p>
					<p class="paddingPTag">계약체결일, 계약서류를 받은 날,대출금 수령일 중 가장 늦은 날로부터 14일 이내에 계약을 철회할 수 있습니다.</p>
					<p class="paddingPTag">대출 계약 철회 시 에는 중도상환 수수료가 발생하지 않습니다.</p><br>
					<p class="paddingPTag fwb">위법한 대출 계약이라면 수수료 없이 <span style="color: blue;">대출 계약을 해</span>지 할 수 있습니다.</p>
					<p class="paddingPTag">금융회사가 금융소비자 보호에 관한 법률을 위반한 경우 계약체결일로부터 5년 이 내,법 위반 사실을 안 날로부터 1년 이내에 계약 해지를 요구할 수 있습니다.</p><br>
					<p class="paddingPTag fwb"><span style="color: blue;">금리인하를 요구 할 수 있는 권리</span>가 있습니다.</p>
					<p class="paddingPTag">저축은행과 신용공여계약을 체결한 고객은 상호저축은행법 제14조의2에 따라 본인의 신용상태가 개선되었다고 판단되는 경우 금리인하를 요구 할 수 있습니다.</p>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn" onclick="importantCheck(6);">확인</button>
					</div>
				</div>
			</div>
			<div class="mt10 class_terms_box" style="margin-bottom: 15px;">
				<div class="parentDiv" onclick="fn_toGgle(8);">
					<p>중요사항 확인 - 상품별 유의사항  <span class="DivInSpanTag"> 8/8</span><span class="check1" style="color:blue;display:none;float:right;margin-right:15px;">확인</span></p>
				</div>
				<div id="divList8" class="subDiv">
					<p class="paddingPTag fwb">『가계대출』은 가계가 생계유지 등 기타 사용목적으로 받는 대출상품을 총칭합니다.</p>
					<p class="paddingPTag fwb">『기업대출』은 기업을 대상으로 기업 운영에 필요한 자금 대출을 목적으로 하는 상품이라는점에서 생계유지 목적으로 제공되는 가계대출 상품과 구분이 됩니다.</p><br>
					<p class="paddingPTag">ㆍ개인(신용)정보 조회는 고객님의 개인신용평점에 영향을 주지 않습니다.</p>
					<p class="paddingPTag">ㆍ대출 계약의 체결만으로도 개인신용평점이 하락할 수 있으며 대출계약이 변제 혹은 이에 준하는 방식으로 거래가 종료된 경우에도 일정기간 개인신용평점의 산정에 영향을 줄 수 있습니다.</p>
					<br>
					<table id="" style="width: 100%;text-align: center;">
						<colgroup>
							<col style="width:40%;">
							<col style="width:30%;">
							<col style="width:30%;">
						</colgroup>
						<thead>
							<tr style="background-color: #f8f8f8;">
								<th>구분</th>
								<th>대출한도 조회</th>
								<th>대출계약 체결</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="background-color: #f8f8f8;">개인신용평점 변동</td>
								<td>X</td>
								<td>O</td>
							</tr>
						</tbody>
					</table>
					<br>
					<p class="paddingPTag">ㆍ대출 실행전,취급 거절사유 발생 시 대출 실행이 불가할 수 있습니다.</p><br>
					<p class="paddingPTag">  -예시)신용상태악화, 보유대출금 증가 등</p><br>
					<p class="paddingPTag">ㆍ시장금리 변동 등으로 상품설명 단계에서 고객님께 적용될 것으로 예상되는 금리와 최종적으로 적용되는 금리는 달라질 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ 대출금을 중도에 상환하는 경우, 중도상환해약금이 부과될 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ대출 만기 도래 시 고객님의 의사를 확인 후 계약기간 연장이 진행됩니다.</p><br>
					<p class="paddingPTag"> 단, 신용점수 혹은 담보가치가 하락되거나 연체등이 발생하는 경우 대출계약의 연장이 거절되거나 한도가 감액될 수 있습니다.</p><br><br>
					<p class="paddingPTag fwb">『신용대출』은 고객님의 소득 등에 따라 평가되는 개인 신용도에 기반하여 대출한도 및 금리가 산정되는 대출상품입니다.</p><br>
					<p class="paddingPTag">ㆍ신용점수가 하락하거나,대출기간 중 대출금을 충분히 사용하지 않은 경우(한도거래) 대출계약 연장 시 한도가 감액될 수 있습니다.</p><br>
					<p class="paddingPTag">ㆍ일정한 자격을 갖춘 고객을 대상으로 한 대출(직장인신용대출,공무원대출 등)의 경우,퇴직/이직/폐업 등 자격상실 사유 발생시 기한연장이 불가할 수 있습니다.</p><br>
					<p class="paddingPTag">*단,신용점수가 하락되거나 연체 등이 발생하는 경우,대출계약 연장이 거절될 수 있습니다.</p>
					<br>
					<div class="" style="text-align:center;">
						<button type="button" name="button" class="infobtn" onclick="importantCheck(7);">확인</button>
					</div>
					<br><br>
					<p class="paddingPTag fwb">궁금하거나 불편한 점이 있다면?</p>
					<p class="paddingPTag fwb">문의는 인터넷 홈페이지(www.yegaramsb.co.kr)또는 고객센터(1877-7788)로 문의 부탁드립니다.</p>
				</div>
			</div>
		</div>
	</div>
	
</div>