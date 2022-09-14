<!-- 22/09/12 김가희 생성 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<article>
	<h2>1:1 고객 게시판</h2>
	<form name="formm" method="post">
		<table id="csList">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>등록일</th>
				<th>답변 여부</th>
			</tr>
			<c:forEach items="${csList}" var="csVO">
				<tr>
					<td>${csVO.csNo}</td>
					<td><a href="DutyfreeServlet?command=cs_view&csNo=${csVO.csNo}">${csVO.csTitle} </td>
					<td><fmt:formatDate value="${csVO.csDate}" type="date" /></td>
					<td>
						<c:choose>
							<c:when test="${csVO.csCheck==0}"> 답변대기중 </c:when>
							<c:when test="${csVO.csCheck==1}"> 답변완료 </c:when>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="clear"></div>
	</form>
</article>