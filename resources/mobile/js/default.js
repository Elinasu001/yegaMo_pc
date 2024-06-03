var winH2 = $(window).height()||window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight;
$(document).on('click', '.btn-top', function(e) {
    e.preventDefault();
    $('body, html').animate({
        scrollTop: 0
    }, 450);
});
//문자열자르기
function cutByLen(str, maxByte) {
    for (b = i = 0; c = str.charCodeAt(i);) {
        b += c >> 7 ? 2 : 1;
        if (b > maxByte)
            break;
        i++;
    }
    return str.substring(0, i);
}
// 접근성 관련 포커스 강제 이동
function accessibilityFocus() {
    $(document).on('keydown', '[data-focus-prev], [data-focus-next]', function(e) {
        var next = $(e.target).attr('data-focus-next'),
            prev = $(e.target).attr('data-focus-prev'),
            target = next || prev || false;
        if (!target || e.keyCode != 9) {
            return;
        }
		//console.log('next : '+next+'\nprev : '+prev);
        if ((!e.shiftKey && !!next) || (e.shiftKey && !!prev)) {
            //setTimeout(function() {
				//console.log('target : '+target);
                $('[data-focus="' + target + '"]').focus();
            //}, 1);
        }
    });
}
function tooltip() {
    var openBtn = '[data-tooltip]',
        closeBtn = '.tooltip-close';

    function getTarget(t) {
        return $(t).attr('data-tooltip');
    }

    function open(t) {
        var showTarget = $('[data-tooltip-con="' + t + '"]');
        showTarget.show();
        
        if(t == "agreementChall-layer"){//20210624 전제선택약관 팝업오픈시 위치조정
        	showTarget.outerHeight(739);
        	showTarget.outerWidth($(window).width());
        }
        
        layerFunc(showTarget);
        showTarget.focus();
        showTarget.find('.tooltip-close').data('activeTarget', t);
		//custom event
	    $("body").trigger("OPEN_LAYER");
    }

    function close(t) {
		deleteBlock();
        var activeTarget = $('[data-tooltip-con="' + t + '"]');
        activeTarget.hide();
        $('[data-tooltip="' + t + '"]').focus();

        /* 레이어팝업이 중복으로 뜰때*/
        if ( $('.layerpopup:visible').length > 1 ) {
	    	addBlock();
	    }

    }
    $(document).on('click', openBtn, function(e) {
        e.preventDefault();
        open(getTarget(e.target));
    }).on('click', closeBtn, function(e) {
        e.preventDefault();
        close($(this).data('activeTarget'));
    });
}
//레이어팝업 높이 판단하여 block와 position 컨트롤
function layerFunc(_target, isNext){
    if(_target.outerHeight() > $(window).height()){
        _target.css({'position':'absolute','top':'50px','left':getCenterAlignPos($(window).width(), _target.outerWidth())});
        addBlock('');
    }else{
        //_target.css({'position':'fixed','top':getCenterAlignPos($(window).height(), _target.outerHeight()),'left':getCenterAlignPos($(window).width(), _target.outerWidth())});
        //addBlock();
    	if(_target.hasClass('pdf-alllayer')){
    		_target.css({'position':'fixed','top': '66px','left': '0'});
    	}else{
    		_target.css({'position':'fixed','top':getCenterAlignPos($(window).height(), _target.outerHeight()),'left':getCenterAlignPos($(window).width(), _target.outerWidth())});
    	}
       //2021.09.14 다음단계 버튼 클릭 시 가계대출상품설명서의 상세약관이 체크되어 있지 않은 경우 해당 팝업의 위치로 이동 
         if(isNext == 1){
			$('#' + _target.attr('id')).find('.pop-cts').find('#pop_radio03').focus();
         }
        if(_target.attr('id') == "loadingLayer"){
            addBlock('removeEvent');
        }else{
            addBlock();
        }
    }

   //20210726 필수약관 신규 추가
    if(_target.attr('id') == "agreement18Layer"){
    	 $("#agreement18Layer").find(".layer-con").find(".pop-cts").find(".table-wrap").find(".table-wrap").find("#dsrCorpNm").text($("#jsdsrCorpNm").val());
         $("#agreement18Layer").find(".layer-con").find(".pop-cts").find(".table-wrap").find(".table-wrap").find("#dsrUserNm").text($("#jsDsrUserNm").val());
    }
  //20210811 필수약관 변경
    if(_target.attr('id') == "agreement13Layer"){
   		$("#agreement13Layer").find(".layer-con").find(".pop-cts").find(".table-wrap").find(".table-wrap").find("#dsrCorpNm").text($("#jsdsrCorpNm").val());
        $("#agreement13Layer").find(".layer-con").find(".pop-cts").find(".table-wrap").find(".table-wrap").find("#dsrUserNm").text($("#jsDsrUserNm").val());
   }
    
    //2021.09.14 가계대출상품설명서 내용 변경
    var popNum = _target.attr('id');
    var pop_prd_name = "라이브A";
    $('#' + popNum).find('.pop-cts').find('#change_rate').text('고정 금리');
    //$('#' + popNum).find('.pop-cts').find('#pop_prd_price').text('30,000,000');
    
    /* 필수약관 전체보기 팝업 */
    if ($('#agreementallLayer:visible').length == 1) {
        var ctsTotal = $('#agreementallLayer .con').length;
        var idx = $('#agreementallLayer .con').index();
        var allLayerTextVal="";
        $('#agreementallLayer .con').hide();
        $('#agreementallLayer .con').eq(idx - 1).show();

     //   $('.all-agree .total').html(ctsTotal);
     //   $('.all-agree .view').html(idx);

        $('.ctrl-box button').click(function() {
            if ($(this).hasClass('btn-next')) {
                if (idx < ctsTotal) {
                    idx++;
                    $('.all-agree .view').html(idx);
                    $('#agreementallLayer .con').hide();
                    $('#agreementallLayer .con').eq(idx - 1).show();
                }
            } else {
                if (idx > 1) {
                    idx--;
                    $('.all-agree .view').html(idx);
                    $('#agreementallLayer .con').hide();
                    $('#agreementallLayer .con').eq(idx - 1).show();
                }
            }
            idx = idx;
        });
        
        
        //약관 전체선택관련 20210623
		if($("#CRDT_AGR_DTL_YN").val() == ''){
			$("#CRDT_AGR_DTL_YN").val("N");
		}
		if($("#PROD_AGR_DTL_YN").val() == ''){
			$("#PROD_AGR_DTL_YN").val("N");
		}
		if($("#SRVC_AGR_DTL_YN").val() == ''){
			$("#SRVC_AGR_DTL_YN").val("N");
		}
		if($("#THIRD_AGR_DTL_YN").val() == ''){
			$("#THIRD_AGR_DTL_YN").val("N");
		}
		
		if(($("#prod_cd").val() == "GL091") ||($("#prod_cd").val() == "GL093") || ($("#prod_cd").val() == "GL094")){
        	allLayerTextVal= "국세체납정보, (담보대출) 담보물권 정보";
		}else{
			allLayerTextVal="국세체납정보";
		}
        
        $("#agreementallLayer").find("#all-agree-check6").find(".layer-con").find(".pop-cts").find(".T000800002_2").find(".table-wrap").find("#changeTextVal").text(allLayerTextVal);
        //20210726 필수약관 신규 추가
        $("#agreementallLayer").find("#all-agree-check18").find(".layer-con").find(".pop-cts").find(".table-wrap").find(".table-wrap").find("#dsrCorpNm").text($("#jsdsrCorpNm").val());
        $("#agreementallLayer").find("#all-agree-check18").find(".layer-con").find(".pop-cts").find(".table-wrap").find(".table-wrap").find("#dsrUserNm").text($("#jsDsrUserNm").val());

        //20210811 필수약관 변경
        $("#agreementallLayer").find("#all-agree-check13").find(".layer-con").find(".pop-cts").find(".table-wrap").find(".table-wrap").find("#dsrCorpNm").text($("#jsdsrCorpNm").val());
        $("#agreementallLayer").find("#all-agree-check13").find(".layer-con").find(".pop-cts").find(".table-wrap").find(".table-wrap").find("#dsrUserNm").text($("#jsDsrUserNm").val());
        
        
      //2021.09.14	가계대출상품설명서
		var length = 0;
		if($('#agreementallLayer').find('#all-productdetail').hasClass('T000800004')){
			length = $('#productdetail-layer').find('.pop-cts').find('.question-list').find('li').length;
		}else{
			length = $('#retailDetail-layer').find('.pop-cts').find('.question-list').find('li').length
			pop_prd_name = $('#prod_nm').val();
			
			//20211015 리테일 상품설명서 내용수정
			if($("#prod_cd").val() == "GL091"){
				$('#' + popNum).find('.pop-cts').find("#rate_mothod").text("□ 변동 ■ 고정 □ 혼합");
				$('#' + popNum).find('.pop-cts').find("#repay_mothod").text("□만기일시 □원금균등 ■원리금균등");
			}else{
				$('#' + popNum).find('.pop-cts').find("#rate_mothod").text("■ 변동 □ 고정 □ 혼합");
				$('#' + popNum).find('.pop-cts').find("#repay_mothod").text("■만기일시 □원금균등 □원리금균등");
			}
		}
		for(var i = 0; i < length; i++){
			$('#RADIO_CHECK_YN'+(i+1)).val("Y");
		}
		
		$('#' + popNum).find('.pop-cts').find('#pop_prd_name').text(pop_prd_name);	//상품개요 및 특성의 상품명 설정
		
        var checks = $('#all-productdetail').find('.pop-cts').find('.question-list');
    	$(checks).find('li').each(function(index){	//hidden값으로 모두동의하기에서 체크한거 자세히보기에서 체크 한것과 동일하게 체크(반대의 경우도 확인)
    		$(this).find('label').addClass('radio');	//label에 .radio 설정
    		if($('#RADIO_CHECK_YN'+(index+1)).val() == "Y"){
    			$(this).find('input:radio[value="Y"]').parent().addClass("r-on");
    			$(this).find('input:radio[value="Y"]').prop("checked",true);
    			$(this).find('input:radio[value="N"]').parent().removeClass("r-on");
    		}else if($('#RADIO_CHECK_YN'+(index+1)).val() == "N"){
    			$(this).find('input:radio[value="N"]').parent().addClass("r-on");
    			$(this).find('input:radio[value="N"]').prop("checked",true);
    			$(this).find('input:radio[value="Y"]').parent().removeClass("r-on");
    		}
    	});
    	
    	//가계대출상품설명서 서명 날짜 입력
    	var date = new Date();
    	$('#all-productdetail').find('.pop-cts').find("#pop_customer_confirmation_date").empty();
    	$('#all-productdetail').find('.pop-cts').find("#pop_customer_confirmation_date").text("고객확인 : " + date.getFullYear() + "년 " + (date.getMonth()+1) + "월 " + date.getDate() + "일 (서명/인)");

        
        $(".radio-area").find(".ctm-radio").click(function() {//약관 전체선택관련 20210623
        	 var cls = $(this).find("input").attr("name");
        	 var radioNm ;
        	 var radioId_1 ;
        	 var radioId_2 ;
        	 var chkVal ;
        	// var codeI;
        	 
        	 //2021.09.14 가계대출상품설명서 라디오박스 제어
        	 if( (cls == "pop_radio01") || (cls == "pop_radio02") || (cls == "pop_radio03") || (cls == "pop_radio04")){
//        		 if( (cls == "pop_radio01") || (cls == "pop_radio02") || (cls == "pop_radio03") || (cls == "pop_radio04")){
 				radioId_1 = "pop_radio01";
				radioId_2 = "pop_radio02";
				var radioId_3 = "pop_radio03";
	        	var radioId_4 = "pop_radio04";
	        	var radioId_5 = "pop_radio05";
	        	var radioId_6 = "pop_radio06";
	        	var radioId_7 = "pop_radio07";
	        	var radioId_8 = "pop_radio08";
	        	var checkedId = $("input:radio[name="+cls+"]:checked").attr("id")
				if(cls == "pop_radio01"){
					//console.log($("#"+radioId_1+"").parent().attr("class"));
					//console.log(">>>>>>>>>>>>>>>>   "+);
					if(radioId_1 == checkedId){
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_1+"").parent().addClass("r-on");
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_1+"").prop("checked",true);
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_2+"").parent().removeClass("r-on");
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_2+"").prop("checked",false);
            		}else {
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_2+"").parent().addClass("r-on");
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_2+"").prop("checked",true);
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_1+"").parent().removeClass("r-on");
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_1+"").prop("checked",false);
            		}
					$("#RADIO_CHECK_YN1").val($("input:radio[name='"+cls+"']:checked").val());
				}else if(cls == "pop_radio02"){
					if(radioId_3 == checkedId){
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_3+"").parent().addClass("r-on");
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_3+"").prop("checked",true);
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_4+"").parent().removeClass("r-on");
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_4+"").prop("checked",false);
            		}else{
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_4+"").parent().addClass("r-on");
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_4+"").prop("checked",true);
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_3+"").parent().removeClass("r-on");
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_3+"").prop("checked",false);
            		}
					$("#RADIO_CHECK_YN2").val($("input:radio[name='"+cls+"']:checked").val());
				}else if(cls == "pop_radio03"){
					if(radioId_5 == checkedId){
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_5+"").parent().addClass("r-on");
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_5+"").prop("checked",true);
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_6+"").parent().removeClass("r-on");
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_6+"").prop("checked",false);
            		}else{
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_6+"").parent().addClass("r-on");
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_6+"").prop("checked",true);
    	        		$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_5+"").parent().removeClass("r-on");
    	        		$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_5+"").prop("checked",false);
            		}
					$("#RADIO_CHECK_YN3").val($("input:radio[name='"+cls+"']:checked").val());
				}else if(cls == "pop_radio04"){
					if(radioId_7 == checkedId){
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_7+"").parent().addClass("r-on");
						$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_7+"").prop("checked",true);
    	        		$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_8+"").parent().removeClass("r-on");
    	        		$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_8+"").prop("checked",false);
            		}else{
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_8+"").parent().addClass("r-on");
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_8+"").prop("checked",true);
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_7+"").parent().removeClass("r-on");
            			$('#all-productdetail').find('.pop-cts').find('.question-list').find('li').find("#"+radioId_7+"").prop("checked",false);
            		}
					$("#RADIO_CHECK_YN4").val($("input:radio[name='"+cls+"']:checked").val());
				}
				
        	}else{
	        	 $("input:radio[name="+cls+"]").click(function() {
	        		var radioId = $(this).attr("id");
	        		var radioName = radioId.substring(0,10);
	        		radioNm = radioName+"_1_1";
	    			radioId_1 = radioName+"_2_1";
	    			radioId_2 = radioName+"_2_2";
	    			
	        		if($("#"+radioId_1+"").is(':checked')){
	        			
	        		}else{
	        			$("#"+radioId_1+" ").parent().parent().removeClass("r-on");
						$("#"+radioId_2+" ").parent().parent().addClass("r-on");
						$("#"+radioId_1+" ").attr("checked","");
						$("#"+radioId_2+" ").attr("checked","checked");
						$("."+radioName+"_2"+"").css("display","block");
						$("."+radioName+"_1"+"").css("display","none");
	    				
	        		}
	        		chkVal = $("input:radio[name='"+radioNm+"']:checked").val();
					if(radioName == 'T000800001'){
						$("#CRDT_AGR_DTL_YN").val(chkVal);
					}else if(radioName == 'T000800002'){
						$("#PROD_AGR_DTL_YN").val(chkVal);
					}else if(radioName == 'T000800003'){
						$("#SRVC_AGR_DTL_YN").val(chkVal);
					}else if(radioName == 'T000800015'){
						$("#THIRD_AGR_DTL_YN").val(chkVal);
					}
					
					setTimeout(function() {
		                myScroll.refresh();
		            }, 100);
	        	});
        	}
        });
       
        
        $(".radio-area").find(".ctm-radio").find("input").each(function(){
        	var inputId = $(this).attr("id");
        	if((inputId == "T000800001_2_1") || (inputId == "T000800002_2_1") || (inputId == "T000800015_2_1")){
        		if(($("#CRDT_AGR_DTL_YN").val() == '' || $("#CRDT_AGR_DTL_YN").val() == "N")
        		|| ($("#PROD_AGR_DTL_YN").val() == '' || $("#PROD_AGR_DTL_YN").val() == "N")
        		|| ($("#THIRD_AGR_DTL_YN").val() == '' || $("#THIRD_AGR_DTL_YN").val() == "N")){
        			$(this).parent().addClass("radio r-on");
            		$(this).addClass("r-on");
            		$(this).attr("checked","checked");
            		$("#CRDT_AGR_DTL_YN").val("N");
            		$("#PROD_AGR_DTL_YN").val("N");
            		if($("#THIRD_AGR_DTL_YN").val() == ''){
            			$("#THIRD_AGR_DTL_YN").val("");
            		}else if($("#THIRD_AGR_DTL_YN").val() == "N"){
            			$("#THIRD_AGR_DTL_YN").val("N");
            		}
            		
        		}
        		
        	}else{
        		$(this).parent().addClass("radio");
        	}
        	
        });
        
    }
    
    //선택약관 전체선택관련 20210623
    if ($('#agreementChallLayer:visible').length == 1) {
        var ctsTotal = $('#agreementChallLayer .con').length;
        var idx = $('#agreementChallLayer .con').index();

        $('#agreementChallLayer .con').hide();
        $('#agreementChallLayer .con').eq(idx - 1).show();

        $('.all-agree .total').html(ctsTotal);
        $('.all-agree .view').html(idx);

        if($("img[name=barImg]").css("width") =="500px"){
	   		 $("img[name=barImg]").css("width","280");
	   		 $("img[name=barImg]").css("float","left");
	   		 $("img[name=qrImg]").before("<br>");
   	 	}
        
        $('.ctrl-box button').click(function() {
            if ($(this).hasClass('btn-next')) {
                if (idx < ctsTotal) {
                    idx++;
                    $('.all-agree .view').html(idx);
                    $('#agreementChallLayer .con').hide();
                    $('#agreementChallLayer .con').eq(idx - 1).show();
                }
            } else {
                if (idx > 1) {
                    idx--;
                    $('.all-agree .view').html(idx);
                    $('#agreementChallLayer .con').hide();
                    $('#agreementChallLayer .con').eq(idx - 1).show();
                }
            }
            idx = idx;
        });
        
		if($("#CRDT_AGR_DTL_YN").val() == ''){
			$("#CRDT_AGR_DTL_YN").val("N");
		}
		if($("#PROD_AGR_DTL_YN").val() == ''){
			$("#PROD_AGR_DTL_YN").val("N");
		}
		if($("#SRVC_AGR_DTL_YN").val() == ''){
			$("#SRVC_AGR_DTL_YN").val("N");
		}
		
		
        $(".radio-area").find(".ctm-radio").click(function() {
        	var cls = $(this).find("input").attr("name");
        	 var radioNm ;
        	 var radioId_1 ;
        	 var radioId_2 ;
        	 var chkVal ;
        	// var codeI;
        	$("input:radio[name="+cls+"]").click(function() {
        		var radioId = $(this).attr("id");
        		var radioName = radioId.substring(0,10);
        		radioNm = radioName+"_1_1";
    			radioId_1 = radioName+"_2_1";
    			radioId_2 = radioName+"_2_2";
    			
        		if($("#"+radioId_1+"").is(':checked')){
        			
        		}else{
        			$("#"+radioId_1+" ").parent().parent().removeClass("r-on");
					$("#"+radioId_2+" ").parent().parent().addClass("r-on");
					$("#"+radioId_1+" ").attr("checked","");
					$("#"+radioId_2+" ").attr("checked","checked");
					$("."+radioName+"_2"+"").css("display","block");
					$("."+radioName+"_1"+"").css("display","none");
    				
        		}
        		chkVal = $("input:radio[name='"+radioNm+"']:checked").val();
				if(radioName == 'T000800001'){
					$("#CRDT_AGR_DTL_YN").val(chkVal);
				}else if(radioName == 'T000800002'){
					$("#PROD_AGR_DTL_YN").val(chkVal);
				}else if(radioName == 'T000800003'){
					$("#SRVC_AGR_DTL_YN").val(chkVal);
				}
				setTimeout(function() {
	                myScroll.refresh();
	            }, 100);
        	});
        });
        
        $(".radio-area").find(".ctm-radio").find("input").each(function(){
        	var inputId = $(this).attr("id");
        	if(inputId == "T000800003_2_1"){
        		if($("#SRVC_AGR_DTL_YN").val() == '' || $("#SRVC_AGR_DTL_YN").val() == "N"){
        			$(this).parent().addClass("radio r-on");
            		$(this).addClass("r-on");
            		$(this).attr("checked","checked");
            		$("#SRVC_AGR_DTL_YN").val("N");
        		}
        		
        	}else{
        		$(this).parent().addClass("radio");
        	}
        	
        });
    }

    
    //2021.09.14 가계대출상품설명서 개별팝업 열었을 경우
    if ($('#productdetail-layer:visible').length == 1 || $('#retailDetail-layer:visible').length == 1) {
    	var checks;
    	if($('#productdetail-layer:visible').length == 1){
    		checks = $('#productdetail-layer').find('.pop-cts').find('.question-list');
    	}else{
    		checks = $('#retailDetail-layer').find('.pop-cts').find('.question-list');
    		pop_prd_name = $('#prod_nm').val();
    		
    		//20211015 리테일 상품설명서 내용수정
			if($("#prod_cd").val() == "GL091"){
				$('#' + popNum).find('.pop-cts').find("#rate_mothod").text("□ 변동 ■ 고정 □ 혼합");
				$('#' + popNum).find('.pop-cts').find("#repay_mothod").text("□만기일시 □원금균등 ■원리금균등");
			}else{
				$('#' + popNum).find('.pop-cts').find("#rate_mothod").text("■ 변동 □ 고정 □ 혼합");
				$('#' + popNum).find('.pop-cts').find("#repay_mothod").text("■만기일시 □원금균등 □원리금균등");
			}
			
    	}
    	
    	$('#' + popNum).find('.pop-cts').find('#pop_prd_name').text(pop_prd_name);	//상품개요 및 특성의 상품명 설정
    	
    	$(checks).find('li').each(function(index){	//hidden값으로 모두동의하기에서 체크한거 자세히보기에서 체크 한것과 동일하게 체크(반대의 경우도 확인)
    		$(this).find('label').addClass('radio');	//label에 .radio 설정
    		if($('#RADIO_CHECK_YN'+(index+1)).val() == "Y"){
    			$(this).find('input:radio[value="Y"]').parent().addClass("r-on");
    			$(this).find('input:radio[value="Y"]').attr("checked",true);
    			$(this).find('input:radio[value="N"]').parent().removeClass("r-on");
    		}else if($('#RADIO_CHECK_YN'+(index+1)).val() == "N"){
    			$(this).find('input:radio[value="N"]').parent().addClass("r-on");
    			$(this).find('input:radio[value="N"]').attr("checked",true);
    			$(this).find('input:radio[value="Y"]').parent().removeClass("r-on");
    		}
    	});
    	$(checks).find('li').each(function(index){
    		$(this).find('.radio-area').find('label').click(function(){	//radio박스 제어
    			var clickIndex = $(this).parent().parent().parent().index();
    			var radioId = $(this).find('input:radio').attr('id');
    			if(parseInt(radioId.substr(radioId.length-1,1)) % 2 == 1){	//예
    				$(this).find('input:radio[value="Y"]').parent().addClass("r-on");
    				$(this).find('input:radio[value="Y"]').addClass("r-on");
    				$(this).find('input:radio[value="Y"]').attr("checked","checked");
    				$(this).find('input:radio[value="N"]').attr("checked",false);
    				$(this).parent().parent().find('input:radio[value="N"]').parent().removeClass("r-on" );
    			}else{
    				$(this).find('input:radio[value="N"]').parent().addClass("r-on");
    				$(this).find('input:radio[value="N"]').addClass("r-on");
    				$(this).find('input:radio[value="N"]').attr("checked",true);
    				$(this).find('input:radio[value="Y"]').attr("checked",false);
    				$(this).parent().parent().find('input:radio[value="Y"]').parent().removeClass("r-on");
    			}
    			$('#RADIO_CHECK_YN' + (clickIndex+1)).val($(this).parent().parent().find('input:radio:checked').val());
    		});
    	});
    	
    	var date = new Date();
    	$('#productdetail-layer').find('.pop-cts').find("#pop_customer_confirmation_date").empty();
    	$('#productdetail-layer').find('.pop-cts').find("#pop_customer_confirmation_date").text("고객확인 : " + date.getFullYear() + "년 " + (date.getMonth()+1) + "월 " + date.getDate() + "일 (서명/인)");
    }	
    
    /* 레이어팝업이 중복으로 뜰때 */
    if ( $('.layerpopup:visible').length > 1 ) {
    	$('.block:nth(0)').css('z-index',30);
    }
}
//block
function addBlock(_full) {
  //$('html').css('overflow','hidden');
    if(_full =='full'){
        $('body').append('<div class="block"></div>').css({'height': $('document').outerHeight,'position':'absolute'});
        //$('body, html').scrollTop(0);
    }else{
        $('body').append('<div class="block"></div>')
        //$('body').append('<div class="block"></div>').css({'height': $(window).height, 'overflow': 'hidden'});
        //$('body, html, #wrap').css({'overflow': 'hidden','height': winH2});
    }
    $('.block').fadeIn(300);

    $('.block').on('click', function() {
     /* 알림팝업창 일때*/
    	if ( $('.layerpopup:visible').hasClass('alert-layer') == 0 && _full != 'removeEvent') {
	    	if ($('.block').length > 0) {
    			$('.block').fadeOut(300).empty().remove();
    			$('.layerpopup').fadeOut(300).scrollTop(0);
    			$('.layerpopup2').fadeOut(300).scrollTop(0);
	        }
	    	$('body, html, #wrap').css({'height': '', 'overflow': ''});
//	        $('body, html, #wrap').css({'height': '', 'overflow': ''});
	        if ( $(this).hasClass('menu-open') ){
	        	$('.menu-close').click();
	        }
	    }
    	$('body').css({'height': '', 'overflow': ''});
    });
    $('.close').on('click', function() {
        $('.block').trigger('click');
    });
}
function deleteBlock(){
	$('.block').fadeOut(300);
	$('.block').detach();
	$('body, html, #wrap').css({'height':'','overflow':''});
}
//popup
function openPopup(id, isNext) {
    var _target = $('#' + id);
    _target.fadeIn(300);
    layerFunc(_target, isNext);
    _target.focus();
    _target.find('.btn-menu-close, .tooltip-close').on('click', function() {
        closePopup(id);

	     /* 레이어팝업이 중복으로 뜰때 */
	     if ( $('.layerpopup:visible').length > 1 ) {
	    	$(this).parent('.layerpopup').hide();
	    	$('.layerpopup').css('z-index',20)
	    	addBlock();
	    }

    });
}
function closePopup(id) {
    deleteBlock();
    $('#' + id).fadeOut(300).scrollTop(0);
    deleteBlock();
}

jQuery(function($) {
    /* Checkbox  */
    var checkBox = $('.ctm-check');
    var addClassCheckBox = function($input) {
        if ($input.prop('checked')) {
            $input.parent().addClass('checked');
        } else {
            $input.parent().removeClass('checked');
        }
    };
    checkBox.on('change', 'input', function() {
        addClassCheckBox($(this));
    });
});

//radio, checkbox custom style
function setupLabel() {
	if ($('.check > input').length) {
        $('.check').each(function(){
			$(this).removeClass('c-on');
		});
		$('.check > input').each(function(){
            //$(this).prop('disabled',true);
            if ($(this).is(':checked')){
        		$(this).parent('label').addClass('c-on');
            }else{
                $(this).parent('label').removeClass('c-on');
            }
		});
	};
	if ($('.radio input').length) {
		if ($('.radio input').length) {
	    	 $('.radio').each(function() {
            	if(!$(this).parent().parent().parent().parent().parent().hasClass('question-list')){
            		$(this).removeClass('r-on'); //페이지 열리자마자 r-on이 없어져버려서 기본체크표시가 안됨
            	}
	         });
	         $('.radio input:checked').each(function() {
	        	 $(this).parent().addClass('r-on');
	             if ($(this).parent().hasClass('focus')) {
	                 $(this).parent().siblings('.radio').removeClass('r-on');
	                 $(this).parent().addClass('r-on');

	             }
	         });

	     }
	};
}
/* selectbox */
jQuery.fn.extend({
    selectbox: function(options) {
        return this.each(function() {
            new jQuery.SelectBox(this, options);
        });
    }
});

/* pawel maziarz: work around for ie logging */
if (!window.console) {
    var console = {
        log: function(msg) {}
    }
}

$(document).ready(function() {
	$("body").on("click",".check",function(e){
        if($(this).find('input').is(':checked')){
            //$(this).find('input').prop("checked", false);
        }else{
            //$(this).find('input').prop("checked", true);
        }
        setupLabel();
	});
    $("body").on("click",".radio",function(e){
        setupLabel();
	});
	setupLabel();
});
jQuery.SelectBox = function(selectobj, options) {

	var opt = options || {};
	opt.inputType = opt.inputType || "input";
	opt.inputClass = opt.inputClass || "selectbox";
	opt.containerClass = opt.containerClass || "selectbox-wrapper";
	opt.hoverClass = opt.hoverClass || "current";
	opt.currentClass = opt.currentClass || "selected";
	opt.groupClass = opt.groupClass || "groupname"; //css class for group
	//opt.maxHeight = opt.maxHeight || 200; // max height of dropdown list
	opt.loopnoStep = opt.loopnoStep || false; // to remove the step in list moves loop
	opt.onChangeCallback = opt.onChangeCallback || false;
	opt.onChangeParams = opt.onChangeParams || false;
	opt.debug = opt.debug || false;
	opt.selectColor = opt.selectColor || "#000"; //css class for group

	var elm_id = selectobj.id;
	var active = 0;
	var inFocus = false;
	var hasfocus = 0;
	var hasfocusContainer = -1;
	//jquery object for select element
	var $select = jQuery(selectobj);
	// jquery container object
	var $container = setupContainer(opt);
	//jquery input object
	var $input = setupInput(opt);
	// hide select and append newly created elements
	$select.hide().before($input).before($container);
	var defaultColor = $input.css('color');
	init();

	$input
	.click(function(){
		if (!inFocus) {
			$container.toggle();
		}
	})
	.focus(function(){
		if( hasfocus > 0 && hasfocusContainer > 0){
			hasfocusContainer = -1;
			setTimeout(function(){ $input.blur(); }, 300);
		}
		else if ($container.not(':visible')) {
			inFocus = true;
			$container.show();
		}
	})
	.keydown(function(event) {
		switch(event.keyCode) {
			case 38: // up
				event.preventDefault();
				moveSelect(-1);
				break;
			case 40: // down
				event.preventDefault();
				moveSelect(1);
				break;
			case 9:  // tab
				hideMe();
				break;
			case 13: // return
				event.preventDefault(); // seems not working in mac !
				$('li.'+opt.hoverClass).trigger('click');
				break;
			case 27: //escape
			  hideMe();
			  break;
		}
	})
	.blur(function(e) {
		if ($container.is(':visible') && hasfocusContainer > 0 ) {
			$input.focus();
		} else {
			hasfocusContainer = -1;
			hideMe();
		}
	});

	$container.on({
		mouseenter : function(){
			hasfocusContainer = 1;
		},
		mouseleave : function(){
			hasfocusContainer = -1;
		}
	});

	function hideMe() {
		hasfocus = 0;
		$container.hide();
	}

	function init() {
		$container.append(getSelectOptions($input.attr('id'))).hide();
		//var width = $input.css('width');
		//var width = $input.outerWidth()-2;
		var width = $input.outerWidth()-2;
		if($container.height() > opt.maxHeight){
			//$container.width(parseInt(width)+parseInt($input.css('paddingRight'))+parseInt($input.css('paddingLeft')));
			$container.width(width);
			$container.height(opt.maxHeight);
		} else $container.width(width);
	}

	function setupContainer(options) {
		var container = document.createElement("div");
		$container = jQuery(container);
		$container.attr('id', elm_id+'_container');
		$container.addClass(options.containerClass);
			$container.css('display', 'none');
		return $container;
	}

	function setupInput(options) {
		if(opt.inputType == "span"){
			var input = document.createElement("span");
			var $input = jQuery(input);
			$input.attr("id", elm_id+"_input");
			$input.addClass(options.inputClass);
			$input.attr("tabIndex", $select.attr("tabindex"));
		} else {
			var input = document.createElement("input");
			var $input = jQuery(input);
			$input.attr("id", elm_id+"_input");
			$input.attr("type", "text");
			$input.addClass(options.inputClass);
			$input.attr("autocomplete", "off");
			$input.attr("readonly", "readonly");
			$input.attr("tabIndex", $select.attr("tabindex")); // "I" capital is important for ie
			$input.css("width", $select.parent().outerWidth()-2);
			//$input.css("width", $select.outerWidth()-2);
			}
		return $input;
	}

	function moveSelect(step) {
		var lis = jQuery("li", $container);
		if (!lis || lis.length == 0) return false;
		// find the first non-group (first option)
		firstchoice = 0;
		while($(lis[firstchoice]).hasClass(opt.groupClass)) firstchoice++;
		active += step;
			// if we are on a group step one more time
			if($(lis[active]).hasClass(opt.groupClass)) active += step;
		//loop through list from the first possible option
		if (active < firstchoice) {
			(opt.loopnoStep ? active = lis.size()-1 : active = lis.size() );
		} else if (opt.loopnoStep && active > lis.size()-1) {
			active = firstchoice;
		} else if (active > lis.size()) {
			active = firstchoice;
		}
			scroll(lis, active);
		lis.removeClass(opt.hoverClass);

		jQuery(lis[active]).addClass(opt.hoverClass);
	}

	function scroll(list, active) {
			var el = jQuery(list[active]).get(0);
			var list = $container.get(0);

		if (el.offsetTop + el.offsetHeight > list.scrollTop + list.clientHeight) {
			list.scrollTop = el.offsetTop + el.offsetHeight - list.clientHeight;
		} else if(el.offsetTop < list.scrollTop) {
			list.scrollTop = el.offsetTop;
		}
	}

	function setCurrent() {
		var li = jQuery("li."+opt.currentClass, $container).get(0);
		var ar = (''+li.id).split('_');
		var el = ar[ar.length-1];
		if (opt.onChangeCallback){
				$select.get(0).selectedIndex = $('li', $container).index(li);
				opt.onChangeParams = { selectedVal : $select.val() };
			opt.onChangeCallback(opt.onChangeParams);
		} else {
			$select.val(el);
			$select.change();
		}
		//console.log($select.get(0).selectedIndex);
		if($select.get(0).selectedIndex!=0)$input.css('color',opt.selectColor);
		else $input.css('color',defaultColor)
		if(opt.inputType == 'span') $input.html($(li).text());
		else $input.val($(li).text());
		return true;
	}

	// select value
	function getCurrentSelected() {
		return $select.val();
	}

	// input value
	function getCurrentValue() {
		return $input.val();
	}

	function getSelectOptions(parentid) {
		var select_options = new Array();
		var ul = document.createElement('ul');
		select_options = $select.children('option');
		if(select_options.length == 0) {
			var select_optgroups = new Array();
			select_optgroups = $select.children('optgroup');
			for(x=0;x<select_optgroups.length;x++){
				select_options = $("#"+select_optgroups[x].id).children('option');
				var li = document.createElement('li');
				li.setAttribute('id', parentid + '_' + $(this).val());
				li.innerHTML = $("#"+select_optgroups[x].id).attr('label');
				li.className = opt.groupClass;
				ul.appendChild(li);
				select_options.each(function() {
					var li = document.createElement('li');
					li.setAttribute('id', parentid + '_' + $(this).val());
					li.innerHTML = $(this).html();
					if ($(this).is(':selected')) {
						$input.html($(this).html());
						$(li).addClass(opt.currentClass);
					}
					ul.appendChild(li);
					$(li)
					.mouseover(function(event) {
						hasfocus = 1;
						if (opt.debug) console.log('over on : '+this.id);
						jQuery(event.target, $container).addClass(opt.hoverClass);
					})
					.mouseout(function(event) {
						hasfocus = -1;
						if (opt.debug) console.log('out on : '+this.id);
						jQuery(event.target, $container).removeClass(opt.hoverClass);
					})
					.click(function(event) {
						var fl = $('li.'+opt.hoverClass, $container).get(0);
						if (opt.debug) console.log('click on :'+this.id);
						$('li.'+opt.currentClass, $container).removeClass(opt.currentClass);
						$(this).addClass(opt.currentClass);
						setCurrent();
						$select.get(0).blur();
						hideMe();
					});
				});
			}
		} else select_options.each(function() {
			var li = document.createElement('li');
			li.setAttribute('id', parentid + '_' + $(this).val());
			li.innerHTML = $(this).html();
			if ($(this).is(':selected')) {
				$input.val($(this).text());
				$(li).addClass(opt.currentClass);
			}
			ul.appendChild(li);
			$(li)
			.mouseover(function(event) {
				hasfocus = 1;
				if (opt.debug) console.log('over on : '+this.id);
				jQuery(event.target, $container).addClass(opt.hoverClass);
			})
			.mouseout(function(event) {
				hasfocus = -1;
				if (opt.debug) console.log('out on : '+this.id);
				jQuery(event.target, $container).removeClass(opt.hoverClass);
			})
			.click(function(event) {
			  	var fl = $('li.'+opt.hoverClass, $container).get(0);
				if (opt.debug) console.log('click on :'+this.id);
				$('li.'+opt.currentClass, $container).removeClass(opt.currentClass);
				$(this).addClass(opt.currentClass);
				setCurrent();
				$select.get(0).blur();
				hideMe();
			});
		});
		return ul;
	}
};

// select 삭제  function
function selClear(selId){
	$(selId+"_input").remove();
	$(selId + '_container').remove();
}

//font Control
function fontPlus(){
	$('*').each(function(){
		var _fontSize = parseInt($(this).css('font-size'))*1.1;
		//console.log(_fontSize);
		$(this).css({'font-size':_fontSize+"px"});
	});
}
function fontMinus(){
	$('*').each(function(){
		var _fontSize = parseInt($(this).css('font-size'))/1.1;
		//console.log(_fontSize);
		$(this).css({'font-size':_fontSize+"px"});
	});
}

/**
* 중앙정렬 위치
* @param containerSize : 컨테이너의 크기
* @param targetSize : 컨테이너에 들어 있는 오브젝트의 크기
* @return
*/
function getCenterAlignPos( containerSize, targetSize ) {
  var pos = ( containerSize - targetSize ) / 2;
  return pos;
}

/**
 * 해당 포인트를 기준으로 중간에 걸칠경우
 * @param centerPos : 기준선
 * @param targetSize : 오브젝트의 크기
 * @return
 *
 */
function getCenterPos( centerPos, targetSize ) {
  var pos = centerPos - ( targetSize / 2 );
  return pos;
}

/**
 * 랜덤값 간단하게 뽑아오기
 * @param min : 가장 적은값
 * @param max  : 가장 높은값
 * @return
 *
 */
function getRandom( min, max ){
	return Math.floor(Math.random()*(max-min))+min;
}


/**
 * 브라우저 종류 알기
 * if(getBrowser.name == "msie") { ... }
 *
 */
var getBrowser = (function() {
  var s = navigator.userAgent.toLowerCase();

  var match = /(webkit)[ \/](\w.]+)/.exec(s) ||
              /(opera)(?:.*version)?[ \/](\w.]+)/.exec(s) ||
			  /(trident)(?:.*rv:([\w.]+))?/.exec(s) ||
			  /(msie) ([\w.]+)/.exec(s)||
              /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) ||
             [];
  return { name: match[1] || "", version: match[2] || "0" };
}());

/**
 * PC 인지 모바일인지 판단하기
 * return true : pc
 * return false : mobile
 *
 */
var isPc = (function() {
	var filter = "win16|win32|win64|mac";
	var isPc = true;

	if( navigator.platform  ){
		if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
		//("모바일 기기에서 접속");
			return false;
		}else{
		//("PC에서 접속");
			return true;
		}
	}
});



/**
 * Input
 *
 */
$(document).ready(function() {
  var placeholderTarget = $('.input-box input[type="text"], .input-box input[type="password"]');

  //포커스시
  placeholderTarget.on('focus', function(){
    $(this).siblings('label').fadeOut('fast');
	$(this).siblings('span.fade').fadeOut('fast');
  });

  //포커스아웃시
  placeholderTarget.on('focusout', function(){
    if($(this).val() == ''){
      $(this).siblings('label').fadeIn('fast');
	  $(this).siblings('span.fade').fadeIn('fast');
    }
  });
});

/**
 * customAlert
 * @param _option.title : 제목
 * @param _option.message : 내용
 * @param _option.type : confirm or anything
 * @param _callback1 : 확인버튼
 * @param _callback1 : 취소버튼
 * @return
 *
 */
function customAlert(_option,_callback1,_callback2){
    var _html = "";
    _html += "<div id=\"customAlertLayer\" class=\"layerpopup alert-layer\">";
    _html +=  "<div class='layer-con'>"
    _html +=    "<p class=\"tit\">"+_option.title+"</p>";
    _html +=    "<p class=\"font14\">"+_option.message+"</p>";
    _html +=    "<div class=\"btn-wrap mt25\">";
    _html +=      "<button type=\"button\" name=\"button\" class=\"btn-normal form c-confirm\">확인</button>";
    if(_option.type == "confirm")_html +=     "<button type=\"button\" name=\"button\" class=\"btn-normal form c-cancle\">취소</button>";
    _html +=    "</div>";
    _html +=   "</div>";
    _html += "</div>";
    $('body').append(_html.replace(/(\n|\r\n)/g, '<br>'));
    //addBlock("fixed");
    layerFunc($('#customAlertLayer'));
    $('#customAlertLayer').show();
    $('.c-confirm').on('click',function(){
    	customAlertDel();
      if (typeof _callback1 === "function") {
      	_callback1();
      }
    });
    $('.c-cancle').on('click',function(){
    	customAlertDel();
	    if (typeof _callback2 === "function") {
	      _callback2();
	    }
    });

    /* 레이어팝업이 중복으로 뜰때 */
    if ( $('.layerpopup:visible').length > 1 ) {
      $('.block:nth(0)').css('z-index',30);
    }

    function customAlertDel(){
        deleteBlock();
        if ( $('.layerpopup:visible').length > 1 ){
            addBlock();
        } else {
          deleteBlock();
        }
        $('#customAlertLayer').fadeOut().empty().remove();
    }
}

function addLoading(_num){
    var _html = "";
    _html += "<div id=\"loadingLayer\" class=\"loading-layer\">";
    _html += "</div>";
    $('body').append(_html);
    if(_num == 2){
        $("#loadingLayer").addClass('type2');
    }
    $("#loadingLayer").animateSprite({
        fps: 5,
        loop: true,
        complete: function(){

        }
    });
    //$('html').addClass('scroll-y');
    layerFunc($('#loadingLayer'));
}
function removeLoading(){
    $('#loadingLayer').fadeOut().empty().remove();
    //$('html').removeClass('scroll-y');
    deleteBlock();
}

//roll
jQuery(function(){
	var rollover = {
		newimage: function(src) {
			return src.substring(0, src.search(/(\.[a-z]+)$/)) + '_on' + src.match(/(\.[a-z]+)$/)[0];
		},
		oldimage: function(src) {
			return src.replace(/_on\./, '.');
		},
		init: function() {
			$('.roll').hover(
			function() {
				$(this).attr('src', rollover.newimage($(this).attr('src')));
			}, function() {
				$(this).attr('src', rollover.oldimage($(this).attr('src')));
			});
		}
	};
	rollover.init();
});
//숫자 콤마
function addComma(data_value) {
	return Number(data_value).toLocaleString('en').split(".")[0];
}
function removeComma(data_value) {  // 콤마제거
    if ( typeof data_value == "undefined" || data_value == null || data_value == "" ) {
        return "";
    }
    var txtNumber = '' + data_value;
	var replaceNum = txtNumber.replace(/(,)/g, "")
    return parseInt(replaceNum);
}
