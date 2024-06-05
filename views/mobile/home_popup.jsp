<%@ page contentType="text/html;charset=UTF-8" language="java" %>

	<script>
	
	var PageFuncPopup = ({
		
		init : function(data) {
			
			$(document).on('click', '#btn_close', function(e) {
				closePopup("popupLayer");
				$("#popup_btn").hide();
		    });
			
			$("#popupLayer .notipop-wrap ul").empty();
			
			for(var i=0; i<data.length; i++) {
				
				if(data[i].LINK || data[i].LINK.trim()) {
					var url="";
					if("Y" === data[i].NEWW_YN) {
						url = "window.open('"+data[i].LINK+"', '_blank')";
					} else {
						url = "location.replace('"+data[i].LINK+"')";
					}
				}
				
				if(!data[i].ATTACH_SEQ) {
					if(url!=""){
						$("#popupLayer .notipop-wrap ul").append($('<li onclick="javascript:'+url+'">'+data[i].CONTENTS+'</li>'));	
					}else{
						$("#popupLayer .notipop-wrap ul").append($('<li>'+data[i].CONTENTS+'</li>'));
					}
					
				}else{
					$("#popupLayer .notipop-wrap ul").append($('<li><a href="'+data[i].LINK+'" title="'+data[i].TITLE+'"><img src="/${dsrId}/attach/'+data[i].ATTACH_SEQ+'" alt=""></a></li>'));
				}
				
			}
			
			openPopup("popupLayer");
			var tempHeight = $("#popupLayer").height();
			var temp = ($(window).height() - tempHeight)/2 - 15;
			if(temp <0 ){
				$(".noti-layer").css("top",0);
				$("#popup_btn").css("top",300)
				$("#popup_btn").css("width",$("#popupLayer").width());
			}else{
				$(".noti-layer").css("top",temp);
				$("#popup_btn").css("top",temp+300)
				$("#popup_btn").css("width",$("#popupLayer").width());
			}
			
			$('.notipop-wrap ul').bxSlider({
				speed: 500,
				auto: true,
				pager: true,
				controls: false,
				autoControls: true,
				touchEnabled: true,
				oneToOneTouch: false,
				//autoHover: true,
				keyboardEnabled: true
			});
			$("#popupLayer").find(".bx-has-pager").css("position","fixed");
 			if(data.length<2){
 				$("#popupLayer").find(".bx-has-pager").css("display","none");
 			}else{
 				if(temp <0 ){
 					$("#popupLayer").find(".bx-has-pager").css("top",278)
 				}else{
 					$("#popupLayer").find(".bx-has-pager").css("top",temp+278)
 				}
 			}
			
			
			$("#popup_btn").show();
			var obj = $("#popupLayer").offset();
            $("#popup_btn").css("left",obj.left);
		},
	});
	
	</script>

    <!-- ********** Include ********** -->
    <!-- s: 레이어팝업 -->
    <div id="popupLayer" class="layerpopup_noti noti-layer" tabindex="0" data-focus="noti-layer" data-focus-prev="btn-menu-close" style="height:300;z-index:100;">
        <div class="pop-wrap" style="height:300px;">
            <!-- s:con -->
            <div class="pop-cts">
                <div class="notipop-wrap" style="padding:10px 13px 0px 13px;">
                    <ul>
                    </ul>
                </div>
            </div>
            <!-- //e:con -->
        </div>
    </div>
    <div class="btn-wrap" id="popup_btn" style="position:fixed;z-index:100;">
        <button type="button" name="button" class="noti-cookie tooltip-close" onclick="PageFunc.setCookie('popupList');" >오늘하루열지않음</button>
        <button type="button" name="button" id="btn_close" class="tooltip-close">닫기</button>
    </div>
    <!-- //e:레이어팝업 -->
    <!-- ********** //Include ********** -->

