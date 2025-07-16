package com.community.mbti.controller;

import com.community.mbti.service.ChatroomService;
import com.community.mbti.vo.MemberVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class ChatroomController {

    private final ChatroomService chatroomService;

    @GetMapping("/chatroom")
    public String chatroomPage(@RequestParam(value = "cat", defaultValue = "0") int cat,
                               Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/";
        }

        String roomTitle = chatroomService.getChatroomTitle(cat);
        model.addAttribute("roomTitle", roomTitle);
        model.addAttribute("cat", cat);
        model.addAttribute("chatHistory", chatroomService.getInitialMessages(cat, loginMember.getMbtiIdx()));

        return "chatroom";
    }
}