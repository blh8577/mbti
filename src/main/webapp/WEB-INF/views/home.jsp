<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>MBTI 커뮤니티</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <c:import url="/WEB-INF/views/fragments/head.jsp" />
</head>
<body>
<c:import url="/WEB-INF/views/header.jsp"></c:import>
<main class="container">
    <div class="home-grid">
        <div class="home-main-content">
            <div class="card">
                <h2 class="card-title">주간 인기글</h2>
                <div class="home-list">
                    <ul><c:import url="/latestBoard?homeboard=2"></c:import></ul>
                </div>
            </div>
            <div class="card">
                <h2 class="card-title">최신글</h2>
                <div class="home-list">
                    <ul><c:import url="/latestBoard?homeboard=1"></c:import></ul>
                </div>
            </div>
        </div>
        <aside class="home-side-content">
            <div class="card">
                <div class="my-info ${sessionScope.color}-bg">
                    <p class="mbti-name">${sessionScope.loginMember.mbtiIdx}</p>
                </div>
                <button class="btn btn-secondary" onClick="location.href='${pageContext.request.contextPath}/logout'">로그아웃</button>
            </div>
            <div class="card">
                <h2 class="card-title">전체 검색</h2>
                <form action="${pageContext.request.contextPath}/search" method="get" class="form-group">
                    <div class="input-with-btn">
                        <input type="text" name="search" placeholder="제목으로 검색">
                        <button type="submit" class="btn btn-primary ${sessionScope.color}-bg">검색</button>
                    </div>
                </form>
            </div>
            <%-- [추가] 쪽지 목록 영역 --%>
            <div class="card">
                <h2 class="card-title">받은 쪽지함</h2>
                <div class="home-list">
                    <ul>
                        <c:import url="/noteList"></c:import>
                    </ul>
                </div>
            </div>
        </aside>
    </div>
</main>
<c:import url="/WEB-INF/views/footer.jsp"></c:import>
<%-- 쪽지 내용 확인을 위한 모달(팝업) --%>
<div id="noteModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index: 200;">
    <div style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); background:#fff; padding:30px; border-radius:12px; width:90%; max-width:500px;">
        <h3 id="modalSender"></h3>
        <p id="modalContent" style="margin-top:15px; min-height:100px;"></p>
        <button onclick="$('#noteModal').hide()" style="float:right; margin-top:20px;" class="btn btn-secondary">닫기</button>
    </div>
</div>

<script>
    function viewNote(noteno, isFromMyNotesPage = false) {
        $.post("${pageContext.request.contextPath}/note/read", { noteno: noteno })
            .done(function(note) {
                // 모달 내용 채우기
                $('#modalSender').text(note.senderMbti + ' 님이 보낸 쪽지');
                $('#modalContent').text(note.content);
                $('#noteModal').show();

                // '내 쪽지함' 페이지가 아닐 때만 목록에서 제거
                if (!isFromMyNotesPage) {
                    $('#note-item-' + noteno).fadeOut();
                }
            })
            .fail(function() {
                alert("쪽지를 불러오는 데 실패했습니다.");
            });
    }
</script>
</body>
</html>