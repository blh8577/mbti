package com.community.mbti.event;

import com.community.mbti.vo.ChatroomVO;
import lombok.Getter;
import org.springframework.context.ApplicationEvent;

@Getter
public class ChatMessageEvent extends ApplicationEvent {
    private final ChatroomVO chat;

    public ChatMessageEvent(Object source, ChatroomVO chat) {
        super(source);
        this.chat = chat;
    }
}