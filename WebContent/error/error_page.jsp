<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../include/header.jsp"%>
-->
<!-- <button class="gnb_close">닫기</button>
	    </nav>
	</header>// header
	    container
		<main id="container"  class="container">
			<script type="text/javascript"> -->
<script type="text/javascript">
	$(function() {
		// 팝업일 경우 부모창에서 보여지고 팝업 호출한 페이지로 redirectUrl 설정
		if (opener != null) {
			var vOpenerUrl = opener.location.href;
			opener.location.href = '//www.hddfs.com/shop/mm/mbshAuca/addLginBase.do?redirectUrl='
					+ vOpenerUrl;
			self.close();
		}
	});
</script>

<!-- S : contents -->
<div class="container">
	<section>
		<div style="width: 100%; min-width: 1340px; padding-top: 121px;">
			<div class="error_box login_need">
				<p class="big_txt">
					<i class="ico_com ineed"></i>로그인이 필요한 서비스 입니다.
				</p>
				<p class="small_txt">로그인 후 이용해 주세요.</p>
				<a type="button" class="btn_basic2" href="DutyfreeServlet?command=login_form">로그인</a>
			</div>
		</div>
	</section>
</div>
<!-- E : contents -->
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
<footer id="footer">
	<div class="policy">
		<div class="box">
			<div class="policy_menu">
				<a href="https://www.hddfs.com/store/kr/dm/main.do" target="_blank">현대백화점 DUTY FREE 소개</a> <a href="https://www.hddfs.com/shop/om/consmCont/stoPtnsQust.do">입점/제휴</a> <a href="https://www.hddfs.com/shop/om/consmCont/selectMbshJoinTcnd.do?mbshJoinTcndCd=001">이용약관</a> <a href="https://www.hddfs.com/shop/om/consmCont/selectMbshJoinTcnd.do?mbshJoinTcndCd=008"> <strong>개인정보처리방침</strong>
				</a> <a href="https://www.hddfs.com/shop/om/consmCont/selectMbshJoinTcnd.do?mbshJoinTcndCd=005">영상정보처리기기 운영 / 관리방침</a> <a href="javascript:" onclick="popEmailReject();">이메일무단수집거부</a>
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
				<span onclick="moveToMain();" style="cursor: pointer;">HYUNDAI DEPARTMENT SHOP - DUTY FREE</span> <strong>주식회사 현대백화점면세점</strong>
			</div>
			<ul>
				<li><span>대표이사 : 이재실</span> <span>서울특별시 강남구 영동대로82길 19</span> <span>사업자등록번호 : 850-88-00325</span></li>
				<li><a href="http://www.ftc.go.kr/www/bizCommView.do?key=232&apv_perm_no=2018322016230202228&pageUnit=10&searchCnd=wrkr_no&searchKrwd=8508800325&pageIndex=1" target="_blank">사업자정보확인</a> <a href="javascript:" onclick="sellerInfo();">판매자별 사업자 정보</a></li>
				<li><span>통신판매업신고 : 2018-서울강남-02228</span> <span>개인정보보호책임자 : 반형철</span> <span>호스팅사업자 : (주)현대백화점면세점</span></li>
				<li><span>대표번호 : 1811-6688</span> <span>대표메일 : hddfs_official@hddfs.com</span></li>
			</ul>
			<p>COPYRIGHT © HYUNDAI DEPARTMENT STORE DUTY FREE. ALL RIGHTS RESERVED.</p>
			<div class="sns_link">
				<a href="https://www.facebook.com/HDDFS.official/" target="_blank" class="facebook">facebook</a> <a href="https://www.instagram.com/hddfs.official/" target="_blank" class="instagram">instagram</a>
			</div>
		</div>
		<div class="escrow">
			<strong>주식회사 케이에스넷 구매안전(에스크로) 서비스 가맹점</strong> <span> 안전한 전자상거래를 위해 ㈜ 케이에스넷의 구매안전(에스크로) 서비스에 <br> 가입하여, 구매안전(에스크로) 서비스를 제공하고 있습니다.
			</span>
			<p>주식회사 케이에스넷 금융감독원 결제대금예치업</p>
			<p>등록번호 : 02-006-00002</p>
			<a href="javascript:" onclick="popOpen('http://pgims.ksnet.co.kr/pg_infoc/src/dealinfo/pg_shop_info2.jsp?shop_id=2001106156', 'popEscrowNet', 750, 300);" class="btn_escrow">가입확인하기</a>
			<ul class="ismsp">
				<li>인증범위 : 현대백화점면세점 면세점 서비스 운영</li>
				<li>유효기간 : 2019.11.27~2022.11.26</li>
			</ul>
			<div class="award">
				<a href="http://www.i-award.or.kr/Smart/Assess/FinalCandidateView.aspx?REG_SEQNO=10902" target="_blank">스마트앱어워드 2021<br>디자인 이노베이션 대상
				</a>
			</div>
			<!--//award-->
			<div class="first">
				<a href="https://fba.kcforum.co.kr/2022/winner.php" target="_blank">2022 대한민국 퍼스트브랜드 대상<br>면세점 부문 대상
				</a>
			</div>
			<!--//first-->
		</div>
	</div>
</footer>

<!-- 판매자별 사업자 정보 -->
<div id="seller_information" title="판매자별 사업자 정보" style="display: none;">
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
</div>
</div>
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
	function closeMainLayer(popSeq) {
		$("#main_bottom_pop" + popSeq).remove();
		if ($(".main_popup").length < 1) {
			$('.modal_wrap').removeClass('active');
		}
	}

	// 메인레이어팝업 오늘하루 보지않기 + 쿠키저장
	function saveMainLayerCookie(popSeq) {

		// 쿠키 저장
		if ($("#btn_hidden_layer_" + popSeq).attr("hiddenYn") == 'N') {
			var date = new Date();
			date.setTime(date.getTime() + (1000 * 60 * 60 * 24));
			date.setHours(0);
			date.setMinutes(0);
			date.setSeconds(0);
			$.cookie("closePop" + popSeq, "Y", {
				expires : date,
				path : "/"
			});
			$("#main_bottom_pop" + popSeq).remove();
			if ($(".main_popup").length < 1) {
				$('.modal_wrap').removeClass('active');
			}
		}
	}

	function callMainPopSwiper() {

		var mainpopupswiper = new Swiper(
				'.popswiper-container',
				{
					slidesPerView : "auto",
					observer : true,
					observeParents : true,
					pagination : {
						el : '.swiper-pagination',
						type : 'custom',
						renderCustom : function(mainpopupswiper, current, total) {
							var customPaginationHtml = "";
							for (var i = 0; i < total; i++) {
								if (i == (current - 1)) {
									customPaginationHtml += '<span class="visual-pagination-customs visual-pagination-customs-active"></span>';
								} else {
									customPaginationHtml += '<span class="visual-pagination-customs"></span>';
								}
							}
							if (total < 10) {
								total = "0" + total
							}
							if (current < 10) {
								current = "0" + current
							}
							var fraction = current
									+ '<span class="space">/</span>'
									+ '<span class="num_total">' + total
									+ '</span>';
							return fraction;
						},
					},
					navigation : {
						nextEl : '.swiper-next',
						prevEl : '.swiper-prev',
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
				<li><a nohref id="chkBtn" value="" class="btnde_type1 mid bg_black" onclick="adultAuthPop(this);" data-setid="" data-cartseq="" data-cartsetid="" data-notAdtGoodsCd="" data-notAdtQtyList="">확인</a></li>
				<input type="hidden" id="goodsCd" value="" />
				<input type="hidden" id="qty" value="" />
				<input type="hidden" id="adtBuyNow" value="" />
			</ul>
		</div>
	</div>
	<div class="event_type_close">닫기</div>
</div>
<div id="layer_popup_adult" class="pop_o9_adult" title="성인인증" style="display: none">
	<div class="adult_popup">
		<strong class="tit">본 상품정보는 '청소년에게 유해한 정보'를 <br>포함하고 있기에 성인인증이 필요합니다.
		</strong>
		<ul>
			<li>본 정보 내용은 청소년 유해물건으로 청소년보호법의 규정에 의하여 만 19세 미만의 청소년이 이용할 수 없습니다.</li>
		</ul>

		<strong class="box"> 이용을 원하시면 로그인 후 <br>성인인증을 진행해주시기 바랍니다. <em>이 상품은 비회원 주문이 불가한 상품입니다.</em>
		</strong>
		<p>
			본인확인이 가능하지 않은 경우 <br>현대백화점면세점 고객센터로 연락주시기 바랍니다.
		</p>
		<a nohref id="hpAuth" value="" class="phonecertification_btn" data-goosCd="" data-qty="" data-buynow="" data-setid="" data-cartseq="" data-cartsetid="" data-notAdtGoodsCd="" data-notAdtQtyList=""> <span>휴대폰 인증</span>
		</a>

		<dl>
			<dt>유의사항</dt>
			<dd>휴대폰을 이용한 본인확인은 본인명의의 휴대전화로만 인증이 가능합니다.</dd>
		</dl>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {

		if (isLogin) {
			adultCallback();
		} else {
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
	$("#hpAuth").click(
			function() {
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

				openDRMOKWindow(type, goodsCd, qty, buynow, setGoosId, cartSeq,
						cartSetId, notAdtGoodsCd, notAdtQtyList);
			});

	$(".event_type_close").click(function() {
		$(this).parent().dialog("close");
	});

	$(".adultCancle").click(function() {
		$(this).closest(".pop_o8_adult").dialog("close");
	});

	/* 성인인증 팝업 */
	function openPopup(obj, type, goodsCd, qtyList, setGoosId, buyNow, cartSeq,
			cartSetId, notAdtGoodsCd, notAdtQtyList) {
		console.log('19세팝업 openPopup')
		console.log(goodsCd + '----' + qtyList);
		if (!isLogin) {
			login("", "", type, goodsCd, qtyList, setGoosId, buyNow,
					notAdtGoodsCd, notAdtQtyList);
			return false;
		}

		adultPopup(type, goodsCd, qtyList, buyNow, setGoosId, cartSeq,
				cartSetId, notAdtGoodsCd, notAdtQtyList);

	}

	function adultPopup(type, goodsCd, qtyList, buyNow, setGoosId, cartSeq,
			cartSetId, notAdtGoodsCd, notAdtQtyList) {

		console.log(type);
		console.log('19세팝업 adultPopup');
		console.log(goodsCd + '----' + qtyList);
		console.log(cartSeq);
		console.log(cartSetId);

		//$("#layer_default_adult").show();

		$(".pop_o8_adult").dialog({
			resizable : false,
			dialogClass : "event_type",
			width : 370,
			minHeight : 120,
			maxHeight : 600,
			modal : true
		});

		$("#chkBtn").attr("value", type);
		$("#chkBtn").closest('li').next().attr("value", goodsCd);
		$("#chkBtn").closest('li').next().next().attr("value", qtyList);
		$("#chkBtn").closest('li').next().next().next().attr("value", buyNow);
		$("#chkBtn").attr("data-setid", setGoosId);
		$("#chkBtn").attr("data-cartseq", cartSeq);
		$("#chkBtn").attr("data-cartsetId", cartSetId);
		$("#chkBtn").attr("data-notAdtGoodsCd", notAdtGoodsCd);
		$("#chkBtn").attr("data-notAdtQtyList", notAdtQtyList);
	}

	function adultAuthPop(obj) {

		console.log($(obj).attr('value'));

		$(".pop_o8_adult").dialog("close");

		$(".pop_o9_adult").dialog({
			//resizable: false,
			dialogClass : "pop_type1",
			width : 380,
			minHeight : 120,
			maxHeight : 600,
			modal : true
		});

		var goodsCd = $(obj).closest("li").next().attr("value");
		var qty = $(obj).closest("li").next().next().attr("value");
		var buyNow = $(obj).closest("li").next().next().next().attr("value");
		var setGoosId = $(obj).attr("data-setid");
		var cartSeq = $(obj).attr("data-cartseq");
		var cartSetId = $(obj).attr("data-cartsetId");
		var notAdtGoodsCd = $(obj).attr("data-notAdtGoodsCd");
		var notAdtQtyList = $(obj).attr("data-notAdtQtyList");

		$("#hpAuth").attr('value', $(obj).attr("value"));
		$("#hpAuth").attr('data-goosCd', goodsCd);
		$("#hpAuth").attr('data-qty', qty);
		$("#hpAuth").attr('data-buynow', buyNow);
		$("#hpAuth").attr('data-setid', setGoosId);
		$("#hpAuth").attr('data-cartseq', cartSeq);
		$("#hpAuth").attr('data-cartsetId', cartSetId);
		$("#hpAuth").attr('data-notAdtGoodsCd', notAdtGoodsCd);
		$("#hpAuth").attr('data-notAdtQtyList', notAdtQtyList);

	}

	function callback(obj) {
		console.log(obj);
		$(location).attr("href", obj);
	}

	function adultSuccessAlert() {

		setTimeout(function() {
			alert('정상적으로 처리되었습니다.'); // 정상적으로 처리되었습니다.
		}, 100);
	}

	function adultErrorAlert(obj) {

		setTimeout(function() {
			alert(obj);
		}, 100);
	}

	function closeAdultPopup() {
		$("#layer_popup_adult").dialog("close");
	}

	function removeAdult() {

		var goosCd = "";
		var minBuyQty = "";
		var url = "https://www.hddfs.com/shop";

		$.each($(".goosList"), function(i, el) {

			if ($(this).attr("data-adult") == "Y") {
				$(this).removeAttr("data-adult");
				$(this).removeAttr("adult");
				goosCd = $(this).attr("data-gooscd");
				minBuyQty = $(this).attr("data-minbuyqty");
				$(this).find('a').attr('onclick', '').unbind('click');
				$(this).find("a").attr("href",
						url + "/gd/dtl/goos.do?onlnGoosCd=" + goosCd);
				$(this).find('.cartBtn').attr(
						"onclick",
						'newAddCartMulti("' + goosCd + '", "' + minBuyQty
								+ '", "", "", "order","N",event)');
				$(this).find('.buyBtn').attr(
						"onclick",
						'newAddCartMulti("' + goosCd + '", "' + minBuyQty
								+ '", "", "", "order","Y",event)');
			}

		})

		$.each($(".goosLi"), function(i, el) {
			if ($(el).attr("data-adult") == "Y") {
				$(el).removeAttr("data-adult");
			}
		});
	}

	function openDRMOKWindow(type, goodsCd, qty, buynow, setGoosId, cartSeq,
			cartSetId, notAdtGoodsCd, notAdtQtyList) {

		/* 휴대폰 인증 관련 공지*/
		var url = "https://www.mobile-ok.com/popup/common/hscert.jsp";

		var DRMOK_window;

		var redirectUrl = "";
		if (type == "detail") {
			redirectUrl = "https://www.hddfs.com/shop/gd/dtl/goos.do?onlnGoosCd="
					+ goodsCd;
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
		DRMOK_window = window
				.open(
						url
								+ '?cpid=hddfs&rtn_url=http://www.hddfs.com/shop/mm/mbshAuca/adultAuca.do?goosInfo='
								+ goosInfo
								+ '&req_info=YDlATbpZdhqc%2B0%2B23KQhOKVGzEHufHOnQ10lf58ERTT1wVEU1xEgsnJXOPYEhD%2B3V8ANS7rZWFxKsGW0UN6MB5niF2HzqcOHzvs6WVSjg4yY5gEsBdC8z8SP2GestpFNEb5jSS8it%2FOCTtgqJdz0QimFn%2Fw3607n9g9FY0%2BkXyalUJRHjzro9Jx%2FbYs6Do%2BdK1N7vG4JiNhgirx3byeUvB66ZPruPAx8q4Tk431L6AxQSBvuRlRXw%2BdqgRfps3zXdFlpswtAyQADANRun8xUd1lxuIAOowdNO8Rg%2FmlJH5wJIkwu1jtl56cxCNcRqFJjSWnJs85F3cnnRbczYCyMjQ%3D%3D',
						'DRMOKWindow',
						'width=425,height=550,scrollbars=no,toolbar=no,location=no,directories=no,status=no');
		DRMOK_window.focus();

		if (DRMOK_window == null) {
			alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n 화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
		}
	}

	function reload() {
		location.reload();
	}

	function adultCallback() {

		var adultType = getCookie("ADULT_TYPE");
		var goosCd = getCookie("ADULT_GOOSCD");
		var qtyList = getCookie("ADULT_QTY");
		var notAdtGoodsCd = getCookie("NOT_ADULT_GOOSCD");
		var notAdtQtyList = getCookie("NOT_ADULT_QTY");
		var setGoosId = getCookie("ADULT_SETID");
		var buyNow = getCookie("ADULT_BUYNOW");

		// 메인 로그인 시 성인인증여부 검증용
		var mainAdultYn = "N";

		if ("N" == "N") {

			$.ajax({
				url : ctx_curr + "/cm/comm/mainAdultYn.json",
				async : false,
				dataType : "json",
				type : "POST",
				success : function(data, textStatus, jqXHR) {

					if (data.mainAdultYn == "Y") {
						mainAdultYn = "Y";
					}
				}
			});
		}

		if (adultType == "cart") {

			if ("N" == "Y" || mainAdultYn == "Y") {
				newAddCartMulti(goosCd, qtyList, '', '', 'order', buyNow);
			} else {
				adultPopup(adultType, goosCd, qtyList, buyNow);
			}
			deleteCookie("ADULT_TYPE");
		} else if (adultType == "detail") {
			if ("N" == "Y" || mainAdultYn == "Y") {
				location.href = ctx_curr + "/gd/dtl/goos.do?onlnGoosCd="
						+ goosCd;
			} else {
				adultPopup(adultType, goosCd, qtyList, buyNow);
			}
			deleteCookie("ADULT_TYPE");
		} else if (adultType == "list") {
			if ("N" == "Y" || mainAdultYn == "Y") {
				newAddCartMulti(goosCd, qtyList, '', '', 'order', buyNow);
			} else {
				adultPopup(adultType, goosCd, qtyList, buyNow, '', '', '',
						notAdtGoodsCd, notAdtQtyList);
			}
			deleteCookie("ADULT_TYPE");
		} else if (adultType == "set") {
			if ("N" == "Y" || mainAdultYn == "Y") {
				/* newAddCartMulti(onlnGoosCdList.join(","), goosQtyList.join(","), '', '', 'insert', 'Y', setGoosId); */
				newAddSetCartMulti(goosCd, qtyList, setGoosId, ''); //세트 장바구니 호출
			} else {
				adultPopup(adultType, goosCd, qtyList, buyNow, setGoosId, '',
						'', notAdtGoodsCd, notAdtQtyList);
			}
			deleteCookie("ADULT_TYPE");
		} else if (adultType == "cartList") { //HDDFS 리뉴얼 프로젝트 [ 김인호 - 2021.06.17 ] - 장바구니
			if ("N" == "Y" || mainAdultYn == "Y") {
				//goSelectedOrder();
				location.href = ctx_curr + "/or/order/order.do";
			} else {
				adultPopup(adultType, goosCd, qtyList, buyNow, '', '');
			}
		} else if (adultType == "cartGoosCdDetail") {
			if ("N" == "Y" || mainAdultYn == "Y") {
				location.href = ctx_curr + "/gd/dtl/goos.do?onlnGoosCd="
						+ goosCd;
			} else {
				adultPopup(adultType, goosCd, '', '');
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
		<img src="https://cdn.hddfs.com/front/images/KO/common/loading_apng.png" alt="">
	</div>
</div>
</body>
</html>