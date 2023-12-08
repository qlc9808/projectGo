package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.Board;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import java.util.List;

@Repository
@RequiredArgsConstructor
@Slf4j
public class BoardDao {

    private final SqlSession session;
    private final PlatformTransactionManager transactionManager;

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


    public int totalnotioceboard() {

        int totalnotioceboard = 0;

        try {
            totalnotioceboard = session.selectOne("noticeboardCount");
        } catch (Exception e) {
            log.error("BoardDao boardCount Exception : {}", e.getMessage());
        }

        return totalnotioceboard;

    }

    public List<Board> listnoticeBoard(Board board) {
        List<Board> listnoticeBoard = null;

        try {
            listnoticeBoard = session.selectList("listnoticeBoard", board);
            log.info("BoardDao getlistnoticeBoard size : {}", listnoticeBoard.size());

        } catch (Exception e) {
            log.error("BoardDao getlistnoticeBoard Exception : {}", e.getMessage());
        }

        return listnoticeBoard;
    }
}
