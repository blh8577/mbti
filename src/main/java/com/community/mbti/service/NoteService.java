package com.community.mbti.service;

import com.community.mbti.mapper.MemberMapper;
import com.community.mbti.mapper.NoteMapper;
import com.community.mbti.vo.MemberVO;
import com.community.mbti.vo.NoteVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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

    /**
     * [수정] '읽지 않은' 쪽지 목록 조회
     */
    public List<NoteVO> getUnreadNotes(String memberId, int limit) {
        return noteMapper.selectUnreadNotes(memberId, limit);
    }

    /**
     * [추가] 받은 모든 쪽지 목록 조회
     */
    public List<NoteVO> getAllReceivedNotes(String memberId) {
        return noteMapper.selectAllReceivedNotes(memberId);
    }

    /**
     * [추가] 쪽지를 읽고, 읽음 상태로 변경
     */
    @Transactional
    public NoteVO readNoteAndMarkAsRead(int noteno, String currentUserId) {
        NoteVO note = noteMapper.selectNoteByNo(noteno);
        // 본인에게 온 쪽지가 맞는지 확인
        if (note != null && note.getRecipients().equals(currentUserId)) {
            noteMapper.markNoteAsRead(noteno);
            return note;
        }
        return null;
    }
}