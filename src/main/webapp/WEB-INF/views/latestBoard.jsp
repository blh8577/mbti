<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<c:if test="${not empty popBoard and empty latestBoard}">
<c:forEach var="board" items="${popBoard}">
 <li><a href="boardView?view=<c:out value="${board.boardno}"/>">&middot;<c:out value="${board.title}"/></a></li>
</c:forEach>
</c:if>

<c:if test="${not empty latestBoard}">
<c:forEach var="board" items="${latestBoard}">   
 <li><a href="boardView?view=<c:out value="${board.boardno}"/>">&middot;<c:out value="${board.title}"/></a></li>
</c:forEach>
</c:if>