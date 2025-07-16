<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>내 쪽지함</title>
    <c:import url="/WEB-INF/views/fragments/head.jsp" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<c:import url="/WEB-INF/views/header.jsp" />
<main class="container">
    <div class="card">
        <h1 class="card-title">받은 쪽지함</h1>
        <div class="table-container">
            <table class="board-table">
                <thead>
                <tr>
                    <th style="width: 15%;">보낸 사람</th>
                    <th>내용</th>
                    <th style="width: 20%;">받은 시간</th>
                    <th style="width: 10%;">상태</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="note" items="${allNotes}">
                    <tr>
                        <td><c:out value="${note.senderMbti}" /></td>
                        <td class="title">
                            <a href="javascript:void(0);" onclick="viewNote(${note.noteno}, true)">
                                <c:out value="${note.content}" />
                            </a>
                        </td>
                        <td><c:out value="${note.wrdate}" /></td>
                        <td>
                            <c:if test="${note.readCheck eq 'N'}">
                                <span style="color: red; font-weight: bold;">읽지 않음</span>
                            </c:if>
                            <c:if test="${note.readCheck eq 'Y'}">
                                <span>읽음</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <%-- [추가] 페이지네이션 --%>
        <div class="board-actions">
            <div class="pagination-wrapper">
                <div class="pagination">
                    <c:if test="${paging.prev}">
                        <button onClick="location.href='${pageContext.request.contextPath}/myNotes?page=1'">&lt;&lt;</button>
                        <button onClick="location.href='${pageContext.request.contextPath}/myNotes?page=${paging.beginPage - 1}'">&lt;</button>
                    </c:if>
                    <c:forEach begin="${paging.beginPage}" end="${paging.endPage}" var="index">
                        <c:choose>
                            <c:when test="${paging.page == index}">
                                <button class="btn-primary ${sessionScope.color}-bg" disabled>${index}</button>
                            </c:when>
                            <c:otherwise>
                                <button onClick="location.href='${pageContext.request.contextPath}/myNotes?page=${index}'">${index}</button>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${paging.next}">
                        <button onClick="location.href='${pageContext.request.contextPath}/myNotes?page=${paging.endPage + 1}'">&gt;</button>
                        <button onClick="location.href='${pageContext.request.contextPath}/myNotes?page=${paging.totalPage}'">&gt;&gt;</button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</main>
<c:import url="/WEB-INF/views/footer.jsp" />

<div id="noteModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index: 200;">
    <div style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); background:#fff; padding:30px; border-radius:12px; width:90%; max-width:500px;">
        <h3 id="modalSender"></h3>
        <p id="modalContent" style="margin-top:15px; min-height:100px;"></p>
        <div id="modalActions" style="text-align: right; margin-top: 20px; display: flex; gap: 10px; justify-content: flex-end;">
        </div>
    </div>
</div>

<script>
    function openNote(recipientId) {
        const url = `${pageContext.request.contextPath}/noteView?recipients=`+recipientId;
        window.open(url, 'noteWindow', 'width=500,height=550');
    }

    function viewNote(noteno, isFromMyNotesPage = false) {
        $.post("${pageContext.request.contextPath}/note/read", { noteno: noteno })
            .done(function(note) {
                $('#modalSender').text((note.senderMbti || '알 수 없음') + ' 님이 보낸 쪽지');
                $('#modalContent').text(note.content);

                const actionsDiv = $('#modalActions');
                actionsDiv.empty();

                const replyButton = $('<button></button>')
                    .addClass('btn btn-primary ${sessionScope.color}-bg')
                    .text('답장하기')
                    .on('click', function() {
                        openNote(note.memberMid);
                        $('#noteModal').hide();
                    });

                const closeButton = $('<button></button>')
                    .addClass('btn btn-secondary')
                    .text('닫기')
                    .on('click', function() {
                        $('#noteModal').hide();
                        if(isFromMyNotesPage) {
                            location.reload();
                        }
                    });

                actionsDiv.append(replyButton, closeButton);
                $('#noteModal').show();

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