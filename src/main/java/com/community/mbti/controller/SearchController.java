package com.community.mbti.controller;

import com.community.mbti.service.BoardService;
import com.community.mbti.vo.MemberVO;
import com.community.mbti.vo.PagingVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
public class SearchController {

    private final BoardService boardService;

    @GetMapping("/search")
    public String searchBoards(@RequestParam("search") String keyword,
                               @RequestParam(value = "cat", required = false) Integer category,
                               PagingVO paging,
                               HttpSession session,
                               Model model) {

        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            // [수정] 로그인 정보가 없으면 루트 경로로 리다이렉트
            return "redirect:/";
        }
        String userMbti = loginMember.getMbtiIdx();
        log.info("검색 요청 - keyword: {}, category: {}, userMbti: {}", keyword, category, userMbti);

        Map<String, Object> searchData = boardService.searchBoards(keyword, category, userMbti, paging);

        model.addAttribute("boardlist", searchData.get("boardlist"));
        model.addAttribute("paging", searchData.get("paging"));
        model.addAttribute("keyword", keyword);
        model.addAttribute("cat", category);

        return "searchResult";
    }
}