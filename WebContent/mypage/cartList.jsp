<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../include/header.jsp"%>
<div style="width: 100%; min-width: 1340px; padding-top: 121px;">
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>현대백화점인터넷면서점</title>
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
    <script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/crew.source.js?ver=18"></script>
    <script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/form/form.source.js?ver=18"></script>
    <script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/crew/sns.js?ver=18"></script>
    <script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/jquery.cookie.js?ver=18"></script>
    <script type="text/javascript" src="https://cdn.hddfs.com/front/js/KO/common.js?ver=18"></script>
</head>

<body>
    <article id="content">

        <section class="cart_wrap">
            <ul class="title_tab">
                <li><a href="javascript:void(0);" onclick='goCartTab("CART");' class="on" id="tabCart">장바구니</a></li>
                <li>주문결제</li>
            </ul>
            <form name="formm" method="post">
                <c:choose>
                    <c:when test="${cartList.size() == 0 }">
                        <div class="cart_contens">
                            <div class="cont_left" id="CART">
                                <input type="hidden" id="cartListLength" value="0">
                                <input type="hidden" id="cartSetListLength" value="0">

                                <div class="no_cartitem">
                                    <img src="//www.hddfs.com/shop/images/KO/common/cart_default.png" alt="">
                                    <p>
                                        장바구니가 비어있습니다 :)
                                    </p>
                                </div>
                                <div class="cart_list">
                                </div>

                                <div class="attention_area">
                                    <p class="attention_tit">유의사항</p>
                                    <div class="attention_list">
                                        • 장바구니에 담긴 상품은 30일간 보관됩니다.(장기간 보관을 원하실 경우 관심상품으로 등록(180일간 저장)하여 이용하시길 바랍니다.)<br>
                                        • 환율 변경 시점과 적립금의 사용조건에 따라 장바구니의 예상결제금액과 최종결제금액은 상이할 수 있습니다.<br>
                                        • 실제 할인금액은 개인별로 보유하신 적립금에 따라 차이가 있을 수 있습니다.<br>
                                        • 장바구니에 보관된 상품은 재고품절 및 할인율, 사은품이 수시로 변경될 수 있습니다.<br>
                                        • 주문 전 기내반입제한 안내를 확인하시기 바랍니다.<br>
                                        • 상품별로 한 주문번호당 주문 가능 수량이 제한될 수 있습니다.<br>
                                        • 세트상품은 함께 사면 할인 혜택을 받을 수 있는 상품이며, 주문 후 매장에 따라 교환권이 각기 다르게 발급될 수 있습니다.
                                    </div>
                                </div>
                                <div id="changeSetGoosQtyList"></div>
                            </div>
                            <div class="cont_left" id="TAB" style=" display:  none;"></div>
                            <div class="cont_right" style="height: 0px;">
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="cart_contens">
                            <div class="cont_left" id="CART">
                                <input type="hidden" id="cartListLength" value="0"> <input type="hidden"
                                    id="cartSetListLength" value="0">

                                <div class="sorting_wrap">
                                    <div class="txt_total">
                                        <span class="chk nolabel">
                                        	<input type="checkbox" name="" id="cart_chk1"checked="checked">
                                        	<label for="cart_chk1">선택</label>
                                        </span>
                                        <div class="cartdel_btn">
                                            <a "onclick="go_cart_delete();">선택삭제</a>
                                        </div>
                                    </div>
                                    <div class="sort_r">
                                        <input type="hidden" id="lgcpBuyMbshGrpDtlCd" value="001"> <select name="cartCd"
                                            onchange="listCartAlin(this)" id="cartCd">
                                            <option value="001" selected="selected">수량순</option>
                                            <option value="002">높은금액순</option>
                                            <option value="003">낮은금액순</option>
                                        </select>
                                    </div>
                                </div>

                                <c:forEach items="${cartList}" var="cartVO">
                                    <div class="cart_list">
                                        <div class="item_area">
                                            <div class="item_chk">
                                                <span class="chk nolabel">
                                                	<input type="checkbox" name="cartSeq"
                                                        id="${cartVO.cDetailNo }" value="${cartVO.cDetailNo }"
                                                        class="cartSeqs" data-onlngooscd="${cartVO.pNo}"
                                                        data-idx="${cartVO.cDetailNo }" checked="">
                                                     <label for="${cartVO.cDetailNo }">선택</label>
                                                </span>
                                                <div class="btn_area">
                                                    <button class="btn_onoff btn_del"
                                                        onclick="go_cart_delete()">삭제</button>
                                                </div>
                                            </div>
                                            <div class="item_cont type_de">
                                                <div class="item_info_wrap">
                                                    <a href="DutyfreeServlet?command=product_detail&cseq=${cartVO.pNo}">
                                                        <div class="item_img">
                                                            <img src="${cartVO.pImage}" alt="${cartVO.pName}"
                                                                onerror="this.onerror=null; this.src='https://cdn.hddfs.com/front/images/KO/common/no_img252.jpg';">
                                                        </div>
                                                        <div class="item_title">
                                                            <strong>${cartVO.pBrand}</strong>
                                                            <span>${cartVO.pName}</span>
                                                        </div>
                                                        <del>$ ${cartVO.pPrice * cartVO.cDetailAmount}</del>
                                                        <p class="pay">
                                                            <strong>$
                                                            	${cartVO.pPrice * ((100 - cartVO.pDiscount)/100)*cartVO.cDetailAmount}                                                           	
                                                            </strong>
                                                            <span>
                                                            	<fmt:formatNumber value="${cartVO.pPrice * ((100 - cartVO.pDiscount)/100)*cartVO.cDetailAmount*1200}" type="currency"/>
                                                            </span>
                                                        </p>
                                                    </a>
                                                    <div class="item_sel"></div>
                                                </div>

                                                <div class="item_buy_wrap">
                                                    <div class="item_buy">
                                                        <div class="num_amount cart_amount">
                                                            <input value="-" type="button" disabled="disabled"
                                                                id="minGoosQty0"
                                                                onclick="changeGoosQty(439313808,'0','m',this, false);">
                                                            <input type="text" class="count" id="count0" value="1"
                                                                min="0" name="goosQty" maxlength="5"
                                                                onkeyup="isNumber(this);"
                                                                onfocusout="changeGoosQty(439313808,'0','c',this, false);">
                                                            <input value="+" type="button"
                                                                onclick="changeGoosQty(439313808,'0','p',this, false);">
                                                        </div>
                                                        <button type="button" class="btnde_type1 large"
                                                            onclick="">
                                                            <span class="font_14b">바로구매</span>
                                                        </button>
                                                    </div>
                                                </div>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="attention_area">
                                    <p class="attention_tit">유의사항</p>
                                    <div class="attention_list">
                                        • 장바구니에 담긴 상품은 30일간 보관됩니다.(장기간 보관을 원하실 경우 관심상품으로 등록(180일간 저장)하여 이용하시길 바랍니다.)
                                        <br>
                                        • 환율 변경 시점과 적립금의 사용조건에 따라 장바구니의 예상결제금액과 최종결제금액은 상이할 수 있습니다.
                                        <br>
                                        • 실제 할인금액은 개인별로 보유하신 적립금에 따라 차이가 있을 수 있습니다.
                                        <br>
                                        • 장바구니에 보관된 상품은 재고품절 및 할인율, 사은품이 수시로 변경될 수 있습니다.
                                        <br>
                                        • 주문 전 기내반입제한 안내를 확인하시기 바랍니다.
                                        <br>
                                        • 상품별로 한 주문번호당 주문 가능 수량이 제한될 수 있습니다.
                                        <br>
                                        • 세트상품은 함께 사면 할인 혜택을 받을 수 있는 상품이며, 주문 후 매장에 따라 교환권이 각기 다르게 발급될 수 있습니다.
                                    </div>
                                </div>
                                <div id="changeSetGoosQtyList"></div>
                            </div>
                            <div class="cont_left" id="TAB" style="display: none;"></div>

                            <div class="cont_left" id="TAB" style=" display:  none;"></div>
                            <div class="cont_right" style="height: 416px;">
                                <div class="pay_table">
                                    <div class="pay_tit">예상주문금액</div>
                                    <div class="pay_list">
                                        <dl>
                                            <dt>주문금액합계</dt>
                                            <dd>
                                                <strong class="totalGoosUsd">$
                                                	${totalCost}
                                                </strong>
                                                <span class="totalGoosKrw">
                                                	<fmt:formatNumber value="${totalCost2}" type="currency"/>원</span>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt>예상할인금액</dt>
                                            <dd>
                                                <strong class="sale totalDcUsd">$
                                                	${totalSale}
                                                </strong>
                                                <span class="sale totalDcKrw">
                                                	<fmt:formatNumber value="${totalSale2}" type="currency"/>
                                                원</span>
                                            </dd>
                                        </dl>
                                        <dl class="total_pay">
                                            <dt>총 <strong class="sumGoosQty">
                                            	<fmt:formatNumber value="${totalAmount}" type="currency"/>
                                            </strong>개</dt>
                                            <dd>
                                                <strong class="payTotalSettUsd">$
                                                	${totalPrice}
                                                </strong>
                                                <span class="payTotalSettKrw">
                                                	<fmt:formatNumber value="${totalPrice2}" type="currency"/>원
                                                </span>
                                            </dd>
                                        </dl>
                                    </div>
                                    <div class="pay_btm">
                                        <div class="pay_btns">
                                            <input type="hidden" id="aucaType" value="">
                                            <a href="javascript:void(0);" class="btnxl_type1"
                                                onclick="goOrder();">주문하기</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </form>
        </section>
    </article>
</body>

</html>