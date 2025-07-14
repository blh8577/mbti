<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>MBTI 커뮤니티 - 회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mainCss.css">
    <%-- jQuery CDN 로드 --%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        /* 메시지 스타일 */
        .message { font-size: 0.9em; margin-left: 10px; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
<section class="index_login_wrap">
    <div class="index_login_1000">
        <div class="index_logo_wrap">
            <a href="/index"><img src="${pageContext.request.contextPath}/img/main_logo.png"></a>
        </div>
        <div class="index_login_content_wrap">
            <%-- 폼 제출 시 validateForm() 함수를 먼저 실행합니다. --%>
            <form action="${pageContext.request.contextPath}/join" method="post" onsubmit="return validateForm();">

                <%-- 서버 측 유효성 검사 실패 시 에러 메시지 표시 --%>
                <c:if test="${param.error == 'true'}">
                    <p class="error">회원가입 중 오류가 발생했습니다. 이미 사용 중인 아이디일 수 있습니다.</p>
                </c:if>

                <table>
                    <tr>
                        <td width="30%">ID</td>
                        <td width="60%">
                            <%-- [수정] name을 MemberVO 필드명인 'mid'로 변경 --%>
                            <input type="text" id="mid" name="mid" placeholder="6~20자의 영문 소문자 또는 숫자" required>
                            <%-- 아이디 중복 확인 결과를 보여줄 영역 --%>
                            <span id="id-check-message" class="message"></span>
                        </td>
                        <td width="10%"><input type="button" value="중복검사" onclick="checkIdDuplicate()"></td>
                    </tr>
                    <tr>
                        <td>PW</td>
                        <%-- [수정] name을 MemberVO 필드명인 'mpw'로 변경 --%>
                        <td><input type="password" id="mpw" name="mpw" placeholder="8~16자의 영문+숫자 조합" required></td>
                    </tr>
                    <tr>
                        <td>PW 확인</td>
                        <td><input type="password" id="pw-check" name="pwcheck" required></td>
                    </tr>
                    <tr>
                        <td>MBTI</td>
                        <td>
                            <%-- [수정] name을 MemberVO 필드명인 'mbtiIdx'로 변경 --%>
                            <select name="mbtiIdx">
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
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <button type="submit">가입하기</button>
                            <button type="reset">다시쓰기</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</section>

<script>
    // [개선] 아이디 중복 확인 상태를 저장하는 변수
    // false: 확인 안됨, true: 확인 완료 및 사용 가능
    let isIdAvailable = false;
    // [개선] 중복 확인을 마친 아이디를 저장하는 변수
    let checkedId = "";

    // 아이디 입력 필드의 내용이 변경되면, 중복 확인 상태를 리셋
    $('#mid').on('input', function() {
        isIdAvailable = false;
        $('#id-check-message').text(''); // 메시지 초기화
    });

    // --- 정규식 함수 (기존 코드 유지) ---
    function isValidId(id) {
        const regExp = /^[a-z0-9]{6,20}$/;
        return regExp.test(id);
    }

    function isValidPw(pw) {
        const regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;
        return regExp.test(pw);
    }

    // --- [개선] 아이디 중복 확인 AJAX 함수 ---
    function checkIdDuplicate() {
        const mid = $('#mid').val();
        const messageSpan = $('#id-check-message');

        if (!isValidId(mid)) {
            messageSpan.text("아이디는 6~20자의 영문 소문자/숫자여야 합니다.").removeClass('success').addClass('error');
            isIdAvailable = false;
            return;
        }

        // GET 방식으로 API 호출
        $.ajax({
            type: 'GET',
            url: '/api/members/check-id', // [수정] RESTful API URL
            data: { mid: mid },
            success: function(response) {
                // [수정] JSON 응답 처리
                if (response.isDuplicate) {
                    messageSpan.text("이미 사용 중인 아이디입니다.").removeClass('success').addClass('error');
                    isIdAvailable = false;
                } else {
                    messageSpan.text("사용 가능한 아이디입니다.").removeClass('error').addClass('success');
                    isIdAvailable = true;
                    checkedId = mid; // 확인 완료된 아이디 저장
                }
            },
            error: function() {
                messageSpan.text("중복 확인 중 오류가 발생했습니다.").removeClass('success').addClass('error');
                isIdAvailable = false;
            }
        });
    }

    // --- [개선] 폼 제출 전 유효성 검사 함수 ---
    function validateForm() {
        const mid = $('#mid').val();
        const mpw = $('#mpw').val();
        const pwCheck = $('#pw-check').val();

        if (!isValidId(mid)) {
            alert("아이디는 6~20자의 영문 소문자 또는 숫자여야 합니다.");
            $('#mid').focus();
            return false; // 폼 제출 중단
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

        // [개선] 중복 확인 후 아이디를 변경했는지 검사
        if (mid !== checkedId) {
            alert("아이디 중복 확인 후 아이디를 변경했습니다. 다시 중복 확인을 해주세요.");
            isIdAvailable = false;
            $('#id-check-message').text('');
            return false;
        }

        // 모든 검사를 통과하면 폼 제출 허용
        return true;
    }
</script>

</body>
</html>