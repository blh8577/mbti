package com.community.mbti.mapper;

import com.community.mbti.vo.NoteVO;
import com.community.mbti.vo.PagingVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface NoteMapper {
    void insertNote(NoteVO note);
    List<NoteVO> selectUnreadNotes(@Param("memberId") String memberId, @Param("limit") int limit);

    // [수정] 페이징된 모든 쪽지 목록 조회
    List<NoteVO> selectAllReceivedNotes(@Param("memberId") String memberId, @Param("paging") PagingVO paging);

    // [추가] 받은 쪽지 총 개수 조회
    int selectReceivedNotesCount(@Param("memberId") String memberId);

    NoteVO selectNoteByNo(int noteno);
    void markNoteAsRead(int noteno);
}