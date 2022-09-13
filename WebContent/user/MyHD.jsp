<%@page import="com.dutyfree.dto.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ include file="/include/header.jsp" %>


<!-- // header -->
	    <!-- container -->
		<main id="container" >
			<script type="text/javascript">
$(function(){
	
    $('#mbshPwd').keydown(function(e) {
        if(e.keyCode == 13) {
        	$('#btnConfirm', '#frmChkMbshPwd').click();
        	e.preventDefault();
        }
    });

    
    $('#btnConfirm', '#frmChkMbshPwd').click(function() {
    	if(isEmpty($('#mbshPwd', '#frmChkMbshPwd').val())){
    		alert('비밀번호를 입력해주세요.');	
    		return;
    	}
        $.ajax({
            url: ctx_curr + '/mm/myInfo/chkMbshPwd.json',
            method: 'post',
            data: {mbshPwd : $('#mbshPwd', '#frmChkMbshPwd').val()},
            async: true,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                var vResultCode = data.resultCode;
                var vMessage = data.message;
                var vInfo = data.info;

                if(crew.ajaxValidate(data, false)){
                	var vType = 'base';
                	if(vType == 'base') { 
                		location.href = ctx_curr + '/mm/myInfo/detailBaseInfoMnge.do';
                	} else if(vType == 'pwd') { 
                		location.href = ctx_curr + '/mm/myInfo/mbshChgPwd.do';
                	} else if(vType == 'pspt') { 
                        location.href = ctx_curr + '/mm/myInfo/mbshPsptMnge.do';
                    }
                } else {
                	alert('비밀번호를 확인해주세요.'); 
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
            	alert('처리중 오류가 발생하였습니다.');
            }
        });
    });
});
</script>
        <main id="container">
            <article class="location">
                <section class="box">
                    <a nohref onclick="goUrl('/dm/main.do');" class="home">홈</a>
                    <div>
                    	<span>마이현대</span>
                    </div>
                    <div>
                    	<span>기본정보관리</span>
                    </div>
                </section>
            </article>
            <article class="top_fullbg">
    <h2 class="page_tit">기본정보관리</h2>    
    <div class="myhd_firinfo">
        <div class="myinfo">
        	<p class="name">
            	<strong>
		            <%=member.getMemName() %></strong> <em>님</em>
            	</p>
            <a nohref class="passregist" onclick="goUrl('/mm/myInfo/inptMbshPwd.do?type=pspt');">여권정보 등록</a>
                <div class="mylv">
                <span class="lv_on_up001"></span>
                <span class="lv_off_up002"></span>
                </div>
        </div>
        <div class="mypresent">
            <dl style="height:200px; padding-top:80px ;">
                <a href="주문내역">
                    <dt style="font-size:20px;">주문내역</dt>
                </a>                   
            </dl>
            <dl style="height:200px; padding-top:80px ;">
                <a href="/mm/myCont/listCounQustBbs.do">
                    <dt style="font-size:20px;">문의내역</dt>
                </a>
            </dl>
           <!--  <dl style="height:200px; padding-top:80px ;">
                <a href="/mm/myInfo/inptMbshPwd.do?type=base">
                    <dt style="font-size:20px;">기본정보관리</dt>
                </a>
            </dl> -->
            <dl style="height:200px; padding-top:80px ;">
                <a href="/mm/myInfo/inptMbshPwd.do?type=pspt">
                    <dt style="font-size:20px;">여권정보관리</dt>
                </a>
            </dl>
            <dl style="height:200px; padding-top:80px ;">
				  <a href="/mm/myInfo/listMbshDpatInfo.do">
                    <dt style="font-size:20px;">출국정보관리</dt>
                </a>
	        </dl>
            
        </div>
    </div>
   <!--  <div class="mymenu">
        <p class="ti">My Hyundai
        <ul>
            <li><a nohref onclick="goUrl('/mm/myOrder/listOrder.do');">주문내역</a></li>
            <li><a nohref onclick="goUrl('/mm/myOrder/listSpord.do');">스페셜오더/H.Share</a></li>
            
            <li id="hPointPay"><a nohref onclick="goHPointPay('');">H.Point Pay 관리</a></li>
          
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
    </div> -->
</article> 
<article id="content">
	<section class="myhd_asis">
		<div class="content_wrap">
			<h3 class="h3_type line">
				기본정보관리
			</h3>
			<form id="update_member" name="update_member" method="post" action="Dutyfree/command=update">
				<table class="tb_write01 vm">
					<caption>기본정보관리</caption>
					<colgroup>
						<col style="width:160px">
						<col style="width:auto">
					</colgroup>
					<tbody>
					<tr>
						<th scope="row" class="bt_no">아이디</th>
						<td class="bt_no"><%=member.getMemId() %></td>
					</tr>
					<tr>
						<th scope="row" class="bt_no">성명</th>
						<td class="td_data"><%=member.getMemName() %>
						<p class="t_info">한글 성명은 고객센터(1811-6688)통해서 수정이 가능합니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row" class="bt_no">성별</th>
						<td class="td_data"> 
						<%=member.getMemGender() %>
						<p class="t_info">성별은 고객센터(1811-6688)통해서 수정이 가능합니다.</p>
						</td>
					</tr> 
					<tr>
						<th scope="row">생년월일</th>
						<td class="td_data"> 
						<%=member.getMemBirth()%>
						</td>
					</tr> 
					<tr>
						<th scope="row">휴대폰번호</th>
						<td class="td_data"> 
						<input type="text" value=<%=member.getMemPhone()%>>
						</td>
					</tr>  
					<tr>
						<th scope="row">회원탈퇴</th>
						<td>
						<span class="rgap02">회원탈퇴를 하시면 그동안 구매 실적은 사라집니다.</span>
						<button type="button" class="btn_basic4 small" id="deleteMember">
						회원탈퇴
						</button>		
						</td>				
					</tr>
					</tbody>
				</table>
				</form>
				<form id="frmMbshPsptMnge" name="frmMbshPsptMnge" method="post" action="">
				<div class="cont_stit por">
				<h3>여권 정보</h3>
				</div>
				<div class="info_table input_passport">
				<table>
				<colgroup>
				<col style="width:150px">
				<col style="width:390px">
				<col style="width:155px">
				<col style="width:auto">
				</colgroup>
				<tbody>
				<tr>
					<th>
					Last Name 성
					<span class="star_red">*</span>
					</th>
					<td class="td_pd" id="divPsptLast">
					<span class="input_de">
					<input type="text" id="mbshEngLstnm" name="mbshEngLstnm" placeholder="영문 성을 공백없이 입력해주세요">
					</span>
					<p class="t_error2" style="display:none;"></p>
					</td>
					<th>
					First Name 이름
					<span class="star_red">*</span>
					</th>
					<td class="td_pd" id="divPsptFirst">
					<span class="input_de">
					<input type="text" id="mbshEngFstnm" name="mbshEngFstnm" placeholder="영문 이름을 공백없이 입력해주세요">
					<p class="t_error2" style="display:none;"></p>
					</span>
					</td>
					</tr>
					<tr>
					<th>
					여권번호
					<span class="star_red">*</span>
					</th>
					<td class="td_pd" id="divPsptNo">
					<span class="input_de">
					<input type="text" id="psptNo" name="psptNo" placeholder="여권번호를 입력해주세요">
					</span>
					<p class="t_error2" style="display:none;"></p>
					</td>
					<th>
					여권만료일
					<span class="star_red">*</span>
					</th>
					<td class="td_pd" id="divPsptDate">
					<span class="input_de datepicker_box">
					<input type="text" class="datepicker hasDatepicker" placeholder="YYYY-MM-DD" id="psptExpiDt" name="psptExpiDt" maxlength="10">
					</span>
					</td>
					</tr>
				</tbody>
				</table>
				</div>
				<div class="btn_area mt40">
				<a href=""  class="btnxl_type2 type2" id="btnConfirm">취소</a>
				<a href=""  class="btnxl_type2 type2 bg_black" id="btnConfirm">확인</a>
				</div>
			</form>
				
		</div>
	</section>
</article>   
<script type="text/javascript">

$(document).ready(function(evt){
    getSvmtAmtAble();
    
    
    getTotBuyAmtNtnl();
    
    $('#hpointAmt').parent().html("<dt>H.Point</dt><dd><a nohref id='btnHeaderUmbSwitcJoin1'>통합회원 전환</a></dd>");
    $('#btnHeaderUmbSwitcJoin1').click(function() {
        popOpen(ctx_curr + '/mm/myInfo/umbMbshJoinNtcPop.do', 'chgUmbMbshPop', 450, 500);
    });
    
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
	
    var vAucaType = 'GENE'; 
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

$(function(){
	$("#deleteMember").click(function(){ window.open("./DutyfreeServlet?command=delete_form","width=700,height=800 toolbar=no,status=no,location=no,scrollbar=yes,resizeable=yes") });
})
</script><!-- <article id="content">
            <form id="frmChkMbshPwd" name="frmChkMbshPwd" method="post" action="">
                <section class="myhd_content">
                    <div class="pw_recheck">
                        <p>회원님의 소중한 개인정보보호를 위하여<br>
                            비밀번호를 다시 한번 확인해 주시기 바랍니다.</p>
                        <span class="input_de"><input type="password" id="mbshPwd" name="mbshPwd" value="" onkeypress="noSpaceEvnt(event);"></span>
                        <div class="btn_area mt40">
                            <a href="javascript:void(0);" class="btnxl_type2 type2 bg_black" id="btnConfirm">확인</a>
                        </div>    
                    </div>
                </section>
            </form>
        </article></main>
	    // container
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
<<<<<<< HEAD
</script>
 <%@ include file="../footer.jsp" %>

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
    DRMOK_window = window.open(url+'?cpid=hddfs&rtn_url=http://www.hddfs.com/shop/mm/mbshAuca/adultAuca.do?goosInfo='+goosInfo+'&req_info=a3LUAhafUU5l88hc83dioLvlLUF0iLV16gZVCIdgaXeXsWOJcBM3nInsMs27sSdETiBYuB8WXy6FT4PfcSN3k7%2BORBziS1bz2BuQJGuOf0D%2F4WKi8CSwBc7BJCivjBGxMYDA%2BEBeQPraHkTZEGJpP1VaCiWlS4YhLfKb624bIdOdTpBLoJWC7q6HZ%2FMzSHxjATEymlnV8uepoAilBOY3jZZQJw5DhVjvPLqfsWpjFj1NrgHLSEE6C6lw6Zw3PaAcmBkmirxpbzEg11%2FEeh%2Fbzixn9%2BmWqhr5UXKFDEc1dzwdW7cQBKHoeDFN2wMqjiUmymZ53F0Jd22evi8Zn7Y9BQ%3D%3D', 'DRMOKWindow', 'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no' );
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

</script> -->
<%@ include file="/include/footer.jsp" %>

