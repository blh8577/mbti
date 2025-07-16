package com.community.mbti.listener;

import com.community.mbti.event.ChatMessageEvent;
import com.community.mbti.handler.ChatWebSocketHandler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class ChatEventListener {

    private final ChatWebSocketHandler chatWebSocketHandler;

    @EventListener
    public void handleChatMessage(ChatMessageEvent event) {
        try {
            // 이벤트가 발생하면, 핸들러의 방송 메서드를 호출합니다.
            chatWebSocketHandler.broadcastMessage(event.getChat());
        } catch (IOException e) {
            log.error("채팅 메시지 브로드캐스팅 중 오류 발생", e);
        }
    }
}