<!-- 22/09/13 김가희 생성 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<article>
	<h2>상품관리</h2>
	<form name="formm" method="post">
		<table id="csList" border="1">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>브랜드</th>
				<th>카테고리</th>
				<th>정가</th>
				<th>할인율</th>
				<th>재고량</th>
				<th>제품등록일</th>
			</tr>
			<c:forEach items="${pList}" var="prodVO">
				<tr>
					<td>${prodVO.pNo}</td>
					<td>${prodVO.pName}</td>
					<td>${prodVO.pBrand}</td>
					<td>${prodVO.pCategory}</td>
					<td>${prodVO.pPrice}</td>
					<td>${prodVO.pDiscount}</td>
					<td>${prodVO.pStock}</td>
					<td>${prodVO.pRegdate}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="clear"></div>
	</form>
</article>