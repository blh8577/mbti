package com.community.mbti.mapper;

import com.community.mbti.vo.CommentsVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentsMapper {
    void insertComment(CommentsVO comment);
    CommentsVO selectCommentByNo(int commentno);
    void updateCommentViewCheck(int commentno);

    // [추가] 댓글 추천수 1 증가
    void incrementCommentRecommendation(int commentno);
}