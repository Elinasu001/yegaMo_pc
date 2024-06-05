<%@ page contentType="text/html;charset=UTF-8" language="java" %>

	<script>
			
		var accordionHegiht=0;
		var PageFuncNotice = ({
		
			myScroll2:null,scrollTimer:null,isNotiOpen:null,
// 			accordionHegiht=0,
			
			notiScroll : function (qIndex){
				setTimeout(function(){ 
					accordionHegiht = $("#notiLayer .accordion-wrap .accordion").height();
					if(accordionHegiht>$("#notiLayer .accordion-wrap").height()){
		                if(typeof myScroll2 == "undefined"){
		                    scrollTimer = setTimeout(function(){
		                        myScroll2 = new IScroll('#notiLayer .accordion-wrap', {
		                            scrollbars: true,
		                            mouseWheel: true,
		                            disableMouse: true,
		                            interactiveScrollbars: true,
		                            preventDefault: false,
		                            bounce: false
		                        });
		                        if(qIndex>1){
		                        	myScroll2.scrollTo(0, -((40*qIndex)-40));
		                        }else {
		                        	myScroll2.scrollTo(0, -(40*qIndex));
		                        }
		                        //$('.accordion li').removeClass('noti-top');
		                        //$('.accordion li:nth-child('+qIndex+')').addClass('noti-top');
		                        //myScroll2.scrollToElement(document.querySelector('.noti-top'),0);
		                    },10);
		                }else{
		                	setTimeout(function(){ myScroll2.refresh()},10);
		                }
		            }else{
		            	if(typeof scrollTimer != "undefined"){
		            		clearTimeout(scrollTimer);
		            	}
		                if(typeof myScroll2 != "undefined"){
		                    //if($('.iScrollIndicator').position().top > 0){$('.accordion').css('top',0);}
		                    myScroll2.scrollTo(0,0);
		                    myScroll2.destroy();
		                    myScroll2 = undefined;
		                }
		            }
				},200);
	        },
			
			printNotiLayer : function(data) {
				
				//console.log("printNotiLayer : "+JSON.stringify(data1));
				
				//초기화!!
				$("#notiLayer .accordion-wrap .accordion").empty();
				
				if(0 === data.length) return;
				 
				for(var i=0; i<data.length; i++) {
					if(i==0){
						data.boardCnt = 1;
						data.startSeq = 1;
					}
					
					var litag = $('<li></li>');
					var atag = null;
					
					if(0 ===i) {
						
						atag = $('<a href="#" class="question-wrap" data-focus-prev="btn-menu-close"><span class="category">!</span><span class="con">'+data[i].TITLE+'</span></a>');
					} else {
						
						atag = $('<a href="#" class="question-wrap" ><span class="category">!</span><span class="con">'+data[i].TITLE+'</span></a>');
					}
					
					litag.append(atag);
					
					if(data[i].LINK || data[i].LINK.trim()) {
						
	                   if("Y" === data[i].NEWW_YN) {
	                        var url = "window.open('"+data[i].LINK+"', '_blank')";
	                    } else {
	                        var url = "location.replace('"+data[i].LINK+"')";
	                    }
	                    litag.append($('<div class="answer-wrap"><a href="#"><div class="con" onclick="javascript:'+url+'">'+data[i].CONTENTS+'</div></a></div>'));		
					} else {
						
						litag.append($('<div class="answer-wrap"><a href="#"><div class="con">'+data[i].CONTENTS+'</div></a></div>'));       
					}
				
				
					$("#notiLayer .accordion-wrap .accordion").append(litag);
					
				}
				
				$('#close_layer').click(function() {
					closePopup("notiLayer");
		        });
				//페이징 처리
				PageFuncNotice.setPageNumber(data);
				
// 				$('.noti-layer li').eq(0).find('a').click();
			},
			
		     //페이징 표시
		     setActiveClass : function( currPage     //현재 페이지 번호
		                                  , numPages     //전체 페이징 처리 수
		                                  ) {
		    	
		    	 $("#paging_div > .pagination > ul").empty();

		         var start = 0
		         var end = 0
		    	 
		    	 if(11 >currPage) {
		    		 start = 1;
		    		 end = 10;
		    		 end = end*1 < numPages ? end*1 : numPages;
		    	 } else {
		    		 start = (currPage -1)+"";
		    		 start = start.substr(0, start.length -1)+"1";
		    		 end = (start.substr(0, start.length -1)*1+1)+"0";
		    		 start = start*1;
		    		 end = end*1 < numPages ? end*1 : numPages;
		    	 }

		         
		         for(var pageNum = start;pageNum <= end;pageNum++) {
		             //var pageNum = i + 1;
		             var lit = document.createElement("li");
					if(pageNum === currPage) {
						
						lit.innerHTML = '<a href="#" onclick="PageFuncNotice.selectNoticeList('+pageNum+')" class="btn-circle nb active">'+pageNum+'</a>';
					} else {
						
						lit.innerHTML = '<a href="#" onclick="PageFuncNotice.selectNoticeList('+pageNum+')" class="btn-circle nb">'+pageNum+'</a>';
					}
					
					$("#paging_div > .pagination > ul").append(lit);
		         };
		    	 
		     },			
				
			setPageNumber : function(data) {
				
				//초기화!!
				$("#paging_div").empty();
				
				if(data.length*1 > 1) {
					
					var paging_div = document.getElementById("paging_div");
					
					var child_div = document.createElement('div');
					child_div.className = 'pagination';
					
					var beforePage = (data.startSeq*1-1) > 1 ? (data.startSeq*1-1) : 1;
					if(1 !== data.startSeq*1) {
						
						var a1 = document.createElement('a');
						a1.className = 'btn-circle prev nb ir';
						
						a1.href = "javascript:PageFuncNotice.selectNoticeList("+beforePage+")";
						a1.innerText = "이전";
						child_div.appendChild(a1);
					}
					
					var ul = document.createElement('ul');
					
					child_div.appendChild(ul);
					
					var nextPage = (data.startSeq*1+1) >= data.boardCnt ? data.boardCnt : (data.startSeq*1+1);
					if(data.startSeq*1 !== data.boardCnt*1) {
						
						var a2 = document.createElement('a');
						a2.className = 'btn-circle next nb ir';
						a2.href = "#";
						
						a2.href = "javascript:PageFuncNotice.selectNoticeList("+nextPage+")";
						a2.innerText = "다음";
						child_div.appendChild(a2);
					}
					
					paging_div.appendChild(child_div);
						
					setTimeout(function(){
						
						PageFuncNotice.setActiveClass(data.startSeq*1, data.boardCnt*1);
					},100);
				
				}
				
				$('#notiLayer').css('top',getCenterAlignPos($(window).height(),$('#notiLayer').height()));
                
                
	            $(document).on('click','#notiLayer .question-wrap',function(){
	                qIndex = $(this).parent().index();
	                PageFuncNotice.notiScroll(qIndex);
// 	                $('#notiLayer .accordion-wrap li').each(function(index){
	                	
// 	                    $(this).hasClass('active')
// 	                    if($(this).hasClass('active')){
// 	                    	console.log(index + " : " + $(this).hasClass('active') + " : " + qIndex)
// 	                        isNotiOpen = false;
// 	                        PageFuncNotice.notiScroll(qIndex);
// 	                        return false;
// 	                    }else{
// 	                    	console.log(index + " : " + $(this).hasClass('active') + " : " + qIndex)
// 	                        isNotiOpen = true;
// 	                        PageFuncNotice.notiScroll(qIndex);
// 	                    }
// 	                });
	            });
                
                $('#notiLayer > .pop-wrap > .btn-wrap > .tooltip-close').on('click', function() {
                    
                    if($('input:checkbox[id="notiLayerCheck"]').is(':checked')) {
//                      PageFunc.setCookie('notiLayer');
                    	setCookie('notiLayer');
                    }
                    
                });
                
                openPopup("notiLayer");
                PageFuncNotice.notiScroll(0);
			},
			
			selectNoticeList : function(startSeq) {
				
				var param = {
					"startSeq" : startSeq ? startSeq : 1
				};
				
				AjaxFunc.ajaxAsyncWithProcess(
						'/home/notice_list'
						, param
					    , function(data1) {
							
				             if(data1.success) {
				                    
				            	 PageFuncNotice.printNotiLayer(data1.data);
			                } else {
			                	
			                    customAlert({title : "알림" , message : data1.resultMessage });
			                }
				             
						}
					    , function(e) {
					    	
					        customAlert({title : "알림" , message : e });
					    }
				);
			},
			
		});
		
		
		
		
	</script>

    <!-- s:공지사항 레이어팝업 -->
   
    <div id="notiLayer" class="layerpopup noti-layer small" tabindex="0" data-focus="noti-layer" data-focus-prev="btn-menu-close" style="padding:0 0 0 0 !important;">
        <div class="pop-wrap">
	        <div class="pop-tit">
	            <div class="tit">공지사항</div>
	        </div>
	        <div class="accordion-wrap" style="padding:10px 0px 10px 0px !important;">
	            <ul class="accordion">

	            </ul>
	        </div>
	        <div id="paging_div" class="pagination-wrap" style="display:none;">
	        </div>
            <div class="btn-wrap" style="height:60px !important;">
                    <p class="noti-cookie">
						<!--s:20180813 pm checkbox 레이아웃 변경 -->
						<label class="check"l for="notiLayerCheck">
							<input type="checkbox" name="check" id="notiLayerCheck" value="">
							하루동안 보지 않기
						</label>
						<!--//e:20180813 pm checkbox 레이아웃 변경 -->
                    </p>
                    
                    
                    <button type="button" name="button" class="btn-normal tooltip-close" id="close_layer">확인</button>
             </div>
	        
	        <!-- //e:con -->
	
	        <button type="button" name="button" class="btn-menu-close"  data-focus="btn-menu-close" data-focus-next="noti-layer">닫기</button>
        </div>
    </div>
    <!-- //e:공지사항 레이어팝업 -->

