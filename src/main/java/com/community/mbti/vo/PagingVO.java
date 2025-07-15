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
    private int totalPage;      // 전체 페이지 수

    // totalCount가 설정되면 자동으로 페이징 관련 모든 변수를 계산합니다.
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        paging();
    }

    private void paging() {
        // 1. 전체 페이지 수 계산
        totalPage = (int) Math.ceil(totalCount / (double) displayRow);

        // 2. 현재 블럭의 끝 페이지 계산
        endPage = ((int) Math.ceil(page / (double) displayPage)) * displayPage;

        // 3. 현재 블럭의 시작 페이지 계산
        beginPage = endPage - (displayPage - 1);
        if (beginPage < 1) {
            beginPage = 1;
        }

        // 4. 끝 페이지가 전체 페이지 수보다 크면, 전체 페이지 수로 맞춤
        if (totalPage < endPage) {
            endPage = totalPage;
        }

        // 5. 이전/다음 버튼 표시 여부 계산
        prev = (beginPage != 1);
        next = (endPage < totalPage);

        // 6. 쿼리에서 사용할 rownum 범위 계산
        startNum = (page - 1) * displayRow + 1;
        endNum = page * displayRow;
    }
}