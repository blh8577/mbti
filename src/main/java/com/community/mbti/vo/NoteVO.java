package com.community.mbti.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoteVO {
    private int noteno;
    private String content;
    private String wrdate;
    private String memberMid;  // 보낸 사람 ID
    private String recipients; // 받는 사람 ID
    private String reMbti;     // 받는 사람 MBTI
    private String readCheck;  // 읽음 여부 (Y/N)
    private String senderMbti;
}