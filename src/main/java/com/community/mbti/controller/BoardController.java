package com.community.mbti.controller;

import com.community.mbti.service.BoardService;
import com.community.mbti.vo.BoardVO;
import com.community.mbti.vo.MemberVO;
import com.community.mbti.vo.PagingVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/board")
    public String boardPage(@RequestParam(value = "cat", defaultValue = "0") int cat,
                            PagingVO paging, // [수정] PagingVO를 파라미터로 받음
                            HttpSession session,
                            Model model) {

        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/index";
        }

        String userMbti = loginMember.getMbtiIdx();
        log.info("게시판 요청 - cat: {}, page: {}, userMbti: {}", cat, paging.getPage(), userMbti);

        // [수정] 서비스를 호출하여 페이징된 데이터를 가져옴
        Map<String, Object> boardData = boardService.getBoardData(cat, userMbti, paging);

        // [수정] 모델에 페이징 객체를 포함하여 전달
        model.addAttribute("boardlist", boardData.get("boardlist"));
        model.addAttribute("popboardlist", boardData.get("popboardlist"));
        model.addAttribute("paging", boardData.get("paging"));
        model.addAttribute("cat", cat);

        return "board";
    }

    @GetMapping("/boardView")
    public String showBoardView(@RequestParam("view") int boardno, Model model) {
        Map<String, Object> boardDetails = boardService.getBoardDetails(boardno);
        model.addAttribute("boardview", boardDetails.get("boardview"));
        model.addAttribute("comlist", boardDetails.get("comlist"));
        model.addAttribute("piclist", boardDetails.get("piclist"));
        return "boardView";
    }

    @GetMapping("/createBoard")
    public String showCreateBoardForm() { return "createBoard"; }

    @PostMapping("/createBoard")
    public String processCreateBoard(BoardVO board, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login";
        }

        board.setMemberMid(loginMember.getMid());
        board.setMbtiIdx(loginMember.getMbtiIdx());

        try {
            log.info("게시글 등록 시도 (파일 포함): {}", board);
            boardService.createBoard(board);
        } catch (Exception e) {
            log.error("게시글 등록 중 오류 발생", e);
            // TODO: 사용자에게 오류 메시지를 보여주는 페이지로 이동
            return "redirect:/board?cat=" + board.getCategory() + "&error=true";
        }

        return "redirect:/board?cat=" + board.getCategory();
    }

    /**
     * 홈 화면의 최신글/인기글 목록을 가져오는 메서드
     */
    @GetMapping("/latestBoard")
    public String getHomeBoardLists(@RequestParam("homeboard") int homeboard, Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "latestBoard"; // 로그인 안했으면 빈 목록 표시
        }
        String mbtiIdx = loginMember.getMbtiIdx();

        if (homeboard == 1) {
            // 최신글 로직
            List<BoardVO> latestBoardList = boardService.getLatestBoards(5, mbtiIdx);
            model.addAttribute("latestBoard", latestBoardList);
        } else if (homeboard == 2) {
            // [수정] 인기글 조회 시, 로그인한 사용자의 MBTI를 기반으로 조회
            List<BoardVO> popularBoardList = boardService.getWeeklyPopularBoards(5, mbtiIdx);
            model.addAttribute("popBoard", popularBoardList);
            log.info("MBTI 관계 기반 주간 인기글 목록 조회: {}건", popularBoardList.size());
        }
        return "latestBoard";
    }

    /**
     * [추가] 게시물 삭제 처리 API
     */
    @PostMapping("/board/delete")
    @ResponseBody // AJAX 요청에 응답하기 위해 추가
    public ResponseEntity<?> deleteBoard(@RequestParam("boardno") int boardno, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(401).body("로그인이 필요합니다.");
        }

        try {
            boolean success = boardService.deleteBoard(boardno, loginMember.getMid());
            if (success) {
                log.info("게시물 삭제 성공: boardno={}", boardno);
                return ResponseEntity.ok(Map.of("message", "게시물이 삭제되었습니다."));
            } else {
                log.warn("게시물 삭제 권한 없음: boardno={}, user={}", boardno, loginMember.getMid());
                return ResponseEntity.status(403).body("삭제할 권한이 없습니다.");
            }
        } catch (Exception e) {
            log.error("게시물 삭제 중 오류 발생", e);
            return ResponseEntity.status(500).body("삭제 중 오류가 발생했습니다.");
        }
    }
}