<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>MBTI</title>
<link rel="stylesheet" href="./css.css">
</head>
<body>
	<!-- Header Section -->

	<c:import url="./header.jsp"></c:import>

	<!-- Content Section -->
	<section class="board_content_wrap">
		<div class="board_content_1000">
			<div class="board_content_list">

				<c:choose>
					<c:when test="${param.cat eq 1}">
						<MARQUEE>
							<h1>RG 게시판에 오신것을 환영합니다.</h1>
						</MARQUEE>
					</c:when>
					<c:when test="${param.cat eq 2}">
						<MARQUEE>
							<h1>RB 게시판에 오신것을 환영합니다.</h1>
						</MARQUEE>
					</c:when>
					<c:when test="${param.cat eq 3}">
						<MARQUEE>
							<h1>LG 게시판에 오신것을 환영합니다.</h1>
						</MARQUEE>
					</c:when>
					<c:when test="${param.cat eq 4}">
						<MARQUEE>
							<h1>LB 게시판에 오신것을 환영합니다.</h1>
						</MARQUEE>
					</c:when>
					<c:otherwise>
						<MARQUEE>
							<h1>MBTI 게시판에 오신것을 환영합니다.</h1>
						</MARQUEE>
					</c:otherwise>
				</c:choose>

				<div
					class="board_content_title <c:out value="${color}"/>_bottom <c:out value="${color}"/>_color">인기
					게시글</div>
				<div class="board_content_content">

					<table>
						<thead>
							<tr>
								<th width="60%">제목</th>
								<th width="10%">작성자</th>
								<th width="10%">작성일</th>
								<th width="10%">추천</th>
								<th width="10%">조회</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="board" items="${popboardlist}">   

 					<tr>
									<td><a
										href="boardView?view=<c:out value="${board.boardno}"/>"><c:out
												value="${board.title}" /></a></td>
									<td><a
										href="noteView?recipients=<c:out value="${board.member_mid}"/>"><c:out
												value="${board.mbti_idx}" /></a></td>
									<td><c:out value="${board.wrdate}" /></td>
									<td><c:out value="${board.recommendation}" /></td>
									<td><c:out value="${board.count}" /></td>
								</tr>

							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="board_content_new_list">
				<div
					class="board_content_title <c:out value="${color}"/>_bottom <c:out value="${color}"/>_color">최근
					게시글</div>
				<div class="board_content_content">
					<table>
						<thead>
							<tr>
								<th width="60%">제목</th>
								<th width="10%">작성자</th>
								<th width="10%">작성일</th>
								<th width="10%">추천</th>
								<th width="10%">조회</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="board" items="${boardlist}">   

 					<tr>
									<td><a
										href="boardView?view=<c:out value="${board.boardno}"/>"><c:out
												value="${board.title}" /></a></td>
									<td><a
										href="noteView?recipients=<c:out value="${board.member_mid}"/>"><c:out
												value="${board.mbti_idx}" /></a></td>
									<td><c:out value="${board.wrdate}" /></td>
									<td><c:out value="${board.recommendation}" /></td>
									<td><c:out value="${board.count}" /></td>
								</tr>

							</c:forEach>

						</tbody>
					</table>
				</div>


				<div class="write_btn_wrap">
					<button onclick="location.href='./createBoard.jsp'"
						class="<c:out value="${color}"/>_background">글쓰기</button>
				</div>


				<div class="page_number_wrap">
					<div class="page_number_center">
						<c:url var="board" value="./board"></c:url>
						<c:if test="${paging.prev}">
							<button
								onClick="location.href='${board}?page=1&cat=${param.cat}'">&lt;&lt;</button>
							<button
								onClick="location.href='${board}?page=${paging.beginPage-1}&cat=${param.cat}'">&lt;</button>
						</c:if>
						<c:forEach begin="${paging.beginPage}" end="${paging.endPage}"
							step="1" var="index">
							<c:choose>
								<c:when test="${paging.page==index}">
									<button class="<c:out value="${color}"/>_background">${index}</button>
								</c:when>
								<c:otherwise>
									<button
										onClick="location.href='${board}?page=${index}&cat=${param.cat}'">${index}</button>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${paging.next}">
							<button
								onClick="location.href='${board}?page=${param.page+1}&cat=${param.cat}'">&gt;</button>
							<button
								onClick="location.href='${board}?page=${paging.totalPage}&cat=${param.cat}'">&gt;&gt;</button>
						</c:if>
					</div>
				</div>


				<div class="search_wrap">
					<div>
						<form action="./search?cat=${param.cat}" method="post">
							<input type="text" name="search"
								class="<c:out value="${color}"/>_border"><input
								type="submit" value="검색"
								class="<c:out value="${color}"/>_background" />
						</form>
					</div>
				</div>


			</div>
		</div>
	</section>

	<!-- Footer Section -->

	<c:import url="./footer.jsp"></c:import>

</body>
</html>