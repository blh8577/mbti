<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>쪽지 보내기</title>
    <c:import url="/WEB-INF/views/fragments/head.jsp" />
</head>
<body>
<main class="container form-page-wrapper" style="padding-top: 30px;">
    <div class="form-container">
        <div class="card">
            <h1 class="card-title">쪽지 보내기</h1>
            <form action="${pageContext.request.contextPath}/noteSend" method="post">
                <div class="form-group">
                    <label>받는 사람</label>
                    <input type="text" value="${recipientMbti}" disabled>
                    <input type="hidden" name="recipients" value="${recipients}">
                </div>
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" required></textarea>
                </div>
                <div class="form-actions" style="justify-content: flex-end;">
                    <button type="submit" class="btn btn-primary ${sessionScope.color}-bg">보내기</button>
                </div>
            </form>
        </div>
    </div>
</main>
</body>
</html>