<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<!-- 
여기는 주문 취소 페이지
팝업(?) 나와서 구현이 되어있음

주문 취소 사유는 묻지않고
주문 취소 누르면 주문 취소돼용

 -->
<html lang="ko">
<head>
<meta charset="utf-8">
<title>현대면세점</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="https://cdn.hddfs.com/front/js/KO/jquery-1.11.3.min.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/jquery.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/jquery-ui.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/jquery.bxslider.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/swiper.min.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/common.ui.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/crew/crew.source.js?ver=18"></script>
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/jquery-ui.css?ver=18">
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/swiper.min.css?ver=18">
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/common.css?ver=18">
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/popup.css?ver=18">
<link rel="shortcut icon" href="https://cdn.hddfs.com/front/images/KO/common/favicon_H.ico">
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
<!-- E: 2022-05-25 이지웰메인팝업 추가 --><script type="text/javascript">

var checkAccountNoYn = "N";
var accountNo = "";


var gCnclCallYn = "N";

$(function(){
    
    $("select[name=repyBnkCd]").selectmenu({
        change : function(event, ui){
            var val = this.value;
            checkAccountNoYn = "N";
        }
    });
    
    $("input[name=svacOwrNm]").change(function(){
        checkAccountNoYn = "N";
    });
});   


function focusAccountNo(val){
    accountNo = val;
}


function changAccountNoYn(val){
    if(val != accountNo){
        checkAccountNoYn = "N";
    }
}


function validateBankAccountNo(){
    var form = $("form[name=form]");

    
    if(!form.validateForm()){ return; }

    
    var formData = form.serializeObject();
    var data = { name : formData.svacOwrNm, bnkCd : formData.repyBnkCd, acntNo : formData.repyAcntNo }

    $.ajax({
        async       : true,
        url         : ctx_curr + "/cm/comm/validateBankAccountNo.json",
        dataType    : "json",
        type        : "POST",
        data        : data,
        success     : function(data, textStatus, jqXHR){
            if(!crew.ajaxValidate(data)){ return; }

            checkAccountNoYn = "Y";
            alert('계좌정보 확인이 완료되었습니다.'); 
        },
        error       : function(jqXHR, textStatus, errorThrown){
        	
        }
    });
}

function cnclOrder(){
    if(gCnclCallYn == "Y"){
    	alert('처리중 입니다.'); 
    	return;
    }
	
    if($("#selCounCnclResnCd").val() == "") {
    	alert('취소 사유를 선택해 주세요.'); 
        $('#selCounCnclResnCd').focus();
        return;
    }
	
    
    var mophSettYn = 'N';
    if(mophSettYn == 'Y'){
    	
        if(checkAccountNoYn != "Y"){
        	alert('계좌정보를 확인해주세요.'); 
            return;
        }
    }
    
    if(confirm('주문을 취소하시겠습니까?')){ 
		var vOrderNo = 'OR2022091400561';
	    var vOrderCnclResnCd = $("#selCounCnclResnCd").val();
	    var vOrderCnclResnCont = $("#selCounCnclResnCont").val();
	    
	    var vBillNos = [];
	    $(".cnclPsbBillNo").each(function(){
	    	vBillNos.push($(this).val());
	    });
	    
	    var vSvacOwrNm = '';
	    var vRepyBnkCd = '';
	    var vRepyAcntNo = '';
	    if(mophSettYn == 'Y'){
	    	var form = $("form[name=form]");
	    	var formData = form.serializeObject();
	        vSvacOwrNm = formData.svacOwrNm;
	    	vRepyBnkCd = formData.repyBnkCd;
	        vRepyAcntNo = formData.repyAcntNo;
	    }
	    
	    gCnclCallYn = "Y";
	    
	    $.ajax({
	        async       : true,
	        url         : "//www.hddfs.com/shop/mm/myOrder/cancelOrder.json",
	        dataType    : "json",
	        contentType : "application/json; charset=utf-8",
	        type        : "POST",
	        data        : JSON.stringify({orderNo : vOrderNo, orderCnclResnCd : vOrderCnclResnCd, orderCnclResnCont : vOrderCnclResnCont, billNos : [vBillNos.join(",")], svacOwrNm : vSvacOwrNm, repyBnkCd : vRepyBnkCd, repyAcntNo : vRepyAcntNo}),
	        success     : function(data, textStatus, jqXHR){
	            if(!crew.ajaxValidate(data)){ return; }
	            
	            if(data.resultCode == 1) {
	            	alert("주문취소 처리되었습니다."); 
	                opener.location.reload();
	                self.close();
	            }else{
	            	alert(data.message);
	            }
	            
	        },
	        error       : function(jqXHR, textStatus, errorThrown){
	        },
	        complete : function(){
                gCnclCallYn = "N";
            }
	    });
		
	}
}

</script>
</head>
<body>
    <div class="pop_wrap">
	        <h1 class="h1_type">주문취소</h1>
	        <div class="pop_content">
	            <table class="tb_view01 mgts type2">
	                <caption>주문 정보</caption>
	                <colgroup>
	                    <col style="width:20%">
	                    <col style="width:auto">
	                    <col style="width:20%">
	                    <col style="width:auto">
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th scope="row">주문번호</th>
	                        <td>OR2022091400561</td>
	                        <th scope="row">주문일시</th>
	                        <td>2022-09-14 21:23</td>
	                    </tr>
	                    <tr>
	                        <th scope="row">성명</th>
	                        <td>김민선</td>
	                        <th scope="row">국적</th>
	                        <td>한국</td>
	                    </tr>
	                    <tr>
	                        <th scope="row">여권번호</th>
	                        <td>M97841669</td>
	                        <th scope="row">생년월일</th>
	                        <td>1996-06-03</td>
	                    </tr>
	                    <tr>
	                        <th scope="row">출국장소</th>
	                        <td>인천공항</td>
	                        <th scope="row">출국일시</th>
	                        <td>2022-09-23&nbsp;10:00</td>
	                    </tr>
	                    <tr>
	                        <th scope="row">직항/경유</th>
	                        <td>
	                            직항</td>
	                        <th scope="row">편명</th>
	                        <td>KE081</td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="tb_list mgtmm">
	                <table>
	                    <caption>주문 목록</caption>
	                    <colgroup>
	                        <col style="width:110px">
	                        <col style="width:auto">
	                        <col style="width:110px">
	                        <col style="width:50px">
	                        <col style="width:110px">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th scope="col">교환권 번호</th>
	                            <th scope="col">상품명</th>
	                            <th scope="col">판매금액</th>
	                            <th scope="col">수량</th>
	                            <th scope="col">구매금액</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <tr>
		                            <input type="hidden" class="cnclPsbBillNo" value="0122091480101523" >
		                                <td class="gray" rowspan="1">0122091480101523</td>
	                                <td class="tl" style="padding-left: 0px;">
		                                <div class="p_small">
		                                    <div class="p_simg"><img src="https://cdn.hddfs.com/files/goos/6341/20190904/ebdd39e5.JPG?sf=webp&RS=64X64" alt="클래식 해수진주 목걸이(W.G)" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/no_img60.jpg';"></div>
		                                    <p class="p_stit">포씨엘<br>클래식 해수진주 목걸이(W.G)</p>
		                                </div>
		                            </td>
		                            <td class="p_info">
		                                <p class="p_price">
		                                    <span class="be">$246</span>
		                                    <span class="sale">$221.4</span>
	</p>
		                            </td>
		                            <td>2</td>
		                            <td class="p_info">
		                                <p class="p_price">
		                                    <span class="sale">$442.8</span>
		                                    <span class="won">(611,595원)</span>
		                                </p>
		                            </td>
		                        </tr>
		                        <tr>
		                            <input type="hidden" class="cnclPsbBillNo" value="0122091480205720" >
		                                <td class="gray" rowspan="1">0122091480205720</td>
	                                <td class="tl" style="padding-left: 0px;">
		                                <div class="p_small">
		                                    <div class="p_simg"><img src="https://cdn.hddfs.com/files/goos/0004/20210929/2bc2b998.jpg?sf=webp&RS=64X64" alt="트리플러스 우먼 90C(성인 여성의 필수 영양에 맞춘 멀티비타민, 미네랄, 오메가-3 함유, 면역력 강화, 항산화에 도움)" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/no_img60.jpg';"></div>
		                                    <p class="p_stit">세노비스<br>트리플러스 우먼 90C(성인 여성의 필수 영양에 맞춘 멀티비타민, 미네랄, 오메가-3 함유, 면역력 강화, 항산화에 도움)</p>
		                                </div>
		                            </td>
		                            <td class="p_info">
		                                <p class="p_price">
		                                    <span class="be">$41</span>
		                                    <span class="sale">$22.55</span>
	</p>
		                            </td>
		                            <td>1</td>
		                            <td class="p_info">
		                                <p class="p_price">
		                                    <span class="sale">$22.55</span>
		                                    <span class="won">(31,146원)</span>
		                                </p>
		                            </td>
		                        </tr>
		                        </tbody>
	                </table>
	            </div>
	            <div class="tb_list02 mgtmm ">
	                <table class="refundTbl">
	                    <caption>환불정보</caption>
	                    <colgroup>
	                        <col style="width:50%">
	                        <col style="width:auto">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th scope="col">환불내역</th>
	                            <th scope="col">환불예정금액</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <tr>
	                            <td>                
                                    <dl>      
	                                    <dt>
				                                          무통장(가상계좌)</dt>
				                                        <dd>
					                                        <span class="won">632,741원</span>
					                                    </dd>
			                                      </dl>
	                                <dl>
	                                    <dt>쿠폰취소</dt>
	                                    <dd>
	                                        <span class="won">0원</span>
	                                    </dd>
	                                </dl>
	                                <dl>
	                                    <dt>적립금 취소/환불</dt>
	                                    <dd>
	                                        <span class="won">10,000원</span>
	                                    </dd>
	                                </dl>
                                    <!-- S: 2021-03-29 제휴사 포인트 적립신청 -->
                                    <dl>
                                        <dt>스카이패스 적립 취소 마일리지</dt>
                                        <dd>
                                            <span class="won">0마일</span>
                                        </dd>
                                    </dl>
                                    <!-- //E: 2021-03-29 제휴사 포인트 적립신청 -->	                                
	                                </td>
	                            <td class="p_info">
	                                <p class="p_price">
	                                    <span class="sale">$458.1</span>
	                                    <span class="won">(632,741원)</span>
	                                </p>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	            </div>
	            <table class="tb_write01 m_minus">
	                <caption>주문 취소사유</caption>
	                <colgroup>
	                    <col style="width:20%">
	                    <col style="width:auto">
	                </colgroup>
	                <tbody>
	                    <tr>
	                        <th scope="row">주문 취소사유</th>
	                        <td>
	                            <span class="selw03">
	                                <select name="selCounCnclResnCd"
    class="sel_type"id="selCounCnclResnCd"
>
    <option value="">취소사유선택</option>
    <option value="001" >구매불필요</option>
    <option value="002" >출국 취소</option>
    <option value="003" >적립금/쿠폰 재사용</option>
    <option value="004" >환율변경으로 인한 재구매</option>
    <option value="005" >타사보다 높은판매금액</option>
    <option value="999" >기타</option>
    </select>
</span>
	                            <br />
	                            <textarea placeholder="" class="sbox_type" id="selCounCnclResnCont"></textarea>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="attention_wrap mgtsm">
			            <p class="attention">유의사항</p>
			            &bull; 취소 후 재 구매 시 상품이 품절될 수 있습니다.<br />
&bull; 재 구매 시 할인율과 환율이 상이할 수 있습니다.<br />
&bull; 주문 시 사용하신 쿠폰 및 적립금은 주문 취소 완료 시 복원됩니다.<br />
&nbsp; (단, 유효기간이 남은 쿠폰과 적립금에 한하여 재사용이 가능합니다.)<br />
&bull; 주문 시 응모하신 이벤트 또는 사은 행사의 경우 취소 시 무효 처리됩니다.<br />
&bull; 취소 후 카드 환불은 카드사에 따라 3~5일 소요되며, 무통장입금 환불은는 입금요청 계좌로 3~5일 내 환불됩니다. (영업일 기준)<br />
&bull; 결제 수단으로 환불이 불가능한 경우 예치금으로 환불됩니다.<br />
&bull; 상품 위치에 따라 즉시취소가 불가할 수 있습니다.<br />
&bull; 현대백화점면세점 고객센터 1811-6688 / 운영시간 09:30~18:30
			        </div>
			    <div class="sh_btn_box">
	                <button type="button" class="btn_basic1" onclick="javascript:self.close()">취소</button>
	                <button type="button" class="btn_basic2" onclick="javascript:cnclOrder();">주문취소</button>
	            </div>
	            </div>
	    </div>
    </body>