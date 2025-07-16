package com.community.mbti.service;

import com.community.mbti.mapper.MemberMapper;
import com.community.mbti.mapper.NoteMapper;
import com.community.mbti.vo.MemberVO;
import com.community.mbti.vo.NoteVO;
import com.community.mbti.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class NoteService {

    private final NoteMapper noteMapper;
    private final MemberMapper memberMapper;

    public void sendNote(NoteVO note) {
        MemberVO recipientInfo = memberMapper.findMemberById(note.getRecipients());
        if (recipientInfo != null) {
            note.setReMbti(recipientInfo.getMbtiIdx());
        }
        noteMapper.insertNote(note);
    }

    public List<NoteVO> getUnreadNotes(String memberId, int limit) {
        return noteMapper.selectUnreadNotes(memberId, limit);
    }

    /**
     * [수정] 받은 모든 쪽지 목록을 페이징 처리하여 조회
     */
    public Map<String, Object> getAllReceivedNotes(String memberId, PagingVO paging) {
        Map<String, Object> resultMap = new HashMap<>();

        // 페이징 계산
        int totalCount = noteMapper.selectReceivedNotesCount(memberId);
        paging.setTotalCount(totalCount);

        // 페이징된 쪽지 목록 조회
        List<NoteVO> noteList = noteMapper.selectAllReceivedNotes(memberId, paging);

        resultMap.put("allNotes", noteList);
        resultMap.put("paging", paging);

        return resultMap;
    }

    @Transactional
    public NoteVO readNoteAndMarkAsRead(int noteno, String currentUserId) {
        NoteVO note = noteMapper.selectNoteByNo(noteno);
        if (note != null && note.getRecipients().equals(currentUserId)) {
            noteMapper.markNoteAsRead(noteno);
            MemberVO senderInfo = memberMapper.findMemberById(note.getMemberMid());
            if (senderInfo != null) {
                note.setSenderMbti(senderInfo.getMbtiIdx());
            }
            return note;
        }
        return null;
    }
}