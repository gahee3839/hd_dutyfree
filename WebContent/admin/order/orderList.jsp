<!-- 22/09/12 김가희 생성 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<article>
	<h2>주문조회</h2>
	<form name="formm" method="post">
		<table id="memTable">
			<tr>
				<th>주문번호</th>
				<th>주문상세번호</th>
				<th>상품명</th>
				<th>주문수량</th>
				<th>가격</th>
				<th>상태</th>
				<th>주문일시</th>
				<th>주문자</th>
			</tr>
			<c:forEach items="${orderList}" var="orderVO">
				<tr>
					<td>${orderVO.oNo}</td>
					<td>${orderVO.odNo}</td>
					<td>${orderVO.pName}</td>
					<td>${orderVO.odAmount}</td>
					<td>${orderVO.pPrice}</td>
					<td>
						<c:choose>
							<c:when test="${orderVO.oShipping==0}"> 상품준비중 </c:when>
							<c:when test="${orderVO.oShipping==1}"> 인도장 </c:when>
							<c:when test="${orderVO.oShipping==2}"> 인도완료 </c:when>
						</c:choose>
					</td>
					<td><fmt:formatDate value="${orderVO.oDate}" type="date" /></td>
					<td>${orderVO.mId}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="clear"></div>
	</form>
</article>