<!-- 22/09/12 김가희 생성 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<article>
	<h2>회원조회</h2>
	<form name="formm" method="post">
		<table id="memTable">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>가입일</th>
				<th>핸드폰번호</th>
			</tr>
			<c:forEach items="${memList}" var="memVO">
				<tr>
					<td>${memVO.memId}</td>
					<td>${memVO.memName}</td>
					<td><fmt:formatDate value="${memVO.memRegDate}" type="date" /></td>
					<td>${memVO.memPhone}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="clear"></div>
	</form>
</article>