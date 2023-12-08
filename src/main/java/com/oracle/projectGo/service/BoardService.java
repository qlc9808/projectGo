package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.BoardDao;
import com.oracle.projectGo.dto.Board;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardService {

    @Autowired
    private BoardDao boardDao;

    public int boardCount(Board board) {
        return boardDao.boardCount(board);
    }

    public List<Board> getNoticAllList(Board board) {
        List<Board> noticAllList = boardDao.getNoticAllList(board);

        log.info("service noticAllList size : {}", noticAllList.size());

        return noticAllList;
    }

}