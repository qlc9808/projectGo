package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.BoardDao;
import com.oracle.projectGo.dto.Board;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

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

    public int totalnoticeboard() {

        int totalnotioceboard = boardDao.totalnotioceboard();

        return totalnotioceboard;
     }

    public List<Board> listnoticeBoard(Board board) {
        List<Board> listnoticeBoard = boardDao.listnoticeBoard(board);
        if(listnoticeBoard==null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙소 리스트가 존재하지 않습니다");
        }

        return listnoticeBoard;
    }
}