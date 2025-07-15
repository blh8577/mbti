package com.community.mbti.service;

import com.community.mbti.mapper.BoardMapper;
import com.community.mbti.vo.BoardVO;
import com.community.mbti.vo.CommentsVO;
import com.community.mbti.vo.PictureVO;
import com.community.mbti.vo.PagingVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper boardMapper;

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

        Map<String, Object> params = new HashMap<>();
        params.put("category", cat);
        params.put("mbtiList", mbtiList);
        params.put("paging", paging);

        int totalCount = boardMapper.selectBoardCount(params);
        paging.setTotalCount(totalCount);

        List<BoardVO> boardList = boardMapper.selectBoardList(params);
        List<BoardVO> popBoardList = boardMapper.selectPopBoardList(params);

        resultMap.put("boardlist", boardList);
        resultMap.put("popboardlist", popBoardList);
        resultMap.put("paging", paging);

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
    public void createBoard(BoardVO board) {
        boardMapper.insertBoard(board);
    }
}