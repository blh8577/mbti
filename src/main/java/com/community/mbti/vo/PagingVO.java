package com.community.mbti.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingVO {
    private int page = 1;       // 현재 페이지 번호
    private int totalCount;     // 전체 게시물 수
    private int displayRow = 10;  // 한 페이지에 보여줄 게시물 수
    private int displayPage = 10; // 한 블럭에 보여줄 페이지 수
    private int beginPage;      // 현재 블럭의 시작 페이지
    private int endPage;        // 현재 블럭의 끝 페이지
    private boolean prev;       // 이전 블럭으로 가는 화살표 유무
    private boolean next;       // 다음 블럭으로 가는 화살표 유무
    private int startNum;       // 현재 페이지의 시작 rownum
    private int endNum;         // 현재 페이지의 끝 rownum

    // totalCount가 설정되면 자동으로 페이징 관련 모든 변수를 계산합니다.
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        paging();
    }

    private void paging() {
        // 끝 페이지 계산
        endPage = ((int) Math.ceil(page / (double) displayPage)) * displayPage;
        // 시작 페이지 계산
        beginPage = endPage - (displayPage - 1);

        // 전체 페이지 수 계산
        int totalPage = (int) Math.ceil(totalCount / (double) displayRow);

        if (totalPage < endPage) {
            endPage = totalPage;
            next = false;
        } else {
            next = true;
        }
        prev = (beginPage != 1); // 시작 페이지가 1이 아니면 무조건 이전 블럭이 있음

        // 쿼리에서 사용할 rownum 범위 계산
        startNum = (page - 1) * displayRow + 1;
        endNum = page * displayRow;
    }
}