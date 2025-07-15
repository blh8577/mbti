<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%-- [수정] 이미 로그인한 사용자는 홈으로 리다이렉트 --%>
<c:if test="${not empty sessionScope.loginMember}">
    <c:redirect url="/home"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>로그인 - MBTI 커뮤니티</title>
    <c:import url="/WEB-INF/views/fragments/head.jsp" />
</head>
<body class="login-page-wrapper">
<div class="form-container">
    <div class="card login-card">
<%--        <div class="logo-area">--%>
<%--            <img src="${pageContext.request.contextPath}/img/main_logo.png" alt="메인 로고">--%>
<%--        </div>--%>
        <h1 class="form-title">MBTI 커뮤니티</h1>
        <p class="welcome-text">당신의 MBTI는 무엇인가요?<br>로그인하고 커뮤니티에 참여하세요!</p>
        <c:if test="${param.error != null}">
            <p style="color: red; text-align: center; margin-bottom: 15px;">아이디 또는 비밀번호가 올바르지 않습니다.</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn btn-primary blue-bg">로그인</button>
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/join'" class="btn btn-secondary">회원가입</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>