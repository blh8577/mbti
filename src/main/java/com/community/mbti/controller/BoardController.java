package com.community.mbti.controller;

import com.community.mbti.service.BoardService;
import com.community.mbti.vo.BoardVO;
import com.community.mbti.vo.MemberVO;
import com.community.mbti.vo.PagingVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/board")
    public String boardPage(@RequestParam(value = "cat", defaultValue = "0") int cat,
                            PagingVO paging,
                            HttpSession session,
                            Model model) {

        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/index";
        }
        String userMbti = loginMember.getMbtiIdx();
        Map<String, Object> boardData = boardService.getBoardData(cat, userMbti, paging);
        model.addAttribute("boardlist", boardData.get("boardlist"));
        model.addAttribute("popboardlist", boardData.get("popboardlist"));
        model.addAttribute("paging", boardData.get("paging"));
        model.addAttribute("cat", cat);
        return "board";
    }

    @GetMapping("/latestBoard")
    public String getHomeBoardLists(@RequestParam("homeboard") int homeboard, Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "latestBoard";
        }
        String mbtiIdx = loginMember.getMbtiIdx();
        if (homeboard == 1) {
            model.addAttribute("latestBoard", boardService.getLatestBoards(5, mbtiIdx));
        } else if (homeboard == 2) {
            model.addAttribute("popBoard", boardService.getPopularBoards(5, mbtiIdx));
        }
        return "latestBoard";
    }

    /**
     * [추가] 게시물 상세 보기 페이지를 처리하는 메서드
     */
    @GetMapping("/boardView")
    public String showBoardView(@RequestParam("view") int boardno, Model model) {
        log.info("게시물 상세 보기 요청: boardno={}", boardno);
        Map<String, Object> boardDetails = boardService.getBoardDetails(boardno);

        model.addAttribute("boardview", boardDetails.get("boardview"));
        model.addAttribute("comlist", boardDetails.get("comlist"));
        model.addAttribute("piclist", boardDetails.get("piclist"));

        return "boardView"; // boardView.jsp 뷰를 반환
    }

    @GetMapping("/createBoard")
    public String showCreateBoardForm() {
        return "createBoard";
    }

    @PostMapping("/createBoard")
    public String processCreateBoard(BoardVO board, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login";
        }

        board.setMemberMid(loginMember.getMid());
        board.setMbtiIdx(loginMember.getMbtiIdx());

        boardService.createBoard(board);
        return "redirect:/board?cat=" + board.getCategory();
    }
}