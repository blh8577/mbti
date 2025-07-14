package com.community.mbti.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentsVO {
    private int commentno;
    private String content;
    //대댓글 주인 번호
    private int mgrno;
    //추천수
    private int recommendation;
    //반대수
    private int opposition;
    private String viewcheck;
    private int boardBoardno;
    private String memberMid;
    private int level;
    private String wrdate;
    private String mbtiIdx;
}
