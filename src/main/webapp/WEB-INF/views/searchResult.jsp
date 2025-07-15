<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>검색 결과 - MBTI 커뮤니티</title>
    <c:import url="/WEB-INF/views/fragments/head.jsp" />
</head>
<body>
<c:import url="/WEB-INF/views/header.jsp"></c:import>
<main class="container">
    <div class="card">
        <h1 class="card-title">'${keyword}'에 대한 검색 결과</h1>
        <div class="table-container">
            <table class="board-table">
                <thead>
                <tr><th style="width: 50%;">제목</th><th>작성자</th><th>작성일</th><th>추천</th><th>조회</th></tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty boardlist}">
                        <c:forEach var="board" items="${boardlist}">
                            <tr>
                                <td class="title">
                                            <span style="font-weight: bold; color: #888;">
                                            [<c:choose>
                                                <c:when test="${board.category == 1}">RG</c:when>
                                                <c:when test="${board.category == 2}">RB</c:when>
                                                <c:when test="${board.category == 3}">LG</c:when>
                                                <c:when test="${board.category == 4}">LB</c:when>
                                                <c:otherwise>MBTI</c:otherwise>
                                            </c:choose>]
                                            </span>
                                    <a href="${pageContext.request.contextPath}/boardView?view=${board.boardno}"><c:out value="${board.title}" /></a>
                                </td>
                                <td><c:out value="${board.mbtiIdx}" /></td>
                                <td><c:out value="${board.wrdate}" /></td>
                                <td><c:out value="${board.recommendation}" /></td>
                                <td><c:out value="${board.count}" /></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr><td colspan="5">검색 결과가 없습니다.</td></tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <div class="board-actions">
            <div class="pagination-wrapper">
                <div class="pagination">
                    <c:if test="${paging.prev}"><button onClick="location.href='${pageContext.request.contextPath}/search?page=1&cat=${cat}&search=${keyword}'">&lt;&lt;</button><button onClick="location.href='${pageContext.request.contextPath}/search?page=${paging.beginPage - 1}&cat=${cat}&search=${keyword}'">&lt;</button></c:if>
                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                        <c:choose>
                            <c:when test="${paging.page == index}"><button class="btn-primary ${sessionScope.color}-bg" disabled>${index}</button></c:when>
                            <c:otherwise><button onClick="location.href='${pageContext.request.contextPath}/search?page=${index}&cat=${cat}&search=${keyword}'">${index}</button></c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${paging.next}"><button onClick="location.href='${pageContext.request.contextPath}/search?page=${paging.endPage + 1}&cat=${cat}&search=${keyword}'">&gt;</button><button onClick="location.href='${pageContext.request.contextPath}/search?page=${paging.totalPage}&cat=${cat}&search=${keyword}'">&gt;&gt;</button></c:if>
                </div>
            </div>
        </div>
    </div>
</main>
<c:import url="/WEB-INF/views/footer.jsp"></c:import>
</body>
</html>