package com.community.mbti.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OppositionVO {
    private int oppno;
    private int bordno;
    private String memberMid;
    //게시판인지 댓글인지 확인
    private String boardcheck;
    //게시판인지 댓글인지 확인하고 주인 찾기
    private int owner;
}
