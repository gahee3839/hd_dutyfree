<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "../include/header.jsp" %>
<!-- 0914 박진수 추가  --> 
<!-- 진수 수정 url로 사이트 들어갈 시 에러 페이지로 이동 -->
<%
if(memId==null){
%>
<script type="text/javascript">
location.href='../DutyfreeServlet?command=error';
</script>
<!--
location.href='/프로젝트이름/DutyfreeServlet?command=error'; 으로 바꾸고 실행
 -->
<% }
String update_success="";
update_success=(String)request.getAttribute("update_success");
if(update_success.equals("update_success")){
%>
<script type="text/javascript">
alert("수정이 완료되었습니다");
</script>
<%} %>
<!-- container -->
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
		            ${member.memName}</strong> <em>님</em>
            	</p>
            <a nohref class="passregist" onclick="goUrl('/mm/myInfo/inptMbshPwd.do?type=pspt');">여권정보 등록</a>
                <div class="mylv">
                <span class="lv_on_up001"></span>
                <span class="lv_off_up002"></span>
                </div>
        </div>
         <div class="mypresent">
            <dl style="height:200px; padding-top:80px; width: 250px;">
                <a href="주문내역">
                    <dt style="font-size:20px;">주문내역</dt>
                </a>                   
            </dl>
            <dl style="height:200px; padding-top:80px; width: 250px;">
                <a href="/mm/myCont/listCounQustBbs.do">
                    <dt style="font-size:20px;">문의내역</dt>
                </a>
            </dl>
            <dl style="height:200px; padding-top:80px; width: 250px;">
            <!-- 0914 박진수 추가  --> 
                <a href="DutyfreeServlet?command=Update_page">
                    <dt style="font-size:20px;">기본정보관리</dt>
                </a>
            </dl>
            
            
        </div>
    </div>
 
</article> 
<article id="content">
	<section class="myhd_asis">
		<div class="content_wrap">
			<h3 class="h3_type line">
				기본정보관리
			</h3>
			<form id="update_member" name="update_member" method="post" action="DutyfreeServlet/command=Update">
				<table class="tb_write01 vm">
					<caption>기본정보관리</caption>
					<colgroup>
						<col style="width:160px">
						<col style="width:auto">
					</colgroup>
					<tbody>
					<tr>
						<th scope="row" class="bt_no">아이디</th>
						<td class="bt_no">
						${member.memId }
						<input type="hidden" name="memId" value="${member.memId}">
						</td>
					</tr>
					<tr>
						<th scope="row" class="bt_no">기존 비밀번호</th>
						<td class="bt_no">
						${member.memPw }
						</td>
						<th scope="row" class="bt_no">새 비밀번호</th>
						<td class="bt_no">
						<input type="password" name="new_memPw" value="${member.memPw }">
						<p class="t_info">새 비밀번호를 냅둘 시 기존 비밀번호로 저장이 됩니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row" class="bt_no">성명</th>
						<td class="td_data" name="memName">
						${member.memName }
						<input type="hidden" name="memId" value="${member.memName}">
						<p class="t_info">한글 성명은 고객센터(1811-6688)통해서 수정이 가능합니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row" class="bt_no">성별</th>
						<td class="td_data"> 
						${member.memGender }
						<input type="hidden" name="memId" value="${member.memGender}">
						<p class="t_info">성별은 고객센터(1811-6688)통해서 수정이 가능합니다.</p>
						</td>
					</tr> 
					<tr>
						<th scope="row">생년월일</th>
						<td class="td_data"> 
						${member.memBirth }
						<input type="hidden" name="memId" value="${member.memBirth}">
						</td>
					</tr> 
					<tr>
						<th scope="row">휴대폰번호</th>
						<td class="td_data"> 
						<input type="text" name="memPhone" value="${member.memPhone }">
						</td>
					</tr>  
					<tr>
						<th scope="row">여권번호</th>
						<td class="td_data"> 
						<input type="text" name="memPassport" value="${member.memPassport }">
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
				<div class="btn_area mt40">
				<a href=""  class="btnxl_type2 type2" id="btnConfirm">취소</a>
				<a href=""  class="btnxl_type2 type2 bg_black" id="btnConfirm">확인</a>
				</div>
				</form>
				<!-- <form id="frmMbshPsptMnge" name="frmMbshPsptMnge" method="post" action="">
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
			</form> -->
				
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
</script> -->
<%@include file="../include/footer.jsp" %>
