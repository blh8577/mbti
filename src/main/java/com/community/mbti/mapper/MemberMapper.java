package com.community.mbti.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.community.mbti.vo.MemberVO; // VO 클래스 임포트
import java.util.List;

@Mapper
public interface MemberMapper {

    // 회원 ID로 한 명의 회원 정보를 조회
    MemberVO findMemberById(String mid);

    // 모든 회원 정보 조회
    List<MemberVO> findAllMembers();

    // 새로운 회원 등록
    void insertMember(MemberVO member);

    /**
     * 아이디 중복 확인을 위해 DB에서 아이디 개수를 셈
     * @param mid 확인할 아이디
     * @return 존재하는 아이디 개수 (0 또는 1)
     */
    int idCheck(String mid);


}