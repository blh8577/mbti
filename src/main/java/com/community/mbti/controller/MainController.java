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

        HttpSession session = request.getSession();
        session.setAttribute("loginMember", loginMember);
        log.info("로그인 성공 및 세션 생성: {}", mid);

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
            e.printStackTrace();
            return "redirect:/join?error=true";
        }
    }

    // --- [추가] 검색 처리 ---
    @PostMapping("/search")
    public String searchProcess(@RequestParam("search") String keyword,
                                @RequestParam(value = "cat", required = false) String category) {
        // 검색 요청이 들어오면 로그를 남깁니다.
        log.info("검색 요청 - 카테고리: {}, 키워드: {}", category, keyword);

        // 실제 검색 로직을 수행한 후, 검색 결과 페이지로 이동합니다.
        // 여기서는 예시로 다시 홈으로 리다이렉트합니다.
        // TODO: 검색 결과 페이지로 이동하도록 수정 필요
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