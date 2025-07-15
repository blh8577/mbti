package com.community.mbti.controller;

import com.community.mbti.service.CommentsService;
import com.community.mbti.vo.CommentsVO;
import com.community.mbti.vo.MemberVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class CommentsController {

    private final CommentsService commentsService;

    /**
     * 댓글 또는 대댓글을 등록하는 메서드
     * @param comment JSP 폼에서 전송된 데이터 (content, boardBoardno, mgrno)
     * @param session 작성자 정보를 가져오기 위한 세션
     * @return 처리가 끝난 후 돌아갈 게시물 상세 보기 페이지로 리다이렉트
     */
    @PostMapping("/commentInput")
    public String processCommentInput(CommentsVO comment, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        // 로그인하지 않은 경우, 로그인 페이지로 보냄
        if (loginMember == null) {
            return "redirect:/index";
        }

        // 세션에서 작성자 정보(ID, MBTI)를 가져와 CommentsVO에 설정
        comment.setMemberMid(loginMember.getMid());
        comment.setMbtiIdx(loginMember.getMbtiIdx());

        log.info("댓글 등록 시도: {}", comment);
        commentsService.addComment(comment);

        // 댓글 등록 후, 원래 보던 게시물 상세 페이지로 리다이렉트
        return "redirect:/boardView?view=" + comment.getBoardBoardno();
    }

    /**
     * [추가] 댓글 삭제 처리 API
     */
    @PostMapping("/comment/delete")
    @ResponseBody
    public ResponseEntity<?> deleteComment(@RequestParam("commentno") int commentno, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        try {
            boolean success = commentsService.deleteComment(commentno, loginMember.getMid());
            if (success) {
                log.info("댓글 삭제 성공: commentno={}", commentno);
                return ResponseEntity.ok(Map.of("message", "댓글이 삭제되었습니다."));
            } else {
                return ResponseEntity.status(403).body("삭제할 권한이 없습니다.");
            }
        } catch (Exception e) {
            log.error("댓글 삭제 중 오류 발생", e);
            return ResponseEntity.status(500).body("삭제 중 오류가 발생했습니다.");
        }
    }
}