<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<c:choose>
    <c:when test="${not empty noteList}">
        <c:forEach var="note" items="${noteList}">
            <li id="note-item-${note.noteno}">
                <a href="javascript:void(0);" onclick="viewNote(${note.noteno})">
                    <span>
                        <strong><c:out value="${note.senderMbti}"/></strong> 님으로부터 온 쪽지
                    </span>
                    <span style="font-size: 0.85em; color: #999;"><c:out value="${note.wrdate}"/></span>
                </a>
            </li>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <li>새로운 쪽지가 없습니다.</li>
    </c:otherwise>
</c:choose>