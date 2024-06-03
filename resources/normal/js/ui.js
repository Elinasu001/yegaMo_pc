var depth1, depth2;
$(document).ready(function(){
    //윈도우 맥 lineheight 처리
    if(getOS() != "Mac OS"){        
        $(".cts-box .box-info [class*='accent']").css({"line-height":"36px"});
    }
    tooltip();
    accessibilityFocus();
    //슬라이더 버튼
    $('.money-btn-wrap button').on('click', function(e) {
        var _plusVal = parseFloat($(this).attr('data'));
        var _plusGubun = $(this).attr('gubun');
        var _selector = $(this).parent().siblings('.input-wrap').find('input');
        var _max = parseFloat($(this).parent().siblings('.slider-wrap').find('.slider').attr('max'));
        //console.log(_max);
        if ($(this).hasClass('dark')) {
            _selector.val(0).trigger("change");
        } else {
            if (_plusGubun == "2") {
                if (removeComma(_selector.val()) + _plusVal >= _max) {
                    _selector.val(addComma(_max)).trigger("change");
                } else {
                    _selector.val(addComma(removeComma(_selector.val()) + _plusVal)).trigger("change");
                }
            } else {
                _selector.val(_plusVal).trigger("change");
            }
        }
    });
    // header / based on sitemapWrap
    var globalNav = {
        init: function() {
            if (typeof depth1 != "undefined" && depth1 > -1 && typeof depth1 != "string") this.currentOneDepthNum = depth1-1;
            if (typeof depth1 != "undefined" && depth1 > -1) this.currentTwoDepthNum = depth2-1;
            this.setLayout();
        },
        setLayout: function() {
            var _self = this;
            if (typeof depth1 != "undefined" && depth1 > -1) {
                if (typeof depth2 != "undefined" && depth2 > -1) {
                    this.setText(this.currentOneDepthNum, this.currentTwoDepthNum);
                    this.activePage(this.currentOneDepthNum);
                }
            }else if (typeof depth1 == "string"){
                _txt = depth1;
                this.setText(_txt, 0, this.currentExpDepthNum);
                //this.activePage(-1);
            }
            this.addEvent();
        },
        setText:function(_oneDepth,_twoDepth) {
            var _self = this;
            var depth1Txt;
            if(typeof _oneDepth == "string"){
                depth1Txt = _oneDepth;
            }else{
                depth1Txt = $('#sitemapWrap h3').eq(_oneDepth).text();
            }
            if (_twoDepth != undefined && _twoDepth != -1) { //// 2depth가 있을 경우
                var depth2Txt = $('#sitemapWrap .all-menu-col:eq("'+_oneDepth+'") .all-depth2 > li:eq("'+_twoDepth+'") > a').text().replace('- ','');
            }else{
                var depth2Txt = '';
            }
            _self.setTitle(depth1Txt, depth2Txt);
            _self.setBreadcrumb(_oneDepth, depth1Txt, _twoDepth, depth2Txt);
        },
        setTitle:function(_depth1Txt,_depth2Txt, _depthExpTxt) {
            var _titleData = '';
            //if ( _depthExpTxt != '') { _titleData += _depthExpTxt + ' &lt; '; } //예외depth(depthExp)가 있는 경우
            if ( _depth2Txt != '') {
                _titleData += _depth2Txt + ' &lt; '+_depth1Txt + ' &lt; ';
            }else{
                _titleData += _depth1Txt + ' &lt; ';
            }
            try {
			   //new browsers
			   $('title').html(_titleData+'예가람저축은행');
			} catch (e) {
			   //IE8
			  document.title = _titleData+'예가람저축은행';
			}
        },
        setBreadcrumb:function(_oneDepth,_depth1Txt, _twoDepth,_depth2Txt){
            $('.breadcrumb .depth1').empty().text(_depth1Txt);
            if(typeof _oneDepth == "string"){
                $('.breadcrumb .depth1').attr('href',$(location).attr('href'));
            }else{
                $('.breadcrumb .depth1').attr('href',$("#sitemapWrap .all-menu-col:eq("+_oneDepth+") h3 a").attr('href'));
            }
            var _leng = $('#sitemapWrap .all-menu-col:eq("'+_oneDepth+'") ul').length;
            if (_twoDepth != undefined && _twoDepth != -1 && _leng > 0) { //// 2depth가 있을 경우
                var depth2Link = $('#sitemapWrap .all-menu-col:eq("'+_oneDepth+'") li:eq("'+_twoDepth+'") > a').attr('href');
                $('.breadcrumb .depth2').empty().text(_depth2Txt);
                $('.breadcrumb .depth2').attr('href',depth2Link);
            }else{
                $('.breadcrumb .depth2').empty().remove();
            }
        },
        activePage:function(_oneDepth) {
            // console.log(_oneDepth);
        	if(typeof _oneDepth != 'undefined'){
        		$('#gnb .depth1').eq(_oneDepth).find('a').addClass('active');
        	}
        },
        addEvent:function(){
            var _self = this;
            var prevEnterDepthIdx;
            var gnbH;
            $('#headerWrap #gnb').on('mouseleave',function(e){
                $('#headerWrap #gnb li a').removeClass('active');
                $('.depth2-wrap').hide();
                //console.log(_self.currentOneDepthNum);
                _self.activePage(_self.currentOneDepthNum);
            });
            $('.depth1 > a').on('mouseenter focusin',function(){
                var idx = $('.depth1 > a').index($(this));
                gnbH = 55 + $(this).siblings('.depth2-wrap').innerHeight();
                $('#gnb').innerHeight(gnbH);
                if (idx < 4) {
                    if (prevEnterDepthIdx != idx) {
                        //$('.depth1 > a').removeClass('active');
                        $('.depth2-wrap').hide();
                    }
                    //$(this).addClass('active');
                    $(this).siblings('.depth2-wrap').show();
                    prevEnterDepthIdx = idx;
                }else{
					$('.depth1 > a').removeClass('active');
					$('.depth1 > div').slideUp('fast');
				}
            }).on('mouseleave focusout', function(){
                //$('.depth1 > a').removeClass('active');
                $('#gnb').innerHeight('auto');
                $(this).siblings('.depth2-wrap').on('mouseenter focusin',function(){
                	$(this).siblings('a').addClass('active');
                }).on('mouseleave',function(){
                    $(this).siblings('a').removeClass('active');
                    $(this).hide();
                });
            });
        }
    };
    globalNav.init();
    //  sitemap
    $('.btn-sitemap').on('click',function(){
        //addBlock();
    });
    $('#sitemapWrap .btn-menu-close').on('click',function(){
        //deleteBlock();
    });
    $('#sitemapWrap .btn-menu-close').on('focusin', function(){
        isFinal = true;
    }).on('focusout', function(){
        isFinal = false;
    });
    var isFinal = false;
    $('body').keydown(function (e) {
        if (e.keyCode == 9) {
            if(isFinal){
                e.preventDefault();
                $('.all-layer').focus();
            }
        }
    });
    var iconBox = $('.icon-box-wrap');
    if (iconBox.length > 0 ) {
        iconBox.each(function(){
            var iconBoxlength = $(this).find('> div').length;
            $(this).find('>div').css('width', parseInt(100/iconBoxlength)+'%');
        });
    }
    // select
    var select = $("select");
    if($("select").length > 0){
        $("select").each(function(){
            var select_name = $(this).children("option:selected").text();
    	    $(this).siblings("p").text(select_name);
        });
    }
	select.change(function(){
        var select_name = $(this).children("option:selected").text();
	    $(this).siblings("p").text(select_name);
	});
    // accordion
	var currentFullNum = -1;
    var isOpen = false;
	$('.accordion li .question-wrap').click(function(e) {
	    e.preventDefault();
	    var num = $('.accordion li').index($(this).parent());
	    $('.accordion li').removeClass('active');
	    if (currentFullNum == num) {
            if (isOpen) {
                $('.accordion > li').removeClass('active');
                isOpen = false;
                $(this).next('.answer-wrap').slideUp('fast');
            } else {
                $('.accordion > li').eq(num).addClass('active');
                isOpen = true;
                $(this).next('.answer-wrap').slideDown('fast');
            }
	    }else {
            $('.accordion > li').not(':eq(' + num + ')').removeClass('active');
            $('.answer-wrap').slideUp('fast');
            $('.accordion > li').eq(num).addClass('active');
            $(this).next('.answer-wrap').slideDown('fast');
            isOpen = true;
	    }
	    currentFullNum = num;
	});
    //unit-txt의 유무 판단하여 unit-txt의 위치와 input padding setting
    $('input').each(function(index){
        if($(this).siblings('.unit-txt').length){
            //var _top = $(this).position().top;
            var _paddingRight = $(this).siblings('.unit-txt').outerWidth();
            //$(this).siblings('.unit-txt').css('top',_top);
            $(this).css('padding-right',_paddingRight);
        }
    });
    //main tabs
    $('.vertical-tab li button').on('click',function(e){
        var _index = $(this).parent().index();
        $('.vertical-tab li').removeClass('active');
        $(this).parent().addClass('active');
        $('.vertical-tab-content .con-wrap').hide();
        $('.vertical-tab-content .con-wrap').eq(_index).show();
        selectWidth();


    });

    //check/radio focus
    $('.check, .radio').on('focusin',function(){
        $(this).addClass('focus');
    });
    $('.check, .radio').on('focusout',function(){
        $(this).removeClass('focus');
    });

  //선택약관 전체선택관련 20210623
    var itemsIdAry=['T000800003','T000800011','T000800014','T000800013','T000800016','T000800017', 'T000800022'];
    var topAry = ['T000800025', 'N000805001', 'N000804001'];
    //약관전체동의
    $('.subcheck-area').hide();
    $('.subcheck-area1').hide();
    $('#all-check').on('click',function(){
        if ( $('#all-check').prop('checked') ){
           /* $('.agree-wrap dd > .check input').prop('checked', true);
            $('.agree-wrap dd > .check').addClass('c-on');

            //sub동의
            $('.subcheck-area').show();
            $('.subcheck-area .check input').prop('checked', true);*/
            
        	//선택약관 제외 20210623
            $('.agree-wrap dd >.check  input').each(function(){
            	var inputId = $(this).attr('id');
            	var itemsId;
            	if(inputId != null){
            		itemsId = $(this).parent().parent().attr("id");
            	}
            	
            	if(itemsIdAry.indexOf(itemsId) == -1 && topAry.indexOf(itemsId) == -1){
            		$("#"+itemsId+"").find('.check').addClass("c-on");
            		$("#"+itemsId+"").find('.check input').prop("checked", true);
            		$("#"+itemsId+"").find('.btn-normal.tiny').addClass('done');
            		//sub동의
            		/*$(".add_class2").show();
            		$(".add_class2").find('.check input').parent().addClass("checked");
            		$(".add_class2").find('.check input').prop('checked', true);*/
            	}
            	
            });
            
        } else {
            //$('.agree-wrap dd > .check input').prop('checked', false);
            //$('.agree-wrap dd > .check').removeClass('c-on');

            //sub동의
            //$('.subcheck-area').hide();
            //$('.subcheck-area .check input').prop('checked', false);
        	
        	//선택약관 제외 20210623
        	$('.agree-wrap dd >.check  input').each(function(){
            	var inputId = $(this).attr('id');
            	var itemsId;
            	if(inputId != null){
            		itemsId = $(this).parent().parent().attr("id");
            	}
	            if(itemsIdAry.indexOf(itemsId) == -1){
	        		$("#"+itemsId+"").find('.check').removeClass("c-on");
	        		$("#"+itemsId+"").find('.check input').prop("checked", false);
	        		$("#"+itemsId+"").find('.btn-normal.tiny').removeClass('done');
	        		//sub동의
	        		$(".add_class2").find('.check input').parent().removeClass("checked");
	        		$(".add_class2").find('.check input').prop('checked', false);
	        		$(".add_class2").hide();
	        	}
        	 });
        }
    });
    
    $('#all-ch-check').on('click',function(){
        if ( $('#all-ch-check').prop('checked') ){
        	//선택약관 제외 20210623
            $('.agree-wrap dd >.check  input').each(function(){
            	var inputId = $(this).attr('id');
            	var itemsId;
            	if(inputId != null){
            		itemsId = $(this).parent().parent().attr("id");
            	}
            	
            	if(itemsIdAry.indexOf(itemsId) != -1){
            		$("#"+itemsId+"").find('.check').addClass("c-on");
            		$("#"+itemsId+"").find('.check input').prop("checked", true);
            		$("#"+itemsId+"").find('.btn-normal.tiny').addClass('done');
            		//sub동의
            		$(".add_class1").show();
            		$(".add_class1").find('.check input').parent().addClass("checked");
            		$(".add_class1").find('.check input').prop('checked', true);
            		$(".add_class3").show();
            		$(".add_class3").find('.check input').parent().addClass("checked");
            		$(".add_class3").find('.check input').prop('checked', true);
            		$(".add_class4").show();
            		$(".add_class4").find('.check input').parent().addClass("checked");
            		$(".add_class4").find('.check input').prop('checked', true);
            		$(".add_class5").show();
            		$(".add_class5").find('.check input').parent().addClass("checked");
            		$(".add_class5").find('.check input').prop('checked', true);
            	}
            	
            });
            
        } else {
        	//선택약관 제외 20210623
        	$('.agree-wrap dd >.check  input').each(function(){
            	var inputId = $(this).attr('id');
            	var itemsId;
            	if(inputId != null){
            		itemsId = $(this).parent().parent().attr("id");
            	}
	            if(itemsIdAry.indexOf(itemsId) != -1){
	        		$("#"+itemsId+"").find('.check').removeClass("c-on");
	        		$("#"+itemsId+"").find('.check input').prop("checked", false);
	        		$("#"+itemsId+"").find('.btn-normal.tiny').removeClass('done');
	        		//sub동의
	        		$(".add_class1").find('.check input').parent().removeClass("checked");
	        		$(".add_class1").find('.check input').prop('checked', false);
	        		$(".add_class1").hide();
	        		$(".add_class3").find('.check input').parent().removeClass("checked");
	        		$(".add_class3").find('.check input').prop('checked', false);
	        		$(".add_class3").hide();
	        		$(".add_class4").find('.check input').parent().removeClass("checked");
	        		$(".add_class4").find('.check input').prop('checked', false);
            		$(".add_class4").hide();
            		$(".add_class5").find('.check input').parent().removeClass("checked");
	        		$(".add_class5").find('.check input').prop('checked', false);
	        		$(".add_class5").hide();
	        	}
        	 });
        }
    });
    
    
   $('.agree-wrap dd > .check').on('change',function(){
        var allcnt = 0; //$('.agree-wrap dd > .check input').length;
        var chkcnt = 0;//$('.agree-wrap dd > .check input:checked').length;
        var chAllCnt = 0;
        var chChkcnt = 0;
        
        $('.agree-wrap dd').each(function(){
        	var itemsId = $(this).attr('id');
        	if($("#"+itemsId+"").is(":visible")){
        		
        		if(itemsIdAry.indexOf(itemsId) == -1){ //선택약관 제외 20210623
        			allcnt++;
        			if($("#"+itemsId+"").find('.check input').prop('checked')){
        				chkcnt++;
        			}
        		}else{
        			chAllCnt++;
        			if($("#"+itemsId+"").find('.check input').prop('checked')){
        				chChkcnt++;
        			}
        		}
        	}
        });
        
        
        if ( allcnt == chkcnt ) {
            $('#all-check').prop('checked', true);
            $('.agree-wrap dt > .check').addClass('c-on');
        } else {
            $('#all-check').prop('checked', false);
            $('.agree-wrap dt > .check').removeClass('c-on');
        }
        
        if (chAllCnt == chChkcnt) { //선택약관 전체선택 20210623
            $('#all-ch-check').prop('checked', true);
            $('#all-ch-check').parent().addClass("c-on");
        } else {
            $('#all-ch-check').prop('checked', false);
            $('#all-ch-check').parent().removeClass("c-on");
        }
        
        //sub동의
        if ( $(this).find('input').is(':checked') ) {
        	if($(this).find("input").attr("id")=="productdetail" || $(this).find("input").attr("id")=="retaildetail"){
        		/*$('.add_class2').find('input:checkbox:first').prop('checked',true);
                $('.add_class2').find('.check').addClass('c-on');
                $('.add_class2').show();*/
        		$('.add_class2').show();
                $('.add_class2').find('input').each(function( index, element ){
					var perClass;
                	if($(this).is(":visible")){
                		var perClass = $(this).parent().attr("Class");
                		if(perClass =='check'){
                			$(this).parent().addClass('c-on');
                			$(this).attr("checked","checked");
    						$(this).attr("disabled","disabled");
                		}
					}
				});
            }else if($(this).find("input").attr("id")=="agree-check5"){
            	$('.add_class1').find('input').prop('checked',true);
                $('.add_class1').find('label').addClass('c-on');
                $('.add_class1').show();
            }else if($(this).find("input").attr("id")=="agree-check16"){
            	$('.add_class3').find('input').prop('checked',true);
                $('.add_class3').find('label').addClass('c-on');
                $('.add_class3').show();
            }else if($(this).find("input").attr("id")=="agree-check17"){
            	$('.add_class4').find('input').prop('checked',true);
                $('.add_class4').find('label').addClass('c-on');
                $('.add_class4').show();
            }else if($(this).find("input").attr("id")=="agree-check14"){
            	$('.add_class5').find('input').prop('checked',true);
                $('.add_class5').find('label').addClass('c-on');
                $('.add_class5').show();
            }
        } else {
        	if($(this).find("input").attr("id")=="productdetail" || $(this).find("input").attr("id")=="retaildetail"){
        		/*$('.add_class2').hide();
                $('.add_class2').find('input:checkbox:first').prop('checked',false);
                $('.add_class2').find('.check').removeClass('c-on');*/
        		
        		$('.add_class2').hide();
        	}else if($(this).find("input").attr("id")=="agree-check5"){
        		$('.add_class1').hide();
                $('.add_class1').find('input').prop('checked',false);
                $('.add_class1').find('label').removeClass('c-on');
        	}else if($(this).find("input").attr("id")=="agree-check16"){
        		$('.add_class3').hide();
                $('.add_class3').find('input').prop('checked',false);
                $('.add_class3').find('label').removeClass('c-on');
        	}else if($(this).find("input").attr("id")=="agree-check17"){
        		$('.add_class4').hide();
                $('.add_class4').find('input').prop('checked',false);
                $('.add_class4').find('label').removeClass('c-on');
        	}else if($(this).find("input").attr("id")=="agree-check14"){
        		$('.add_class5').hide();
                $('.add_class5').find('input').prop('checked',false);
                $('.add_class5').find('label').removeClass('c-on');
        	}
           
        }
    });

    $('.agree-wrap .check').on('change',function(){
        if ( $(this).siblings('button').length != 0){

            if ( $(this).find('input').is(':checked') ) {
                $(this).siblings('button').trigger('click');
            }
        }
    });

    $('.subcheck-area').each(function(){
        $(this).on('change',function(){
            var subchk = $(this).find('input').length;
            var subchked = $(this).find('input:checked').length;
            var subtit = $(this).find('.check-tit input').length;
            var subtitChked = $(this).find('.check-tit input:checked').length;
            if ( subtitChked == 0 ){
                $(this).siblings('.check').find('input').prop('checked', false);
                $(this).siblings('.check').removeClass('c-on');
                
                var chAllCnt = 0;
                var chChkcnt = 0;
                
                $('.agree-wrap dd').each(function(){
                	var itemsId = $(this).attr('id');
                	if($("#"+itemsId+"").is(":visible")){
                		
                		if(itemsIdAry.indexOf(itemsId) == -1){ //선택약관 제외 20210623
                			
                		}else{
                			chAllCnt++;
                			if($("#"+itemsId+"").find('.check input').prop('checked')){
                				chChkcnt++;
                			}
                		}
                	}
                });
                if (chAllCnt == chChkcnt) { //선택약관 전체선택 20210623
                    $('#all-ch-check').prop('checked', true);
                    $('#all-ch-check').parent().addClass("c-on");
                } else {
                    $('#all-ch-check').prop('checked', false);
                    $('#all-ch-check').parent().removeClass("c-on");
                }
            } else {
                $(this).siblings('.check').find('input').prop('checked', true);
                $(this).siblings('.check').addClass('c-on');
            }
            if ( subchked != 0){
                $(this).siblings('.check').find('input').prop('checked', true);
                $(this).siblings('.check').addClass('c-on');
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });

    $('.sub-box').each(function(){
        $(this).find('.check-tit').on('change',function(){
            if ( $(this).find('input').is(':checked') ){
                $(this).siblings('.sub-check').find('input').prop('checked', true);
                $(this).siblings('.sub-check').find('.check').addClass('c-on');
            } else {
            	if($(this).parent().parent().hasClass('add_class5')){
            		$(".add_class5").find('.check input').parent().removeClass("checked");
	        		$(".add_class5").find('.check input').prop('checked', false);
            		$(".add_class5").hide();
            	}else{
            		$(this).siblings('.sub-check').find('input').prop('checked', false);
            		$(this).siblings('.sub-check').find('.check').removeClass('c-on');
            	}
            }

        });
        $(this).find('.sub-check').on('change',function(){
            var subChk = $(this).find('input').length;
            var subChked = $(this).find('input:checked').length;
            if ( subChked == 0 ){
                //if ( $(this).siblings('.check-tit').hasClass('subbox-all') ){
                    $(this).siblings('.check-tit').find('input').prop('checked', false);
                    $(this).siblings('.check-tit').find('.check').removeClass('c-on');
               // }
            }else {
                $(this).siblings('.check-tit').find('input').prop('checked', true);
                $(this).siblings('.check-tit').find('.check').addClass('c-on');

            }
        });
        $(this).find('.subcheck-all').on('change',function(){
            if ( $(this).find('input').is(':checked') ){
                $(this).siblings('.type').find('input').prop('checked', true);
                $(this).siblings('.type').find('.check').addClass('c-on');
            } else {
                $(this).siblings('.type').find('input').prop('checked', false);
                $(this).siblings('.type').find('.check').removeClass('c-on');
            }

        });
        $(this).find('.type').on('change',function(){
            var type = $(this).find('input').length;
            var typeChked = $(this).find('input:checked').length;
            if ( typeChked == 0 || type > typeChked){
                $(this).siblings('.subcheck-all').find('input').prop('checked', false);
                $(this).siblings('.subcheck-all').find('.check').removeClass('c-on');
            } else if ( type == typeChked ){
                $(this).siblings('.subcheck-all').find('input').prop('checked', true);
                $(this).siblings('.subcheck-all').find('.check').addClass('c-on');
            }
        });

    });

    //top버튼 위치
    if ( $(window).width() < 1340 ) {
        $('.btn-top').css({'right':'50%','margin-right':'-620px'});
    }

    //select-box color
    $('select').selectmenu({
        change:function(event,ui){
            if ( $(this).val() != ''){
                $(this).siblings('.ui-selectmenu-button').addClass('in-value');
            } else {
                $(this).siblings('.ui-selectmenu-button').removeClass('in-value');
            }
        }
    });

    // $(document).on('change','select',function(e){
    //     console.log(111);
    //     var selectedIndex = $(this).find('option:selected').index();
    //     if ( selectedIndex != 0 ){
    //         $(this).siblings('.selectbox').css('color','#000');
    //     }else {
    //         $(this).siblings('.selectbox').css('color','#888')
    //     }
    // });

    btnTop();
    if ( winH2 < $('body').outerHeight() ){
        $('.btn-top').hide();
    }


    var layerH = winH2 - 110;
    $('.layerpopup').css('max-height',layerH);
    $('#dutyViewer').css('height', (layerH-150));
    $('.subcheck-area1').each(function(){
    	 $(this).find("label").on('click',function(){
    		 
    		 var $this = $(this).find("input");
    		 var chkName = $this.attr("name");
    		 if($this.prop("checked")){
    			 if(chkName =="agree-check16"){
    				 $('.add_class3').hide();
                     $('.add_class3').find('input').prop('checked',false);
                     $('.add_class3').find('label').removeClass('c-on');
                     $("#agree-check16").prop('checked',false);
                     $("#agree-check16").parent().removeClass('c-on');
    			 }else{
    				 $('.add_class4').hide();
                     $('.add_class4').find('input').prop('checked',false);
                     $('.add_class4').find('label').removeClass('c-on');
                     $("#agree-check17").prop('checked',false);
                     $("#agree-check17").parent().removeClass('c-on');
    			 }
                 
                 var chAllCnt = 0;
                 var chChkcnt = 0;
                 
                 $('.agree-wrap dd').each(function(){
                 	var itemsId = $(this).attr('id');
                 	if($("#"+itemsId+"").is(":visible")){
                 		
                 		if(itemsIdAry.indexOf(itemsId) != -1){ //선택약관 제외 20210623
                 			chAllCnt++;
                 			if($("#"+itemsId+"").find('.check input').prop('checked')){
                 				chChkcnt++;
                 			}
                 		}
                 	}
                 });
                 
                 if (chAllCnt == chChkcnt) { //선택약관 전체선택 20210623
                     $('#all-ch-check').prop('checked', true);
                     $('#all-ch-check').parent().addClass("c-on");
                 } else {
                     $('#all-ch-check').prop('checked', false);
                     $('#all-ch-check').parent().removeClass("c-on");
                 }
    	      }
    	 });
    	 
    });
    
});

function openWinPopup(url){
    window.open(url,"",'scrollbars=yes,toolbar=no,location=no,resizable=no,status=no,menubar=no,resizable=no,width=948,height=700,left=474,top=0,fullscreen');
}
function goFamilySite() {
    var url = $('#family-site option:selected').attr('value');
    if(url == '')
        return false;

    window.open(url);
}
$(window).resize(function(){
	layerHeight();
});
$(window).load(function(){
    //bg animation
    if(typeof TweenMax != "undefined"){
        var radius = 10;
        TweenMax.staggerFromTo('.bg-blob', 4 ,{
        	cycle: {
        		attr:function(i) {
        			var r = i*90;
        			return {
        				transform:'rotate('+r+') translate('+radius+',0.1) rotate('+(-r)+')'
        			}
        		}
        	}
        },{
        	cycle: {
        		attr:function(i) {
        			var r = i*90+360;
        			return {
        				transform:'rotate('+r+') translate('+radius+',0.1) rotate('+(-r)+')'
        			}
        		}
        	},
        	ease:Linear.easeNone,
        	repeat:-1
        });
    }
    //bg position
    /*$('.bg2').each(function(){
        var _height = $('body').outerHeight()-551;
        $(this).css('top',_height);
    });*/

    btnTop();

});

$(window).scroll(function(){
    btnTop();
});

function selectWidth(){
    $('.select-wrap').each(function(){
        var selectW = $(this).outerWidth();
        var selectList = $(this).find('.selectbox,.selectbox-wrapper')
        selectList.css('width', selectW);
    });
}

function btnTop(){
    //btn-top
    if ( $(window).scrollTop() == 0) {
        $('.btn-top').hide();
    } else {
        $('.btn-top').fadeIn(300);
    }
}

function layerHeight(){
	var layerH = $(window).height() - 110;
	$('.layerpopup').css('max-height',layerH);
}
