<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--  
주문 목록 -> 주문 번호를 누르면 주문 상세페이지가 나옴 
여기는 주문 상세페이지

1, 주문 취소 구현
2, od_no를 pk 로 하나씩 데이터 가져와서 뿌리기
3, 1:1 상담문의 즉, cs 링크 걸기
4, 


-->

<!DOCTYPE html>

<html lang="ko">
<head>
	<title>현대백화점인터넷면세점</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="format-detection" content="telephone=no">
	<meta name="title" content="현대백화점인터넷면세점">
    <meta name="description" content="해외명품/화장품/시계/가방, 적립금/할인/쿠폰 등 다양한 혜택, 공동구매/가상착장(AR)서비스 제공">
    <meta name="metaKeywords" content="현대면세점, 현대백화점인터넷면세점, 현대인터넷면세점, 현대백화점면세점, 현대면세, 인터넷현대면세점, 현대온라인면세점, 현대백화점온라인면세점, 현대백화점DUTYFREE,현대무역센터면세점, 현대무역센터점, 현대동대문면세점, 현대동대문점, 현대인천공항면세점, 현대인천공항점, 면세쇼핑몰, 인터넷면세점, 온라인면세점, 인천공항면세점, 인천공항면세, 공항면세, 공항면세점, 공항쇼핑, dutyfree, 면세할인, 면세점할인, 면세가격, 면세점할인방법, 면세추천, 면세선물, 면세점선물, 면세점선물추천, 현대면세점인도장, 면세점인도장, 면세점상품수령, 쇼핑, 쇼핑몰, 명품쇼핑, 해외여행, 인천공항, 출장, 출국, 신혼여행, 허니문, 여행선물, 선물인터넷면세점주문, 인터넷면세점주문가능시간, 출국3시간전, 출국전쇼핑, 출국전인터넷쇼핑, 쿠폰, 할인쿠폰, 면세쿠폰, 면세점쿠폰, 현대면세점쿠폰, 적립금, 면세점적립금, 면세적립금, 현대면세점적립금,화장품, 향수, 가방, 명품, 해외명품, 브랜드, 면세점주류, 면세점담배, 면세점홍삼, 면세점화장품, 면세점향수, 면세점명품, 면세점시계, 면세점가방, 명품가방, 면세점정품">
	<meta property="og:title" content="현대백화점인터넷면세점">
	    <meta property="og:description" content="해외명품/화장품/시계/가방, 적립금/할인/쿠폰 등 다양한 혜택, 공동구매/가상착장(AR)서비스 제공">
	    <meta property="og:image" content="https://cdn.hddfs.com/front/images/KO/common/hddfs_og.png">
	<script src="https://cdn.hddfs.com/front/js/KO/jquery-1.12.4.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/jquery-ui.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/lottie.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/jquery.bxslider.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/swiper-bundle.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/jquery.lazyload.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/jquery.lazyloadxt.min.js?ver=18"></script>
	<script src="https://cdn.hddfs.com/front/js/KO/common.ui.js?ver=18"></script>
	<link rel="shortcut icon" href="https://cdn.hddfs.com/front/images/KO/common/favicon_H.ico">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/jquery-ui.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/swiper-bundle.min.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/common.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/layout.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/n_hgk.css?ver=18">
	<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/member.css?ver=18">
	<script language="javascript">
    // 현재 요청경로
    var ctx_curr                = "//www.hddfs.com/shop";
    var ctx_shop                = "https://www.hddfs.com/shop";
    var isLogin                 = true;
    var SERVER_IMAGE            = "https://cdn.hddfs.com/front";
    var SERVER_IMAGE_MNG = "https://cdn.hddfs.com/files/";
    var SERVER_SCRIPT_JSON      = "https://cdn.hddfs.com/files";    
    var USER_AUTO_LOGOUT_TIME   = 1800;
    var gUmbMbshUrl             = "https://www.h-point.co.kr"; // 통합멤버쉽 주소
    
</script>

<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/crew.source.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/form/form.source.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/sns.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/jquery.cookie.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/common.js?ver=18"></script>

<!-- S: 다이퀘스트 스크립트 추가 -->
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/diquest/dqAutoCompleteCommon.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/diquest/dqHeader.js?ver=18"></script>
<!-- E: 다이퀘스트 스크립트 추가 -->

<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/cloud-zoom.1.0.2.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/SsoAjax.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/SsoHttpRequest.js?ver=18"></script>

<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/makePCookie.js?ver=18"></script>


<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/hash.js?ver=18"></script>
<script>
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(document.referrer);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

var Naver_Previous_Query = getParameterByName('oquery');
</script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-121444436-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  
  
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('set', {'dimension1' :Naver_Previous_Query});
  gtag('config', 'UA-121444436-1', {'send_page_view' : false});
  
  var gaMbshNo = "2208990015585";
  var gaCustNo = "z2xaY+fU/wmApR2sphSjeg==";
  
  if(isLogin){
	  if(gaCustNo == ""){
		  dataLayer.push({
              'dimension3' : gaMbshNo
          });
	  }else{
		  dataLayer.push({
	          'dimension3' : gaMbshNo,
	          'dimension4' : gaCustNo
	      });
	  }
  }
  </script>

<!-- Google Tag Manager -->
<script async src="https://www.googletagmanager.com/gtm.js?id=GTM-56VKRZT"></script>
<script>
	var gaStr = window.location.pathname;
	var gaPathName = gaStr.split('/');
	if(gaPathName[3] != "main.do"){
		(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','GTM-56VKRZT');
	}
</script>
<!-- End Google Tag Manager -->

<!-- 네이버 연관채널 추가 2020.07.30 -->
<script type="application/ld+json">
{
 "@context": "http://schema.org",
 "@type": "Person",
 "name": "현대백화점면세점",
 "url": "https://www.hddfs.com",
 "sameAs": [
   "https://www.facebook.com/HDDFS.official",
   "https://www.instagram.com/hddfs.official",
   "https://www.youtube.com/c/hddfs",
   "https://apps.apple.com/kr/app/id1436812610",
   "https://play.google.com/store/apps/details?id=com.ehyundai.HyunDaiDutyFreeShop"
 ]
}
</script>
 
<script>
    //통합멤버쉽 가입팝업
    function fnUmbJoinPop(joinType, ptnrChlCd, ptcoAlliPaonInf2) {
        var $form = $('<form></form>');
        $form.attr('action', gUmbMbshUrl + '/cu/join/start.nhd');
        $form.attr('method', 'post');
        $form.attr('target', 'umbJoinPop');
        $form.append('<input type="hidden" value="02" name="prtnrReqGb">');
        $form.append('<input type="hidden" value="D030" name="prtnrId">');
        $form.append('<input type="hidden" value="1201" name="chnnlId">');
        $form.append('<input type="hidden" value="PC" name="ptcoReqnMdaInf">');
        $form.append('<input type="hidden" value="' + joinType + '" name="ptcoReqnOnoflnGb">');
        $form.append('<input type="hidden" value="' + ptnrChlCd + '" name="ptcoAlliPaonInf1">');
        $form.append('<input type="hidden" value="' + ptcoAlliPaonInf2 + '" name="ptcoAlliPaonInf2">');
        $form.appendTo('body');

        popOpen('', 'umbJoinPop', 600, 800);
        $form.submit();
    }


    $(document).ready(function(evt){
    	
        // 회원 자동 로그아웃 타이머 구동(30분)
        if(isLogin){
            setTimeout(logoutAuto, USER_AUTO_LOGOUT_TIME * 1000);
        }

        // 숫자입력만 허용
        $(".onlynum").keyup(onlynum);
        
        //HDDFS 리뉴얼 프로젝트 [ 김인호 - 2021.05.27 ] 숫자입력만 허용 
        $("input[type='number']").keyup(onlynum2);

        // lazy 적용
        if(typeof($.fn.lazyload) == "function"){
            //$("img.lazy").trigger("appear");
            $("img.lazy").lazyload({ effect : "fadeIn", threshold:200, placeholder : SERVER_IMAGE + '/images/KO/common/loading.gif' });
            $("img.lazy").removeClass("lazy");
        }


        //$.ajax 공통 설정
        $.ajaxSetup({
            complete : function(jqXHR, textStatus ){
                if(typeof($.fn.lazyload) == "function"){
                    $("img.lazy").lazyload({ effect : "fadeIn", threshold:200, placeholder : SERVER_IMAGE + '/images/KO/common/loading.gif' });
                    $("img.lazy").removeClass("lazy");
                }
            }
        });
    });
</script>

<!-- S: 2022-05-25 이지웰 메인팝업 추가 -->
<style>
    .main_popup2 {display:none}
    .main_popup2:after {display:none !important;}
    .main_popup2 .pop_img {height:368px; overflow:hidden;} 
    .main_popup2 .pop_img, .main_popup2 .close_section2 {position:relative; z-index:1;}
    .close_section2 {padding:16px 20px 14px}
    .close_section2::after {display:block; content:''; clear:both}
    .today_close2 {display:block; float:left; font-size:14px; color:#5c6677; line-height:20px; position:relative}
    .today_close2.chk input[type='checkbox'] {display:none;}
    .today_close2.chk input[type='checkbox'] + label {padding-left:0;}
    .today_close2.chk input[type='checkbox'] + label:before {display:none;}
    .popup_close2 {display:block; cursor:pointer; float:right; font-size:14px; color:#1b1e23; line-height:20px; font-weight:600}
    .ui-dialog.ui-widget.ui-widget-content.main_popup2_layer {position:fixed !important;background:#fff;border-radius:20px}
    .ui-dialog.main_popup2_layer .ui-dialog-titlebar {display:none}
    .main_popup2_layer {width:560px !important; height:422px !important; background-color:#fff; position:absolute !important; top:50% !important; left:50% !important; transform:translate(-50%, -50%) !important;}
</style>

<div class="main_popup2">
    <div class="pop_img">
        <a href="javascript:void(0);" onclick="login('')"> 
            <img src="https://cdn.hddfs.com/files/editor/20220504/6b3d071d_202205041549127060.jpg" alt="로그인 한번으로 즐기는 간편한 면세쇼핑">
        </a>
    </div>
    <div class="close_section2">
        <span class="today_close2 chk">
            <input type="checkbox" id="today_close2">
            <label for="today_close2">오늘하루보지 않기</label>
        </span>
        <span class="popup_close2">닫기</span>
    </div>
</div>
<script>
    // main_popup2
    $( function() {
        $(".main_popup2").dialog({
            dialogClass: "main_popup2_layer",
            width:560,
            autoOpen: false
        });
        
        $(".popup_close2").click(function(){
            $(".main_popup2").dialog("close");
        });
        
        $("#today_close2").click(function(){
        	// 쿠키 저장
            var date = new Date();
            date.setTime(date.getTime() + (1000 * 60 * 60 * 24));
            date.setHours(0);
            date.setMinutes(0);
            date.setSeconds(0);
            $.cookie("closePopEz", "Y", { expires: date, path : "/" });
            $(".main_popup2").dialog("close");
        });
        
        // 이지웰 로그인 팝업
        if(!isLogin && getCookie("closePopEz") != "Y" && getCookie("PTNR_CHL_GBN_KEY") == "00009902" 
        		&& getCookie("EZWEL_USER_KEY_SESSION") != null && location.href.indexOf("membershipSleepRelease") == -1){
        	if(location.href.indexOf("main") == -1){ // 메인이 아닐때 팝업 뜸
                $(".main_popup2").css("display","block");
                $(".main_popup2").dialog("open");
            }
        	else if(location.href.indexOf("main") != -1 && sessionStorage.getItem("selMainSwiperPos") != 0){//메인인 경우 인트로 아닐때 팝업뜸
        		$(".main_popup2").css("display","block");
                $(".main_popup2").dialog("open");
        	}
        }
        
        $(".intro_box").scroll(function(){
            if(!isLogin && getCookie("closePopEz") != "Y" && getCookie("PTNR_CHL_GBN_KEY") == "00009902" 
                    && getCookie("EZWEL_USER_KEY_SESSION") != null && location.href.indexOf("membershipSleepRelease") == -1
                    && sessionStorage.getItem("selMainSwiperPos") != 0){
                $(".main_popup2").css("display","block");
                $(".main_popup2").dialog("open");
            }
        });
    });

</script>
<!-- E: 2022-05-25 이지웰메인팝업 추가 --></head>
<body>
	<div id="wrap">
		<!-- header -->
		<meta name="google-site-verification" content="rYjJmYP3q9lxBYCTSa_Tg3h1N9l3yZjJGp0AFaKCZlM" />
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-56VKRZT" height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

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
	$(function() {
		// 햄버거 
		if("N" == "Y"){
			// 햄버거
			$(".btn_gnb").click(function(){ wiseLogAggr("KR_PC_GNB_Hamburger"); });
			// 검색버튼 
			$(".btn_search").click(function(){ wiseLogAggr("KR_PC_GNB_SearchIcon"); });		
			// 로그인
			$("#loginBtn").click(function(){ wiseLogAggr("KR_PC_GNB_Login"); });
			// 언어변경
			$("#ko_btn").click(function(){ wiseLogAggr("KR_PC_GNB_Language"); });	
			// 통화변경currencyInfo
			$(".currencyInfo>.ko").click(function(){ wiseLogAggr("KR_PC_GNB_Change_Currency"); });	
			$(".currencyInfo>.cn").click(function(){ wiseLogAggr("KR_PC_GNB_Change_Currency"); });	
		}
	});
</script>
<header id="header">
	<section class="box">
		<a href="javascript:" class="btn_gnb">Navigation Drawer</a>
	    <!-- <h1 onclick="goMainPage();" style="cursor: pointer;">HYUNDAI DEPARTMENT SHOP - DUTY FREE</h1> -->
	    <h1 onclick="goMainPage();" style="cursor: pointer;" ><img id = "mainLogo" src="https://cdn.hddfs.com/front/images/KO/common/logo.png?RS=192X40" alt="HYUNDAI DEPARTMENT SHOP - DUTY FREE"></h1>
	    <form name="searchHeader" id="searchHeader" method="get" onsubmit="return false;">
	    <fieldset class="searchfield" >
	    	<legend>통합검색</legend>
	        <div class="select_search">
	            <button class="tag_search" id="hashSrchCond">해시태그검색</button>
	            <button class="text_search" id="basicSrchCond">일반검색</button>
	            <div class="tooltip">해시태그로 검색하세요 :)</div>   <!-- 일반단어로 검색하세요 :) -->
	        </div>
	        
	        <div class="mainsearchinput">
		        <input type="search" class="text_search" name="searchTerm" id="basicSearchTerm" maxlength="" value="" placeholder="검색어를 입력해주세요" onkeypress="javascript:if(event.keyCode == 13) { searchHeaderAction();}" onmousedown="dq_setTextbox('1',event);" onfocusin="srchLayer();" onkeydown="dq_setTextbox('1',event);" autocomplete="off"/>
		        <input type="search" class="tag_search" name="searchTerm" id="hashSearchTerm" maxlength="" value="" placeholder="해시태그를 입력해주세요" onkeypress="javascript:if(event.keyCode == 13) { searchHeaderAction();}" onmousedown="dq_setTextbox('1',event);" onfocusin="srchLayer();" onkeydown="dq_setTextbox('1',event);" autocomplete="off"/>
		        <input type="hidden" id="movUrl" name="movUrl" value=""/>
		        <input type="hidden" id="rcntOffYn" name="rcntOffYn" value="" />	  <!-- 최근검색어 저장 사용 유무 -->
			    <input type="hidden" id="rcntWrdYn" name="rcntWrdYn" value="" />      <!-- 최근검색어 존재 유무 여부 -->
			    <input type="hidden" id="autoOffYn" name="autoOffYn" value="" />      <!-- 자동완성 사용 여부 -->
			    <input type="hidden" id="searchType" name="searchType" value="" />   <!-- 검색 타입 구분 -->
			    <input type="hidden" id="searchOrder" name="order" value="" />   		  <!-- 정렬 구분 -->
		    </div>
	        <button class="btn_search" onclick="searchHeaderAction();">검색</button>
	    </fieldset>
	    </form>
	    <!-- 검색 레이어 영역 START -->
    	<div class="advanced_search">
	<div class="tab-action theme_search" id="allSearchArea">
	    <ul class="tab_textmedium" id="searchTabBox" style="display:none">
	        <li id="rcntTab">
	            <a href="#advanced_search_01">최근 · 인기검색어</a>
	        </li>
	        <li id="brandTab">
	            <a href="#advanced_search_02">브랜드검색</a>
	        </li>
	    </ul>

	    <div class="adsearch_panel" id="searchLayerList">
	    	<div id="advanced_search_01" class="popular_search">
	    	
	    	</div>
	    	
	    	<div id="advanced_search_02" class="brand_search">
	            <div class="tab-action">
	                <ul class="tab_round">
	                    <li id="default_brand_tab">
	                        <a href="#advanced_search_brand_01">BRAND</a>
	                    </li>
	                    <li id="default_category_tab">
	                        <a href="#advanced_search_brand_02">CATEGORY</a>
	                    </li>
	                </ul>
	                <div id="advanced_search_brand_01">
	                    <div class="sort_wrap">
	                        <div class="tab-action">
	                            <ul class="sortbtn_wrap" id="brandSortBtn">
	                                <li><a href="#brand_sortbtn_01" onclick="switchBranTab('01');">가나다순</a></li>
	                                <li><a href="#brand_sortbtn_02" onclick="switchBranTab('02');">ABC순</a></li>
	                            </ul>
	                            <div id="brand_sortbtn_01" class="lang_sort on">
	                                <div class="brand_cate">
										<ul id="brandKrList">
											</ul>
		                            </div>
		                            
	                            </div>
	                            <div id="brand_sortbtn_02" class="lang_sort">
		                            <div class="brand_cate">
										<ul id="brandEnList">
											</ul>
		                            </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                
	                <div id="advanced_search_brand_02">
	                    <div class="sort_wrap">
	                        <div class="tab-action">
	                            <div id="brand_sortbtn_03" class="lang_sort on">
	                                <div class="brand_cate">
										<ul id="cateList">
											</ul>
		                            </div>
	                            </div>
	                        </div>
	                        
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="search_autocomplete" id="autoList" style="display:none;">
	    <div class="none_autoword" id="no_autoComplete" style="display:none;">자동완성기능을 사용하고 있지 않습니다.</div>
	    <span class="switch autoword">
	    	<input type="checkbox" id="autoCompleteBtn" onclick="javascript:autoCompleteSwitch();">
	        <label for="autoCompleteBtn">
	            <span class="slider"></span>
	            <span>자동완성</span>
	        </label>
	    </span>
	</div>
	<a href="javascript:" class="search_close">닫기</a>
</div>

<script src="https://cdn.hddfs.com/front/js/KO/diquest/dqAutoComplete.js"></script>	
<script type="text/javascript">	

	
	$(function(){
		
		// 검색결과에 따라 검색창 변환
		changeSearchArea();
		
		if($("#autoOffYn").val() == "" || $("#autoOffYn").val() == null){
			$("#autoOffYn").val('Y');
		}
		
		// 일반 검색창에 # 입력시 해시태그 검색창 전환
		$("#basicSearchTerm").on('keyup', function(){
			if($("#basicSearchTerm").val() === "#"){
				$(".select_search #hashSrchCond").trigger('click');
				//changeSearchTextBox();
				//console.log("dq_autoSearchType : " + dq_autoSearchType);
				$("#hashSearchTerm").focus();
			}
		});
		
		// 검색 조건 클릭시 자동완성 타입 변경
		$(".select_search button").on('click', function(){
			changeSearchTextBox();
		});
		
		// 검색창 클릭시 검색 레이어 호출
		$("#basicSearchTerm, #hashSearchTerm").on('click', function(){
			if( ($("#brandKrList > li").length <1) || ($("#brandEnList > li").length <1)){
				loadBranIcKrList();
			} 
			if($("#brandTab").attr('tabindex') == '0'){
				wiseLogAggr("KR_PC_Common_BrandSearch");
			}else{
				wiseLogAggr("KR_PC_Common_SearchKeyword");
			}
			srchLayer();
		});
		
		$("#default_category_tab > a").click(function(){
			//카테고리 로드
			loadCtgList();
		});
		
		$("#brandTab").on('click', function(){
			wiseLogAggr("KR_PC_Common_BrandSearch");
			$(".tab_round #default_brand_tab a").trigger('click');
		});
		
		$("#rcntTab").on('click', function(){
			wiseLogAggr("KR_PC_Common_SearchKeyword");
		});
		
		$("#default_brand_tab a").on('click', function(){
			wiseLogAggr("KR_PC_Common_BrandSearch_Brand");
		});
		
		$("#default_category_tab a").on('click', function(){
			wiseLogAggr("KR_PC_Common_BrandSearch_Category");
		});
		
	});
	
	function branAction(branCd){
		$(location).attr('href', ctx_curr+"/dm/bran/brand.do?onlnBranCd="+branCd);
		
 	}
	
	//브랜드 ㄱㄴㄷ > ABC 변경시
	function switchBranTab(type){
		if(type =="02"){
			//ABC 순 조회
			loadBranIcEnList();
		}
		$("#brand_sortbtn_"+type+" > div > ul > li > button").removeClass("on");
		$("#brand_sortbtn_"+type+" > div > ul > li:eq(0) > button").addClass("on");
		$("#brand_sortbtn_"+type+" > div > ul > li > .branTabResult").removeClass("on");		
		$("#brand_sortbtn_"+type+" > div > ul > li:eq(0) > .branTabResult").addClass("on");
	}
	
	// 초성 선택시 동작
	function chgBranTab($this,type){
		if(!$($this).hasClass("disabled")){
			if(type ==1){		//국문
				$("#brandKrList > li").each(function(){
					var dataGroup = $(this).data("group-pos");
					if($('[data-group="bran'+dataGroup+'"]:checked').length < 1){
						$(this).find("button").removeClass("on");
					}
				});
			}else{
				$("#brandEnList > li").each(function(){
					var dataGroup = $(this).data("group-pos");
					if($('[data-group="bran'+dataGroup+'"]:checked').length < 1){
						$(this).find("button").removeClass("on");
					}
				});
			} 
			$(".branTabResult").removeClass("on");
			$($this).addClass("on");
			$($this).parent().find("div").addClass("on");
		}
	}
	
	// 카테고리 선택시 동작
	function chgCateTab($this){
		if(!$($this).hasClass("disabled")){
			$("#cateList > li").each(function(){
				var dataGroup = $(this).data("group-pos");
				if($('[data-group="cate'+dataGroup+'"]:checked').length < 1){
					$(this).find("button").removeClass("on");
				}
			});
			$(".cateTabResult").removeClass("on");
			$($this).addClass("on");
			$($this).parent().find("div").addClass("on");
		}
	}
	
	// 검색어 목록 call json
  	function srchLayer(){
		// 검색어 있는 상태일때 자동완성 실행
		if($("#basicSearchTerm").val().length > 0 || $("#hashSearchTerm").val().length > 0){
			dq_reqSearch();
		}
		
		// 검색 타입 구분
		var searchType = $("#searchType").val();
		
		$.ajax({
		    async       : true,
		    url         : ctx_curr + "/sr/searchLayer.json",
		    dataType    : "json",
		    type        : "POST",
		    data        : { searchType : searchType },
		    success     : function(data, textStatus, jqXHR){
		        if(!crew.ajaxValidate(data)){ return; }
		        // 검색어 목록 추가
		        //$("#searchLayerList").append(data.html);
		        $("#advanced_search_01").html(data.html);
		        
		        // 최근 검색어 존재 유무 세팅
	        	$("#rcntWrdYn").val(data.dqGoosSrch.rcntWrdYn);
				
		        // 자동 저장 사용 유무를 쿠키에서 받아옴
		        if(data.rcntOffYn != null){
		        	$("#rcntOffYn").val(data.rcntOffYn);
		        }else{
		        	$("#rcntOffYn").val('Y');
		        }
		        
		     	// 정렬값를 쿠키에서 받아옴
		        if(data.order != null){
		        	$("#searchOrder").val(data.order);
		        }else{
		        	$("#searchOrder").val('random');
		        }
	        	// 초기 자동저장 세팅 
	        	setAutoSave();
		     	
		    	 // 자동완성 기능 사용여부 
				if($("#autoOffYn").val() == 'N'){
					dq_acOff();
				}else{
					dq_acArrow();
				}
		    },
		    error       : function(jqXHR, textStatus, errorThrown){
		        //console.log(jqXHR.status);
		    }
		});
	}
	
    // 검색 레이어 띄울때 자동저장 상태 세팅
	function setAutoSave() {
		if(dq_autoSearchType == "basic"){
			dq_searchTextbox = document.getElementById("basicSearchTerm");
			if(showType == 'intro'){
				dq_searchTextbox = document.getElementById("basicSearchTermIntro");
			}
		} else {
			dq_searchTextbox = document.getElementById("hashSearchTerm");
			if(showType == 'intro'){
				dq_searchTextbox = document.getElementById("hashSearchTermIntro");
			}
		}
		
    	if ($("#rcntOffYn").val() === 'Y') {
    		//console.log("자동저장 체크됨  : " + $("#rcntOffYn").val());
    		$('input[id="autoSaveBtn"]').attr('checked', true);
    		$("#rcntKeyword").show();
    		$("#deleteAll").show();
    		$(".words_list #noRcnt").hide();
    		
    		// 사용하지만 최근 검색어가 없을때 
    	 	if ($("#rcntWrdYn").val() === 'N') {
    	 		//$("#rcntKeyword").hide();
    	 		$("#deleteAll").hide();
    	 		$(".words_list #noRcnt").show();
    	 		$("#noRcnt").text('최근 검색어가 없습니다.');
    	 	}
    	} else {
    		//console.log("자동저장 체크헤제됨  : " + $("#rcntOffYn").val());
    		$('input[id="autoSaveBtn"]').attr('checked', false);
    		$(".words_list #noRcnt").show();
    		$("#noRcnt").text('자동저장 기능 미사용 중입니다.');
    		$("#rcntKeyword").hide();
    		$("#deleteAll").hide();
    	}
	}
	
	
	// 해시태그 결과 페이지인 경우 검색창 전환
	function changeSearchArea(){
		if($("#resultSearchType").val() == "hash"){
	 		dq_autoSearchType = "hash";
	 		$(".searchfield .select_search").addClass("tag");
			$(".mainsearchinput").addClass("tag");
			$(".searchfield .tooltip").text("일반단어로 검색하세요 :)")
			$("#basicSearchTerm").val('');
			//console.log("해시태그 결과 페이지 확인 : " + dq_autoSearchType);
		} else {
	 		dq_autoSearchType = "basic";
	 		$(".searchfield .select_search").removeClass("tag");
			$(".mainsearchinput").removeClass("tag");
			$(".searchfield .tooltip").text("해시태그로 검색하세요 :)")
			$("#hashSearchTerm").val('');
			//console.log("일반 결과 페이지 확인 : " + dq_autoSearchType);
		}
	}
	
	
    // HDDFS 리뉴얼 프로젝트 [이승훈-2021.04.16] - 자동완성 기능 추가
    // 자동완성 on/off
	function autoCompleteSwitch(){
	    
    	if ($("#autoOffYn").val() === 'Y') {
	        dq_acOff();
//   		console.log("자동완성 미사용 전환  : " + $("#autoOffYn").val());
    		
    	} else {
    		dq_acArrow();
//    		console.log("자동완성 사용 전환  : " + $("#autoOffYn").val());
    	}
	}
	
	// 자동 저장 on/off
    function autoSaveSwitch() {
    	
    	// 사용 -> 미사용으로 전환
    	if ($("#rcntOffYn").val() === 'Y') {
    		$("#rcntOffYn").val('N');
    		$("#rcntKeyword").hide();
    		$("#deleteAll").hide();
    		$(".words_list #noRcnt").show();
    		$("#noRcnt").text('자동저장 기능 미사용 중입니다.');
//    		console.log("자동저장 미사용으로 전환 : " + $("#rcntOffYn").val());
        // 미사용 -> 사용으로 전환   
    	} else {
    		$("#rcntOffYn").val('Y');
    		$(".words_list #noRcnt").hide();
    		$("#rcntKeyword").show();
    		$("#deleteAll").show();
//    		console.log("자동저장 사용으로 전환 : " + $("#rcntOffYn").val());
       		
    		// 사용하지만 최근 검색어가 없을때 
    	 	if ($("#rcntWrdYn").val() === 'N') {
    	 		$("#rcntKeyword").hide();
    	 		$("#deleteAll").hide();
    	 		$(".words_list #noRcnt").show();
    	 		$("#noRcnt").text('최근 검색어가 없습니다.');
    	 	}
    	}
    	
    	autoSaveActionBySaveCookie();	
    	
    	
    }
	
    // 쿠키 사용 (자동저장 유무 값 유지용도)
	function autoSaveActionBySaveCookie() {
	    
		var rcntOffYn = $("#rcntOffYn").val();
		
	    $.ajax({
	        async       : true,
	        url         : ctx_curr+"/sr/srchWrdSave.json",
	        dataType    : "json",
	        type        : "POST",
	        cache       : false,
	        data        : {"rcntOffYn" : rcntOffYn},
	        success     : function(data, textStatus, jqXHR){
	            if(!crew.ajaxValidate(data)){ return; }
	        },
	        error       : function(jqXHR, textStatus, errorThrown){
	            //console.log(jqXHR.status);
	        }
	    });
	} 	

	// 최근 검색어 삭제
	function delSrchWrd(srchWrd, hashTagYn){
	
		//console.log("삭제된 검색어 srchWrd : " + srchWrd);
		
		var searchType = "";
		if(hashTagYn == 'Y'){
			searchType = "hash"
		}else if(hashTagYn == 'all'){
			searchType = "all"
		}else {
			searchType = "basic"
		}
		
		//console.log(searchType);
		
		if (srchWrd === null || srchWrd === undefined) {
			srchWrd = "";
		}
		
	    var html = "";
	    
	    /* 최근검색어 삭제요청 */
	    $.ajax({
	        async       : true,
	        url         : ctx_curr+"/sr/delSrchWrd.json",
	        dataType    : "json",
	        type        : "POST",
	        cache       : false,
	        data        : {
	        				"srchWrd" : srchWrd, 
	        				"searchType" : searchType 
	        	  		  },
	        
	        success     : function(data, textStatus, jqXHR){
	            if(!crew.ajaxValidate(data)){ return; }
	            
		           	if(data.recentList.length > 0){
		            	$.each(data.recentList,function(key){
		                    var list = data.recentList[key];
		                    
		                    if(list.srchClsCd == "001"){
		                    	html += "<li><a href=\""+ctx_curr+"/sr/searchResult.do?searchTerm="+ encodeURIComponent(list.srchWrd) + "&searchType="+encodeURIComponent("basic")+"\">"+list.srchWrd+"</a><button type=\"button\" class=\"ic_x deleteOne\" onclick=\"javascript:delSrchWrd('"+list.srchWrd+"', 'N');\">X</button></li>";
		                    }else{
		                    	html += "<li><a href=\""+ctx_curr+"/sr/hashSearchResult.do?searchTerm="+ encodeURIComponent(list.srchWrd) +"&searchType="+encodeURIComponent("hash")+"\">#"+list.srchWrd+"</a><button type=\"button\" class=\"ic_x deleteOne\" onclick=\"javascript:delSrchWrd('"+list.srchWrd+"', 'Y');\">X</button></li>";
		                    }
		                });
		            	$("#rcntKeyword").html(html);
		            }else{
		            	$("#rcntKeyword").empty();
		            	$("#noRcnt").show();
		            	$("#noRcnt").text('최근 검색어가 없습니다.');
		            	$("#deleteAll").hide();
		            }
		            
		           	// 최근 검색어가 있을때
		            if(data.dqGoosSrch.rcntWrdYn == 'Y'){
		            	$("#rcntWrdYn").val('Y');
		            	$("#rcntKeyword").show();
		                $("#noRcnt").hide();
		            // 최근 검색어가 없을때
		            }else{
		            	$("#rcntWrdYn").val('N');
		            	$("#rcntKeyword").hide();
		            	$("#noRcnt").show();
		            	$("#noRcnt").text('최근 검색어가 없습니다.');
		            }
	            
	        },
	        error       : function(jqXHR, textStatus, errorThrown){
	            //console.log(jqXHR.status);
	        }
	    });
	}
	
	
	// 검색어 체크
	function checkSearchTerm(searchTerm){
		var ke = dqc_trimSpace(searchTerm);

		while(ke.indexOf("\\") != -1)
			ke = ke.replace("\\", "");

		while(ke.indexOf("\'") != -1)
			ke = ke.replace("\'", "");
		
		return ke;		
	}
	
	// form submit
    function searchHeaderAction(){
    	wiseLogAggr("KR_PC_GNB_SearchIcon");
    	//$(".advanced_search").removeClass("adsearch_open");

		// 검색어 미입력 시 삽입된 문구로 검색 혹은 지정된 url로 이동
		/* if ($("#basicSearchTerm").val() === "" && $("#hashSearchTerm").val() === "") {
			var url = $("#searchHeader").find("[name=movUrl]").val();
		    
			if(url != ""){
				location.href = url;
		    }else{
		    	alert("검색어를 입력해주세요."); // 검색어를 입력해주세요 
		    }
		}else{ */
			var result = '';
			$("#movUrl").attr('disabled', true);
		
	     	// 일반 검색 일때
	     	if (!$(".mainsearchinput").hasClass('tag')){
	     		if ($("#basicSearchTerm").val() === "") {
	    			var url = $("#searchHeader").find("[name=movUrl]").val();
	    		    
	    			if(url != ""){
	    				location.href = url;
	    		    }else{
	    		    	alert("검색어를 입력해주세요."); // 검색어를 입력해주세요 
	    		    }
	     		}else{
	     			$(".advanced_search").hide();
	     			
		     		result = checkSearchTerm($("#basicSearchTerm").val());
		     		$("#basicSearchTerm").val(result);
		     		$("#hashSearchTerm").val('');
		     		$("#basicSearchTerm").attr('disabled', false);
		    		$("#hashSearchTerm").attr('disabled', true);
		    		// 일반검색은 order값 제외
		    		$("#searchOrder").attr('disabled', true); 
		    		// 검색 타입 구분
		    		$("#searchType").val("basic");
		    		
		    		searchHeader.action = ctx_curr+"/sr/searchResult.do";
		    		searchHeader.submit();
	     		}
	    	} else {
	    	// 해시태그 검색 일때
	    		if ($("#hashSearchTerm").val() === "") {
    		    	alert("검색어를 입력해주세요."); // 검색어를 입력해주세요 
	     		}else{
	     			$(".advanced_search").hide();
	     			
		    		result = checkSearchTerm($("#hashSearchTerm").val());
		     		$("#hashSearchTerm").val(result);
		     		$("#basicSearchTerm").val('');
		     		$("#basicSearchTerm").attr('disabled', true);
		    		$("#hashSearchTerm").attr('disabled', false);
		    		// 검색 타입 구분
		    		$("#searchType").val("hash");
		    		
		    		searchHeader.action = ctx_curr+"/sr/hashSearchResult.do";
		    		searchHeader.submit();
	     		}
	    	}
	    	
		//}
		
	    $(".adsearch_dim").hide();
		
    }
</script><!-- 검색 레이어 영역 END-->
	    <div class="default_menu">
	    	<a class="menu_login_join" href="javascript:" id="logoutBtn" onclick="logout();">로그아웃</a>
	    		<ul>
	            <li class="item_01">
	                <a href="https://www.hddfs.com/shop/or/order/listCart.do"><strong>장바<br>구니</strong><em id="rwingCartCnt" style="display: none"></em></a>
	            </li>
	            <li class="item_02">
	                <a href="https://www.hddfs.com/shop/mm/myOrder/listOrder.do"><strong>주문<br>조회</strong><em class="orderStatusTxt">0</em></a>
	            </li>
	            <li class="item_03">
	                <a rel="nosublink" href="https://www.hddfs.com/shop/mm/myOrder/listOrder.do"><strong>마이<br>현대</strong></a>
	            </li>
	            <li class="item_04">
	                <a href="https://www.hddfs.com/shop/om/consmComm/main.do"><strong>고객<br>센터</strong></a>
	            </li>
	            <li class="item_05">
	                <a href="https://www.hddfs.com/store/kr/dm/main.do" target="_blank"><strong>공식<br>사이트</strong></a>
	            </li>
	            <li class="language ko">
	                <a href="javascript:" class="ko"><strong>언어<br>설정</strong></a>
	                <div>
	                    <a href="javascript:" id="ko_btn" onclick="goMainPage();" class="ko">ko</a>
	                    <a href="https://cn.hd-dfs.com/shop/dm/main.do" class="cn">cn</a>
	                </div>
	            </li>
	            <li class="currency">
	                <a href="javascript:" class="currencyType "><strong>통화<br>설정</strong></a>
	                <div class="currencyInfo">
	                    <a href="javascript:" onclick="chgCurrencyInfo('KRW');" class="ko">KRW</a>
	                    <a href="javascript:" onclick="chgCurrencyInfo('CNY');" class="cn">CNY</a>
	                </div>
	            </li>
	            <li class="exchange_rate exchageRateTxt"></li>
	        </ul>
	    </div>
	    <!-- 히든메뉴 START -->
	    <script type="text/javascript">

function commOpenLayer(cookieChkYn, hiddenYn){
	$.ajax({
	    async       : true,
	    url         : ctx_curr + "/dm/main/popInfo.json",
	    dataType    : "json",
	    type        : "POST",
	    success     : function(popInfo, textStatus, jqXHR){
	    	var data = popInfo.resPop;
	    	var html = "";
	    	for(var i=0; i < data.popSeqList.length; i++){
    			html+="<div class=\"main_popup\" id=\"main_bottom_pop"+data.popSeqList[i].popSeq+"\" data-seq=\""+data.popSeqList[i].popSeq+"\">";
	    		var addClass = "";
	    		var addStyle= "";
	    		if(data.popSeqList[i].popTmplCd == '001'){
	    			addClass="popswiper-container";
	    		}else{
	    			addClass="html_wrap";
	    			addStyle= "style='width:560px; height: 368px;'";
	    		}
	    		html+="<div class=\""+addClass+"\" "+addStyle+">";
	    		if(data.popSeqList[i].popTmplCd == '001'){
	    			html+="<ul class=\"swiper-wrapper mainPopList\">";
	    			for(var j=0; j < data.dataList.length; j++){
	    				if(data.popSeqList[i].popSeq == data.dataList[j].popSeq){
	    					html += "<li class=\"swiper-slide\">";
	    					var link = data.dataList[j].linkUrl != null ? data.dataList[j].linkUrl : "javascript:";		
	    					
	    					var wiseLog = "";
	    					if(link != "javascript:") {
	    						if(link.indexOf("?") != -1) {
	    							wiseLog = "&MG=KR_PC_Main_Popup"+data.popSeqList[i].popSeq+"_"+data.dataList[j].popDtlSeq;
	    						} else {
	    							wiseLog = "?MG=KR_PC_Main_Popup"+data.popSeqList[i].popSeq+"_"+data.dataList[j].popDtlSeq;
	    						}
	    					}
	    					
	    					if(data.dataList[j].shrtVdoUrl != null){
	    						html += "<video preload=\"none\" muted loop class='video-js'  style='width:560px; height:368px; object-fit:cover; background-color: black;'>";
	    						html += "<source src=\"https://cdn.hddfs.com/files/"+data.dataList[j].shrtVdoUrl+"\" type=\"video/mp4\">";
	    						html += "<strong>Your browser does not support the video tag.</strong>";
	    						html += "</video>";
	    					}else{
	    						var mainTitl = data.dataList[j].mainTitl != null ? data.dataList[j].mainTitl : "";
	    						var subTitl = data.dataList[j].subTitl != null ? data.dataList[j].subTitl : "";
	    						var bnnrWrd = data.dataList[j].bnnrWrd != null ? data.dataList[j].bnnrWrd : "";
	    						
	    						html += "<a href=\""+link+wiseLog+"\"  class='item_wrap'>";
	    						html += "<div class='pop_txt'>";
	    						html += "<strong class='cate'>"+mainTitl+"</strong>";
	    						html += "<p>"+subTitl+"</p>";
	    						html += "<p>"+bnnrWrd+"</p>";
	    						html += "</div>";
	    						html += "<img src=\"https://cdn.hddfs.com/files/"+data.dataList[j].imgUrl+"?sf=webp&RS=750X494\" alt=\""+data.dataList[j].mainTitl+"\">";
	    						html += "</a>";
	    					}
	    					html += "</li>";
	    				}	
	    			}
	    			html+="</ul>";
	    			html+="<div class=\"swiper_control\" id=\"mainPop_"+data.popSeqList[i].popSeq+"\">";
	    			html+="<div class=\"swiper-pagination\"></div>";
	    			html+="<div class=\"swiper-prev\"></div>";
	    			html+="<div class=\"swiper-next\"></div>";
	    			html+="</div>";
	    		}else{
	    			html += data.popSeqList[i].htmlCont;
	    		}
	    		html+="</div>";
	    		html+="<div class=\"close_section\">";
	    		html+="<span class=\"today_close chk\">";
	    		html+="<input type=\"checkbox\" class=\"today_close\" id=\"btn_hidden_layer_"+data.popSeqList[i].popSeq+"\" onclick=\"saveMainLayerCookie("+data.popSeqList[i].popSeq+");\" hiddenYn=\"N\" />";
	    		html+="<label for=\"btn_hidden_layer_"+data.popSeqList[i].popSeq+"\" style=\"cursor: pointer;\">오늘 하루 보지 않기</label>";
	    		html+="</span>";
	    		html+="<span class=\"popup_close\"  data-seq=\""+data.popSeqList[i].popSeq+"\" onclick=\"closeMainLayer("+data.popSeqList[i].popSeq+");\">닫기</span>";
	    		html+="</div>";
	    		html+="</div>";	
    		}
	    	
	    	$(".mainPopWrap").html(html); 
	    	callMainPopSwiper();
	    	
	    	if(hiddenYn == "Y"){
	    	    $(".hidden_menu").removeClass("open");
	    		$(".item").slideUp(200);
	    	}
	    	
	    	if($(".main_popup").length > 0){
		    	$('.modal_wrap').addClass('active');	//팝업 띄우기
	    	}
	    	
	    	if(cookieChkYn == "Y"){
	    		// 메인팝업
	    		$(".main_popup").each(function(){
	    			var seq = $(this).data("seq");
	    			$(".today_close.chk").show();
	    			$("#btn_hidden_layer_"+seq).attr("hiddenYn", "N");
	    			if(getCookie("closePop" + seq) == "Y"){	// 팝업 오픈
	    				$("#main_bottom_pop"+seq).remove();
	    				if($(".main_popup").length <1){
	    					$('.modal_wrap').removeClass('active');
	    				}
	    			}
	    		});
	    	}else{
	    		// 메인팝업 오픈
	    		$(".main_popup").each(function(){
	    			var seq = $(this).data("seq");
	    			$(".today_close.chk").hide();
	    			$("#btn_hidden_layer_"+seq).attr("hiddenYn", "Y");	    			
	    		});
	    	}
	    	
	    	if(hiddenYn == "Y"){
	    		$(".ui-resizable").css("position", "fixed")
	    	}
	    	
    		$(".main_popup").each(function(){
    			var seq = $(this).data("seq");
    			if($("#main_bottom_pop"+seq).find("li").length == 1){
    				$("#mainPop_"+seq).hide();
    			}
    		});
    		
    		$(".mainPopList > li").find("video").attr("preload","");
    		$(".mainPopList > li").find("video").attr("autoplay",true);
	    }
	});
}


//쿠폰 다운로드
function issueHiddenCoupon(cupId){
	var lgcpBuyMbshGrpCd = '001';
	var mbshGrpNm = '';
	
    // 로그인 체크
    if ( !isLogin ) {
    	alert('로그인 후 이용 가능합니다.');	/*로그인 후 이용 가능합니다.*/
        login();
        return;
    }
    
    if(lgcpBuyMbshGrpCd == "MG" || mbshGrpNm == "MG"){
    	alert('본 쿠폰은 현대백화점면세점 일반 회원만 다운로드 및 사용할 수 있습니다.');	/*본 쿠폰은 현대백화점면세점 일반 회원만 다운로드 및 사용할 수 있습니다.*/
        return;
    }

    issueCoupon(cupId,function(data){
        if ( data.resultCode == 1 ) {
        	alert('쿠폰이 다운로드 되었습니다.');	/*쿠폰이 다운로드 되었습니다.*/
        } 
        else {
            alert(data.message);
        }
    });
}


// 적립금 다운로드
function issueHiddenSvmt(svmtId, baseRsvgAmt){
	issueSvmt(svmtId, baseRsvgAmt , function(data){
        if ( data.resultCode == 1 ) {
        	alert('적립금이 다운로드 되었습니다.');	/*적립금이 다운로드 되었습니다.*/
        } 
        else {
            alert(data.message);
        }
    });
}

// 이벤트 혜택받기
function getHiddenMenuEvntBnef(evntId){
    addEvnt(evntId);
}
</script>

<div class="hidden_menu">
	<a href="javascript:wiseLogAggr('KR_PC_Common_HiddenMenuIcon');" class="btn">히든메뉴</a>
	<div class="item">
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	            <div class="swiper-slide mainPopBtn">
		                <a href="javascript:wiseLogAggr('KR_PC_Common_HiddenMenu_1');" onclick="javascript:commOpenLayer('N', 'Y');">
		                    <span class="img fix">
		                        <img src="https://cdn.hddfs.com/front/images/KO/common/icon_hidden_01.png" alt="메인팝업">
		                    </span>
		                    <p>메인팝업</p>
		                </a>
		            </div>
	            <div class="swiper-slide">
		                <a href="https://www.hddfs.com/event/op/bnf/listBnf.do?MG=KR_PC_Common_HiddenMenu_2">
		                    <span class="img fix">
		                        <img src="https://cdn.hddfs.com/front/images/KO/common/icon_hidden_02.png" alt="월별혜택안내">
		                    </span>
		                    <p>월별혜택안내</p>
		                </a>
		            </div>
	            </div>
		</div>
        <div class="controller">
            <button class="btn-up" value="up"></button>
            <button class="btn-down" value="down"></button>
        </div>
	</div>
</div><!-- 히든메뉴 END -->
	    </section>
	    <nav class="navication">
	        <ul class="quick_link">
	            <li class="ql_03"><a href="https://www.hddfs.com/shop/mm/myOrder/listOrder.do" rel="nosublink">주문내역</a></li>
	            <li class="ql_01"><a href="https://www.hddfs.com/shop/om/consmGuide/useNotice.do" rel="nosublink">주문<br>가능시간</a></li>
	            <li class="ql_04"><a href="https://www.hddfs.com/shop/mm/myInfo/listMbshDpatInfo.do" rel="nosublink">출국정보</a></li>
	            <li class="ql_02"><a href="https://www.hddfs.com/shop/mm/myInfo/inptMbshPwd.do?type=pspt" rel="nosublink">여권정보</a></li>
	        </ul>
	        <div id="gnb">
    <h2>Global Navigation Bar</h2>
    <ul class="depth_01">
        <li>
            <strong>전체서비스</strong>
            <ul class="depth_02 serviceMenu">
            	<li>
						<a href="https://www.hddfs.com/shop/op/sale/saleShop.do" >
							세일</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/shop/dm/best/weekly.do" >
							베스트</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/event/op/evnt/evntShop.do" >
							이벤트</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/event/op/spex/spexShop.do" >
							기획전</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/shop/or/coupon/cupMain.do" >
							쿠폰</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/shop/dm/new/newShop.do" >
							신상품</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/event/op/evnt/evntDetail.do?evntId=0002920" >
							H.COS Club</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/event/op/evnt/evntDetail.do?evntId=0003628" >
							Club Travel</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/shop/or/spord/main.do" >
							스페셜오더</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/shop/op/weds/wedsShop.do" >
							웨딩샵</a>
					</li>
				<li>
						<a href="http://www.hselect.co.kr" target="_blank">
							출국없는 면세쇼핑</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/shop/dm/hluxury/luxuryList.do" >
							H.LUXURY</a>
					</li>
				<li>
						<a href="http://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=649901" >
							H.AMORNY(우수 중소기업 브랜드관)</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/shop/dm/specialMain.do?spclMenuSeq=8&MG=KR_PC_Main_Mainevent_6" >
							❤H.OUTLET(시즌오프)❤</a>
					</li>
				<li>
						<a href="https://www.hddfs.com/shop/dm/specialMain.do?spclMenuSeq=4&MG=KR_PC_Main_Mainevent_6" >
							❤화장품 클리어런스 大세일❤</a>
					</li>
				</ul>
        </li>
        <li>
            <strong>카테고리</strong>
            <ul class="depth_02 serviceCtgList"></ul>
        </li>
        <li>
            <strong>공식스토어</strong>
            <ul class="depth_02 gnb_luxury luxuryAreaList">
            	<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=005601" rel="nosublink">
							<p>겔랑</p>
							<img src="https://cdn.hddfs.com/files/gd/20220214/8964829b_202202141654149430.jpg?sf=webp&RS=131X131" alt="겔랑" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=001801" rel="nosublink">
							<p>라프레리</p>
							<img src="https://cdn.hddfs.com/files/gd/20220204/864a76a0_202202041249213770.png?sf=webp&RS=131X131" alt="라프레리" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=006301" rel="nosublink">
							<p>랑콤</p>
							<img src="https://cdn.hddfs.com/files/gd/20220504/c20154c6_202205041256272420.jpg?sf=webp&RS=131X131" alt="랑콤" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=006801" rel="nosublink">
							<p>슈에무라 </p>
							<img src="https://cdn.hddfs.com/files/gd/20220504/59c9f78e_202205041254565010.jpg?sf=webp&RS=131X131" alt="슈에무라 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=006701" rel="nosublink">
							<p>아틀리에 코롱 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/006701_3.jpg?sf=webp&RS=131X131" alt="아틀리에 코롱 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=007301" rel="nosublink">
							<p>키엘 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/007301_3.jpg?sf=webp&RS=131X131" alt="키엘 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=063001" rel="nosublink">
							<p>케라스타즈</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/063001_3.jpg?sf=webp&RS=131X131" alt="케라스타즈" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=053601" rel="nosublink">
							<p>버버리 뷰티</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/053601_3.jpg?sf=webp&RS=131X131" alt="버버리 뷰티" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=024101" rel="nosublink">
							<p>프라다 향수</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/024101_3.jpg?sf=webp&RS=131X131" alt="프라다 향수" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=063401" rel="nosublink">
							<p>구찌 뷰티</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/063401_3.jpg?sf=webp&RS=131X131" alt="구찌 뷰티" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=022901" rel="nosublink">
							<p>에스티 로더</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/022901_3.jpg?sf=webp&RS=131X131" alt="에스티 로더" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=025701" rel="nosublink">
							<p>크리니크</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/025701_3.jpg?sf=webp&RS=131X131" alt="크리니크" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=013101" rel="nosublink">
							<p>골든구스</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/013101_3.jpg?sf=webp&RS=131X131" alt="골든구스" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=025501" rel="nosublink">
							<p>조 말론 런던</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/025501_3.jpg?sf=webp&RS=131X131" alt="조 말론 런던" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=026901" rel="nosublink">
							<p>달팡</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/026901_3.jpg?sf=webp&RS=131X131" alt="달팡" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=025401" rel="nosublink">
							<p>맥</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/025401_3.jpg?sf=webp&RS=131X131" alt="맥" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=025301" rel="nosublink">
							<p>라 메르 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/025301_3.jpg?sf=webp&RS=131X131" alt="라 메르 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=027101" rel="nosublink">
							<p>톰포드 뷰티</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/027101_3.jpg?sf=webp&RS=131X131" alt="톰포드 뷰티" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=024901" rel="nosublink">
							<p>르 라보 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/024901_3.jpg?sf=webp&RS=131X131" alt="르 라보 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=026401" rel="nosublink">
							<p>오리진스 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/026401_3.jpg?sf=webp&RS=131X131" alt="오리진스 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=026701" rel="nosublink">
							<p>랩시리즈 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/026701_3.jpg?sf=webp&RS=131X131" alt="랩시리즈 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=028401" rel="nosublink">
							<p>프레데릭 말</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/028401_3.jpg?sf=webp&RS=131X131" alt="프레데릭 말" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=067001" rel="nosublink">
							<p>크리스찬 루부탱 뷰티</p>
							<img src="https://cdn.hddfs.com/files/gd/20220829/f179847d_202208291029194800.jpg?sf=webp&RS=131X131" alt="크리스찬 루부탱 뷰티" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=057001" rel="nosublink">
							<p>킬리안</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/057001_3.jpg?sf=webp&RS=131X131" alt="킬리안" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=004901" rel="nosublink">
							<p>포레오</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/004901_3.jpg?sf=webp&RS=131X131" alt="포레오" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=023901" rel="nosublink">
							<p>펜할리곤스</p>
							<img src="https://cdn.hddfs.com/files/gd/20211020/c9d90fa9_202110201126129160.jpg?sf=webp&RS=131X131" alt="펜할리곤스" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=601401" rel="nosublink">
							<p>정관장</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/601401_3.jpg?sf=webp&RS=131X131" alt="정관장" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=064301" rel="nosublink">
							<p>라티잔 퍼퓨머</p>
							<img src="https://cdn.hddfs.com/files/gd/20211116/58a8c781_202111161658026460.jpg?sf=webp&RS=131X131" alt="라티잔 퍼퓨머" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=021901" rel="nosublink">
							<p>구찌 타임피스 앤 주얼리</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/021901_3.jpg?sf=webp&RS=131X131" alt="구찌 타임피스 앤 주얼리" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=621700" rel="nosublink">
							<p>LG 생활건강</p>
							<img src="https://cdn.hddfs.com/files/gd/20211230/2770170e_202112301024035510.jpg?sf=webp&RS=131X131" alt="LG 생활건강" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=007101" rel="nosublink">
							<p>라로슈포제 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/007101_3.jpg?sf=webp&RS=131X131" alt="라로슈포제 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=622101" rel="nosublink">
							<p>설화수</p>
							<img src="https://cdn.hddfs.com/files/gd/20220622/c0e7428b_202206221414438690.jpg?sf=webp&RS=131X131" alt="설화수" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=007001" rel="nosublink">
							<p>비쉬 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/007001_3.jpg?sf=webp&RS=131X131" alt="비쉬 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				<li>
						<a  href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=659901" rel="nosublink">
							<p>오에라</p>
							<img src="https://cdn.hddfs.com/files/gd/20220622/a84a5db1_202206221546194980.jpg?sf=webp&RS=131X131" alt="오에라" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=131X131';">
						</a>
					</li>
				</ul>
        </li>
       	<li>
            <strong>행사중인 브랜드</strong>
            <ul class="depth_02 gnb_brand interestBranList">
            	<li class="interest006301">
						<a href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=006301" rel="nosublink">
							<p>랑콤</p>
							<img src="https://cdn.hddfs.com/files/gd/20220504/c20154c6_202205041256272420.jpg?sf=webp&RS=84X84" alt="랑콤" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=84X84';">
						</a>
					</li>
				<li class="interest063001">
						<a href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=063001" rel="nosublink">
							<p>케라스타즈</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/063001_3.jpg?sf=webp&RS=84X84" alt="케라스타즈" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=84X84';">
						</a>
					</li>
				<li class="interest006701">
						<a href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=006701" rel="nosublink">
							<p>아틀리에 코롱 </p>
							<img src="https://cdn.hddfs.com/files/gd/bran/006701_3.jpg?sf=webp&RS=84X84" alt="아틀리에 코롱 " onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=84X84';">
						</a>
					</li>
				<li class="interest634601">
						<a href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=634601" rel="nosublink">
							<p>글램팜</p>
							<img src="https://cdn.hddfs.com/files/gd/20220802/10efd3eb_202208021055439310.jpg?sf=webp&RS=84X84" alt="글램팜" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=84X84';">
						</a>
					</li>
				<li class="interest660101">
						<a href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=660101" rel="nosublink">
							<p>솔트레인</p>
							<img src="https://cdn.hddfs.com/files/gd/20220627/1f51c58f_202206271114566470.jpg?sf=webp&RS=84X84" alt="솔트레인" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=84X84';">
						</a>
					</li>
				<li class="interest063201">
						<a href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=063201" rel="nosublink">
							<p>모라츠</p>
							<img src="https://cdn.hddfs.com/files/gd/bran/063201_3.jpg?sf=webp&RS=84X84" alt="모라츠" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=84X84';">
						</a>
					</li>
				<li class="interest657201">
						<a href="https://www.hddfs.com/shop/dm/bran/brand.do?onlnBranCd=657201" rel="nosublink">
							<p>유에프씨 스포츠</p>
							<img src="https://cdn.hddfs.com/files/gd/20220214/82ce4320_202202141536535810.JPG?sf=webp&RS=84X84" alt="유에프씨 스포츠" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/noimg.png?sf=webp&RS=84X84';">
						</a>
					</li>
				</ul>
        </li>
    </ul>
</div><button class="gnb_close">닫기</button>
	    </nav>
	</header><!-- // header -->
	    <!-- container -->
		<main id="container" >
			<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/jquery-barcode.js?ver=18"></script>
<script type="text/javascript">

$(function(){
	
    $("#allCheck").change(function() {
        $(".billNos").prop("checked", $(this).prop("checked"));
    });
    
    $(".billNos").on("change", function(){
    	var len = $(".billNos").length
    	var allck = true;
    	for(var i=0; i<len; i++){
    		var ck;
    		if($(".billNos").eq(i).is(":checked")){
    			ck = true;
    		}else{
    			ck = false;
    		}
    		allck &= ck;
    	}
    	if(!allck){
    		$("#allCheck").prop("checked", "");
    	}else{
    		$("#allCheck").prop("checked", "checked");
    	}
    });

    
    var myhdsetLen = $(".myhdset-swiper").length
    for(var i=1; i<=myhdsetLen; i++){
    	var myhdsetswiper = $(".set_"+i).length
    	if(myhdsetswiper > 6){
            var myhdSetProductitemswiper = new Swiper('.myhdset_'+i, {
                slidesPerView: 'auto',
                observer:true,
                observeParents:true,
                navigation: {
                    prevEl: ".myhdsetproduct .swiper-prev",
                    nextEl: ".myhdsetproduct .swiper-next",
                },
            });
        }
        else{
            $(".myhdsetproduct .next_"+i).hide()
            $(".myhdsetproduct .prev_"+i).hide()
        }
    }
    
    
    $("#nomore_stock").dialog({
        autoOpen: false,
        resizable: false,
        dialogClass: "no_title", 
        width:295,
        minHeight: 120,
        maxHeight: 720,
        modal: true
    });
    
});

function fnCnclOrder(){
    
	// HDDFS 리뉴얼 프로젝트 [ 김진범 - 2021.10.15 ] - 주문전체 취소 (부분취소 가능할시 주석처리)
	$(".billNos").prop("checked", true);
	
    if ($("input[name='billNo']:checked").length == 0) {
        alert('선택된 상품이 없습니다.'); 
        return false;
    }
    
    
    if($("#depositWaitYn").val() == "Y"){
        if($("#orderBillCnt").val() != $("input[name='billNo']:checked").length){
            alert('입금대기 상태는 전체 주문취소만 가능합니다.'); 
            return false;
        }
    }
    
    
    var partMinQtyCncl = "Y";
    var cnclMinQty = "";
    var onlnGoosCdArr  = new Array();
    var goosQtyArr = new Array();

    
    var delDupGoosInfo = {};
    var delMinQtyInfo = {};
	var allGoosQtyInfo = {};
    
    var billNos2 = [];
    $("input[name='billNo']").each(function() {
        billNos2.push($(this).val());
        var vBillNo = $(this).val();
        
        var orderStat = $("#orderStat_"+vBillNo).val();
        
        if(orderStat == "010" || orderStat == "020"){
        	$("input[name='onlnGoosCd_"+vBillNo+"']").each(function(){
                var vOnlnGoosCd = $(this).val();
                var vGoosQty = $(this).parent().find("input.qty_"+ vBillNo + "_" + vOnlnGoosCd).val();
                
                var inputGoosQty = Number(allGoosQtyInfo[vOnlnGoosCd]);
                
                if(inputGoosQty > 0){
                    var sumGoosQty = Number(inputGoosQty) + Number(vGoosQty);
                    allGoosQtyInfo[vOnlnGoosCd] = sumGoosQty.toString();
                }else{
                	allGoosQtyInfo[vOnlnGoosCd] = vGoosQty.toString();
                }
            });
        }
    });
    
    $("input[name='billNo']:checked").each(function() {
        var vBillNo = $(this).val();
        
        $("input[name='onlnGoosCd_"+vBillNo+"']").each(function(){
            var vOnlnGoosCd = $(this).val();
            var vGoosQty = $(this).parent().find("input.qty_"+ vBillNo + "_" + vOnlnGoosCd).val();
            var vMinQty = $(this).parent().find("input.minQty_"+ vBillNo + "_" + vOnlnGoosCd).val();
            
            var inputGoosQty = Number(delDupGoosInfo[vOnlnGoosCd]);
            
            if(inputGoosQty > 0){
                var sumGoosQty = Number(inputGoosQty) + Number(vGoosQty);
                delDupGoosInfo[vOnlnGoosCd] = sumGoosQty.toString();
            }else{
                delDupGoosInfo[vOnlnGoosCd] = vGoosQty.toString();
            }
            delMinQtyInfo[vOnlnGoosCd] = vMinQty;
        });
    });
    $("input[name='onlnGoosCd']").each(function(){
    	var vGoosCd = $(this).val();
    	if(parseInt(allGoosQtyInfo[vGoosCd]) - parseInt(delDupGoosInfo[vGoosCd]) < parseInt(delMinQtyInfo[vGoosCd]) && parseInt(allGoosQtyInfo[vGoosCd]) != parseInt(delDupGoosInfo[vGoosCd])){
    		partMinQtyCncl = 'N'
    		cnclMinQty = delMinQtyInfo[vGoosCd];
    	}
    })
    if(partMinQtyCncl == 'N'){
    	alert('%s개 이상 주문이 가능한 상품으로, 취소를 원하시면 고객센터로 문의해주세요.'.replace("%s",cnclMinQty));
		return false;
    }
    
    if($("#partCnclPsbYn").val() == "N"){
        if($("#orderBillCnt").val() != $("input[name='billNo']:checked").length){
            alert('부분취소 불가 브랜드가 포함되어, 전체 취소 후 재결제 바랍니다.'); 
            return false;
        }
    }
    
    if($("#partCnclPmptDcYn").val() == "N"){
        if($("#orderBillCnt").val() != $("input[name='billNo']:checked").length){
            alert('전체 주문취소만 가능합니다.'); 
            return false;
        }
    }
    
    var cnclPsbYn = "Y";
    var billNos = [];
    $("input[name='billNo']:checked").each(function() {
        billNos.push($(this).val());
        
        
        var orderStat = $("#orderStat_"+$(this).val()).val();
        if(orderStat != "010" && orderStat != "020"){
            cnclPsbYn = "N";
        }
    });
    if(cnclPsbYn == "N"){
        var consmTeln = '1811-6688';
        
        alert('취소가 불가능한 주문건입니다. 고객센터에 문의해주세요.'+'('+consmTeln+')');
        return false;
    } else {
        $.ajax({
            async : true,
            url : ctx_curr + "/mm/myOrder/listOrderAprtEvtApplBillInfoByOrderNoAndBillNos.json",
            dataType : "json",
            type : "POST",
            data : {orderNo : 'OR2022091400561', billNos : billNos.join(",")},
            success : function(data, textStatus, jqXHR) {
                if(!crew.ajaxValidate(data)){ return; }
                
                if(isEmpty(data.billNoList)) {
                    if("false"){
                    	
                        fnSetGoosYn(billNos);   
                    }
                    else
                    {
                        popOpen(ctx_shop+'/mm/myOrder/cnclOrder.do?orderNo=OR2022091400561&billNos='+billNos, '주문취소', 720, 800); 
                    }
                } else {
                    var fregBillNoList = data.billNoList;
                    var fregfNm = isEmpty(data.fregfNm) ? "" : "('" + data.fregfNm + "')";
					var fregfConfirmMsg = "본 교환권은 사은품 %s 지급조건에 의해 교환권 (%s)와 같이 취소 가능합니다. 취소하시겠습니까?".replace("%s", fregfNm).replace("%s", fregBillNoList.join(","));
                    
                    if(confirm(fregfConfirmMsg)) {
                        for(var i=0 ; i < fregBillNoList.length ; i++) {
                            billNos.push(fregBillNoList[i]);
                        }
                        if("false"){
                        	
                            fnSetGoosYn(billNos);
                        }
                        else
                        {
                            popOpen(ctx_shop+'/mm/myOrder/cnclOrder.do?orderNo=OR2022091400561&billNos='+billNos, '주문취소', 720, 800); 
                        }
                    }
                }
            }, error : function(jqXHR, textStatus, errorThrown){
                
            }
        });
    }
}


function fnSetGoosYn(billNos){
     $.ajax({
         async : true,
         url : ctx_curr + "/mm/myOrder/listOrderSetGoosApplBillInfoByOrderNoAndBillNos.json",
         dataType : "json",
         type : "POST",
         data : {orderNo : 'OR2022091400561', billNos : billNos.join(",")},
         success : function(data, textStatus, jqXHR) {
             if(!crew.ajaxValidate(data)){ return; }
             
             if(isEmpty(data.billNoList)) {
                 popOpen(ctx_shop+'/mm/myOrder/cnclOrder.do?orderNo=OR2022091400561&billNos='+billNos, '주문취소', 720, 800);
             } else {
                var setGoosBillNoList = data.billNoList;
                var setGoosNm = isEmpty(data.setGoosNm) ? "" : "('" + data.setGoosNm + "')";
				var setConfirmMsg = "본 교환권은 세트할인행사 %s 지급조건에 의해 교환권 (%s)와 같이 취소 가능합니다. 취소하시겠습니까?".replace("%s", setGoosNm).replace("%s", setGoosBillNoList.join(","));
				
				if(confirm(setConfirmMsg)) {
                     for(var i=0 ; i < setGoosBillNoList.length ; i++) {
                         billNos.push(setGoosBillNoList[i]);
                     }
                     
                     popOpen(ctx_shop+'/mm/myOrder/cnclOrder.do?orderNo=OR2022091400561&billNos='+billNos, '주문취소', 720, 800);
                 }
             }
         }, error : function(jqXHR, textStatus, errorThrown){
            
         }
     });
}


function fnReOrder(){
    
	

    if ($("input[name='billNo']:checked").length == 0) {
        alert('선택된 상품이 없습니다.'); 
        return false;
    }
    
    var onlnGoosCdArr  = new Array();
    var goosQtyArr = new Array();

    
    var delDupGoosInfo = {};
    
    
    var vSpordGoosYn = "";
    
    $("input[name='billNo']:checked").each(function() {
        var vBillNo = $(this).val();
        
        
        $("input[name='spordGoosYn_"+vBillNo+"']").each(function(){
            if(vSpordGoosYn != "Y"){
                vSpordGoosYn = $(this).val();
            }
        });
        
        $("input[name='onlnGoosCd_"+vBillNo+"']").each(function(){
            var vOnlnGoosCd = $(this).val();
            var vGoosQty = $(this).parent().find("input.qty_"+ vBillNo + "_" + vOnlnGoosCd).val();
            
            var inputGoosQty = Number(delDupGoosInfo[vOnlnGoosCd]);
            
            if(inputGoosQty > 0){
                var sumGoosQty = Number(inputGoosQty) + Number(vGoosQty);
                delDupGoosInfo[vOnlnGoosCd] = sumGoosQty.toString();
            }else{
                delDupGoosInfo[vOnlnGoosCd] = vGoosQty.toString();
            }
            
        });
    });
    
    
    for(var key in delDupGoosInfo){
        onlnGoosCdArr.push(key);
        goosQtyArr.push(delDupGoosInfo[key]);
    }
    
    
    if(vSpordGoosYn == "Y"){
        alert('스페셜오더 상품은 재구매가 불가 합니다.');  
        return false;
    }
    
    $.ajax({
        async       : true,
        url         : ctx_curr + "/cm/comm/checkOrderAbleGoos.json",
        dataType    : "json",
        type        : "POST",
        data        : { onlnGoosCdList : onlnGoosCdArr.join(","), goosQtyList : goosQtyArr.join(",") },
        success     : function(data, textStatus, jqXHR){
            if(!crew.ajaxValidate(data)){ return; }
             
            if(data.info.stocGoosList.length != 0){
                var onlnGoosCd = data.info.stocGoosList[0];
                var info = data.info.chkInfo[onlnGoosCd];
                openStocInfo(onlnGoosCd, info.goosNm);
            }else{
            	
                newAddCartMulti(onlnGoosCdArr.join(","), goosQtyArr.join(","), '', '', 'order', 'Y' , '', '', 'I');
            }
            
        },
        error       : function(jqXHR, textStatus, errorThrown){
        }
    });
}


function openStocInfo(onlnGoosCd, goosNm){
    $("#nomoreStockGoosNm").html(goosNm);
    $("#nomoreStockGoosCd").val(onlnGoosCd);
    
	$("#pw_error").dialog({
		resizable: false,
		width:400,
		maxHeight: 720,
		modal: true
	});
	$("#pw_error").show();
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


function fnPrintCoupPop(orderNo){
	popOpen(ctx_shop+"/mm/myOrder/printCoup.do?orderNo="+orderNo+"&billNo=&printYn=Y","printCoupPop",430,800);
}


function fnPrintReceipt(orderNo, billNo){
	 popOpen(ctx_shop+"/mm/myOrder/printReceipt.do?orderNo="+orderNo+"&billNo="+billNo,"printReceiptPop",720,800);
 }

 
function fnPsptChg(orderNo){
	
	if ($("input[name='billNo']:checked").length == 0) {
        alert('선택된 상품이 없습니다.'); 
        return false;
    }
	
	var chgPsptYn = "Y";
	$("input[name='billNo']:checked").each(function() {
        var orderStat = $("#orderStat_"+$(this).val()).val();
        if(orderStat == "100" || orderStat == "900"){
        	chgPsptYn = "N";
        }
    });
	if(chgPsptYn == "N"){
        alert('출국정보를 변경할 수 없는 주문입니다');
        return false;
    }
	
	if(!confirm("선택하신 교환권에 대한 주문번호의 \n출국정보가 모두 변경됩니다. \n해당 주문번호의 출국정보를 변경하시겠습니까? \n(교환권별 출국정보 변경 : 고객센터 ☏1811-6688)")){
		return;
	}
	
    
        alert('출국정보 변경이 불가합니다.'); 
}


function showMoreCnclInfo(obj,cnclDiv) {
    $("#"+cnclDiv).show();
    $(obj).parent().remove();
}


function fnSmsCoup(){
    
    $.ajax({
        async       : true,
        url         : ctx_curr+"/mm/myOrder/sendSmsCoup.json",
        dataType    : "json",
        type        : "POST",
        cache       : false,
        data        : {
            orderNo     : 'OR2022091400561',
            toName      : '김민선',
            toPhone     : '01051982880'
        },
        success     : function(data, textStatus, jqXHR){
            if(!crew.ajaxValidate(data)){ return; }
            
            alert('교환권이 SMS로 발송되었습니다.');   
        },
        error       : function(jqXHR, textStatus, errorThrown){
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
            	<strong>
		            김*선</strong> <em>님</em>
            	</p>
            <p class="passinfo">
                        <span>M978*****</span> 
                        <span>2026-11-01</span></p>
                <div class="mylv">
                <span class="lv_on_up001"></span>
                <span class="lv_off_up002"></span>
                </div>
        </div>
        <div class="mypresent">
            <dl>
                <a href="https://www.hddfs.com/shop/mm/myBnf/listSvmt.do">
                    <dt>적립금</dt>
                    <dd id="svmtAmt"><strong>0</strong>원</dd>
                </a>                   
            </dl>
            <dl>
                <a href="https://www.hddfs.com/shop/mm/myBnf/listCup.do">
                    <dt>쿠폰</dt>
                    <dd><strong>0</strong>장</dd>
                </a>
            </dl>
            <dl>
                <a href="https://www.hddfs.com/shop/mm/myBnf/listGfca.do">
                    <dt>예치금</dt>
                    <dd id="mainCdpst"><strong>0</strong>원</dd>
                </a>
            </dl>
            <dl>
                <a href="https://www.hddfs.com/shop/mm/myBnf/listGfca.do?gfcaClsType=GFCA">
                    <dt>상품권 전환금</dt>
                    <dd><strong>0</strong>원</dd>
                </a>
            </dl>
            <dl>
                <dt>H.Point</dt>
                    <dd id="hpointAmt"><strong>0</strong>P</dd>
                </dl>
            <dl>
	                <dt>H.Point Plus 포인트</dt>
	                <dd><a href="https://www.h-point.co.kr/cu/main/index.nhd">조회</a></dd>
	                </dl>
            <dl>
	                <dt>구매금액</dt>
	                <dd id="setTotBuyAmtNtnl"><strong>$0</strong></dd>
	            </dl>
	            <dl>
	                <a href="https://www.hddfs.com/shop/om/consmCont/mbshLvlInfo.do">
	                    <dt>승급잔여금액</dt>
	                    <dd id="setRestPrice"><strong>$0</strong></dd>
	                </a>
	            </dl>
            <dl>&nbsp;</dl>
            <dl>&nbsp;</dl>
        </div>
    </div>
    <div class="mymenu">
        <p class="ti">My Hyundai
        <ul>
            <li><a nohref onclick="goUrl('/mm/myOrder/listOrder.do');">주문내역</a></li>
            <li><a nohref onclick="goUrl('/mm/myOrder/listSpord.do');">스페셜오더/H.Share</a></li>
            
            <li id="hPointPay"><a nohref onclick="goHPointPay('bb2880');">H.Point Pay 관리</a></li>
          
            <li><a nohref onclick="goUrl('/mm/myBnf/listSvmt.do');">적립금내역</a></li>
            <li><a nohref onclick="goUrl('/mm/myBnf/listCup.do');">쿠폰내역</a></li>
            <li><a nohref onclick="goUrl('/mm/myBnf/listGfca.do');">예치금/상품권전환금</a></li>
            <li><a nohref onclick="goUrl('/mm/myOrder/listBrandAlarm.do');">알림 신청 내역</a></li>
            <li><a nohref onclick="goUrl('/mm/myEvntSpex/listEvntPtcp.do');">나의 이벤트/기획전</a></li>
            <li><a nohref onclick="goUrl('/mm/myCont/listCnrGoos.do');">관심 상품/브랜드</a></li>
            <li><a nohref onclick="goUrl('/mm/myCont/listCounQustBbs.do');">문의내역</a></li>
            <li><a nohref onclick="goUrl('/mm/grvws/mainGrvws.do');">상품평</a></li>
            <li><a nohref onclick="goUrl('/mm/myInfo/inptMbshPwd.do?type=base');">기본정보관리</a></li>
            <li><a nohref onclick="goUrl('/mm/myInfo/inptMbshPwd.do?type=pspt');">여권정보관리</a></li>
            <li><a nohref onclick="goUrl('/mm/myInfo/listMbshDpatInfo.do');">출국정보관리</a></li>
            <li><a nohref onclick="liMyChgPwd();">비밀번호변경</a></li>
            <li><a nohref onclick="goUrl('/mm/myInfo/snsConn.do');">SNS 간편로그인 설정</a></li>
        </ul>
        <button class="btn_view">메뉴더보기</button>
        </p>
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
</script><article id="content">
	<section class="myhd_content">
		<div class="cont_stit">
			<h3>주문내역</h3>
		</div>
		<div class="box_gray2">
			<dl class="order_info">
				<dt>주문번호</dt>
				<dd>OR2022091400561</dd>
				<dt>주문일시</dt>
				<dd>2022-09-14 21:23</dd>
				<dt>주문상태</dt>
				<dd>입금대기</dd>
			</dl>
		</div>
		<div class="sorting_wrap myhd">
			<div class="sort_r">
			     </div>
		</div>
		
        <div id="onlnlist">
			<div class="list_table01">
				<table>
					<colgroup> 
						<col width="50px">
						<col width="140px">
						<col width="290px">
						<col width="95px">
						<col width="100px">
						<col width="55px">
						<col width="100px">
						<col width="100px">
						<col width="150px">
					</colgroup>
					<tbody>
						<tr>
							<th><span class="chk nolabel"> <input type="checkbox" id="allCheck"> <label for="allCheck">선택</label></span></th>
							<th>교환권번호</th>
							<th>상품명</th>
							<th>교환권상태</th>
							<th>판매금액</th>
							<th>수량</th>
							<th>할인금액</th>
							<th>적립금사용</th>
							<th>결제금액</th>
						</tr>
						<input type="hidden" name="onlnGoosCd_0122091480101523" value="56341490000701">
	                        <input type="hidden" name="onlnGoosCd" value="56341490000701">
	                        <input type="hidden" name="spordGoosYn_0122091480101523" value="N">
	                        <input type="hidden" class="qty_0122091480101523_56341490000701" value="2">
	                        <input type="hidden" value="1" class="minQty_0122091480101523_56341490000701">
                            <tr>
						  <td rowspan="1"><span class="chk nolabel">
									   <input type="hidden" id="orderStat_0122091480101523" value="010" >
								       <input type="checkbox" name="billNo" id="ch1" class="billNos" value="0122091480101523" > <label for="ch1">선택</label>
								  </span>
							  </td>
							  <td rowspan="1" class="td_btns"><p>0122091480101523</p>
                                  </td>
							<td>
                                 <a href='https://www.hddfs.com/shop/gd/dtl/goos.do?onlnGoosCd=56341490000701'" style="cursor: pointer;" class="product_info"> <span class="on_img"><img src="https://cdn.hddfs.com/files/goos/6341/20190904/ebdd39e5.JPG?sf=webp&RS=200X200" alt="클래식 해수진주 목걸이(W.G)" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/no_img252.jpg';"></span>
                                    <dl>
                                        <dt>포씨엘</dt>
                                        <dd>클래식 해수진주 목걸이(W.G)</dd>
                                        <dd>SKU NO : 563414900007</dd>
                                    </dl>
                                 </a>
                            </td>
							<td>
                                 입금대기</td>
							<td>
							     <del class="delprice">$246</del>
							     <p class="dollar c_dark">$221.4</p>
						    </td>
							<td>2</td>
							<td>
								<p class="dollar c_dark">$56.44</p>
								<p class="k_won">77,955<span>원</span></p>
							</td>
							<td>
								<p class="dollar c_dark">$7.24</p>
								<p class="k_won">10,000<span>원</span>
								</p>
							</td>
							<td>
								<p class="dollar">$435.56</p>
								<p class="k_won">601,595<span>원</span>
								</p>
							</td>
						</tr>
						<input type="hidden" name="onlnGoosCd_0122091480205720" value="10004820003101">
	                        <input type="hidden" name="onlnGoosCd" value="10004820003101">
	                        <input type="hidden" name="spordGoosYn_0122091480205720" value="N">
	                        <input type="hidden" class="qty_0122091480205720_10004820003101" value="1">
	                        <input type="hidden" value="1" class="minQty_0122091480205720_10004820003101">
                            <tr>
						  <td rowspan="1"><span class="chk nolabel">
									   <input type="hidden" id="orderStat_0122091480205720" value="010" >
								       <input type="checkbox" name="billNo" id="ch2" class="billNos" value="0122091480205720" > <label for="ch2">선택</label>
								  </span>
							  </td>
							  <td rowspan="1" class="td_btns"><p>0122091480205720</p>
                                  </td>
							<td>
                                 <a href='https://www.hddfs.com/shop/gd/dtl/goos.do?onlnGoosCd=10004820003101'" style="cursor: pointer;" class="product_info"> <span class="on_img"><img src="https://cdn.hddfs.com/files/goos/0004/20210929/2bc2b998.jpg?sf=webp&RS=200X200" alt="트리플러스 우먼 90C(성인 여성의 필수 영양에 맞춘 멀티비타민, 미네랄, 오메가-3 함유, 면역력 강화, 항산화에 도움)" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/no_img252.jpg';"></span>
                                    <dl>
                                        <dt>세노비스</dt>
                                        <dd>트리플러스 우먼 90C(성인 여성의 필수 영양에 맞춘 멀티비타민, 미네랄, 오메가-3 함유, 면역력 강화, 항산화에 도움)</dd>
                                        <dd>SKU NO : 100048200031</dd>
                                    </dl>
                                 </a>
                            </td>
							<td>
                                 입금대기</td>
							<td>
							     <del class="delprice">$41</del>
							     <p class="dollar c_dark">$22.55</p>
						    </td>
							<td>1</td>
							<td>
								<p class="dollar c_dark">$18.45</p>
								<p class="k_won">25,483<span>원</span></p>
							</td>
							<td>
								<p class="dollar c_dark">$0</p>
								<p class="k_won">0<span>원</span>
								</p>
							</td>
							<td>
								<p class="dollar">$22.55</p>
								<p class="k_won">31,146<span>원</span>
								</p>
							</td>
						</tr>
						</tbody>
				</table>
		    <input type="hidden" id="showCoupYn" value="N">
            <input type="hidden" id="depositWaitYn" value="Y">
            <input type="hidden" id="orderBillCnt" value="2">
            <input type="hidden" id="partCnclPsbYn" value="Y">
			</div>
		</div>
        <div class="cont_stit">
			<h3>결제 정보</h3>
		</div>

		<div class="payment_infobox">
			<div class="paybox">
				<div>
					<strong class="total_tit">총 주문금액</strong>
					<p class="pay_dollar">$533</p>
					<p class="pay_won">736,179<span>원</span>
					</p>
					<div class="cost_list">
						<dl>
							<dt>상품종류</dt>
							<dd>
							     2<span>종</span>
							</dd>
						</dl>
						<dl>
							<dt>상품수량</dt>
							<dd>
								3<span>개</span>
							</dd>
						</dl>
						<dl class="tax_limit">
							<dt>면세한도 적용금액</dt>
							<dd>
								<strong>$458.11</strong>
							</dd>
						</dl>
					</div>
					<small>(국내/외 브랜드 구매금액 모두 포함)</small>
				</div>
				<div class="discount_total">
					<strong class="total_tit">총 할인금액</strong>
					<p class="pay_dollar">$74.89</p>
					<p class="pay_won">103,438<span>원</span></p>
					<div class="cost_list">
						<dl>
                            <dt>인터넷회원할인(비과세)</dt>
                            <dd>
                                93,438<span>원</span>
                            </dd>
                        </dl>
                        <input type="hidden" id="partCnclPmptDcYn" value="Y">
						<dl>
							<dt>할인적립금 사용(비과세)</dt>
							<dd>
								10,000<span>원</span>
							</dd>
						</dl>
						</div>
				</div>
				<div>
					<strong class="total_tit">최종 결제금액</strong>
					<p class="pay_dollar">$458.11</p>
					<p class="pay_won">
						632,741<span>원</span>
					</p>
					<div class="cost_list">
	                    <dl>
		                            <dt>H.Point</dt>
		                            <dd>
		                                1,265<span>P</span>
		                            </dd>
		                        </dl>
		                    </div>
					</div>
			</div>
			<div class="btn_area">
				<a href="javascript:void(0);" class="btnde_type14 mid" onclick="fnCnclOrder();">주문취소</a>
				<a href="javascript:void(0);" class="btnde_type14 mid bg_black" onclick="fnReOrder();">동일상품 재구매</a>
			</div>
		</div>
		<div class="box_gray2 por">
			<p>주문/취소/반품관련 문의사항은 1:1 상담문의를 통해 이용하실 수 있습니다.</p>
			<div class="poa_rbtn">
				<button onclick="location.href='https://www.hddfs.com/shop/om/consmCoun/addCoun.do'" class="btnc_type_s">1:1 상담문의</button>
			</div>
		</div>
		<div class="cont_stit">
			<h3>주문자/여권정보</h3>
		</div>
		<div class="info_table">
			<table>
				<colgroup>
					<col style="width: 150px">
					<col style="width: 390px">
					<col style="width: 150px">
					<col style="width: auto">
				</colgroup>
				<tr>
					<th>아이디/성명</th>
					<td>bb2880 / 김민선</td>
					<th>성별</th>
					<td>여</td>
				</tr>
				<tr>
					<th>영문성명</th>
					<td>KIM MINSUN</td>
					<th>생년월일</th>
					<td>1996-06-03</td>
				</tr>
				<tr>
					<th>국적</th>
					<td>한국</td>
					<th>휴대폰번호</th>
					<td>
	                    
	                         +82-
	                     010-5198-2880</td>
				</tr>
				<tr>
					<th>여권번호</th>
					<td>M97841669</td>
					<th>긴급연락처</th>
					<td>
					   
                             +82-
                        010-5198-2880</td>
				</tr>
				<tr>
					<th>여권만료일</th>
					<td>2026-11-01</td>
					<th></th>
					<td></td>
				</tr>
			</table>
		</div>
		<div class="cont_stit por" id="listOrderStat">
			<h3>출국정보</h3>
			<div class="poa_rbtn">
	            </div>
		</div>
		<div class="info_table" id="departInfo">
			<table>
				<colgroup>
					<col style="width: 150px">
					<col style="width: 390px">
					<col style="width: 150px">
					<col style="width: auto">
				</colgroup>
				<tr>
					<th>출국장소</th>
					<td>인천공항</td>
					<th>출국일시</th>
					<td>2022-09-23&nbsp;10:00</td>
				</tr>
				<tr>
					<th>직항/경유</th>
					<td>
					   <dd id = "drtaYn">직항</dd>
	                       </td>
					<th>편명</th>
					<td>KE081</td>
				</tr>
			</table>
		</div>

		<div class="cont_stit">
			<h3>결제정보</h3>
		</div>
		<div class="list_table01">
			<table>
				<colgroup>
					<col width="200px">
					<col width="370px">
					<col width="150px">
					<col width="200px">
					<col width="150px">
				</colgroup>
				<tbody>
					<tr>
						<th>선택 결제수단</th>
						<th>상세정보</th>
						<th>결제금액</th>
						<th>결제일시</th>
						<th>결제상태</th>
					</tr>
					<tr>
                                    <td>무통장입금</td>
                                    <td>
                                        농협은행79005463805201 / 예금주:(주)현대백화점면세점<br/>(입금기한: 2022-09-14&nbsp;23:54 / 입금자: 김민선 )
                                    </td>
                                    <td>632,741원</td>
                                    <td>
                                        -</td>
                                    <td>주문완료</td>
                                </tr>
	                       </tbody>
			</table>
		</div>
        <div class="cont_stit">
			<h3>인도장 안내</h3>
		</div>
		<div class="airport_map">
			<img class="map_img" src="https://cdn.hddfs.com/files/om/20181005/3431816b_201810051530069510.jpg?sf=webp" alt="인도장 이미지" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/no_img666x310.jpg';">
			<dl class="map_info">
				<dt>위치안내</dt>
				<dd>
					인천공항 T2 2번 출입국 심사대 통과 후 252번 게이트 건너편 4층</dd>
				<dt>문의안내</dt>
				<dd>인도장 : 1811-6688</dd>
				<dt>상담시간</dt>
				<dd>09:30 ~ 18:30</dd>
			</dl>
		</div>
		<div class="attention_area">
				<p class="attention_tit">유의사항</p>
				<div class="attention_list">
					&bull; 결제 완료 후 주문 내역에서 구매하신 상품이 확인되지 않을 경우 로그아웃 후 재로그인 해주시기 바랍니다.<br />
<br />
&bull; 아래의 경우 인도장에서 상품 수령이 제한되오니 반드시 확인해 주시기 바랍니다.<br />
- 주문하신 고객님과 출국하시는 고객님의 정보가 불일치 할 경우<br />
- 주문서에 기재된 여권번호와 출국 시 여권번호가 불일치 할 경우<br />
- 등록된 출국정보(출국장소, 출국일시, 편명 등)와 실 출국정보가 다른 경우<br />
<br />
&bull; 출국 정보 변경을 원하실 경우, 출국일 최소 3일 전에 고객센터로 연락해 주시기 바랍니다.(단, 지방공항 이용 시 4일전)<br />
&bull; 출국 시 인도받지 못한 물건은 고객센터로 연락 바랍니다.<br />
&bull; 주문에 대한 궁금하신 사항은 FAQ에서 확인이 가능합니다. FAQ 바로가기<br />
&bull; 추가 궁금하신 내용은 고객센터 (1811-6688 / 운영시간 09:30~18:30) 로 문의바랍니다.
					<a href="https://www.hddfs.com/shop/om/consmComm/faq.do" class="link_txt_point">FAQ 바로가기</a>
				</div>
			</div>
		<div id="printCoup"></div>
<div id="psptChg"></div>

<input type="hidden" id="nomoreStockGoosCd" />
<div id="pw_error" title="재고 부족 안내" style="display:none">
    <div class="layer_popup">
        <div id="pw_error" title="재고 부족 안내">
			<div class="message_box">
				<p class="small_txt">고객님께서 재구매를 원하시는 상품<br>[<span id="nomoreStockGoosNm"></span>] 상품은 재고가 부족합니다.</p>
				<p class="small_txt">재입고알림을 신청하시겠습니까?</p>
			</div>
			<div class="basic_btn_box mgtsm">
				<button type="button" class="btn_basic1" onclick="$('#pw_error').dialog('close');">취소</button>
				<a href="javascript:void(0);" class="btn_basic2" onclick="$('#pw_error').dialog('close');addAginRecpNtc($('#nomoreStockGoosCd').val());">재입고알림</a>
			</div>
		</div>
    </div>




</div>
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
<footer id="footer">
    <div class="policy">
        <div class="box">
            <div class="policy_menu">
                <a href="https://www.hddfs.com/store/kr/dm/main.do" target="_blank">현대백화점  DUTY FREE 소개</a>
                <a href="https://www.hddfs.com/shop/om/consmCont/stoPtnsQust.do">입점/제휴</a>
                <a href="https://www.hddfs.com/shop/om/consmCont/selectMbshJoinTcnd.do?mbshJoinTcndCd=001">이용약관</a>
                <a href="https://www.hddfs.com/shop/om/consmCont/selectMbshJoinTcnd.do?mbshJoinTcndCd=008">
                    <strong>개인정보처리방침</strong>
                </a>
                <a href="https://www.hddfs.com/shop/om/consmCont/selectMbshJoinTcnd.do?mbshJoinTcndCd=005">영상정보처리기기 운영 / 관리방침</a>
                <a href="javascript:" onclick="popEmailReject();">이메일무단수집거부</a>
            </div>
            <div class="family_site">
                <button>Family Site</button>
                <div class="list">
                    <p>쇼핑몰 사이트</p>
                    <ul>
                        <li><a href="http://www.hyundaihmall.com/" target="_blank">현대Hmall</a></li>
                        <li><a href="http://www.thehyundai.com/" target="_blank">더현대닷컴</a></li>
                        <li><a href="http://www.thehandsome.com/" target="_blank">더한섬</a></li>
                        <li><a href="http://mall.hyundailivart.co.kr/" target="_blank">현대리바트몰</a></li>
                        <li><a href="http://www.hyundairentalcare.co.kr/" target="_blank">현대렌탈케어</a></li>
                        <li><a href="http://www.hfashionmall.com/" target="_blank">H패션몰</a></li>
                        <li><a href="http://www.h-vrstation.com/" target="_blank">VR STATION</a></li>
                    </ul>
                    <p>관계사 사이트</p>
                    <ul>
                        <li><a href="http://www.ehyundai.com/newPortal/ir/main.do" target="_blank">현대백화점그룹</a></li>
                        <li><a href="https://www.ehyundai.com/newPortal/index.do" target="_blank">현대백화점</a></li>
                        <li><a href="https://www.hyundaihmall.com/" target="_blank">현대홈쇼핑</a></li>
                        <li><a href="https://hyundaigreenfood.com/" target="_blank">현대그린푸드</a></li>
                        <li><a href="http://www.hyundaicatering.co.kr/" target="_blank">현대캐터링시스템</a></li>
                        <li><a href="http://www.cnsfoodsystem.co.kr/" target="_blank">C&amp;S푸드시스템</a></li>
                        <li><a href="https://www.handsome.co.kr/ko/main.do" target="_blank">한섬</a></li>
                        <li><a href="https://www.hyundailivart.co.kr/" target="_blank">현대리바트</a></li>
                        <li><a href="http://www.hyundailnc.com/" target="_blank">현대L&amp;C</a></li>
                        <li><a href="http://home.hyundaidreamtour.com/" target="_blank">현대드림투어</a></li>
                        <li><a href="http://www.hyundairentalcare.co.kr/" target="_blank">현대렌탈케어</a></li>
                        <li><a href="https://www.hyundaifuturenet.co.kr/" target="_blank">현대퓨처넷</a></li>
                        <li><a href="http://www.everdigm.com/" target="_blank">에버다임</a></li>
                        <li><a href="http://www.hyundai-ite.com/" target="_blank">현대IT&amp;E</a></li>
                        <li><a href="http://www.hyundaibioland.co.kr/" target="_blank">현대바이오랜드</a></li>
                        <li><a href="https://www.ezwel.com/" target="_blank">현대이지웰</a></li>
                        <li><a href="http://www.ehyundai.com/newPortal/sc/main/main.do" target="_blank">현대백화점그룹 사회복지재단</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="copy">
        <div class="copyright">
            <div class="logo">
                <span onclick="moveToMain();" style="cursor:pointer;">HYUNDAI DEPARTMENT SHOP - DUTY FREE</span>
                <strong>주식회사 현대백화점면세점</strong>
            </div>
            <ul>
                <li>
                    <span>대표이사 : 이재실</span>
                    <span>서울특별시 강남구 영동대로82길 19</span>
                    <span>사업자등록번호 : 850-88-00325</span>
                </li>
                <li>
                    <a href="http://www.ftc.go.kr/www/bizCommView.do?key=232&apv_perm_no=2018322016230202228&pageUnit=10&searchCnd=wrkr_no&searchKrwd=8508800325&pageIndex=1" target="_blank">사업자정보확인</a>
                    <a href="javascript:" onclick="sellerInfo();">판매자별 사업자 정보</a>
                </li>
                <li>
                    <span>통신판매업신고 : 2018-서울강남-02228</span>
                    <span>개인정보보호책임자 : 반형철</span>
                    <span>호스팅사업자 : (주)현대백화점면세점</span>
                </li>
                <li>
                    <span>대표번호 : 1811-6688</span>
                    <span>대표메일 : hddfs_official@hddfs.com</span>
                </li>
            </ul>
            <p>COPYRIGHT © HYUNDAI DEPARTMENT STORE DUTY FREE. ALL RIGHTS RESERVED.</p>
            <div class="sns_link">
                <a href="https://www.facebook.com/HDDFS.official/" target="_blank"  class="facebook">facebook</a>
                <a href="https://www.instagram.com/hddfs.official/" target="_blank" class="instagram">instagram</a>
            </div>
        </div>
        <div class="escrow">
            <strong>주식회사 케이에스넷 구매안전(에스크로) 서비스 가맹점</strong>
            <span>
                안전한 전자상거래를 위해 ㈜ 케이에스넷의 구매안전(에스크로) 서비스에 <br>
                가입하여, 구매안전(에스크로) 서비스를 제공하고 있습니다.
            </span>
            <p>주식회사 케이에스넷 금융감독원 결제대금예치업</p>
            <p>등록번호 : 02-006-00002</p>
            <a href="javascript:" onclick="popOpen('http://pgims.ksnet.co.kr/pg_infoc/src/dealinfo/pg_shop_info2.jsp?shop_id=2001106156', 'popEscrowNet', 750, 300);" class="btn_escrow">가입확인하기</a>
            <ul class="ismsp">
                <li>인증범위 : 현대백화점면세점 면세점 서비스 운영</li>
                <li>유효기간 : 2019.11.27~2022.11.26</li>
            </ul>
			<div class="award">
				<a href="http://www.i-award.or.kr/Smart/Assess/FinalCandidateView.aspx?REG_SEQNO=10902" target="_blank">스마트앱어워드 2021<br>디자인 이노베이션 대상</a>
			</div><!--//award-->
			<div class="first">
				<a href="https://fba.kcforum.co.kr/2022/winner.php" target="_blank">2022 대한민국 퍼스트브랜드 대상<br>면세점 부문 대상</a>
			</div><!--//first-->
        </div>
    </div>
</footer>

<!-- 판매자별 사업자 정보 -->
<div id="seller_information" title="판매자별 사업자 정보" style="display:none;">
    <div class="layer_popup">
		<strong>(주)현대백화점면세점 무역센터점</strong>
		<dl>
        	<dt>대표이사 :&nbsp;</dt>
			<dt>이재실</dt>
		</dl>
       	<dl>
        	<dt>통신판매신고 :&nbsp;</dt>
            <dt>2018-서울강남-02228</dt>
		</dl>
		<dl>
        	<dt>사업자등록번호 :&nbsp;</dt>
        	<dt>850-88-00325</dt>
		</dl>
		<strong>(주)현대백화점면세점 동대문점</strong>
       	<dl>
        	<dt>대표이사 :&nbsp;</dt>
           	<dt>이재실</dt>
		</dl>
        <dl>
        	<dt>통신판매신고 :&nbsp;</dt>
           	<dt>2020-서울중구-0163</dt>
		</dl>
       	<dl>
        	<dt>사업자등록번호 :&nbsp;</dt>
            <dt>850-88-00325</dt>
		</dl>
	</div>
</div></div>
	<!-- 공통 팝업 정의 START -->
	<style type="text/css">
/* 레이어 팝업 */
.swiper_control {position:relative}
.swiper_control .swiper-pagination {text-align:justify; bottom:30px; left:40px; font-size:15px; font-weight:600; color:#ffffff}
.swiper_control .swiper-pagination span.space { padding:0 3px; font-weight:400}
.swiper_control .swiper-pagination span.num_total {font-weight:400}
.popswiper-container .swiper-prev {background:url('https://cdn.hddfs.com/front/images/KO/common/icon_controller.png')0 -32px no-repeat; width:9px; height:13px; position:absolute; bottom:33px; left:94px; z-index:100}
.popswiper-container .swiper-next {background:url('https://cdn.hddfs.com/front/images/KO/common/icon_controller.png')-9px -32px no-repeat; width:9px; height:13px; position:absolute; bottom:33px; left:112px; z-index:100}

.ui-dialog.ui-widget.ui-widget-content.layer_newtype {background:#fff;border-radius:20px}
.ui-dialog.layer_newtype .ui-dialog-titlebar {display:none}
</style>

<script type="text/javascript">
  
// 팝업 닫기
function closeMainLayer(popSeq){
	$("#main_bottom_pop"+popSeq).remove();
	if($(".main_popup").length <1){
		$('.modal_wrap').removeClass('active');
	}
}

// 메인레이어팝업 오늘하루 보지않기 + 쿠키저장
function saveMainLayerCookie(popSeq){
	
	// 쿠키 저장
	if($("#btn_hidden_layer_"+popSeq).attr("hiddenYn") == 'N'){
		var date = new Date();
		date.setTime(date.getTime() + (1000 * 60 * 60 * 24));
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		$.cookie("closePop" + popSeq, "Y", { expires: date, path : "/" });
		$("#main_bottom_pop"+popSeq).remove();
		if($(".main_popup").length <1){
			$('.modal_wrap').removeClass('active');
		}
	}
}

function callMainPopSwiper(){
	
	var mainpopupswiper = new Swiper('.popswiper-container', {
		slidesPerView: "auto",
		observer:true,
		observeParents:true,
		pagination:{
			el: '.swiper-pagination',
			type: 'custom',
			renderCustom: function (mainpopupswiper, current, total) {
				var customPaginationHtml = "";
				for(var i = 0; i < total; i++) {
				if(i == (current - 1)) {
					customPaginationHtml += '<span class="visual-pagination-customs visual-pagination-customs-active"></span>';
				}else{
					customPaginationHtml += '<span class="visual-pagination-customs"></span>';
				}
				}
				if(total < 10){
				total = "0" + total
				}
				if(current < 10){
				current = "0" + current
				}
				var fraction =  current + '<span class="space">/</span>'  + '<span class="num_total">'+total+'</span>';
				return  fraction;
			},
		},
		navigation: {
			nextEl: '.swiper-next',
			prevEl: '.swiper-prev',
		},
	});
}
</script>
<div class="modal_wrap mainPopWrap">
</div>  <!-- 공통 팝업 정의 ENd -->
	<div class="layer_unit pop_o8_adult" style="display:none">
    <div class="layer_popup">
        <div class="layer_cont">
            <p class="txt_ty1">성인인증 안내</p>
            <p class="text_ty2">
                본 상품은 성인인증 이후 이용이 가능합니다.<br>
                성인인증 화면으로 이동하시겠습니까?
            </p>
            
            <ul class="btn_group">
                <li><a nohref class="btnde_type1 mid adultCancle">취소</a></li>
                <li><a nohref id="chkBtn" value="" class="btnde_type1 mid bg_black" onclick="adultAuthPop(this);" data-setid="" data-cartseq="" data-cartsetid="" data-notAdtGoodsCd="" data-notAdtQtyList="">확인</a></li>
                <input type="hidden" id="goodsCd" value=""/>
                <input type="hidden" id="qty" value=""/>
                <input type="hidden" id="adtBuyNow" value=""/>
            </ul>
        </div>
    </div>
    <div class="event_type_close">닫기</div>
</div>
<div id="layer_popup_adult" class="pop_o9_adult" title="성인인증" style="display:none">
    <div class="adult_popup">
        <strong class="tit">본 상품정보는 '청소년에게 유해한 정보'를 <br>포함하고 있기에 성인인증이 필요합니다.</strong>
        <ul>
            <li>본 정보 내용은 청소년 유해물건으로 청소년보호법의 규정에 의하여 만 19세 미만의 청소년이 이용할 수 없습니다.</li>
        </ul>

        <strong class="box">
            이용을 원하시면 로그인 후 <br>성인인증을 진행해주시기 바랍니다.
            <em>이 상품은 비회원 주문이 불가한 상품입니다.</em>
        </strong>
        <p>본인확인이 가능하지 않은 경우 <br>현대백화점면세점 고객센터로 연락주시기 바랍니다.</p>
        <a nohref id="hpAuth" value="" class="phonecertification_btn" data-goosCd="" data-qty="" data-buynow="" data-setid="" data-cartseq="" data-cartsetid="" data-notAdtGoodsCd="" data-notAdtQtyList="">
            <span>휴대폰 인증</span>
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
    DRMOK_window = window.open(url+'?cpid=hddfs&rtn_url=http://www.hddfs.com/shop/mm/mbshAuca/adultAuca.do?goosInfo='+goosInfo+'&req_info=EQ%2B4c52qaTe8hmqbZpmmZK0le8L1UPReDdqRCIKnGzI%2BFh1z9FuJTyQ5ULFxTaZ%2BKpSqXEoZuZe9Catwo5hnps7i130JLenx1%2FRhsj9sBBPv3Ic3KUOhnQG4pYL5FjruKIs8NUtY%2FkeCYDUGSqcYD38nHWMmDXX9GO7Fqa5vAMS0rwIQ3DC8Ev8KPcXoWcPAlOdQcsv7KwieEBvMghm044%2FGJoWlGy0TS%2FgFaZGBEbf5OQbDzVcBOMHziz8LsqrX1vW5wFBwJTgCuphf8S1dqC%2FUt1GA7XGjLx%2BO%2F%2F9feGc8HJLGi0g8JL541sxR%2F%2BWkoCk461GYWMbFzRY%2FjAPX5w%3D%3D', 'DRMOKWindow', 'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no' );
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




</script><div class="loading loadProgBar" style="display:none;">
		<div class="loading_img">
        	<img src="https://cdn.hddfs.com/front/images/KO/common/loading_apng.png" alt="">
		</div>
	</div>
</body>
</html>