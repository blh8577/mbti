package com.community.mbti.service;

import com.community.mbti.mapper.MemberMapper;
import com.community.mbti.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberMapper memberMapper;
    private final PasswordEncoder passwordEncoder;

    /**
     * [추가] 수동 로그인을 위한 서비스 메서드
     * @return 로그인 성공 시 MemberVO 객체, 실패 시 null
     */
    public MemberVO login(String mid, String rawPassword) {
        MemberVO member = memberMapper.findMemberById(mid);
        // 사용자가 존재하고, 입력된 비밀번호와 DB의 암호화된 비밀번호가 일치하는지 확인
        if (member != null && passwordEncoder.matches(rawPassword, member.getMpw())) {
            return member;
        }
        return null;
    }

    /**
     * 회원가입 로직 (비밀번호 암호화 포함)
     */
    @Transactional
    public void joinMember(MemberVO memberVO) {
        if (isIdDuplicate(memberVO.getMid())) {
            throw new IllegalStateException("이미 존재하는 아이디입니다.");
        }
        String encodedPassword = passwordEncoder.encode(memberVO.getMpw());
        memberVO.setMpw(encodedPassword);
        memberMapper.insertMember(memberVO);
    }

    /**
     * 아이디 중복 확인 서비스
     */
    public boolean isIdDuplicate(String mid) {
        return memberMapper.idCheck(mid) > 0;
    }
}