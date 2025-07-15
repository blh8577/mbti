<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>MBTI - <c:out value="${boardview.title}"/></title>
    <c:import url="/WEB-INF/views/fragments/head.jsp" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        function openNote(recipientId) {
            const url = `${pageContext.request.contextPath}/noteView?recipients=${recipientId}`;
            window.open(url, 'noteWindow', 'width=500,height=550');
        }
        $(document).ready(function() {
            $('.comment-textarea').on('keydown', function(e) {
                if (e.keyCode === 13 && !e.shiftKey) {
                    e.preventDefault();
                    $(this).closest('form').submit();
                }
            });
        });

        function reple_btn(ri) {
            $(".reply-form-wrapper").not(".rrd" + ri).hide();
            $(".rrd" + ri).fadeToggle();
        }

        function recommendation() {
            $.post("${pageContext.request.contextPath}/boardRecommendation?view=${boardview.boardno}", function(data) {
                if (data.result === 0) {
                    alert("추천했습니다!");
                    let currentCount = parseInt($('#board-rec-count').text());
                    $('#board-rec-count').text(currentCount + 1);
                } else {
                    alert("이미 추천한 게시물입니다.");
                }
            }).fail(function() {
                alert("로그인이 필요합니다.");
            });
        }

        function comrecommendation(commentno) {
            $.post("${pageContext.request.contextPath}/comRecommendation", { com: commentno }, function(data) {
                if (data.result === 0) {
                    alert("추천했습니다!");
                    let currentCount = parseInt($('#comment-rec-count-' + commentno).text());
                    $('#comment-rec-count-' + commentno).text(currentCount + 1);
                } else {
                    alert("이미 추천한 댓글입니다.");
                }
            }).fail(function() {
                alert("로그인이 필요합니다.");
            });
        }

        function deleteComment(commentno) {
            if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
                $.post("${pageContext.request.contextPath}/comment/delete", { commentno: commentno })
                    .done(function(data) {
                        alert(data.message);
                        location.reload();
                    })
                    .fail(function(xhr) {
                        alert(xhr.responseText);
                    });
            }
        }

    </script>
</head>
<body>
<c:import url="/WEB-INF/views/header.jsp" />
<main class="container">
    <div class="card">
        <div class="board-view-header">
            <h1><c:out value="${boardview.title}" /></h1>
            <div class="board-view-meta">
                <span><a href="javascript:void(0);" onclick="openNote('${board.memberMid}')">작성자: <c:out value="${boardview.mbtiIdx}" /></a></span>
                <span>작성일: <c:out value="${boardview.wrdate}" /></span>
                <span>추천수: <span id="board-rec-count"><c:out value="${boardview.recommendation}" /></span></span>
                <span>조회수: <c:out value="${boardview.count}" /></span>
            </div>
        </div>
        <div class="board-view-images">
            <c:forEach var="pic" items="${piclist}"><img alt="게시물 이미지" src="${pic.picturepath}"></c:forEach>
        </div>
        <div class="board-view-content">${boardview.content}</div>
        <div class="board-view-actions">
            <button onclick="recommendation()" class="btn btn-primary ${sessionScope.color}-bg">추천하기</button>
        </div>
        <div class="comment-section">
            <h2 class="card-title" style="font-size: 18px;">댓글</h2>
            <form action="${pageContext.request.contextPath}/commentInput" method="post" class="comment-form">
                <textarea name="content" class="comment-textarea" placeholder="댓글을 입력해주세요. (Shift+Enter로 줄바꿈)" required></textarea>
                <input type="hidden" name="boardBoardno" value="${boardview.boardno}"/>
                <input type="hidden" name="mgrno" value="0"/>
                <button type="submit" class="btn btn-primary ${sessionScope.color}-bg">등록</button>
            </form>
            <div class="comment-list">
                <c:forEach var="com" items="${comlist}" varStatus="s">
                    <div class="comment-item" style="padding-left: ${(com.level - 1) * 20}px;">
                        <div class="comment-header">
                            <span class="comment-author"><a href="javascript:void(0);" onclick="openNote('${board.memberMid}')"><c:out value="${com.mbtiIdx}"/></a></span>
                            <div class="comment-actions">
                                <c:if test="${com.viewcheck eq 'Y'}">
                                    <button onclick="comrecommendation(${com.commentno})">추천 <span id="comment-rec-count-${com.commentno}">${com.recommendation}</span></button>
                                    <button onclick="reple_btn(${s.count})">댓글달기</button>
                                    <c:if test="${sessionScope.loginMember.mid == com.memberMid}">
                                        <button onclick="deleteComment(${com.commentno})">삭제</button>
                                    </c:if>
                                </c:if>
                            </div>
                            <span class="comment-date"><c:out value="${com.wrdate}"/></span>
                        </div>
                        <div class="comment-body">
                            <c:choose>
                                <c:when test="${com.viewcheck eq 'N'}"><span style="color: #999;">삭제된 댓글입니다.</span></c:when>
                                <c:otherwise><c:out value="${com.content}"/></c:otherwise>
                            </c:choose>
                        </div>
                        <div class="reply-form-wrapper rrd${s.count}">
                            <form action="${pageContext.request.contextPath}/commentInput" method="post" class="comment-form">
                                <input type="hidden" name="mgrno" value="${com.commentno}"/>
                                <input type="hidden" name="boardBoardno" value="${boardview.boardno}"/>
                                <textarea name="content" class="comment-textarea" placeholder="대댓글을 입력해주세요."></textarea>
                                <button type="submit" class="btn btn-primary ${sessionScope.color}-bg">등록</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</main>
<c:import url="/WEB-INF/views/footer.jsp" />
</body>
</html>