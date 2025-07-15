package com.community.mbti.controller;

import com.community.mbti.service.RecommendationService;
import com.community.mbti.vo.MemberVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
public class RecommendationController {

    private final RecommendationService recommendationService;

    /**
     * 게시물 추천 처리 API
     */
    @PostMapping("/boardRecommendation")
    public ResponseEntity<?> recommendBoard(@RequestParam("view") int boardno, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }
        String memberMid = loginMember.getMid();

        boolean success = recommendationService.recommendBoard(boardno, memberMid);
        log.info("게시물 추천 시도 - boardno: {}, member: {}, 결과: {}", boardno, memberMid, success);

        return ResponseEntity.ok(Map.of("result", success ? 0 : 1));
    }

    /**
     * 댓글 추천 처리 API
     */
    @PostMapping("/comRecommendation")
    public ResponseEntity<?> recommendComment(@RequestParam("com") int commentno, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }
        String memberMid = loginMember.getMid();

        boolean success = recommendationService.recommendComment(commentno, memberMid);
        log.info("댓글 추천 시도 - commentno: {}, member: {}, 결과: {}", commentno, memberMid, success);

        return ResponseEntity.ok(Map.of("result", success ? 0 : 1));
    }
}