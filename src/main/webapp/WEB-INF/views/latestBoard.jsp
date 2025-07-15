<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 인기글 목록(popBoard)이 전달된 경우 --%>
<c:if test="${not empty popBoard}">
    <c:forEach var="board" items="${popBoard}">
        <li>
            <span style="font-weight: bold; color: #888; font-size: 0.9em;">
                [
                <c:choose>
                    <c:when test="${board.category == 1}">RG</c:when>
                    <c:when test="${board.category == 2}">RB</c:when>
                    <c:when test="${board.category == 3}">LG</c:when>
                    <c:when test="${board.category == 4}">LB</c:when>
                    <c:otherwise>MBTI</c:otherwise>
                </c:choose>
                ]
            </span>
            <a href="${pageContext.request.contextPath}/boardView?view=${board.boardno}">&middot; <c:out value="${board.title}"/></a>
        </li>
    </c:forEach>
</c:if>

<%-- 최신글 목록(latestBoard)이 전달된 경우 --%>
<c:if test="${not empty latestBoard}">
    <c:forEach var="board" items="${latestBoard}">
        <li>
                <%-- [수정] 최신글에도 카테고리 이름 표시 --%>
            <span style="font-weight: bold; color: #888; font-size: 0.9em;">
                [
                <c:choose>
                    <c:when test="${board.category == 1}">RG</c:when>
                    <c:when test="${board.category == 2}">RB</c:when>
                    <c:when test="${board.category == 3}">LG</c:when>
                    <c:when test="${board.category == 4}">LB</c:when>
                    <c:otherwise>MBTI</c:otherwise>
                </c:choose>
                ]
            </span>
            <a href="${pageContext.request.contextPath}/boardView?view=${board.boardno}">&middot; <c:out value="${board.title}"/></a>
        </li>
    </c:forEach>
</c:if>

<%-- 만약 데이터가 하나도 없는 경우 --%>
<c:if test="${empty popBoard and empty latestBoard}">
    <li>게시글이 없습니다.</li>
</c:if>