package com.community.mbti.mapper;

import com.community.mbti.vo.NoteVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface NoteMapper {
    void insertNote(NoteVO note);

    // [수정] 읽지 않은 쪽지 목록 조회
    List<NoteVO> selectUnreadNotes(@Param("memberId") String memberId, @Param("limit") int limit);

    // [추가] 받은 모든 쪽지 목록 조회
    List<NoteVO> selectAllReceivedNotes(@Param("memberId") String memberId);

    // [추가] 특정 쪽지 1건 조회
    NoteVO selectNoteByNo(int noteno);

    // [추가] 쪽지를 읽음 상태로 변경
    void markNoteAsRead(int noteno);
}