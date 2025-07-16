package com.community.mbti.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatroomVO {
    private int chatno;
    private String wrdate;
    private String chat;
    private int category;
    private String mbtiIdx;
    private String memberMid;
}