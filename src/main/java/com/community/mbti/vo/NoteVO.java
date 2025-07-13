package com.community.mbti.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoteVO {
    private int noteno;
    private String content;
    private String wrdate;
    private String memberMid;
    //수신자
    private String recipients;
    private String reMbti;
}
