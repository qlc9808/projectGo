package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.Board;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

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

    public int InsertnoticeBoard(Board board) {
        int result = 0;
        try {
            result = session.insert("InsertnoticeBoard", board);
        } catch(Exception e) {
            log.info("BoardDaoImpl InsertnoticeBoard Exception => " + e.getMessage());
        }

        return result;

    }

    public int noticeUpdate(Board board) {
        int result = 0;
        TransactionStatus txStatus =
                transactionManager.getTransaction(new DefaultTransactionDefinition());
        try {
            result = session.update("noticeUpdate", board);
            log.info("noticeUpdate noticeUpdate result => " + result);
            transactionManager.commit(txStatus);
        } catch(Exception e) {
            transactionManager.rollback(txStatus);
            log.info("AccomodationDaoImpl updateAccomodation Exception => " + e.getMessage());
            result = -1;
        }

        return result;

    }

    public Board detailnotice(int userId) {
        Board board = new Board();

        try {
            board = session.selectOne("noticeDetail", userId);
            log.info("Board noticeDetail() notice.getTitle ->" + board.getTitle());

        } catch (Exception e) {
            log.info("Board noticeDetail() ->" + e.getMessage());
        }
        return board;

    }

    public int noticeDelete(int userId) {
        int noticeDelete = 0;
        try {
            noticeDelete = session.delete("noticeDelete",userId);
        } catch (Exception e) {
        }

        return noticeDelete;


    }
}
