<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>MBTI 커뮤니티</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainCss.css">
</head>
<body>
<section class="index_login_wrap">
    <div class="index_login_1000">
        <div class="index_logo_wrap">
            <img src="${pageContext.request.contextPath}/img/main_logo.png">
        </div>
        <div class="index_login_content_wrap">

            <c:if test="${param.error == 'true'}">
                <p style="color: red;">아이디 또는 비밀번호가 올바르지 않습니다.</p>
            </c:if>

            <%-- [핵심] action을 "/login"으로 변경 --%>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <table>
                    <tr>
                        <td>ID</td>
                        <%-- name="username"은 시큐리티 기본값 --%>
                        <td><input type="text" name="username" required></td>
                    </tr>
                    <tr>
                        <td>PW</td>
                        <%-- name="password"는 시큐리티 기본값 --%>
                        <td><input type="password" name="password" required></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <button type="submit">로그인</button>
                            <button type="button" onclick="location.href='/join'">회원가입</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</section>
</body>
</html>
