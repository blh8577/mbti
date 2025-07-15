package com.community.mbti.mapper;

import org.apache.ibatis.annotations.Mapper;
import java.util.Map;

@Mapper
public interface RecommendationMapper {
    int checkBoardRecommendation(Map<String, Object> params);
    void insertBoardRecommendation(Map<String, Object> params);
    int checkCommentRecommendation(Map<String, Object> params);
    void insertCommentRecommendation(Map<String, Object> params);
}