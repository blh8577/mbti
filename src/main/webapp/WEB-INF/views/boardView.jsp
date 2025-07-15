<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<title>MBTI - <c:out value="${boardview.title}"/></title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainCss.css">
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
		function reple_btn(ri){
			// 모든 대댓글 입력창을 숨기고, 클릭한 것만 보여줌
			$(".board_view_reple_table .board_view_reple_input").css("display","none");
			$(".rrd"+ri).fadeIn();
		}

		// 아래 AJAX 함수들은 별도의 컨트롤러 구현이 필요합니다.
		function recommendation(){
			$.post("${pageContext.request.contextPath}/boardRecommendation?view=<c:out value="${param.view}"/>", function(data) {
				if (data == 0) {
					alert("추천했습니다!");
					// TODO: 추천 수를 실시간으로 업데이트하는 로직 추가
				} else {
					alert("이미 추천한 게시물입니다.");
				}
			});
		}

		function comrecommendation(com){
			$.post("${pageContext.request.contextPath}/comRecommendation" , { com : com }, function(data) {
				if (data == 0) {
					alert("추천했습니다!");
				} else {
					alert("이미 추천한 댓글입니다.");
				}
			});
		}
	</script>
</head>
<body>
<!-- Header Section -->
<c:import url="/WEB-INF/views/header.jsp"></c:import>

<!-- Content Section -->
<section class="board_view_wrap">
	<div class="board_view_1000">
		<div class="board_view_top <c:out value="${sessionScope.color}"/>_bottom">
			<p>제목 : <b><c:out value="${boardview.title}" /></b></p>
			<p><c:out value="${boardview.wrdate}" /></p>
			<p>추천수 : <c:out value="${boardview.recommendation}" /></p>
			<p>조회수 : <c:out value="${boardview.count}" /></p>
		</div>
		<div class="board_view_mid">
			<%-- 사진 목록이 있다면 표시 --%>
			<c:forEach var="pic" items="${piclist}">
				<img alt="게시물 이미지" src="${pageContext.request.contextPath}/${pic.picturepath}">
			</c:forEach>
		</div>
		<div class="board_view_bottom">
			<%-- HTML 태그가 포함될 수 있으므로 c:out을 사용하지 않거나 escapeXml="false" 사용 --%>
			${boardview.content}
		</div>
		<div class="board_view_recommend">
			<button onclick="recommendation()" class="<c:out value="${sessionScope.color}"/>_background">추천하기</button>
		</div>
		<div class="board_view_reple_wrap">
			<div class="board_view_reple_input">
				<form action="${pageContext.request.contextPath}/commentInput" method="post">
					<input type="text" name="content" placeholder="댓글을 입력해주세요.">
					<input type="hidden" name="view" value="<c:out value="${param.view}"/>"/>
					<input type="hidden" name="mgr" value="0"/>
					<input type="submit" value="등록" class="<c:out value="${sessionScope.color}"/>_background">
				</form>
			</div>
			<hr>
			<div class="board_view_reple_table">
				<table>
					<c:forEach var="com" items="${comlist}" varStatus="s">
						<c:choose>
							<c:when test="${com.level == 1}">
								<%-- 부모 댓글 --%>
								<tr>
									<td><a href="${pageContext.request.contextPath}/noteView?recipients=${com.memberMid}"><c:out value="${com.mbtiIdx}"/></a></td>
									<td>추천:<c:out value="${com.recommendation}"/></td>
									<td><button onclick="comrecommendation(<c:out value="${com.commentno}"/>)">추천</button></td>
									<td><button onclick="reple_btn(<c:out value="${s.count}"/>)">댓글달기</button></td>
									<td><c:out value="${com.wrdate}"/></td>
								</tr>
								<tr>
									<td colspan="5">
										<c:out value="${com.content}"/>
										<div class="board_view_reple_input rrd<c:out value="${s.count}"/>">
											<form action="${pageContext.request.contextPath}/commentInput" method="post">
												<input type="hidden" name="mgr" value="<c:out value="${com.commentno}"/>">
												<input type="hidden" name="view" value="<c:out value="${param.view}"/>"/>
												<input type="text" name="content" placeholder="대댓글을 입력해주세요.">
												<input type="submit" value="등록" class="<c:out value="${sessionScope.color}"/>_background">
											</form>
										</div>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<%-- 자식(대댓글) --%>
								<tr>
									<td width="10%" style="padding-left: 20px;">&rdca;</td>
									<td><a href="${pageContext.request.contextPath}/noteView?recipients=${com.memberMid}"><c:out value="${com.mbtiIdx}"/></a></td>
									<td>추천:<c:out value="${com.recommendation}"/></td>
									<td><button onclick="comrecommendation(<c:out value="${com.commentno}"/>)">추천</button></td>
									<td><c:out value="${com.wrdate}"/></td>
								</tr>
								<tr>
									<td></td>
									<td colspan="4" style="padding-left: 20px;"><c:out value="${com.content}"/></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</section>

<!-- Footer Section -->
<c:import url="/WEB-INF/views/footer.jsp"></c:import>
</body>
</html>