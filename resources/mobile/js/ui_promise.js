var depth1, depth2;
$(document).ready(function(){
    tooltip();
    accessibilityFocus();
    // header / based on sitemapWrap
    var globalNav = {
        init: function() {
            if (typeof depth1 != "undefined" && depth1 < 100) this.currentOneDepthNum = depth1;
            if (typeof depth1 != "undefined" && depth1 < 100) this.currentTwoDepthNum = depth2;
            if (typeof depthExp != "undefined") this.currentExpDepthNum = depthExp;
            this.setLayout();
        },
        setLayout: function() {
            var _self = this;
            if (depth1 != 99 && typeof depth1 != "undefined" && depth1 < 100) {
                if (typeof depth2 != "undefined" && depth2 < 100) {
                    this.setText(this.currentOneDepthNum, this.currentTwoDepthNum, this.currentExpDepthNum);
                    this.activePage(this.currentOneDepthNum);
                }
            }
            this.addEvent();
        },
        setText:function(_oneDepth,_twoDepth, _expDepth) {
            var depthExpTxt;
            switch (_expDepth) {
                case 0 :
                    depthExpTxt = '';
                    break;
                default:
                    depthExpTxt = '';
            }
            var depth1Txt = $('#sitemapWrap h3').eq(_oneDepth).text();
            if (_twoDepth != undefined && _twoDepth != 99) { //// 2depth가 있을 경우
                var depth2Txt = $('#sitemapWrap .all-menu-col:eq("'+_oneDepth+'") .all-depth2 > li:eq("'+_twoDepth+'") > a').text().replace('- ','');
            }else{
                var depth2Txt = '';
            }
            globalNav.setTitle(depth1Txt, depth2Txt);
            globalNav.setBreadcrumb(_oneDepth, depth1Txt, _twoDepth, depth2Txt);
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
            $('.breadcrumb .depth1').attr('href',$("#sitemapWrap .all-menu-col:eq("+_oneDepth+") h3 a").attr('href'));
            var _leng = $('#sitemapWrap .all-menu-col:eq("'+_oneDepth+'") ul').length;
            if (_twoDepth != undefined && _twoDepth != 99 && _leng > 0) { //// 2depth가 있을 경우
                var depth2Link = $('#sitemapWrap .all-menu-col:eq("'+_oneDepth+'") li:eq("'+_twoDepth+'") > a').attr('href');
                $('.breadcrumb .depth2').empty().text(_depth2Txt);
                $('.breadcrumb .depth2').attr('href',depth2Link);
            }else{
                $('.breadcrumb .depth2').empty().remove();
            }
        },
        /*activePage:function(_oneDepth) {
            if(typeof _oneDepth != 'undefined'){
                $('#gnb .depth1').eq(_oneDepth).find('a').addClass('active');
            }
        },*/
        addEvent:function(){
            var _self = this;
            var prevEnterDepthIdx;
            var gnbH;
            /*$('#headerWrap #gnb').on('mouseleave',function(e){
                $('#headerWrap #gnb li a').removeClass('active');
                $('.depth2-wrap').hide();
                //console.log(_self.currentOneDepthNum);
                _self.activePage(_self.currentOneDepthNum);
            });*/
            $('.depth1 > a').on('click focusin',function(){
                var idx = $('.depth1 > a').index($(this));
                gnbH = 55 + $(this).siblings('.depth2-wrap').innerHeight();
                //$('#gnb').innerHeight(gnbH);
                if (idx < 4) {
                    if (prevEnterDepthIdx != idx) {
                        $('.depth1 > a').removeClass('active');
                        $('.depth2-wrap').hide();
                    }
                    $(this).addClass('active');
                    $(this).siblings('.depth2-wrap').show();
                    prevEnterDepthIdx = idx;
                }else{
                    $('.depth1 > a').removeClass('active');
                    $('.depth1 > div').slideUp('fast');
                }
            }).on('focusout', function(){
                $('.depth1 > a').removeClass('active');
                $(this).siblings('.depth2-wrap').on('click focusin',function(){
                    $(this).siblings('a').addClass('active');
                }).on('focusout',function(){
                    $(this).siblings('a').removeClass('active');
                    //$(this).hide();
                });
            });
        }
    };
    globalNav.init();
    // layerpopup
    $('.layerpopup').css('max-height',winH2-106);



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
            $('.accordion > li').eq(num).addClass('active');
            $('.answer-wrap').slideUp('fast');
            isOpen = true;
            $(this).next('.answer-wrap').slideDown('fast');
        }
        currentFullNum = num;
    });
    // menu open
    $('.btn-menu').on('click', function(){
        $('#wrap').addClass('open');
        addBlock();
        $('.block').addClass('menu-open');
        $('body').css('position','fixed');
    });
    // menu close
     $('.menu-close').on('click', function(){
        $('#wrap').removeClass('open');
        deleteBlock();
        $('body').css('position','');
    });
    //sub nav
    $('.depth2-wrap').parent('.depth1').addClass('insub');
    if ( $('.sub-menu').length > 0 ) {
        var mySwiper = new Swiper('.sub-menu.swiper-container', {
            slidesPerView: 'auto',
            slideToClickedSlide: true,
            spaceBetween: 15,
            freeMode: true
        });
        $('.swiper-slide').on('click',function(){
            $('.swiper-slide').removeClass('active');
            $(this).addClass('active');
        });
        $(window).load(function(){
            var _index=$('.swiper-slide.active').index();
            mySwiper.slideTo(_index,300,false);
        });

        $('#contentsWrap').css('padding-top',90);
    }

    //메인배너
    if ( $('.main-prod.swiper-container').length > 0 ) {
        var swiper = new Swiper('.main-prod.swiper-container', {
          centeredSlides: true,
          autoplay: {
            delay: 2500,
            disableOnInteraction: false,
          },
          pagination: {
            el: '.swiper-pagination',
            clickable: true,
          }
        });

        $('.prod-layer .tooltip-close').on('click',function(){
            $('.prod-layer').scrollTop(0);
            var banner = $('.main-prod');
            var bannerT = banner.offset().top;
            $('html, body').animate({scrollTop:bannerT},10);
        });
    }

    $('.agree-layer .tooltip-close').on('click',function(){
        $('.agree-layer').scrollTop(0);
    });


    //메인 간편 대출신청 버튼
    $(window).scroll(function(){
        var cts = parseInt($('.counselor-area').outerHeight() + $('.loan-apply').outerHeight());
        var btnApply = $('.btn-loan-apply');

        if ($(this).scrollTop() >= cts) {
            $('#wrap').css('padding-bottom',btnApply.height() + 'px');
            btnApply.fadeIn(200);
        } else {
            //$('body').css('padding-bottom',0);
            btnApply.fadeOut(200);
        }
    });

    //약관전체동의
    $('.subcheck-area').hide();
    $('#all-check').on('change',function(){
        if($(this).closest('.agree-parent').length > 0){
             if ( $('.agree-parent #all-check').prop('checked') ){
                 $('.agree-parent .agree-wrap dd > .check input').prop('checked', true);
                 $('.agree-parent .agree-wrap dd > .check').addClass('c-on');
             } else {
                 $('.agree-parent .agree-wrap dd > .check input').prop('checked', false);
                 $('.agree-parent .agree-wrap dd > .check').removeClass('c-on');
             }
            /*
            if ( $('.agree-parent #all-check').prop('checked') ){

                $('.agree-parent .agree-wrap dd > .check input').prop('checked', true);
                $('.agree-parent .agree-wrap dd > .check').addClass('c-on');

                //sub동의
                $('.agree-parent .subcheck-area').show();
                $('.agree-parent .subcheck-area .check input').prop('checked', true);
            } else {
                $('.agree-parent .agree-wrap dd > .check input').prop('checked', false);
                $('.agree-parent .agree-wrap dd > .check').removeClass('c-on');

                //sub동의
                $('.agree-parent .subcheck-area').hide();
                $('.agree-parent .subcheck-area .check input').prop('checked', false);
            }*/
        }else{
            if ( $('#all-check').prop('checked') ){
                $('.agree-wrap dd > .check input').prop('checked', true);
                $('.agree-wrap dd > .check').addClass('c-on');

                //sub동의
                $('.subcheck-area').show();
                $('.subcheck-area .check input').prop('checked', true);
            } else {
                $('.agree-wrap dd > .check input').prop('checked', false);
                $('.agree-wrap dd > .check').removeClass('c-on');

                //sub동의
                $('.subcheck-area').hide();
                $('.subcheck-area .check input').prop('checked', false);
            }
        }

    });
    $('.agree-wrap dd > .check').on('change',function(){
        var allcnt;
        var chkcnt;
        allcnt = $('.agree-wrap dd > .check input').length;
        chkcnt = $('.agree-wrap dd > .check input:checked').length;

        if($(this).closest('.agree-parent').length > 0){
            allcnt = $('.agree-parent .agree-wrap dd > .check:not(".promise") input').length;
            chkcnt = $('.agree-parent .agree-wrap dd > .check:not(".promise") input:checked').length;

            if ( allcnt == chkcnt ) {
                $('.promise #all-check').prop('checked', true);
                $('.agree-wrap .promise.check').addClass('c-on');
            } else {
                $('.promise #all-check').prop('checked', false);
                $('.agree-wrap .promise.check').removeClass('c-on');
            }
        }else{

            allcnt = $('.agree-wrap dd > .check input').length;
            chkcnt = $('.agree-wrap dd > .check input:checked').length;
            if ( allcnt == chkcnt ) {
                $('#all-check').prop('checked', true);
                $('.agree-wrap dt > .check').addClass('c-on');
            } else {
                $('#all-check').prop('checked', false);
                $('.agree-wrap dt > .check').removeClass('c-on');
            }
        }

        //sub동의
        if ( $(this).find('input').is(':checked') ) {
           $(this).siblings('.subcheck-area').find('input').prop('checked',true);
           $(this).siblings('.subcheck-area').find('label').addClass('c-on');
           $(this).siblings('.subcheck-area').show();

        } else {
           $(this).siblings('.subcheck-area').hide();
           $(this).siblings('.subcheck-area').find('input').prop('checked',false);
           $(this).siblings('.subcheck-area').find('label').removeClass('c-on');
        }
    });

    $('.agree-wrap .check').on('change',function(){
        if ( $(this).find('a').length != 0){
            if ( $(this).find('input').is(':checked') ) {
                $(this).find('a').trigger('click');
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
                $(this).siblings('.sub-check').find('input').prop('checked', false);
                $(this).siblings('.sub-check').find('.check').removeClass('c-on');
            }

        });
        $(this).find('.sub-check').on('change',function(){
            var subChk = $(this).find('input').length;
            var subChked = $(this).find('input:checked').length;
            if ( subChked == 0 ){
                if ( $(this).siblings('.check-tit').hasClass('subbox-all') ){
                    $(this).siblings('.check-tit').find('input').prop('checked', false);
                    $(this).siblings('.check-tit').find('.check').removeClass('c-on');
                }
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
    var firstRun = true;
    var allAgreeLayer = {
        init: function() {
            this.selector = $('.layerpopup.all-agree');
            this.currentNum = 0;
            this.totalNum = this.selector.length-1;
            this.setLayout();
        },
        setLayout: function(){
            var _self = this;
            if(firstRun){
                _self.selector.each(function(index){
                    $('.agreement-all-layer').append("<div class='layer-con'>"+$(this).find('.layer-con').html()+"</div>");
                });
            }
            firstRun = false;
            $('.agreement-all-layer .layer-con').hide();
            $('.agreement-all-layer .layer-con').eq(_self.currentNum).show().scrollTop(0);
            $('.agreement-all-layer .current-num').text(_self.currentNum+1);
            this.removeEvent();
            this.addEvent();
        },
        addEvent: function(){
            var _self = this;
            $('.agreement-all-layer .layer-con .tooltip-close').on('click',function(){
                $('.agreement-all-layer .controll-wrap .btn-menu-close').trigger('click');
            });
            $('.ctrl-box .btn-prev').on('click',function(){
                _self.pageFunc(0);
            });
            $('.ctrl-box .btn-next').on('click',function(){
                _self.pageFunc(1);
            });
        },
        removeEvent: function(){
            var _self = this;
            $('.agreement-all-layer .layer-con .tooltip-close').off('click');
            $('.ctrl-box .btn-prev').off('click');
            $('.ctrl-box .btn-next').off('click');
        },
        pageFunc: function(_num){
            var _self = this;
            if(_num == 0){
                if(_self.currentNum > 0){
                    _self.currentNum--;
                }
            }else if(_num == 1){
                if(_self.currentNum < _self.totalNum){
                    _self.currentNum++;
                }
            }
            $('.agreement-all-layer .layer-con').hide();
            $('.agreement-all-layer .layer-con').eq(_self.currentNum).show().scrollTop(0);
            $('.agreement-all-layer .current-num').text(_self.currentNum+1);
        }
    };
    $("body").on("OPEN_LAYER",function(event){
        if($('.agreement-all-layer').css('display') == "block"){
            allAgreeLayer.init();
        }
        if($('.layerpopup').css('display') == "block"){
            $('.layerpopup .layer-con').scrollTop(0);
        }
    });
      //back
      $('.btn-back').on('click',function(){
        event.preventDefault();
        window.history.go(-1);
      });

    //select-box color
    $(document).on('change','select',function(e){
        if ( $(this).val() !=   '' ){
            $(this).css('color','#000')
        }else {
            $(this).css('color','#888')
        }
    });


});

function openWinPopup(url){
    window.open(url,"",'scrollbars=yes,toolbar=no,location=no,resizable=no,status=no,menubar=no,resizable=no,width=948,height=700,left=474,top=0,fullscreen');
}
function goFamilySite() {
    var url = $('#family-site optionelected').attr('value');
    if(url == '')
        return false;

    window.open(url);
}

$(window).load(function(){
    //bg animation
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
});
