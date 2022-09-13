<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<%@include file="../include/header.jsp"%>
<body>
	<div id="wrap">
		<!-- header -->
		<meta name="google-site-verification"
			content="rYjJmYP3q9lxBYCTSa_Tg3h1N9l3yZjJGp0AFaKCZlM" />
		<!-- Google Tag Manager (noscript) -->
		<noscript>
			<iframe src="https://www.googletagmanager.com/ns.html?id=GTM-56VKRZT"
				height="0" width="0" style="display: none; visibility: hidden"></iframe>
		</noscript>
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

		<!-- container -->
		<main id="container" class="container">
			<script language="javascript"
				src="https://kspay.ksnet.to/popmpi/js/kspf_pop_mpi.js"></script>
			<script language="javascript"
				src="https://www.vpay.co.kr/eISP/Wallet_layer_VP.js"></script>
			<script src="https://mup.mobilians.co.kr/js/ext/ext_inc_comm.js"></script>
			<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script>
			<script src="https://pg.cnspay.co.kr/dlp/scripts/postmessage.js"
				charset="utf-8"></script>
			<script src="https://pg.cnspay.co.kr/dlp/scripts/cnspay.js"
				charset="utf-8"></script>
			<script src="https://js.tosspayments.com/v1/connectpay"></script>


			<script type="text/javascript">
var clientKey = "live_ck_7XZYkKL4MrjLOOY5Owo30zJwlEWR";
var customerKey = '0011911632';
var connectPay = ConnectPay(clientKey, customerKey, {redirectUrl: 'https://www.hddfs.com/shop/or/order/hpayAccesstoken.do'});

function hpayPayment(){
    console.log($("input[name='settWayCd']").val());
    console.log($("input[name='hpayPaymentId']").val());
    $.ajax({
        url: 'https://www.hddfs.com/shop/or/order/hpayReady.json',
        method: "post",
        async: false,
        dataType : 'json',
        data : {hpayForm:$("form[name='hpayForm']").serialize()},
        success : function(data, textStatus, jqXHR) {
            if(data.resultCode == 1) {
                popOpen('https://www.hddfs.com/shop/or/order/hpayOpen.do?'+$("form[name='hpayForm']").serialize(), 'hpayReady', 750, 800);
            } else {
                alert(data.message);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
}
    
function hpayApproval(amount,methodId,orderId,paymentKey){
    hpayForm.totalOrderAmt.value = amount;
    hpayForm.methodId.value = methodId;
    hpayForm.orderNo.value = orderId;
    hpayForm.paymentKey.value = paymentKey;
    
    saveOrder($("form[name='hpayForm']").serialize()); 
}

function setHpayIstm(month) {
    $("input[name='istmMonsCnt']").val(month);  
}

function checkHpayTerms(type) {//card, bank
    var umbMbshNo = '0011911632';
    if(umbMbshNo == "") {
         popOpen(ctx_curr + '/mm/myInfo/umbMbshJoinNtcPop.do', 'chgUmbMbshPop', 450, 500);
    }else {
        //H.Point Pay 약관 조회 정보
        $.ajax({
            async       : true,
            url         : ctx_curr + "/or/order/hPointPaymentTerms.json",
            dataType    : "json",
            type        : "POST",
            success     : function(data, textStatus, jqXHR){
                if(!crew.ajaxValidate(data)){ return; }
                var terms = data.terms;
                
                if(data.isMember == true){
                    //카드 등록
                    addPaymentMethod(type)
                } else{
                    //약관동의 팝업
                    $("#hpay_layer_popup").html(data.html);
                    $("#hpay_layer_popup").show();
                    $("#hpay_layer_popup").dialog({
                        dialogClass: "pop_type1",
                        minHeight: 488,
                        maxHeight: 600,
                        width: 412,
                        modal: true
    
                    });
                    //TODO 여기서 팝업 응답값 받아서 결제수단 등록 창 이동 시켜줄 수 있는지 ㅜ
                }  
            },
            error : function(jqXHR, textStatus, errorThrown){
                alert('처리중 오류가 발생하였습니다.');
                
            }
        });
    }
}

function hpayAuthenticate(){
    connectPay.authenticate()
        .then(function (){
            alert('가입이 완료 되었습니다.');
            addPaymentMethod();
        }).catch(function(error){
            
        });
} 


function addPaymentMethod(type){
    if (type === "card"){
        connectPay.addPaymentMethod('카드')
        .then(function (methods) {
            location.reload();
        }).catch(function (error) {
            if(error.code == 'USER_CANCEL') {
                
            }
        });
    } else if(type === "bank"){
        connectPay.addPaymentMethod('계좌')
        .then(function (methods) {
            location.reload();
        }).catch(function (error) {
            if(error.code == 'USER_CANCEL') {
                
            }
        });
        
    } else {
        connectPay.addPaymentMethod()
        .then(function (methods) {
            location.reload();
        }).catch(function (error) {
            if(error.code == 'USER_CANCEL') {
                
            }
        });
        
    } 
}

</script>



			<script type="text/javascript">
var isLogin = true;
var exchr = 1385.3;
var d = new Date();

var isSettInfoFirst = true;

var imgnAcctChkYn = false; 
var geneMbshCupSeqId = "";
var dblMbshCupSeqId = "";
var totalCupUseLmtUsd = $("input[name='totalCupUseLmtUsd']").val();
var settProgYn = "N";
var hpoinAmt = 0;
var hpoinUseAucaYn = false;
var scrollPosition;
var nmbshSmsAucaYn = false;
var hpoinAdvsAmt = 0;
var hpoinGeneAmt = 0;

var currMbshLgcpBuyMbshGrpCd = "001";
var currMbshMbshIosdClsCd = "0";

$(document).ready(function() {
    console.log('order is start : isLogin [' + isLogin + ']');
    
    if($("#defaultItem").css("display") != "none"){
    	$("#cartItem").hide();
    }
    
    
    
    $("a.settGrpDoma").off("click").on("click", function() {
        
		
		
		if(!applSettFixInit()) {
			return false;
		}
        
        $("a.settGrpDoma").parent().removeClass("ui-tabs-active");
        $(this).parent().addClass("ui-tabs-active");
        
        var strArray = $(this).prop('id').split('_');
        var strId =  '#'+strArray[1]+'_'+strArray[2];
        
        $(".cont_item").hide();
        if("#rcnt_0" === strId){  
            $("#payway_tab_01").show();
        }else{
            $(strId).show();
        }
        
        setTimeout(function() {
            paymentSettInfo(); 
        }, 100);
        
        
        console.log('결제정보그룹 즉시할인 -> 청구할인 호출');
        setTimeout(function() {
            getChagDcAmt();
        }, 100);
        return;
        
    });
    
     
    $("li#settInfoTit > div").off("click").on("click", function() {
        
        setTimeout(function() {
                     
            if($("li#settInfoTit").hasClass("open")) {
                var settPrrgAmt = Number($("input[name='totalGoosKrw']").val()) - getDcAmt('krw');
                if(settPrrgAmt == 0) {
                    
                    var grpDivHeight = 0;
                    $(".settGrpDoma").each(function() {
                        if($(this).parent().hasClass("ui-tabs-active")) {
                            var grpId = String($(this).attr("noHref")).replace("#","");
                            var grpIdSplit = grpId.split("_")[0];
                            
                            if(grpIdSplit == "003") {
                            	grpDivHeight = $("div#"+grpId).height() + 88;
                            } else if(grpIdSplit == "004") {
                                grpDivHeight = $("div#"+grpId).height() + 143;                    	
                            } else {
                            	grpDivHeight = $("div#"+grpId).height() + 141;
                            }
                            
                            return false;
                        }
                    });
                    
                    $(".payment_method_dim").css("height", (grpDivHeight) + "px"); 
                    $(".flag").hide();
                    $(".payment_method_dim").show();
                } else {
                	
                }
            } else {
                $(".flag").show();
                $(".payment_method_dim").hide();
            }
        }, 100);
    });
    
    
     
    $("input:radio[name^='virtAcntBnk'], input:radio[name^='etcSett']").off("click").on("click", function() {
    	if(!applSettFixInit()) {
			return false;
		}
        
        setTimeout(function() {
            paymentSettInfo(); 
        }, 100);
        
        
        console.log('무통장/다른결제 즉시할인 -> 청구할인 호출');
        setTimeout(function() {
            getChagDcAmt();
        }, 100);
        return true;
    });
    

    
    
    $(".easypayment > a > div").off("click").on("click", function() {
    	
		var selPayment = checkSettGrpDoma()[0]; 
		if(selPayment == $(this).parent().data("dispsettwaycd")) {
			return true;
		}			
		
		if(!applSettFixInit()) {
			return false;
		}
		
       	$(this).parent().parent().find("a").find("div").removeClass("active"); 
       	$(this).addClass("active");
       
        setTimeout(function() {
            paymentSettInfo(); 
        }, 100);
       
        
        console.log('간편결제 즉시할인 -> 청구할인 호출');
        setTimeout(function() {
            getChagDcAmt();
        }, 100);
        return true;
    });
    
    
    $("input[type='checkbox'][name^='hyundaiCardM_']").off("click").on("click", function() {
        var checked = $(this).prop("checked");
        $("input[type='checkbox'][name^='hyundaiCardM_']").each(function(idx, obj){
            $(this).prop("checked", checked);
        });
    });
    
    
    $("input[type='checkbox'][class='befSettWaySaveYn']").off("click").on("click", function() {
        var checked = $(this).prop("checked");
        $("input[type='checkbox'][class^='befSettWaySaveYn']").each(function(idx, obj){
            $(this).prop("checked", checked);
        });
    });

    
    $("select[name='ptnrPmptDcType']").off("change").on("change", function() {
    	var type = $(this).val();
        var applPmptDcType = $.trim($("input[name=ptnrPmptDcCompTypeCd]").val());
        
        if(applPmptDcType != "" && applPmptDcType != "0") {
            if(!confirm("제휴사인증할인이 이미 설정되어 있습니다.\n제휴할인을 변경하시겠습니까?\n변경 시, 할인설정이 모두 초기화됩니다.")) {
                $(this).val(applPmptDcType);
                return false;
            }
        }
        
        setPtnrPmptDcAmt(0,0,0,0,0,'','',0);
        $("#ptnrPmptPossPoinDoma").hide();
        $("#ptnrPmptDcPoinAmtDoma").hide();
        $(".ptnrPmptDcGuide").hide();
        
        
        if(applPmptDcType != "" && applPmptDcType != "0") {
        	
            initSettWay("pmpt");
            
            getSvmtRsvgAmt();
            
            getOrderSvmtAmt();
             
            getChagDcAmt(); 
        }
    
        if($.trim($(this).val()) == "") {
            return false;
        }
        
        var settAmt = getPtnrPmptDcSettAmt();
        
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/popPtnrAuca.do',
            method: "post",
            data: {
            	  type : type
                , settAmt : settAmt
                , totalSettKrw : $("input[name='totalSettKrw']").val()
            },
            async: false,
            dataType : 'html',
            success : function(data, textStatus, jqXHR) {
            	
            	var ptnrPmpt = "ptnrPmptLayerPopup";
            	var popClassId = "";
            	var popTitle = "";
            	if(type == 001){
            		popClassId = "memplus_pop2";
            		popTitle = "KT멤버십 할인";
            	}else if(type == 003){
            		popClassId = "memplus_pop1";
            		popTitle = "U+멤버십 할인";
            	}
            	
            	$("#"+ptnrPmpt).removeClass("memplus_pop1");
            	$("#"+ptnrPmpt).removeClass("memplus_pop2");
            	$("#"+ptnrPmpt).addClass(popClassId);
            	
            	$("#"+ptnrPmpt).html(data);
            	$("div[aria-describedby='"+ptnrPmpt+"'] .ui-dialog-title").text(popTitle);
                
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.');
            }
        });
    });

    
    $(".choiGoosCup").off("change").on("change", function() {
        
        var objThis = $(this);
        var cupDupYn = false;       
        
        $(".choiGoosCup").each(function(idx, obj){
            
            if(objThis.attr("cartseq") != $(this).attr("cartseq") 
            		&& objThis.val() != ""
            		&& objThis.val() == $(this).val() 
                    && objThis.attr("name") == $(this).attr("name")) {
                cupDupYn = true;
                return false;
            }
        });
        
        if(cupDupYn) {
            $(this).val("");
            alert("이미 사용중인 쿠폰입니다."); 
            return false;
        }
        
        
        var cupClsCd = "002";
        if ($(this).attr("name") == "choiGoosDblCup") {
            cupClsCd = "005";
        }

        var choiGoosDblCup = $(this).parent().parent().parent().find("select[name='choiGoosDblCup']");
        if (cupClsCd == "002") {
            choiGoosDblCup.val("");
        } else {
        	
        	var choiGoosCup = $(this).parent().parent().parent().find("select[name='choiGoosCup']");
        	if(isEmpty(choiGoosCup.val())) {
        		choiGoosDblCup.val("");
        		alert("상품쿠폰을 먼저 선택해주세요."); 
				return false;
        	}
        }

        var obj = $(this);
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/choiGoosCup.json',
            method: "post",
            timeout : 60000,
            data: {cartSeq : $(this).attr("cartSeq"), mbshCupSeq : $(this).val(), cupClsCd : cupClsCd, goosCupCartApplYn : false},
            async: false,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
            	
                if(data == null || data.cupDcAmt == null) {
                    alert("최대 사용 할인율을 초과하여 쿠폰을 사용할 수 없습니다."); 
                    objThis.val("");
                } else {
                    if (data.cupDcAmt.goosDcDblCupUsdAtThis == 0 && !isEmpty(choiGoosDblCup.val())) {
                    	alert("최대 사용 할인율을 초과하여 상품더블쿠폰을 사용할 수 없습니다."); 
                        choiGoosDblCup.val("");
                    }
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.');
            }
        });
    });

    
    $(".choiGoosCup").off("click").on("click", function() {
      var cupClsCd = "002";
         if ($(this).attr("name") == "choiGoosDblCup") {
             cupClsCd = "005";
             
             if (isEmpty($(this).parent().parent().parent().find("select[name='choiGoosCup']").val())) {
                 alert("상품쿠폰을 먼저 선택해주세요."); 
                 return false;
             }
         }
    });
    
    
    $("#btnHpoinUseAuca").off("click").on("click", function() {
    	
        if (hpoinUseAucaYn) {
            alert('이미 인증 받았습니다.');
            return;
        }
        
        if (Number($("input[name='hpoinAmt']").val()) < 100000) {
            alert('10만 포인트 이상 사용 시 휴대번호 인증이 필요합니다.');
            return;
        }
        
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/popSmsAuth.json',
            method: "post",
            data: {type : 'orderHpoinUseAuca' ,layerPopupId : 'hPointSmsAuth'},
            async: false,
            dataType : 'html',
            success : function(data, textStatus, jqXHR) {
                $(".pop_quantity").html(data);
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.'); 
            }
        });
        
    });
    
    
    $(".orderSettCardList").off("click").on("click", function(e) {
    
    	if(!applSettFixInit()) {
			return false;
		}
        
        var cardItem = $(this).parent();
        
        if($(this).data("depth") == "2") {
            cardItem = cardItem.parent().parent().parent();
        }
        
        var grpSettCd = cardItem.data("grpsettcd");
        var grpDispOrdg = cardItem.data("grpdispordg");
        var settWayCd = cardItem.data("settwaycd");
        var settOvseCd = cardItem.data("settovsecd");
        
        var url = "https://www.hddfs.com/shop/or/order/settCardList.do?grpSettCd="+grpSettCd+"&grpDispOrdg="+grpDispOrdg+"&settWayCd="+settWayCd+"&settOvseCd="+settOvseCd;
        $.ajax({
            url: url,
            method: "get",
            async: false,
            dataType : 'html',
            success : function(data, textStatus, jqXHR) {
                
                $("#settCardListLayerPopup").html(data);
               
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.'); 
            }
        });
    });
    
     
    $("select[name^='virtAcntBnkCd']").off("change").on("change", function() {
        var grpSettCd = $(this).data("grpsettcd");
        var grpDispOrdg = $(this).data("grpdispordg");

        var bdgeDispWrd = $.trim($(this).find(":selected").data("bdgedispwrd"));
        $("#virtAcntBnkCd_bdge_"+grpSettCd+"_"+grpDispOrdg).hide();
        if(bdgeDispWrd != "") {
            $("#virtAcntBnkCd_bdge_"+grpSettCd+"_"+grpDispOrdg).text(bdgeDispWrd);
            $("#virtAcntBnkCd_bdge_"+grpSettCd+"_"+grpDispOrdg).show();
        }
        
        console.log('무통장 은행선택 -> 청구할인 호출');
        setTimeout(function() {
            getChagDcAmt();
            paymentSettInfo(); 
        }, 100);
    });
    
    
    $("#ptnsSvmtAllCheck").off("click").on("click", function() {
        var thisObj = $(this);
        var checked = thisObj.prop("checked");
        var isFirst = true;
        var checkedLength = $("input[type='checkbox'][name='ptnsSvmtSeq']:checked").length;
        var firstDupUsePsbYn = true;
        
        if(checkedLength > 0) {
            firstDupUsePsbYn = $("input[type='checkbox'][name='ptnsSvmtSeq']:checked:first").data("dupusepsbyn");
            
            if(checked && firstDupUsePsbYn == "N") {
                return true;
            }
            
        } else {
            firstDupUsePsbYn = $("input[type='checkbox'][name='ptnsSvmtSeq']:first").data("dupusepsbyn");
        }
        
        $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
            if(checked) {
                if(firstDupUsePsbYn == "Y") {
                	                 
                    if($.trim($(this).data("dupusepsbyn")) == firstDupUsePsbYn) {
                        $(this).prop("checked", true);
                    } else {
                        $(this).prop("disabled", true);                     
                    }
                } else {
                	                 
                    if(isFirst) {
                        $(this).prop("checked", true);
                        isFirst = false;
                    } else {
                        $(this).prop("disabled", true);     
                    }
                }
            } else {
                $(this).prop("checked", false);
                $(this).prop("disabled", false);
            }
        });
        
        $("#ptnsSvmtCalcCheck").val("N");
    });
    
    $(window).bind("pageshow", function (event) {
        if (event.originalEvent.persisted) {
            window.location.reload();
        } else {
            document.getElementById("orderForm").reset();
            $("input[name='geneMbshCupSeq']").prop("checked", false);
            $("input[name='dblMbshCupSeq']").prop("checked", false);
            initSettWay("all");
        }
    });

 	getHpoinAmt(false);

    totalCupUseLmtUsd = $("input[name='totalCupUseLmtUsd']").val();
    //StartSmartUpdate();
    
    
    $("input[name='cdpstAmt']").off("focusout").on("focusout", function() {
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".cdpstUseKrw").text().replace(/[^0-9]/g,''));
        var usePsbCdpstAmt = 0;
        if (Number($(this).val()) > usePsbCdpstAmt) {
            alert('보유하신 예치금잔액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".cdpstUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > settPrrgAmt) {
            alert('결제금액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".cdpstUseKrw").text("0");
            $(this).focus();
        } else {
            
            if(!settDcCheckConfirm('1', settPrrgAmt, $(this),'cdpstUseKrw', 0)) {
                return false;
            }   
        
            $(".cdpstUseKrw").text(comma($(this).val()));
            
            
        }
        
        
        
        calnSettAmt(); 
        if($("#chagDcEvtInfoDl").is(":visible")) {
            getChagDcAmt(); 
        }
        return;
    });
    
    
    $("input[name='advsAmt']").off("focusout").on("focusout", function() {
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".advsUseKrw").text().replace(/[^0-9]/g,''));
        var usePsbAdvsAmt = 0;
        if (Number($(this).val()) > usePsbAdvsAmt) {
            alert('보유하신 선수금잔액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".advsUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > settPrrgAmt) {
            alert('결제금액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".advsUseKrw").text("0");
            $(this).focus();
        } else {
            
            if(!settDcCheckConfirm('1', settPrrgAmt, $(this),'advsUseKrw', 0)) {
                return false;
            }
            
            $(".advsUseKrw").text(comma($(this).val()));

            
        }
        
        
        
        calnSettAmt(); 
        if($("#chagDcEvtInfoDl").is(":visible")) {
            getChagDcAmt(); 
        }
        return;
    });    

    
    $("input[name='gfcaCdpstAmt']").off("focusout").on("focusout", function() {
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".gfCaCdpstUseKrw").text().replace(/[^0-9]/g,''));
        var usePsbGfcaCdpstAmt = 0;
        if (Number($(this).val()) > usePsbGfcaCdpstAmt) {
            alert('보유하신 상품권전환금잔액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".gfCaCdpstUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > settPrrgAmt) {
            alert('결제금액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".gfCaCdpstUseKrw").text("0");
            $(this).focus();
        } else {
            
            if(!settDcCheckConfirm('1', settPrrgAmt, $(this),'gfCaCdpstUseKrw', 0)) {
                return false;
            }
            
            $(".gfCaCdpstUseKrw").text(comma($(this).val()));

            
        }
        
        
        calnSettAmt(); 
        if($("#chagDcEvtInfoDl").is(":visible")) {
            getChagDcAmt(); 
        }
        return;
    });

    
    $("input[name='svmtAmt']").off("focusout").on("focusout", function() {
         
        initMoblSvmtAmt();
        initEvntSvmtAmt(); 
        initBranSvmtAmt(); 
        initPtnsSvmtAmt(); 
        initSettSvmtAmt(); 
        initEtcAmt(); 
        
        calnSettAmt(); 
        
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".svmtAmt").val().replace(/[^0-9]/g,''));
        
        
        var inputSvmtAmt = Number($(this).val());
        
        
        var svmtUsePsbAmt = Number($(".svmtUsePsbKrw").text().replace(/[^0-9]/g,''));
        
        
        var svmtUseLmtAmt = getSvmtUseLmtAmt('SVMT');
        
        var svmtAmt = 0;
        svmtAmt += Number($("input[name='settWaySvmtAmt']").val());
        if(!isEmpty($("input[name='moblSvmtAmt']").val())) {
            svmtAmt += Number($("input[name='moblSvmtAmt']").val());
        }
        
        if(inputSvmtAmt > svmtUsePsbAmt) {
            alert('사용가능 적립금잔액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".svmtAmt").val("0");
            $(".svmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else if(inputSvmtAmt > svmtUseLmtAmt) {
            
            var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
            alert("본 주문에서 사용가능한 적립금은 최대 %s 원입니다. 다시 입력해주세요.".replace("%s", comma(svmtUseMaxAmt))); 
            
            $(this).val("");
            $(".svmtAmt").val("0");
            $(".svmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else if(inputSvmtAmt > settPrrgAmt) {
            alert('결제금액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".svmtAmt").val("0");
            $(".svmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else {
            $(".svmtAmt").val(inputSvmtAmt);
            $(".svmtUseKrw").text(comma(inputSvmtAmt + svmtAmt));
        }
        
        
        $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
        $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
        
        
        $("input[name='allUseEvntSvmt']").attr("disabled", "disabled");
        $("input[name='evntSvmtAmt']").attr("disabled", "disabled");
        
        
        $("input[name='allUseBranSvmt']").attr("disabled", "disabled");
        $("input[name='branSvmtAmt']").attr("disabled", "disabled");
        
        getOrderSvmtAmt("SVMT");
        
        if($("#chagDcEvtInfoDl").is(":visible")) {
        	
            getChagDcAmt(); 
        }
        return;
    });
    
    
    
    $("input[name='evntSvmtAmt']").off("focusout").on("focusout", function() {
        initMoblSvmtAmt();
        initBranSvmtAmt(); 
        initPtnsSvmtAmt(); 
        initSettSvmtAmt(); 
        initEtcAmt(); 
        
        calnSettAmt(); 
        
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".evntSvmtAmt").val().replace(/[^0-9]/g,''));
        
        
        var inputSvmtAmt = Number($(this).val());
        
        
        var svmtUsePsbAmt = Number($(".evntSvmtUsePsbKrw").text().replace(/[^0-9]/g,''));
        
        
        var svmtUseLmtAmt = getSvmtUseLmtAmt('EVNT');
        
        var svmtAmt = 0;
        
        if(inputSvmtAmt > svmtUsePsbAmt) {
            alert('사용가능 적립금잔액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".evntSvmtAmt").val("0");
            $(".evntSvmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else if(inputSvmtAmt > svmtUseLmtAmt) {
            
            var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
            alert('본 주문에서 사용가능한 적립금은 최대 %s 원입니다. 다시 입력해주세요.'.replace("%s", comma(svmtUseMaxAmt)));
            
            $(this).val("");
            $(".evntSvmtAmt").val("0");
            $(".evntSvmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else if(inputSvmtAmt > settPrrgAmt) {
            alert('결제금액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".evntSvmtAmt").val("0");
            $(".evntSvmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else {
            $(".evntSvmtAmt").val(inputSvmtAmt);
            $(".evntSvmtUseKrw").text(comma(inputSvmtAmt));
        }
        
        
        $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
        $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
        
        
        $("input[name='allUseBranSvmt']").attr("disabled", "disabled");
        $("input[name='branSvmtAmt']").attr("disabled", "disabled");
        
        getOrderSvmtAmt("SVMT");
        
        if($("#chagDcEvtInfoDl").is(":visible")) {
        	
            getChagDcAmt(); 
        }
        return;
    });
    
    
    
    $("input[name='branSvmtAmt']").off("focusout").on("focusout", function() {
        initMoblSvmtAmt();
        initPtnsSvmtAmt(); 
        initSettSvmtAmt(); 
        initEtcAmt(); 
        
        calnSettAmt(); 
        
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".branSvmtAmt").val().replace(/[^0-9]/g,''));
        
        
        var inputSvmtAmt = Number($(this).val());
        
        
        var svmtUsePsbAmt = Number($(".branSvmtUsePsbKrw").text().replace(/[^0-9]/g,''));
        
        
        var svmtUseLmtAmt = getSvmtUseLmtAmt('BRAN');
        
        var svmtAmt = 0;
        
        if(inputSvmtAmt > svmtUsePsbAmt) {
            alert('사용가능 적립금잔액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".branSvmtAmt").val("0");
            $(".branSvmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else if(inputSvmtAmt > svmtUseLmtAmt) {
            
            var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
            alert("본 주문에서 사용가능한 적립금은 최대 %s 원입니다. 다시 입력해주세요.".replace("%s", comma(svmtUseMaxAmt))); 
            $(this).val("");
            $(".branSvmtAmt").val("0");
            $(".branSvmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else if(inputSvmtAmt > settPrrgAmt) {
            alert('결제금액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".branSvmtAmt").val("0");
            $(".branSvmtUseKrw").text(comma(svmtAmt));
            $(this).focus();
        } else {
            $(".branSvmtAmt").val(inputSvmtAmt);
            $(".branSvmtUseKrw").text(comma(inputSvmtAmt));
        }
        
        
        $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
        $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
        
        getOrderSvmtAmt("SVMT");
        
        if($("#chagDcEvtInfoDl").is(":visible")) {
        	
            getChagDcAmt(); 
        }
        return;
    });    

    
    $("input[name='hpoinAmt']").off("focusout").on("focusout", function() {
    	
    	initHPoinPlsAmt(); 
    	initEtcEzwelSettAmt(); 
    	initEtcPaySettAmt(); 
    	calnSettAmt(); 
    	
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".hPoinUseKrw").text().replace(/[^0-9]/g,''));
        
        var hPoinPsbAmt = 0; // H.Point 사용가능금액(제외상품,브랜드)
        
        $('p.txt.finaDivAmt').each(function() {
        	if($(this).parent().attr('hpoinpsbyn') == 'Y') {
        		hPoinPsbAmt += Number($(this).text());
        	}
        });
        
        if (Number($(this).val()) > hpoinAmt) {
            alert('보유하신 H포인트잔액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".hPoinUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > settPrrgAmt) {
            alert('결제금액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".hPoinUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > hPoinPsbAmt){
        	
        	alert('고객님께서 보유하신 H.Point %sP 중, 사용 가능한 포인트는 %sP 입니다. 다시 입력해주세요.'.replace('%s', comma(hpoinAmt)).replace('%s', comma(hPoinPsbAmt)));
            $(this).val("");
            $(".hPoinUseKrw").text("0");
            $(this).focus();        	
        } else if (Number($(this).val()) > 0 && Number($(this).val()) < 100) {
            alert('H.Point 최소 결제금액은 100P이며 1P단위로 사용가능합니다.');
            $(this).val("");
            $(".hPoinUseKrw").text("0");
            $(this).focus();
        } else {
            
            if(!settDcCheckConfirm('1', settPrrgAmt, $(this),'hPoinUseKrw', 0)) {
                return false;
            }
            
            $(".hPoinUseKrw").text(comma($(this).val()));

            if (!hpoinUseAucaYn && Number($(this).val()) >= 100000) {
                alert('SMS 인증 후 사용가능합니다.'); 
            }

            
        }
        
        
        calnSettAmt(); 
        if($("#chagDcEvtInfoDl").is(":visible")) {
            getChagDcAmt(); 
        }
        
        getEzwelAmt(); 
        return;
    });
    
    
    $("input[name='ezwelWlfrPoinAmt']").off("focusout").on("focusout", function() {
    	
    	
    	$("input[name='ezwelSvmtAmt']").val("");
    	$(".ezwelSvmtUseKrw").text("0");
    	
    	$("input[name='ezwelSpclPoinAmt']").val("");
    	$(".ezwelSpclPoinUseKrw").text("0");
    	initEtcPaySettAmt(); 
    	calnSettAmt(); 
    	
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".ezwelWlfrPoinUseKrw").text().replace(/[^0-9]/g,''));
        var ezwelWlfrPoinPsbAmt = Number($("#ezwelWlfrPoinPsbAmt").text().replace(/[^0-9]/g,''));
        var minPsbAmt = Number($.trim($("#ezwelWlfrPoinMinPsbAmt").val()));
        if (Number($(this).val()) > ezwelWlfrPoinPsbAmt) {
        	alert("사용가능 금액을 초과하였습니다. 다시 입력해주세요."); 
            $(this).val("");
            $(".ezwelWlfrPoinUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > settPrrgAmt) {
            alert("결제금액을 초과하였습니다. 다시 입력해주세요."); 
            $(this).val("");
            $(".ezwelWlfrPoinUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > 0 && Number($(this).val()) < minPsbAmt) {
        	alert("최소 결제금액은 %s원이며, 1원단위로 사용가능합니다.".replace("%s", comma(minPsbAmt))); 
            $(this).val("");
            $(".ezwelWlfrPoinUseKrw").text("0");
            $(this).focus();
        } else {
            
            if(!settDcCheckConfirm('1', settPrrgAmt, $(this),'ezwelWlfrPoinUseKrw', 0)) {
                return false;
            }
            
            $(".ezwelWlfrPoinUseKrw").text(comma($(this).val()));
        }
        calnSettAmt(); 
        if($("#chagDcEvtInfoDl").is(":visible")) {
            getChagDcAmt(); 
        }
        
        getEzwelAmt(); 
        return;
    });
    
    
    $("input[name='ezwelSvmtAmt']").off("focusout").on("focusout", function() {
    	
    	
    	$("input[name='ezwelSpclPoinAmt']").val("");
    	$(".ezwelSpclPoinUseKrw").text("0");
    	initEtcPaySettAmt(); 
    	calnSettAmt(); 
    	
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".ezwelSvmtUseKrw").text().replace(/[^0-9]/g,''));
        var ezwelSvmtPsbAmt = Number($("#ezwelSvmtPsbAmt").text().replace(/[^0-9]/g,''));
        var minPsbAmt = Number($.trim($("#ezwelSvmtMinPsbAmt").val()));
        if (Number($(this).val()) > ezwelSvmtPsbAmt) {
        	alert("사용가능 금액을 초과하였습니다. 다시 입력해주세요."); 
            $(this).val("");
            $(".ezwelSvmtUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > settPrrgAmt) {
            alert("결제금액을 초과하였습니다. 다시 입력해주세요."); 
            $(this).val("");
            $(".ezwelSvmtUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > 0 && Number($(this).val()) < minPsbAmt) {
        	alert("최소 결제금액은 %s원이며, 1원단위로 사용가능합니다.".replace("%s", comma(minPsbAmt))); 
            $(this).val("");
            $(".ezwelSvmtUseKrw").text("0");
            $(this).focus();
        } else {
            
            if(!settDcCheckConfirm('1', settPrrgAmt, $(this),'ezwelSvmtUseKrw', 0)) {
                return false;
            }
            
            $(".ezwelSvmtUseKrw").text(comma($(this).val()));
        }
        calnSettAmt(); 
        if($("#chagDcEvtInfoDl").is(":visible")) {
            getChagDcAmt(); 
        }
        
        getEzwelAmt(); 
        return;
    });
    
    
    $("input[name='ezwelSpclPoinAmt']").off("focusout").on("focusout", function() {
    	
    	initEtcPaySettAmt(); 
    	calnSettAmt(); 
    	
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".ezwelSpclPoinUseKrw").text().replace(/[^0-9]/g,''));
        var ezwelSpclPoinPsbAmt = Number($("#ezwelSpclPoinPsbAmt").text().replace(/[^0-9]/g,''));
        var minPsbAmt = Number($.trim($("#ezwelSpclPoinMinPsbAmt").val()));
        if (Number($(this).val()) > ezwelSpclPoinPsbAmt) {
        	alert("사용가능 금액을 초과하였습니다. 다시 입력해주세요."); 
            $(this).val("");
            $(".ezwelSpclPoinUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > settPrrgAmt) {
            alert("결제금액을 초과하였습니다. 다시 입력해주세요."); 
            $(this).val("");
            $(".ezwelSpclPoinUseKrw").text("0");
            $(this).focus();
        } else if (Number($(this).val()) > 0 && Number($(this).val()) < minPsbAmt) {
        	alert("최소 결제금액은 %s원이며, 1원단위로 사용가능합니다.".replace("%s", comma(minPsbAmt))); 
            $(this).val("");
            $(".ezwelSpclPoinUseKrw").text("0");
            $(this).focus();
        } else {
            
            if(!settDcCheckConfirm('1', settPrrgAmt, $(this),'ezwelSpclPoinUseKrw', 0)) {
                return false;
            }
            
            $(".ezwelSpclPoinUseKrw").text(comma($(this).val()));
        }
        calnSettAmt(); 
        if($("#chagDcEvtInfoDl").is(":visible")) {
            getChagDcAmt(); 
        }
        return;
    });

    
    $("input[name='moblSvmtAmt']").off("focusout").on("focusout", function() {
        var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".moblSvmtAmt").val().replace(/[^0-9]/g,''));
        var moblSvmtUsePsbAmt = Number($(".moSvmtUsePsbKrw").text().replace(/[^0-9]/g,''));
        
        var pmptUseSvmtAmt = 0;
        
        var inputMoblSvmt = Number($(this).val());
        var svmtUseLmtAmt = getSvmtUseLmtAmt('MOBL');
        
        if (inputMoblSvmt > moblSvmtUsePsbAmt) {
            alert('사용가능 모바일전용적립금잔액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".moblSvmtAmt").val("0");
            $(".svmtUseKrw").text(comma(Number($("input[name='settWaySvmtAmt']").val()) + Number($("input[name='svmtAmt']").val())));
        } else if(inputMoblSvmt > svmtUseLmtAmt) {
            var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
            alert("본 주문에서 사용가능한 적립금은 최대 %s 원입니다. 다시 입력해주세요.".replace("%s", comma(svmtUseMaxAmt))); 
            $(this).val("");
            $(".moblSvmtAmt").val("0");
            $(".svmtUseKrw").text(comma(Number($("input[name='settWaySvmtAmt']").val()) + Number($("input[name='svmtAmt']").val())));
        } else if (inputMoblSvmt > settPrrgAmt) {
            alert('결제금액을 초과하였습니다. 다시 입력해주세요.');
            $(this).val("");
            $(".moblSvmtAmt").val("0");
            $(".svmtUseKrw").text(comma(Number($("input[name='settWaySvmtAmt']").val()) + Number($("input[name='svmtAmt']").val())));
        } else {
        	
            var gfcaCdpstAmt = isEmpty($("input[name='gfcaCdpstAmt']").val()) ? 0 : Number($("input[name='gfcaCdpstAmt']").val());
            var cdpstAmt = isEmpty($("input[name='cdpstAmt']").val()) ? 0 : Number($("input[name='cdpstAmt']").val());
            var hpoinAmt = isEmpty($("input[name='hpoinAmt']").val()) ? 0 : Number($("input[name='hpoinAmt']").val());
            var lgcpBuyMbshGrpCd = "001";
            
            if(lgcpBuyMbshGrpCd != 'MG' && gfcaCdpstAmt + cdpstAmt + hpoinAmt < 1000 && (settPrrgAmt - inputMoblSvmt < 1000)) {
                alert('결제금액은 최소 1,000원 이상입니다.');
                
                if(settPrrgAmt - 1000 > 0){
                    $(this).val(settPrrgAmt - 1000);
                } else {
                    $(this).val(0);
                }
            }
            
            $(".moblSvmtAmt").val($(this).val());
            $(".svmtUseKrw").text(comma(Number($(this).val()) + Number($("input[name='settWaySvmtAmt']").val()) + Number($("input[name='svmtAmt']").val())));
        }
        
        getOrderSvmtAmt("SVMT");
        
        
        
        if($("#chagDcEvtInfoDl").is(":visible")) {
        	
            getChagDcAmt(); 
        }
    });
    
    
    $("input[name='pmptUseSvmtUseYn']").change(function() {
        if ($(this).val() == "Y") {
            $("input[name='settPrrgAmtTmp']").val(Number($("input[name='settPrrgAmtTmp']").val()) - Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,'')));
        } else {
            $("input[name='settPrrgAmtTmp']").val(Number($("input[name='settPrrgAmtTmp']").val()) + Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,'')));
        }
 
        initSettWay("all");
        calnSettAmt();
        
        
        $("input[name='allUseSvmt']").attr("disabled", "disabled");
        $("input[name='svmtAmt']").attr("disabled", "disabled");
        $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
        $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
        
        
        $("input[name='allUseEvntSvmt']").attr("disabled", "disabled");
        $("input[name='evntSvmtAmt']").attr("disabled", "disabled");
        
        $("input[name='allUseBranSvmt']").attr("disabled", "disabled");
        $("input[name='branSvmtAmt']").attr("disabled", "disabled");
        
         
        
        getOrderSvmtAmt();
        
        if($("#chagDcEvtInfoDl").is(":visible")) {
        	
            getChagDcAmt(); 
        }
        return;
    });
    
    $("select[name='geneMbshCupSeq']").change(function() {
        if(isEmpty($(this).val())) {
            $("select[name='dblMbshCupSeq']").val("");
        }
        
        $("select[name='dblMbshCupSeq']").prop("disabled", isEmpty($(this).val()));
    });

    $("#closeMbshSvmtDtl").click(function() {
        $("#mbshSvmtInfo").removeClass('opened');
    });

    $("input[name='chkMoney']").change(function() {
        $(".natiClsbSettAmt").text(comma(setNatiClsbSettAmt()));
    });

    $("div[aria-describedby='cartCupLayerPopup'] button[title=Close]").off("click").on("click",function() {
        if (isEmpty(geneMbshCupSeqId)) {
            $("select[name='geneMbshCupSeq']").val("");
            $("select[name='dblMbshCupSeq']").prop("disabled", true);
        } else {
            $("#" + geneMbshCupSeqId).prop("selected", true);
        }
        if (isEmpty(dblMbshCupSeqId)) {
            $("select[name='dblMbshCupSeq']").val("");
        } else {
            $("#" + dblMbshCupSeqId).prop("selected", true);
        }
    });
    
        
    $("input[type='checkbox'][name='tempTrdrClsCd']").off("click").on("click", function()
    {
        var checked = $(this).prop("checked");
        $("input[type='checkbox'][name='tempTrdrClsCd']").each(function(idx, obj){
            $(this).prop("checked", checked);
        });
    });
    
    $("input[type='tel'][name^='idntCfmNo']").off("focusout").on("focusout", function() {
        var txt = $(this).val();
        var loc = $(this).data("inputloc");
        
        $("input[type='tel'][name='idntCfmNo"+loc+"']").each(function(idx, obj){
            $(this).val(txt);
        });
    });
    
    
    $("input[type='tel'][name^='idntCfmNo']").off("keyup").on("keyup", function() {
        if ($(this).val().length >= $(this).attr("maxlength")) {
            var index = $(".idntCfmNo").index(this);
            $(".idntCfmNo").eq(index + 1).focus();
        }
    });
    
        
    $("input[type='text'][name^='svacOwrNm']").off("focusout").on("focusout", function() {
        var txt = $(this).val();
        $("input[type='text'][name^='svacOwrNm']").each(function(idx, obj){
            $(this).val(txt);
        });
    });
    
    
    $(".btnGoIspAppDown").click(function() {
        window.location.href = "";
    });
    
    
    var applMons = "";
    $("select[name^='istmMonsCnt']").off("click").on("click", function() {
        var mons = checkSettGrpDoma()[2];
        applMons = mons; 
    });
    
    
    $("select[name^='istmMonsCnt']").off("change").on("change", function() {
        var pmptDcEvtObj = $("input[type='radio'][name='pmptDcEvt']:checked");
        var pmptDcEvtVal = $.trim(pmptDcEvtObj.val()); 
        
        var mons = checkSettGrpDoma()[2];
        
        if(pmptDcEvtVal != "") {
            
            var settMethCd = $.trim(String(pmptDcEvtObj.data("settmethcd")).replace("null", ""));
            var validCheck = false;
            if(settMethCd == "01" && $(this).find("option:selected").hasClass("interest-free") == false) {
                                  
                validCheck = true;
            } else if((settMethCd == "" || settMethCd == "02") && $(this).find("option:selected").hasClass("interest-free") == true) {
                
                validCheck = true;
            }
            
            if(validCheck) {
                if(dcInitConfirm('107')) {
                    pmptDcInitProc();
                } else {
                    $(this).val(applMons);
                    return false;
                }
            }
        }
        
        
        if($(this).val() == "00") {
            $("input[name='rateYn']").val('Y');
        } else {
        	
            if($(this).find("option:selected").hasClass("interest-free") == false) {
                $("input[name='rateYn']").val('Y');    
            } else {
                $("input[name='rateYn']").val('N');    
            }
        }
        
    
    });
    
    
    $("input[name='allUseSvmt']").attr("disabled", "disabled");
    $("input[name='svmtAmt']").attr("disabled", "disabled");
    $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
    $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
    
    
    $("input[name='allUseEvntSvmt']").attr("disabled", "disabled");
    $("input[name='evntSvmtAmt']").attr("disabled", "disabled");
    
    
    $("input[name='allUseBranSvmt']").attr("disabled", "disabled");
    $("input[name='branSvmtAmt']").attr("disabled", "disabled");
    
	
	        getPmptDcList(isLogin);
	    
	        
	        getSvmtRsvgAmt();
	        
	        
	        getOrderSvmtAmt();
	    
    $("#ptnrPmptPossPoinDoma").hide();
    $("#ptnrPmptDcPoinAmtDoma").hide();
    $(".ptnrPmptDcGuide").hide();
    
    
    $(".settTextDataInfo").each(function(idx, obj){
    	
    	if($.trim($(this).text().replace(/[\t]/gi, "").replace(/[\n]/gi, "")) == "") {
            $(this).hide();
        }
    });
    
    
    $("#hpoinPlsAmtSearch").off("click").on("click", function() {
       	initEtcEzwelSettAmt(); 
       	initEtcPaySettAmt(); 
       	calnSettAmt();
       	
    	setTimeout(function() {
    		getHpoinAmt(true);
       		getEzwelAmt(); 
        }, 10);
    });
    
    
    $("input[type='radio'][name='hpoinPlsUseYn']").off("change").on("change", function() {
       	initEtcEzwelSettAmt(); 
       	initEtcPaySettAmt(); 
       	
    	var hPoinPlsAmt = 0;
    	if($(this).val() == "Y") {
    		hPoinPlsAmt = $("#dispHpoinPlsAmt1").val();
    	}
		$(".hPoinPlsUseKrw").text(comma(hPoinPlsAmt));
		calnSettAmt();
		
    	setTimeout(function() {
       		getEzwelAmt(); 
        }, 10);
    });
    
    $("#koreanAirSearch").off("click").on("click", function() {
        if(!koreanAirSkyPassValidate()) {
            return;
        }
        
        var memberNum = $('#skyPassMemberNum').val();
        var engLstNm = $('#skyPassMemberEngLstNm').val();
        var engFstNm = $('#skyPassMemberEngFstNm').val();
        
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/koreanAirSearch.json',
            method: "post",
            data: {memberNum : memberNum, engLstNm : engLstNm, engFstNm : engFstNm},
            async: true,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                
                var vResultCode = data.resultCode;
                var vMessage = data.message;
                var vInfo = data.info;
                
                if(crew.ajaxValidate(data, false)){
                    
                	  
                    
                    alert(vMessage); 
                    
                    
                    if(vResultCode != "0"){
                        setKoreanAirSkyPassMemberNum(memberNum);
                    }
                } else {
                    alert('처리중 오류가 발생하였습니다.2'); 
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.'); 
            }
        });
        
        $("#koreanAirClose").click();
    });
    
    
    $("#koreanAirClose").off("click").on("click", function() {
    	$("#koreanAirSkyPassLayerPopup").dialog('close');
    	$("#koreanAirSkyPassLayerPopup").hide();
    });
    
    
    setTimeout(function() {
        autoSvmt();
    }, 1000);
    
});
    
    
    function applSettFixInit() {
    	
    	 
        var geneMbshCupSeq = $("select[name='geneMbshCupSeq']").data("cupseq");
        var dblMbshCupSeq = $("select[name='dblMbshCupSeq']").data("cupseq");
        
        var geneMbshCupSettWayCd = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("dispSettWayCd");
        var geneMbshCupSettCardId = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("cardid");
        
        var dblMbshCupSettWayCd = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("dispSettWayCd");
        var dblMbshCupSettCardId = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("cardid");		
    	
        
    	var pmptDcAmt = $("input[name='pmptDcAmt']").length > 0 ? $("input[name='pmptDcAmt']").val() : 0;
    	var settSvmtAmt = $("input[name='settWaySvmtAmt']").length > 0 ? $("input[name='settWaySvmtAmt']").val() : 0;
    	
    	var isFirst = true;
    	var replaceStr = "";
    	
    	if(($.trim(geneMbshCupSeq) != "" && $.trim(geneMbshCupSettWayCd) != "")
    			  || ($.trim(dblMbshCupSeq) != "" && $.trim(dblMbshCupSettWayCd) != "")) {
    		replaceStr += "쿠폰";
    		isFirst = false;			
    	}
    	
    	if(pmptDcAmt > 0) {
    		if(!isFirst) {
    			replaceStr += "/";			
    		}
    		replaceStr += "즉시할인";
    		isFirst = false;
    	}
    	
    	if(settSvmtAmt > 0) {
    		if(!isFirst) {
    			replaceStr += "/";			
    		}
    		replaceStr += "결제플러스적립금";
    	}
    	
    	if(($.trim(geneMbshCupSeq) != "" && $.trim(geneMbshCupSettWayCd) != "")
    			  || ($.trim(dblMbshCupSeq) != "" && $.trim(dblMbshCupSettWayCd) != "")) {
    		if(dcInitConfirm('281', replaceStr)) {
    			if($.trim(geneMbshCupSeq) != "" && $.trim(geneMbshCupSettWayCd) != "") {
    									
    				$("select[name='geneMbshCupSeq']").val("");
    				$("select[name='dblMbshCupSeq']").val("");
    			} else {
    				
    				$("select[name='dblMbshCupSeq']").val("");
    			}
    			choiCartCup();
    		} else {
    			return false;
    		}
    	} else if(pmptDcAmt > 0) {
    		if(dcInitConfirm('281', replaceStr)) {
    			pmptDcInitProc();
    		} else {
    			return false;
    		}
    	} else if(settSvmtAmt > 0) {
    		if(dcInitConfirm('281', replaceStr)) {
    			initSettSvmtAmt();
    			initEtcAmt();
    		} else {
    			return false;
    		}			
    	}
    	
    	return true;
    }
    
    
    function autoSvmt() {
        if(!isLogin){
            return;
        }
        
        if($(".svmtUsePsbKrw").length > 0 && Number($(".svmtUsePsbKrw").text().replace(/[^0-9]/g,'')) > 0 ){
          allUseSvmtClick(); 
        }
        
        if($(".evntSvmtUsePsbKrw").length > 0 && Number($(".evntSvmtUsePsbKrw").text().replace(/[^0-9]/g,'')) > 0 ){
          allUseEvntSvmtClick();  
        }
        
        if($(".branSvmtUsePsbKrw").length > 0 && Number($(".branSvmtUsePsbKrw").text().replace(/[^0-9]/g,'')) > 0 ){
          allUseBranSvmtClick(); 
        }
    }  
    
    
  function goosCupEtcInfoSetting(data){
      var goosCupApplCnt = 0;
      $(".choiGoosCup").each(function(idx, obj){
          var cupSeq = $.trim($(this).val());
          
              $(this).data("cupseq", cupSeq);
		  
          
          if(cupSeq != "") {
              goosCupApplCnt++;
          }
      });
      var cartCupApplUsdAmt = Number($("#cartCupApplUsdAmt").text());
      var goosCupApplUsdAmt = (data.cupDcAmt.goosDcCupUsd + data.cupDcAmt.goosDcDblCupUsd).toFixed(2);
      var dispCupDcTotalAmt = Number(goosCupApplUsdAmt) + Number(cartCupApplUsdAmt);
      
      if(Number(dispCupDcTotalAmt) <= 0) {
          dispCupDcTotalAmt = Number("0");
      } else {
          dispCupDcTotalAmt = Number(dispCupDcTotalAmt).toFixed(2);
      }
      
      if(Number(goosCupApplUsdAmt) <= 0) {
          goosCupApplUsdAmt = Number("0");
      } else {
          goosCupApplUsdAmt = Number(goosCupApplUsdAmt).toFixed(2);
      }
      
      $("#dispCupDcTotalAmt").text(dispCupDcTotalAmt); 
      $("#goosCupApplUsdAmt").text(goosCupApplUsdAmt);  
      $("#goosCupApplCnt").text(goosCupApplCnt+'장 적용'); 
  }
    


function paymentSettInfo() {
    
	var selPayment = checkSettGrpDoma()[0]; 
    var selPaymentDtl = checkSettGrpDoma()[1]; 
    
    if($.trim(selPaymentDtl) != "") {
        selPayment += selPaymentDtl;
    }
    
    var grpDomaSelect = ""; 
    var grpDomaSort = ""; 
    
    $(".settGrpDoma").each(function(idx, obj){
        if($(this).parent().hasClass("ui-tabs-active")) {
            grpDomaSelect = $(this).attr("id");
            return false;
        }
    });
    
    if(grpDomaSelect != "") {
        grpDomaSort = grpDomaSelect.split("_")[2];
        grpDomaSelect = grpDomaSelect.split("_")[1];
    }
    
    if(grpDomaSelect != "rcnt") {
        
        $(".settTextDataNoti").each(function(idx, obj){
            $(this).hide();
            
            if($(this).hasClass("payment"+selPayment+grpDomaSort)) {
                
            	if($.trim($(this).text().replace(/[\t]/gi, "").replace(/[\n]/gi, "")) != "") {
                    $(this).show();
                }
            }
        });
        
        
        $(".settTextDataNtc").each(function(idx, obj){
            $(this).hide();
            
            
            if(selPayment == "002") {
                if($(this).hasClass("payment"+selPayment)) {
                    
                      if($.trim($(this).text().replace(/[\t]/gi, "").replace(/[\n]/gi, "")) != "") {
                        $(this).show();
                    }
                }
            } else {
                if($(this).hasClass("settGrp"+grpDomaSelect)) {
                      
                   	  if($.trim($(this).text().replace(/[\t]/gi, "").replace(/[\n]/gi, "")) != "") {
                        $(this).show();
                    }
                }
            }
            
        });    
    }
    
}
        
        
function checkSettGrpDoma() {
    
    var grpDomaSelect = ""; 
    var grpDoamTabDiv = "";
    
    var paymentWayCd = ""; 
    var paymentDtlCd = ""; 
    var istmMonsCnt = ""; 
    var svacOwrNm = ""; 
    var chkMpoint = ""; 
    var ovseSettWayCd = ""; 
    var rateYn = ""; 
    
    $(".settGrpDoma").each(function(idx, obj){
        if($(this).parent().hasClass("ui-tabs-active")) {
            grpDomaSelect = $(this).attr("id");
            grpDoamTabDiv = $(this).attr("noHref");
            return false;
        }
    });
    
    
    if(grpDomaSelect != "") {
        var grpDoma = grpDomaSelect.split("_");
        
        
        if(grpDoma[1] == "rcnt") {
        	
            $(grpDoamTabDiv).find("div:eq(0) > div > div ").each(function(idx, obj) {
                if($(this).hasClass("swiper-slide-active")) {
                    paymentWayCd = $(this).data("dispsettwaycd");
                    ovseSettWayCd = $(this).data("settovsecd");
                    
                    if(paymentWayCd == "001") {
                    	
                        paymentDtlCd = $(this).data("settcardid"); 
                        
                        istmMonsCnt = $(this).find("select[name='istmMonsCnt_"+$(this).data("grpsettcd")+"_rcnt']").val();
                        if(paymentDtlCd == "4") {
                        	
                            chkMpoint = $(this).find("input[name='hyundaiCardM_"+$(this).data("grpsettcd")+"_rcnt']").prop("checked");
                        }
                        
                        if($(this).find("select[name='istmMonsCnt_"+$(this).data("grpsettcd")+"_rcnt']").find("option:selected").hasClass("interest-free")) {
                        	rateYn = "N";
                        } else {
                        	rateYn = "Y";
                        }
                    } else {
                    	if($.trim(ovseSettWayCd) != "") {
                    		
                    	} else {
	                        paymentDtlCd = $(this).data("settwaycd");
	                        
	                        if(paymentWayCd == "103") {
	                            svacOwrNm = $(this).find("input[name='svacOwrNm_"+$(this).data("grpsettcd")+"_rcnt']").val();
	                        }
                    	}
                    }
                    
                    return false;
                }
            });
        } else if(grpDoma[1] == "001") {
            $(grpDoamTabDiv).find(".settSvmt").each(function(idx, obj) {
                if($(this).css("display") == "block") {
                    paymentWayCd = $(this).data("dispsettwaycd");
                    paymentDtlCd = $(this).data("settcardid"); 
                    ovseSettWayCd = $(this).data("settovsecd");
                    
                    if($.trim(ovseSettWayCd) != "") {
                    	
                    } else {
	                    istmMonsCnt = $(this).find("select[name='istmMonsCnt_"+grpDoma[1]+"_"+grpDoma[2]+"']").val();
	                    if(paymentDtlCd == "4") {
	                    	
	                        chkMpoint = $(this).find("input[name='hyundaiCardM_"+grpDoma[1]+"_"+grpDoma[2]+"']").prop("checked");
	                    }
	                    
	                    if($(this).find("select[name='istmMonsCnt_"+grpDoma[1]+"_"+grpDoma[2]+"']").find("option:selected").hasClass("interest-free")) {
                        	rateYn = "N";
                        } else {
                        	rateYn = "Y";
                        }
                    }
                    
                    return false;
                }
            });
        } else if(grpDoma[1] == "002") {
        	
                paymentWayCd = $(grpDoamTabDiv).find("input[type='radio'][name='virtAcntBnk_"+grpDoma[1]+"_"+grpDoma[2]+"']:checked").val();
                paymentDtlCd = $(grpDoamTabDiv).find("select[name='virtAcntBnkCd_"+grpDoma[1]+"_"+grpDoma[2]+"']").val();
                
                if(paymentWayCd == "103") {
                    svacOwrNm = $(grpDoamTabDiv).find("input[name='svacOwrNm_"+grpDoma[1]+"_"+grpDoma[2]+"']").val();
                }
                
        } else if(grpDoma[1] == "003") {
            $(grpDoamTabDiv).find(".easypayment").find(".settSvmt").each(function(idx, obj) {
            	if($(this).hasClass("active")) {
            		paymentWayCd = $(this).data("dispsettwaycd");
                    ovseSettWayCd = $(this).data("settovsecd");
                    
                    return false;
                }
            });
        } else if(grpDoma[1] == "004") {
            paymentWayCd = $(grpDoamTabDiv).find("input[type='radio'][name='etcSett_"+grpDoma[1]+"_"+grpDoma[2]+"']:checked").val();
            ovseSettWayCd = $(grpDoamTabDiv).find("input[type='radio'][name='etcSett_"+grpDoma[1]+"_"+grpDoma[2]+"']:checked").data("settovsecd");
            
            if(paymentWayCd == "103") {
                paymentDtlCd = $(grpDoamTabDiv).find("select[name='virtAcntBnkCd_"+grpDoma[1]+"_"+grpDoma[2]+"']").val();
                svacOwrNm = $(grpDoamTabDiv).find("input[name='svacOwrNm_"+grpDoma[1]+"_"+grpDoma[2]+"']").val();
            } else {
            	
            }
        } else if(grpDoma[1] == "005") {
        	//카드
        	if($('#hpay_01').is(':checked')) {
       		   $(grpDoamTabDiv).find(".settSvmt").each(function(idx, obj) {
       		        if($(this).hasClass("swiper-slide-active")) {
	                	paymentWayCd = '110';
	                    paymentDtlCd = $(this).data("settcardid"); 
	                    
	                    if($("#hdcard_"+paymentDtlCd).is(':checked')) {
	                    	$("input[name='poinUseYn']").val('Y');    
	                    }else {
	                    	$("input[name='poinUseYn']").val('N');    
	                    }
	                }
               });
        	};
        	
        	//계좌
            if($('#hpay_02').is(':checked')) {
                $(grpDoamTabDiv).find(".settSvmtBank").each(function(idx, obj) {
                    if($(this).hasClass("swiper-slide-active")) {
                        paymentWayCd = '111';
                        paymentDtlCd = $(this).data("settcardid"); 
                    }
               });              
            };
            
        }
    }
    
    var paymentWayArr = new Array();
    
    paymentWayArr.push(paymentWayCd); 
    paymentWayArr.push(paymentDtlCd); 
    paymentWayArr.push(istmMonsCnt); 
    paymentWayArr.push(svacOwrNm); 
    paymentWayArr.push(chkMpoint); 
    paymentWayArr.push(ovseSettWayCd); 
    paymentWayArr.push(rateYn); 
    
    return paymentWayArr;
}


function setPaymentData(paymentWayArr) {
	
    $("#settWayCd").val(""); 
    $("#cardCd").val(""); 
    $("#virtAcntBnkCd").val(""); 
    $("#istmMonsCnt").val(""); 
    $("#chkMpoint").val(""); 
    $("#svacOwrNm").val(""); 
    $("input[name='paymethod']").val(""); 
    if (Number($("input[name='settPrrgAmt']").val()) > 0) {
        var settWayCd = $.trim(paymentWayArr[0]);
        var dtlWayCd = $.trim(paymentWayArr[1]);
        var istmMonsCnt = $.trim(paymentWayArr[2]);
        var svacOwrNm = $.trim(paymentWayArr[3]);
        var chkMpoint = $.trim(paymentWayArr[4]);
        var ovseSettWayCd = $.trim(paymentWayArr[5]);
        
        $("#settWayCd").val(settWayCd);
        $("input[name='paymethod']").val(ovseSettWayCd);
        if(settWayCd == "001") {
        	
            $("#cardCd").val(dtlWayCd);
            $("#istmMonsCnt").val(istmMonsCnt);
            if(dtlWayCd == "4") {
            	
            	if("true" == chkMpoint) {
					$("#chkMpoint").val("Y");
				} else {
					$("#chkMpoint").val("N");
				}
            }
        } else if(paymentWayArr[0] == "103") {
        	
            $("#virtAcntBnkCd").val(dtlWayCd);
            $("#svacOwrNm").val(svacOwrNm);
        } else if(paymentWayArr[0] == "110" || paymentWayArr[0] == "111") {
            
            $("#hpayPaymentId").val(dtlWayCd);
        }
    }
    
    var trdrClsCd = "";
    if($("input[type='checkbox'][name='tempTrdrClsCd']:first").prop("checked") == true) {
        trdrClsCd = "1"
    }
    $("input[type='hidden'][name='trdrClsCd']").val(trdrClsCd);
    
    
    var hPointPlsUseYn = $.trim($("input[type='radio'][name='hpoinPlsUseYn']:checked").val());
    if(hPointPlsUseYn == "Y") {
    	$("#hpoinPlsAmt").val($("#dispHpoinPlsAmt1").val());
    	
    	
    } else {
    	$("#hpoinPlsAmt").val("");
    	$("#hpoinPlsCupNo").val("");
    }
    
}


function setChoiGoosCupChk() {
	$("#orderLoading").show(); 
    setTimeout(function() {
	    setChoiGoosCup();
    },100);
}


function setChoiGoosCup() {
	var choiGoosDblCup = "";
    var choiGoosCupList =  "";
    var dblCupYn = false;
    
    $(".choiGoosCup").each(function(idx, obj){
        var cupClsCd = "002";
        if ($(this).attr("name") == "choiGoosDblCup") {
            cupClsCd = "005";
        }
        
        choiGoosDblCup = $(this).parent().parent().parent().find("select[name='choiGoosDblCup']");
        if (cupClsCd == "002" && isEmpty($(this).val())) {
            choiGoosDblCup.val("");
        }
        
        if(cupClsCd == "005" && $.trim($(this).val()) != "") {
            dblCupYn = true;
        }
        
        if($.trim($(this).val()) == "" && $.trim($(this).data("cupseq")) == "") {
        	
        } else {
            var choiGoosCup = $(this).attr("cartSeq") + "::" +  $(this).val() + "::" + cupClsCd;
            choiGoosCupList += choiGoosCup + "@:@";
        }
    });

    
    if(choiGoosCupList != "") {
        choiGoosCupList = choiGoosCupList.substring(0,choiGoosCupList.length-3);
    } else {
    	$("#goosCupLayerPopup").dialog("close");
        return;
    }
    
    var popNm = "#goosCupLayerPopup";
    var obj = $(this);
    $.ajax({
        url: 'https://www.hddfs.com/shop/or/order/choiGoosCup.json',
        method: "post",
        timeout : 60000,
        data: {cupApplList : choiGoosCupList, goosCupCartApplYn : true},
        async: false,
        dataType : 'json',
        beforeSend : function(){
            scroll_on(popNm);
            
        },
        success : function(data, textStatus, jqXHR) {
          
            var dcAmtResult = setCupDcAmt(data, "goos");
            
            if(!dcAmtResult) {
                return;
            }

            goosCupEtcInfoSetting(data);
            
            
            $("#goosCupLayerPopup").dialog("close");
        	
        	
        },
        complete : function (){
            scroll_off(popNm);
            $("#orderLoading").hide(); 
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
	   
}
    
function scroll_on(name) {
	$(name).on('scroll touchmove mousewheel', function (e) {
		e.preventDefault();
		e.stopPropagation();
		return false;
	});
}

function scroll_off(name) {
	$(name).off('scroll touchmove mousewheel');
}
    

function simpRsvgPoinIssuLayerPopup(type) {
    
    if(type == "open") {
        $("#simpRsvgPoinIssuLayerPopup").show();
        $("#simpRsvgPoinIssuLayerPopup").dialog({
            dialogClass: "pop_type1",
            minHeight: 488,
            maxHeight: 600,
            width: 412,
            modal: true,
            close:function(){
                $("#simpRsvgPoinIssuLayerPopup").dialog("close");
            }
        });
    } else if(type == "agree") {        
        if($("#orderSimpRsvgPoinAgrYn").is(':checked')) {
            $.ajax({
	            url: 'https://www.hddfs.com/shop/or/order/intgMemberSimpRsvg.json',
	            method: "post",
	            data: {custNm : $("input[name='custNm']").val() , birthDt : $("input[name='birthDt']").val() , mophNo : $("input[name='mophNo']").val() , ptnrTcmYn : "Y"},
	            async: true,
	            dataType : 'json',
	            success : function(data, textStatus, jqXHR) {
	            
	            	$("#simpRsvgPoinIssuLayerPopup").dialog("close");
	            	alert(data.redirect.message);
	            },
	            error : function(jqXHR, textStatus, errorThrown) {
	                alert('처리중 오류가 발생하였습니다.'); 
	            }
	        });
            
        } else {
            alert("간편적립포인트 발급신청 동의 여부를 확인해주세요.");
            $("#orderSimpRsvgPoinAgrYn").focus();
        }
    } else {
        $("#simpRsvgPoinIssuLayerPopup").dialog("close");
    }
    return true;
}


function basicSvmtRedrew(innerHtmlId, psbAmtId, psbAmtClass, svmtList) {
    
    var html ="";
    var svmtUsePsbKrw = 0;
    var textYn = false;
    
    var svmtListLength = $.trim(svmtList) == "" ? 0 : svmtList.length;
    
    
    if(svmtListLength > 1) {
    	var tempSvmtIdList = new Array();
    	var tempSvmtId = "";
    	for(var i=0; i<svmtListLength; i++) {
    		if(svmtList[i].svmtId != tempSvmtId) {
    			tempSvmtId = svmtList[i].svmtId;
    			tempSvmtIdList.push(tempSvmtId);
    		}
    	}
    	
    	
		var tempSvmtIsFirst = false;
		var tempSvmtIndex = 0;
    	for(var j=0; j<tempSvmtIdList.length; j++) {
    		tempSvmtIsFirst = false;
    		tempSvmtIndex = 0;
    		for(var i=0; i<svmtList.length; i++) {
    			if(tempSvmtIdList[j] == svmtList[i].svmtId) {
    				if(!tempSvmtIsFirst) {
    					
    					tempSvmtIsFirst = true;
    					tempSvmtIndex = i;
    					
    					svmtList[i].usePsbYn = "Y";
    				} else {
    					
    					svmtList[tempSvmtIndex].svmtPublAmt += svmtList[i].svmtPublAmt;
    					svmtList[tempSvmtIndex].svmtAmt += svmtList[i].svmtAmt;
    					
    					svmtList[i].usePsbYn = "N"; 
    				}
    			} else {
    				if(tempSvmtIsFirst) {
    					
    					break;
    				}
    			}
    		}
    	}
    }
    
    for(var i=0; i<svmtListLength; i++) {
        textYn = false;
        
        if($.trim(svmtList[i].usePsbYn) == "N") {
        	
        	continue;
        }
        
        html += "<div class='eve_cou'>";
        html += "<dl>";
        html += "<dt>"+svmtList[i].svmtNm+"</dt>";
        html += "<dd>";
        html += "<p>";
        
        if($.trim(svmtList[i].useStDolrAmt) != "" && Number(svmtList[i].useStDolrAmt) > 0) {
            textYn = true;          
            html += "$"+comma(svmtList[i].useStDolrAmt) + " 이상";
        }
        
        if($.trim(svmtList[i].useEndDolrAmt) != "" && Number(svmtList[i].useEndDolrAmt) > 0) {
            textYn = true;          
            html += " $"+comma(svmtList[i].useEndDolrAmt) + " 미만"; 
        }
        
        if(textYn) {
            html += " 구매 시"; 
        } else {
            html += "제한없음"; 
        }
        html += "</p>";
        
        html += "<p>";
        html += comma(svmtList[i].svmtPublAmt);
        html += "<span>원 - 사용가능: </span>"+comma(svmtList[i].svmtAmt);
        html += "<span>원</span>";
        html += "</p>";
        
        if(psbAmtId == "bran" && $.trim(svmtList[i].svmtApplItem) != "") {
			html += "<p class='brtxt'>";
			html += svmtList[i].svmtApplItem;
			html += "</p>";
		}
        
        html += "</dd>";
        html += "</div>";
        
        svmtUsePsbKrw += svmtList[i].svmtAmt;
    }
    
    $("#"+innerHtmlId).html(html);
    
    
    if(svmtUsePsbKrw < 0) {
        svmtUsePsbKrw = 0;
    }
    
    var amtHtml ="";
    
    
    if(svmtUsePsbKrw > 0) {
    	amtHtml += "<a noHref class='active_amount' onclick=\"plusSvmtLayerPopupOpen('"+psbAmtId+"'); return false;\">";
    }

    
    if(psbAmtClass == "") {
    	if(svmtUsePsbKrw > 0){
    		amtHtml += "사용가능 &nbsp;<em class='svmtUsePsbKrw'>"+comma(svmtUsePsbKrw)+"</em>원";	
    	}else{
    		amtHtml += "사용가능 &nbsp;<em class='svmtUsePsbKrw active_amount' style= 'font-weight : 600; font-size :14px;'>"+comma(svmtUsePsbKrw)+"</em>원";	
    	}
    	
    } else {
    	if(svmtUsePsbKrw > 0){
            amtHtml += "사용가능 &nbsp;<em class='"+psbAmtClass+"SvmtUsePsbKrw'>"+comma(svmtUsePsbKrw)+"</em>원";  
        }else{
            amtHtml += "사용가능 &nbsp;<em class='"+psbAmtClass+"SvmtUsePsbKrw active_amount' style= 'font-weight : 600; font-size :14px;'>"+comma(svmtUsePsbKrw)+"</em>원";
        }
    }
    
    if(svmtUsePsbKrw > 0) {
        amtHtml += "</a>";
    }
    
    $("#"+psbAmtId+"SvmtUseYn").html(amtHtml);
    
}


function ptnsPlsSvmtRedrew(svmtList) {
    var html ="";
    var subHtml ="";
    var dupUsePsbYn = "";
    
    var svmtListLength = $.trim(svmtList) == "" ? 0 : svmtList.length;
    
    for(var i=0; i<svmtListLength; i++) {
        var textYn = false;
        var dupUsePsbYnText = "";
        var count = i+1;
        
        if(svmtList[i].dupUsePsbYn != "Y") {
            dupUsePsbYnText = "ty_disabled";  
        }
        
         
        
        html += "<li>";
        html += "<span class='chk "+dupUsePsbYnText+"'>";
        html += "<input type='checkbox' name='ptnsSvmtSeq' id='ptnsSvmt"+count+"' value='"+svmtList[i].mbshSvmtSeq+"' class='plusSvmt'";
        html += " data-svmttype='ptns' data-applptnssvmtid='' data-applptnssvmtamt='0' data-svmtamt='"+svmtList[i].svmtAmt+"' data-svmtburdrate='"+svmtList[i].svmtBurdRate+"' data-applordg='1' data-dupusepsbyn='"+svmtList[i].dupUsePsbYn+"'>";
        
        html += "<label for='ptnsSvmt"+count+"'>";
        html += "<dl>";
        html += "<dt>"+svmtList[i].svmtNm+"</dt>";
        html += "<dd>";
        
        html += "<p><strong>";
        if($.trim(svmtList[i].useStDolrAmt) != "" && Number(svmtList[i].useStDolrAmt) > 0) {
            textYn = true;          
            html += "$"+comma(svmtList[i].useStDolrAmt) + " 이상"; 
        }
        
        if($.trim(svmtList[i].useEndDolrAmt) != "" && Number(svmtList[i].useEndDolrAmt) > 0) {
            textYn = true;          
            html += " $"+comma(svmtList[i].useEndDolrAmt) + " 미만"; 
        }
        
        if(textYn) {
            html += " 구매 시"; 
        } else {
            html += "제한없음"; 
        }
        html += "</strong></p>";
        
        html += "<strong>" + comma(svmtList[i].svmtPublAmt) + "</strong>원 ";
        html += "<empty class=\"ptnsUsePsbDoma\" data-seq=\""+svmtList[i].mbshSvmtSeq+"\" style=\"display:none;\"> - 사용가능: <strong>"+comma(svmtList[i].svmtAmt)+"</strong>원</empty>";
        
         
        if($.trim(svmtList[i].ptnrChlNm) != "") { 
            html += "<p class='brtxt'>"+svmtList[i].ptnrChlNm+"</p>";
        }
        
        html += "</dl>";
        html += "</label>";
        if($.trim(svmtList[i].dupUsePsbYn) != "Y") { 
            html += "<p class='no_double'>중복사용 불가</p>";
        }
        
        if($.trim(svmtList[i].ptnrChlNm) != "") { 
            
            
        }
        
        html += "</li>";
    }
    
    if(html != "") {
        subHtml += "<p class='fztit13'>총 사용가능 금액</p>";
        subHtml += "<span class='input_de hasbtn'>";
        subHtml += "<input type='text' id='ptnsSvmtCalcAmt' value='0' readonly>";
        subHtml += "<button type='button' class='btnde_type2 mid' onclick='ptnsPlsSvmtCalcChk();'><span class='font_14'>계산하기</span></button>";
        subHtml += "</span>";
    }
    
    $("#mbshPtnsSvmtList").html(html);
    $("#mbshPtnsSvmtListPoint").html(subHtml);  
    var amtHtml ="";
    
    if(svmtListLength > 0) {
        amtHtml += "<p id='dispPtnsApplMsg'>제휴 전용 혜택을 선택해주세요.</p>";
        amtHtml += "<p id='dispPtnsApplAmt' style='display:none;'>할인금액 &nbsp;<em id='dispPtnsSvmtAmt'>0</em>원</p>";
        amtHtml += "<a noHref class='btn' onclick=\"plusSvmtLayerPopupOpen('ptns'); return false;\">";
        amtHtml += "선택하기</a>";
    } else {
        amtHtml += "사용할 수 있는 적립금이 없습니다"; 
    }
    $("#ptnsSvmtUseYn").html(amtHtml);
    
    
    $("input[type='checkbox'][name='ptnsSvmtSeq']").off("click").on("click", function() {
        var thisObj = $(this);
        var checked = thisObj.prop("checked");
        var dupUsePsbYn = thisObj.data("dupusepsbyn");
        var checkedLength = $("input[type='checkbox'][name='ptnsSvmtSeq']:checked").length;
        
        if(checkedLength == 0 && checked == false) {
            $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
                $(this).prop("checked", false);
                $(this).prop("disabled", false);
            });
        } else if(checkedLength == 1 && checked == true) {
            $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
                var dup = $.trim($(this).data("dupusepsbyn"));
                if(dupUsePsbYn == "Y") {
                    if(dup != "Y") {
                        $(this).prop("disabled", true);     
                    }
                } else {
                    if(thisObj.val() != $(this).val()) {
                        $(this).prop("disabled", true);
                    }
                }
            });     
        }
        
        $("#ptnsSvmtCalcCheck").val("N");
    });
    
    
}


function settPlsSvmtRedrew(svmtList) {
    var html ="";
    
    var svmtListLength = $.trim(svmtList) == "" ? 0 : svmtList.length;
    for(var i=0; i<svmtListLength; i++) {
        var textYn = false;
        var count = i+1;
        
        html += "<li>";
        html += "<span class='chk'>";
        
        html += "<input type='radio' name='settWaySvmtSeq' id='settWaySvmtSeq"+count+"' value='"+svmtList[i].mbshSvmtSeq+"' class='plusSvmt'";
        html += " data-svmttype='sett' data-applsettsvmtid='' data-applsettsvmtamt='0' cardId='"+svmtList[i].cardId+"' dispSettWayCd='"+svmtList[i].dispSettWayCd+"' settWaySvmtAmt='"+svmtList[i].svmtAmt+"'>";
        
        html += "<label for='settWaySvmtSeq"+count+"'>";
        html += "<dl>";
        html += "<dt>"+svmtList[i].svmtNm+"</dt>";
        html += "<dd>";
        
        html += "<p><strong>";
        if($.trim(svmtList[i].useStDolrAmt) != "" && Number(svmtList[i].useStDolrAmt) > 0) {
            textYn = true;          
            html += "$"+comma(svmtList[i].useStDolrAmt) + " 이상"; 
        }
        
        if($.trim(svmtList[i].useEndDolrAmt) != "" && Number(svmtList[i].useEndDolrAmt) > 0) {
            textYn = true;          
            html += " $"+comma(svmtList[i].useEndDolrAmt) + " 미만"; 
        }
        
        if(textYn) {
            html += " 구매 시"; 
        } else {
            html += "제한없음"; 
        }
        html += "</strong></span>";
        
        html += "<p>";
        html += "<strong>" + comma(svmtList[i].svmtPublAmt) + "</strong>원";
        html += " - 사용가능: <strong id='settUsePsbAmt_"+svmtList[i].mbshSvmtSeq+"'>"+comma(svmtList[i].svmtAmt)+"</strong>원"; 
        html += "</p>";
        if($.trim(svmtList[i].ptnrChlNm) != "") {
            html += "<p class='brtxt'>"+svmtList[i].ptnrChlNm+"</p>";
        }
        
        if($.trim(svmtList[i].settWayNm) != "") {
            html += "<p class='brtxt'>"+svmtList[i].settWayNm+"</p>";
        }
        
        html += "</dl>";
        html += "</label>";
        html += "</span>";
        html += "</li>";
    }
    
    $("#mbshSettSvmtList").html(html);
    
     
    var amtHtml ="";
    if(svmtListLength > 0) {
        amtHtml += "<p id='dispSettApplMsg'>결제 전용 혜택을 선택해주세요.</p>";
        amtHtml += "<p id='dispSettApplAmt' style='display:none;'>할인금액 &nbsp;<em id='dispSettSvmtAmt'>0</em>원</p>";
        amtHtml += "<a noHref class='btn' onclick=\"plusSvmtLayerPopupOpen('sett'); return false;\">";
        amtHtml += "선택하기</a>";
    } else {
        amtHtml += "사용할 수 있는 적립금이 없습니다";
    }
    $("#settSvmtUseYn").html(amtHtml);
    
}


function ptnsPlsSvmtCalcChk() {
	
	$("#ptnsSvmtLayerPopupLoading").show();
	setTimeout(function() {
		ptnsPlsSvmtCalc();
    }, 100);
}

function ptnsPlsSvmtCalc() {
	
    if(!isLogin) {
        return false;
    }

    var checkedLength = $("input[type='checkbox'][name='ptnsSvmtSeq']:checked").length;
    var ptnsSvmtUseKrw = Number($(".ptnsSvmtUseKrw").text().replace(/[^0-9]/g,'')); 
    
    var pmptUseSvmtAmt = 0;
    if ($("input[name='pmptUseSvmtUseYn']:checked").val() == "Y") {
        pmptUseSvmtAmt = Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,''));
    }
    
    var pmptDcAmt = $.trim($("input[name='pmptDcAmt']").val()) == "" ? 0 : $("input[name='pmptDcAmt']").val(); 
    var ptnrPmptDcAmt = $.trim($("input[name='ptnrPmptDcAmt']").val()) == "" ? 0 : $("input[name='ptnrPmptDcAmt']").val(); 
    var ptnrPmptDcEvtSeq = $.trim($("input[name='ptnrPmptDcEvtSeq']").val()) == "" ? 0 : $("input[name='ptnrPmptDcEvtSeq']").val(); 
    
    var geneSvmtAmt = $.trim($("input[name='svmtAmt']").val()) == "" ? 0 : $("input[name='svmtAmt']").val();
    var evntSvmtAmt = $.trim($("input[name='evntSvmtAmt']").val()) == "" ? 0 : $("input[name='evntSvmtAmt']").val();
    var branSvmtAmt = $.trim($("input[name='branSvmtAmt']").val()) == "" ? 0 : $("input[name='branSvmtAmt']").val();
    
    
    var checkedSeq = "";
    if(checkedLength > 0){
        $("input[type='checkbox'][name='ptnsSvmtSeq']:checked").each(function() {
            checkedSeq += $(this).val() + ",";
        });
        
        checkedSeq = checkedSeq.substring(0, checkedSeq.length-1);
    }

    
    var popNm = "#ptnsSvmtLayerPopup";
    $.ajax({
        url: 'https://www.hddfs.com/shop/or/order/ptnsPlsSvmtAutoCalc.json',
        method: "post",
        data: {
            checkedLength : checkedLength
            , checkedSeq : checkedSeq
        	, pmptDcAmt : pmptDcAmt
            , ptnrPmptDcAmt : ptnrPmptDcAmt
            , ptnrPmptDcEvtSeq : ptnrPmptDcEvtSeq            
            , pmptUseSvmtUseYn : $("input[name='pmptUseSvmtUseYn']:checked").val()
            , pmptUseSvmtAmt : pmptUseSvmtAmt
            , svmtUsePsbKrw :  Number($(".svmtUsePsbKrw").text().replace(/[^0-9]/g,''))
            , totalGoosKrw : $("input[name='totalGoosKrw']").val()
            , totalSettKrw : $("input[name='totalSettKrw']").val()
            , svmtUseMaxAmt : $("input[name=svmtUseMaxAmt]").val()
            , geneSvmtAmt : geneSvmtAmt
            , evntSvmtAmt : evntSvmtAmt
            , branSvmtAmt : branSvmtAmt
        },
        async: false,
        dataType : 'json',
        beforeSend : function(){
            scroll_on(popNm);
            
        },
        success : function(data, textStatus, jqXHR) {
            
            var calcSeq = data.calcSeq;
            var calcAmt = data.calcAmt;
            var calcAmtUsd = data.calcAmtUsd;
            
            if(checkedLength == 0) {
                var isFirst = true;
                $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
                    if(calcSeq.indexOf($(this).val()) > -1) {
                        if(isFirst) {
                                                        
                            $(this).click();
                            isFirst = false;
                        } else {
                            $(this).prop("checked", true);
                        }
                    }
                });
            } else {
                if(checkedSeq != calcSeq) {
                    
                    $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
                        if(calcSeq.indexOf($(this).val()) > -1) {
                            $(this).prop("checked", true);
                        } else {
                            $(this).prop("checked", false);
                        }
                    });
                    
                    alert("최대사용 적립금까지 적용되었습니다."); 
                }
            }
            
            if($.trim(data.calcSeqByAmt) != "") {
                var tempSeqSplit = data.calcSeqByAmt.split("@");
                
                for(var i=0; i<tempSeqSplit.length; i++) {
                    if($.trim(tempSeqSplit[i]) != "") {
                        var t = tempSeqSplit[i].split("::");
                        $("empty.ptnsUsePsbDoma").filter("[data-seq='"+t[0]+"']").find("strong").text(comma(t[1]));
                    }
                }
            }
            
            $("empty.ptnsUsePsbDoma").each(function(idx, obj){
                var ptnsChecked = $(this).parent().parent().parent().parent().find("input:first").is(":checked");
                if(ptnsChecked) {
                    $(this).show();                     
                } else {
                    $(this).hide();
                }
            });
            
            
            $("#ptnsSvmtCalcAmt").val(comma(calcAmt));
            
          },
          complete : function (){
              scroll_off(popNm);
              $("#ptnsSvmtLayerPopupLoading").hide(); 
          },
          error : function(jqXHR, textStatus, errorThrown) {
              alert("제휴플러스 처리중 오류가 발생하였습니다."); 
          }
      });   

    $("#ptnsSvmtCalcCheck").val("Y");
}


function ptnsPlsSvmtAppl() {
    
    var checkedLength = $("input[type='checkbox'][name='ptnsSvmtSeq']:checked").length;
    var ptnsSvmtUseKrw = $.trim(Number($(".ptnsSvmtUseKrw").text().replace(/[^0-9]/g,''))); 
    
    if(ptnsSvmtUseKrw == "") {
        ptnsSvmtUseKrw = 0;
    }
    
    
    if(checkedLength == 0 && ptnsSvmtUseKrw == 0) {
    	
        $("#ptnsSvmtLayerPopup").dialog("close");
        return false; 
    }

    if(checkedLength > 0 && $("#ptnsSvmtCalcCheck").val() != "Y") {
        alert("계산하기 버튼을 눌러주세요."); 
        return false;
    }
    
    initSettSvmtAmt(); 
    initEtcAmt(); 
    
    var ptnsSvmtAmt = 0;
    var ptnsSvmtSeqList = 0;
    if(checkedLength == 0) {
        $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
            $(this).data("applptnssvmtid", "");
        });
    } else {
        $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
            if($(this).prop("checked") == true) {
                $(this).data("applptnssvmtid", $(this).val());
                
                var applAmt = Number($("empty.ptnsUsePsbDoma").filter("[data-seq='"+$(this).val()+"']").find("strong").text().replace(/[^0-9]/g,''));
                $(this).data("applptnssvmtamt", applAmt);
                
                ptnsSvmtSeqList += $(this).val()+",";
                ptnsSvmtAmt += applAmt;
                
            } else {
                $(this).data("applptnssvmtid", "");
                $(this).data("applptnssvmtamt", "0");
            }
        });
        
        ptnsSvmtSeqList = ptnsSvmtSeqList.substring(0, ptnsSvmtSeqList.length-1);
    }
    
    
    var svmtUseLmtAmt = getSvmtUseLmtAmt('PTNS');
    if(ptnsSvmtAmt > svmtUseLmtAmt) {
        var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
        alert("본 주문에서 사용가능한 적립금은 최대 %s 원입니다. 다시 입력해주세요.".replace("%s", comma(svmtUseMaxAmt))); 
        return;
    }

    if(ptnsSvmtAmt == 0) {
        $("#dispPtnsApplMsg").show();
        $("#dispPtnsApplAmt").hide();
    } else {
        $("#dispPtnsApplMsg").hide();
        $("#dispPtnsApplAmt").show();       
    }
    $("#dispPtnsSvmtAmt").text(comma(ptnsSvmtAmt)); 
    $(".ptnsSvmtSeqList").val(ptnsSvmtSeqList); 
    $(".ptnsSvmtAmt").val(ptnsSvmtAmt); 
    $(".ptnsSvmtUseKrw").text(comma(ptnsSvmtAmt)); 

    getOrderSvmtAmt("SVMT");
    
    
    $("#ptnsSvmtLayerPopup").dialog("close");
}
    

function settPlsSvmtAppl() {
    
	var applYn = true; 
    var objThis = $("input[name='settWaySvmtSeq']:checked");
    var dispSettWayCd = objThis.attr("dispsettwaycd");
    var settSvmtCardId = $.trim(String(objThis.attr("cardid")).replace("null", ""));
    var settWaySvmtAmt = objThis.attr("settwaysvmtamt");
    
    
    var geneMbshCupSeq = $("select[name='geneMbshCupSeq']").data("cupseq");
    var dblMbshCupSeq = $("select[name='dblMbshCupSeq']").data("cupseq");
    
    var geneMbshCupSettWayCd = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("dispSettWayCd");
    var geneMbshCupSettCardId = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("cardid");
    
    var dblMbshCupSettWayCd = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("dispSettWayCd");
    var dblMbshCupSettCardId = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("cardid");
    
    var settPlsSvmtProgYn = true;
    
    if($.trim(geneMbshCupSeq) != "" && $.trim(geneMbshCupSettWayCd) != "") {
        if(dispSettWayCd != geneMbshCupSettWayCd) {
        	
            settPlsSvmtProgYn = false;
        } else if(settSvmtCardId != geneMbshCupSettCardId) {
        	
            settPlsSvmtProgYn = false;
        }
    }
    
    if($.trim(dblMbshCupSeq) != "" && $.trim(dblMbshCupSettWayCd) != "") {
        if(dispSettWayCd != dblMbshCupSettWayCd) {
        	
            settPlsSvmtProgYn = false;
        } else if(settSvmtCardId != dblMbshCupSettCardId) {
        	
            settPlsSvmtProgYn = false;
        }
    }
    
    if(!settPlsSvmtProgYn) {
    	if(objThis.val() == "") {
    		
        } else {
        	
    		applYn = false;
        }
    }
    
    
    var pmptDcEvtObj = $("input[type='radio'][name='pmptDcEvt']:checked");
    if(pmptDcEvtObj.length > 0 && pmptDcEvtObj.val() != "") {
        var settInfoCmpaSucc = "Y";
        
        var pmptDcDispSettWayCd = $.trim(pmptDcEvtObj.data("dispsettwaycd"));
        var pmptDcCardId = $.trim(pmptDcEvtObj.data("cardid"));
        
        
        if(objThis.val() != "") {
            var settSvmtDispSettWayCd = $.trim(objThis.attr("dispSettWayCd"));
            var settSvmtCardId = $.trim(objThis.attr("cardid"));
            
            if(pmptDcDispSettWayCd == settSvmtDispSettWayCd) {
                if(pmptDcCardId == "") {
                	
                } else {
                    if(pmptDcCardId == settSvmtCardId) {
                    	
                    } else {
                    	
                        settInfoCmpaSucc = "N";
                    }
                }
            } else {
            	
                settInfoCmpaSucc = "N";

            }
        }
        
        if(settInfoCmpaSucc != "Y") {
			applYn = false;
        }
    }
    
    if(!applYn) {
				
		if(!applSettFixInit()) {
			if($.trim($("#settWaySvmtSeqApplTmp").val()) != "")	 {
				$("input[type='radio'][name='settWaySvmtSeq']").filter("[value='"+$("#settWaySvmtSeqApplTmp").val()+"']").prop("checked", true);
			} else {
				$("input[type='radio'][name='settWaySvmtSeq']").filter("[value='']").prop("checked", true);
			}
		} else {
			
			$("#settSvmtLayerPopup").dialog("close");
		}
		return false;
	}
    
    
        
    if(!isEmpty(dispSettWayCd)) {
    	
        var existsSettwaycd = existsSettWayCdApplYn(dispSettWayCd, settSvmtCardId);
        
        if(!existsSettwaycd) {
            alert("적용가능한 결제수단이 존재하지 않습니다."); 
            $("input[type='radio'][name='settWaySvmtSeq']").filter("[value='']").prop("checked", true);
            
            return;
        }
    }
    
    initEtcAmt(); 
    
    
    $("input[name='settWaySvmtAmt']").val(settWaySvmtAmt);
    $(".settSvmtUseKrw").text(comma(Number(settWaySvmtAmt))); 
    $("#settWaySvmtSeqApplTmp").val(objThis.val());

    
    fixSettInfo("svmt", dispSettWayCd, settSvmtCardId, true);
    
    if(Number($("input[name='settWaySvmtAmt']").val()) <= 0) {
        $("#dispSettApplMsg").show();
        $("#dispSettApplAmt").hide();
        $("#dispSettSvmtAmt").text("0");
        $("#dispSettWayNm").text("");
    }
    
    
    getOrderSvmtAmt("SVMT");
    calnSettAmt(); 
    getChagDcAmt(); 
    
    paymentSettInfo(); 
    var settWaySvmtSeq =   $("input[name='settWaySvmtSeq']:checked").val();
    $("#settWaySvmtSeq").val(settWaySvmtSeq);
    
    
    $("#settSvmtLayerPopup").dialog("close");
};

function getTxnId(){
	  
    document.smilepayForm.target = "txnIdGetterFrame";
    document.smilepayForm.acceptCharset = "utf-8";
    if (document.smilepayForm.canHaveHTML) { 
        document.charset = smilepayForm.acceptCharset;
    }
    document.smilepayForm.GoodsName.value = document.smilepayForm.GoodsNm.value;
    document.smilepayForm.action = "getTxnId.do";
    
    document.smilepayForm.submit();
}


function cnspay() { 
    
    if(document.smilepayForm.ResultCode.value == '0000') {
        XD.receiveMessage(smilepay_callback, "https://pg.cnspay.co.kr" );
        
        
        if(cnspay_L.domain == "") {
            cnspay_L.domain = "https://pg.cnspay.co.kr";
        }
        cnspay_L.method = "/smile/v2/certPage" ;
        cnspay_L.callAPIPage("smilePay_layer", eval(document.smilepayForm.UsePopup.value), smilepay_callback, document.smilepayForm.TxnId.value);
    } else {
        alert('[RESULT_CODE] : ' + document.smilepayForm.ResultCode.value + '\n[RESULT_MSG] : ' + document.smilepayForm.ResultMsg.value);
    }
}

var smilepay_callback = function (message){ 
    cnspay_L.destroy();

    if(message != null && message != "null"){
        var obj;
        
        if(message.data != null && message.data != "null"){
            obj = JSON.parse(message.data);
        }else{
            if(typeof(message) == "string"){
                var replaceMessage = message.replace(/&quot;/g, '\"');
                obj = JSON.parse(replaceMessage);
            }else{
                alert('결제가 취소되었습니다.');
                window.location.reload();
                return;
            }
        }
        
        setResData(obj);

        if(obj.Spu.length> 0 && obj.SpuSignToken.length > 0) {
            saveOrder($("form[name='smilepayForm']").serialize()); 
        }
    }else{ 
        alert('결제가 취소되었습니다.');
        window.location.reload();
    }
}

function setResData(obj){   
    document.getElementsByName('Spu')[0].value = obj.Spu;
    document.getElementsByName('SpuSignToken')[0].value = obj.SpuSignToken;
    document.getElementsByName('SmileCash')[0].value = obj.SmileCash;    
    document.getElementsByName('Tid')[0].value = obj.Tid;    
    document.getElementsByName('AuthToken')[0].value = obj.AuthToken;
    document.getElementsByName('Etc1')[0].value = "return=>"+obj.Etc1;
    document.getElementsByName('Etc2')[0].value = "return=>"+obj.Etc2;
    document.getElementsByName('Etc3')[0].value = "return=>"+obj.Etc3;
}

function fnUsePopupChanged(){
    if(document.smilepayForm.UsePopup.value == 'true'){
                document.smilepayForm.ReturnUrl2.value = "https://www.hddfs.com/shop/or/order/smilepayApproveReturn2.do";
    } else {
        document.smilepayForm.ReturnUrl2.value = "";
    }
}


function getPtnrPmptDcSettAmt() {
    if($('#ptnrPmptDcType').val() == '') {
        alert("제휴사인증할인을 선택해주세요."); 
        $('#ptnrPmptDcType').focus();
        return;
    }
    
    
    var settAmt = Number($("input[name='totalGoosKrw']").val()); 
    $(".dcInfo.exceptDc").each(function() {
        settAmt -= Number($(this).text().replace(/[^0-9]/g,''));
    });
    
    settAmt -= Number($(".dcCupKrw.dcInfo").text().replace(/[^0-9]/g,''));  
    
    
    
    return settAmt;
}


function getSvmtUseLmtAmt(svmtType){
    
    var svmtUseLmtAmt = Number($("input[name=svmtUseMaxAmt]").val());
    if(svmtUseLmtAmt > 0){
    	
        if(svmtUseLmtAmt > 0 && $("input[name='pmptUseSvmtUseYn']:checked").val() == "Y") {
            svmtUseLmtAmt -= Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,''));
        }
        
        
        if(svmtType != 'SVMT' && !isEmpty($(".svmtAmt").val())) {
            svmtUseLmtAmt -= Number($(".svmtAmt").val());
        }
            
        
        if(svmtType != 'MOBL' && !isEmpty($(".moblSvmtAmt").val())) {
            svmtUseLmtAmt -= Number($(".moblSvmtAmt").val());
        }
            
        
        if(svmtType != 'EVNT' && !isEmpty($(".evntSvmtAmt").val())) {
            svmtUseLmtAmt -= Number($(".evntSvmtAmt").val());
        }
            
        
        if(svmtType != 'BRAN' && !isEmpty($(".branSvmtAmt").val())) {
            svmtUseLmtAmt -= Number($(".branSvmtAmt").val());
        }
         
        
    }
    
    return svmtUseLmtAmt;
}


function goSett() {
     
        
    if (!checkVali()) {
        return false;
    }
    
    var settWayCd = $("#settWayCd").val();
    
    $.ajax({
        url: 'https://www.hddfs.com/shop/or/order/consmInfoCfm.do',
        method: "post",
        async: false,
        data : {settWayCd : settWayCd},
        dataType : 'html',
        success : function(data, textStatus, jqXHR) {
            $("#settInfoLayerPopup").html(data);
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	
			if(jqXHR.status == "404") {
				alert('유효하지 않은 요청입니다.');
				location.replace("https://www.hddfs.com/shop/or/order/listCart.do"); 	
			} else {
	            alert('처리중 오류가 발생하였습니다.');
			}
        }
    });
}

function doSett() {
    
    $("#layre_payment_chk").dialog('close');
    if (!checkVali()) {
        return;
    }
    settProgYn = "Y";

    var smsRcvYn = "N";
    if ($("#smsRcvYn").is(":checked")) {
        smsRcvYn = "Y";
    }

    $("input[name='smsRcvYn']").val(smsRcvYn);

    
    var befSettWaySaveYn = "N";
    $("input[type='checkbox'][class^='befSettWaySaveYn']").each(function(idx, obj){
        if(!$(this).is(":disabled") && $(this).is(":checked")) {
            befSettWaySaveYn = "Y";
            return false;
        }
    });

    $("input[name='befSettWaySaveYn']").val(befSettWaySaveYn);

    var dpatInfoSavYn = "N";
    if ($("#dpatInfoSavYn").is(":checked")) {
        dpatInfoSavYn = "Y";
    }

    $("input[name='dpatInfoSavYn']").val(dpatInfoSavYn);
    if($("input[name=settWayCd]").val() != "001"){
        $("#cardCd").val("");
    }
    
    $.ajax({
        url: 'https://www.hddfs.com/shop/or/order/validateOrder.json',
        method: "post",
        data: $("form[name='orderForm']").serialize(),
        async: true,
        dataType : 'json',
        success : function(data, textStatus, jqXHR) {
            if(crew.ajaxValidate(data, false)){
                if(data.resultCode == 1) {
                    if ($("input[name='settWayCd']").val() == "001") {
                        var cardCd = $("#cardCd").val(); 
                        if (cardCd == "0100" || cardCd == "0204" || cardCd == "0170") { 
                            $("form[name='ispForm']>input[name='KVP_PRICE']").val($("input[name='settPrrgAmt']").val());
                            $("form[name='ispForm']>input[name='KVP_CARDCOMPANY']").val(cardCd);
                            $("form[name='ispForm']>input[name='KVP_QUOTA']").val($("#istmMonsCnt").val());
                            $("form[name='ispForm']>input[name='KVP_QUOTA_INF']").val(Number($("#istmMonsCnt").val()));   
                            
                            MakePayMessage(document.ispForm);
                            
                        } else { 
                            $("form[name='Visa3d']>input[name='pan']").val("");
                            $("form[name='Visa3d']>input[name='dummy']").val("dummy");
                            $("form[name='Visa3d']>input[name='cardcode']").val(cardCd);
                            $("form[name='Visa3d']>input[name='purchase_amount']").val($("input[name='settPrrgAmt']").val());
                            $("form[name='Visa3d']>input[name='amount']").val($("input[name='settPrrgAmt']").val());
                            $("form[name='Visa3d']>input[name='installments']").val($("#istmMonsCnt").val());
                            $("form[name='Visa3d']>input[name='returnUrl']").val("https://www.hddfs.com/shop/or/order/mpiReturn.do?hddfsSession=sPa8fbQhr1vqCtrpxRKyBd5IfyYoCryNV1uLoMNigjVu9xwEbZ348rTap8heYdjr.b25saW5lX2RvbWFpbi9zZXJ2ZXJfZGZwa29fMQ==");

                            
                            _KSP_CALL_MPI(document.Visa3d ,paramSet);
                        }
                    } else if ($("input[name='settWayCd']").val() == "002" || $("input[name='settWayCd']").val().substring(0,1) == "2") {

                        $("form[name='ovseForm']>input[name='amt']").val($("input[name='settPrrgUsd']").val());
                        $("form[name='ovseForm']>input[name='item_0_unitPrice']").val($("input[name='settPrrgUsd']").val());

                        popOpen('', 'ovseCreditCard', 820, 600);

                        document.ovseForm.target = "ovseCreditCard";
                        document.ovseForm.submit();
                    } else if ($("input[name='settWayCd']").val() == "104") {
                        $("form[name='payForm']>input[name='Tradeid']").val(data.order.orderNo);
                        $("form[name='payForm']>input[name='Prdtprice']").val($("input[name='settPrrgAmt']").val());
                        $("form[name='payForm']>input[name='MC_SVCID']").val(data.svcid);
                        $("form[name='payForm']>input[name='PAY_MODE']").val(data.payMode);
                        $("form[name='payForm']>input[name='MC_AUTHPAY']").val(data.mcAuthpay);

                        MCASH_PAYMENT(document.payForm);
                    } else if ($("input[name='settWayCd']").val() == "105") {
                        $("form[name='Visa3d']>input[name='pan']").val("");
                        $("form[name='Visa3d']>input[name='dummy']").val("dummy");
                        $("form[name='Visa3d']>input[name='cardcode']").val("SP");
                        $("form[name='Visa3d']>input[name='purchase_amount']").val($("input[name='settPrrgAmt']").val());
                        $("form[name='Visa3d']>input[name='amount']").val($("input[name='settPrrgAmt']").val());
                        $("form[name='Visa3d']>input[name='installments']").val($("#istmMonsCnt").val());
                        $("form[name='Visa3d']>input[name='returnUrl']").val("https://www.hddfs.com/shop/or/order/sspayReturn.do?hddfsSession=sPa8fbQhr1vqCtrpxRKyBd5IfyYoCryNV1uLoMNigjVu9xwEbZ348rTap8heYdjr.b25saW5lX2RvbWFpbi9zZXJ2ZXJfZGZwa29fMQ==");
                        
                        _KSP_CALL_MPI(document.Visa3d ,"");
                    } else if ($("input[name='settWayCd']").val() == "107") {
                        getTxnId();
                    } else if ($("input[name='settWayCd']").val() == "106") {
                        kakaoPayment();
                    } else if ($("input[name='settWayCd']").val() == "108") {
                        naverPayment3();
                    } else if ($("input[name='settWayCd']").val() == "109") {
                        paycoPayment();
                    } else if ($("input[name='settWayCd']").val() == "110" || $("input[name='settWayCd']").val() == "111") {
                        hpayPayment();
                    } else {
                        console.log('saveOrder 호출 ');
                        saveOrder();
                    }
                } else {
                    alert(data.message);
                }

            } else {
                alert('처리중 오류가 발생하였습니다.');
            }
        },
        beforeSend: function() {
            $(".pmntLoading").show();
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
            $(".pmntLoading").hide();
        }
    });
}

function choiCartCupChk() {
    $("#cartCupLayerPopupLoading").show();
    setTimeout(function() {
    	choiCartCup();
    },100);
}

function choiCartCup(cupType) {
    
    var cartCupStat = "appl";
    if($("select[name='geneMbshCupSeq']").val() == "" && $("select[name='geneMbshCupSeq']").data("cupseq") != "" && $.trim($("select[name='dblMbshCupSeq']").val()) == "") {
        cartCupStat = "del"
    }
    
    if(cartCupStat == "del") {
        
              
        $("select[name='geneMbshCupSeq']").val("");
        $("select[name='dblMbshCupSeq']").val("");
        
        settFixDisabledOff(); 
    } else {
        if (isEmpty($("select[name='dblMbshCupSeq']").val()) && isEmpty($("select[name='geneMbshCupSeq']").val())) {
            alert('장바구니쿠폰을 선택해주세요.');
            return;
        } else if (!isEmpty($("select[name='dblMbshCupSeq']").val()) && isEmpty($("select[name='geneMbshCupSeq']").val())) {
            alert('일반 장바구니쿠폰을 먼저 선택해주세요.');
            return;
        }

        

        if (!isEmpty($("select[name='geneMbshCupSeq']").find("option:selected").attr("dispSettWayCd")) && !isEmpty($("select[name='dblMbshCupSeq']").find("option:selected").attr("dispSettWayCd"))) {
            if ($("select[name='geneMbshCupSeq']").find("option:selected").attr("dispSettWayCd") != $("select[name='dblMbshCupSeq']").find("option:selected").attr("dispSettWayCd") ||
                    $("select[name='geneMbshCupSeq']").find("option:selected").attr("cardId") != $("select[name='dblMbshCupSeq']").find("option:selected").attr("cardId")) {
                alert('서로 다른 결제수단 쿠폰을 사용할 수 없습니다.');
                return;
            }
        }
        
        var geneMbshCupSettWayCd = $("select[name='geneMbshCupSeq']").find("option:selected").attr("dispSettWayCd");
        var geneMbshCupSettCardId = $("select[name='geneMbshCupSeq']").find("option:selected").attr("cardid");
        
        var dblMbshCupSettWayCd = $("select[name='dblMbshCupSeq']").find("option:selected").attr("dispSettWayCd");
        var dblMbshCupSettCardId = $("select[name='dblMbshCupSeq']").find("option:selected").attr("cardid");
        
        if(!isEmpty($("select[name='geneMbshCupSeq']").val()) && !isEmpty(geneMbshCupSettWayCd)) {
            var existsSettWayCdYn = existsSettWayCdApplYn(geneMbshCupSettWayCd, geneMbshCupSettCardId);
            
            if(!existsSettWayCdYn) {
                alert('적용가능한 결제수단이 존재하지 않습니다.');
                return;
            }
        }
        
        if(!isEmpty($("select[name='dblMbshCupSeq']").val()) && !isEmpty(dblMbshCupSettWayCd)) {
            var existsSettWayCdYn = existsSettWayCdApplYn(dblMbshCupSettWayCd, dblMbshCupSettCardId);
            
            if(!existsSettWayCdYn) {
                alert('적용가능한 결제수단이 존재하지 않습니다.');
                return false;
            }
        }
    }
    
    $("#cartCupLayerPopupLoading").show();
    setTimeout(function() {
        setCartCup();
    },100);
    
    setTimeout(function() {
        getChagDcAmt();
    },1000);
    
}


function existsSettWayCdApplYn(dispSettWayCd, cardId) {

    var existsSettwaycd = false;
    
    if(!isEmpty(dispSettWayCd)) {
        var checkCardId = cardId;
        
        if(checkCardId != null && $.trim(String(checkCardId).replace("null", "")) != "") {
            $("div.settSvmt").each(function() {
                var settDispSettWayCd = $.trim($(this).data("dispsettwaycd"));
                var settCardId = $.trim($(this).data("settcardid"));
                
                if(settDispSettWayCd == dispSettWayCd && settCardId == checkCardId) {
                    existsSettwaycd = true;
                    return false; 
                }
            });
        } else if(dispSettWayCd == "110" || dispSettWayCd == "111") {
        	existsSettwaycd = true;
            return true; 
        }else {
        	if(dispSettWayCd == "002") {
				
				$("div.settSvmt").each(function() {
					var settDispSettWayCd = $.trim($(this).data("dispsettwaycd"));
					if(settDispSettWayCd == dispSettWayCd) {
						existsSettwaycd = true;
			            return false; 
					}
				});
			}
        	
        	
			if(!existsSettwaycd) {
	        	$("a.settSvmt").each(function() {
	                var settDispSettWayCd = $.trim($(this).data("dispsettwaycd"));
	                if(settDispSettWayCd == dispSettWayCd) {
	                    existsSettwaycd = true;
	                    return false; 
	                }
	            });
			}
            
			
            if(!existsSettwaycd) {
                $("input[type='radio'].settSvmt").each(function() {
                    if(dispSettWayCd == $(this).data("dispsettwaycd")) {
                        existsSettwaycd = true;
                        return false; 
                    }
                });
            }
        }
            
        return existsSettwaycd; 
    }
    
    return false;  
}



function setCartCup() {
	
	var popNm = "#cartCupLayerPopup";
	
	console.log('<!>');
	
	$.ajax({
        url: 'https://www.hddfs.com/shop/or/order/choiCartCup.json',
        method: "post",
        data: {geneMbshCupSeq : $("select[name='geneMbshCupSeq']").val(), dblMbshCupSeq : $.trim($("select[name='dblMbshCupSeq']").val())},
        async: false,
        dataType : 'json',
        beforeSend : function(){
            scroll_on(popNm);
            
        },
        success : function(data, textStatus, jqXHR) {
            
            var dcAmtResult = setCupDcAmt(data, "cart");
            
            if(!dcAmtResult) {
                return;
            }
            
            var cartCupApplCnt = 0;
            $(".choiCartCup").each(function(idx, obj){
                var cupSeq = $.trim($(this).val());
                
                    $(this).data("cupseq", cupSeq);
                
                
                if(cupSeq != "") {
                    cartCupApplCnt++;
                }
            });
            
            var goosCupApplUsdAmt = Number($("#goosCupApplUsdAmt").text()); 
            var cartCupApplUsdAmt = (data.cupDcAmt.cartDcCupUsd).toFixed(2);
            var dispCupDcTotalAmt = Number(goosCupApplUsdAmt) + Number(cartCupApplUsdAmt);
            
            if(Number(dispCupDcTotalAmt) <= 0) {
                dispCupDcTotalAmt = Number("0");
            } else {
                dispCupDcTotalAmt = Number(dispCupDcTotalAmt).toFixed(2);
            }
            
            if(Number(cartCupApplUsdAmt) <= 0) {
                cartCupApplUsdAmt = Number("0");
            } else {
                cartCupApplUsdAmt = Number(cartCupApplUsdAmt).toFixed(2);
            }
            
            $("#dispCupDcTotalAmt").text(dispCupDcTotalAmt); 
            $("#cartCupApplUsdAmt").text(cartCupApplUsdAmt);  
            $("#cartCupApplCnt").text(cartCupApplCnt+'장 적용');
            
            
            $("#cartCupLayerPopup").dialog("close");
        },
        complete : function (){
            scroll_off(popNm);
            $("#cartCupLayerPopupLoading").hide(); 
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
    
	
    getChagDcAmt("cup");
}

function setCupDcAmt(data, cupType) {

	
    if(data == null || data.cupDcAmt == null) {
        alert("최대 사용 할인율을 초과하여 쿠폰을 사용할 수 없습니다."); 
        
        if(!isEmpty($("select[name='geneMbshCupSeq']").val())) {
            $("select[name='geneMbshCupSeq']").val("");
            $("select[name='dblMbshCupSeq']").prop("disabled", true);
        } else if(!isEmpty($("select[name='dblMbshCupSeq']").val())) {
            $("select[name='dblMbshCupSeq']").prop("disabled", false);
        }
        
        $("select[name='dblMbshCupSeq']").val("");
        
        return false;
    }
	
	
	if ($.trim(data.cupDcAmt.geneCartDcCupUsd) != "" && data.cupDcAmt.geneCartDcCupUsd == 0 && !isEmpty($("select[name='geneMbshCupSeq']").val())) {
        alert("최대 사용 할인율을 초과하여 쿠폰을 사용할 수 없습니다."); 
        $("select[name='geneMbshCupSeq']").val("");
        $("select[name='dblMbshCupSeq']").prop("disabled", true);
        $("select[name='dblMbshCupSeq']").val("");
        return false;
    } else if ($.trim(data.cupDcAmt.dblCartDcCupUsd) != "" && data.cupDcAmt.dblCartDcCupUsd == 0 && !isEmpty($("select[name='dblMbshCupSeq']").val())) {
        alert("최대 사용 할인율을 초과하여 더블 쿠폰을 사용할 수 없습니다."); 
        $("select[name='dblMbshCupSeq']").prop("disabled", false);
        $("select[name='dblMbshCupSeq']").val("");
        return false;
    }

    $(".totalDcUsd").text(comma(Number((Number($("input[name='totalGoosDcUsd']").val()) + data.cupDcAmt.pmptDcCupUsd + data.cupDcAmt.goosDcCupUsd + data.cupDcAmt.goosDcDblCupUsd + data.cupDcAmt.cartDcCupUsd).toFixed(2))));
    $(".totalDcKrw").text(comma(data.cupDcAmt.pmptDcCupKrw + data.cupDcAmt.goosDcCupKrw + data.cupDcAmt.goosDcDblCupKrw + data.cupDcAmt.cartDcCupKrw + Number($("input[name='totalGoosDcKrw']").val()))+'원');
    $(".totalSettUsd").text(comma(Number((Number($("input[name='totalSettUsd']").val()) - (data.cupDcAmt.pmptDcCupUsd + data.cupDcAmt.goosDcCupUsd + data.cupDcAmt.goosDcDblCupUsd + data.cupDcAmt.cartDcCupUsd)).toFixed(2))));
    $(".totalSettKrw").text(comma(Number($("input[name='totalSettKrw']").val()) - (data.cupDcAmt.pmptDcCupKrw + data.cupDcAmt.goosDcCupKrw + data.cupDcAmt.goosDcDblCupKrw + data.cupDcAmt.cartDcCupKrw))+'원');

    $(".dcCupKrw").text(comma(data.cupDcAmt.pmptDcCupKrw + data.cupDcAmt.goosDcCupKrw + data.cupDcAmt.goosDcDblCupKrw + data.cupDcAmt.cartDcCupKrw));
    
	var cupDataKey = Object.keys(data.cupDcAmt.goosDcCupKrwForHpoin); // 2022.08.16 상품번호별 쿠폰가 뽑아오기 [이호원]
    for(var i=0; i<cupDataKey.length; i++) {
    	$("li[goosCd='"+cupDataKey[i]+"']").children(".txt.cupDcAmtKrw").text(data.cupDcAmt.goosDcCupKrwForHpoin[cupDataKey[i]]);
    }
    
    
    $("input[name='allUseSvmt']").attr("disabled", "disabled");
    $("input[name='svmtAmt']").attr("disabled", "disabled");
    $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
    $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
    
    
    $("input[name='allUseEvntSvmt']").attr("disabled", "disabled");
    $("input[name='evntSvmtAmt']").attr("disabled", "disabled");
    
    
    $("input[name='allUseBranSvmt']").attr("disabled", "disabled");
    $("input[name='branSvmtAmt']").attr("disabled", "disabled");
    
    initSettWay("all");
    
    
    getPmptDcList(false);
    
    getPtnrPmptDcAmt(); 
    
    getSvmtRsvgAmt(); 
    getOrderSvmtAmt("cup");

    

    if (cupType == "cart") {
    	
        calnSettAmt("cup");
        
        paymentSettInfo(); 
    } else {
        calnSettAmt();
    }
    $("#mbshSvmtInfo").removeClass('opened');

    return true; 
}


function initSettWay(exceptType) {
    $(".settWay").text("0");
    $("input[name='allUseCdpst']").prop("checked", false);
    $("input[name='cdpstAmt']").val("");

    
    $("input[name='allUseAdvs']").prop("checked", false);
    $("input[name='advsAmt']").val("");
    
    $("input[name='allUseGfcaCdpst']").prop("checked", false);
    $("input[name='gfcaCdpstAmt']").val("");
    $("input[name='allUseSvmt']").prop("checked", false);
    $("input[name='svmtAmt']").val("");
    $(".svmtAmt").val("0");
    
    
    $("input[name='evntSvmtAmt']").val("");
    $(".evntSvmtAmt").val("0");
    $("input[name='branSvmtAmt']").val("");
    $(".branSvmtAmt").val("0");
    
    $("input[name='allUseHpoin']").prop("checked", false);
    $("input[name='hpoinAmt']").val("");
    initHPoinPlsAmt(); 
	$("input[name='ezwelWlfrPoinAmt']").val("");
	$(".ezwelWlfrPoinUseKrw").text("0");
	
	
	$("input[name='ezwelSvmtAmt']").val("");
	$(".ezwelSvmtUseKrw").text("0");
	
	
	$("input[name='ezwelSpclPoinAmt']").val("");
	$(".ezwelSpclPoinUseKrw").text("0");
    
    $("input[name='allUseMoblSvmt']").prop("checked", false);
    $("input[name='moblSvmtAmt']").val("");
    $(".moblSvmtAmt").val("0");
    $("input[name='cdpstAmt']").prop("readonly", false);
    $("input[name='advsAmt']").prop("readonly", false); 
    $("input[name='gfcaCdpstAmt']").prop("readonly", false);
    $("input[name='svmtAmt']").prop("readonly", false);
    
    
    $("input[name='evntSvmtAmt']").prop("readonly", false);
    $("input[name='branSvmtAmt']").prop("readonly", false);
    
    $("input[name='hpoinAmt']").prop("readonly", false);
    $("input[name='moblSvmtAmt']").prop("readonly", false);
    
    $("input[name='ezwelWlfrPoinAmt']").prop("readonly", false);
    $("input[name='ezwelSvmtAmt']").prop("readonly", false);
    $("input[name='ezwelSpclPoinAmt']").prop("readonly", false);
    
    if (exceptType == "all" || exceptType == "pmpt") {
    	
        initPtnsSvmtAmt(); 
        initSettSvmtAmt(); 
    }

    var svmtUseKrw = Number($("input[name='settWaySvmtAmt']").val());
    $(".svmtUseKrw").text(comma(svmtUseKrw));
    
    
    setSmsgpayIstmMons();        
}


function checkVali() {
    if (!isLogin) {
        if($.trim($("input[name='nmbshPwd']").val()) == "" || $.trim($("input[name='nmbshPwd1']").val()) == "") {
            alert("비밀번호를 입력해주세요."); 
            if($.trim($("input[name='nmbshPwd']").val()) == "") {
                $("input[name='nmbshPwd']").focus();
            } else {
                $("input[name='nmbshPwd1']").focus();
            }
            return false;
        }
        
        if($.trim($("input[name='nmbshPwd']").val()) != $.trim($("input[name='nmbshPwd1']").val())) {
            $("input[name='nmbshPwd1']").focus();
            alert("주문조회 비밀번호 확인이 일치하지 않습니다."); 
            return false;
        }
    }
    
    var checkSettInfo = checkSettGrpDoma();
    setPaymentData(checkSettInfo); 
    setSmsgpayIstmMons();
    
    var settWayCd = $("input[name='settWayCd']").val();

    if (Number($("input[name='settPrrgAmt']").val()) > 0) {
        if (isEmpty(settWayCd)) {
            alert('결제수단을 선택해주세요.');
            if(!$("#settInfoTit").hasClass("open")) {
                $("#settInfoTit").addClass("open");
                $(".payment_method").show();
            }
            return false;
        }
    }
    
    if (!isEmpty(settWayCd)) {
        if (Number($("input[name='settPrrgAmt']").val()) < 1000) {
            alert('결제금액은 최소 1,000원 이상입니다.');
            return false;
        }
        if (settWayCd == "001") {
            if (isEmpty($("#cardCd").val())) {
                alert('카드종류를 선택해주세요.');
                if(!$("#settInfoTit").hasClass("open")) {
                    $("#settInfoTit").addClass("open");
                    $(".payment_method").show();
                }
                return false;
            }

            if (Number($("input[name='settPrrgAmt']").val()) < 50000) {
                if ($("#istmMonsCnt").val() != "00") {
                    alert('국내신용카드 결제 시 50,000원 미만은 일시불로만 결제할 수 있습니다.');
                    return false;
                }
            }
        } else if (settWayCd == "103") {
            if (isEmpty($("#virtAcntBnkCd").val())) {
                alert('은행을 선택해주세요.');
                if(!$("#settInfoTit").hasClass("open")) {
                    $("#settInfoTit").addClass("open");
                    $(".payment_method").show();
                    
                }   
                return false;
            } else if (isEmpty($("#svacOwrNm").val())) {
                alert('입금자를 확인해주세요.');
                if(!$("#settInfoTit").hasClass("open")) {
                    $("#settInfoTit").addClass("open");
                    $(".payment_method").show();
                }
                return false;
            }
        }
    } else {
    	
        var gfcaCdpstAmt = isEmpty($("input[name='gfcaCdpstAmt']").val()) ? 0 : Number($("input[name='gfcaCdpstAmt']").val());
        var cdpstAmt = isEmpty($("input[name='cdpstAmt']").val()) ? 0 : Number($("input[name='cdpstAmt']").val());
        var advsAmt = isEmpty($("input[name='advsAmt']").val()) ? 0 : Number($("input[name='advsAmt']").val());
        var hpoinAmt = isEmpty($("input[name='hpoinAmt']").val()) ? 0 : Number($("input[name='hpoinAmt']").val());
        var hpoinPlsAmt = 0;
        if($.trim($("input[type='radio'][name='hpoinPlsUseYn']:checked").val()) == "Y") {
        	hpoinPlsAmt = Number($("#dispHpoinPlsAmt1").val());
        }
        
        var ezwelWlfrPoinAmt = isEmpty($("input[name='ezwelWlfrPoinAmt']").val()) ? 0 : Number($("input[name='ezwelWlfrPoinAmt']").val());
        var ezwelSvmtAmt = isEmpty($("input[name='ezwelSvmtAmt']").val()) ? 0 : Number($("input[name='ezwelSvmtAmt']").val());
        var ezwelSpclPoinAmt = isEmpty($("input[name='ezwelSpclPoinAmt']").val()) ? 0 : Number($("input[name='ezwelSpclPoinAmt']").val());
        
        var lgcpBuyMbshGrpCd = "001";
        
        if(lgcpBuyMbshGrpCd != 'MG' && (gfcaCdpstAmt + cdpstAmt + advsAmt + hpoinAmt + hpoinPlsAmt + ezwelWlfrPoinAmt + ezwelSvmtAmt + ezwelSpclPoinAmt < 1000)) {
            alert('결제금액은 최소 1,000원 이상입니다.');
            return false;
        }
    }

    
    if ($("#tempCashRcptTable").val() == "Y" && $("input[type='checkbox'][name='tempTrdrClsCd']:first").prop("checked") == true) {
        if (isEmpty($("input[name='idntCfmNo1']").val()) || isEmpty($("input[name='idntCfmNo2']").val()) || isEmpty($("input[name='idntCfmNo3']").val())) {
            alert('현금영수증 발급번호를 입력해주세요.');
            if(!$("#settInfoTit").hasClass("open")) {
                $("#settInfoTit").addClass("open");
                $(".payment_method").show();
                
            }
            
            return false;
        }
    }

    var geneMbshCupSeq = $("select[name='geneMbshCupSeq']").data("cupseq");
    if (!isEmpty(geneMbshCupSeq)) {
        var dispSettWayCd = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("dispSettWayCd");
        var cardId = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("cardid");

        if (!isEmpty(dispSettWayCd)) {
	        if (dispSettWayCd != settWayCd) {
	            alert("선택한 결제수단쿠폰의 결제수단을 선택해주세요."); 
	            return false;
	        }
	
	        if (!isEmpty(cardId)) {
	            if (settWayCd == "001") {
	                if ($("#cardCd").val() != cardId) {
	                	alert("선택한 결제수단쿠폰의 신용카드를 선택해주세요."); 
	                    return false;
	                }
	            }
	        }
        }
    }

    var dblMbshCupSeq = $("select[name='dblMbshCupSeq']").data("cupseq");
    if (!isEmpty(dblMbshCupSeq)) {
        var dispSettWayCd = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("dispSettWayCd");
        var cardId = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("cardid");

        if (!isEmpty(dispSettWayCd)) {
	        if (dispSettWayCd != settWayCd) {
	        	 alert("선택한 결제수단쿠폰의 결제수단을 선택해주세요."); 
	            return false;
	        }
	
	        if (!isEmpty(cardId)) {
	            if (settWayCd == "001") {
	                if ($("#cardCd").val() != cardId) {
	                	alert("선택한 결제수단쿠폰의 신용카드를 선택해주세요."); 
	                    return false;
	                }
	            }
	        }
        }
    }
    
    
    var pmptDcEvtObj = $("input[type='radio'][name='pmptDcEvt']:checked");
    if (!isEmpty(pmptDcEvtObj.val())) {
        var dispSettWayCd = pmptDcEvtObj.data("dispsettwaycd");
        var cardId = pmptDcEvtObj.data("cardid");
        var settMethCd = $.trim(String(pmptDcEvtObj.data("settmethcd")).replace("null", ""));
        
        if (dispSettWayCd != settWayCd) {
            alert("선택한 카드/제휴 즉시할인의 결제수단을 선택해주세요."); 
            return false;
        }

        if (!isEmpty(cardId)) {
            if (settWayCd == "001") {
                if ($("#cardCd").val() != cardId) {
                    alert("선택한 카드/제휴 즉시할인의 신용카드를 선택해주세요."); 
                    return false;
                }
            }
        }
        
        
        if(settMethCd == "01" && settWayCd == "001") {
        	if(checkSettInfo[6] == "Y") {
        		var pmptDcApplDcText = $("input[type='radio'][name='pmptDcEvt']").filter("[value='"+$("#tempCardPtnrSeq").val()+"']").parent().find('label > strong > ez').text();
        		
        		if(pmptDcApplDcText.indexOf("(") > -1) {
	        		pmptDcApplDcText = pmptDcApplDcText.substring(0, pmptDcApplDcText.indexOf("("));
        		}
        		alert("%s 즉시할인 행사는 무이자 할부로 결제시에만 적용 가능합니다.".replace("%s", pmptDcApplDcText));
                return false;
        	}
        }
    }
    
    
    $("input[type='radio'][name='settWaySvmtSeq']").filter("[value='"+$("#settWaySvmtSeqApplTmp").val()+"']").prop("checked", true);
    
    if (!isEmpty($("input[name='settWaySvmtSeq']:checked").val())) {
        var dispSettWayCd = $("input[name='settWaySvmtSeq']:checked").attr("dispSettWayCd");
        var cardId = $("input[name='settWaySvmtSeq']:checked").attr("cardId");

        if (dispSettWayCd != settWayCd) {
            alert("선택한 결제플러스 적립금의 결제수단을 선택해주세요."); 
            return false;
        }

        if (!isEmpty(cardId)) {
            if (settWayCd == "001") {
                if ($("#cardCd").val() != cardId) {
                    alert("선택한 결제플러스 적립금의 신용카드를 선택해주세요."); 
                    return false;
                }
            }
        }
    }
    
    if (!isEmpty($("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("dispSettWayCd")) 
    		|| !isEmpty($("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("dispSettWayCd"))
    		|| !isEmpty($("input[name='settWaySvmtSeq']:checked").val())) {
        if (Number($("input[name='settPrrgAmt']").val()) < 1000) {
            alert("결제금액은 최소 1,000원 이상입니다."); 
            return false;
        }
    }

    if (Number($("input[name='hpoinAmt']").val()) >= 100000 && !hpoinUseAucaYn) {
        alert('SMS를 인증해주세요.');
        $("#btnHpoinUseAuca").focus();
        return false;
    }

    if (!$("#chkAgree").is(":checked")) {
        alert('구매 동의 여부를 확인해주세요.');
        return false;
    }

    return true;
}

 
function getDcAmt(type) {
    var priceList2Display = "none"; 
    var dcAmt = 0;
    var dcAmtUsd = 0;
    
    
    $(".dcInfo").each(function() {
        dcAmt += Number($(this).text().replace(/[^0-9]/g,''));
        
        if (!$(this).hasClass("exceptDc")) {
            dcAmtUsd += Number($(this).text().replace(/[^0-9]/g,''));
        }
        if (Number($(this).text().replace(/[^0-9]/g,'')) > 0) {
            $(this).parent().show();
            
            if($(this).closest(".price_list2").length > 0) {
                priceList2Display = "";
            }
        } else {
            
            $(this).parent().hide()
        }
    }); 
    
    $(".price_list2").css("display", priceList2Display);
    
    if(type == 'krw') {
        return dcAmt;
    } else {
        return dcAmtUsd;
    }
}

function calnSettAmt(fixSettWayType) {
	
    var dcAmt = 0;
    var dcAmtUsd = 0;
    var cdpstAmt = 0;
    var advsAmt = 0;
    var gfcaCdpstAmt = 0;    
    var priceList2Display = "none";
    
    dcAmt = getDcAmt('krw');
    dcAmtUsd = getDcAmt('usd');
    
    var settPrrgAmt = Number($("input[name='totalGoosKrw']").val()) - dcAmt;
    var settPrrgUsd = (((Number($("input[name='totalSettUsd']").val()) * 100) - (Math.floor(Math.round(1 / exchr * 10000000000) / 10000000000 * dcAmtUsd * 100) / 100) * 100) / 100).toFixed(2);
    
    if (settPrrgAmt == 0) {
        settPrrgUsd = 0;
    }

    $("input[name='settPrrgAmt']").val(settPrrgAmt);
    $("input[name='settPrrgUsd']").val(settPrrgUsd);
    $("input[name='SupplyAmt']").val(settPrrgAmt);
    $("input[name='totalAmount']").val(settPrrgAmt);
    $("input[name='taxFreeAmount']").val(settPrrgAmt);
    $("input[name='Amt']").val(settPrrgAmt);
    $("input[name='totalOrderAmt']").val(settPrrgAmt);
    $(".totalSettKrw").text(comma(settPrrgAmt)+'원');
    $(".totalDcKrw").text(comma(dcAmt)+'원');
    $(".totalSettUsd").text('$'+comma(settPrrgUsd));
    $(".totalDcUsd").text('$'+comma(Number(($("input[name='totalGoosUsd']").val()) - settPrrgUsd).toFixed(2) * 100 / 100));
    $(".natiClsbSettAmt").text(comma(setNatiClsbSettAmt()));
    
    
    var calcHpoin = 0;
    var hpoinUse = Number($(".hPoinUseKrw").text().replace(/[^0-9]/g,''));
    
    if((hpoinUse - hpoinGeneAmt) > 0){
        calcHpoin = (hpoinUse - hpoinGeneAmt);
    }
    
     
    if(Number($("input[name='cdpstAmt']").val()) > 0) cdpstAmt = Number($("input[name='cdpstAmt']").val());
    if(Number($("input[name='advsAmt']").val()) > 0) advsAmt = Number($("input[name='advsAmt']").val());
    if(Number($("input[name='gfcaCdpstAmt']").val()) > 0)       gfcaCdpstAmt = Number($("input[name='gfcaCdpstAmt']").val());
    
    		$(".hpointRsvgPrrgAmt").text(comma(Math.round((settPrrgAmt + cdpstAmt + advsAmt + gfcaCdpstAmt + calcHpoin) * Number($("input[name='hpoinSavRat']").val()) / 100, 0)));
    	
        
    if (settPrrgAmt == 0) {
        $("input[name='settWayCd']").val("");
        
        
        setTimeout(function() {
            var grpDivHeight = 0;
            $(".settGrpDoma").each(function() {
                if($(this).parent().hasClass("ui-tabs-active")) {
                    var grpId = String($(this).attr("noHref")).replace("#","");
                    var grpIdSplit = grpId.split("_")[0];
                    
                    if(grpIdSplit == "003") {
                    	grpDivHeight = $("div#"+grpId).height() + 88;
                    } else if(grpIdSplit == "004") {
                        grpDivHeight = $("div#"+grpId).height() + 143;                    	
                    } else {
                    	grpDivHeight = $("div#"+grpId).height() + 141;
                    }
                    
                    return false;
                }
            });
            
            
            $(".payment_method_dim").css("height", (grpDivHeight) + "px"); 
            if($("li#settInfoTit").hasClass("open")) {
                $(".flag").hide();
                $(".payment_method_dim").show();
            }
        }, 100);
        
        $(".settGrpDoma").removeClass("card_badge"); 
        $(".befSettWaySaveYn").prop("disabled", true);
    } else {
        
        if(fixSettWayType != "befSett") {
            fixSettWayCd(fixSettWayType);
        }
        
        setTimeout(function() {
        	$(".payment_method_dim").hide();
        }, 100);
        
        
        $(".settGrpDoma").each(function() {
            if($.trim($(this).data("cardbadge")) == "Y") {
                $(this).addClass("card_badge");  
                $(this).find("p").show();    
            }
        });
        
        $(".befSettWaySaveYn").prop("disabled", false);
    }
    
    toggleCashRcpt();
}


 
function toggleCashRcpt() {

	var settWayCd = checkSettGrpDoma()[0];
	 
    if (settWayCd == "108"
            || settWayCd == "103" 
            || Number($("input[name='cdpstAmt']").val()) > 0
            || Number($("input[name='advsAmt']").val()) > 0 
            || Number($("input[name='gfcaCdpstAmt']").val()) > 0) {
        $(".cash_receipts").show();
        $("#tempCashRcptTable").val("Y");
    } else {
        $(".cash_receipts").hide();
        $("#tempCashRcptTable").val("N");
    }
}


function fixSettInfo(fixSettWayType, dispSettWayCd, cardId, fixYn) {
	if(dispSettWayCd == "005") {
		$("a.settGrpDoma").parent().removeClass("ui-tabs-active");
		$(".cont_item").hide();
        
        $("#settGrpDoma_005_1").parent().addClass("ui-tabs-active");
        $("#005_1").css("display","block");
        
        setTimeout(function() {
            getChagDcAmt();
        }, 100);
        return;
    }
	
    
	
    
    if(fixSettWayType == "befSett") {
        if(!existsSettWayCdApplYn(dispSettWayCd, cardId)) {
            return;
        }
    }
    
    $("#settInfoTit").addClass("open");
    $(".payment_method").show();
    
    var settWaySvmtAmt = 0; 
    if(fixSettWayType == "svmt") {
        settWaySvmtAmt = $("input[name='settWaySvmtSeq']:checked").attr("settWaySvmtAmt");
    }
    
    if (isEmpty(dispSettWayCd)) {
    	
        initSettFix();
    } else {
        var chkGrpSettCd = "";
        var chkGrpDispOrdg = "";
        var chkDispSettWayCd = "";
        var chkDtlSettWayCd = "";
        var chkSettCardId = "";
        var chkSettOvseCd = "";

        
                 
        if(cardId != null && $.trim(String(cardId).replace("null", "")) != "") {
            $("div.settSvmt").each(function() {
                var settDispSettWayCd = $.trim($(this).data("dispsettwaycd"));
                var settCardId = $.trim($(this).data("settcardid"));
                if(settDispSettWayCd == dispSettWayCd && settCardId == cardId) {
                    chkGrpSettCd = $(this).data("grpsettcd");
                    chkGrpDispOrdg = $(this).data("grpdispordg");
                    chkDispSettWayCd = $(this).data("dispsettwaycd");
                    chkDtlSettWayCd = $(this).data("settwaycd");
                    chkSettCardId = $(this).data("settcardid");
                    
                    return false;
                }
            });
            
            
            if(chkGrpSettCd == "001") {
                var settMethCd = "";

                if(fixSettWayType == "pmpt") {
                    settMethCd = $("input[type='radio'][name='pmptDcEvt']:checked").data("settmethcd");
                }
                
                
                if(fixSettWayType == "svmt") {
                    if($.trim($("#tempCardPtnrSeq").val()) == "") {
                    	getIstmMonsList(fixSettWayType, chkGrpSettCd, chkGrpDispOrdg, chkDispSettWayCd, chkSettCardId, settMethCd);
                    }                    	
                } else {
                	getIstmMonsList(fixSettWayType, chkGrpSettCd, chkGrpDispOrdg, chkDispSettWayCd, chkSettCardId, settMethCd);
                }
            }
            
            $("div.settSvmt.orderSettCardList_"+chkGrpSettCd+"_"+chkGrpDispOrdg).each(function() {
                $(this).hide();
                if($(this).data("settcardid") == cardId) {
                    if(fixSettWayType == "svmt") {
                        if(settWaySvmtAmt == 0) {
                            $("#dispSettApplMsg").show();
                            $("#dispSettApplAmt").hide();
                        } else {
                            $("#dispSettApplMsg").hide();
                            $("#dispSettApplAmt").show();
                        }                       
                        $("#dispSettSvmtAmt").text(comma(settWaySvmtAmt));
                        $("#dispSettWayNm").text($(this).data("settwaynm"));
                    }
                    
					
                    $("#cartItem").show();
                    $(this).show();
                    
                }else if(isEmpty($(this).data("settcardid"))){
                    $("#defaultItem").hide();
                    $("#cartItem").show();
                }
            });
        } else {
        	
            if(dispSettWayCd == "002") {
            	$("div.settSvmt").each(function() {
                    var settDispSettWayCd = $.trim($(this).data("dispsettwaycd"));
                    var settCardId = $.trim($(this).data("settcardid"));
                    if(settDispSettWayCd == dispSettWayCd && settCardId == cardId) {
                        chkGrpSettCd = $(this).data("grpsettcd");
                        chkGrpDispOrdg = $(this).data("grpdispordg");
                        chkDispSettWayCd = $(this).data("dispsettwaycd");
                        chkSettOvseCd = $(this).data("settovsecd");
                        
                        return false;
                    }
                });
            	
            	$("div.settSvmt.orderSettCardList_"+chkGrpSettCd+"_"+chkGrpDispOrdg).each(function() {
                    $(this).hide();
                    if($(this).data("settovsecd") == chkSettOvseCd) {
                        if(fixSettWayType == "svmt") {
                            if(settWaySvmtAmt == 0) {
                                $("#dispSettApplMsg").show();
                                $("#dispSettApplAmt").hide();
                            } else {
                                $("#dispSettApplMsg").hide();
                                $("#dispSettApplAmt").show();
                            }                       
                            $("#dispSettSvmtAmt").text(comma(settWaySvmtAmt));
                            $("#dispSettWayNm").text($(this).data("settwaynm"));
                        }
                        
    					
                        $("#cartItem").show();
                        $(this).show();
                        
                    }else if(isEmpty($(this).data("settcardid"))){
                        $("#defaultItem").hide();
                        $("#cartItem").show();
                    }
                });
            }
        	
             
            $("a.settSvmt").each(function() {
                var settDispSettWayCd = $.trim($(this).data("dispsettwaycd"));
                
                if(settDispSettWayCd == dispSettWayCd) {
                    chkGrpSettCd = $(this).data("grpsettcd");
                    chkGrpDispOrdg = $(this).data("grpdispordg");
                    chkDispSettWayCd = $(this).data("dispsettwaycd");
                    
                    return false;
                }
            });
            
            
            if(chkGrpSettCd != "") {
            	
                $("a.item.settSvmt.simpSett_"+chkGrpSettCd+"_"+chkGrpDispOrdg).each(function() {
                	
                    if(fixYn) {
                        $(this).find("div").prop("disabled", true); 
                    }
                    $(this).removeClass("active");
                    
                    if($(this).data("dispsettwaycd") == chkDispSettWayCd) {
                        
                        if(fixSettWayType == "svmt") {
                            if(settWaySvmtAmt == 0) {
                                $("#dispSettApplMsg").show();
                                $("#dispSettApplAmt").hide();
                            } else {
                                $("#dispSettApplMsg").hide();
                                $("#dispSettApplAmt").show();       
                            }                               
                            $("#dispSettSvmtAmt").text(comma(settWaySvmtAmt));
                            $("#dispSettWayNm").text($(this).data("settwaynm"));
                        }
                        
                        $(this).addClass("active");
                    }
                });
                
            } else {
                
                                        
                $("input[type='radio'].settSvmt").each(function() {
                    
                    if($(this).data("dispsettwaycd") == dispSettWayCd){
                        chkGrpSettCd = $(this).data("grpsettcd");
                        chkGrpDispOrdg = $(this).data("grpdispordg");
                        
                        if(fixSettWayType == "svmt") {
                            if(settWaySvmtAmt == 0) {
                                $("#dispSettApplMsg").show();
                                $("#dispSettApplAmt").hide();
                            } else {
                                $("#dispSettApplMsg").hide();
                                $("#dispSettApplAmt").show();       
                            }
                            $("#dispSettSvmtAmt").text(comma(settWaySvmtAmt));
                            $("#dispSettWayNm").text($(this).data("dispsettwaynm"));
                        }

                        return false;
                    }
                }); 
                
                
                
                $("input[type='radio'].settSvmt").each(function() {
                    
					
                    
                    if($(this).data("dispsettwaycd") == dispSettWayCd) {
                    	
	                            $(this).prop("disabled", false); 
                        $(this).prop("checked", true);                          
                    }  
                });
            }
        }
        
        
        
        $(".cont_item").hide();
        $("#settGrpDoma_rcnt_0").parent().removeClass("ui-tabs-active"); 
        $(".settGrpDoma").each(function() {
            
        	
	                $(this).prop("disabled", false); 
            $(this).parent().removeClass("ui-tabs-active");
            
            if($(this).prop("id") == "settGrpDoma_"+chkGrpSettCd+"_"+chkGrpDispOrdg) {
                $(this).parent().addClass("ui-tabs-active");
                var activeTab = $(this).attr("noHref");
                
                if(chkGrpSettCd == '004'){
                	if(dispSettWayCd == '103'){
                        $(".otherpayment").find(".card_banktransfer").addClass("checked");
                    	$(".otherpayment").find(".card_mobilepayment").removeClass("checked");
                    }
                }
                $(activeTab).show();
            }
            
            if(fixYn) {
                $(this).prop("disabled", true); 
            }
        });
     }
    
    
    if(fixSettWayType == "befSett") {
    	
        if("" == "103") {
        	$(".settGrpDoma").each(function() {
                if($(this).parent().hasClass("ui-tabs-active")) {
                    var grpId = String($(this).attr("noHref")).replace("#","");
                    if($("select[name='virtAcntBnkCd_"+grpId+"']").find("option[value='']").length > 0) {
                        setTimeout(function() {
                        	$("select[name='virtAcntBnkCd_"+grpId+"']").val("");
                        }, 200);
                        return false;
                    }
                }
            });
        }
    }
    if((dispSettWayCd == "110" || dispSettWayCd == "111") && fixSettWayType == "svmt") {
    	if(settWaySvmtAmt == 0) {
            $("#dispSettApplMsg").show();
            $("#dispSettApplAmt").hide();
        } else {
            $("#dispSettApplMsg").hide();
            $("#dispSettApplAmt").show();
        }                       
        $("#dispSettSvmtAmt").text(comma(settWaySvmtAmt));
        $("#dispSettWayNm").text($(this).data("settwaynm"));
    }
    if(dispSettWayCd == "110") {
        $("a.settGrpDoma").parent().removeClass("ui-tabs-active");
        $(".cont_item").hide();
        
        $("#settGrpDoma_005_1").parent().addClass("ui-tabs-active");
        $("#005_1").css("display","block");
        
        $("#hpay_01").prop("checked", true);
        $(".hpay_box").removeClass("active");
        $(".hpay_box.card").addClass("active");
        
        return;
    }else if(dispSettWayCd == "111") {
        $("a.settGrpDoma").parent().removeClass("ui-tabs-active");
        $(".cont_item").hide();
        
        $("#settGrpDoma_005_1").parent().addClass("ui-tabs-active");
        $("#005_1").css("display","block");
        
        $("#hpay_02").prop("checked", true);
        $(".hpay_box").removeClass("active");
        $(".hpay_box.bankbook").addClass("active");
        return;
    }
}

function fixSettWayCd(fixSettWayType) {
	var ptnrChlOrderYn = false;
    var ptnrDispSettWayCd = ""; 
    var ptnrCardId = ""; 
    if(!isEmpty(ptnrDispSettWayCd)){
        ptnrChlOrderYn = true;
    }
    
    if (!isEmpty(fixSettWayType) || ptnrChlOrderYn) {
        
        var dispSettWayCd = "";
        var cardId = "";
        
        if (fixSettWayType == "svmt") {
            dispSettWayCd = $("input[name='settWaySvmtSeq']:checked").attr("dispSettWayCd");
            cardId = $("input[name='settWaySvmtSeq']:checked").attr("cardId");
        } else if (fixSettWayType == "cup") {
            dispSettWayCd = $("select[name='geneMbshCupSeq']").find("option:selected").attr("dispSettWayCd");
            cardId = $("select[name='geneMbshCupSeq']").find("option:selected").attr("cardId");
            if (isEmpty(dispSettWayCd)) {
                dispSettWayCd = $("select[name='dblMbshCupSeq']").find("option:selected").attr("dispSettWayCd");
                cardId = $("select[name='dblMbshCupSeq']").find("option:selected").attr("cardId");
            }
        }
        
        if(isEmpty(dispSettWayCd) && ptnrChlOrderYn) {
            dispSettWayCd = ptnrDispSettWayCd;
            cardId = ptnrCardId;
        }
        
        
        fixSettInfo(fixSettWayType, dispSettWayCd, cardId, true);
        $("input[name='settWayCd']").val(dispSettWayCd);
    }

}


function setNatiClsbSettAmt() {
    var curRate = Number($("input[name='chkMoney']:checked").val());
    var natiClsbSettAmt = Number($("input[name='settPrrgUsd']").val());
    if (curRate != 1) {
        natiClsbSettAmt = setExchrClsbAmt(natiClsbSettAmt, curRate);
    }

    return natiClsbSettAmt;
}

function setExchrClsbAmt(amt, exchr) {
    return Math.floor(amt * exchr * 100) / 100;
}

function closeIframe(id) {
    var pId = "#" + id;
    $(pId).dialog('close');
    $(pId).find("iframe").attr("src", "https://www.hddfs.com/shop/or/order/dummy.do");
    $(pId).find("iframe").html("");
    $(".pmntLoading").hide();
}

function paramSet(){
        var frm = document.KSMpiAuthForm;

        var r_array;
        r_array = arguments[0].split('|');

        frm.xid.value = r_array[1];
        frm.eci.value = r_array[2];
        frm.cavv.value = r_array[3];
        frm.cardno.value = r_array[4];

        proceed(r_array[0]);
}

    function proceed(arg){
        var frm = document.KSMpiAuthForm;

        if(arg == 'TRUE' || arg == 'true')
        {
        	
            if(isNaN(frm.cardno.value))
            {
                alert("결제 카드 번호 확인 필요"); 
                settProgYn = "N";
                return ;
            }
            

            frm.expdt.value = frm.expyear.value.substring(2) + frm.expmon.value ;
            $("form[name='KSMpiAuthForm']>input[name='amount']").val($("input[name='settPrrgAmt']").val());
            $("form[name='KSMpiAuthForm']>input[name='installment']").val($("#istmMonsCnt").val());

            saveOrder($("form[name='KSMpiAuthForm']").serialize());
        }
    }


    function resizeFrame( gobj )
    {
        var innerBody = gobj.contentWindow.document.body;
        var innerHeight = innerBody.scrollHeight + (innerBody.offsetHeight - innerBody.clientHeight);
        var innerWidth = innerBody.scrollWidth + (innerBody.offsetWidth - innerBody.clientWidth);
        
        gobj.style.height = "540px" ;

        if(document.Visa3d.cardcode.value == "1" || document.Visa3d.cardcode.value == "2" || document.Visa3d.cardcode.value == "6")
            gobj.style.width = "320px";
        else if(document.Visa3d.cardcode.value == "7" || document.Visa3d.cardcode.value == "11")
            gobj.style.width = "320px";
        else if(document.Visa3d.cardcode.value == "9")
            gobj.style.width = "430px";
        else if(document.Visa3d.cardcode.value == "4")
            gobj.style.width = "360px";
        else if(document.Visa3d.cardcode.value == "5")
            gobj.style.width = "370px";

        

        document.getElementById("MPIFRAME").scrolling="YES";
        document.getElementById("MPIFRAME").style.display="";
    }

function saveOrder(data) {
    
    $.ajax({
        url: 'https://www.hddfs.com/shop/or/order/saveOrder.json',
        method: "post",
        data: data,
        async: true,
        dataType : 'json',
        success : function(data, textStatus, jqXHR) {
            if(crew.ajaxValidate(data, false)){
                if(data.resultCode == 1) {
                    
                    console.log('==========주문완료 ==============');
                    orderCplt();        
                    
                } else {

                    console.log('==========주문실패  ==============');
                    
                    var failMessage = "";
                    if($.trim(data.dtlMessage) == "") {
                        failMessage = $.trim(data.message); 
                    } else {
                        failMessage = $.trim(data.dtlMessage); 
                    }
                    orderFail(failMessage);                    
                }
                
            } else {
                alert('처리중 오류가 발생하였습니다.'+'2');
                settProgYn = "N";
                $(".loadProgBar").css("display","none");
            }
        },
        beforeSend: function() {
        	
            $(".loadProgBar").css("display","block"); 
        },
        complete : function (){
        	$(".loadProgBar").css("display","none");
       	},
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
            settProgYn = "N";
            
            $(".loadProgBar").css("display","none");
        }
    });
}

function VP_Ret_Pay(ret) {
   if(ret) {
       saveOrder($("form[name='ispForm']").serialize());
       
    } else {
    	
    }
}


function orderCplt() {
	$.ajax({
        url: 'https://www.hddfs.com/shop/or/order/popOrderCplt.do',
        method: "post",
        async: false,
        dataType : 'html',
        success : function(data, textStatus, jqXHR) {
            
            $('#orcomplete_pop').html(data);                            
            $('#orcomplete_pop').parent().addClass('order_fin');
            $(document).scrollTop(0);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
}


function orderFail(message) {
	$.ajax({
        url: 'https://www.hddfs.com/shop/or/order/popOrderFail.do',
        method: "post",
        async: false,
        data : {failMessage : message},
        dataType : 'html',
        success : function(data, textStatus, jqXHR) {
            
            $('#failed_pop').html(data);
            $('#failed_pop').parent().addClass('order_fin');
            $(document).scrollTop(0);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
}


function callbackIspReturn(resultCode, message, dtlMessage) {
	closeIframe("layer_iframe");
	
	if(resultCode == "1") {
	    $("#orcomplete_pop").load("https://www.hddfs.com/shop/or/order/popOrderCplt.do");
	} else {
	    var failMessage = "";
	    if($.trim(dtlMessage) == "") {
	        failMessage = encodeURI($.trim(message)); 
	    } else {
	        failMessage = encodeURI($.trim(dtlMessage)); 
	    }
	    
	    $("#orcomplete_pop").load("https://www.hddfs.com/shop/or/order/popOrderFail.do?failMessage=" + failMessage);
	}
	
	$("#orcomplete_pop").dialog({
	    dialogClass: "event_type",
	    maxHeight: 720,
	    width: 412,
	    modal: true
	})           
}

function callbackSetHpoinOccpAucaNo(authNo) {
    hpoinUseAucaYn = true;
    $("input[name='hpoinOccpAucaNo']").val(authNo);
}

function call_isp_app( arg )
{
    if( arg=="TRUE" || arg=="true" || arg==true )
    {
        document.location.href = "ispmobile://?TID=" + document.vpForm.TID.value;
    }
    else
    {
        alert('ISP인증실패'+'2');
    }
    
    return false;
}



function showCardInfoLayer() {
    $(".credit_pop").dialog({
        dialogClass: "pop_type1",
        minHeight: 488,
        maxHeight: 600,
        width: 412,
        modal: true
    });
    
    return false;
}


function sspay_I_return(proceed,kvpcardcode,sessionkey,encdata,otc,kbCardCode,kbCardPrefix,installment,interest,usepoint,issuerCode)
{
    closeIframe("layer_iframe");
    var realform = document.KSMpiAuthForm;
    if (proceed == "TRUE"||proceed == "true"||proceed == true)
    {
        if(otc != ""){
            realform.otc.value   = otc ;
            realform.expdt.value = "8911";
        }else{
        	
            realform.KVP_CARDCODE.value   = kvpcardcode ;
            realform.KVP_SESSIONKEY.value = sessionkey;
            realform.KVP_ENCDATA.value    = encdata;
        }
        realform.installment.value = installment;
        realform.interest.value = interest;
        realform.usepoint.value = usepoint;
        realform.certitype.value = "I";
        realform.issuerCode.value = issuerCode;

        $("form[name='KSMpiAuthForm']>input[name='amount']").val($("input[name='settPrrgAmt']").val());
        saveOrder($("form[name='KSMpiAuthForm']").serialize());
    }else{
    	
    }
}

function sspay_M_return(proceed,xid, eci, cavv, cardno,installment,interest,usepoint,issuerCode)
{
    var realform = document.KSMpiAuthForm;

    if (proceed == "TRUE"||proceed == "true"||proceed == true)
    {
        realform.xid.value    = xid   ;
        realform.eci.value    = eci   ;
        realform.cavv.value   = cavv  ;
        realform.cardno.value = cardno;
        
        realform.expdt.value = realform.expyear.value.substring(2) + realform.expmon.value ;
        realform.installment.value = installment;
        realform.interest.value = interest;
        realform.usepoint.value = usepoint;
        realform.certitype.value = "M";
        realform.issuerCode.value= issuerCode;

        $("form[name='KSMpiAuthForm']>input[name='amount']").val($("input[name='settPrrgAmt']").val());
        saveOrder($("form[name='KSMpiAuthForm']").serialize());
    }else{
    	
    }
}

function settDcCheckConfirm(type, settPrrgAmt, obj, amtObjClass, itemAmt) {
    
    var checkAmt = 0;
    if(type == "1") {
             
        checkAmt = obj.val();
    } else if(type == "2") {
                  
        checkAmt = itemAmt;
    } else {
        return false;
    }
    
    var chk = true;
    
    
    var geneMbshCupSeq = $("select[name='geneMbshCupSeq']").data("cupseq");
    var dblMbshCupSeq = $("select[name='dblMbshCupSeq']").data("cupseq");
    var cupSettYn = false;
    
    if($.trim(geneMbshCupSeq) != "") {
        var geneMbshCupSettWayCd = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("dispSettWayCd");
        
        if($.trim(geneMbshCupSettWayCd) != "") {
            cupSettYn = true;
        }
    }
    
    if($.trim(dblMbshCupSeq) != "") {
        var dblMbshCupSettWayCd = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("dispSettWayCd");
        
        if($.trim(dblMbshCupSettWayCd) != "") {
            cupSettYn = true;
        }
    }
    
    
	var pmptDcAmt = $("input[name='pmptDcAmt']").length > 0 ? $("input[name='pmptDcAmt']").val() : 0;
	var settSvmtAmt = $("input[name='settWaySvmtAmt']").length > 0 ? $("input[name='settWaySvmtAmt']").val() : 0;
	if(cupSettYn || pmptDcAmt> 0 || settSvmtAmt > 0) {
		if(settPrrgAmt - Number(checkAmt) < 1000) {
			
	    	var isFirst = true;
	    	var replaceStr = "";
	    	if(cupSettYn) {
	    		replaceStr += "쿠폰";
	    		isFirst = false;			
	    	}
	    	
	    	if(pmptDcAmt > 0) {
	    		if(!isFirst) {
	    			replaceStr += "/";			
	    		}
	    		replaceStr += "즉시할인";
	    		isFirst = false;
	    	}
	    	
	    	if(settSvmtAmt > 0) {
	    		if(!isFirst) {
	    			replaceStr += "/";			
	    		}
	    		replaceStr += "결제플러스적립금";
	    	}
	    	
			if(dcInitConfirm('281', replaceStr)) {
                if(cupSettYn) {
                    choiCartCupInitProc();
                }  else {
                    pmptDcInitProc();
                }
                
                if(type == "1") {
                    
                    if(obj != null) {
                        obj.val("");
                    }
                    
                    if($.trim(amtObjClass) != "") {
                        $("."+amtObjClass).text("0");
                    }
                } else if(type == "2") {
                    
                }
            } else {
                if(type == "1") {
                    
                    if(obj != null) {
                        obj.val("");
                    }
                    
                    if($.trim(amtObjClass) != "") {
                        $("."+amtObjClass).text("0");
                    }
                } else if(type == "2") {
                    
                }
            }
            
            if(type == "1") {
                
                calnSettAmt(); 
            }
            chk = false;
        }
    }
    
    return chk;
}

var hpoinAmtSearchProcess = false;
function getHpoinAmt(plsYn) {
	
    if(hpoinAmtSearchProcess) {
        return false;
    }
    hpoinAmtSearchProcess = true;
	
	
	
	var settAmt = Number($("input[name='totalGoosKrw']").val()); 
	$(".dcInfo.exceptDc").each(function() {
		settAmt -= Number($(this).text().replace(/[^0-9]/g,''));  
	});
	settAmt -= Number($(".dcCupKrw.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".pmptDcAmt.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".ptnrPmptDcAmt.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".pay_data_pmptUseSvmtAmt.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".svmtUseKrw.settWay.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".evntSvmtUseKrw.settWay.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".branSvmtUseKrw.settWay.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".ptnsSvmtUseKrw.settWay.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".settSvmtUseKrw.settWay.dcInfo").text().replace(/[^0-9]/g,'')); 
	settAmt -= Number($(".hPoinUseKrw.settWay.dcInfo").text().replace(/[^0-9]/g,'')); 
	
	if($.trim(settAmt) == "" || settAmt < 0) {
		settAmt = 0;
	}
	
	var plsPoinSrchYn = "N";
	if(plsYn == true) {
		plsPoinSrchYn = "Y";
	}
	
	var pmptUseSvmtAmt = 0;
    if ($("input[name='pmptUseSvmtUseYn']:checked").val() == "Y") {
        pmptUseSvmtAmt = Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,''));
    }
    
    var pmptDcAmt = $.trim($("input[name='pmptDcAmt']").val()) == "" ? 0 : $("input[name='pmptDcAmt']").val(); 
    var ptnrPmptDcAmt = $.trim($("input[name='ptnrPmptDcAmt']").val()) == "" ? 0 : $("input[name='ptnrPmptDcAmt']").val(); 
    var ptnrPmptDcEvtSeq = $.trim($("input[name='ptnrPmptDcEvtSeq']").val()) == "" ? 0 : $("input[name='ptnrPmptDcEvtSeq']").val(); 
    var geneSvmtAmt = $.trim($("input[name='svmtAmt']").val()) == "" ? 0 : Number($("input[name='svmtAmt']").val().replace(/[^0-9]/g,''));
    var evntSvmtAmt = $.trim($("input[name='evntSvmtAmt']").val()) == "" ? 0 : Number($("input[name='evntSvmtAmt']").val().replace(/[^0-9]/g,''));
    var branSvmtAmt = $.trim($("input[name='branSvmtAmt']").val()) == "" ? 0 : Number($("input[name='branSvmtAmt']").val().replace(/[^0-9]/g,''));
    var ptnsSvmtAmt = 0;
    $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
        if($.trim($(this).data("applptnssvmtid")) != "") {
            var applSvmtAmt = $.trim($(this).data("applptnssvmtamt")) == "" ? 0 : Number($(this).data("applptnssvmtamt"));
            ptnsSvmtAmt += applSvmtAmt;
        }
    });
    var settSvmtAmt = $.trim($("input[name='settWaySvmtAmt']").val()) == "" ? 0 : Number($("input[name='settWaySvmtAmt']").val());
    
    var hpoinSettAmt = $.trim($("input[name='hpoinAmt']").val()) == "" ? 0 : Number($("input[name='hpoinAmt']").val().replace(/[^0-9]/g,''));	

	$.ajax({
	    url: 'https://www.hddfs.com/shop/or/order/getHpoinAmt.json',
	    method: "post",
	    timeout : 30000,
	    data: {plsPoinSettAmt : settAmt
    		, plsPoinSrchYn : plsPoinSrchYn
            , pmptDcAmt : pmptDcAmt
            , ptnrPmptDcAmt : ptnrPmptDcAmt
            , ptnrPmptDcEvtSeq : ptnrPmptDcEvtSeq
            , pmptUseSvmtUseYn : $("input[name='pmptUseSvmtUseYn']:checked").val()
            , pmptUseSvmtAmt : pmptUseSvmtAmt
            , svmtUsePsbKrw :  Number($(".svmtUsePsbKrw").text().replace(/[^0-9]/g,''))
            , totalGoosKrw : $("input[name='totalGoosKrw']").val()
            , totalSettKrw : $("input[name='totalSettKrw']").val()
            , svmtUseMaxAmt : $("input[name=svmtUseMaxAmt]").val()
            , geneSvmtAmt : Number(geneSvmtAmt)
            , evntSvmtAmt : Number(evntSvmtAmt)
            , branSvmtAmt : Number(branSvmtAmt)
            , ptnsSvmtAmt : Number(ptnsSvmtAmt)
            , settWaySvmtAmt : Number(settSvmtAmt)
        	, ptnsSvmtSeqList : $(".ptnsSvmtSeqList").val()
        	, settWaySvmtSeq : $("input[type='radio'][name='settWaySvmtSeq']:checked").val()
        	, settWaySvmtAmt : Number(settSvmtAmt)
        	, hpoinAmt : Number(hpoinSettAmt)
        	},
	    async: false,
	    dataType : 'json',
	    success : function(data, textStatus, jqXHR) {
	        if(crew.ajaxValidate(data, false)){
	            if(data.resultCode == 1) {
	            	
	            	if(!plsYn) {
		                hpoinAmt = data.hpoinAmt;
		                $(".hpoinAmt").text(comma(hpoinAmt));
		                hpoinGeneAmt = data.hpoinGeneAmt;
		                hpoinAdvsAmt = data.hpoinAdvsAmt;
		                $("input[name='hpoinPsbAmt']").val(data.hpoinAdvsAmt);
		                var hpointPsbYnKey = Object.keys(data.hpointPsbYn); // 2022.08.23 상품번호별 hpoint 사용여부 뽑아오기 [이호원]
		                
		                for(var i=0; i<hpointPsbYnKey.length; i++) {
		                	$("li[goosCd='"+hpointPsbYnKey[i]+"']").attr("hpoinPsbYn", data.hpointPsbYn[hpointPsbYnKey[i]]);
		                }
	            	}
	                
	                if(plsYn) {
	                	if(data.plsUsePoinAmt > 0) {
		                	$("#dispHpoinPlsAmt1").val(data.plsUsePoinAmt); 
		                	$("#dispHpoinPlsAmt2").text(comma(data.plsUsePoinAmt)); 
							$("#hpoinPlsCupNo").val(data.plsCupNo); 
							
							$("input[type='radio'][name='hpoinPlsUseYn']").prop("disabled", false);
							$("input[type='radio'][name='hpoinPlsUseYn']").filter("[value='Y']").prop("checked", true);
							
							$(".hPoinPlsUseKrw").text(comma(data.plsUsePoinAmt));
							calnSettAmt();
	                	} else {
	                		alert("플러스포인트 사용가능 금액이 없습니다."); 
	                	}
	                }
	            } else {
	                alert(data.message);
	            }
	        } else {
	        	alert("처리중 오류가 발생하였습니다.2"); 
	        }
	    },
	    error : function(jqXHR, textStatus, errorThrown) {
	    	alert("처리중 오류가 발생하였습니다."); 
	    }
	});
	
    setTimeout(function() {
    	hpoinAmtSearchProcess = false;
    }, 500);
	

}


function choiCartCupInitProc() {
    $("select[name='geneMbshCupSeq']").val("");
    $("select[name='dblMbshCupSeq']").val("");
    choiCartCup();
}


function pmptDcInitProc() {
    initSettWay("all");
    calnSettAmt();
    pmptDcAmtInit(true);
    
    getSvmtRsvgAmt(); 
    getOrderSvmtAmt(); 
    getChagDcAmt(); 
}


function dcInitConfirm(messageType, str) {
    var dcInitYn = true;
    
    var confirmMsg = "";
    if(messageType == "106") {
    	confirmMsg = "결제수단별 쿠폰을 이미 사용하고 있습니다.\n결제수단을 변경하시겠습니까?\n변경 시, 할인설정이 모두 초기화됩니다."; 
	} else if(messageType == "107") {
		confirmMsg = "할부 정보 변경시 카드사즉시할인 혜택을 받으실 수 없으며 할인설정이 모두 초기화 됩니다. 변경하시겠습니까?"; 
	} else if(messageType == "281") {
		confirmMsg = "%s 할인이 이미 설정되어 있습니다.\n결제수단을 변경하시겠습니까?\n변경 시, 할인설정이 모두 초기화됩니다.".replace("%s", str); 
	}
    
    if(confirm(confirmMsg)) {
        $(".chk > li").removeClass("checked");
    	$("#pmptDcEvtLi").addClass("checked");
    	dcInitYn = true;
    } else {
        dcInitYn = false;
    }
    
    return dcInitYn;
}



function pmptDcAmtInit(pmptDcEvtInit) {
    
	if(pmptDcEvtInit) {
        $("input[type='radio'][name='pmptDcEvt']").filter("[value='']").prop("checked", true);
        $("#tempCardPtnrSeq").val("");
    }
    $("input[name='pmptDcAmt']").val("0");
    $(".pmptDcAmt").text("0");
    $(".pmptDcAmt").parent().find("ez.card").text("");
    $(".pmptDcAmt").parent().hide();
    
    
    
}


function getPmptDcList(isDF) {
    
	if('N' == 'N' && 'Y' == 'Y') {
        
        var settAmt = Number($("input[name='totalGoosKrw']").val()); 
        $(".dcInfo.exceptDc").each(function() {
            settAmt -= Number($(this).text().replace(/[^0-9]/g,''));
        });
        settAmt -= Number($(".dcCupKrw.dcInfo").text().replace(/[^0-9]/g,''));
        
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/getPmptDcList.do',
            method: "post",
            data: {
                settAmt : settAmt,
            },
            async: false,
            dataType : 'html',
            success : function(data, textStatus, jqXHR) {
            	$("#cardPtnrRsvgDcInfoDoma").html(data);
                
                if($("input[type='radio'][name='pmptDcEvt']").length > 1) {
                    
                	
                    $("#cardInfoTit").addClass("open");
                    $("#cardPtnrRsvgDcInfoDoma").parent().show();
                    pmptDcAmtInit(true); 
                    
                } else {
                    $("#cardPtnrRsvgDcInfoDoma").parent().hide();
                }
                
                
                $("input[type='radio'][name='pmptDcEvt']").off("click").on("click", function(e) {
                	
                    var settPrrgAmt = Number($("input[name='totalGoosKrw']").val()) - getDcAmt('krw');
                    if($(this).val() != "" && settPrrgAmt == 0) {
                        alert("결제 가능한 금액이 없습니다."); 
                        return false;
                    }
                    
                    
                    var pmptDcDispSettWayCd = $(this).data("dispsettwaycd");
                    
                    if(pmptDcDispSettWayCd == "110" || pmptDcDispSettWayCd == "111") {
                    	var umbMbshNo = '0011911632';
                    	if(!isLogin) {
                    		alert("H.Point Pay를 통한 할인은 통합멤버십 회원만 이용이 가능합니다."); 
                    	}
                    	else if(umbMbshNo == "") {
                    		popOpen(ctx_curr + '/mm/myInfo/umbMbshJoinNtcPop.do', 'chgUmbMbshPop', 450, 500);
                    		return false;
                    	}
                    }
                    var pmptDcCardId = $(this).data("cardid");
                    var pmptDcTypeCd = $(this).data("pmptdctypecd"); 
                    var geneMbshCupSeq = $("select[name='geneMbshCupSeq']").data("cupseq");
                    var dblMbshCupSeq = $("select[name='dblMbshCupSeq']").data("cupseq");
                    
                    var geneMbshCupSettWayCd = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("dispSettWayCd");
                    var geneMbshCupSettCardId = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("cardid");
                    
                    var dblMbshCupSettWayCd = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("dispSettWayCd");
                    var dblMbshCupSettCardId = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("cardid");
                    
                    var pmptDcProgYn = true;
                    var cupSettYn = false;
                    
                    if($.trim(geneMbshCupSeq) != "" && $.trim(geneMbshCupSettWayCd) != "") {
                        cupSettYn = true;                       
                        if(pmptDcDispSettWayCd != geneMbshCupSettWayCd) {
                        	
                            pmptDcProgYn = false;
                        } else if(pmptDcCardId != geneMbshCupSettCardId) {
                        	
                            pmptDcProgYn = false;
                        }
                    }
                    
                    if($.trim(dblMbshCupSeq) != "" && $.trim(dblMbshCupSettWayCd) != "") {
                        cupSettYn = true;                       
                        if(pmptDcDispSettWayCd != dblMbshCupSettWayCd) {
                        	
                            pmptDcProgYn = false;
                        } else if(pmptDcCardId != dblMbshCupSettCardId) {
                        	
                            pmptDcProgYn = false;
                        }
                    }
                    
                    if(pmptDcProgYn) {
                    	
                        if($(this).val() == "") {
                            pmptDcAmtInit(false);
                            
                            var grpDomaSelect = ""; 
                            var grpDomaSort = ""; 
                            
                            $(".settGrpDoma").each(function(idx, obj){
                                if($(this).parent().hasClass("ui-tabs-active")) {
                                    grpDomaSelect = $(this).attr("id");
                                    return false;
                                }
                            });
                            
                            if(grpDomaSelect != "") {
                                grpDomaSort = grpDomaSelect.split("_")[2];
                                grpDomaSelect = grpDomaSelect.split("_")[1];
                                
                                if(grpDomaSelect == "001") {
                                    $("select[name='istmMonsCnt_"+grpDomaSelect+"_"+grpDomaSort+"']").val("00");
                                }
                            }
                            
                        	if(!getPmptDcChangeMsg($(this))) {
                        		return false;                   	
                        	}
                        } else {
                        	if(!getPmptDcChangeMsg($(this))) {
                        		return false;                   	
                        	}
                        	
                            fixSettInfo('pmpt', $(this).data("dispsettwaycd"), $(this).data("cardid"), cupSettYn);                      
                            getPmptDcAmt($(this));
                        }
                    } else {
                        if($(this).val() == "") {
                            pmptDcAmtInit(false);
                            
                            var grpDomaSelect = ""; 
                            var grpDomaSort = ""; 
                            
                            $(".settGrpDoma").each(function(idx, obj){
                            	if($(this).parent().hasClass("ui-tabs-active")) {
                                    grpDomaSelect = $(this).attr("id");
                                    return false;
                                }
                            });
                            
                            if(grpDomaSelect != "") {
                                grpDomaSort = grpDomaSelect.split("_")[2];
                                grpDomaSelect = grpDomaSelect.split("_")[1];
                                
                                if(grpDomaSelect == "001") {
                                    $("select[name='istmMonsCnt_"+grpDomaSelect+"_"+grpDomaSort+"']").val("00");
                                }
                            }
                            
                        } else {
                        	
                        	
			        		if(!applSettFixInit()) {
			        			if($.trim($("#tempCardPtnrSeq").val()) != "")	 {
			        				$("input[type='radio'][name='pmptDcEvt']").filter("[value='"+$("#tempCardPtnrSeq").val()+"']").prop("checked", true);
			        			} else {
			        				$("input[type='radio'][name='pmptDcEvt']").filter("[value='']").prop("checked", true);
			        			}			        			
			        		}
			        		
			        		return false;
                        }
                        
                        if(!getPmptDcChangeMsg($(this))) {
                    		return false;                   	
                    	}
                    }
                	
                    initSettWay("pmpt");
                    calnSettAmt();
                    
                    
                    $("input[name='allUseSvmt']").attr("disabled", "disabled");
                    $("input[name='svmtAmt']").attr("disabled", "disabled");
                    $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
                    $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
                    
                    
                    $("input[name='allUseEvntSvmt']").attr("disabled", "disabled");
                    $("input[name='evntSvmtAmt']").attr("disabled", "disabled");
                    
                    $("input[name='allUseBranSvmt']").attr("disabled", "disabled");
                    $("input[name='branSvmtAmt']").attr("disabled", "disabled");
                    
                    getSvmtRsvgAmt(); 
                    getOrderSvmtAmt(); 
                    getChagDcAmt();
                    
                    paymentSettInfo(); 
                    
                    if(pmptDcTypeCd == "01") {
                    	$("#cardPtnrPmptDcTypeText").text("카드사");
                    } else {
                    	$("#cardPtnrPmptDcTypeText").text("제휴사");
                    }
                    $("#tempCardPtnrSeq").val($(this).val()); 
                });
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert("처리중 오류가 발생하였습니다."); 
            }
        });
    }
}

function getPmptDcChangeMsg(obj) {
	if(obj.val() != "" && $("#tempCardPtnrSeq").val() != "") {
                             
        if(obj.val() != $("#tempCardPtnrSeq").val() != "") {
            var tempCardPtnrSeq = $("#tempCardPtnrSeq").val();
            
             
            var pmptDcApplDcText = $("input[type='radio'][name='pmptDcEvt']").filter("[value='"+tempCardPtnrSeq+"']").parent().find('label > strong > ez').text();
            
            
            var pmptDcCheckDcText = obj.parent().find('label > strong > ez').text();
            
            
            var confirmMsg = "%s 즉시할인이 설정되어 있습니다.\n%s로 변경 하시겠습니까?".replace("%s", pmptDcApplDcText).replace("%s", pmptDcCheckDcText);
            
            if(!confirm(confirmMsg)) {
                return false; 
            }
        }
    }
    
	return true;
}

function getPmptDcAmt(obj) {
    console.log('getPmptDcAmt...');
    
    if ('N' == 'N' && 'Y' == 'Y') { 
        var pmptDcEvtSeq = obj.val();
        var dispSettWayCd = obj.data("dispsettwaycd");
        var cardId = obj.data("cardid");
        var rateYn = obj.data("settmethcd") == "02" ? "Y":"N";
        
        
        var settAmt = Number($("input[name='totalGoosKrw']").val()); 
        $(".dcInfo.exceptDc").each(function() {
            settAmt -= Number($(this).text().replace(/[^0-9]/g,''));
        });
        
        settAmt -= Number($(".dcCupKrw.dcInfo").text().replace(/[^0-9]/g,''));
        
        
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/getPmptDcAmt.json',
            method: "post",
            data: {
                pmptDcEvtSeq : pmptDcEvtSeq,
                dispSettWayCd : dispSettWayCd,
                cardId : cardId,
                settAmt : settAmt, 
                rateYn : rateYn
            },
            async: false,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                
                $("input[name='pmptDcAmt']").val(data.pmptDcAmt);
                
                var dispSettNm = data.dispSettNm;
                if(!isEmpty(dispSettNm)){
                    $(".pmptDcAmt").parent().parent().find("ez.card").text(dispSettNm);
                    
                }

                var dcAmt = getDcAmt('krw');
                var dcAmtUsd = getDcAmt('usd');
                var krw = 0;

                $(".dcInfo").each(function() {
                    krw = Number($(this).text().replace(/[^0-9]/g,''));
                    dcAmt += krw;
                    if (!$(this).hasClass("exceptDc")) {
                        dcAmtUsd += krw;
                    }
                });
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.');
            }
        });
    } else {
    }
    
    var pmptDcAmt = Number($("input[name='pmptDcAmt']").val());
    if (pmptDcAmt <= 0) {
        $(".pmptDcAmt").text("0");
        $(".pmptDcAmt").parent().parent().find("span.card").text("");
        $(".pmptDcAmt").parent().hide();
    } else {
        $(".pmptDcAmt").text(comma(pmptDcAmt));
        $(".pmptDcAmt").parent().show();
    }
    
    
    console.log('getPmptDcAmt 즉시할인 -> 청구할인 호출');
    getChagDcAmt();     
}


function getPtnrPmptDcAmt() {
	var ptnrPmptDcCardNum = $("input[name=ptnrPmptDcCardNum]").val();
    var birth = $("input[name=ptnrPmptDcBirth]").val();
    var settAmt = 0;
    
    var pmptUseSvmtAmt = 0;
    if ($("input[name='pmptUseSvmtUseYn']:checked").val() == "Y") {
        pmptUseSvmtAmt = Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,''));
    }
    
    var pmptUseSvmtUseYn = $("input[name='pmptUseSvmtUseYn']:checked").val();
    var pmptUseSvmtAmt = pmptUseSvmtAmt ;
    var svmtUsePsbKrw = Number($(".svmtUsePsbKrw").text().replace(/[^0-9]/g,''));
    var totalSettKrw = $("input[name='totalSettKrw']").val();
    var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
    
    if($('#ptnrPmptDcType').val() == '001') { 
        if(ptnrPmptDcCardNum != "") {
            settAmt = getPtnrPmptDcSettAmt();
            
            $.ajax({
                url: 'https://www.hddfs.com/shop/or/order/ptnrPmptKtMembershipSearchExclBran.json',
                method: "post",
                data: {cardNo : ptnrPmptDcCardNum
                    , birthDate : birth
                    , settAmt : settAmt
                    , pmptUseSvmtUseYn : pmptUseSvmtUseYn
                    , pmptUseSvmtAmt : pmptUseSvmtAmt
                    , svmtUsePsbKrw : svmtUsePsbKrw
                    , totalSettKrw : totalSettKrw
                    , svmtUseMaxAmt : svmtUseMaxAmt
                },
                async: false,
                dataType : 'json',
                success : function(data, textStatus, jqXHR) {
                    if(crew.ajaxValidate(data, false)){

                        if(data.otsdEvntKT.returnCode == 1) {
                            if(data.otsdEvntKT.EtcInfo == 0) {
                                alert("진행중인 행사가 없습니다."); 
                            }
                            
                            if(data.otsdEvntKT.remainPoint >= 1000) {
                                var remainPoint = data.otsdEvntKT.remainPoint;          
                                var mophApplPoin = data.otsdEvntKT.appPoint;                           
                                var ptnrPmptDcAmt = data.otsdEvntKT.ptnrPmptDcAmt;                 
                                $('#mophApplPoinDcAmt').val(data.otsdEvntKT.ptnrPmptDcAmt);        
                                var ptnrPmptDcCompTypeCd = data.otsdEvntKT.compCd;                 
                                var ptnrPmptDcLvlInfoCd = data.otsdEvntKT.mbshLvlId;                                        
                                var ptnrPmptDcEvtSeq = data.otsdEvntKT.ptnrPmptDcEvtSeq;           
                                
                                setPtnrPmptDcAmt(remainPoint, mophApplPoin, ptnrPmptDcAmt, ptnrPmptDcCompTypeCd, ptnrPmptDcLvlInfoCd, ptnrPmptDcCardNum, birth, ptnrPmptDcEvtSeq)
                                
                                
                                initSettWay("pmpt");
                                
                                getSvmtRsvgAmt();
                                
                                getOrderSvmtAmt();
                                
                                getChagDcAmt(); 
                            } else {
                                alert("고객님의 포인트가 부족합니다. (잔액 : " + data.otsdEvntKT.remainPoint +')'); 
                                setPtnrPmptDcAmt(0,0,0,0,0,'','',0);
                                
                                
                                initSettWay("pmpt");
                                
                                getSvmtRsvgAmt();
                                
                                getOrderSvmtAmt();
                                
                                getChagDcAmt(); 
                            }
                        } else {
                            alert(data.otsdEvntKT.errordescription);
                        }
                    } else {
                        alert("처리중 오류가 발생하였습니다.2"); 
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    alert('처리중 오류가 발생하였습니다.');
                }
            });             
        }
    } else if($('#ptnrPmptDcType').val() == '003') { 
        if(ptnrPmptDcCardNum != "") {
            settAmt = getPtnrPmptDcSettAmt();
            
            $.ajax({
                url: 'https://www.hddfs.com/shop/or/order/ptnrPmptLgMembershipSearchExclBran.json',
                method: "post",
                data: {encmbrcardno : ptnrPmptDcCardNum
                    , birthday : birth
                    , settAmt : settAmt
                    , discobjamt : settAmt
                    , pmptUseSvmtUseYn : pmptUseSvmtUseYn
                    , pmptUseSvmtAmt : pmptUseSvmtAmt
                    , totaldiscobjamt : totalSettKrw
                },
                async: false,
                dataType : 'json',
                success : function(data, textStatus, jqXHR) {

                	if(crew.ajaxValidate(data, false)){
                        console.log("succes start 1");
                        if(data.LG_RW0003.r_code == "00") {
                            console.log("succes start 2");
                            if(true) {
                                var ptnrPmptDcAmt = data.LG_RW0003.ptnrPmptDcAmt;                 
                                $('#mophApplPoinDcAmt').val(data.LG_RW0003.ptnrPmptDcAmt);        
                                var ptnrPmptDcCompTypeCd = data.LG_RW0003.compCd;                 
                                var ptnrPmptDcLvlInfoCd = data.LG_RW0003.grade;                                        
                                var ptnrPmptDcEvtSeq = data.LG_RW0003.ptnrPmptDcEvtSeq;        
                                
                                setPtnrPmptDcAmt("", "", ptnrPmptDcAmt, ptnrPmptDcCompTypeCd, ptnrPmptDcLvlInfoCd, ptnrPmptDcCardNum, birth, ptnrPmptDcEvtSeq)
                                
                                
                                initSettWay("pmpt");
                                
                                getSvmtRsvgAmt();
                                
                                getOrderSvmtAmt();
                                 
                                calnSettAmt();
                                getChagDcAmt(); 
                                if($("#ptnrPmptLayerPopup").hasClass("active")) {
                                    $("#ptnrPmptLayerPopup").removeClass("active");
                                }
                            } else {
                                
                            }
                        } else {
                            alert(data.LG_RW0003.r_disp);
                        }   
                    } else {
                        alert("처리중 오류가 발생하였습니다.2"); 
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    alert("처리중 오류가 발생하였습니다."); 
                }
            });
        }
            
    }
    
    
    $("input[type='radio'][name='pmptDcEvt']").filter("[value='']").prop("checked", true);
    
    
    console.log('getPtnrPmptDcAmt 즉시할인 -> 청구할인 호출');
    getChagDcAmt();     
}



function getChagDcAmt(type) {
    var dispSettWayCd = checkSettGrpDoma()[0];  
    if (dispSettWayCd != null && $.trim(dispSettWayCd) != "" && 'Y' == 'Y') { 
    
        var cardId = checkSettGrpDoma()[1];
    
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/getChagDcAmt.json',
            method: "post",
            data: {dispSettWayCd : dispSettWayCd 
                 , cardId : cardId  
                 , settAmt : Number($("input[name='settPrrgAmt']").val())
                 , rateYn : $("input[name='rateYn']").val()},
            async: false,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                var settPrrgAmt = Number($("input[name='settPrrgAmt']").val());
                var chagSettPrrgAmt = settPrrgAmt - data.chagDcAmt;
                
                if(data.chagDcAmt > 0) {
                	$("#chagDcEvtInfoP").text("(" + data.chagDcEvtInfoText + ")"); 
                    $("#chagDcEvtInfoDl em").html(comma(chagSettPrrgAmt) + "원");
                    $("#chagDcEvtInfoDl").show();
                } else {
                    $("#chagDcEvtInfoDl").hide();
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert("처리중 오류가 발생하였습니다."); 
            }
        });
    } else {
        $("#chagDcEvtInfoDl").hide();
    }
    
        
    console.log("getChagDcAmt -> calnSettAmt");
    calnSettAmt(type);    
}


function getIstmMonsList(fixSettWayType, grpSettCd, grpDispOrdg, dispSettWayCd, dtlSettCardId, settMethCd) {
    
    var settWayCd = "";
    var cardId = "";
    
    
     var renewalSettYn = false;
     if($.trim(dispSettWayCd) != "" && $.trim(dtlSettCardId) != "") {
         renewalSettYn = true;
         
         settWayCd = dispSettWayCd;
         cardId = dtlSettCardId;
     } else {
    	 
         settWayCd = checkSettGrpDoma()[0]; 
         cardId = checkSettGrpDoma()[1]; 
     }
    
    if(!isEmpty(fixSettWayType)){
        if (fixSettWayType == "svmt") {
            if(renewalSettYn) {
            	
            } else {
                settWayCd = $("input[name='settWaySvmtSeq']:checked").attr("dispSettWayCd");
                cardId = $("input[name='settWaySvmtSeq']:checked").attr("cardId");
            }
        } else if (fixSettWayType == "cup") {
            
            var isDblCup = (isEmpty($("select[name='geneMbshCupSeq']").find("option:selected").attr("dispSettWayCd")) ? true : false);
            if(isDblCup){
                settWayCd = $("select[name='dblMbshCupSeq']").find("option:selected").attr("dispSettWayCd");
                cardId = $("select[name='dblMbshCupSeq']").find("option:selected").attr("cardId");
            } else {
                settWayCd = $("select[name='geneMbshCupSeq']").find("option:selected").attr("dispSettWayCd");
                cardId = $("select[name='geneMbshCupSeq']").find("option:selected").attr("cardId");
            }
        }
        
        if(isEmpty(settWayCd) && !isEmpty($("input[name=ptnrDispSettWayCd]").val())){
            settWayCd = $("input[name=ptnrDispSettWayCd]").val();
            cardId = $("input[name=ptnrCardId]").val();
        }
    }
    
    
    $("input[name='rateYn']").val('Y');
    
    if (!isEmpty(settWayCd)) {
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/getIstmMonsList.json',
            method: "post",
            data: {"cardId" : cardId},
            async: false,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                
                if(renewalSettYn) {
                    $(".orderSettCardList_"+grpSettCd+"_"+grpDispOrdg).find("select option").remove();
                    
                    var selectText = "selected";
                    
                    if($.trim(settMethCd) == "01") {
                        $(".orderSettCardList_"+grpSettCd+"_"+grpDispOrdg).find("select[name='istmMonsCnt_"+grpSettCd+"_"+grpDispOrdg+"']").append('<option value="00">일시불</option>');
                    } else {
                        $(".orderSettCardList_"+grpSettCd+"_"+grpDispOrdg).find("select[name='istmMonsCnt_"+grpSettCd+"_"+grpDispOrdg+"']").append('<option value="00" '+ selectText+'>일시불</option>');
                        selectText = "";
                    }
                    
                    $.each(data.istmMonsList, function(key, value) {
                        if(value.rateYn == 'Y') {
                            $(".orderSettCardList_"+grpSettCd+"_"+grpDispOrdg).find("select[name='istmMonsCnt_"+grpSettCd+"_"+grpDispOrdg+"']").append('<option value="'+ value.istmMonsVal +'" '+selectText+'>'+ value.istmMonsNm +'개월</option>');
                            selectText = "";
                        } else {
                            $(".orderSettCardList_"+grpSettCd+"_"+grpDispOrdg).find("select[name='istmMonsCnt_"+grpSettCd+"_"+grpDispOrdg+"']").append('<option class="interest-free" value="'+ value.istmMonsVal +'" '+selectText+'>'+ value.istmMonsNm +'개월 (무)</option>');
                            selectText = "";
                        }
                    });
                }
                
                if($.trim(fixSettWayType) != "" && fixSettWayType != "pmpt" && fixSettWayType != "cup" && fixSettWayType != "svmt") {
                    console.log("getIstmMonsList ajax calnSettAmt");                    
                    calnSettAmt(fixSettWayType);
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.');
            }
        });
    } else {
    	if($.trim(fixSettWayType) != "") {
            console.log("getIstmMonsList else calnSettAmt");
            calnSettAmt(fixSettWayType);
        }
    }
}


function setSmsgpayIstmMons() {
	
  if(checkSettGrpDoma()[0] == '105') {   
      if (Number($("input[name='settPrrgAmt']").val()) < 50000) {
          $("form[name='Visa3d']>input[name='sspayInfo']").val('01///A102,02///A102,03///A102,04///A102,05///A102,06///A102,11///A102,12///A102'); 
      } else {
          $("form[name='Visa3d']>input[name='sspayInfo']").val('01/2-6/7-30/A102,02/2-5/6-18/A102,03/2-6/7-18/A102,04/2-5/6-24/A102,05//2-24/A102,06/2-5/6-24/A102,11/2-6/7-24/A102,12//2-24/A102');
      }
  }
}

function fnCheckboxClick(name) {
    $('[name^=' + name + ']').on('click', function () {
        if ($(this).attr('name').indexOf('All') != -1) {
            $('[name=' + name + ']').prop('checked', $(this).is(':checked'));
        } else {
            var vTotalCnt = $('[name=' + name + ']').length;
            var vChkCnt = $('[name=' + name + ']:checked').length;
            if ($(this).is(':checked')) {
                if (vTotalCnt == vChkCnt) {
                    $('[name=' + name + 'All]').prop('checked', $(this).is(':checked'));
                }
            } else {
                if (vTotalCnt != vChkCnt) {
                    $('[name=' + name + 'All]').prop('checked', $(this).is(':checked'));
                }
            }
        }
    });
}


function callbackSetNmbshOrderSmsAuca(obj) {
  $("select[name='telNatiCd']").val(obj['telNatiCd']);

  if (obj['telNatiCd'] == "82") {
      $(".nonKor").hide();
      $(".kor").show();
      
      $("input[name='mophNo1']").val(obj['mophNo1']);
      $("input[name='mophNo2']").val(obj['mophNo2']);
      $("input[name='mophNo3']").val(obj['mophNo3']);
      $("input[name='nmbshSmsconfirmNum']").val(obj['telNatiCd'] + obj['mophNo1'] + obj['mophNo2'] + obj['mophNo3']);
  } else {
      $(".nonKor").show();
      $(".kor").hide();
      
      $("input[name='mophNo']").val(obj['mophNo']);
      $("input[name='nmbshSmsconfirmNum']").val(obj['telNatiCd'] + obj['mophNo']);
  } 
  
  nmbshSmsAucaYn = true;
}

function callbackSetPsptNo(psptNo, psptExpiDt) {
    $("input[name='psptNo']").val(psptNo);
    $("input[name='psptExpiDt']").val(psptExpiDt);
}


function getSvmtRsvgAmt() {
    if(isLogin) {
        var pmptDcAmt = $.trim($("input[name='pmptDcAmt']").val()) == "" ? 0 : $("input[name='pmptDcAmt']").val(); 
        var ptnrPmptDcAmt = $.trim($("input[name='ptnrPmptDcAmt']").val()) == "" ? 0 : $("input[name='ptnrPmptDcAmt']").val(); 
        var ptnrPmptDcEvtSeq = $.trim($("input[name='ptnrPmptDcEvtSeq']").val()) == "" ? 0 : $("input[name='ptnrPmptDcEvtSeq']").val(); 
      
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/getPmptUseSvmtForRsvgAmt.json',
            method: "post",
            data: {
                pmptDcAmt : pmptDcAmt
                , ptnrPmptDcAmt : ptnrPmptDcAmt
                , ptnrPmptDcEvtSeq : ptnrPmptDcEvtSeq
                , totalSettKrw : $("input[name='totalSettKrw']").val()
            },
            async: false,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                
                var svmtRsvgAmt = data.svmtRsvgAmt.svmtRsvgAmt;
                var svmtRsvgAmtUsd = data.svmtRsvgAmt.svmtRsvgAmtUsd.toFixed(2);
                var svmtRsvgAmtCny = data.svmtRsvgAmt.svmtRsvgAmtCny.toFixed(2);
                
                $(".pmptUseSvmtAmt").text(comma(svmtRsvgAmt));
                
                var svmtRsvgDivAmtKey = Object.keys(data.svmtRsvgAmt.svmtRsvgAmtList); // 2022.08.16 상품번호별 적립금 뽑아오기 [이호원]
                
                for(var i=0; i<svmtRsvgDivAmtKey.length; i++) {
                	$("li[goosCd='"+svmtRsvgDivAmtKey[i]+"']").children(".txt.pmptSvmtUseDivAmt").text(data.svmtRsvgAmt.svmtRsvgAmtList[svmtRsvgDivAmtKey[i]]);
                }
                
                if(svmtRsvgAmt == 0) {
                    $("input:radio[name='pmptUseSvmtUseYn']").filter("[value='N']").attr("checked", true);
                    $("input:radio[name='pmptUseSvmtUseYn']").attr("disabled", "disabled");
                } else {
                    $("input:radio[name='pmptUseSvmtUseYn']").attr("disabled", false);
                }
                
                if ($("input:radio[name='pmptUseSvmtUseYn']:checked").val() == "Y") {
                    $("input[name='settPrrgAmtTmp']").val(Number($("input[name='settPrrgAmtTmp']").val()) - Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,'')));
                } else {
                    $("input[name='settPrrgAmtTmp']").val(Number($("input[name='settPrrgAmtTmp']").val()) + Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,'')));
                }
                
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.');
            }
        });      
    }
}

function getOrderSvmtAmt(type) {
    
    if(isLogin) {
        var pmptUseSvmtAmt = 0;
        if ($("input[name='pmptUseSvmtUseYn']:checked").val() == "Y") {
            pmptUseSvmtAmt = Number($(".pmptUseSvmtAmt").text().replace(/[^0-9]/g,''));
            $("input[name='pay_data_pmptUseSvmtAmt']").val(pmptUseSvmtAmt);
            $(".pay_data_pmptUseSvmtAmt").text(comma(pmptUseSvmtAmt)); 
        }
        else{
            $("input[name='pay_data_pmptUseSvmtAmt']").val('0');
            $(".pay_data_pmptUseSvmtAmt").text(comma(pmptUseSvmtAmt));
        }
        
        var pmptDcAmt = $.trim($("input[name='pmptDcAmt']").val()) == "" ? 0 : $("input[name='pmptDcAmt']").val(); 
        var ptnrPmptDcAmt = $.trim($("input[name='ptnrPmptDcAmt']").val()) == "" ? 0 : $("input[name='ptnrPmptDcAmt']").val(); 
        var ptnrPmptDcEvtSeq = $.trim($("input[name='ptnrPmptDcEvtSeq']").val()) == "" ? 0 : $("input[name='ptnrPmptDcEvtSeq']").val(); 
        var geneSvmtAmt = $.trim($("input[name='svmtAmt']").val()) == "" ? 0 : Number($("input[name='svmtAmt']").val().replace(/[^0-9]/g,''));
        var evntSvmtAmt = $.trim($("input[name='evntSvmtAmt']").val()) == "" ? 0 : Number($("input[name='evntSvmtAmt']").val().replace(/[^0-9]/g,''));
        var branSvmtAmt = $.trim($("input[name='branSvmtAmt']").val()) == "" ? 0 : Number($("input[name='branSvmtAmt']").val().replace(/[^0-9]/g,''));
        var ptnsSvmtAmt = 0;
        $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
            if($.trim($(this).data("applptnssvmtid")) != "") {
                var applSvmtAmt = $.trim($(this).data("applptnssvmtamt")) == "" ? 0 : Number($(this).data("applptnssvmtamt"));
                ptnsSvmtAmt += applSvmtAmt;
            }
        });
        
        var settSvmtAmt = $.trim($("input[name='settWaySvmtAmt']").val()) == "" ? 0 : Number($("input[name='settWaySvmtAmt']").val());
        
        
        var dispSvmtTotalAmtUsd = 0;
        if($("input[name='pmptUseSvmtUseYn']:checked").val() == "Y") {
			if(pmptUseSvmtAmt > 0) {
        		dispSvmtTotalAmtUsd += krwToUsd(pmptUseSvmtAmt,exchr);
			}
        }
        
        if(geneSvmtAmt > 0) {
        	dispSvmtTotalAmtUsd += krwToUsd(geneSvmtAmt,exchr);
        }
        
        if(evntSvmtAmt > 0) {
	        dispSvmtTotalAmtUsd += krwToUsd(evntSvmtAmt,exchr);
        }
        
        if(branSvmtAmt > 0) {
        	dispSvmtTotalAmtUsd += krwToUsd(branSvmtAmt,exchr);
        }
        
        if(ptnsSvmtAmt > 0) {
	        dispSvmtTotalAmtUsd += krwToUsd(ptnsSvmtAmt,exchr);
        }
        
        if(settSvmtAmt > 0) {
        	dispSvmtTotalAmtUsd += krwToUsd(settSvmtAmt,exchr);
        }
        
        if(dispSvmtTotalAmtUsd > 0) {
        	dispSvmtTotalAmtUsd = dispSvmtTotalAmtUsd.toFixed(2);
        }
        
        $("#dispSvmtTotalAmt").text('할인 $'+comma(dispSvmtTotalAmtUsd)); 
        
        if(type == "SETTSVMT") { 
            getEzwelAmt(); 
            return;
        }
        $.ajax({
            url: 'https://www.hddfs.com/shop/or/order/getOrderSvmtAmt.json',
            method: "post",
            data: {
            	pmptDcAmt : pmptDcAmt
                , ptnrPmptDcAmt : ptnrPmptDcAmt
                , ptnrPmptDcEvtSeq : ptnrPmptDcEvtSeq
                , pmptUseSvmtUseYn : $("input[name='pmptUseSvmtUseYn']:checked").val()
                , pmptUseSvmtAmt : pmptUseSvmtAmt
                , svmtUsePsbKrw :  Number($(".svmtUsePsbKrw").text().replace(/[^0-9]/g,''))
                , totalGoosKrw : $("input[name='totalGoosKrw']").val()
                , totalSettKrw : $("input[name='totalSettKrw']").val()
                , svmtUseMaxAmt : $("input[name=svmtUseMaxAmt]").val()
                , geneSvmtAmt : Number(geneSvmtAmt)
                , evntSvmtAmt : Number(evntSvmtAmt)
                , branSvmtAmt : Number(branSvmtAmt)
                , ptnsSvmtAmt : Number(ptnsSvmtAmt)
                , settWaySvmtAmt : Number(settSvmtAmt)
            	, ptnsSvmtSeqList : $(".ptnsSvmtSeqList").val()
            	, settWaySvmtSeq : $("input[type='radio'][name='settWaySvmtSeq']:checked").val()                
                , mbshSvmtAmt : $("#mbshSvmtAmt").val()
                , mbshEvntSvmtAmt : $("#mbshEvntSvmtAmt").val()
                , mbshBranSvmtAmt : $("#mbshBranSvmtAmt").val()
                , mbshPtnsSvmtAmt : $("#mbshPtnsSvmtAmt").val()
                , mbshSettSvmtAmt : $("#mbshSettSvmtAmt").val()
            },
            async: false,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                
                basicSvmtRedrew("mbshSvmtList", "gene", "", data.svmtList);
                
                
                basicSvmtRedrew("mbshEvntSvmtList", "evnt", "evnt", data.evntSvmtList);
                
                
                basicSvmtRedrew("mbshBranSvmtList", "bran", "bran", data.branSvmtList);
                
                
                
                var ptnsSvmtListLength = $.trim(data.ptnsSvmtList) == "" ? 0 : data.ptnsSvmtList.length;
                if(type == "SVMT") {
                                      
                    for (var i=0; i<ptnsSvmtListLength; i++) {
                    	
                        $("input[type='checkbox'][name='ptnsSvmtSeq']").filter("[value='"+data.ptnsSvmtList[i].mbshSvmtSeq+"']").data("svmtamt", data.ptnsSvmtList[i].svmtAmt);
                    }
                } else {
                    
                    ptnsPlsSvmtRedrew(data.ptnsSvmtList);
                }

                
                
                var settSvmtListLength = $.trim(data.settSvmtList) == "" ? 0 : data.settSvmtList.length;
                if(type == "SVMT") {
                                      
                    for (var i=0; i<settSvmtListLength; i++) {
                        $("#settUsePsbAmt_"+data.settSvmtList[i].mbshSvmtSeq).text(comma(data.settSvmtList[i].svmtAmt));
                        $("input[type='radio'][name='settWaySvmtSeq']").filter("[value='"+data.settSvmtList[i].mbshSvmtSeq+"']").attr("settWaySvmtAmt", data.settSvmtList[i].svmtAmt);
                    }
                } else {
                    
                    settPlsSvmtRedrew(data.settSvmtList);
                }   
                
                
                
                $("input[name=svmtUseMaxAmt]").val(data.svmtUseMaxAmt);
        
                 
                if($(".svmtUsePsbKrw").length > 0 && Number($(".svmtUsePsbKrw").text().replace(/[^0-9]/g,'')) > 0) {
                    $("input[name='allUseSvmt']").prop("disabled", false);
                    $("input[name='svmtAmt']").prop("disabled", false);
                }
                
                if($(".moSvmtUsePsbKrw").length > 0 && Number($(".moSvmtUsePsbKrw").text().replace(/[^0-9]/g,'')) > 0) {
                    $("input[name='allUseMoblSvmt']").prop("disabled", false);
                    $("input[name='moblSvmtAmt']").prop("disabled", false);
                }
                
                if($(".evntSvmtUsePsbKrw").length > 0 && Number($(".evntSvmtUsePsbKrw").text().replace(/[^0-9]/g,'')) > 0) {
                	
                    $("input[name='allUseEvntSvmt']").prop("disabled", false);
                    $("input[name='evntSvmtAmt']").prop("disabled", false);
                }
                
                if($(".branSvmtUsePsbKrw").length > 0 && Number($(".branSvmtUsePsbKrw").text().replace(/[^0-9]/g,'')) > 0) {
                	
                    $("input[name='allUseBranSvmt']").prop("disabled", false);
                    $("input[name='branSvmtAmt']").prop("disabled", false);
                }
                
                var ptnrPmptDataKey = Object.keys(data.ptnrPmptDcDivAmt); // 2022.08.16 상품번호별 쿠폰가 뽑아오기 [이호원]

                for(var i=0; i<ptnrPmptDataKey.length; i++) {
                	$("li[goosCd='"+ptnrPmptDataKey[i]+"']").children(".txt.ptnrPmptDcDivAmt").text(data.ptnrPmptDcDivAmt[ptnrPmptDataKey[i]]);
                }
                
                var svmtAmtDataKey = Object.keys(data.svmtUseDivAmt); // 2022.08.16 상품번호별 쿠폰가 뽑아오기 [이호원]

                for(var i=0; i<svmtAmtDataKey.length; i++) {
                	$("li[goosCd='"+svmtAmtDataKey[i]+"']").children(".txt.svmtUseDivAmt").text(data.svmtUseDivAmt[svmtAmtDataKey[i]]);
                }
                
                for(var i=0; i<svmtAmtDataKey.length; i++) {
                	var finaDivAmt = 0;
                	finaDivAmt += $("li[goosCd='"+svmtAmtDataKey[i]+"']").children(".txt.finaGoosSellPric").text();
                	finaDivAmt -= $("li[goosCd='"+svmtAmtDataKey[i]+"']").children(".txt.cupDcAmtKrw").text();
                	finaDivAmt -= $("li[goosCd='"+svmtAmtDataKey[i]+"']").children(".txt.ptnrPmptDcDivAmt").text();
                	finaDivAmt -= $("li[goosCd='"+svmtAmtDataKey[i]+"']").children(".txt.svmtUseDivAmt").text();
                	finaDivAmt -= $("li[goosCd='"+svmtAmtDataKey[i]+"']").children(".txt.pmptSvmtUseDivAmt").text();
                	
                	$("li[goosCd='"+svmtAmtDataKey[i]+"']").children(".txt.finaDivAmt").text(finaDivAmt);
                }
                
                
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.');
            }
        });      
    }
    
    
    if(type != "cup") {
    	
        console.log("getOrderSvmtAmt calnSettAmt");
        calnSettAmt();
    }
    
    getEzwelAmt(); 
}

function getEzwelAmt() {
	
}


function initMoblSvmtAmt() {
	if(true) {
		return;	
	}
    var useMoblSvmtAmt = $("input[name='moblSvmtAmt']").val();
    if(useMoblSvmtAmt > 0) {
        $("input[name='allUseMoblSvmt']").prop("checked", false);
        $("input[name='moblSvmtAmt']").val("");
        $(".moblSvmtAmt").val("0");
        $("input[name='moblSvmtAmt']").prop("readonly", false);
    }
}


function initEvntSvmtAmt() {
    var useEvntSvmtAmt = $("input[name='evntSvmtAmt']").val();
    if(useEvntSvmtAmt > 0) {
        $("input[name='allUseEvntSvmt']").prop("checked", false);
        $("input[name='evntSvmtAmt']").val("");
        $(".evntSvmtAmt").val("0");
        $(".evntSvmtUseKrw").text("0");
        $("input[name='evntSvmtAmt']").prop("readonly", false);
    }
}


function initBranSvmtAmt() {
    var useBranSvmtAmt = $("input[name='branSvmtAmt']").val();
    if(useBranSvmtAmt > 0) {
        $("input[name='allUseBranSvmt']").prop("checked", false);
        $("input[name='branSvmtAmt']").val("");
        $(".branSvmtAmt").val("0");
        $(".branSvmtUseKrw").text("0");
        $("input[name='branSvmtAmt']").prop("readonly", false);
    }
}


function initPtnsSvmtAmt() {
    $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
        $(this).prop("checked", false);
        $(this).prop("disabled", false);
        
        $(this).data("applptnssvmtid", "");
        $(this).data("applptnssvmtamt", "0");
    });
    
    $("#dispPtnsApplMsg").show();
    $("#dispPtnsApplAmt").hide();
    $("#dispPtnsSvmtAmt").text("0"); 
    $("#ptnsSvmtCalcAmt").text("0");
    $("#ptnsSvmtCalcCheck").val("N");
    $(".ptnsSvmtAmt").val("0");
    $(".ptnsSvmtUseKrw").text("0");
    
    
}


function initSettSvmtAmt() {
    $("input[type='radio'][name='settWaySvmtSeq']").filter("[value='']").prop("checked",true); 
    $("input[name='settWaySvmtAmt']").val("0");
    $("#settWaySvmtSeqApplTmp").val("");
    $(".settSvmtAmt").val("0");
    $(".settSvmtUseKrw").text("0");

    initSettFix();

    
    if($("input[type='radio'][name='settWaySvmtSeq']").length > 1) {
        
        
        $("#dispSettApplMsg").show();
        $("#dispSettApplAmt").hide();
        $("#dispSettSvmtAmt").text("0");
        $("#dispSettWayNm").text("");
    } else {
        
    }
}


function initEtcAmt() {
	
	$("input[name='hpoinAmt']").val("");
	$(".hPoinUseKrw").text("0");
	
	
	initHPoinPlsAmt();
	
	
	initEtcEzwelSettAmt(); 
	initEtcPaySettAmt(); 
}


function initEtcEzwelSettAmt() {
	
}


function initEtcPaySettAmt() {
	   
    $("input[name='cdpstAmt']").val("");    
    $(".cdpstUseKrw").text("0");
    
    
    $("input[name='advsAmt']").val("");
    $(".advsUseKrw").text("0");
    
    
    $("input[name='gfcaCdpstAmt']").val("");
    $(".gfCaCdpstUseKrw").text("0");	
}


function initHPoinPlsAmt() {

	$("#dispHpoinPlsAmt1").val(""); 
	$("#dispHpoinPlsAmt2").text("0"); 	
	$(".hPoinPlsUseKrw").text("0");
	
	$("#hpoinPlsAmt").val(""); 
	$("#hpoinPlsCupNo").val(""); 
	
	$("input[type='radio'][name='hpoinPlsUseYn']").prop("disabled", "disabled");
	$("input[type='radio'][name='hpoinPlsUseYn']").filter("[value='N']").prop("checked", true);

}

function initSettFix() {
    var geneMbshCupSeq = $("select[name='geneMbshCupSeq']").data("cupseq");
    var dblMbshCupSeq = $("select[name='dblMbshCupSeq']").data("cupseq");
    
    var geneMbshCupSettWayCd = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("dispSettWayCd");
    var geneMbshCupSettCardId = $("select[name='geneMbshCupSeq']").find("[value='"+geneMbshCupSeq+"']").attr("cardid");
    
    var dblMbshCupSettWayCd = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("dispSettWayCd");
    var dblMbshCupSettCardId = $("select[name='dblMbshCupSeq']").find("[value='"+dblMbshCupSeq+"']").attr("cardid");
    
    var cupSettYn = false;
    
    if($.trim(geneMbshCupSeq) != "" && $.trim(geneMbshCupSettWayCd) != "") {
        cupSettYn = true;
    }
    
    if($.trim(dblMbshCupSeq) != "" && $.trim(dblMbshCupSettWayCd) != "") {
        cupSettYn = true;
    }
    
    if(!cupSettYn) {
        settFixDisabledOff(); 
    }

}


function settFixDisabledOff() {
    
    
	        $(".settGrpDoma").each(function() {
	        	$(this).prop("disabled", false);
	        });
	        
	        
	        $("input[type='radio'].settSvmt").each(function() {
	        	$(this).prop("disabled", false);
	        });
	        
	        
	        $("div.settSvmt").each(function() {
	        	$(this).find("div").find("dd").css({pointerEvents : "auto"});  
	        });
	        
	        
	        $("a.settSvmt").each(function() {
	            $(this).find("div").prop("disabled", false); 
	        });
	     

}



function setHdCardMPoint() {
    var mbshNo = '2208990015585';
    if($("input[name='settWayCd']").val() == '001' && $("select[name='cardCd']").val() == '4') {    
        $("#hdCardMPointDiv").show();
    } else {
        $("#hdCardMPointDiv").hide();
    }
}




function kakaoPayment() {
    $.ajax({
        url: 'https://www.hddfs.com/shop/or/order/kakaoPayReady.json',
        method: "post",
        async: false,
        dataType : 'json',
        data : {totalSettKrw : $("input[name='totalAmount']").val()},
        success : function(data, textStatus, jqXHR) {
            if(data.resultCode == 1) {
                kakaoPayform.tid.value = data.redirect.body.tid;
                popOpen(data.message, 'popKakaopay', 540, 500);
            } else {
                alert(data.message);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
}

function kakaoPayApproval(pg_token,orderId,mbshId){
    
    kakaoPayform.pgToken.value = pg_token;
    kakaoPayform.partnerOrderId.value = orderId;
    kakaoPayform.partnerUserId.value = mbshId;
    
    saveOrder($("form[name='kakaoPayform']").serialize()); 
}

function setPtnrPmptDcAmt(mophRemainPoin, mophApplPoin, ptnrPmptDcAmt, ptnrPmptDcCompTypeCd, ptnrPmptDcLvlInfoCd, ptnrPmptDcCardNum, ptnrPmptDcBirth, ptnrPmptDcEvtSeq){
    $('#mophRemainPoin').text(comma(mophRemainPoin));                   
    $("#mophApplPoin").text(comma(mophApplPoin));                           
    $('#mophApplPoinDcAmt').text(comma(ptnrPmptDcAmt));                
    $("input[name=ptnrPmptDcAmt]").val(ptnrPmptDcAmt);              
    $("input[name=ptnrPmptDcCompTypeCd]").val(ptnrPmptDcCompTypeCd); 
    $("input[name=ptnrPmptDcLvlInfoCd]").val(ptnrPmptDcLvlInfoCd);  
    $("input[name=ptnrPmptDcCardNum]").val(ptnrPmptDcCardNum);      
    $("input[name=ptnrPmptDcBirth]").val(ptnrPmptDcBirth);          
    $("input[name=ptnrPmptDcEvtSeq]").val(ptnrPmptDcEvtSeq);          
    
    if(mophApplPoin > 0 && ptnrPmptDcAmt == 0) {
        $("#mophApplPoin").text("0");
        
    } 
      
    if(ptnrPmptDcAmt <= 0) {
        $(".ptnrPmptDcAmt").text("0");
        $(".ptnrPmptDcAmt").parent().find("ez.card").text("");
        
        
    }else {
        
    	var ptnrPmptDcCompTypeNm = "";
        if(ptnrPmptDcCompTypeCd == "001") {
            ptnrPmptDcCompTypeNm = "KT";
        } else if(ptnrPmptDcCompTypeCd == "003") {
            ptnrPmptDcCompTypeNm = "";
        } else if(ptnrPmptDcCompTypeCd == "004") {
            ptnrPmptDcCompTypeNm = "";
        }
    	
    	$(".ptnrPmptDcAmt").text(comma(ptnrPmptDcAmt));
    	$(".ptnrPmptDcAmt").parent().find("ez.type").text(ptnrPmptDcCompTypeNm);
    	
    }
    
    
    if(ptnrPmptDcCompTypeCd == "003") {
        $("#mophApplPoin").parent().hide(); 
        $(".lguGuide").show();
    } else {
        $("#mophApplPoin").parent().show(); 
        $("#ptnrPmptPossPoinDoma").show(); 
        $(".ktGuide").show();
    }
    
    
    $("#ptnrPmptDcPoinAmtDoma").show();
    
    
    console.log("setPtnrPmptDcAmt calnSettAmt");
    calnSettAmt(); 
    
}

function naverPayment3(){
    
	
    
    var productItemsLength = "1";

    
    var totalCount = parseInt(0);
    var result = new Array();

    
       var json = new Object();
       json.goosQty="1";
       result.push(json);
    

    for(i=0; i<productItemsLength; i++){
        totalCount += parseInt(result[i].goosQty);
    }    

    var settWon = $("input[name='settPrrgAmt']").val();
    var queryString = '?count='+ totalCount + '&settWon=' + settWon;

    popOpen('https://www.hddfs.com/shop/or/order/naverPayReady.do' + queryString , 'naverPayReady', 750, 800);
}

function naverPayApproval(paymentId){
    
	
    naverPayForm.detail.value = "아아";
    naverPayForm.paymentId.value = paymentId;
        
    saveOrder($("form[name='naverPayForm']").serialize()); 

}

function paycoPayment(){
   // alert('저는 페이코 입니다');
    //alert(Advanced Night Repair 어드밴스드 나이트 리페어 싱크로나이즈드 멀티-리커버리 콤플렉스);
    var a = 0;
     
        //alert(1);
        a = a + 1;
    
    //alert(a);
    
    $.ajax({
        url: 'https://www.hddfs.com/shop/or/order/paycoReady.json',
        method: "post",
        async: false,
        dataType : 'json',
        data : {totalSettKrw : $("input[name='totalAmount']").val(), goosQty : a , onlnGoosCd : 182.5},
        success : function(data, textStatus, jqXHR) {
            if(data.resultCode == 1) {
                //
                //popOpen(data.message, 'popPayco', 750, 800);
                var s = data.message;                
                popOpen('https://www.hddfs.com/shop/or/order/paycoOpen.do' +"?returnUrl="+ s , 'paycoReady', 750, 800);
            } else {
                alert(data.message);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
}

function paycoApproval(paymentCertifyToken,reserveOrderNo,totalPaymentAmt,sellerOrderReferenceKey){
    
    
    paycoForm.paymentCertifyToken.value = paymentCertifyToken;
    paycoForm.reserveOrderNo.value = reserveOrderNo;
    paycoForm.totalPaymentAmt.value = totalPaymentAmt;
    paycoForm.sellerOrderReferenceKey.value = sellerOrderReferenceKey;
        
    saveOrder($("form[name='paycoForm']").serialize()); 

}


function allUseSvmtClick(){
	
    if($("input[name='svmtAmt']").prop("disabled") == true) {
        return false;
    }
    
    initMoblSvmtAmt();
    initEvntSvmtAmt();
    initBranSvmtAmt();
    initPtnsSvmtAmt(); 
    initSettSvmtAmt(); 
    initEtcAmt(); 
    calnSettAmt(); 
    
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".svmtAmt").val().replace(/[^0-9]/g,''));
    var svmtAmt = 0;
    
    var svmtUseLmtAmt = getSvmtUseLmtAmt('SVMT');
    var svmtUsePsbAmt = Number($(".svmtUsePsbKrw").text().replace(/[^0-9]/g,''));
    
    if (settPrrgAmt <= 0) {
        alert('결제 가능한 금액이 없습니다.');
        $(this).prop("checked", false);
        return;
    }
    
    if (svmtUseLmtAmt <= 0) {
        
        var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
        var svmtNotUseGoosArr = new Array();
        $("ul.goosUl > li").each(function(idx, obj){
            if($(obj).attr("svmtUsePsbYn") == "N"){
                svmtNotUseGoosArr.push($(obj).find(".goosNmTxt").text());
            }
        });
        
        alert("본 주문에서 사용가능한 적립금은 최대 %s 원이며 아래 상품은 적립금 사용이 불가합니다.".replace("%s", comma(svmtUseMaxAmt)) + svmtNotUseGoosArr.join("\r\n"));  
        
        $(this).prop("checked", false);
        return;
    }
    
    if (svmtUseLmtAmt > svmtUsePsbAmt) {
        svmtAmt = svmtUsePsbAmt;
    } else {
        svmtAmt = svmtUseLmtAmt;
    }

    $(".svmtAmt").val(svmtAmt);
    $("input[name='svmtAmt']").val(svmtAmt);

    svmtAmt += Number($("input[name='settWaySvmtAmt']").val());
    if (!isEmpty($("input[name='moblSvmtAmt']").val())) {
        svmtAmt += Number($("input[name='moblSvmtAmt']").val());
    }
    
    
    $(".svmtUseKrw").text(comma(svmtAmt));
    
    
    $("input[name='allUseMoblSvmt']").prop("disabled", true);
    $("input[name='moblSvmtAmt']").prop("disabled", true);  
    
    getOrderSvmtAmt("SVMT");
    
    
    if($("#chagDcEvtInfoDl").is(":visible")) {
    	getChagDcAmt(); 
    }
    return;
}


function allUseMoblSvmtClick(){
    
    if($("input[name='moblSvmtAmt']").prop("disabled") == true) {
        return false;
    }
    
    
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".moblSvmtAmt").val().replace(/[^0-9]/g,''));
    var useMoblSvmtAmt = 0;
    
        
    var svmtUseLmtAmt = getSvmtUseLmtAmt('MOBL');
    var moblSvmtUsePsbAmt = Number($(".moSvmtUsePsbKrw").text().replace(/[^0-9]/g,''));
    
    if(settPrrgAmt <= 0) {
        alert('결제 가능한 금액이 없습니다.');
        $(this).prop("checked", false);
        return;
    }
    
    if(svmtUseLmtAmt <= 0){
        var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
        var svmtNotUseGoosArr = new Array();
        $("ul.goosUl > li").each(function(idx, obj){
            if($(obj).attr("svmtUsePsbYn") == "N"){
                svmtNotUseGoosArr.push($(obj).find(".goosNmTxt").text());
            }
        });
        
        alert("본 주문에서 사용가능한 적립금은 최대 " + comma(svmtUseMaxAmt) + "원이며 아래 상품은 적립금 사용이 불가합니다. \r\n" + svmtNotUseGoosArr.join("\r\n"));
        $(this).prop("checked", false);
        return;
    }
    
    if (svmtUseLmtAmt > moblSvmtUsePsbAmt) {
        useMoblSvmtAmt = moblSvmtUsePsbAmt;
    } else {
        useMoblSvmtAmt = svmtUseLmtAmt;
    }
    
    
    var gfcaCdpstAmt = isEmpty($("input[name='gfcaCdpstAmt']").val()) ? 0 : Number($("input[name='gfcaCdpstAmt']").val());
    var cdpstAmt = isEmpty($("input[name='cdpstAmt']").val()) ? 0 : Number($("input[name='cdpstAmt']").val());
    var advsAmt = isEmpty($("input[name='advsAmt']").val()) ? 0 : Number($("input[name='advsAmt']").val());
    var hpoinAmt = isEmpty($("input[name='hpoinAmt']").val()) ? 0 : Number($("input[name='hpoinAmt']").val());
    var lgcpBuyMbshGrpCd = "001";
    
    if(lgcpBuyMbshGrpCd != 'MG' && (gfcaCdpstAmt + cdpstAmt + advsAmt + hpoinAmt) < 1000 && (settPrrgAmt - useMoblSvmtAmt < 1000)) {
        alert("결제금액은 최소 1,000원 이상입니다."); 
        useMoblSvmtAmt -= 1000;
    }
    
    if(useMoblSvmtAmt < 0) {
        useMoblSvmtAmt = 0;
        $(this).prop("checked", false);
    }
    $("input[name='moblSvmtAmt']").val(useMoblSvmtAmt);
        
    $(".moblSvmtAmt").val($("input[name='moblSvmtAmt']").val());

    useMoblSvmtAmt += Number($("input[name='settWaySvmtAmt']").val()) + Number($("input[name='svmtAmt']").val());

    $(".svmtUseKrw").text(comma(useMoblSvmtAmt));

    
    getOrderSvmtAmt("SVMT"); 
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    return;

}


function allUseEvntSvmtClick(){
    
	if($("input[name='evntSvmtAmt']").prop("disabled") == true) {
        return false;
    }
    
    initMoblSvmtAmt();
    initBranSvmtAmt();
    initPtnsSvmtAmt(); 
    initSettSvmtAmt(); 
    initEtcAmt(); 
    
    calnSettAmt(); 
    
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".evntSvmtAmt").val().replace(/[^0-9]/g,''));
    var evntSvmtAmt = 0;
    var svmtUseLmtAmt = getSvmtUseLmtAmt('EVNT');
    var evntSvmtUsePsbAmt = Number($(".evntSvmtUsePsbKrw").text().replace(/[^0-9]/g,''));
        
    if (settPrrgAmt <= 0) {
        alert("결제 가능한 금액이 없습니다."); 
        return;
    }
        
    if (svmtUseLmtAmt <= 0) {
           
        var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
        var svmtNotUseGoosArr = new Array();
        $("ul.goosUl > li").each(function(idx, obj){
            if($(obj).attr("svmtUsePsbYn") == "N"){
                svmtNotUseGoosArr.push($(obj).find(".goosNmTxt").text());
               }
            });
           
            alert("본 주문에서 사용가능한 적립금은 최대 " + comma(svmtUseMaxAmt) + "원이며 아래 상품은 적립금 사용이 불가합니다. \r\n" + svmtNotUseGoosArr.join("\r\n"));
            $(this).prop("checked", false);
            return;
    }
    
    if (svmtUseLmtAmt > evntSvmtUsePsbAmt) {
        evntSvmtAmt = evntSvmtUsePsbAmt;
    } else {
        evntSvmtAmt = svmtUseLmtAmt;
    }
    
    $(".evntSvmtAmt").val(evntSvmtAmt);
    $("input[name='evntSvmtAmt']").val(evntSvmtAmt);
    
    

    $(".evntSvmtUseKrw").text(comma(evntSvmtAmt)); 
    $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
    $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
    
    
    $("input[name='allUseBranSvmt']").attr("disabled", "disabled");
    $("input[name='branSvmtAmt']").attr("disabled", "disabled");
    
    getOrderSvmtAmt("SVMT");   
    
    
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    return;
}


function allUseBranSvmtClick(){
    
    if($("input[name='branSvmtAmt']").prop("disabled") == true) {
        return false;
    }
    
    initMoblSvmtAmt();
    initPtnsSvmtAmt(); 
    initSettSvmtAmt(); 
    initEtcAmt(); 
    
    calnSettAmt(); 
    
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".branSvmtAmt").val().replace(/[^0-9]/g,''));
    var branSvmtAmt = 0;
    var svmtUseLmtAmt = getSvmtUseLmtAmt('BRAN');
    var branSvmtUsePsbAmt = Number($(".branSvmtUsePsbKrw").text().replace(/[^0-9]/g,''));
        
    if (settPrrgAmt <= 0) {
        alert('결제 가능한 금액이 없습니다.');
        return;
    }
        
    if (svmtUseLmtAmt <= 0) {
           
        var svmtUseMaxAmt = $("input[name=svmtUseMaxAmt]").val();
        var svmtNotUseGoosArr = new Array();
        $("ul.goosUl > li").each(function(idx, obj){
            if($(obj).attr("svmtUsePsbYn") == "N"){
                svmtNotUseGoosArr.push($(obj).find(".goosNmTxt").text());
               }
            });
           
            alert("본 주문에서 사용가능한 적립금은 최대 " + comma(svmtUseMaxAmt) + "원이며 아래 상품은 적립금 사용이 불가합니다. \r\n" + svmtNotUseGoosArr.join("\r\n"));
            $(this).prop("checked", false);
            return;
    }
    
    if (svmtUseLmtAmt > branSvmtUsePsbAmt) {
        branSvmtAmt = branSvmtUsePsbAmt;
    } else {
        branSvmtAmt = svmtUseLmtAmt;
    }
    
    
    if(settPrrgAmt < branSvmtAmt) {
        branSvmtAmt = settPrrgAmt;
    }
    
    $(".branSvmtAmt").val(branSvmtAmt);
    $("input[name='branSvmtAmt']").val(branSvmtAmt);
    
    

    $(".branSvmtUseKrw").text(comma(branSvmtAmt)); 
    $("input[name='allUseMoblSvmt']").attr("disabled", "disabled");
    $("input[name='moblSvmtAmt']").attr("disabled", "disabled");
    
    
    $("input[name='allUseBranSvmt']").attr("disabled", "disabled");
    $("input[name='branSvmtAmt']").attr("disabled", "disabled");
    
    getOrderSvmtAmt("SVMT");
    
    
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    return;
}


function allUseCdpstClick() {
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".cdpstUseKrw").text().replace(/[^0-9]/g,''));
    var usePsbCdpstAmt = 0;
    var cdpstAmt = 0;
    if (settPrrgAmt <= 0) {
        alert("결제 가능한 금액이 없습니다."); 
        return;
    }

    if (settPrrgAmt > usePsbCdpstAmt) {
        cdpstAmt = usePsbCdpstAmt;
    } else {
        cdpstAmt = settPrrgAmt;
    }
    
    
    if(!settDcCheckConfirm('2', settPrrgAmt, null, '', cdpstAmt)) {
        return false;
    }
    
    $("input[name='cdpstAmt']").val(cdpstAmt);
    $(".cdpstUseKrw").text(comma(cdpstAmt));

    
    
    calnSettAmt(); 
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    return;
}


function allUseAdvsClick(){
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".advsUseKrw").text().replace(/[^0-9]/g,''));
    var usePsbAdvsAmt = 0;
    var advsAmt = 0;
    if (settPrrgAmt <= 0) {
        alert("결제 가능한 금액이 없습니다."); 
        return;
    }

    if (settPrrgAmt > usePsbAdvsAmt) {
        advsAmt = usePsbAdvsAmt;
    } else {
        advsAmt = settPrrgAmt;
    }
    
    
    if(!settDcCheckConfirm('2', settPrrgAmt, null, '', advsAmt)) {
        return false;
    }

    $("input[name='advsAmt']").val(advsAmt);
    $(".advsUseKrw").text(comma(advsAmt));

    
    
    calnSettAmt(); 
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    return;
}


function allUseGfcaCdpstClick(){
    
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".gfCaCdpstUseKrw").text().replace(/[^0-9]/g,''));
    var usePsbGfcaCdpstAmt = 0;
    var gfcaCdpstAmt = 0;

    if (settPrrgAmt <= 0) {
        alert("결제 가능한 금액이 없습니다."); 
        return;
    }

    if (settPrrgAmt > usePsbGfcaCdpstAmt) {
        gfcaCdpstAmt = usePsbGfcaCdpstAmt;
    } else {
        gfcaCdpstAmt = settPrrgAmt;
    }
    
    
    if(!settDcCheckConfirm('2', settPrrgAmt, null, '', gfcaCdpstAmt)) {
        return false;
    }

    $("input[name='gfcaCdpstAmt']").val(gfcaCdpstAmt);
    $(".gfCaCdpstUseKrw").text(comma(gfcaCdpstAmt));

    
    
    calnSettAmt(); 
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    return;
}

function allUseHpoinClick(){
	
	initHPoinPlsAmt(); 
	initEtcEzwelSettAmt(); 
	initEtcPaySettAmt(); 
	calnSettAmt(); 
	
	var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".hPoinUseKrw").text().replace(/[^0-9]/g,'')) + Number($("input[name='pmptDcAmt']").val());
    var useHpoinAmt = 0;
    hPoinPsbAmt = 0; // H.Point 사용가능금액(제외상품,브랜드)
    
    $('p.txt.finaDivAmt').each(function() {
    	if($(this).parent().attr('hpoinpsbyn') == 'Y') {
    		hPoinPsbAmt += Number($(this).text());
    	}
    });
    
    if (hPoinPsbAmt <= 0) {
        alert("결제 가능한 금액이 없습니다."); 
        $(this).prop("checked", false);
        return;
    }

    if (hPoinPsbAmt > hpoinAmt) { //H.point 사용가능 금액 > 보유 H.point
        useHpoinAmt = hpoinAmt; // 사용할 H.point = 보유 H.point
    } else { // H.point 사용가능 금액 <= 보유 H.point
        useHpoinAmt = hPoinPsbAmt; //사용할 H.point = H.point 사용가능 금액
    }
    
    if (Number(useHpoinAmt) < 100) {
        alert("H.Point 최소 결제금액은 100P이며 1P단위로 사용가능합니다."); 
        return;
    }
    
    
    if(!settDcCheckConfirm('2', settPrrgAmt, null, '', useHpoinAmt)) {
        return false;
    }

    $("input[name='hpoinAmt']").val(useHpoinAmt);
    $(".hPoinUseKrw").text(comma(useHpoinAmt));

    if (!hpoinUseAucaYn && Number(useHpoinAmt) >= 100000) {
        setTimeout(function() {
            alert("SMS 인증 후 사용가능합니다."); 
        }, 20);
    }
    
    
    
    calnSettAmt(); 
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    getEzwelAmt(); 
    return;
}


function allUseEzwelWlfrPoinClick() {
	var ezwelWlfrPoinPsbAmt = Number($("#ezwelWlfrPoinPsbAmt").text().replace(/[^0-9]/g,''));
	if(ezwelWlfrPoinPsbAmt <= 0) {
    	return false;
	}
	
	
	initEtcPaySettAmt(); 
	calnSettAmt(); 
	
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".ezwelWlfrPoinUseKrw").text().replace(/[^0-9]/g,''));
    if (settPrrgAmt <= 0) {
        alert("결제 가능한 금액이 없습니다."); 
        return;
    }

    var useEzwelWlfrPoinAmt = 0;
    if (settPrrgAmt > ezwelWlfrPoinPsbAmt) {
        useEzwelWlfrPoinAmt = ezwelWlfrPoinPsbAmt;
    } else {
        useEzwelWlfrPoinAmt = settPrrgAmt;
    }
    
    var minAmt = Number($.trim($("#ezwelWlfrPoinMinPsbAmt").val()));
    if (minAmt > 0 && Number(useEzwelWlfrPoinAmt) < minAmt) {
    	alert("최소 결제금액은 %s원이며, 1원단위로 사용가능합니다.".replace("%s", comma(minAmt))); 
        return;
    }
       
    
    if(!settDcCheckConfirm('2', settPrrgAmt, null, '', useEzwelWlfrPoinAmt)) {
        return false;
    }

    $("input[name='ezwelWlfrPoinAmt']").val(useEzwelWlfrPoinAmt);
    $(".ezwelWlfrPoinUseKrw").text(comma(useEzwelWlfrPoinAmt));
    
    calnSettAmt(); 
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    
    getEzwelAmt(); 
    return;
}


function allUseEzwelSvmtClick() {
	var ezwelSvmtPsbAmt = Number($("#ezwelSvmtPsbAmt").text().replace(/[^0-9]/g,''));
	if(ezwelSvmtPsbAmt <= 0) {
		return false;
	}
	
	
	initEtcPaySettAmt(); 
	calnSettAmt(); 
	
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".ezwelSvmtUseKrw").text().replace(/[^0-9]/g,''));
    if (settPrrgAmt <= 0) {
        alert("결제 가능한 금액이 없습니다."); 
        return;
    }

    var useEzwelSvmtAmt = 0;
    if (settPrrgAmt > ezwelSvmtPsbAmt) {
        useEzwelSvmtAmt = ezwelSvmtPsbAmt;
    } else {
        useEzwelSvmtAmt = settPrrgAmt;
    }
    
    var minAmt = Number($.trim($("#ezwelSvmtMinPsbAmt").val()));
    if (minAmt > 0 && Number(useEzwelSvmtAmt) < minAmt) {
    	alert("최소 결제금액은 %s원이며, 1원단위로 사용가능합니다.".replace("%s", comma(minAmt))); 
        return;
    }
       
    
    if(!settDcCheckConfirm('2', settPrrgAmt, null, '', useEzwelSvmtAmt)) {
        return false;
    }

    $("input[name='ezwelSvmtAmt']").val(useEzwelSvmtAmt);
    $(".ezwelSvmtUseKrw").text(comma(useEzwelSvmtAmt));
    
    calnSettAmt(); 
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    
    getEzwelAmt(); 
    return;
}


function allUseEzwelSpclPoinClick() {
	var ezwelSpclPoinPsbAmt = Number($("#ezwelSpclPoinPsbAmt").text().replace(/[^0-9]/g,''));
	if(ezwelSpclPoinPsbAmt <= 0) {
		return false;
	}
	
	initEtcPaySettAmt(); 
	calnSettAmt(); 
	
    var settPrrgAmt = Number($("input[name='settPrrgAmt']").val()) + Number($(".ezwelSpclPoinUseKrw").text().replace(/[^0-9]/g,''));
    if (settPrrgAmt <= 0) {
        alert("결제 가능한 금액이 없습니다."); 
        return;
    }

    var useEzwelSpclPoinAmt = 0;
    if (settPrrgAmt > ezwelSpclPoinPsbAmt) {
        useEzwelSpclPoinAmt = ezwelSpclPoinPsbAmt;
    } else {
        useEzwelSpclPoinAmt = settPrrgAmt;
    }
    
    var minAmt = Number($.trim($("#ezwelSpclPoinMinPsbAmt").val()));
    if (minAmt > 0 && Number(useEzwelSpclPoinAmt) < minAmt) {
    	alert("최소 결제금액은 %s원이며, 1원단위로 사용가능합니다.".replace("%s", comma(minAmt))); 
        return;
    }
       
    
    if(!settDcCheckConfirm('2', settPrrgAmt, null, '', useEzwelSpclPoinAmt)) {
        return false;
    }

    $("input[name='ezwelSpclPoinAmt']").val(useEzwelSpclPoinAmt);
    $(".ezwelSpclPoinUseKrw").text(comma(useEzwelSpclPoinAmt));
    
    calnSettAmt(); 
    if($("#chagDcEvtInfoDl").is(":visible")) {
        getChagDcAmt(); 
    }
    
    
    return;
}

var layerPopupProcess = false;

function cupLayerPopup(type){
    
	
    if(layerPopupProcess) {
        return false;
    }
    layerPopupProcess = true;
    
    if(type == "goos") {
    	
        $("select[name='choiGoosCup']").each(function(idx, obj){
            $(this).val($.trim($(this).data("cupseq")));
        });
        
        $("select[name='choiGoosDblCup']").each(function(idx, obj){
            $(this).val($.trim($(this).data("cupseq")));
        });
    } else if(type == "cart"){
    	
        $("select[name='geneMbshCupSeq']").each(function(idx, obj){
            $(this).val($.trim($(this).data("cupseq")));
        });
        
        $("select[name='dblMbshCupSeq']").each(function(idx, obj){
            $(this).val($.trim($(this).data("cupseq")));
        });
        
        if($("select[name='geneMbshCupSeq']").val() == "") {
            $("select[name='dblMbshCupSeq']").attr("disabled", "disabled");
        }
    }
    
    $("#"+type+"CupLayerPopup").dialog({
           dialogClass: "pop_type1",
           minHeight: 488,
           maxHeight: 600,
           width: 412,
           modal: true,
           open:function(event, ui) {
               $(".btnde_type1").off("click").on("click", function(){
                    $("#"+type+"CupLayerPopup").dialog("close");
               })
           }
    });
    
    
    setTimeout(function() {
        layerPopupProcess = false;
    }, 500);
}

function plusSvmtLayerPopupOpen(type){
	
    if(layerPopupProcess) {
        return false;
    }
    layerPopupProcess = true;

    if(type == "gene") {
        
    } else if(type == "evnt") {
        
        
    } else if(type == "bran") {
        
    }
    
    if(type == "ptns") {
        
    	$("#ptnsSvmtAllCheck").attr("checked", false);
    	
    	       
        $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
            $(this).prop("checked", false);
            $(this).prop("disabled", false);
        });
        
        var applSvmtAmt = 0;
        var isFirst = true;
        $("input[type='checkbox'][name='ptnsSvmtSeq']").each(function(idx, obj){
            
            if($.trim($(this).data("applptnssvmtid")) != "") {
                applSvmtAmt += $(this).data("applptnssvmtamt");
                $("empty.ptnsUsePsbDoma").filter("[data-seq='"+$(this).data("applptnssvmtid")+"']").find("strong").text(comma($(this).data("applptnssvmtamt")));
                if(isFirst) {
                                        
                    $(this).click();
                    isFirst = false;
                } else {
                    $(this).prop("checked", true);
                }
            } else {
                
            }
        });
        
        $("empty.ptnsUsePsbDoma").each(function(idx, obj){
            var ptnsChecked = $(this).parent().parent().parent().parent().find("input:first").is(":checked");
            if(ptnsChecked) {
                $(this).show();                     
            } else {
                $(this).hide();
            }
        });
        
        $("#ptnsSvmtCalcAmt").val(comma(applSvmtAmt));
    } else if(type == "sett") {
    	
        $("input[name='settWaySvmtSeq']").each(function(idx, obj){
            $(this).prop("checked", false);
            if($("#settWaySvmtSeqApplTmp").val() == $(this).val()) {
                $(this).prop("checked", true);
            }
        });
    }
    
    
    
    plusSvmtLayerPopOpen(type);
    
    
    
    setTimeout(function() {
        layerPopupProcess = false;
    }, 500);
    
}

function plusSvmtLayerPopOpen(type) {
    
    $("#"+type+"SvmtLayerPopup").show();
    $("#"+type+"SvmtLayerPopup").dialog({
         dialogClass: "pop_type1",
         minHeight: 488,
         maxHeight: 600,
         width: 412,
         modal: true

     });
}


function plusSvmtLayerPopupClose(type) {
    $("#"+type+"SvmtLayerPopup").dialog("close");
}

var aucaYn = "N";
function koreanAirSkyPass() {
	if(aucaYn == "Y") {
		return false;
	}
	
	
	if(currMbshLgcpBuyMbshGrpCd != "001" || currMbshMbshIosdClsCd == "1")	{
		alert("참여할 수 없는 대상자입니다.");
		return false;
	}

	$("#koreanAirSkyPassLayerPopup").show();
    $("#koreanAirSkyPassLayerPopup").dialog({
         dialogClass: "pop_type1",
         minHeight: 488,
         maxHeight: 600,
         width: 412,
         modal: true
     });
    
	
	return true;
}


function setKoreanAirSkyPassMemberNum(memberNum) {
	aucaYn = 'Y';
	$("input[name=memberNum]").val(memberNum);
	$('.aff_air_info').find("input:first").val("V 인증완료 [ SKYPASS " + memberNum + " ]"); 
	$('#koreanAir').hide();
	$(".aff_air_info").show();

	return;
}

function koreanAirSkyPassValidate() {
	if($('#skyPassMemberNum').val() == "" || $('#skyPassMemberNum').val().length < 12 || !fnIsNumber($('#skyPassMemberNum').val())){
        alert("입력하신 회원번호는 유효하지 않습니다.확인 후 다시 입력 해 주세요.");
        $('#skyPassMemberNum').focus();
        return false;
    }
    
    if($('#skyPassMemberNum').val() == "" || $('#skyPassMemberEngLstNm').val() == "" || $('#skyPassMemberEngFstNm').val() == ""){
        alert("필수정보를 입력해주세요.");
        if($('#skyPassMemberNum').val() == "") {
        	$('#skyPassMemberNum').focus();
        } else if($('#skyPassMemberEngLstNm').val() == "") {
        	$('#skyPassMemberEngLstNm').focus();
        } else if($('#skyPassMemberEngFstNm').val() == "") {
        	$('#skyPassMemberEngFstNm').focus();
        }
        return false;
    }   
	
    if(!$("#air01").is(":checked")) {
        alert("개인정보 수집/제공 동의 여부를 확인해주세요.");
        $('#air01').focus();
        return false;
    }
    
    if(!$("#air02").is(":checked")) {
        alert("개인정보 제 3자 제공 동의 여부를 확인해주세요.");
        $('#air02').focus();
        return false;
    }        
      
    
       
    
    return true;
}

function krwToUsd(krwAmt, exchr) {
    return Math.floor(Math.round(1 / exchr * 10000000000) / 10000000000 * krwAmt * 100) / 100;
}


</script>
			<form method="post" name="orderForm" id="orderForm">

				<ul class="goosUl" style="display: none;">
					<li test="252817" svmtUsePsbYn="Y" goosCd="10229250014901">
						<p class="txt goosNmTxt">Advanced Night Repair 어드밴스드 나이트 리페어
							싱크로나이즈드 멀티-리커버리 콤플렉스</p>
						<p class="txt BranCd">022901</p>
						<p class="txt finaPmptDcCupDcAmt">252817</p>
						<p class="txt finaGoosSellPric">252817</p>
						<p class="txt cupDcAmtKrw"></p>
						<p class="txt ptnrPmptDcDivAmt"></p>
						<p class="txt svmtUseDivAmt"></p>
						<p class="txt pmptSvmtUseDivAmt"></p>
						<p class="txt finaDivAmt"></p>
					</li>
				</ul>


				<article id="content">
					<section class="orderpayment_wrap">
						<ul class="title_tab">
							<li><a
								href="https://www.hddfs.com/shop/or/order/listCart.do">장바구니</a></li>
							<li><strong class="on" id="tabOrder">주문결제</strong></li>
						</ul>
						<div class="payment_board">
							<div class="order_sheet">


								<div id="001_2" class="payway_area_card  cont_item">
									<div class="item" id="defaultItem">
										<div class="default settSvmt orderSettCardList_001_2"
											data-grpsettcd="001" data-grpdispordg="2"
											data-dispsettwaycd="001" data-settwaycd="" data-settwaynm=""
											data-settcardid="" data-settovsecd="">
											<button type="button" class="orderSettCardList"
												data-depth="1">카드선택</button>
										</div>
									</div>
								

								<div id="003_3" class="payway_area_easy  cont_item">
									<div class="chk">
										<input type="checkbox" id="befSettWaySaveYn_003_3"
											class="befSettWaySaveYn"> <label
											for="befSettWaySaveYn_003_3">선택한 결제수단 다음에도 사용</label>
									</div>
								
							
	<div class="payment_sheet scroll-sticky">
		<div class="title">
			<h4>최종결제금액</h4>
			<em>총 1개</em>
		</div>
		<ul class="total_bill">
			<li><strong>총 주문금액합계</strong> <span> <em>$365</em>
					<p>505,634원</p>
			</span></li>
			<li class="discount_list"><strong>
					<button type="button" class="btn">총할인금액</button>
			</strong> <span> <em class="totalDcUsd">$182.5</em>
					<p class="totalDcKrw">252,817원</p>
			</span>
			
			
			
		</ul>
		<div class="total_amount">
			<h5>최종결제금액</h5>
			<div>
				<em class="totalSettUsd">$182.5</em>
				<p class="won totalSettKrw">252,817원</p>
			</div>
		</div>
		<div class="confirm">
			<a href="javascript:void(0);" class="btn" onclick="goSett();">결제하기</a>
			<div class="chk">
				<input type="checkbox" id="chkAgree"> <label for="chkAgree">
					<span>주문내역 확인 동의</span>
					<p>주문할 상품의 정보를 확인하였으며, 해당 주문에 대한 구매에 동의 합니다.</p>
				</label>
			</div>
		</div>
	</div>
	</div>
	</section>
	</article>

	
	</form>


	<iframe id=MPIFRAME name=MPIFRAME style="display: none"></iframe>
	<div style="display: none">
		<form name=Visa3d target="MPIFRAME" method=post>
			<input type="text" name=pan size="19" maxlength="19" value="">
			<input type="text" name=expiry size="6" maxlength="6" value="4912">
			<input type="text" name=purchase_amount size="20" maxlength="20"
				value=""> <input type="text" name=amount size="20"
				maxlength="20" value=""> <input type="text" name=description
				size="80" maxlength="80" value="none"> <input type="text"
				name=currency size="3" maxlength="3" value="410"> <input
				type="text" name=recur_frequency size="4" maxlength="4" value="">
			<input type="text" name=recur_expiry size="8" maxlength="8" value="">
			<input type="text" name=installments size="4" maxlength="4" value="">
			<input type="text" name=device_category size="20" maxlength="20"
				value="0"> <input type="text" name="name" size="20"
				value="%C7%F6%B4%EB%B9%E9%C8%AD%C1%A1%B8%E9%BC%BC%C1%A1"> <input
				type="text" name="url" size="20" value="https://www.hddfs.com/shop">
			<input type="text" name="country" size="20" value="410"> <input
				type="password" name="dummy" value=""> <input type="text"
				name="returnUrl"
				value="https://www.hddfs.com/shop/or/order/mpiReturn.do"> <input
				type="text" name=cardcode value=""> <input type="text"
				name="merInfo" value="DPT0Q21075"> <input type="text"
				name="bizNo" value="8508800325"> <input type="text"
				name="instType" value="1"> <input type="hidden"
				name="sspayInfo" value=""> <input type="hidden"
				name="goodname" value="Advanced Night Repai"> <input
				type="hidden" name="PgId" value="K0036">
		</form>
	</div>

	<div style="display: none">
		<form name=KSMpiAuthForm method=post action="" onSubmit="">
			<input type=hidden name="expdt" value=""> <input type=hidden
				name="idnum" value=""> <input type=hidden name="goodname"
				value="goodName"> <input type=hidden name="amount" value="">
			<input type=hidden name="currencytype" value="410"> <input
				type=hidden name="expyear" value="2049"> <input type=hidden
				name="expmon" value="12"> <input type=hidden name="termID"
				value="DPT0Q21075"> <input type=hidden name="gubun"
				value="1130"> <input type=hidden name="installment">
			<input type=hidden name="rateYn"> <input type=hidden
				name="issuerCode"> <input type="hidden" name="xid" value="">
			<input type="hidden" name="eci" value=""> <input
				type="hidden" name="cavv" value=""> <input type="hidden"
				name="cardno" value=""> <input type="hidden" name="otc"
				value=""> <input type="hidden" name="usepoint" value="">
			<input type="hidden" name="KVP_PGID" value=""> <input
				type="hidden" name="KVP_CARDCODE" value=""> <input
				type="hidden" name="KVP_SESSIONKEY" value=""> <input
				type="hidden" name="KVP_ENCDATA" value=""> <input
				type="hidden" name="certitype" value=""> <input
				type="hidden" name="interest" value="">
		</form>
	</div>
	</div>
	<div style="display: none">
		<form name="ispForm" method=post>
			<input type="text" name="KVP_PGID" value="K0036"> <input
				type="text" name="KVP_GOODNAME" value="Advanced Night Repai" /> <input
				type="text" name="KVP_CARDCOMPANY" value=""> <input
				type="text" name="KVP_PRICE" value=""> <input type="text"
				name="KVP_CURRENCY" value="WON"> <input type="text"
				name=KVP_QUOTA_INF value=""> <input type="text"
				name=KVP_NOINT_INF value=""> <input type="text"
				name="KVP_NOINT" /> <input type="text"
				name="KVP_NOINT_FLAG" /> <input type="text" name="KVP_QUOTA"
				value="" /> <input type="text" name="KVP_OACERT_INF" /> <input
				type="text" name="KVP_BC_OACERT_INF" /> <input type="text"
				name="Kvp_NOINT_FLAG" /> <input type="text"
				name="KVP_CARDCODE" /> <input type="text"
				name="VP_BC_ISSUERCODE" /> <input type="text"
				name="KVP_KB_SAVEPOINTREE" /> <input type="text"
				name="KVP_WR_SAVEPOINT" /> <input type="text"
				name="VP_BC_SAVEPOINT" /> <input type="text"
				name="VP_RET_SAVEPOINT" /> <input type="text"
				name="KVP_FIXPAYFLAG" /> <input type="text"
				name="KVP_MERCHANT_KB" /> <input type="text"
				name="VP_MERCHANT_ID" /> <input type="text" name="VP_REQ_AUTH"
				value="FALSE" /> <input type="text" name="KVP_CARD_PREFIX" />
			<input type="text" name="KVP_IMGURL" /> <input type="text"
				name="KVP_CONAME" /> <input type="text"
				name="KVP_SESSIONKEY" /> <input type="text" name="KVP_ENCDATA" />
			<input type="text" name="KVP_RESERVED1" /> <input type="text"
				name="KVP_RESERVED2" /> <input type="text"
				name="KVP_RESERVED3" /> <input type="text"
				name="KVP_PAYSET_FLAG" /> <input type="hidden"
				name="KVP_USING_POINT" />
		</form>
	</div>

	<div style="display: none">
		<form class="form-horizontal" name="ovseForm" method="post"
			action="https://www.hddfs.com/shop/or/order/ovseCreditCardRequest.do">
			<input type="hidden" name="statusurl"
				value="https://www.hddfs.com/shop/or/order/procOvseCreditCardCplt.do" />
			<input type="hidden" name="returnurl"
				value="https://www.hddfs.com/shop/or/order/ovseCreditCardResponse.do" />
			<input type="hidden" name="mid" value="5DBD8A86B4"> <input
				type="hidden" name="ref" value="demo20170418202020"> <input
				type="hidden" name="ostype" value="P"> <input type="hidden"
				name="displaytype" value="P"> <input type="hidden"
				name="cur" value="USD"> <input type="hidden" name="amt"
				value=""> <input type="hidden" name="buyer" value="">
			<input type="hidden" name="email" value=""> <input
				type="hidden" name="tel" value=""> <input type="hidden"
				name="lang" value="KR"> <input type="hidden"
				name="paymethod" value=""> <input type="hidden" name="shop"
				value=""> <input type="hidden" name="item_0_product"
				value="Advanced Night Repai"> <input type="hidden"
				name="item_0_quantity" value="1"> <input type="hidden"
				name="item_0_unitPrice" value="">
		</form>
	</div>

	<div style="display: none">
		<form class="form-horizontal" name="payForm" method="post" action="">
			<input type="text" name="CASH_GB" id="CASH_GB" size="30" value="MC">
			<input type="text" name="Okurl" id="Okurl" size="50"
				value="https://www.hddfs.com/shop/or/order/mobiliansReturn.do?hddfsSession=sPa8fbQhr1vqCtrpxRKyBd5IfyYoCryNV1uLoMNigjVu9xwEbZ348rTap8heYdjr.b25saW5lX2RvbWFpbi9zZXJ2ZXJfZGZwa29fMQ==">
			<input type="text" name="MC_SVCID" id="MC_SVCID" size="30" value="">
			<input type="text" name="Prdtnm" id="Prdtnm" size="30"
				value="Advanced Night Repai"> <input type="text"
				name="Prdtprice" id="Prdtprice" size="30" value=""> <input
				type="text" name="Siteurl" id="Siteurl" size="30"
				value="http://naver.com"> <input type="text" name="PAY_MODE"
				id="PAY_MODE" size="30" value=""> <input type="text"
				name="Tradeid" id="Tradeid" size="50" value=""> <input
				type="text" name="LOGO_YN" id="LOGO_YN" size="30" value="N">
			<input type="text" name="CALL_TYPE" id="CALL_TYPE" size="30"
				value="P"> <input type="text" name="MC_AUTHPAY"
				id="MC_AUTHPAY" size="30" value="Y">
		</form>
	</div>


	<div style="display: none">
		<form name="kakaoPayform" id="kakaoPayform" method="post" action="">
			<input type="hidden" name="cid" value="" /> <input type="hidden"
				name="partnerOrderId" value="" /> <input type="hidden"
				name="partnerUserId" value="" /> <input type="hidden"
				name="itemName" value="Advanced Night Repai" /> <input
				type="hidden" name="quantity" value="1" /> <input type="hidden"
				name="totalAmount" value="252817" /> <input type="hidden"
				name="taxFreeAmount" value="252817" /> <input type="hidden"
				name="approvalUrl"
				value="https://www.hddfs.com/shop/or/order/kakaoPaySuccess.do" /> <input
				type="hidden" name="cancelUrl"
				value="https://www.hddfs.com/shop/or/order/kakaoPayCanCel.do" /> <input
				type="hidden" name="failUrl"
				value="https://www.hddfs.com/shop/or/order/kakaoPayFail.do" /> <input
				type="hidden" name="pgToken" value="" /> <input type="hidden"
				name="tid" value="" />
		</form>
	</div>


	<form name="smilepayForm" id="smilepayForm" action="" method="post"
		accept-charset="">
		<input type="hidden" name="requestUrl"
			value="https://pg.cnspay.co.kr/pay/v2/approve" /> <input
			type="hidden" name="Mid" value="hddfsco00m" /> <input type="hidden"
			name="Moid" id="Moid" value="157056605175569810" /> <input
			type="hidden" name="GoodsNm" value="Advanced Night Repai" /> <input
			type="hidden" name="Amt" value="252817" /> <input type="hidden"
			name="SupplyAmt" value="252817" /> <input type="hidden"
			name="ServiceAmt" value="0" /> <input type="hidden" name="GoodsVat"
			value="0" /> <input type="hidden" name="TaxationAmt" value="0" /> <input
			type="hidden" name="Currency" value="KRW" /> <input type="hidden"
			name="PointUseYn" value="Y" /> <input type="hidden" name="Etc1"
			value="" /> <input type="hidden" name="Etc2" value="" /> <input
			type="hidden" name="Etc3" value="" /> <input type="hidden"
			name="UserKey" value="" maxlength="200" /> <input type="hidden"
			name="SmileCash" value="0" /> <input type="hidden"
			name="IsSmileAppInstalled" id="IsSmileAppInstalled" value="U"
			readonly="readonly" style="background-color: #e2e2e2;" /> <input
			type="hidden" name="CalledFromAppOrElse" value="WEB" /> <input
			type="hidden" name="ShopAppIosScheme" placeholder="IOS APP 사용시 필수" />
		<input type="hidden" name="ReturnUrl2" type="text"
			value="https://www.hddfs.com/shop/or/order/smilepayApproveReturn2.do?hddfsSession=sPa8fbQhr1vqCtrpxRKyBd5IfyYoCryNV1uLoMNigjVu9xwEbZ348rTap8heYdjr.b25saW5lX2RvbWFpbi9zZXJ2ZXJfZGZwa29fMQ==" />
		<input type="hidden" name="possiCard" value="" /> <input type="hidden"
			name="itemType" value="1" /> <input type="hidden" name="PayMethod"
			value="SMILEPAY" /> <input type="hidden" name="GoodsCnt" value="1" />
		<input type="hidden" name="BuyerName" value="김민선" /> <input
			type="hidden" name="LogoURL" type="text"
			value="https://pg.cnspay.co.kr" readonly="readonly"
			style="background-color: #e2e2e2;" /> <input type="hidden"
			name="requestDealApproveUrl" id="requestDealApproveUrl"
			value="https://pg.cnspay.co.kr/smile/v2/createTxnId"
			readonly="readonly" style="background-color: #e2e2e2;" /> <input
			type="hidden" name="EncodeKey"
			value="/MbPBwqUTsnv5DCLikoH8ildWyCZ+uDoCiO+x5fp9abPLngj2hA1ZZShdNDQ/yLpAqpvH2zaqMZ3Ff6TWj9t6A==" />
		<input type="hidden" name="merchantEncKey" value="/MbPBwqUTsnv5DCL"
			style="background-color: #e2e2e2;" /> <input type="hidden"
			name="merchantHashKey" value="AicQKBlKQjOl6kKk"
			style="background-color: #e2e2e2;" /> <input type="hidden"
			name="UsePopup" value="true" />

		<div id="txnContents">
			<input id="ResultCode" name="ResultCode" type="hidden" value="" /> <input
				id="ResultMsg" name="ResultMsg" type="hidden" value="" /> <input
				id="TxnId" name="TxnId" type="hidden" value="" /> <input id="PrDt"
				name="PrDt" type="hidden" value="" /> <input id="TlsVer"
				name="TlsVer" type="hidden" value="" />
		</div>
		<div id="dlpContents">
			<input name="GoodsName" type="hidden" value="" /> <input
				name="SpuSignToken" type="hidden" value="" /> <input
				name="SmileCash" type="hidden" value="" /> <input name="Spu"
				type="hidden" value="" /> <input name="Tid" type="hidden" value="" />
			<input name="AuthToken" type="hidden" value="" />
		</div>

	</form>

	<div class='div_frame' id="smilePay_layer"></div>
	<iframe name="txnIdGetterFrame" id="txnIdGetterFrame" width="0px"
		height="0px"
		style="border-left-width: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px;"></iframe>
	<div style="display: none">
		<form name="naverPayForm" id="naverPayForm" method="post" action="">
			<input type="hidden" name="paymentId" value="" /> <input
				type="hidden" name="detail" value="" />
		</form>
	</div>


	<div style="display: none">
		<form name="paycoForm" id="paycoForm" method="post" action="">
			<input type="hidden" name="paymentCertifyToken" value="" /> \ <input
				type="hidden" name="reserveOrderNo" value="" /> \ <input
				type="hidden" name="totalPaymentAmt" value="" /> \ <input
				type="hidden" name="sellerOrderReferenceKey" value="" /> \
		</form>
	</div>
	<div style="display: none">
		<form name="hpayForm" id="hpayForm" method="post" action="">
			<input type="hidden" id="hpayPaymentId" name="hpayPaymentId" value="" />
			<input type="hidden" id="methodId" name="methodId" value="" /> <input
				type="hidden" id="orderNo" name="orderNo" value="" /> <input
				type="hidden" id="paymentKey" name="paymentKey" value="" /> <input
				type="hidden" id="istmMonsCnt" name="istmMonsCnt" value="0" /> <input
				type="hidden" id="orderName" name="orderName"
				value="Advanced Night Repai" /> <input type="hidden"
				id="totalOrderAmt" name="totalOrderAmt" value="252817" /> <input
				type="hidden" id="poinUseYn" name="poinUseYn" value="" />
		</form>
	</div>
	<script>
    $(function(){
        
        console.log("common.ui bind start")
        
        $('.ui-widget-overlay').on('click', function() {
            $('#dialog').dialog('close');
        })
        
    
        $(".accordion_box").hide()
        $(".open .accordion_box").show();
        $(".accordion .title .btn").on("click", function(){
            if($(this).parents(".accordion li").hasClass("open")){
                $(this).parents(".accordion li").removeClass("open");
                $(this).parent().siblings().slideUp(200)
            }else{
                $(this).parents(".accordion li").addClass("open");
                $(this).parent().siblings().slideDown(200)
            }
        });
        
        $(".discount_list .details").hide()
        $(".discount_list .btn").on("click", function(){
            if($(".discount_list").hasClass("open")){
                $(".discount_list").removeClass("open");
                $(".discount_list .details").slideUp(200)
            }else{
                $(".discount_list").addClass("open");
                $(".discount_list .details").slideDown(200)
            }
        });
        
        
    
                
        
        
        if(isLogin) {
            
            if($("#fregInfoTit").length > 0) {
            		
                $("#fregInfoTit").addClass("open");
                $(".gift_list").show();
            }
            
             
            $(".cont_item").hide();
            $(".tab_square > li:first").addClass("ui-tabs-active").show(); 
            $(".tab_square > li:first").parent().addClass("ui-tabs-active");
           
            var strArray = $(".tab_square > li:first > a").prop('id').split('_');
            var strId =  '#'+strArray[1]+'_'+strArray[2];
           
            if("#rcnt_0" === strId){  
                $("#payway_tab_01").show();
            }else{
                $(strId).show();
            }
            $("#settInfoTit").addClass("open");
            $(".payment_method").show();
            
            
            
            
        }else{
        	
        	$(".cont_item").hide();
        	$(".tab_square > li:first").addClass("ui-tabs-active").show(); 
        	$(".tab_square > li:first").parent().addClass("ui-tabs-active");
        	
        	var strArray = $(".tab_square > li:first > a").prop('id').split('_');
            var strId =  '#'+strArray[1]+'_'+strArray[2];
            $(strId).show();
        	
        	
        }
        
	        if(isLogin) {
	            $(".payway-swiper").each(function(index, element){
	                var $this = $(this);
	                $this.addClass("instance-swipwe-" + index);
	                
	                var ProductModuleSwiper = new Swiper(".instance-swipwe-" + index, {
	                    slidesPerView: "auto",
	                    slidesPerView: 1.5,
	                    loop:false,
	                    observer:true,
	                    observeParents:true,
	                    centeredSlides: true,
	                    on :{
	                        slideChange:function() { 
	                            setTimeout(function() {
	                                getChagDcAmt();
	                                
	                                
	                                if(checkSettGrpDoma()[0] == "001") {
	                                    getIstmMonsList('','001','rcnt', '001', checkSettGrpDoma()[1]);
	                                }                                  
	                            }, 100);
	                        }
	                    },
	                });
	            });
	        }
	    
        
        getChagDcAmt('befSett');
        
        
        setTimeout(function() {
	        toggleCashRcpt();
	        paymentSettInfo(); 
        }, 100);
        
        
        $(".loadProgBar").css("display","none"); 
        
    })

    
    $(document).on("click", ".card_discount .chk input", function(){
        if ($(this).is(":checked")){
            $(".card_discount li").removeClass("checked");
            $(this).next().parent("li").addClass("checked");
            getChagDcAmt();
        }
    });

    
    $(document).on("click", ".easypayment .item", function(){
        $(this).addClass("active").siblings().removeClass("active");
    });

    
    $(document).on("click", ".otherpayment .chk input[type='radio']", function(){
        if ($(this).is(":checked")){
            $(".otherpayment .item").removeClass("checked");
            $(this).next().parent().parent(".item").addClass("checked");
        }
    });
    
 
    
</script>
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

	<!-- 공통 팝업 정의 START -->
	<style type="text/css">
/* 레이어 팝업 */
.swiper_control {
	position: relative
}

.swiper_control .swiper-pagination {
	text-align: justify;
	bottom: 30px;
	left: 40px;
	font-size: 15px;
	font-weight: 600;
	color: #ffffff
}

.swiper_control .swiper-pagination span.space {
	padding: 0 3px;
	font-weight: 400
}

.swiper_control .swiper-pagination span.num_total {
	font-weight: 400
}

.popswiper-container .swiper-prev {
	background:
		url('https://cdn.hddfs.com/front/images/KO/common/icon_controller.png')
		0 -32px no-repeat;
	width: 9px;
	height: 13px;
	position: absolute;
	bottom: 33px;
	left: 94px;
	z-index: 100
}

.popswiper-container .swiper-next {
	background:
		url('https://cdn.hddfs.com/front/images/KO/common/icon_controller.png')
		-9px -32px no-repeat;
	width: 9px;
	height: 13px;
	position: absolute;
	bottom: 33px;
	left: 112px;
	z-index: 100
}

.ui-dialog.ui-widget.ui-widget-content.layer_newtype {
	background: #fff;
	border-radius: 20px
}

.ui-dialog.layer_newtype .ui-dialog-titlebar {
	display: none
}
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
    DRMOK_window = window.open(url+'?cpid=hddfs&rtn_url=http://www.hddfs.com/shop/mm/mbshAuca/adultAuca.do?goosInfo='+goosInfo+'&req_info=S89SwqM%2FMBHe8b7YNQLGPs0NuIwSqsukxsPBQlvLgfZVNoHCMrLPo7%2FlVKEx5EWeP4ItNxswkng%2BkamDeNq4x%2BM%2Fldl6bYOuhTmdfhKd6be%2BSwACCGp4CI1rDNM7R8GybG30hBlZlZo%2F6Oaiv73gPLAZ%2FBdTzR5Ydpb9mJknSvtHN6Gk%2FxvTAvI51x6nBZJz%2FtVOm1AdeGPmJ%2BwQ%2FrANbstatuQMvXMLvpIjkuBDsEZekfQqSrK5m%2FNycvLJfxRzpaWi46srdLzfAUWs6XylX9U9KLhjEJ8fY%2B6Rflb6F0wDZ2L4Bi5N67fkN3mAWdiClT8IsqQePCL7cQilM2upfg%3D%3D', 'DRMOKWindow', 'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no' );
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