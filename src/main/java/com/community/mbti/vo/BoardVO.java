package com.community.mbti.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {
    //번호
    private int boardno;
    //작성일
    private String wrdate;
    //제목
    private String title;
    //게시물 카테고리
    private String boardcol;
    //조회수
    private int count;
    //삭제여부
    private String viewcheck;
    //카테고리
    private int category;
    //추천수
    private int recommendation;
    //반대수
    private int opposition;
    //작성자
    private String memberMid;
    //작성자mbti
    private String mbtiIdx;
    //내용
    private String content;
}
