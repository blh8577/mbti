<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입 - MBTI 커뮤니티</title>
    <c:import url="/WEB-INF/views/fragments/head.jsp" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<%-- [수정] 헤더를 불러오기 전에 페이지 타입을 설정합니다. --%>
<c:set var="pageType" value="simple" scope="request" />
<c:import url="/WEB-INF/views/header.jsp" />

<main class="container form-page-wrapper">
    <div class="form-container">
        <div class="card">
            <h1 class="card-title">회원가입</h1>
            <form action="${pageContext.request.contextPath}/join" method="post" onsubmit="return validateForm();">
                <div class="form-group">
                    <label for="mid">아이디</label>
                    <div class="input-with-btn">
                        <input type="text" id="mid" name="mid" placeholder="6~20자의 영문 소문자 또는 숫자" required>
                        <button type="button" class="btn btn-secondary" onclick="checkIdDuplicate()">중복확인</button>
                    </div>
                    <div id="id-check-message" class="message"></div>
                </div>
                <div class="form-group">
                    <label for="mpw">비밀번호</label>
                    <input type="password" id="mpw" name="mpw" placeholder="8~16자의 영문과 숫자 조합" required>
                </div>
                <div class="form-group">
                    <label for="pw-check">비밀번호 확인</label>
                    <input type="password" id="pw-check" name="pwcheck" required>
                </div>
                <div class="form-group">
                    <label for="mbtiIdx">MBTI</label>
                    <select id="mbtiIdx" name="mbtiIdx">
                        <option value="INTJ">INTJ</option>
                        <option value="INTP">INTP</option>
                        <option value="INFJ">INFJ</option>
                        <option value="INFP">INFP</option>
                        <option value="ISTJ">ISTJ</option>
                        <option value="ISTP">ISTP</option>
                        <option value="ISFJ">ISFJ</option>
                        <option value="ISFP">ISFP</option>
                        <option value="ENTJ">ENTJ</option>
                        <option value="ENTP">ENTP</option>
                        <option value="ENFJ">ENFJ</option>
                        <option value="ENFP">ENFP</option>
                        <option value="ESTJ">ESTJ</option>
                        <option value="ESTP">ESTP</option>
                        <option value="ESFJ">ESFJ</option>
                        <option value="ESFP">ESFP</option>
                    </select>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary blue-bg">가입하기</button>
                </div>
            </form>
        </div>
    </div>
</main>

<c:import url="/WEB-INF/views/footer.jsp" />

<script>
    let isIdAvailable = false;
    let checkedId = "";

    $('#mid').on('input', function() {
        isIdAvailable = false;
        $('#id-check-message').text('');
    });

    function isValidId(id) {
        const regExp = /^[a-z0-9]{6,20}$/;
        return regExp.test(id);
    }

    function isValidPw(pw) {
        const regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;
        return regExp.test(pw);
    }

    function checkIdDuplicate() {
        const mid = $('#mid').val();
        const messageDiv = $('#id-check-message');

        if (!isValidId(mid)) {
            messageDiv.text("아이디는 6~20자의 영문 소문자/숫자여야 합니다.").removeClass('success').addClass('error');
            isIdAvailable = false;
            return;
        }

        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/api/members/check-id',
            data: { mid: mid },
            success: function(response) {
                if (response.isDuplicate) {
                    messageDiv.text("이미 사용 중인 아이디입니다.").removeClass('success').addClass('error');
                    isIdAvailable = false;
                } else {
                    messageDiv.text("사용 가능한 아이디입니다.").removeClass('error').addClass('success');
                    isIdAvailable = true;
                    checkedId = mid;
                }
            },
            error: function() {
                messageDiv.text("중복 확인 중 오류가 발생했습니다.").removeClass('success').addClass('error');
                isIdAvailable = false;
            }
        });
    }

    function validateForm() {
        const mid = $('#mid').val();
        const mpw = $('#mpw').val();
        const pwCheck = $('#pw-check').val();

        if (!isValidId(mid)) {
            alert("아이디는 6~20자의 영문 소문자 또는 숫자여야 합니다.");
            $('#mid').focus();
            return false;
        }
        if (!isValidPw(mpw)) {
            alert("비밀번호는 8~16자의 영문과 숫자 조합이어야 합니다.");
            $('#mpw').focus();
            return false;
        }
        if (mpw !== pwCheck) {
            alert("비밀번호가 일치하지 않습니다.");
            $('#pw-check').focus();
            return false;
        }
        if (!isIdAvailable) {
            alert("아이디 중복 확인을 해주세요.");
            return false;
        }
        if (mid !== checkedId) {
            alert("아이디 중복 확인 후 아이디를 변경했습니다. 다시 중복 확인을 해주세요.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>