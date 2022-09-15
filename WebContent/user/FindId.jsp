<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<!-- // header -->
	<!-- container -->
	<main id="container" class="container">
		<script type="text/javascript">
			var dblFlag = false;
			var gTimerId; // 인증시간타이머
			var gLimitSec; // 인증유효시간
			var isDblClick = false;
			var isOverCnt = false;

			$(function() {

				$('#mbshHnglNm, #mbshEngLstnm, #mbshEngFstnm').blur(function() {
					$(this).val($(this).val().toUpperCase());
				});

				$('#mbshBymdDtSms').keyup(function() {
					$(this).val(fnAutoHypenBymd($(this).val())); // 자동하이픈 처리
				});

				$('#mbshBymdDtMail').keyup(function() {
					$(this).val(fnAutoHypenBymd($(this).val())); // 자동하이픈 처리
				});

				// 문자 인증번호 발송 버튼
				$('#smsBtnSend', '#frmMbshFindIdAuth')
						.click(
								function() {
									if (isDblClick) {//중복호출 방지
										return;
									}
									$('#spanSmsError1').hide();

									if (($("#mbshHnglNm").val() == null || $(
											"#mbshHnglNm").val() == '')
											|| ($("#mbshBymdDtSms").val() == null || $(
													"#mbshBymdDtSms").val() == '')
											|| ($("#telNatiCd").val() == null || $(
													"#telNatiCd").val() == '')
											|| ($("#mophNo").val() == null || $(
													"#mophNo").val() == '')) {
										$('#spanSmsError1').show();
										$('#spanSmsError1').text(
												'성명, 생년월일, 휴대폰번호를 입력해주세요.');
										return;
									}

									vRegExpFormat1 = /[^가-힣]/g;
									if (vRegExpFormat1.test($('#mbshHnglNm')
											.val())) {
										$('#spanSmsError1').show();
										$('#spanSmsError1').text(
												'성명을 한글로 입력해주세요.');
										return;
									}

									if (!fnIsValidDate($('#mbshBymdDtSms')
											.val())) {
										$('#spanSmsError1').show();
										$('#spanSmsError1').text(
												'생년월일을 확인해주세요.');
										return;
									}

									if (!fnIsNumber($('#mophNo').val())) {
										$('#spanSmsError1').show();
										$('#spanSmsError1').text(
												'휴대폰 번호를 확인해주세요.');
										return;
									}
									isDblClick = true; //ajax 중복호출 방지 활성화

									$('#frmMbshFindIdAuth').add(
											$('#MbshIosdClsCd').val('0'));

									$
											.ajax({
												url : ctx_curr
														+ '/mm/mbshAuca/sendAuthSmsForFindId.json',
												method : 'post',
												data : $('#frmMbshFindIdAuth')
														.serialize(),
												async : false,
												dataType : 'json',
												success : function(data,
														textStatus, jqXHR) {
													var vResultCode = data.resultCode;
													var vMessage = data.message;
													var vInfo = data.info;

													if (crew.ajaxValidate(data,
															false)) {
														clearInterval(gTimerId); // 기존타이머 종료

														// 타이머설정
														gLimitSec = 180;
														gTimerId = setInterval(
																function() {
																	gLimitSec -= 1;
																	var vMinute = '0'
																			+ parseInt(gLimitSec / 60);
																	var vSecond = '0'
																			+ parseInt(gLimitSec % 60);
																	var vTxt = vMinute
																			.slice(-2)
																			+ ':'
																			+ vSecond
																					.slice(-2);
																	$(
																			'#spanSmsAuthTime')
																			.text(
																					vTxt);
																	if (gLimitSec == 0) {
																		clearInterval(gTimerId); // 타이머종료
																		$(
																				'#spanSmsError2')
																				.show()
																				.text(
																						'인증번호 입력 시간이 초과했습니다. 인증번호 재발송 후 다시 입력해주세요.'); // 인증번호 입력 시간이 초과했습니다. 인증번호 재발송 후 다시 입력해주세요.
																		$(
																				'#authNo')
																				.val(
																						"");
																		$(
																				'#authNo')
																				.attr(
																						'disabled',
																						true);
																	}
																}, 1000);

														alert('인증번호가 발송되었습니다. 3분 이내에 인증번호를 입력해주세요.');
														$('#smsBtnSend')
																.attr("class",
																		"btn_basic4 small");
														$('#smsBtnSend').text(
																'재발송');
														$('#spanSmsError1')
																.hide();
														$('#spanSmsError2')
																.hide();
														$('#authNo').attr(
																'disabled',
																false);
														isOverCnt = false;

													} else {
														$('#spanSmsAuthTime')
																.text('10:00');
														clearInterval(gTimerId);
														$('#authNo').val("");
														$('#authNo').attr(
																'disabled',
																true);

														if (vResultCode == 10) { // 
															alert('일치하는 회원정보가 없습니다. 다시 확인하시고 입력해주세요.');
															$('#smsBtnSend')
																	.attr(
																			"class",
																			"btn_basic4 small");
															$('#smsBtnSend')
																	.text('재발송');
															$('#spanSmsError1')
																	.show()
																	.text(
																			'일치하는 회원정보가 없습니다. 다시 확인하시고 입력해주세요.');
														} else {
															alert('인증번호 발송이 실패하였습니다.');
														}
													}
												},
												error : function(jqXHR,
														textStatus, errorThrown) {
													alert('처리중 오류가 발생하였습니다.');
												},
												complete : function() {
													setTimeout(function() {
														isDblClick = false;
													}, 2000); //2초 후 중복호출 방지 기능 해제
												}
											});
								});

				// 이메일 인증번호 발송 버튼
				$('#mailBtnSend', '#frmMbshFindIdAuth')
						.click(
								function() {
									if (isDblClick) {//중복호출 방지
										return;
									}
									$('#spanMailError1').hide();

									if (($("#mbshEngLstnm").val() == null || $(
											"#mbshEngLstnm").val() == '')
											|| ($("#mbshEngFstnm").val() == null || $(
													"#mbshEngFstnm").val() == '')
											|| ($("#mbshBymdDtMail").val() == null || $(
													"#mbshBymdDtMail").val() == '')
											|| ($("#mailAddr").val() == null || $(
													"#mailAddr").val() == '')) {
										$('#spanMailError1').show();
										$('#spanMailError1').text(
												'성명, 생년월일, 휴대폰번호를 입력해주세요.');
										return;
									}

									if (!fnIsEmail($('#mailAddr').val())) {
										setTimeout(function() {
											$('#spanMailError1').show().text(
													'이메일 주소를 다시 확인하고 입력해주세요.');
										}, 50);
										$('#mailAddr').focus();
										return;
									}
									isDblClick = true; //ajax 중복호출 방지 활성화

									$('#frmMbshFindIdAuth').add(
											$('#MbshIosdClsCd').val('1'));

									$
											.ajax({
												url : ctx_curr
														+ '/mm/mbshAuca/sendAuthEmailForFindId.json',
												method : 'post',
												data : $('#frmMbshFindIdAuth')
														.serialize(),
												async : false,
												dataType : 'json',
												success : function(data,
														textStatus, jqXHR) {
													var vResultCode = data.resultCode;
													var vMessage = data.message;
													var vInfo = data.info;

													if (crew.ajaxValidate(data,
															false)) {
														clearInterval(gTimerId); // 기존타이머 종료

														// 타이머설정
														gLimitSec = 600;
														gTimerId = setInterval(
																function() {
																	gLimitSec -= 1;
																	var vMinute = '0'
																			+ parseInt(gLimitSec / 60);
																	var vSecond = '0'
																			+ parseInt(gLimitSec % 60);
																	var vTxt = vMinute
																			.slice(-2)
																			+ ':'
																			+ vSecond
																					.slice(-2);
																	$(
																			'#spanMailAuthTime')
																			.text(
																					vTxt);
																	if (gLimitSec == 0) {
																		clearInterval(gTimerId); // 타이머종료
																		$(
																				'#spanMailError2')
																				.show()
																				.text(
																						'인증번호 입력 시간이 초과했습니다. 인증번호 재발송 후 다시 입력해주세요.'); // 인증번호 입력 시간이 초과했습니다. 인증번호 재발송 후 다시 입력해주세요.
																		$(
																				'#mailAuthNo')
																				.val(
																						"");
																		$(
																				'#mailAuthNo')
																				.attr(
																						'disabled',
																						true);
																	}
																}, 1000);

														alert('입력하신 이메일로 인증번호가 발송되었습니다. 10분 이내에 인증번호를 입력해주세요.');
														$('#mailBtnSend')
																.attr("class",
																		"btn_basic4 small");
														$('#mailBtnSend').text(
																'재발송');
														$('#spanMailError1')
																.hide();
														$('#spanMailError2')
																.hide();
														$('#mailAuthNo').attr(
																'disabled',
																false);
														isOverCnt = false;

													} else {
														$('#spanMailAuthTime')
																.text('10:00');
														clearInterval(gTimerId);
														$('#mailAuthNo')
																.val("");
														$('#mailAuthNo').attr(
																'disabled',
																true);

														if (vResultCode == 10) { // 
															alert('일치하는 회원정보가 없습니다. 다시 확인하시고 입력해주세요.');
															$('#mailBtnSend')
																	.attr(
																			"class",
																			"btn_basic4 small");
															$('#mailBtnSend')
																	.text('재발송');
															$('#spanMailError1')
																	.show()
																	.text(
																			'일치하는 회원정보가 없습니다. 다시 확인하시고 입력해주세요.');
														} else {
															alert('인증메일 발송이 실패하였습니다.');
														}
													}
												},
												error : function(jqXHR,
														textStatus, errorThrown) {
													alert('처리중 오류가 발생하였습니다.');
												},
												complete : function() {
													setTimeout(function() {
														isDblClick = false;
													}, 2000); //2초 후 중복호출 방지 기능 해제
												}
											});
								});
			});

			function chkSmsAuth() {
				$('#spanSmsError2').hide();

				vRegExpFormat = /[^0-9]{1}/g;

				if ($('#authNo').val() == "" || $('#authNo').val().length < 6
						|| vRegExpFormat.test($('#authNo').val())) {
					setTimeout(
							function() {
								$('#spanSmsError2').show().text(
										'인증번호 확인 후 다시 시도해주세요.');
							}, 50);
					return;
				}

				if (isOverCnt) {
					setTimeout(
							function() {
								$('#spanSmsError2')
										.show()
										.text(
												'인증번호를 5회 이상 잘못 입력하셨습니다. 인증번호 재발송 후 다시 입력해주세요.');
							}, 50);
					$('#spanSmsAuthTime').text('3:00');
					clearInterval(gTimerId); // 타이머종료
					$('#authNo').attr('disabled', true);
					return;
				}

				$('#frmMbshFindIdAuth').add($('#authNo').val());
				$('#frmMbshFindIdAuth').add($('#foreignerYn').val('N'));

				$
						.ajax({
							async : false,
							url : ctx_curr + "/mm/mbshJoin/chkAuthSms.json",
							dataType : "json",
							type : "POST",
							data : {
								type : 'findId',
								telNatiCd : $('#telNatiCd').val(),
								mophNo : $('#mophNo').val(),
								authNo : $('#authNo').val(),
								mbshHnglNm : $('#mbshHnglNm').val(),
								mbshBymdDt : $('#mbshBymdDtSms').val()
							},
							success : function(data, textStatus, jqXHR) {
								var vResultCode = data.resultCode;
								var vMessage = data.message;
								var vInfo = data.info;

								if (crew.ajaxValidate(data, false)) {
									var vUrl = '//www.hddfs.com/shop/mm/mbshAuca/membershipFindIdComplete.do';
									vUrl += '?findId=' + vInfo.findId;
									vUrl += '&findNm='
											+ encodeURIComponent(vInfo.findNm);
									vUrl += '&umbYn='
											+ encodeURIComponent(vInfo.umbYn);

									alert('SMS 인증이 완료되었습니다.');

									$('#frmMbshFindIdAuth')
											.attr(
													'action',
													ctx_curr
															+ '/mm/mbshAuca/membershipFindIdComplete.do?findId='
															+ vInfo.findId
															+ '&findNm='
															+ encodeURIComponent(vInfo.findNm)
															+ '&umbYn='
															+ encodeURIComponent(vInfo.umbYn));
									$('#frmMbshFindIdAuth').submit();
								} else {
									if (vResultCode == 10) {
										setTimeout(function() {
											$('#spanSmsError2').show().text(
													'인증번호 확인 후 다시 시도해주세요.');
										}, 50);
									} else if (vResultCode == 20) {
										isOverCnt = true;
										setTimeout(
												function() {
													$('#spanSmsError2')
															.show()
															.text(
																	'인증번호를 5회 이상 잘못 입력하셨습니다. 인증번호 재발송 후 다시 입력해주세요.');
												}, 50);
										$('#spanSmsAuthTime').text('3:00');
										clearInterval(gTimerId); // 타이머종료
										$('#authNo').val("");
										$('#authNo').attr('disabled', true);
									} else {
										alert('처리중 오류가 발생하였습니다.');
									}
								}

							},
							error : function(jqXHR, textStatus, errorThrown) {
								//console.log(jqXHR.status);
							}
						});

			}

			function chkMailAuth() {
				$('#spanMailError2').hide();

				vRegExpFormat = /[^0-9]{1}/g;

				if ($('#mailAuthNo').val() == ""
						|| $('#mailAuthNo').val().length < 6
						|| vRegExpFormat.test($('#mailAuthNo').val())) {
					setTimeout(function() {
						$('#spanMailError2').show()
								.text('인증번호 확인 후 다시 시도해주세요.');
					}, 50);
					return;
				}

				if (isOverCnt) {
					setTimeout(
							function() {
								$('#spanMailError2')
										.show()
										.text(
												'인증번호를 5회 이상 잘못 입력하셨습니다. 인증번호 재발송 후 다시 입력해주세요.');
							}, 50);
					$('#spanMailAuthTime').text('10:00');
					clearInterval(gTimerId); // 타이머종료
					$('#mailAuthNo').attr('disabled', true);
					return;
				}

				$('#frmMbshFindIdAuth').add($('#mailAuthNo').val());
				$('#frmMbshFindIdAuth').add($('#foreignerYn').val('Y'));

				$
						.ajax({
							async : false,
							url : ctx_curr + "/mm/mbshJoin/chkAuthMailNo.json",
							dataType : "json",
							type : "POST",
							data : $('#frmMbshFindIdAuth').serialize(),
							success : function(data, textStatus, jqXHR) {
								var vResultCode = data.resultCode;

								if (vResultCode == 10) {
									setTimeout(function() {
										$('#spanMailError2').show().text(
												'인증번호 확인 후 다시 시도해주세요.');
									}, 50);
								} else if (vResultCode == 20) {
									isOverCnt = true;
									setTimeout(
											function() {
												$('#spanMailError2')
														.show()
														.text(
																'인증번호를 5회 이상 잘못 입력하셨습니다. 인증번호 재발송 후 다시 입력해주세요.');
											}, 50);
									$('#spanMailAuthTime').text('10:00');
									clearInterval(gTimerId); // 타이머종료
									$('#mailAuthNo').val("");
									$('#mailAuthNo').attr('disabled', true);
								} else if (vResultCode == 0) {
									alert('처리중 오류가 발생하였습니다.');
								} else {
									$('#frmMbshFindIdAuth')
											.attr(
													'action',
													ctx_curr
															+ '/mm/mbshJoin/chkAuthMail.do?mailAukyVal='
															+ data.MailAukyVal);
									$('#frmMbshFindIdAuth').submit();
								}

							},
							error : function(jqXHR, textStatus, errorThrown) {
								//console.log(jqXHR.status);
							}
						});

			}
		</script>
		<div style="width: 100%; min-width: 1340px; padding-top: 121px; ">
		<div class="container">
			<section>
				<div class="join_wrap">
					<form id="frmMbshFindIdAuth" name="frmMbshFindIdAuth" method="post"
						action="DutyfreeServlet?command=FindId"">
						<h2 class="h2_type" >아이디 찾기</h2>
						<!-- 내국인용join_form -->
						<div class="tabcon">
							<div class="join_form">
								<div class="join_row with_btn">
									<input type="text" id="mbshHnglNm" name="mbshHnglNm" value=""
										placeholder="성명" maxlength="60"
										style="text-transform: uppercase; padding:10px;"
										onkeypress="javascript:noSpaceEvnt(event);">
									<p class="t_error" style="display: none;">성명을 입력해주세요.</p>
								</div>
								<div class="join_row with_btn">
									<input type="text" id="mbshHnglNm" name="mbshHnglNm" value=""
										placeholder="전화번호" maxlength="50"
										style="text-transform: uppercase;"
										onkeypress="javascript:noSpaceEvnt(event);">
									<p class="t_error" style="display: none;">전화번호를 입력해주세요.</p>
								</div>
							</div>
						</div>

						<div class="basic_btn_box mgtsm">
							<button type="button" class="btn_basic2"
								onclick="javascript:chkSmsAuth();">확인</button>
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
	<%@include file="../include/footer.jsp"%>