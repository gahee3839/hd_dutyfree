<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>
<%
	String pw = (String) request.getAttribute("pw");

if (pw != null) {
%>
<script language='javascript'>
	alert('비밀번호는 ' + pw);
	location.href = '../DutyfreeServlet?command=index';
</script>

<%
	}
%>

<!-- container -->
<main id="container" class="container">
<script type="text/javascript">
		$(function() {
			$('#btnLgin', '#FindPw').click(function() {
						// trim 처리
						$('#memId', '#FindPw').val(
								$.trim($('#memId', '#FindPw').val()));
						$('#memPhone', '#FindPw').val(
								$.trim($('#memPhone', '#FindPw').val()));

						if ($('#memId', '#FindPw').val() == '') {
							$('#pError', '#FindPw').show()
									.text('아이디를 입력해주세요.');
							$('#memId', '#FindPw').focus();
							return;
						}

						if ($('#memPhone', '#FindPw').val() == '') {
							$('#pError','#FindPw').show().text(
									'비밀번호를 입력해주세요.');
							$('#memPhone', '#FindPw').focus();
							return;
						}
						$('#pError', '#FindPw').hide();
						$('#FindPw').submit();
						//fnLogin('GENE', $('#frmGeneLgin').serialize());
			 });
			});
</script>
			
			
			// 엔터키처리
			
	<div style="width: 100%; min-width: 1340px; padding-top: 121px;">
		<div class="container">
			<section>
				<div class="join_wrap">
					<h2 class="h2_type">비밀번호 찾기</h2>
					<!-- <p class="f_size01 mgtm">아이디를 입력하시면 비밀번호 찾기를 하실 수 있습니다.</p> -->
					<form id="FindPw" name="FindPw" method="post" action="DutyfreeServlet?command=FindPw" autocomplete="off">
				
				<!-- 탭구분용 -->
				<div class="join_form">
					<div class="join_row with_btn">
						<!-- 0914 박진수 추가  -->
						<input type="text" id="memId" name="memId"  placeholder="아이디" onkeypress="javascript:noSpaceEvnt(event);" maxlength="20" autocomplete="off">
						<p class="t_error" style="display:none;">아이디를 입력해주세요.</p>
						<!--  -->
					</div>
					<div class="join_row">
						<input type="text" id="memPhone" name="memPhone" placeholder="휴대폰번호" onkeypress="javascript:noSpaceEvnt(event);" maxlength="100" autocomplete="off">
						<p class="t_error" style="display:none">휴대폰번호를 입력해주세요.</p>
					</div>
				</div>
				<div class="dang_type">
					<p class="d_txt" id="pError" style="display: none;"></p>
				</div>
				<div class="basic_btn_box mgtsm">
                        <button type="button" class="btn_basic2" id="btnLgin">확인</button>
                </div>
			</form>
				</div>
			</section>
		</div>
	</div>
</main>
<!-- // container -->
<script type="text/javascript">
	function sellerInfo() {
		$("#seller_information").dialog("open");
	}
	$(document).ready(function() {
		// 다이얼로그 초기화
		$("#seller_information").dialog({
			autoOpen : false,
			resizable : false,
			width : 400,
			maxHeight : 340,
			modal : true
		});
	});
	function moveToMain() {
		location.href = ctx_shop + '/dm/main.do';
	}
</script>
<%@ include file="../include/footer.jsp"%>


