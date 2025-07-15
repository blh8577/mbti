<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>게시판 - MBTI 커뮤니티</title>
	<c:import url="/WEB-INF/views/fragments/head.jsp" />
</head>
<body>
<c:import url="/WEB-INF/views/header.jsp"></c:import>
<main class="container">
	<div class="card">
		<h1 class="card-title">
			<c:choose>
				<c:when test="${cat eq 1}">RG 게시판</c:when>
				<c:when test="${cat eq 2}">RB 게시판</c:when>
				<c:when test="${cat eq 3}">LG 게시판</c:when>
				<c:when test="${cat eq 4}">LB 게시판</c:when>
				<c:otherwise>MBTI 게시판</c:otherwise>
			</c:choose>
		</h1>
		<h2 class="card-title" style="font-size: 18px; border: none;">인기 게시글</h2>
		<div class="table-container">
			<table class="board-table">
				<thead>
				<tr><th style="width: 50%;">제목</th><th>작성자</th><th>작성일</th><th>추천</th><th>조회</th></tr>
				</thead>
				<tbody>
				<c:forEach var="board" items="${popboardlist}">
					<tr>
						<td class="title"><a href="${pageContext.request.contextPath}/boardView?view=${board.boardno}"><c:out value="${board.title}" /></a></td>
						<td><a href="javascript:void(0);" onclick="openNote('${board.memberMid}')"><c:out value="${board.mbtiIdx}" /></a></td>
						<td><c:out value="${board.wrdate}" /></td>
						<td><c:out value="${board.recommendation}" /></td>
						<td><c:out value="${board.count}" /></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<h2 class="card-title" style="font-size: 18px; border: none; margin-top: 30px;">최근 게시글</h2>
		<div class="table-container">
			<table class="board-table">
				<thead>
				<tr><th style="width: 50%;">제목</th><th>작성자</th><th>작성일</th><th>추천</th><th>조회</th></tr>
				</thead>
				<tbody>
				<c:forEach var="board" items="${boardlist}">
					<tr>
						<td class="title"><a href="${pageContext.request.contextPath}/boardView?view=${board.boardno}"><c:out value="${board.title}" /></a></td>
						<td><a href="javascript:void(0);" onclick="openNote('${board.memberMid}')"><c:out value="${board.mbtiIdx}" /></a></td>
						<td><c:out value="${board.wrdate}" /></td>
						<td><c:out value="${board.recommendation}" /></td>
						<td><c:out value="${board.count}" /></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="board-actions">
			<div class="pagination-wrapper">
				<div class="pagination">
					<c:if test="${paging.prev}"><button onClick="location.href='${pageContext.request.contextPath}/board?page=1&cat=${cat}'">&lt;&lt;</button><button onClick="location.href='${pageContext.request.contextPath}/board?page=${paging.beginPage - 1}&cat=${cat}'">&lt;</button></c:if>
					<c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
						<c:choose>
							<c:when test="${paging.page == index}"><button class="btn-primary ${sessionScope.color}-bg" disabled>${index}</button></c:when>
							<c:otherwise><button onClick="location.href='${pageContext.request.contextPath}/board?page=${index}&cat=${cat}'">${index}</button></c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${paging.next}"><button onClick="location.href='${pageContext.request.contextPath}/board?page=${paging.endPage + 1}&cat=${cat}'">&gt;</button><button onClick="location.href='${pageContext.request.contextPath}/board?page=${paging.totalPage}&cat=${cat}'">&gt;&gt;</button></c:if>
				</div>
			</div>
			<div class="write-btn-wrapper">
				<a href="${pageContext.request.contextPath}/createBoard" class="btn btn-primary ${sessionScope.color}-bg">글쓰기</a>
			</div>
		</div>
	</div>
</main>
<c:import url="/WEB-INF/views/footer.jsp"></c:import>
<script>
	function openNote(recipientId) {
		const url = `${pageContext.request.contextPath}/noteView?recipients=` + recipientId;
		window.open(url, 'noteWindow', 'width=500,height=550');
	}
</script>
</body>
</html>