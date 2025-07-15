<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 인기글 목록(popBoard)이 전달된 경우 --%>
<c:if test="${not empty popBoard}">
    <c:forEach var="board" items="${popBoard}">
        <li><a href="${pageContext.request.contextPath}/boardView?view=${board.boardno}">&middot; <c:out value="${board.title}"/></a></li>
    </c:forEach>
</c:if>

<%-- 최신글 목록(latestBoard)이 전달된 경우 --%>
<c:if test="${not empty latestBoard}">
    <c:forEach var="board" items="${latestBoard}">
        <li><a href="${pageContext.request.contextPath}/boardView?view=${board.boardno}">&middot; <c:out value="${board.title}"/></a></li>
    </c:forEach>
</c:if>

<%-- 만약 데이터가 하나도 없는 경우 --%>
<c:if test="${empty popBoard and empty latestBoard}">
    <li>게시글이 없습니다.</li>
</c:if>