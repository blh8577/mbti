package com.community.mbti.service;

import com.community.mbti.mapper.BoardMapper;
import com.community.mbti.vo.BoardVO;
import com.community.mbti.vo.CommentsVO;
import com.community.mbti.vo.PictureVO;
import com.community.mbti.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper boardMapper;
    private final FileService fileService; // 파일 서비스 주입

    public Map<String, Object> getBoardData(int cat, String userMbti, PagingVO paging) {
        Map<String, Object> resultMap = new HashMap<>();
        List<String> mbtiList = new ArrayList<>();

        if (cat == 0) {
            mbtiList.add(userMbti);
        } else {
            String relationType = "";
            switch (cat) {
                case 1: relationType = "relation_good"; break;
                case 2: relationType = "relation_bad"; break;
                case 3: relationType = "love_good"; break;
                case 4: relationType = "love_bad"; break;
            }
            if (!relationType.isEmpty()) {
                mbtiList = boardMapper.selectRelatedMbtis(userMbti, relationType);
            }
            if (!mbtiList.contains(userMbti)) {
                mbtiList.add(userMbti);
            }
        }

        // [수정] 페이징 계산 로직 추가
        int totalCount = boardMapper.selectBoardCount(cat, mbtiList);
        paging.setTotalCount(totalCount); // totalCount를 설정하여 페이징 변수들 계산

        // [수정] 페이징된 게시물 목록 조회
        List<BoardVO> boardList = boardMapper.selectBoardList(cat, mbtiList, paging);
        List<BoardVO> popBoardList = boardMapper.selectPopBoardList(cat, mbtiList);

        resultMap.put("boardlist", boardList);
        resultMap.put("popboardlist", popBoardList);
        resultMap.put("paging", paging); // 계산이 완료된 페이징 객체 전달

        return resultMap;
    }

    public List<BoardVO> getLatestBoards(int limit, String mbtiIdx) {
        return boardMapper.selectLatestBoards(limit, mbtiIdx);
    }

    public List<BoardVO> getPopularBoards(int limit, String mbtiIdx) {
        return boardMapper.selectPopularBoards(limit, mbtiIdx);
    }

    /**
     * [추가] 게시물 상세 정보 조회 서비스
     */
    @Transactional
    public Map<String, Object> getBoardDetails(int boardno) {
        Map<String, Object> detailsMap = new HashMap<>();

        // 1. 조회수 증가
        boardMapper.updateViewCount(boardno);

        // 2. 게시물 상세 정보, 댓글, 사진 목록을 각각 조회
        BoardVO board = boardMapper.selectBoardByNo(boardno);
        List<CommentsVO> comments = boardMapper.selectCommentsByBoardNo(boardno);
        List<PictureVO> pictures = boardMapper.selectPicturesByBoardNo(boardno);

        // 3. 맵에 담아 반환
        detailsMap.put("boardview", board);
        detailsMap.put("comlist", comments);
        detailsMap.put("piclist", pictures);

        return detailsMap;
    }

    @Transactional
    public void createBoard(BoardVO board) throws IOException {
        // 1. 게시글 정보를 먼저 DB에 저장합니다.
        //    (selectKey를 통해 board.boardno에 새로 생성된 PK값이 담깁니다)
        boardMapper.insertBoard(board);
        int boardno = board.getBoardno(); // 생성된 게시물 번호

        // 2. 첨부된 파일들을 서버에 저장하고, 저장된 경로 목록을 받습니다.
        List<String> storedFilePaths = fileService.storeFiles(board.getFiles());

        // 3. 저장된 파일 경로들을 PICTURE 테이블에 저장합니다.
        if (!storedFilePaths.isEmpty()) {
            for (String path : storedFilePaths) {
                PictureVO picture = new PictureVO();
                picture.setBoardBoardno(boardno);
                picture.setPicturepath(path);
                boardMapper.insertPicture(picture);
            }
        }
    }

    /**
     * [수정] 주간 인기글 조회 서비스
     * @param limit 가져올 게시글 수
     * @param mbtiIdx 로그인한 사용자의 MBTI
     * @return 주간 인기 게시글 목록
     */
    public List<BoardVO> getWeeklyPopularBoards(int limit, String mbtiIdx) {
        return boardMapper.selectWeeklyPopularBoards(limit, mbtiIdx);
    }

    /**
     * [추가] 게시물 삭제 서비스
     * @param boardno 삭제할 게시물 번호
     * @param currentUserId 현재 로그인한 사용자 ID
     * @return 삭제 성공 여부
     */
    @Transactional
    public boolean deleteBoard(int boardno, String currentUserId) {
        BoardVO board = boardMapper.selectBoardByNo(boardno);
        // 게시물이 존재하고, 현재 로그인한 사용자가 작성자인지 확인
        if (board != null && board.getMemberMid().equals(currentUserId)) {
            boardMapper.updateBoardViewCheck(boardno);
            return true;
        }
        return false;
    }

    /**
     * [추가] 게시물 검색 서비스
     * @param keyword 검색어
     * @param category 검색할 카테고리 (null이면 전체 검색)
     * @param userMbti 로그인한 사용자 MBTI
     * @param paging 페이징 정보
     * @return 검색 결과 데이터 맵
     */
    public Map<String, Object> searchBoards(String keyword, Integer category, String userMbti, PagingVO paging) {
        Map<String, Object> resultMap = new HashMap<>();
        List<String> mbtiList = null;

        if (category != null) { // 게시판 내 검색
            mbtiList = new ArrayList<>();
            if (category == 0) {
                mbtiList.add(userMbti);
            } else {
                String relationType = "";
                switch (category) {
                    case 1: relationType = "relation_good"; break;
                    case 2: relationType = "relation_bad"; break;
                    case 3: relationType = "love_good"; break;
                    case 4: relationType = "love_bad"; break;
                }
                if (!relationType.isEmpty()) {
                    mbtiList = boardMapper.selectRelatedMbtis(userMbti, relationType);
                }
                if (!mbtiList.contains(userMbti)) {
                    mbtiList.add(userMbti);
                }
            }
        }

        int totalCount = boardMapper.selectSearchBoardCount(keyword, category, userMbti, mbtiList);
        paging.setTotalCount(totalCount);

        List<BoardVO> boardList = boardMapper.selectSearchBoardList(keyword, category, userMbti, mbtiList, paging);

        resultMap.put("boardlist", boardList);
        resultMap.put("paging", paging);

        return resultMap;
    }
}