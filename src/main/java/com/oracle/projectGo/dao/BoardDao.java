package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.Board;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
@Slf4j
public class BoardDao {

    private final SqlSession session;

    public int boardCount(Board board) {
        // 쿼리를 작성하고 실행하여 게시글의 수를 반환해야 합니다.
        int countBoard = 0;

        try {
            countBoard = session.selectOne("boardCount", board);
        } catch (Exception e) {
            log.error("BoardDao boardCount Exception : {}", e.getMessage());
        }

        return countBoard;
    }

    public List<Board> getNoticAllList(Board board) {
        List<Board> noticAllList = null;

        try {
            noticAllList = session.selectList("noticAllList", board);
            log.info("BoardDao getNoticAllList size : {}", noticAllList.size());

        } catch (Exception e) {
            log.error("BoardDao getNoticAllList Exception : {}", e.getMessage());
        }

        return noticAllList;
    }


}
