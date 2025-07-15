package com.community.mbti.service;

import com.community.mbti.mapper.CommentsMapper;
import com.community.mbti.vo.CommentsVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CommentsService {

    private final CommentsMapper commentsMapper;

    /**
     * 댓글 또는 대댓글을 DB에 추가
     * @param comment 컨트롤러로부터 받은 댓글 정보
     */
    public void addComment(CommentsVO comment) {
        // 부모 댓글 번호(mgrno)가 0이면 일반 댓글(level 1),
        // 0이 아니면 부모 댓글의 level을 조회하여 +1 한 값을 현재 댓글의 level로 설정
        if (comment.getMgrno() == 0) {
            comment.setLevel(1);
        } else {
            // 부모 댓글의 정보를 조회
            CommentsVO parentComment = commentsMapper.selectCommentByNo(comment.getMgrno());
            if (parentComment != null) {
                // 부모 댓글의 level + 1을 현재 댓글의 level로 설정
                comment.setLevel(parentComment.getLevel() + 1);
            } else {
                // 혹시 모를 예외 상황: 부모 댓글이 없다면 최상위 댓글로 처리
                comment.setLevel(1);
                comment.setMgrno(0);
            }
        }
        commentsMapper.insertComment(comment);
    }

    /**
     * [추가] 댓글 삭제 서비스
     * @param commentno 삭제할 댓글 번호
     * @param currentUserId 현재 로그인한 사용자 ID
     * @return 삭제 성공 여부
     */
    @Transactional
    public boolean deleteComment(int commentno, String currentUserId) {
        CommentsVO comment = commentsMapper.selectCommentByNo(commentno);
        // 댓글이 존재하고, 현재 로그인한 사용자가 작성자인지 확인
        if (comment != null && comment.getMemberMid().equals(currentUserId)) {
            commentsMapper.updateCommentViewCheck(commentno);
            return true;
        }
        return false;
    }
}