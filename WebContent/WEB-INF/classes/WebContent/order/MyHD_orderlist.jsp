<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">

<body>
	<div id="wrap">
		<script type="text/javascript">
	$(document).ready(function(){
		var currency = getCookie("currencyType");	
		/*$(".currencyType").html(currency);*/
		$(".currency").addClass(currency.toLowerCase());
		$(".currencyType").addClass(currency.toLowerCase());
		$(".currencyInfo > li").removeClass("is_selected");
		
		
		//loadGnbDispCtgJsonp(); //카테고리 JSON Data
		//오늘의 환율 조회
		$.ajax({
	        async       : true,
	        url        	   : "//www.hddfs.com/shop/cm/comm/lnbTodayExchr.json",
	        dataType   : "json",
	        type          : "POST",
	        success     : function(data, textStatus, jqXHR){
	            if(!crew.ajaxValidate(data)){ return; }
				var result = data.result;
				$(".exchageRateTxt").html("$1 = "+result.krw+" 원</em>");
				/* 
				if(getCookie("currencyNtnlCd") =="KR"){
					$(".exchageRateTxt").html("$1 = "+result.krw+" 원</em>");
				}else if(getCookie("currencyNtnlCd") =="CN"){
					$(".exchageRateTxt").html("$1 = "+result.cny.toFixed(2)+" 元</em>");
				}
				 */
	        },
	        error       : function(jqXHR, textStatus, errorThrown){
	            //console.log(jqXHR.status);
	        }
	    });
		
		$.ajax({
			async       : true,
	        url        	   : "//www.hddfs.com/shop/dm/mainLogo.json",
	        dataType   : "json",
	        type          : "POST",
	        success     : function(data, textStatus, jqXHR){
	            if(!crew.ajaxValidate(data)){ return; }
	            
					$("#mainLogo").attr("src","https://cdn.hddfs.com/files/"+data.mainLogo.dispEttList[0].dispEttDtlInfo.imgUrl);//+"?RS=192X40"
	        },
	        error       : function(jqXHR, textStatus, errorThrown){
	            //console.log(jqXHR.status);
	        }
	    });
		
	});
	
	//통화(화폐) 저장 
	function chgCurrencyInfo(type){
		//상품상세에서만 통화 변경 가능
		if(document.URL.indexOf('/gd/dtl/goos.do') > -1) {
			setCookie("currencyType",type);
		} else {
			setCookie("currencyType",type,1);		// 통화 정보 설정 쿠키(1일)
			setCookie("currencyNtnlCd",type.substring(0,2),1);		// 통화 국적
			alert("상품상세 화면에서만 통화변경을 확인하실 수 있습니다.");
		}
		window.location.reload();
	}
	
	$(window).load(function(){
		fnLnbCountInfo();
		orderStatusInfo();
		
	});
	
	
	function fnLnbCountInfo(){
        $.ajax({
            async       : true,
            url         : "//www.hddfs.com/shop/cm/comm/lnbInfo.json",
            dataType    : "json",
            type        : "POST",
            success     : function(data, textStatus, jqXHR){
                //if(!crew.ajaxValidate(data)){ return; }
                
                var result =  data.cartCnt;
            	if(result >= 99){
                    result = "99+";
                }
                
                if(data.cartCnt > 0){
                    $("#rwingCartCnt").html(result);
                    $("#rwingCartCnt").show();
                }else{
                    $("#rwingCartCnt").html("0");  //전체삭제시 장바구니 카운트가 초기화 되지 않아 장바구니 추가시 기존카운트에 추가됨.
                    $("#rwingCartCnt").hide();
                }
                
                
            },
            error       : function(jqXHR, textStatus, errorThrown){
                //console.log(jqXHR.status);
            }
        });    
    }
	
	
	
    function orderStatusInfo() {
    	if(isLogin){
            $.ajax({
                async       : true,
                url            : "//www.hddfs.com/shop/cm/comm/orderStatusInfo.json",
                dataType   : "json",
                type          : "POST",
                success     : function(data, textStatus, jqXHR){
                    if(!crew.ajaxValidate(data)){ return; }
                    
                    var result020 = typeof(data.orderStatInfo['020']) == "undefined" ? 0 : Number(data.orderStatInfo['020']);       //주문완료
                    var result030 = typeof(data.orderStatInfo['030']) == "undefined" ? 0 : Number(data.orderStatInfo['030']);       //상품준비중
                    var result040 = typeof(data.orderStatInfo['040']) == "undefined" ? 0 : Number(data.orderStatInfo['040']);       //상품이동중
                    var result050 = typeof(data.orderStatInfo['050']) == "undefined" ? 0 : Number(data.orderStatInfo['050']);       //인도대기
                    
                    var result = result020 + result030 + result040 +result050;

                    if(result >= 99){
                    	result = "99+";
                    }
                    $(".orderStatusTxt").html(result == null ? 0 : result);
                    
                    //관심 브랜드 처리
		            var interestList = data.interestBranList;
		            var interestListLength = $(".interestBranList > li").length;
		            if(interestList.length+interestListLength >20){
		            	for(var i=0; i< (interestList.length+interestListLength-20); i++){
		            		$(".interestBranList > li:last").remove();
		            	}
		            }

	            	var html="";
		            for(var i=0; i<interestList.length; i++){
		            	var onlnBranCd = interestList[i].onlnBranCd;
		            	if($(".interest"+onlnBranCd).length <1){
		            		html+="<li class=\"interest"+onlnBranCd+"\">";
		            		html+="<a rel=\"nosublink\" href=\"https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd="+onlnBranCd+"\">";
		            		html+="<p>"+interestList[i].branNm+"</p>";
		            		html+="<img src=\"https://cdn.hddfs.com/files/"+interestList[i].branReprImgUrl+"?sf=webp&RS=200x200\" alt=\"\" onerror=\"this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=200x200';\">";
		            		html+="</a>";
		            		html+="</li>";
		            	}
		            }
		            $(".interestBranList").prepend(html);
		            
		            if($(".interestBranList > li").length < 1){
		            	$(".interestBranList").parent().remove();
		            } 
                },
                error       : function(jqXHR, textStatus, errorThrown){
                    console.log(jqXHR.status);
                }
            }); 
        }else{
			if($(".interestBranList > li").length < 1){
            	$(".interestBranList").parent().remove();
            }
		}
    	 if($(".luxuryAreaList > li").length <1){						//럭셔리 없는 경우 항목삭제
 			$(".luxuryAreaList").parent().remove();
 		}
	}
	
	$(function(){
		$(".btn_gnb").on("click", function(){
			$("#gnb > ul > li").removeClass("open").css("display","");
			$("#gnb > ul > li > ul").css("display","none");
			$(".serviceMenu").parent().removeClass("open");
			$(".serviceMenu").parent().addClass("open");
			$(".serviceMenu").css("display","block");
			
			//카테고리 JSONP load
			if($(".serviceCtgList > li").length <1){
				loadCtgList();	
			}
		});
	});
	
	function goMainPage(){
		sessionStorage.setItem("selMainSwiperPos", 1); 
		location.href="https://www.hddfs.com/shop/dm/main.do";
	}
	
	
	// HDDFS 리뉴얼 프로젝트 [고영주] - 트래킹코드
	
</script>


		<!-- container -->
		<main id="container">
			<script type="text/javascript"
				src="https://cdn.hddfs.com/front/js/KO/jquery-barcode.js?ver=18"></script>

			<script type="text/javascript">

var back ="0"
var currPage = 1;
var initPage = 1;
var berfBillState = ["", "", "", ""]
var berfOrderState = ["", "", "", "",]
var berfStdt = ["", "", "", ""];
var berfEnddt = ["", "", "", ""];
var berfMonth = ["1","1","1","1"];
var scrollYn = "Y"
$(function(){
    getSvmtAmtAble();
    getTotBuyAmtNtnl(); 
    
    $(window).bind("popstate", function (event) {
    	var url = location.href;
		var subUrl = url.substring(url.indexOf('?')+1).split('&');
		var bfResult = {};
		
		for(var i=0; i<subUrl.length; i++){
			subUrl[i] = subUrl[i].split('=');
			bfResult[subUrl[i][0]] = decodeURIComponent(subUrl[i][1]);
		}
		var orderStatUrl= bfResult.orderStat;
		var billStatUrl	= bfResult.billStat;
		var srchStdCdUrl= bfResult.srchStdCd;
		var tabTypeUrl	= bfResult.tabType;
		var stDtUrl 	= bfResult.stDt;
		var endDtUrl 	= bfResult.endDt;
		var monthValUrl	= bfResult.monthVal;
		
		if(srchStdCdUrl == null || tabTypeUrl == null){
			srchStdCdUrl 	= "order";
			tabTypeUrl 		= "onln";
			var stDt = new Date();
		    var endDt = new Date();

		    endDt.setMonth(stDt.getMonth() + 1);
		    
		    var sYear = stDt.getFullYear();
		    var sMonth = stDt.getMonth()+1;
		    var sDay = stDt.getDate();
		    
		    var eYear = endDt.getFullYear();
		    var eMonth = endDt.getMonth()+1;
		    var eDay = endDt.getDate();
		    
		    if(sMonth<10) sMonth = "0" + sMonth;
		    if(sDay<10) sDay = "0" + sDay;
		    
		    if(eMonth<10) eMonth = "0" + eMonth;
		    if(eDay<10) eDay = "0" + eDay; 
		        
		    stDtUrl = sYear + '-' + sMonth + '-' + sDay
		    endDtUrl = eYear + '-' + eMonth + '-' + eDay
		}
		$('#my_order').show();
	    $("#dpatDiv").hide();
	    $("#orderDiv").hide();
	    $("#oflnDpatDiv").hide();                           
	    $("#oflnOrderDiv").hide();
		if(tabTypeUrl == "onln" && srchStdCdUrl == "dpat"){
			$("#dpatDiv").show();
			$('#billStat1').val(billStatUrl);
			$("#onlnOrder").addClass("ui-tabs-active");
		    $("#oflnOrder").removeClass("ui-tabs-active");
			$("#tabCtgDpatType").attr("class","ui-state-default ui-tabs-active");
	        $("#tabCtgOrderType").attr("class","ui-state-default");
		}else if(tabTypeUrl == "onln" && srchStdCdUrl == "order"){
			$("#orderDiv").show();
			$('#orderStat1').val(orderStatUrl);
			$("#onlnOrder").addClass("ui-tabs-active");
		    $("#oflnOrder").removeClass("ui-tabs-active");
			$("#tabCtgDpatType").attr("class","ui-state-default");
	        $("#tabCtgOrderType").attr("class","ui-state-default ui-tabs-active");
		}else if(tabTypeUrl == "ofln" && srchStdCdUrl == "dpat"){
			$("#oflnDpatDiv").show();
			$('#billStat2').val(billStatUrl);
			$("#onlnOrder").removeClass("ui-tabs-active");
		    $("#oflnOrder").addClass("ui-tabs-active");
			$("#tabCtgDpatType").attr("class","ui-state-default ui-tabs-active");
	        $("#tabCtgOrderType").attr("class","ui-state-default");
		}else if(tabTypeUrl == "ofln" && srchStdCdUrl == "order"){
			$("#oflnOrderDiv").show();
			$('#orderStat2').val(orderStatUrl);
			$("#onlnOrder").removeClass("ui-tabs-active");
		    $("#oflnOrder").addClass("ui-tabs-active");
			$("#tabCtgDpatType").attr("class","ui-state-default");
	        $("#tabCtgOrderType").attr("class","ui-state-default ui-tabs-active");
		}
		$(".monthbox >li >a").removeClass("current");
		for(var j=0; j<$('.monthbox >li >a').length; j++){
			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  monthValUrl){
				$(".monthbox >li >a").eq(j).addClass("current")
			}
		}
		$("#stDt").val(stDtUrl);
		$("#endDt").val(endDtUrl);
		back = "1";
		fnValidation();
    })
    
    $(".btnde_type_more").click(function(){
        $(this).toggleClass("on");
    });
    fn_init();
    
    $(window).scroll(function(){
    	 
	    if(Math.round($(window).scrollTop() + ($(window).height())) > Math.round(($(document).height()))- $("#footer").height()-$(".attention_area").height()){
	    	if(scrollYn == "Y"){
				scrollYn = "N";
				more();
			}
	    }
    });
});

 
function goUrl(url){
	location.href = ctx_shop + url;
}

function fn_init(){ 
    $(".tab_1depth > li").removeClass("ui-tabs-active");
    selectChange();
    var type = "onln";
    var srchStdCd = "order";
    if(type == null || type == ""){
            type = "onln";
        }
    if(srchStdCd == null || srchStdCd == ""){
    	srchStdCd = "order"
    }
    $('#my_order').show();
    $("#dpatDiv").hide();
    $("#orderDiv").hide();
    $("#oflnDpatDiv").hide();                           
    $("#oflnOrderDiv").hide();
    if(type == "onln"){
        $("#onlnOrder").attr("class","ui-tabs-active");
        $("#oflnOrder").attr("class","");
        if(srchStdCd =='dpat'){
          $("#tabCtgDpatType").attr("class","ui-state-default ui-tabs-active");
          $("#tabCtgOrderType").attr("class","ui-state-default");
          $("#dpatDiv").show();
          for(var j=0; j<$('.monthbox >li >a').length; j++){
				if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, "") ==  '1'){
					$(".monthbox >li >a").eq(j).addClass("current")
				}
			}
        } else {
          $("#tabCtgDpatType").attr("class","ui-state-default");
          $("#tabCtgOrderType").attr("class","ui-state-default ui-tabs-active");
          $("#orderDiv").show();
          for(var j=0; j<$('.monthbox >li >a').length; j++){
				if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, "") ==  '1'){
					$(".monthbox >li >a").eq(j).addClass("current")
				}
			}
        }
    } else if(type == "ofln") {
        $("#onlnOrder").attr("class","");
        $("#oflnOrder").attr("class","ui-tabs-active");
        if(srchStdCd =='dpat'){
          $("#tabCtgDpatType").attr("class","ui-state-default ui-tabs-active");
          $("#tabCtgOrderType").attr("class","ui-state-default");
          $("#oflnDpatDiv").show(); 
          for(var j=0; j<$('.monthbox >li >a').length; j++){
				if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, "") ==  '1'){
					$(".monthbox >li >a").eq(j).addClass("current")
				}
			}
        } else {
          $("#tabCtgDpatType").attr("class","ui-state-default");
          $("#tabCtgOrderType").attr("class","ui-state-default ui-tabs-active");
          $("#oflnOrderDiv").show();
          for(var j=0; j<$('.monthbox >li >a').length; j++){
				if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, "") ==  '1'){
					$(".monthbox >li >a").eq(j).addClass("current")
				}
			}
        }
    }
    my_datePicker("dpat");
    my_datePicker("order");
    $("#srchStdCd").val(srchStdCd);
    $("#tabType").val(type);
}

function selectChange(){
    
    $('#orderStat1, #orderStat2').off("change").on("change",function(){
        currPage = 1; 
        if($("#onlnOrder").hasClass("ui-tabs-active")){
        	berfOrderState[0] = $("#orderStat1").val();
        }else if($("#oflnOrder").hasClass("ui-tabs-active")){
        	berfOrderState[1] = $("#orderStat2").val();
        }
        fnValidation();
    });
    
    $('#billStat1, #billStat2').off("change").on("change", function(){
        currPage = 1;  
        if($("#onlnOrder").hasClass("ui-tabs-active")){
        	berfBillState[0] = $("#billStat1").val();
        }else if($("#oflnOrder").hasClass("ui-tabs-active")){
        	berfBillState[1] = $("#billStat2").val();
        }
        fnValidation();
    });
}


function fnSearch(){
  var type = "";
  var srchStdCd ="";
  var url="";
  if($("#onlnOrder").hasClass("ui-tabs-active")){
      type = "onln";
      if($('#tabCtgDpatType').hasClass("ui-tabs-active")){
   	     srchStdCd = "dpat";
   	     berfStdt[0] = $("#stDt").val();
   	     berfEnddt[0] = $("#endDt").val();
   	  	 berfMonth[0] = $(".monthbox >li >a[class=current]").text().replace(/[^0-9]/g, "");
   	  	 if(back != "1"){
   	  		 url = "tabType="+type+"&srchStdCd="+srchStdCd+"&billStat="+berfBillState[0]+"&orderStat="+berfOrderState[2]+"&stDt="+berfStdt[0]+"&endDt="+berfEnddt[0]+"&monthVal="+berfMonth[0];
   	  		 history.pushState("","",ctx_curr + "/mm/myOrder/listOrder.do?"+url);
   	  	 }else{back = "0"}
   	 }else if($('#tabCtgOrderType').hasClass("ui-tabs-active")){
   	     srchStdCd = "order";
   	  	 berfStdt[1] = $("#stDt").val();
	     berfEnddt[1] = $("#endDt").val();
	     berfMonth[1] = $(".monthbox >li >a[class=current]").text().replace(/[^0-9]/g, "");
   	  	 if(back != "1"){
   	  		 url = "tabType="+type+"&srchStdCd="+srchStdCd+"&billStat="+berfBillState[2]+"&orderStat="+berfOrderState[0]+"&stDt="+berfStdt[1]+"&endDt="+berfEnddt[1]+"&monthVal="+berfMonth[1];
   	  		 history.pushState("","",ctx_curr + "/mm/myOrder/listOrder.do?"+url);
   	  	 }else{back = "0"}
   	 }
  } else if($("#oflnOrder").hasClass("ui-tabs-active")){
      type = "ofln";  
     if($('#tabCtgDpatType').hasClass("ui-tabs-active")){
   	     srchStdCd = "dpat";
   	  	 berfStdt[2] = $("#stDt").val();
	     berfEnddt[2] = $("#endDt").val();
	     berfMonth[2] = $(".monthbox >li >a[class=current]").text().replace(/[^0-9]/g, "");
   	  	 if(back != "1"){
   	  		 url = "tabType="+type+"&srchStdCd="+srchStdCd+"&billStat="+berfBillState[1]+"&orderStat="+berfOrderState[3]+"&stDt="+berfStdt[2]+"&endDt="+berfEnddt[2]+"&monthVal="+berfMonth[2];
   	  		 history.pushState("","",ctx_curr + "/mm/myOrder/listOrder.do?"+url);
   	  	 }else{back = "0"}
   	 }else if($('#tabCtgOrderType').hasClass("ui-tabs-active")){
   	     srchStdCd = "order";
   	  	 berfStdt[3] = $("#stDt").val();
	     berfEnddt[3] = $("#endDt").val();
	     berfMonth[3] = $(".monthbox >li >a[class=current]").text().replace(/[^0-9]/g, "");
   	  	 if(back != "1"){
   	  		 url = "tabType="+type+"&srchStdCd="+srchStdCd+"&billStat="+berfBillState[3]+"&orderStat="+berfOrderState[1]+"&stDt="+berfStdt[3]+"&endDt="+berfEnddt[3]+"&monthVal="+berfMonth[3];
   	  		 history.pushState("","",ctx_curr + "/mm/myOrder/listOrder.do?"+url);
   	  	 }else{back = "0"}
   	 }
  }
  fn_searchList(type, srchStdCd);
}

function fn_changeOnlnOfln(type){
	
	$(".monthbox >li >a").removeClass("current");
  if( type === "onln"){
      $("#onlnOrder").addClass("ui-tabs-active");
      $("#oflnOrder").removeClass("ui-tabs-active");
      if($('#tabCtgOrderType').hasClass("ui-tabs-active")){
    	  $("#stDt").val(berfStdt[1]);
 	      $("#endDt").val(berfEnddt[1]);
 	     for(var j=0; j<$('.monthbox >li >a').length; j++){
 			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  berfMonth[1]){
 				$(".monthbox >li >a").eq(j).addClass("current")
 			}
 		}
      }else if($('#tabCtgDpatType').hasClass("ui-tabs-active")){
    	  $("#stDt").val(berfStdt[0]);
 	      $("#endDt").val(berfEnddt[0]);
 	     for(var j=0; j<$('.monthbox >li >a').length; j++){
 			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  berfMonth[0]){
 				$(".monthbox >li >a").eq(j).addClass("current")
 			}
 		}
      }
  } else if( type === "ofln"){
      $("#onlnOrder").removeClass("ui-tabs-active");
      $("#oflnOrder").addClass("ui-tabs-active");
      if($('#tabCtgOrderType').hasClass("ui-tabs-active")){
    	  $("#stDt").val(berfStdt[3]);
 	      $("#endDt").val(berfEnddt[3]);
 	     for(var j=0; j<$('.monthbox >li >a').length; j++){
 			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  berfMonth[3]){
 				$(".monthbox >li >a").eq(j).addClass("current")
 			}
 		}
      }else if($('#tabCtgDpatType').hasClass("ui-tabs-active")){
    	  $("#stDt").val(berfStdt[2]);
 	      $("#endDt").val(berfEnddt[2]);
 	     for(var j=0; j<$('.monthbox >li >a').length; j++){
 			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  berfMonth[2]){
 				$(".monthbox >li >a").eq(j).addClass("current")
 			}
 		}
      }
  }
  fnValidation();   
}

function fn_search(type){
    
    currPage = 1;  
    $("#page").val(1);
    $("#totalPage").val(1);
    
    $("#orderStat1").val(berfOrderState[0]);
    $("#orderStat2").val(berfOrderState[1]);
    $("#billStat1").val(berfBillState[0]);
    $("#billStat2").val(berfBillState[1]);
    $(".monthbox >li >a").removeClass("current");
    if(type =='dpat'){
      $("#tabCtgDpatType").attr("class","ui-state-default ui-tabs-active");
      $("#tabCtgOrderType").attr("class","ui-state-default");
      if($("#onlnOrder").hasClass("ui-tabs-active")){
    	  $("#stDt").val(berfStdt[0]);
 	      $("#endDt").val(berfEnddt[0]);
 	     for(var j=0; j<$('.monthbox >li >a').length; j++){
  			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  berfMonth[0]){
  				$(".monthbox >li >a").eq(j).addClass("current")
  			}
  		}
      }else if($("#oflnOrder").hasClass("ui-tabs-active")){
    	  $("#stDt").val(berfStdt[2]);
 	      $("#endDt").val(berfEnddt[2]);
 	     for(var j=0; j<$('.monthbox >li >a').length; j++){
  			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  berfMonth[2]){
  				$(".monthbox >li >a").eq(j).addClass("current")
  			}
  		}
      }
    } else {
      $("#tabCtgDpatType").attr("class","ui-state-default");
      $("#tabCtgOrderType").attr("class","ui-state-default ui-tabs-active");
	  if($("#onlnOrder").hasClass("ui-tabs-active")){
		  $("#stDt").val(berfStdt[1]);
 	      $("#endDt").val(berfEnddt[1]);
 	     for(var j=0; j<$('.monthbox >li >a').length; j++){
  			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  berfMonth[1]){
  				$(".monthbox >li >a").eq(j).addClass("current")
  			}
  		}
      }else if($("#oflnOrder").hasClass("ui-tabs-active")){
    	  $("#stDt").val(berfStdt[3]);
 	      $("#endDt").val(berfEnddt[3]);
 	     for(var j=0; j<$('.monthbox >li >a').length; j++){
  			if($(".monthbox >li >a").eq(j).text().replace(/[^0-9]/g, '') ==  berfMonth[3]){
  				$(".monthbox >li >a").eq(j).addClass("current")
  			}
  		}
      }
    }
    
    fnValidation();
}

function fn_searchList(type, srchStdCd){   
 
	
 currPage = 1;  
 $("#page").val(1);
 $("#totalPage").val(1);
 
 var sForm = "";
 scrollYn = "Y"
 $("#tabType").val(type);        
 $("#srchStdCd").val(srchStdCd);
 	
 $.ajax({
         async       : true,
         url         : ctx_curr + "/mm/myOrder/listOrder.do",
         dataType    : "html",
         type        : "POST",
         data        : { "page" : "1"
             ,"stDt"     : $("#stDt").val()
             ,"endDt"    : $("#endDt").val()
             ,"tabType" : $("#tabType").val()
             ,"srchStdCd"  : $("#srchStdCd").val()
             ,"billStat" : (type == 'onln')? berfBillState[0]:berfBillState[1]
             ,"orderStat": (type == 'onln')? berfOrderState[0]:berfOrderState[1]
             ,"monVal"   : $("#monVal").val()
    }, 
         success     : function(data){
             if(!crew.ajaxValidate(data)){ return; }      
             
             var __this = $(data).find("#onln_list");
             var ___this = $(data).find("#ofln_list");
             var totalPage = $(data).find("#totalPage").val();
             var page      = $(data).find("#page").val();
             $('#my_order').empty();
             $('#my_order').show();
             
             $("#totalPage").val(totalPage);
             $("page").val(page);
             if(type == "onln"){
                 $("#my_order").append(__this);
                 
                 if(srchStdCd == "dpat"){ 
                     $("#dpatDiv").show();
                     $("#orderDiv").hide();
                 } else if (srchStdCd == "order"){
                     $("#dpatDiv").hide();                       
                     $("#orderDiv").show();
                 }
             } else { 	
                 $("#my_order").append(___this);	
                 
                 if(srchStdCd == "dpat"){
                     $("#oflnDpatDiv").show();
                     $("#oflnOrderDiv").hide();
                 } else if (srchStdCd == "order"){
                     $("#oflnDpatDiv").hide();                           
                     $("#oflnOrderDiv").show();                      
                 }
             }
           
             selectChange(); 
         },
         error       : function(data){
         }
     });
}


function my_datePicker(ctgcd){
	var stDt = new Date();
    var endDt = new Date();
    if(ctgcd == "dpat"){
        stDt.setMonth(stDt.getMonth());
        endDt.setMonth(stDt.getMonth()+1);
    }else{
        endDt.setMonth(stDt.getMonth());
        stDt.setMonth(stDt.getMonth() - 1);
    }
    var sYear = stDt.getFullYear();
    var sMonth = stDt.getMonth()+1;
    var sDay = stDt.getDate();
    
    var eYear = endDt.getFullYear();
    var eMonth = endDt.getMonth()+1;
    var eDay = endDt.getDate();
    
    if(sMonth<10) sMonth = "0" + sMonth;
    if(sDay<10) sDay = "0" + sDay;
    
    if(eMonth<10) eMonth = "0" + eMonth;
    if(eDay<10) eDay = "0" + eDay; 
    
    if(ctgcd == "dpat"){
    	berfStdt[0] = sYear + '-' + sMonth + '-' + sDay;
    	berfStdt[2] = sYear + '-' + sMonth + '-' + sDay;
    	berfEnddt[0] = eYear + '-' + eMonth + '-' + eDay;
    	berfEnddt[2] = eYear + '-' + eMonth + '-' + eDay;
    }else{
    	berfStdt[1] = sYear + '-' + sMonth + '-' + sDay;
    	berfStdt[3] = sYear + '-' + sMonth + '-' + sDay;
    	berfEnddt[1] = eYear + '-' + eMonth + '-' + eDay;
    	berfEnddt[3] = eYear + '-' + eMonth + '-' + eDay;
    }
    
}

var currPage = 1;
var initPage = 1;

function more(){
  if($("#totalPage").val() <= '1' || $("#totalPage").val() == currPage){
      $("#main_loading_area").hide();
      $("#main_loading_area_orderMain").hide();
      return false;
  }
  $("#main_loading_area").show();
  $("#main_loading_area_orderMain").show();

  currPage++;
  var type = $("#tabType").val();
  if( type === "onln"){
      $("#onlnOrder").addClass("ui-tabs-active");
      $("#oflnOrder").removeClass("ui-tabs-active");
  } else if( type === "ofln"){
      $("#onlnOrder").removeClass("ui-tabs-active");
      $("#oflnOrder").addClass("ui-tabs-active");
  }
  
  var sForm = "";
  var srchStdCd = "";
  
  if($('#tabCtgDpatType').hasClass("ui-tabs-active")){
      srchStdCd = "dpat";
  }else if($('#tabCtgOrderType').hasClass("ui-tabs-active")){
      srchStdCd = "order";
  }
  
  $.ajax({
      async       : true,
      url         : ctx_curr + "/mm/myOrder/listOrder.do",
      dataType    : "html",
      type        : "POST",
      data        : { "page" : currPage
                     ,"stDt"     : $("#stDt").val()
                     ,"endDt"    : $("#endDt").val()
                     ,"tabType" : $("#tabType").val()
                     ,"srchStdCd"  : $("#srchStdCd").val()
                     ,"billStat" : (type == 'onln')? $("#billStat1").val():$("#billStat2").val()
                     ,"orderStat": (type == 'onln')? $("#orderStat1").val():$("#orderStat2").val()
                     ,"monVal"   : $("#monVal").val()
            },
      success     : function(data, textStatus, jqXHR){
          if(!crew.ajaxValidate(data)){ return; }
          
          hashInfo.currPage = currPage;
          
          $(".currPage").html(currPage);
          $("#listArea_2").append(data.html);
          
          //-------------------------------------
          var __this = $(data).find("#onln_list");
          var ___this = $(data).find("#ofln_list");
          var totalPage = $(data).find("#totalPage").val();
          var page = $(data).find("#page").val();
          var tabType = $(data).find("#tabType").val();
          var srchStdCd = $(data).find("#srchStdCd").val();
          
           
          $("#totalPage").val(totalPage);
          $("#page").val(page);

          if(type == "onln"){
              if(srchStdCd == "dpat"){
                  var dpat__this = __this.find("#onlnDpatList_add");
                  $("#onlnDpatList_cart").append(dpat__this );
              } else if (srchStdCd == "order"){
                  var order__this = __this.find("#onlnOrderList_add");
                  $("#onlnOrderList_cart").append(order__this );
              }
          } else {
              
              if(srchStdCd == "dpat"){
                  var dpat__this = ___this.find("#oflnDpatList_add");
                  $("#oflnDpatList_cart").append(dpat__this );
              } else if (srchStdCd == "order"){
                  var order__this = ___this.find("#oflnOrderList_add");
                  $("#oflnOrderList_cart").append(order__this );
              }
          }
          
          selectChange();
          
          
          $("#main_loading_area_orderMain").hide();
          $("#main_loading_area").hide();           
          
          if(page == totalPage){
              $(".moreArea").hide();
          }
          
           
          if(initPage > currPage){
              more();
          }
          scrollYn = "Y"
      },
      error       : function(jqXHR, textStatus, errorThrown){
      }
  }); 
}

function fnPrintReceipt(orderNo, billNo){
	 popOpen(ctx_shop+"/mm/myOrder/printReceipt.do?orderNo="+orderNo+"&billNo="+billNo,"printReceiptPop",720,800);
 }
 

function fnPrintCoup(orderNo, billNo){
	 $.ajax({
		 url: '//www.hddfs.com/shop/mm/myOrder/printCoup.do?orderNo='+orderNo+'&billNo='+billNo,
	        method: "post",
	        data: {},
	        async: false,
	        dataType : 'html',
	        success : function(data, textStatus, jqXHR) {
	            $("#printCoup").html(data);
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            alert('처리중 오류가 발생하였습니다.');
	        }
	    });
}
 

 function fnOflnPrintCoup(billNo){
      $.ajax({
          url: '//www.hddfs.com/shop/mm/myOrder/oflnPrintCoup.do?billNo='+billNo,
             method: "post",
             data: {},
             async: false,
             dataType : 'html',
             success : function(data, textStatus, jqXHR) {
                 $("#printCoup").html(data);
             },
             error : function(jqXHR, textStatus, errorThrown) {
                 alert('처리중 오류가 발생하였습니다.');
             }
         });
 }

 
function fn_oflnEltRcpt(billNo,saleDt){
  $.ajax({
      url: '//www.hddfs.com/shop/mm/myOrder/oflnEltRcpt.do?billNo='+billNo+'&saleDt='+saleDt,
         method: "post",
         data: {},
         async: false,
         dataType : 'html',
         success : function(data, textStatus, jqXHR) {
             $("#oflnEltRcpt").html(data);
         },
         error : function(jqXHR, textStatus, errorThrown) {
             alert('처리중 오류가 발생하였습니다.');
         }
     });
}


function fn_onlnEltRcpt(orderNo, billNo){
	$.ajax({
	      url: '//www.hddfs.com/shop/mm/myOrder/printReceipt.do?orderNo='+orderNo+'&billNo='+billNo,
	         method: "post",
	         data: {},
	         async: false,
	         dataType : 'html',
	         success : function(data, textStatus, jqXHR) {
	             $("#onlnEltRcpt").html(data);
	         },
	         error : function(jqXHR, textStatus, errorThrown) {
	             alert('처리중 오류가 발생하였습니다.');
	         }
	     });
}
</script>

			<main id="container">
				<article class="location">
					<section class="box">
						<a nohref onclick="goUrl('/dm/main.do');" class="home">홈</a>
						<div>
							<span>마이현대</span>
						</div>
						<div>
							<span>주문 내역</span>
						</div>
					</section>
				</article>
				<article class="top_fullbg">
					<h2 class="page_tit">주문 내역</h2>
					<div class="myhd_firinfo">
						<div class="myinfo">
							<p class="name">
								<strong> 이름 넣기</strong> <em>님</em>
							</p>
						
							<div class="mylv" style = "padding-top: 10px;">
								<span class="lv_on_up001"></span> <span class="lv_off_up002"></span>
							</div>
						</div>
						<div class="mypresent">
							<dl style="height: 200px; padding-top: 80px;">
								<a href="주문내역">
									<dt style="font-size: 20px;">주문내역</dt>
								</a>
							</dl>
							<dl style="height: 200px; padding-top: 80px;">
								<a href="/mm/myCont/listCounQustBbs.do">
									<dt style="font-size: 20px;">문의내역</dt>
								</a>
							</dl>
							<dl style="height: 200px; padding-top: 80px;">
								<a href="/mm/myInfo/inptMbshPwd.do?type=base">
									<dt style="font-size: 20px;">기본정보관리</dt>
								</a>
							</dl>
							<dl style="height: 200px; padding-top: 80px;">
								<a href="/mm/myInfo/inptMbshPwd.do?type=pspt">
									<dt style="font-size: 20px;">여권정보관리</dt>
								</a>
							</dl>
							<dl style="height: 200px; padding-top: 80px;">
								<a href="">
									<dt style="font-size: 20px;">출국정보관리</dt>
								</a>
							</dl>
						</div>
					</div>
	</div>
	</article>
	<script type="text/javascript">

$(document).ready(function(evt){
    getSvmtAmtAble();
    
    
    getTotBuyAmtNtnl();
    
    fnGetHpointAmt();
    
    $(".btn_view").click(function(){
        $(this).toggleClass("plus");
        $(".mymenu").toggleClass("plus");
    });
    
});

$(function(){
	
    $('#btnHeaderPsptChg').click(function() {
        location.href = ctx_curr + '/mm/myInfo/inptMbshPwd.do?type=pspt';
    });

    
    $('#btnHeaderUmbSwitcJoin1,#btnHeaderUmbSwitcJoin2,#btnHeaderUmbSwitcJoin3').click(function() {
        popOpen(ctx_curr + '/mm/myInfo/umbMbshJoinNtcPop.do', 'chgUmbMbshPop', 450, 500);
    });
});

function fnGetOcrnPntAmt(){
	$.ajax({
        async       : true,
        url         : ctx_curr + '/or/order/getMemberSimpRsvg.json',
        dataType    : 'json',
        type        : 'POST',
        success     : function(data, textStatus, jqXHR){
            if(!crew.ajaxValidate(data)){ return; }
            

            if(data.redirect != null){
            	if(data.redirect.ocrnPnt != null){
            		$('#hpointAmt').html('<strong>'+ comma(data.redirect.ocrnPnt) +'</strong>P');
            	}
            }else{
            	$('#hpointAmt').parent().html("<dt>H.Point</dt><dd><a nohref id='btnHeaderUmbSwitcJoin1'>통합회원 전환</a></dd>");
            	$('#btnHeaderUmbSwitcJoin1').click(function() {
                    popOpen(ctx_curr + '/mm/myInfo/umbMbshJoinNtcPop.do', 'chgUmbMbshPop', 450, 500);
                });
            }

        },
        error       : function(jqXHR, textStatus, errorThrown){
        }
    });
}


function fnGetHpointAmt(){
    $.ajax({
        async       : true,
        url         : ctx_curr + '/mm/myInfo/getHpointAmt.json',
        dataType    : 'json',
        type        : 'POST',
        success     : function(data, textStatus, jqXHR){
            if(!crew.ajaxValidate(data)){ return; }
            $('#hpointAmt').html('<strong>'+ comma(data.hpointAmt) +'</strong>P');
        },
        error       : function(jqXHR, textStatus, errorThrown){
        }
    });
}


function fnGetHpointPlsAmt(){
    $.ajax({
        async       : true,
        url         : ctx_curr + '/mm/myInfo/getHpointAmt.json',
        dataType    : 'json',
        type        : 'POST',
        success     : function(data, textStatus, jqXHR){
            if(!crew.ajaxValidate(data)){ return; }
            $('#hpointPlsAmt').html('<strong>'+comma(data.hpointAmt)+' </strong>P');
        },
        error       : function(jqXHR, textStatus, errorThrown){
        }
    });
}


function getSvmtAmtAble(){
    $.ajax({
        async       : true,
        url         : ctx_curr + "/mm/myInfo/getSvmtAmtAble.json",
        dataType    : "json",
        type        : "POST",
        success     : function(data, textStatus, jqXHR){
        	var vInfo = data.info;
            if(!crew.ajaxValidate(data)){ return; }
            $("#svmtAmt").html('<strong>'+comma(vInfo.data.svmtAmt)+'</strong>원');
        },
        error       : function(jqXHR, textStatus, errorThrown){
        }
    });
}

function getTotBuyAmtNtnl(){
    $.ajax({
        async       : true,
        url         : ctx_curr + '/mm/my/getTotBuyAmtNtnl.json',
        dataType    : "json",
        type        : "POST",
        success     : function(data, textStatus, jqXHR){
            var vInfo = data.info;
            var totBuyAmtNtnl=vInfo.data.totBuyAmtNtnl;
            var nextLvluBuyAmtNtnl=vInfo.data.nextLvluBuyAmtNtnl;
            
            $('#setTotBuyAmtNtnl').html('<strong>＄' + comma(Math.round(totBuyAmtNtnl * 100)/100) +'</strong>');
            
            
            if(totBuyAmtNtnl > nextLvluBuyAmtNtnl){
                $('#setRestPrice').html('<strong>＄0</strong>');
            }else{
                $('#setRestPrice').html('<strong>＄'+ comma(Math.round((nextLvluBuyAmtNtnl-totBuyAmtNtnl) * 100)/100) +'</strong>');    
            }
            
            var percentValue = 0;
            if((totBuyAmtNtnl / nextLvluBuyAmtNtnl *100) > 100 ){
                percentValue = 100;
            }else{
                percentValue = totBuyAmtNtnl/nextLvluBuyAmtNtnl * 100;
            }
                 
        },
        error : function(jqXHR, textStatus, errorThrown) {
        }
    });
}

function goUrl(url){
    location.href = ctx_shop + url;
}


function liMyChgPwd(){
	
    var vAucaType = 'INTG'; 
    if(vAucaType == 'INTG') { 
        
        alert('고객님은 H.Point통합회원이십니다. H.Point통합회원의 경우 비밀번호변경은 통합멤버십 사이트에서 가능합니다.');
        popup = window.open(gUmbMbshUrl + '/cu/mem/showCustInfo.shd', 'umbIndexPop', "width=800, height=920");
        
        
    } else { 
            location.href = ctx_shop + '/mm/myInfo/inptMbshPwd.do?type=pwd';
    }
}


function goHPointPay(umbMbshId){
    if(umbMbshId != '') { // 통합회원: H.Point Pay 이동
        goUrl('/mm/myOrder/listHPointPay.do');
    } else { // 일반회원: 통합회원 전환 창 이동
        popOpen(ctx_curr + '/mm/myInfo/umbMbshJoinNtcPop.do', 'chgUmbMbshPop', 450, 500);
    }
}



$(function(){
	$('.myinfo .name strong').each(function () {
		if (this.offsetHeight < this.scrollHeight ){
			$(this).addClass('ellipsised');
		} else {
			$(this).removeClass('ellipsised');
		}
	});
});
</script>
	<article id="content">
		<section class="myhd_content" style ="padding-top: 0px;">

			<div class="tab-action">
				<div class ="ui-tab tab_center " style ="font-size: 30px; font-weight: 700; text-decoration: underline; text-underline-position:under;text-decoration-thickness: 3px;">주문일 기준</div>


				<form id="mainForm" name="mainForm" method="get">
					<input type="hidden" name="srchStdCd" id="srchStdCd" value="order">
					<input type="hidden" name="tabType" id="tabType" value="onln">
					<input type="hidden" name="page" id="page" value="1"> <input
						type="hidden" name="totalPage" id="totalPage" value="1">

					<script> 
$(document).ready(function(){
	
	//최초 페이지 접근시(날짜조건 빈값일경우) - 온라인/출국일기준
	
		var stDt = new Date(); //시작일자
	    var endDt = new Date(); //끝일자

	    stDt.setMonth(endDt.getMonth() - 1); // 끝일자 월 계산 (현재+2)
	    
	    var sYear = stDt.getFullYear();
	    var sMonth = stDt.getMonth()+1;
	    var sDay = stDt.getDate();
	    
	    var eYear = endDt.getFullYear();
	    var eMonth = endDt.getMonth()+1;
	    var eDay = endDt.getDate();
	    
	    //월,일 2자리수로 셋팅
	    if(sMonth<10) sMonth = "0" + sMonth;
	    if(sDay<10) sDay = "0" + sDay;
	    
	    if(eMonth<10) eMonth = "0" + eMonth;
	    if(eDay<10) eDay = "0" + eDay; 
	        
	    $("#stDt").val(sYear + '-' + sMonth + '-' + sDay);
	    $("#endDt").val(eYear + '-' + eMonth + '-' + eDay);
	
	
	// 사용자가 날짜 직접 입력시
    $('#stDt, #endDt').keyup(function() {
        $(this).val(fnAutoHypenBymd($(this).val())); // 자동하이픈 처리
    });
	
	// 날짜 수정시 개월버튼 class삭제
	/* $('#stDt, #endDt').on("change", function(){
		$(".monthbox >li >a").removeClass("current")
	}) */
	
});
//개월버튼 선택에 따른 날짜 셋팅
function fnDateSetting(obj, num){
    
    //시작 일자를 기준으로 세팅 - 주문내역
    if($("#tabCtgDpatType").hasClass("ui-tabs-active")){ // 출국일 기준
    	var stDt = $("#stDt").val();
        if($.trim(stDt) == ""){
            alert("시작일자를 입력하세요.");
            return;
        }
        var stDt = new Date($("#stDt").datepicker("getDate")); //시작일자
        var endDt = new Date($("#stDt").datepicker("getDate")); //끝일자
        endDt.setMonth(stDt.getMonth() + Number(num)); // 시작일자 월 계산
    } else {
    	var endDt = $("#endDt").val();
        if($.trim(endDt) == ""){
            alert("끝일자를 입력하세요.");
            return;
        }
    	var stDt = new Date($("#endDt").datepicker("getDate")); //시작일자
        var endDt = new Date($("#endDt").datepicker("getDate")); //끝일자
        stDt.setMonth(stDt.getMonth() - Number(num)); // 시작일자 월 계산
    }   
    
    var sYear = stDt.getFullYear();
    var sMonth = stDt.getMonth()+1;
    var sDay = stDt.getDate();
    
    var eYear = endDt.getFullYear();
    var eMonth = endDt.getMonth()+1;
    var eDay = endDt.getDate();
    
    //월,일 2자리수로 셋팅
    if(sMonth<10) sMonth = "0" + sMonth;
    if(sDay<10) sDay = "0" + sDay;
    
    if(eMonth<10) eMonth = "0" + eMonth;
    if(eDay<10) eDay = "0" + eDay; 
        
    $("#stDt").val(sYear + '-' + sMonth + '-' + sDay);
    $("#endDt").val(eYear + '-' + eMonth + '-' + eDay);
    $("#monVal").val(num);  //개월수 flag
    $(".monthbox >li >a").removeClass("current")
    $(obj).addClass("current")
}

// 조회전 검색조건 검증
function fnValidation(){
	var stDt = $("#stDt").val();
	var endDt = $("#endDt").val();
	
	//오늘날짜
	var today = new Date(); 
	var year = today.getFullYear();
    var month = today.getMonth()+1;
    var day = today.getDate();
    if(month<10) month = "0" + month;
    if(day<10) day = "0" + day;
    today = year + '-' + month + '-' + day;
    
	if($.trim(stDt) == ""){
        alert("시작일자를 입력하세요.");
        return;
    }
    if($.trim(endDt) == ""){
        alert("끝일자를 입력하세요.");
        return;
    }
	if(!isValidDate(stDt)){
		alert("시작일자가 유효하지 않습니다.");
		return;
	}
	if(!isValidDate(endDt)){
		alert("종료 일자를 확인해주세요.");
		return;
	}
	
	
	
	var stDt = new Date($("#stDt").datepicker("getDate"));
    var endDt = new Date($("#endDt").datepicker("getDate"));
    var yrDate = new Date($("#endDt").datepicker("getDate"));
    yrDate.setMonth(yrDate.getMonth() - 12); // 종료일자의 1년전
    
    if(stDt - yrDate < 0){
        alert("조회기간은 최대 1년까지입니다.");
        return;
    }
    if (endDt - stDt < 0){
        alert("종료일은 시작일보다 커야합니다."); 
        return;
    }
    
	fnSearch();    //부모창 조회함수 호출!
}

//날짜포맷에 맞는지 검사
function isDateFormat(d) {
    var df = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
    return d.match(df);
}
// 윤년여부 검사
function isLeaf(year) {
    var leaf = false;

    if(year % 4 == 0) {
        leaf = true;

        if(year % 100 == 0) {
            leaf = false;
        }

        if(year % 400 == 0) {
            leaf = true;
        }
    }
    return leaf;
}
//날짜가 유효한지 검사
function isValidDate(d) {
    // 포맷에 안맞으면 false리턴
    if(!isDateFormat(d)) {
        return false;
    }
    var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    var dateToken = d.split('-');
    var year = Number(dateToken[0]);
    var month = Number(dateToken[1]);
    var day = Number(dateToken[2]);
    
    // 날짜가 0이면 false
    if(day == 0) {
        return false;
    }

    var isValid = false;

    // 윤년일때
    if(isLeaf(year)) {
        if(month == 2) {
            if(day <= month_day[month-1] + 1) {
                isValid = true;
            }
        } else {
            if(day <= month_day[month-1]) {
                isValid = true;
            }
        }
    } else {
        if(day <= month_day[month-1]) {
            isValid = true;
        }
    }
    return isValid;
}

</script>
					<input type="hidden" name="monVal" id="monVal" value="" />
					<div class="period">
						<div class="period_cover">
							<ul class="textbox monthbox">
								<li><a nohref onclick="fnDateSetting(this,'1');"
									id="dtSrchFirstTab">1개월</a></li>
								<li><a nohref onclick="fnDateSetting(this,'3');">3개월</a></li>
								<li><a nohref onclick="fnDateSetting(this,'6');">6개월</a></li>
								<li><a nohref onclick="fnDateSetting(this,12);">12개월</a></li>
							</ul>
							<div class="datebox">
								<span class="datepicker_box"> <input type="text"
									id="stDt" name="stDt" onkeyup="isNumber(this);"
									class="datepicker" value="" maxlength="10"
									placeholder="0000-00-00">
								</span> <span class="from">~</span> <span class="datepicker_box">
									<input type="text" id="endDt" name="endDt"
									onkeyup="isNumber(this);" class="datepicker" value=""
									maxlength="10" placeholder="0000-00-00">
								</span>
							</div>
							<button type="button" class="btnde_type1 mid dcheck_btn"
								onclick="fnValidation();">조회</button>
						</div>
					</div>




					<div id="my_order">
						<div class="cart_list" id="onln_list">
							<div id="dpatDiv">
								<div id="date_departure">
									<div class="sorting_wrap myhd"">
										<span class="txt_total">총 <strong>1</strong>개
										</span>
										<div class="sort_r">
											<select name="billStat" id="billStat1">
												<option value="">전체</option>
												<option value="010">최신순</option>
												<option value="020">오래된순</option>
												<option value="030^040">금액 높은순</option>
												<option value="050">금액 낮은순</option>
							
											</select>
										</div>
									</div>
									<div class="list_table01">
										<table>
											<colgroup>
												<col width="108px">
												<col width="100%">
												<col width="140px">
												<col width="298px">
												<col width="55px">
												<col width="156px">
												<col width="106px">
											</colgroup>
											<tbody id="onlnDpatList_cart">
												<tr>
													<th>주문일자</th>
													<th>주문번호</th>
													<th>이미지</th>
													<th>상품명</th>
													<th>수량</th>
													<th>결제금액</th>
													<th>주문상태</th>
												</tr>
												<tr id="onlnDpatList_add">

													<td rowspan="0">2022-09-08</td>
													<td><a
														href="//www.hddfs.com/shop/mm/myOrder/dtlOrder.do?orderNo=OR2022090800194"
														class="order_number numshort">OR2022090800194</a></td>

													<td>
														<div class="product_info" style ="padding-left:35px;">
															<span class="on_img"> <img
																src="https://cdn.hddfs.com/files/goos/0073/20220422/70852e7b.png?sf=webp&RS=60X60"
																alt="키엘 클리어리 코렉티브 다크 스팟 솔루션 115ML"
																onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/no_img252.jpg';">
															</span>
													</td>
													<td>
															<dl>
																<dt>키엘</dt>
																<dd>키엘 클리어리 코렉티브 다크 스팟 솔루션 115ML</dd>
																
															</dl>
														</div>
													</td>
													<td>0</td>
													<td><del class="delprice">$0</del>
														<p class="dollar">$0</p>
														<p class="k_won">
															0<span>원</span>
														</p></td>
													<td>취소완료</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>


						</div>
				</form>
			</div>
			<div class="attention_area">
				<p class="attention_tit">유의사항</p>
				<div class="attention_list">
					&bull; 결제 완료 후 주문 내역에서 구매하신 상품이 확인되지 않을 경우 로그아웃 후 재로그인 해주시기 바랍니다.<br />
					&nbsp;&nbsp;<br /> &bull; 아래의 경우 인도장에서 상품 수령이 제한되오니 반드시 확인해 주시기
					바랍니다.<br /> - 주문하신 고객님과 출국하시는 고객님의 정보가 불일치 할 경우<br /> - 주문서에 기재된
					여권번호와 출국 시 여권번호가 불일치 할 경우<br /> - 등록된 출국정보(출국장소, 출국일시, 편명 등)와 실
					출국정보가 다른 경우<br /> <br /> &bull; 출국 정보 변경을 원하실 경우, 출국일 최소 3일 전에
					고객센터로 연락해 주시기 바랍니다.(단, 지방공항 이용 시 4일전)<br /> &bull; 출국 시 인도받지 못한
					물건은 고객센터로 연락 바랍니다.<br /> &bull;&nbsp;화장품/식품等 유통기한과 연관있는 상품의 경우
					출국정보 변경 시 유통기한이 임박 또는 초과된 상품을 받을 수 있으므로 유의하시기 바랍니다.<br /> &bull;
					추가 궁금하신 내용은 고객센터 (1811-6688 / 운영시간 09:30~18:30) 로 문의바랍니다. <a
						href="https://www.hddfs.com/shop/om/consmComm/faq.do"
						class="link_txt_point">FAQ 바로가기</a>
				</div>
			</div>
			<div id="printCoup"></div>
			<div id="oflnEltRcpt"></div>
			<div id="onlnEltRcpt"></div>
		</section>
	</article>
	</main>
	<!-- // container -->
	<script type="text/javascript">
	function sellerInfo(){
	    $("#seller_information").dialog("open");
	}
	$(document).ready(function(){
        // 다이얼로그 초기화
        $("#seller_information").dialog({
            autoOpen: false,
            resizable: false,
            width:400,
            maxHeight: 340,
            modal: true
        });
    });
	function moveToMain(){
		location.href = ctx_shop + '/dm/main.do';
	}
</script>
	<%@include file="../include/footer.jsp"%>

	<div class="modal_wrap mainPopWrap"></div>
	<!-- 공통 팝업 정의 ENd -->
	<div class="layer_unit pop_o8_adult" style="display: none">
		<div class="layer_popup">
			<div class="layer_cont">
				<p class="txt_ty1">성인인증 안내</p>
				<p class="text_ty2">
					본 상품은 성인인증 이후 이용이 가능합니다.<br> 성인인증 화면으로 이동하시겠습니까?
				</p>

				<ul class="btn_group">
					<li><a nohref class="btnde_type1 mid adultCancle">취소</a></li>
					<li><a nohref id="chkBtn" value=""
						class="btnde_type1 mid bg_black" onclick="adultAuthPop(this);"
						data-setid="" data-cartseq="" data-cartsetid=""
						data-notAdtGoodsCd="" data-notAdtQtyList="">확인</a></li>
					<input type="hidden" id="goodsCd" value="" />
					<input type="hidden" id="qty" value="" />
					<input type="hidden" id="adtBuyNow" value="" />
				</ul>
			</div>
		</div>
		<div class="event_type_close">닫기</div>
	</div>
	<div id="layer_popup_adult" class="pop_o9_adult" title="성인인증"
		style="display: none">
		<div class="adult_popup">
			<strong class="tit">본 상품정보는 '청소년에게 유해한 정보'를 <br>포함하고
				있기에 성인인증이 필요합니다.
			</strong>
			<ul>
				<li>본 정보 내용은 청소년 유해물건으로 청소년보호법의 규정에 의하여 만 19세 미만의 청소년이 이용할 수
					없습니다.</li>
			</ul>

			<strong class="box"> 이용을 원하시면 로그인 후 <br>성인인증을 진행해주시기
				바랍니다. <em>이 상품은 비회원 주문이 불가한 상품입니다.</em>
			</strong>
			<p>
				본인확인이 가능하지 않은 경우 <br>현대백화점면세점 고객센터로 연락주시기 바랍니다.
			</p>
			<a nohref id="hpAuth" value="" class="phonecertification_btn"
				data-goosCd="" data-qty="" data-buynow="" data-setid=""
				data-cartseq="" data-cartsetid="" data-notAdtGoodsCd=""
				data-notAdtQtyList=""> <span>휴대폰 인증</span>
			</a>

			<dl>
				<dt>유의사항</dt>
				<dd>휴대폰을 이용한 본인확인은 본인명의의 휴대전화로만 인증이 가능합니다.</dd>
			</dl>
		</div>
	</div>
	<script type="text/javascript">
$(document).ready(function(){
    
	if(isLogin){
    	adultCallback();
	}else{
		deleteCookie("ADULT_TYPE");
		deleteCookie("ADULT_GOOSCD");
	    deleteCookie("ADULT_QTY");
	    deleteCookie("NOT_ADULT_GOOSCD");
	    deleteCookie("NOT_ADULT_QTY");
	    deleteCookie("ADULT_SETID");
	    deleteCookie("ADULT_BUYNOW");
	}
	
	
    
})


/* 휴대폰 인증  */
$("#hpAuth").click(function(){
    var type = $(this).attr("value");
    var goodsCd = $(this).attr("data-goosCd");
    var qty = $(this).attr("data-qty");
    var buynow = $(this).attr("data-buynow");
    var setGoosId = $(this).attr("data-setid");
    var cartSeq = $(this).attr("data-cartseq");
    var cartSetId = $(this).attr("data-cartsetid");
    var notAdtGoodsCd = $(this).attr("data-notAdtGoodsCd");
    var notAdtQtyList = $(this).attr("data-notAdtQtyList");
    
    console.log(type);
    
    openDRMOKWindow(type,goodsCd,qty,buynow,setGoosId,cartSeq,cartSetId,notAdtGoodsCd , notAdtQtyList);
});

$(".event_type_close").click(function(){
    $(this).parent().dialog("close");
});

$(".adultCancle").click(function(){
	$(this).closest(".pop_o8_adult").dialog("close");
}); 

/* 성인인증 팝업 */
function openPopup(obj,type,goodsCd,qtyList,setGoosId , buyNow, cartSeq , cartSetId, notAdtGoodsCd , notAdtQtyList){
    console.log('19세팝업 openPopup')
    console.log(goodsCd + '----' + qtyList);
    if(!isLogin){
        login("","",type,goodsCd,qtyList,setGoosId ,buyNow,notAdtGoodsCd,notAdtQtyList); 
     return false;
    }   
    
    adultPopup(type,goodsCd,qtyList , buyNow,setGoosId , cartSeq , cartSetId,notAdtGoodsCd,notAdtQtyList);  
    
}

function adultPopup(type,goodsCd,qtyList, buyNow,setGoosId , cartSeq , cartSetId, notAdtGoodsCd , notAdtQtyList){
    
    console.log(type);
    console.log('19세팝업 adultPopup');
    console.log(goodsCd + '----' + qtyList);
    console.log(cartSeq);
    console.log(cartSetId);
    
    //$("#layer_default_adult").show();
    
    $(".pop_o8_adult").dialog({
        resizable: false,
        dialogClass:"event_type",
        width:370,
        minHeight: 120,
        maxHeight: 600,
        modal: true
    });
    
    $("#chkBtn").attr("value",type);
    $("#chkBtn").closest('li').next().attr("value",goodsCd);
    $("#chkBtn").closest('li').next().next().attr("value",qtyList);
    $("#chkBtn").closest('li').next().next().next().attr("value",buyNow);
    $("#chkBtn").attr("data-setid",setGoosId);
    $("#chkBtn").attr("data-cartseq",cartSeq);
    $("#chkBtn").attr("data-cartsetId",cartSetId);
    $("#chkBtn").attr("data-notAdtGoodsCd",notAdtGoodsCd);
    $("#chkBtn").attr("data-notAdtQtyList",notAdtQtyList);
}

function adultAuthPop(obj){
    
    console.log($(obj).attr('value'));
    
    $(".pop_o8_adult").dialog("close");
    
    $(".pop_o9_adult").dialog({
        //resizable: false,
        dialogClass: "pop_type1",
        width: 380,
        minHeight: 120,
        maxHeight: 600,
        modal: true
    });
    
    var goodsCd = $(obj).closest("li").next().attr("value");
    var qty = $(obj).closest("li").next().next().attr("value");
    var buyNow = $(obj).closest("li").next().next().next().attr("value");
    var setGoosId = $(obj).attr("data-setid");
    var cartSeq = $(obj).attr("data-cartseq");
    var cartSetId = $(obj).attr("data-cartsetId");
    var notAdtGoodsCd = $(obj).attr("data-notAdtGoodsCd");
    var notAdtQtyList = $(obj).attr("data-notAdtQtyList");
    
    
    $("#hpAuth").attr('value',$(obj).attr("value"));
    $("#hpAuth").attr('data-goosCd',goodsCd);
    $("#hpAuth").attr('data-qty',qty);
    $("#hpAuth").attr('data-buynow',buyNow);
    $("#hpAuth").attr('data-setid',setGoosId);
    $("#hpAuth").attr('data-cartseq',cartSeq);
    $("#hpAuth").attr('data-cartsetId',cartSetId);
    $("#hpAuth").attr('data-notAdtGoodsCd',notAdtGoodsCd);
	$("#hpAuth").attr('data-notAdtQtyList',notAdtQtyList);
    
    
    
} 

function callback(obj){
    console.log(obj);
    $(location).attr("href", obj);
}

function adultSuccessAlert(){
	
	setTimeout(function(){
		alert('정상적으로 처리되었습니다.');  // 정상적으로 처리되었습니다.
    }, 100);
}

function adultErrorAlert(obj){
	
	setTimeout(function(){
		alert(obj);
    }, 100);
}

function closeAdultPopup(){
	$("#layer_popup_adult").dialog("close");
}


function removeAdult(){
	
	var goosCd = "";
	var minBuyQty = "";
	var url = "https://www.hddfs.com/shop";
    
	$.each($(".goosList"),function(i,el){
        
        if($(this).attr("data-adult") == "Y"){
            $(this).removeAttr("data-adult");
            $(this).removeAttr("adult");
            goosCd = $(this).attr("data-gooscd");
			minBuyQty = $(this).attr("data-minbuyqty");
			$(this).find('a').attr('onclick', '').unbind('click');
			$(this).find("a").attr("href",url+"/gd/dtl/goos.do?onlnGoosCd="+goosCd);
			$(this).find('.cartBtn').attr("onclick",'newAddCartMulti("'+goosCd+'", "'+minBuyQty+'", "", "", "order","N",event)');
			$(this).find('.buyBtn').attr("onclick",'newAddCartMulti("'+goosCd+'", "'+minBuyQty+'", "", "", "order","Y",event)');
        }
        
    })
    
    $.each($(".goosLi"),function(i,el){
    	if($(el).attr("data-adult") == "Y"){
	    	$(el).removeAttr("data-adult");
        }
    });
}


function openDRMOKWindow(type,goodsCd,qty,buynow,setGoosId, cartSeq , cartSetId, notAdtGoodsCd , notAdtQtyList){
    
    /* 휴대폰 인증 관련 공지*/
    var url = "https://www.mobile-ok.com/popup/common/hscert.jsp";

    var DRMOK_window;
    
    var redirectUrl = "";
    if(type == "detail"){
        redirectUrl = "https://www.hddfs.com/shop/gd/dtl/goos.do?onlnGoosCd="+goodsCd; 
    }
    
    var goosCdArr = new Array();
    goosCdArr = goodsCd.split(",");
    goosCdLength = goosCdArr.length;
    
    var notAdtGoosCdArr = new Array();
    notAdtGoosCdArr = notAdtGoodsCd.split(",");
    notAdtGoosCdLength = notAdtGoosCdArr.length;
    
    var goosInfo = new Array();
    goosInfo.push(type);
    goosInfo.push(buynow);
    goosInfo.push(setGoosId);
    goosInfo.push(cartSeq);
    goosInfo.push(cartSetId);
    goosInfo.push(goosCdLength);
    goosInfo.push(goodsCd);
    goosInfo.push(qty);
    goosInfo.push(notAdtGoosCdLength);
    goosInfo.push(notAdtGoodsCd);
    goosInfo.push(notAdtQtyList);
    
    
    
    window.name = 'sendJsp';
    DRMOK_window = window.open(url+'?cpid=hddfs&rtn_url=http://www.hddfs.com/shop/mm/mbshAuca/adultAuca.do?goosInfo='+goosInfo+'&req_info=OjmSdw7jHeBK%2F%2F5XqiEZ0l6W%2F%2BljfSsKGeulj8CiwPF0ioulrJ2lSLNCxq4xtf%2FibYLCYL4vcieQrGuodc8fWSdrBS9mY3a8jQaQVkXL57m6BKAcMw0Y1kPgMfja59e%2FdNMhjbh4WQJHQ1RP1rOm9tFosbJv9vTJ%2B8pZ%2FFCN%2B%2FJtJTT8Ja1oJbEOulmoEGIVHlaBz2D%2F4rCid5E1UEgDJpCnlb0%2FmF2hL4MJnp9q7eyFB4gkEau8pnkhde%2F0l0GJ%2BeOkiPKNp6ilxjoHBkGCDk5Os1%2F64%2BRBh5NvRW8UKRIZ8eHpaW74Z0GIwQFfYGD62yXmrefhAX9dAAbeMjdEbw%3D%3D', 'DRMOKWindow', 'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no' );
    DRMOK_window.focus();

    if(DRMOK_window == null){
        alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n 화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
    }
}

function reload(){
    location.reload();
}

function adultCallback(){
	
	var adultType = getCookie("ADULT_TYPE");
    var goosCd = getCookie("ADULT_GOOSCD");
    var qtyList = getCookie("ADULT_QTY");
    var notAdtGoodsCd = getCookie("NOT_ADULT_GOOSCD");
	var notAdtQtyList = getCookie("NOT_ADULT_QTY");
    var setGoosId = getCookie("ADULT_SETID");
    var buyNow = getCookie("ADULT_BUYNOW");
    
	// 메인 로그인 시 성인인증여부 검증용
    var mainAdultYn = "N";
	
	if("N" == "N") {
		
	    $.ajax({
			url : ctx_curr + "/cm/comm/mainAdultYn.json",
			async : false,
			dataType : "json",
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				
				if(data.mainAdultYn == "Y") {
					mainAdultYn = "Y";
				}
			}
		});
	}
    
    if(adultType == "cart"){
        
        if("N" == "Y" || mainAdultYn == "Y"){
        	newAddCartMulti(goosCd, qtyList, '', '', 'order',buyNow);
        }else{
            adultPopup(adultType,goosCd,qtyList,buyNow);  
        }
        deleteCookie("ADULT_TYPE");
    }else if(adultType == "detail"){
        if("N" == "Y" || mainAdultYn == "Y"){
            location.href = ctx_curr + "/gd/dtl/goos.do?onlnGoosCd=" + goosCd;
        }else{
            adultPopup(adultType,goosCd,qtyList,buyNow); 
        }
        deleteCookie("ADULT_TYPE");
    }else if(adultType == "list"){
        if("N" == "Y" || mainAdultYn == "Y"){
            newAddCartMulti(goosCd, qtyList, '', '', 'order',buyNow);
        }else{
            adultPopup(adultType,goosCd,qtyList,buyNow,'','','',notAdtGoodsCd,notAdtQtyList); 
        }
        deleteCookie("ADULT_TYPE");
    }else if(adultType == "set"){
        if("N" == "Y" || mainAdultYn == "Y"){
            /* newAddCartMulti(onlnGoosCdList.join(","), goosQtyList.join(","), '', '', 'insert', 'Y', setGoosId); */
        	newAddSetCartMulti(goosCd, qtyList, setGoosId, '');		//세트 장바구니 호출
        }else{
            adultPopup(adultType,goosCd,qtyList,buyNow, setGoosId , '' , '' , notAdtGoodsCd,notAdtQtyList); 
        }
        deleteCookie("ADULT_TYPE");
    }else if(adultType == "cartList"){ //HDDFS 리뉴얼 프로젝트 [ 김인호 - 2021.06.17 ] - 장바구니
        if("N" == "Y" || mainAdultYn == "Y"){
        	//goSelectedOrder();
        	location.href = ctx_curr + "/or/order/order.do";
        }else{
        	adultPopup(adultType,goosCd,qtyList,buyNow , '' ,''); 
        }
    }else if(adultType == "cartGoosCdDetail"){
        if("N" == "Y" || mainAdultYn == "Y"){
            location.href = ctx_curr + "/gd/dtl/goos.do?onlnGoosCd=" + goosCd;
        }else{
            adultPopup(adultType,goosCd,'',''); 
        }
   }
    deleteCookie("ADULT_GOOSCD");
    deleteCookie("ADULT_QTY");
    deleteCookie("ADULT_SETID");
    deleteCookie("ADULT_BUYNOW");
    deleteCookie("NOT_ADULT_GOOSCD");
    deleteCookie("NOT_ADULT_QTY");
    
    
}




</script>
	<div class="loading loadProgBar" style="display: none;">
		<div class="loading_img">
			<img
				src="https://cdn.hddfs.com/front/images/KO/common/loading_apng.png"
				alt="">
		</div>
	</div>
</body>
</html>