package com.community.mbti.controller;

import com.community.mbti.service.NoteService;
import com.community.mbti.vo.MemberVO;
import com.community.mbti.vo.NoteVO;
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

@Slf4j
@Controller
@RequiredArgsConstructor
public class NoteController {

    private final NoteService noteService;

    @GetMapping("/noteView")
    public String showNoteForm(@RequestParam("recipients") String recipients, Model model) {
        model.addAttribute("recipients", recipients);
        return "noteView";
    }

    @PostMapping("/noteSend")
    public String processNoteSend(NoteVO note, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login";
        }
        note.setMemberMid(loginMember.getMid());
        noteService.sendNote(note);
        return "noteSendSuccess";
    }

    @GetMapping("/noteList")
    public String getUnreadNotes(HttpSession session, Model model) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember != null) {
            List<NoteVO> noteList = noteService.getUnreadNotes(loginMember.getMid(), 5);
            model.addAttribute("noteList", noteList);
        }
        return "fragments/noteListFragment";
    }

    @GetMapping("/myNotes")
    public String showMyNotes(HttpSession session, Model model) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/login";
        }
        List<NoteVO> allNotes = noteService.getAllReceivedNotes(loginMember.getMid());
        model.addAttribute("allNotes", allNotes);
        return "myNotes";
    }

    @PostMapping("/note/read")
    @ResponseBody
    public ResponseEntity<NoteVO> readNote(@RequestParam("noteno") int noteno, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return ResponseEntity.status(401).build();
        }
        NoteVO note = noteService.readNoteAndMarkAsRead(noteno, loginMember.getMid());
        if (note == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(note);
    }
}