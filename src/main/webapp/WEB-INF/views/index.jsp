<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>MBTI</title>
    <link rel="stylesheet" href="css.css">
</head>
<body>
<section class="index_login_wrap">
    <div class="index_login_1000">
        <div class="index_logo_wrap">
            <img src="./img/main_logo.png">
        </div>
        <div class="index_login_content_wrap">
            <form action="./logincon" method="post">
                <table>
                    <tr>
                        <td width="40%">ID</td>
                        <td width="60%"><input type="text" name = "id" required></td>
                    </tr>
                    <tr>
                        <td>PW</td>
                        <td><input type="password" name = "pw" required></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="로그인"><input type="button" value="회원가입" onClick="location.href='join.jsp'"></td>
                    </tr>
                </table>

            </form>

        </div>
        <div>
</section>
</body>
</html>