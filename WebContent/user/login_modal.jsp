<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
<meta charset="utf-8">
<title>현대백화점인터넷면세점</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="https://cdn.hddfs.com/front/js/KO/jquery-1.12.4.min.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/jquery-ui.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/jquery.bxslider.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/swiper.min.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/jquery.lazyload.min.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/jquery.lazyloadxt.min.js?ver=18"></script>
<script src="https://cdn.hddfs.com/front/js/KO/common.ui.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/crew.source.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/form/form.source.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/common.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/SsoAjax.js?ver=18"></script>
<script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/SsoHttpRequest.js?ver=18"></script>
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/jquery-ui.css?ver=18">
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/swiper.min.css?ver=18">
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/common.css?ver=18">
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/member.css?ver=18">
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/popup.css?ver=18">
<link rel="shortcut icon" href="https://cdn.hddfs.com/front/images/KO/common/favicon_H.ico">
</head>
<body>
<script type="text/javascript">
document.msCapsLockWarningOff = true; // ie caps lock 체크 툴팁해제
var ctx_curr                = "//www.hddfs.com/shop";
var ctx_shop                = "https://www.hddfs.com/shop";
var SERVER_SCRIPT_JSON      = "https://cdn.hddfs.com/files";
var gUmbMbshUrl             = "https://www.h-point.co.kr"; // 통합멤버쉽 주소
var gAucaType = 'INTG'; // 로그인유형
var ctx_serviceName = "prod";
var umbKkoSyncYn = "";

$(function(){
    // 비밀번호 잠금 레이어 설정
    $("#pw_error").dialog({
        autoOpen: false,
        resizable: false,
        width:400,
        maxHeight: 720,
        modal: true
    });

	// 통합멤버쉽 간편가입 안내
    $("#mem_error").dialog({
        autoOpen: false,
        resizable: false,
        width:400,
        maxHeight: 720,
        modal: true
    });
    
    
    $("#pw_noti").dialog({
    	autoOpen: false,
    	resizable: false,
        width:400,
        maxHeight: 320,
        modal: true,
        closeOnEscape:false
    });
    $("#pw_noti").on('dialogclose',function(){
        fnLogin('INTG', $('#frmIntgLgin').serialize());
    });

	// 탭 클릭시 로그인유형 변경
    $('li', '#ulAucaType').click(function() {
    	gAucaType = $(this).attr('id');
    });

    // 통합 아이디, 비밀번호 caps lock 체크
    $('#custId, #custPwd', '#frmIntgLgin').keypress(function(e) {
        var s = String.fromCharCode( e.which );
        if ( s.toUpperCase() === s && s.toLowerCase() !== s && !e.shiftKey ) {
            $('#pError', '#frmIntgLgin').show().text("<Caps Lock>이 켜져 있습니다.");
        } else {
            $('#pError', '#frmIntgLgin').hide();
        }
    });

    // 일반 아이디, 비밀번호 caps lock 체크
    $('#mbshId, #mbshPwd', '#frmGeneLgin').keypress(function(e) {
        var s = String.fromCharCode( e.which );
        if ( s.toUpperCase() === s && s.toLowerCase() !== s && !e.shiftKey ) {
        	$('#pError', '#frmGeneLgin').show().text("<Caps Lock>이 켜져 있습니다.");
        } else {
        	$('#pError', '#frmGeneLgin').hide();
        }
    });

    // 통합 로그인버튼
    $('#btnLgin1', '#frmIntgLgin').click(function() {
    	// trim 처리
    	$('#custId', '#frmIntgLgin').val($.trim($('#custId', '#frmIntgLgin').val()));
    	$('#custPwd', '#frmIntgLgin').val($.trim($('#custPwd', '#frmIntgLgin').val()))
        
    	if($('#custId', '#frmIntgLgin').val() == '') {
            $('#pError', '#frmIntgLgin').show().text('아이디를 입력해주세요.');
            $('#custId', '#frmIntgLgin').focus();
            return ;
        }

        if($('#custPwd', '#frmIntgLgin').val() == '') {
            $('#pError', '#frmIntgLgin').show().text('비밀번호를 입력해주세요.');
            $('#custPwd', '#frmIntgLgin').focus();
            return ;
        }
        $('#pError', '#frmIntgLgin').hide();

    	$.ajax({
            url: ctx_curr + '/mm/mbshJoin/lginUmbMbshh.json',
            method: "post",
            data: $('#frmIntgLgin').serialize(),
            async: false,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                var vInfo = JSON.parse(data.info);
                
                lginUmbMbsh(vInfo);
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.');
            }
        });
    });
    
    if(umbKkoSyncYn != null && umbKkoSyncYn == 'Y'){
        var kData = JSON.parse('');
        $('#umbMbshNo', '#frmIntgLgin').val(kData.mcustNo);
        lginUmbMbsh(kData);
    }
    

    // 일반 로그인버튼
    $('#btnLgin2', '#frmGeneLgin').click(function() {
    	// trim 처리
    	$('#mbshId', '#frmGeneLgin').val($.trim($('#mbshId', '#frmGeneLgin').val()));
    	$('#mbshPwd', '#frmGeneLgin').val($.trim($('#mbshPwd', '#frmGeneLgin').val()));


    	if($('#mbshId', '#frmGeneLgin').val() == '') {
            $('#pError', '#frmGeneLgin').show().text('아이디를 입력해주세요.');
            $('#mbshId', '#frmGeneLgin').focus();
            return ;
        }

    	if($('#mbshPwd', '#frmGeneLgin').val() == '') {
            $('#pError', '#frmGeneLgin').show().text('비밀번호를 입력해주세요.');
            $('#mbshPwd', '#frmGeneLgin').focus();
            return ;
        }
    	$('#pError', '#frmGeneLgin').hide();

    	fnLogin('GENE', $('#frmGeneLgin').serialize());
    });

    // 통멤 아이디 찾기
    $('#aFindId', '#frmIntgLgin').click(function() {
    	popOpen(gUmbMbshUrl + '/cu/config/findCustId.nhd', 'umbFindCustIdPop', 770, 903);
    });

    // 통멤 비밀번호 찾기
    $('#aFindPwd', '#frmIntgLgin').click(function() {
    	popOpen(gUmbMbshUrl + '/cu/config/findCustPwd.nhd', 'umbFindCustPwdPop', 770, 903);
    });

    // 엔터키처리
    $('#custPwd, #mbshPwd').keydown(function(e) {
        if(e.keyCode == 13) {
        	if(gAucaType == 'INTG') {
        		$('#btnLgin1', '#frmIntgLgin').click(); // 통멤로그인
            } else {
            	$('#btnLgin2', '#frmGeneLgin').click(); // 면세점로그인
            }
        	e.preventDefault();
        }
    });

    // 통멤 간편가입 팝업
    $('#btnUmbSimpleJoin', '#mem_error').click(function() {
    	// 간편가입처리(통멤페이지로 이동시 SSO처리때문에 redirect이 일어나므로 통멤페이지 두 번 호출함)
        $('#hiddenifr').attr('src', gUmbMbshUrl);
        setTimeout(function(){ fnUmbSimpJoinPop($('#ssoMcustNo', '#mem_error').val(), ''); }, 1500);
    });

    fnInit();

    // SSO 인증처리
    gfnSsoReqHttp(fnSsoAuthCallback);
    
    
    $("#umbMbshPwdChgExt").click(function(){
        $.ajax({
            url: ctx_curr + '/mm/mbshJoin/umbMbshPwdChgExt.json',
            method: "post",
            data: {"mcustNo" : $("#umbMbshNo").val()},
            async: false,
            dataType : 'json',
            success : function(data, textStatus, jqXHR) {
                var vInfo = JSON.parse(data.info);
//                 console.log(vInfo);
                //에러 코드에 따른 결과 처리
                if(vInfo.code == '0000') { // 성공
                	
                } else { // 실패
                	alert("통합멤버십 비밀번호가 변경되지 않았습니다. 다시 시도해 주세요.");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                alert('처리중 오류가 발생하였습니다.');
            }
            ,complete : function(){
            	$("#pw_noti").dialog('close');
            }
        });
    });
});

// opner redirect -> self.close
function fnOpenerLocationClose(url){
	opener.location.href = ctx_curr + url;
    self.close();
}
// 초기화 함수
function fnInit() {
	var vIntgId = getCookie('INTG_SAVE_ID');
	var vGeneId = getCookie('GENE_SAVE_ID');

	// 아이디저장값 화면에 설정
	if(vIntgId != '') {
		$('#umbSaveId', '#frmIntgLgin').prop('checked', true);
		$('#custId', '#frmIntgLgin').val(vIntgId);
	}

	if(vGeneId != '') {
        $('#saveId', '#frmGeneLgin').prop('checked', true);
        $('#mbshId', '#frmGeneLgin').val(vGeneId);
    }

	// 보여지는 탭 설정
	if(vIntgId != '') {
		$('#custPwd', '#frmIntgLgin').focus();
        return ;
    }

    if(vGeneId != '') {
    	$('#GENE').find('a').click();
    	$('#mbshPwd', '#frmGeneLgin').focus();
        return ;
    }

    $('#custId', '#frmIntgLgin').focus();
}

// 로그인
function fnLogin(type, data) {
	$.ajax({
        url: ctx_curr + '/mm/mbshAuca/saveLgin.json',
        method: "post",
        data: data,
        async: false,
        dataType : 'json',
        success : function(data, textStatus, jqXHR) {
            loginCallback(type, data);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
}

//통멤 로그인 처리 상세
function lginUmbMbsh(vInfo){
    if(vInfo.code == '0000') { // 성공
        // SSO토큰발급요청
        if(vInfo.succYn == 'Y') {
            $('#umbMbshNo', '#frmIntgLgin').val(vInfo.mcustNo);
            //console.log( "0000 권한코드 발급 완료 mcustNo : " + vInfo.mcustNo + "\nssoAuthMcustNo : " + vInfo.ssoAuthMcustNo + '\nssoAuthCd : ' + vInfo.ssoAuthCd);
            gfnReqSSoToknIssuHttp(vInfo.ssoAuthMcustNo, vInfo.ssoAuthCd, fnSsoToknCallback);
        }
    } else if(vInfo.code == 'L001') { // 로그인오류
        alert(vInfo.message);
        return ;
    } else if(vInfo.code == 'L002') { // 휴면고객
        if(confirm(vInfo.message)) {
            fnUmbSleepRelease(vInfo.mcustNo); // 휴면해제
            return ;
        }
    } else if(vInfo.code == 'L004') { // 패스워드갱신대상
        // SSO토큰발급요청
        if(vInfo.succYn == 'Y') {
            $('#umbMbshNo', '#frmIntgLgin').val(vInfo.mcustNo);
            //console.log( "L004 권한코드 발급 완료 mcustNo : " + vInfo.mcustNo + "\nssoAuthMcustNo : " + vInfo.ssoAuthMcustNo + '\nssoAuthCd : ' + vInfo.ssoAuthCd);
            gfnReqSSoToknIssuHttp(vInfo.ssoAuthMcustNo, vInfo.ssoAuthCd, fnSsoToknPwdChgCallback);
        }
    } else if(vInfo.code == '1111') { // 통멤서버오류
        $('#umbMbshNo', '#frmIntgLgin').val(vInfo.mcustNo);
        fnLogin('INTG', $('#frmIntgLgin').serialize());
    } else {
        alert('처리중 오류가 발생하였습니다.');
    }
    
}

// 통합멤버쉽 휴면해제
function fnUmbSleepRelease(custNo) {
	$.ajax({
        url: ctx_curr + '/mm/mbshJoin/ReleaseSleepUmbMbsh.json',
        method: "post",
        data: {mcustNo : custNo},
        async: false,
        dataType : 'json',
        success : function(data, textStatus, jqXHR) {
            var vInfo = JSON.parse(data.info);

            if(vInfo.code == '0000') { // 성공
            	$('#umbMbshNo', '#frmIntgLgin').val(vInfo.mcustNo);
                //console.log( "휴면해제 0000 권한코드 발급 완료 mcustNo : " + vInfo.mcustNo + "\nssoAuthMcustNo : " + vInfo.ssoAuthMcustNo + '\nssoAuthCd : ' + vInfo.ssoAuthCd);
                gfnReqSSoToknIssuHttp(vInfo.ssoAuthMcustNo, vInfo.ssoAuthCd, fnSsoToknCallback);
            } else if(vInfo.code == 'L001') { // 로그인오류
                alert(vInfo.message);
                return ;
            } else if(vInfo.code == 'L004') { // 패스워드갱신대상
            	// SSO토큰발급요청
                if(vInfo.succYn == 'Y') {
                    $('#umbMbshNo', '#frmIntgLgin').val(vInfo.mcustNo);
                    //console.log( "휴면해제 L004 권한코드 발급 완료 mcustNo : " + vInfo.mcustNo + "\nssoAuthMcustNo : " + vInfo.ssoAuthMcustNo + '\nssoAuthCd : ' + vInfo.ssoAuthCd);
                    gfnReqSSoToknIssuHttp(vInfo.ssoAuthMcustNo, vInfo.ssoAuthCd, fnSsoToknPwdChgCallback);
                }
            } else {
                alert('처리중 오류가 발생하였습니다.');
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            alert('처리중 오류가 발생하였습니다.');
        }
    });
}

// SSO 토큰발급 콜백
function fnSsoToknCallback(data){
// 	console.log('fnSsoToknCallback : ' + JSON.stringify(data));
	
    if(data.succYn == 'Y') { // 발급성공
    	fnLogin('INTG', $('#frmIntgLgin').serialize());
    } else { // 발급실패
        alert('통합멤버쉽 로그인에 실패하였습니다.');
    }
}

// SSO 토큰발급 콜백(패스워드갱신대상)
function fnSsoToknPwdChgCallback(data){
//     console.log('fnSsoToknPwdChgCallback : ' + JSON.stringify(data));

//     alert("test fnSsoToknPwdChgCallback succYn : "+data.succYn);
    if(data.succYn == 'Y') { // 발급성공
    	// 통합멤버쉽패스워드갱신처리 (AS-IS)
//     	if(confirm('패스워드 사용 기간이 지났습니다. 패스워드 변경 후 이용 바랍니다.')) {
//             popOpen(gUmbMbshUrl + '/cu/mem/showCustInfo.shd', 'umbIndexPop', 800, 920);
//         }
        
        $("#pw_noti").dialog('open');
    } else { // 발급실패
        alert('통합멤버쉽 로그인에 실패하였습니다.');
    }
}

// SSO 인증 콜백
function fnSsoAuthCallback(data) {
//     console.log('fnSsoAuthCallback : ' + JSON.stringify(data));

    // 자동로그인
    if(data.succYn == 'Y') {
    	$('#umbMbshNo', '#frmIntgLgin').val(data.mcustNo);

    	var vData = $('#frmIntgLgin').serialize();
        vData += '&autoLoginYn=Y';

        fnLogin('INTG', vData);
    }
}

// 통합멤버쉽 간편가입팝업
function fnUmbSimpJoinPop(ssoMcustNo, joinType) {
	var $form = $('<form></form>');
    $form.attr('action', gUmbMbshUrl + '/cu/join/simpJoinStart.nhd');
    $form.attr('method', 'post');
    //$form.attr('target', 'umbSimpJoinPop');
    $form.append('<input type="hidden" value="D030" name="prtnrId">');
    $form.append('<input type="hidden" value="1201" name="chnnlId">');
    $form.append('<input type="hidden" value="' + ssoMcustNo + '" name="ssoMcustNo">');
    $form.append('<input type="hidden" value="PC" name="ptcoReqnMdaInf">');
    $form.append('<input type="hidden" value="' + joinType + '" name="ptcoReqnOnoflnGb">');
    $form.appendTo('body');

    //popOpen('', 'umbSimpJoinPop', 600, 800);
    $form.submit();
}
</script>
   <div class="pop_wrap"  > <h1 class="h1_type">로그인</h1>
        <div class="pop_content">
            <div class="tab_type01 two">
                <ul id="ulAucaType">
                    <li id="INTG"><a href="#;" class="hide_fix active" title="login01">H.Point통합회원</a></li>
                    <li id="GENE"><a href="#;" title="login02">면세점간편회원</a></li>
                </ul>
            </div>
            <!-- S : H.Point통합회원 -->
            <div class="tab_view_box block" id="login01" >
                <form id="frmIntgLgin" name="frmIntgLgin" method="post" action="" autocomplete="off">
                    <input type="hidden" name="aucaType" value="INTG" />
                    <input type="hidden" name="authType" value="INTG" /> <!-- 탭구분용 -->
                    <input type="hidden" id="umbMbshNo" name="umbMbshNo" value="" />
                    <input type="hidden" id="custPwd2" name="custPwd2" value="77LNW1" />
                    <input type="hidden" name="umbKkoSyncYn" value="" />
                    <div class="join_form">
                        <div class="join_row">
                            <input type="text" id="custId" name="custId" placeholder="아이디" onkeypress="javascript:noSpaceEvnt(event);" maxlength="20" style="ime-mode:inactive;" autocomplete="off">
                        </div>
                        <div class="join_row placeholder_wrap">
                            <input type="password" id="custPwd" name="custPwd" placeholder="비밀번호" onkeypress="javascript:noSpaceEvnt(event);" maxlength="100" autocomplete="off">
                        </div>
                    </div>
                    <div class="dang_type">
                        <p class="d_txt" id="pError" style="display:none;"></p>
                    </div>
                    <div class="id_save">
                        <span class="checkbox small">
                            <input type="checkbox" name="saveId" id="umbSaveId" value="Y">
                            <label for="umbSaveId">아이디 저장</label>
                        </span>
                        <span class="find_idpw">
                            <span class="ico_memb h_logo"><em class="hide">hpoint로고</em></span>
                            <a href="#;" id="aFindId">아이디찾기</a>
                            <a href="#;" id="aFindPwd">비밀번호찾기</a>
                        </span>
                    </div>
                    <div class="btn_login"><button type="button" class="btn_basic2 big" id="btnLgin1">로그인</button></div>
                </form>
                <div class="sns_type mgtsm">
	                <h2 class="f_size04 sns_title">SNS 간편로그인 연결</h2>
	                <ul>
	                    <li class="naver"><a href="javascript:snsLogin.naver.login()" class="ico_memb s_na2">네이버</a></li>
	                    <li class="facebook"><a href="javascript:snsLogin.facebook.login()" class="ico_memb s_fa2">페이스북</a></li>
	                    <li class="kakaotalk"><a href="javascript:kakaoLginUmbMbsh()" class="ico_memb s_ka2">H.Point 카카오</a></li>
	                </ul>
	                <form name="kakaoForm" action="" method="post">
                        <input type="hidden" id="prtnrId" name="prtnrId" value="D030"/>
                        <input type="hidden" id="chnnlId" name="chnnlId" value="1201"/>
                        <input type="hidden" id="kkoRetUrl" name="kkoRetUrl" value="https://www.hddfs.com/shop/mm/mbshJoin/kakaoLginUmbMbsh.do"/>
                    </form>
                </div>
                
            </div>
            <!-- E : H.Point통합회원 -->
            <!-- S : 면세점간편회원 -->
            <div class="tab_view_box" id="login02">
                <form id="frmGeneLgin" name="frmGeneLgin" method="post" action=""  autocomplete="off">
                    <input type="hidden" name="aucaType" value="GENE" />
                    <input type="hidden" name="authType" value="GENE" /> <!-- 탭구분용 -->
                    <div class="join_form">
                        <div class="join_row">
                            <input type="text" id="mbshId" name="mbshId" placeholder="아이디" onkeypress="javascript:noSpaceEvnt(event);" maxlength="20" autocomplete="off">
                        </div>
                        <div class="join_row placeholder_wrap">
                            <input type="password" id="mbshPwd" name="mbshPwd" placeholder="비밀번호" onkeypress="javascript:noSpaceEvnt(event);" maxlength="100" autocomplete="off">
                        </div>
                    </div>
                    <div class="dang_type">
                        <p class="d_txt" id="pError" style="display:none;"></p>
                    </div>
                    <div class="id_save">
                        <span class="checkbox small">
                            <input type="checkbox" name="saveId" id="saveId" value="Y">
                            <label for="saveId">아이디 저장</label>
                        </span>
                        <span class="find_idpw">
                            <a href="javascript:fnOpenerLocationClose('/mm/mbshAuca/membershipFindId.do');">아이디찾기</a>
                            <a href="javascript:fnOpenerLocationClose('/mm/mbshAuca/membershipFindPwd.do');">비밀번호찾기</a>
                        </span>
                    </div>
                    <div class="btn_login"><button type="button" class="btn_basic2 big" id="btnLgin2">로그인</button></div>
                </form>
                <div class="sns_type mgtsm">
                    <h2 class="f_size04 sns_title">SNS 간편로그인 연결</h2>
                    <ul>
                        <li class="naver"><a href="javascript:snsLogin.naver.login()" class="ico_memb s_na2">네이버</a></li>
                        <li class="facebook"><a href="javascript:snsLogin.facebook.login()" class="ico_memb s_fa2">페이스북</a></li>
                        <li class="kakaotalk"><a href="javascript:snsLogin.kakao.login()" class="ico_memb s_ka2">면세점 카카오</a></li>
                    </ul>
                </div>
                
            </div>
            <!-- E : 면세점간편회원 -->
            
            <div class="txt_btn tl">
                <p>회원가입 시 더 많은 혜택이 제공됩니다.<a href="javascript:fnOpenerLocationClose('/mm/mbshJoin/join.do');" class="btn_basic1">회원가입</a></p>
            </div>
            
            <div class="fix_btn two">
                <ul>
                    <li><a href="javascript:fnOpenerLocationClose('/or/order/listCart.do');" class="ico_coma i_link">비회원 주문</a></li><li><a href="https://www.hddfs.com/shop/mm/myOrder/searchNmbshOrder.do" class="ico_coma i_link">비회원 주문 조회</a></li>
                </ul>
            </div>
        </div>
    </div>

   <!-- S : dialog -->
   <div id="pw_error" title="로그인 안내"  > <div class="layer_popup">
           <div class="message_box">
               <!-- S : 2017-08-23 modify -->
               <p class="small_txt">동일 아이디로 비밀번호 5회 오류가 되어<br>로그인 제한되었습니다.</p>
               <!-- E : 2017-08-23 modify -->
           </div>
           <div class="basic_btn_box">
               <a href="javascript:fnOpenerLocationClose('/mm/mbshAuca/membershipFindId.do');" class="btn_basic1">아이디 찾기</a>
               <a href="javascript:fnOpenerLocationClose('/mm/mbshAuca/membershipFindPwd.do');" class="btn_basic1">비밀번호 찾기</a>
           </div>
       </div>
   </div>

   <div id="mem_error" title="로그인 안내"  > <input type="hidden" id="ssoMcustNo" name="ssoMcustNo" value="">
        <div class="layer_popup">
            <div class="message_box">
                <!-- S : 2017-08-23 modify -->
                <p class="small_txt">현대백화점인터넷면세점에 가입되지 않은<br>H.Point통합회원입니다.<br>H.Point 통합멤버십 페이지에서<br>현대백화점인터넷면세점 회원가입 하실 수 있습니다.</p>
                <!-- E : 2017-08-23 modify -->
            </div>
            <div class="basic_btn_box">
                <a href="#;" class="btn_basic1" id="btnUmbSimpleJoin">H.Point 통합멤버십 사이트 바로가기</a>
            </div>
        </div>
    </div>
    
    <div id="pw_noti" title="비밀번호 변경" style="display:none;">
        <div class="layer_popup">
            <div class="message_box">
                <p class="small_txt">통합멤버십 비밀번호 변경 대상 회원입니다.<br>비밀번호를 변경해주세요</p>
            </div>
            <div class="sh_btn_box">
                <button type="button" class="btn_basic1" id="umbMbshPwdChgExt">다음에 변경</button>
                <button type="button" class="btn_basic2" onclick="javascript:changeUmbPwd()">비밀번호 변경</button>
            </div>          
        </div>
    </div>
    <!-- E : dialog -->
<script>
var snsKey   = "18e3297260e3403e96a4f4db7b58f556";
</script>
<script src="https://cdn.hddfs.com/front/js/KO/crew/snsLogin.js"></script>

<script>
// 로그인 완료후의 액션 처리 - 동일액션에 여러군데에 존재해서 함수로 분리
function loginCallback(type, data){
	var redirectUrl = "https://www.hddfs.com/shop/dm/main.do".replace(/&amp;/gi, '&');
    if(redirectUrl.indexOf("token") != -1){
    	redirectUrl = redirectUrl.slice(0, redirectUrl.indexOf("&token"));
    }
    var orderYn     = "";
    
    if(crew.ajaxValidate(data, false)){ // 로그인 성공
        
    
        // ID 저장
        if(type == 'GENE') { // 면세점회원
        	// 입력된 ID값이 있을 경우만 처리(자동로그인 등의 케이스 제거)
        	if($('#mbshId', '#frmGeneLgin').val() != '') {
        		if($('#saveId', '#frmGeneLgin').prop('checked')) {
                    setCookie("GENE_SAVE_ID", $('#mbshId', '#frmGeneLgin').val());
                } else {
                    deleteCookie("GENE_SAVE_ID");
                }
        	}
        } else if(type == 'INTG') { // 통합회원
        	// 입력된 ID값이 있을 경우만 처리(자동로그인 등의 케이스 제거)
            if($('#custId', '#frmIntgLgin').val() != '') {
                if($('#umbSaveId', '#frmIntgLgin').prop('checked')) {
                    setCookie('INTG_SAVE_ID', $('#custId', '#frmIntgLgin').val());
                } else {
                    deleteCookie('INTG_SAVE_ID');
                }
            }
        }
        
        var adultType = "";
        var goosCds = new Array(); 
        var goosCd = "";
        var qtyList = "";
        var notAdtGoodsCd = "undefined";
        var notAdtQtyList = "undefined";
        var buyNow = "";
        var setGoosId = "";
        if(adultType != null && adultType != "" && adultType != "undefined"){
        	setCookie('ADULT_TYPE', adultType); 
        }
        
        if(goosCd != null && goosCd != "" && goosCd != "undefined"){
        	setCookie('ADULT_GOOSCD', goosCd);
        }
        
        if(qtyList != null && qtyList != "" && qtyList != "undefined"){
        	setCookie('ADULT_QTY', qtyList);
        }
        
        if(notAdtGoodsCd != null && notAdtGoodsCd != "" && notAdtGoodsCd != "undefined"){
        	setCookie('NOT_ADULT_GOOSCD', notAdtGoodsCd);
        }
        
        if(notAdtQtyList != null && notAdtQtyList != "" && notAdtQtyList != "undefined"){
        	setCookie('NOT_ADULT_QTY', notAdtQtyList);
        }
        
        if(setGoosId != null && setGoosId != "" && setGoosId != "undefined"){
        	setCookie('ADULT_SETID', setGoosId);
        }
        
        if(buyNow != null && buyNow != "" && buyNow != "undefined"){
        	setCookie('ADULT_BUYNOW', buyNow);
        }
        

    	// 메세지 처리
    	if(data.message != ""){
    		alert(data.message);
    	}

        // 창닫기 처리
        if(orderYn == "Y"){
        	opener.loginBuy();
        }else{
            if(redirectUrl != "") {
                //if(opener != null)
                    opener.location.href = redirectUrl;
                //else if(umbKkoSyncYn != null && umbKkoSyncYn == 'Y')
                	//location.href = redirectUrl;
            } else {
            	// 회원가입관련페이지들에서 로그인할 경우 메인으로 이동시키도록 url 설정
                var rtnVal = false;
                var arrJoinUrl = ["/mm/mbshJoin/join.do", "/mm/mbshJoin/termsAgree.do", "/mm/mbshJoin/authentication.do", "/mm/mbshJoin/mbshInformation", "/mm/mbshJoin/joinComplete.do"];

                for(var i = 0; i < arrJoinUrl.length; i++) {
                    if(opener.location.href.indexOf(arrJoinUrl[i]) != -1) {
                        rtnVal = true;
                        break;
                    }
                }

                if(rtnVal) {
                    opener.location.href = ctx_shop + '/dm/main.do';
                } else {
                	opener.location.reload();
                }
            }
        }

        self.close();
    } else { // 로그인 실패
        var vResultCode = data.resultCode;
        var vMessage = data.message;
        var vInfo = data.info;

        // 아이디, 비밀번호 초기화
        if(type == 'INTG') { // 통합멤버쉽
            $('#custId, #custPwd', '#frmIntgLgin').val('');
        } else if(type == 'GENE') { // 일반
            $('#mbshId, #mbshPwd', '#frmGeneLgin').val('');
        }

        // 100번 미만의 결과 코드는 일반 메세지임.
        if(vResultCode < 100){
            alert(vMessage);
            return;
        }

        // 100번 이상의 결과 코드를 기준으로 분기 처리
        if(vResultCode == 100) { // 계정잠금
            $("#pw_error").dialog("open");
            return ;
        } else if(vResultCode == 110){ // 휴면회원 해제
            //opener.location.href = ctx_curr + '/mm/mbshAuca/membershipSleepRelease.do?mbshNo=' + vInfo.mbshNo + '&redirectUrl=' + redirectUrl;
            opener.fnMbshSleepRelease(vInfo.mbshNo, vInfo.authType, redirectUrl);
        } else if(vResultCode == 120) { // 임시 비밀번호 변경 안내
            alert(vMessage);
        
            
            
            opener.location.href = ctx_curr + '/mm/myInfo/inptMbshPwd.do?type=pwd';
        } else if(vResultCode == 130) { // 비밀번호 장기 미변경
        	
            
            opener.location.href = ctx_curr + '/mm/mbshAuca/membershipChangePassword.do?redirectUrl=' + redirectUrl;
        } else if(vResultCode == 140) { // 불량회원 로그인
            alert('고객님의 계정은 사용이 일지중지되었습니다. 자세한 문의는 고객센터를 이용해주세요.\n문의전화 : 1811-6688');
        } else if(vResultCode == 150) { // 승급안내
        	
            
            location.href = ctx_curr + '/mm/mbshAuca/addLginBlank.do?resultCode=' + vResultCode + '&redirectUrl=' + redirectUrl;
            return ;
        } else if(vResultCode == 160 || vResultCode == 190) { // 비밀번호 불일치 & 기타
            $('#pError', '#frmGeneLgin').show().text(vMessage);
            return ;
        } else if(vResultCode == 170) { // 통합멤버쉽 참여사 미가입
            $('#mem_error').dialog('open');
            $('#ssoMcustNo', '#mem_error').val(vInfo.ssoMcustNo);
            return ;
        } else if(vResultCode == 180) { // SNS 로그인 실패
            alert(vMessage);
            return ;
        } else {
            alert('처리중 오류가 발생하였습니다.');
            return ;
        }

        self.close();
    }
}



// 페이스북 로그인 콜백 처리
function snsFBLogin(response){
    var data = { snsKey : snsKey, snsSimpJoinClsCd : "003", snsId : response.id, mailAddr : response.email, mbshNm : response.name, mbshBirtDt : "" }
    requestSnsLogin(data);
}

// 네이버 로그인 콜백 처리
function snsNVLogin(response){
    //var data = { snsKey : snsKey, snsSimpJoinClsCd : "001", snsId : response.id, mailAddr : response.email, mbshNm : response.name, mbshBirtDt : response.birthday }
    var data = { snsKey : snsKey, snsSimpJoinClsCd : "001", snsId : response.id, mailAddr : response.email, mbshNm : response.name, mbshBirtDt : "" }
    requestSnsLogin(data);
}


// 카카오 로그인 콜백 처리
function snsKOLogin(response){
    var data = { snsKey : snsKey, snsSimpJoinClsCd : "002", snsId : response.id, mailAddr : response.kaccount_email, mbshNm : response.properties.nickname, mbshBirtDt : "" }
    requestSnsLogin(data);
}


// SNS 로그인 요청
function requestSnsLogin(data){
    var vSnsSimpJoinClsCd = data.snsSimpJoinClsCd; // 간편가입구분코드(네이버, 카카오톡, 페이스북)
    
    // 전송
    $.ajax({
        async       : false,
        url         : ctx_curr + "/mm/mbshAuca/snsLogin.json",
        dataType    : "json",
        type        : "POST",
        data        : data,
        success     : function(data, textStatus, jqXHR){
            // 메일주소가 존재하는 경우와 존재하지 않는 경우의 이동 경로가 다름.
            if(data.info && data.info.checkYn){
                if(data.info.checkYn == "Y"){
                    opener.location.href = ctx_curr + "/mm/mbshJoin/snsJoin.do";
                }else{
                    opener.location.href = ctx_curr + "/mm/mbshJoin/snsJoinFail.do?snsSimpJoinClsCd=" + vSnsSimpJoinClsCd;
                }

                // 창닫기
                window.close();
                
            }else{
                loginCallback('SNS', data);
            }
        },
        error       : function(jqXHR, textStatus, errorThrown){
            //console.log(jqXHR.status);
        }
    });
}




function kakaoLginUmbMbsh(){
    var frm=document.kakaoForm;
    frm.kkoRetUrl.value = "https://www.hddfs.com/shop/mm/mbshJoin/kakaoLginUmbMbsh.do";
    frm.action="https://www.h-point.co.kr/api/login/kakaoLoginApi.nhd";
    frm.target="hpKkoLogin";
    frm.method="post";
    window.name = "opener.window.name"; 
    var ret = window.open('', 'hpKkoLogin', "width=430,height=650", false);
    frm.submit();
}


function changeUmbPwd(){
//     popOpen(gUmbMbshUrl + '/cu/mem/showCustInfo.shd', 'umbIndexPop', 800, 920);
    popOpen(gUmbMbshUrl + '/cu/login.nhd', 'umbIndexPop', 800, 920);
    $("#pw_noti").dialog('close');
    
}

</script>
<iframe id="hiddenifr" name="hiddenifr" src="" style="display: none"/>
</body>
</html>