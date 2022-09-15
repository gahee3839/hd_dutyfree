<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>현대백화점인터넷면세점</title>
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/productdetail.css">
<link rel="stylesheet" href="https://cdn.hddfs.com/front/css/KO/product.css">

<%@ include file="../include/header.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(function() {
    $(window).scroll(function() {
        var WScrollTop = $(window).scrollTop();
        var val = $(document).height() - $(window).height() - $("#footer").outerHeight();
        var headerHeight = $('#header').height();


        $(".pd_visual").css('top', -WScrollTop + headerHeight)


        // if (WScrollTop >= headerHeight){
        //     $(".pd_visual").addClass("floor").css({top:""})
        // } else {
        //     $(".pd_visual").removeClass("floor").css({top:"121px"})
        // }

    })
});

</script>
<div style="width: 100%; min-width: 1340px; padding-top: 121px;">
	<body>
		<main id="container">
			<article id="content" class="productdetail">
				<section class="pd_area">
					<div class="pd_visual" style="top: 120.05px;">
						<div class="swiper-container swiper_visual">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<a href="javascript://">이미지 크게보기</a> <img src="https://cdn.hddfs.com/files/goos/0073/20220816/6530bf7f.png?sf=webp&amp;RS=460x460" alt="" onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/no_img500.jpg';" />
								</div>
							</div>
						</div>
						<div class="summary_info">
							<div class="tit">
								<p></p>
								<strong>레티놀 스킨 리뉴잉 데일리 마이크로 도스 트리트먼트 50ml</strong>
							</div>
							<div class="price">
								<span class="upto"> <i>45</i>%
								</span>
								<ul class="del">
									<li><del> $83</del> <del class="won"> 112,589원</del></li>
									<li><strong> $45.65</strong>
										<p>61,924원</p></li>
								</ul>
							</div>
							<div class="prd_no">
								<ul>
									<li><em>SKU NO</em>100732500166</li>
									<li><em>REF NO</em>S4536100</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="pd_info">
						<div class="purchase_benefits" style="margin-top: 120.05px;">
							<h4>구매혜택</h4>
							<ul class="con">
								<li><strong>
										<p>할인율</p>
										<div class="square_tooltip">
											<a href="javascript:" class="btn">도움말</a>
											<div class="tooltip">
												즉시 할인가가 적용 됩니다. * 아래 표기 된 할인률은 당사 및 브랜드사의 정책에 따라 브랜드별로 상이할 수 있습니다.
												<button class="close">닫기</button>
											</div>
										</div>
								</strong>
									<div class="box">할인율 : ???%</div></li>
							</ul>
						</div>

						<div class="productdetail_cart">
							<div class="selectlist">
								<div class="selectitem" data-id="10489260003401">
									<div class="box detailBox">
										<div class="num_amount">
											<input value="-" count_range="m" type="button" class="minus" onclick="changeGoosQty(this, 0, 'M','3','N')">
											<input type="number" class="count" id="0" value="1" min="1" max="110" onkeydown="return checkNumber(event);" onfocusout="return changeGoosList(this,event,'0','M','N');" onpaste="return false;">
											<input value="+" count_range="p" type="button" class="plus" onclick="changeGoosQty(this, 0, 'M','3','N')">
										</div>
										<dl class="priceInfo">
											<dt class="dorPrice0" value="72">$72</dt>
											<dd class="wonPrice0" value="98661">
												98,661<em>원</em>
											</dd>
										</dl>
									</div>
								</div>
							</div>
							<div class="totalamount">총금액</div>
						</div>
						<div class="button_area">
							<div class="square_tooltip maxprice">
								<%-- <button class="btnxl_type1 btnico btn_tooltip btn_view_rv" onclick="javascript:calcMaxDcPrc()">
									<em class="ico_sale">적립금 혜택 엿보기</em>
									<div class="info_reserve">적립금 혜택 엿보기</div><!--//2022-04-19 추가-->
								</button>--%>

								<div class="tooltip" id="maxSvmtInfoPop">
									<ul class="dl_price">
									</ul>
									<button class="close" onclick="closeMaxDcPrc();">닫기</button>
								</div>
							</div>
							<a href="javascript:addCarts('cart');" class="addcart">장바구니</a> <a href="javascript:addCarts('buy')" class="buynow">바로구매</a>
						</div>
						<ul class="layercall">
							<%--<li class="call_panel_b">
						<a href="javascript://" onclick="callGoosInfo('10073250016601','007301','00010102','');"><p>사은품</p><em>1</em></a>
					</li>--%>
							<li class="call_panel_c"><a href="javascript://" onclick="callGoosInfo('10073250016601','007301','00010102','');"><p>상품정보</p></a></li>
							<%-- <li class="call_panel_d">
					<a href="javascript://" onclick="callGoosInfo('10073250016601','007301','00010102','');">
						<p>추천상품</p></a>
				</li>--%>
							<li class="call_panel_e"><a href="javascript://" onclick="callGoosInfo('10073250016601','007301','00010102','');"><p>상품평</p></a></li>
						</ul>
					</div>
				</section>
			</article>
		</main>
		<%@ include file="../include/footer.jsp"%>
	</body>
</div>
</html>
