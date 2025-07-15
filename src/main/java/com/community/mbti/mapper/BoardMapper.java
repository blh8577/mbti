package com.community.mbti.mapper;

import com.community.mbti.vo.BoardVO;
import com.community.mbti.vo.CommentsVO;
import com.community.mbti.vo.PagingVO;
import com.community.mbti.vo.PictureVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {

    List<String> selectRelatedMbtis(@Param("mbtiFrom") String mbtiFrom, @Param("relationType") String relationType);
    int selectBoardCount(@Param("category") int category, @Param("mbtiList") List<String> mbtiList);
    List<BoardVO> selectBoardList(@Param("category") int category, @Param("mbtiList") List<String> mbtiList, @Param("paging") PagingVO paging);
    List<BoardVO> selectPopBoardList(@Param("category") int category, @Param("mbtiList") List<String> mbtiList);
    List<BoardVO> selectLatestBoards(@Param("limit") int limit, @Param("mbtiIdx") String mbtiIdx);
    List<BoardVO> selectPopularBoards(@Param("limit") int limit, @Param("mbtiIdx") String mbtiIdx);
    void insertBoard(BoardVO board);

    // [추가] 게시물 상세 보기를 위한 메서드들
    int updateViewCount(int boardno);
    BoardVO selectBoardByNo(int boardno);
    List<CommentsVO> selectCommentsByBoardNo(int boardno);
    List<PictureVO> selectPicturesByBoardNo(int boardno);

    // [추가] 게시물 추천수 1 증가
    void incrementBoardRecommendation(int boardno);

    List<BoardVO> selectWeeklyPopularBoards(@Param("limit") int limit, @Param("mbtiIdx") String mbtiIdx);

    void insertPicture(PictureVO picture);

    void updateBoardViewCheck(int boardno);

    int selectSearchBoardCount(@Param("keyword") String keyword,
                               @Param("category") Integer category,
                               @Param("userMbti") String userMbti,
                               @Param("mbtiList") List<String> mbtiList);

    List<BoardVO> selectSearchBoardList(@Param("keyword") String keyword,
                                        @Param("category") Integer category,
                                        @Param("userMbti") String userMbti,
                                        @Param("mbtiList") List<String> mbtiList,
                                        @Param("paging") PagingVO paging);
}