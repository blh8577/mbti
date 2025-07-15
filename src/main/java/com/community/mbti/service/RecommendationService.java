package com.community.mbti.service;

import com.community.mbti.mapper.BoardMapper;
import com.community.mbti.mapper.CommentsMapper;
import com.community.mbti.mapper.RecommendationMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@RequiredArgsConstructor
public class RecommendationService {

    private final RecommendationMapper recommendationMapper;
    private final BoardMapper boardMapper;
    private final CommentsMapper commentsMapper;

    @Transactional
    public boolean recommendBoard(int boardno, String memberMid) {
        int count = recommendationMapper.checkBoardRecommendation(Map.of("boardno", boardno, "memberMid", memberMid));
        if (count > 0) {
            return false; // 이미 추천함
        }
        recommendationMapper.insertBoardRecommendation(Map.of("boardno", boardno, "memberMid", memberMid));
        boardMapper.incrementBoardRecommendation(boardno);
        return true;
    }

    @Transactional
    public boolean recommendComment(int commentno, String memberMid) {
        int count = recommendationMapper.checkCommentRecommendation(Map.of("commentno", commentno, "memberMid", memberMid));
        if (count > 0) {
            return false; // 이미 추천함
        }
        recommendationMapper.insertCommentRecommendation(Map.of("commentno", commentno, "memberMid", memberMid));
        commentsMapper.incrementCommentRecommendation(commentno);
        return true;
    }
}