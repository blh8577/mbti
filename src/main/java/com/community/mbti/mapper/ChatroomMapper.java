package com.community.mbti.mapper;

import com.community.mbti.vo.ChatroomVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface ChatroomMapper {
    void insertMessage(ChatroomVO chatroomVO);
    List<Map<String, String>> getAllMbtiRelations();
    List<ChatroomVO> selectInitialMessages(@Param("category") int category, @Param("mbtiList") List<String> mbtiList);
}