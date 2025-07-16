<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${roomTitle} - MBTI 커뮤니티</title>
    <c:import url="/WEB-INF/views/fragments/head.jsp" />
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        .chat-window { height: 60vh; border: 1px solid #ddd; overflow-y: scroll; padding: 20px; margin-bottom: 20px; background: #fff; }
        .chat-message { margin-bottom: 15px; display: flex; flex-direction: column; }
        .chat-message.mine { align-items: flex-end; }
        .chat-message.others { align-items: flex-start; }
        .message-bubble { display: inline-block; max-width: 70%; padding: 10px 15px; border-radius: 18px; word-break: break-all; color: #333; }
        .message-bubble.mine { color: #fff; } /* 내 메시지 버블의 글자색은 항상 흰색 */
        .message-sender { font-size: 0.9em; font-weight: 700; margin-bottom: 5px; }
        .chat-input-form { display: flex; gap: 10px; }
        .chat-input-form input { flex-grow: 1; height: 48px; }
    </style>
</head>
<body>
<c:import url="/WEB-INF/views/header.jsp" />
<main class="container">
    <div class="card">
        <h1 class="card-title">${roomTitle}</h1>
        <div class="chat-window" id="chat-window">
            <%-- 기존 메시지 출력 --%>
            <c:forEach var="chat" items="${chatHistory}">
                <c:set var="isMine" value="${chat.memberMid == sessionScope.loginMember.mid}" />
                <c:set var="bubbleColor" value="others" />
                <c:if test="${isMine}">
                    <c:set var="bubbleColor" value="mine ${sessionScope.color}-bg" />
                </c:if>
                <c:if test="${not isMine}">
                    <c:choose>
                        <c:when test="${chat.mbtiIdx.startsWith('I') and (chat.mbtiIdx.endsWith('TJ') or chat.mbtiIdx.endsWith('TP'))}">
                            <c:set var="bubbleColor" value="others pink-bg" />
                        </c:when>
                        <c:when test="${chat.mbtiIdx.startsWith('I') and (chat.mbtiIdx.endsWith('FJ') or chat.mbtiIdx.endsWith('FP'))}">
                            <c:set var="bubbleColor" value="others green-bg" />
                        </c:when>
                        <c:when test="${chat.mbtiIdx.startsWith('E') and (chat.mbtiIdx.endsWith('TJ') or chat.mbtiIdx.endsWith('TP'))}">
                            <c:set var="bubbleColor" value="others pink-bg" />
                        </c:when>
                        <c:when test="${chat.mbtiIdx.startsWith('E') and (chat.mbtiIdx.endsWith('FJ') or chat.mbtiIdx.endsWith('FP'))}">
                            <c:set var="bubbleColor" value="others green-bg" />
                        </c:when>
                        <c:when test="${chat.mbtiIdx.startsWith('I') and (chat.mbtiIdx.endsWith('SJ') or chat.mbtiIdx.endsWith('SP'))}">
                            <c:set var="bubbleColor" value="others blue-bg" />
                        </c:when>
                        <c:when test="${chat.mbtiIdx.startsWith('E') and (chat.mbtiIdx.endsWith('SJ') or chat.mbtiIdx.endsWith('SP'))}">
                            <c:set var="bubbleColor" value="others yellow-bg" />
                        </c:when>
                    </c:choose>
                </c:if>

                <div class="chat-message ${isMine ? 'mine' : 'others'}">
                    <div class="message-sender">${chat.mbtiIdx}</div>
                    <div class="message-bubble ${bubbleColor}">
                        <c:out value="${chat.chat}"/>
                    </div>
                </div>
            </c:forEach>
        </div>
        <form id="chat-form" class="chat-input-form">
            <input type="text" id="message-input" placeholder="메시지를 입력하세요" autocomplete="off">
            <button type="submit" class="btn btn-primary ${sessionScope.color}-bg">전송</button>
        </form>
    </div>
</main>
<c:import url="/WEB-INF/views/footer.jsp" />

<script>
    $(document).ready(function() {
        const chatWindow = document.getElementById('chat-window');
        const chatForm = document.getElementById('chat-form');
        const messageInput = document.getElementById('message-input');
        const category = "${cat}";
        const myMid = "${sessionScope.loginMember.mid}";
        let ws;

        function connect() {
            const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
            ws = new WebSocket(protocol + "//" + window.location.host + "/chat");

            ws.onopen = () => { console.log("WebSocket 연결 성공"); scrollToBottom(); };
            ws.onmessage = (event) => {
                const msg = JSON.parse(event.data);
                appendMessage(msg.senderMid, msg.senderMbti, msg.content);
            };
            ws.onclose = () => console.log("WebSocket 연결 종료");
            ws.onerror = (error) => console.error("WebSocket 오류:", error);
        }

        function getMbtiColorClass(mbti) {
            if (!mbti) return 'others';
            const type = mbti.toUpperCase();
            if (['INTJ', 'INTP', 'ENTJ', 'ENTP'].includes(type)) return 'pink-bg';
            if (['INFJ', 'INFP', 'ENFJ', 'ENFP'].includes(type)) return 'green-bg';
            if (['ISTJ', 'ISFJ', 'ESTJ', 'ESFJ'].includes(type)) return 'blue-bg';
            if (['ISTP', 'ISFP', 'ESTP', 'ESFP'].includes(type)) return 'yellow-bg';
            return 'others';
        }

        function appendMessage(senderMid, senderMbti, content) {
            const isMine = (senderMid === myMid);
            const escapedContent = String(content).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");

            let bubbleColorClass = isMine ? `mine ${sessionScope.color}-bg` : `others ` + getMbtiColorClass(senderMbti);

            const messageHtml =
                '<div class="chat-message ' + (isMine ? 'mine' : 'others') + '">' +
                senderMbti +
                '<div class="message-bubble ' + bubbleColorClass + '">' +
                escapedContent +
                '</div>' +
                '</div>';
            $(chatWindow).append(messageHtml);
            scrollToBottom();
        }

        function scrollToBottom() {
            chatWindow.scrollTop = chatWindow.scrollHeight;
        }

        chatForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const message = messageInput.value;
            if (message.trim() !== '' && ws && ws.readyState === WebSocket.OPEN) {
                const chatData = {
                    cat: parseInt(category),
                    message: message
                };
                ws.send(JSON.stringify(chatData));
                messageInput.value = '';
            }
        });

        connect();
    });
</script>
</body>
</html>