package com.community.mbti.handler;

import com.community.mbti.service.ChatroomService;
import com.community.mbti.vo.ChatroomVO;
import com.community.mbti.vo.MemberVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
@Slf4j
@RequiredArgsConstructor
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final Map<WebSocketSession, MemberVO> sessionMap = new ConcurrentHashMap<>();
    private final ChatroomService chatroomService;
    private final ObjectMapper objectMapper;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        MemberVO loginMember = (MemberVO) session.getAttributes().get("loginMember");
        if (loginMember != null) {
            sessionMap.put(session, loginMember);
        } else {
            try {
                session.close(CloseStatus.POLICY_VIOLATION);
            } catch (IOException e) {
                log.error("세션 종료 중 오류 발생", e);
            }
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        Map<String, Object> chatData = objectMapper.readValue(payload, Map.class);
        MemberVO sender = sessionMap.get(session);

        if (sender != null) {
            ChatroomVO chat = new ChatroomVO();
            chat.setCategory((Integer) chatData.get("cat"));
            chat.setChat((String) chatData.get("message"));
            chat.setMemberMid(sender.getMid());
            chat.setMbtiIdx(sender.getMbtiIdx());

            chatroomService.saveMessage(chat);
            broadcast(chat);
        }
    }

    private void broadcast(ChatroomVO chat) throws IOException {
        Map<String, String> messageMap = Map.of(
                "senderMid", chat.getMemberMid(),
                "senderMbti", chat.getMbtiIdx(),
                "content", chat.getChat()
        );
        String messageJson = objectMapper.writeValueAsString(messageMap);
        TextMessage textMessage = new TextMessage(messageJson);

        for (Map.Entry<WebSocketSession, MemberVO> entry : sessionMap.entrySet()) {
            WebSocketSession recipientSession = entry.getKey();
            MemberVO recipient = entry.getValue();

            if (chatroomService.canReceive(chat.getMbtiIdx(), recipient.getMbtiIdx(), chat.getCategory())) {
                if (recipientSession.isOpen()) {
                    recipientSession.sendMessage(textMessage);
                }
            }
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        sessionMap.remove(session);
    }
}