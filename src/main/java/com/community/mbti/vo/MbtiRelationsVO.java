package com.community.mbti.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MbtiRelationsVO {
    private String mbtiFrom;      // 기준이 되는 MBTI 유형 (mbti_from 컬럼)
    private String mbtiTo;        // 관계 대상 MBTI 유형 (mbti_to 컬럼)
    private String relationType;  // 궁합의 종류 (relation_type 컬럼)

    @Override
    public String toString() {
        return "MbtiRelationsVO{" +
                "mbtiFrom='" + mbtiFrom + '\'' +
                ", mbtiTo='" + mbtiTo + '\'' +
                ", relationType='" + relationType + '\'' +
                '}';
    }
}
