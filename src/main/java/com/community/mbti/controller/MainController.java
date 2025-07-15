package com.community.mbti.controller;

import com.community.mbti.service.MemberService;
import com.community.mbti.vo.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.Collections;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MainController {

    private final MemberService memberService;

    // --- 페이지 이동 관련 ---
    @GetMapping({"/", "/index"})
    public String index() { return "index"; }

    @GetMapping("/login")
    public String loginPage() { return "login"; }

    @GetMapping("/home")
    public String home() { return "home"; }

    @GetMapping("/join")
    public String joinPage() { return "join"; }

    // --- 수동 로그인/로그아웃 처리 ---
    @PostMapping("/login")
    public String loginProcess(@RequestParam("username") String mid,
                               @RequestParam("password") String password,
                               HttpServletRequest request) {
        log.info("수동 로그인 시도: {}", mid);
        MemberVO loginMember = memberService.login(mid, password);

        if (loginMember == null) {
            log.warn("로그인 실패: {}", mid);
            return "redirect:/login?error=true";
        }

        // 로그인 성공 시 세션 생성
        HttpSession session = request.getSession();
        session.setAttribute("loginMember", loginMember);

        // [수정] MBTI에 따라 색상을 결정하고 세션에 저장
        String mbti = loginMember.getMbtiIdx();
        String color = "default"; // 기본값
        if (mbti != null) {
            switch (mbti.toUpperCase()) {
                case "INTJ": case "INTP": case "ENTJ": case "ENTP":
                    color = "pink";
                    break;
                case "INFJ": case "INFP": case "ENFJ": case "ENFP":
                    color = "green";
                    break;
                case "ISTJ": case "ISFJ": case "ESTJ": case "ESFJ":
                    color = "blue";
                    break;
                case "ISTP": case "ISFP": case "ESTP": case "ESFP":
                    color = "yellow";
                    break;
            }
        }
        session.setAttribute("color", color); // 세션에 색상 저장
        log.info("로그인 성공 및 세션 생성: {}, 색상: {}", mid, color);

        return "redirect:/home";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/";
    }

    // --- 회원가입 로직 ---
    @PostMapping("/join")
    public String processJoin(MemberVO memberVO) {
        try {
            memberService.joinMember(memberVO);
            return "redirect:/index";
        } catch (Exception e) {
            return "redirect:/join?error=true";
        }
    }

    // --- 검색 처리 ---
    @PostMapping("/search")
    public String searchProcess(@RequestParam("search") String keyword,
                                @RequestParam(value = "cat", required = false) String category) {
        log.info("검색 요청 - 카테고리: {}, 키워드: {}", category, keyword);
        return "redirect:/home";
    }

    // --- 아이디 중복 확인 API ---
    @GetMapping("/api/members/check-id")
    @ResponseBody
    public ResponseEntity<?> checkIdDuplicate(@RequestParam("mid") String mid) {
        boolean isDuplicate = memberService.isIdDuplicate(mid);
        return ResponseEntity.ok(Collections.singletonMap("isDuplicate", isDuplicate));
    }
}