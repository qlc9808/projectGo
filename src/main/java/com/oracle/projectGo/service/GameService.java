package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.GameDao;
import com.oracle.projectGo.dto.GameContents;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class GameService {

    private final GameDao gd;
//------------------------------------------------------

    // 게임콘텐츠 insert
    public int gameContentInsert(GameContents gameContents) {
        System.out.println("ContentService gameContentInsert Start !");
        int gameContentInsert = gd.gameContentInsert(gameContents);

        return gameContentInsert;
    }

    // 총 갯수
    public int gameContentsTotalCount() {
        System.out.println("ContentService gameContentsTotalCount Start !");
        int gameContentsTotalCount = gd.gameContentsTotalCount();

        return gameContentsTotalCount;
    }

    // 리스트 조회
    public List<GameContents> gameContentsList(GameContents gameContents) {
        System.out.println("ContentService gameContentsList Start !");
        List<GameContents> gameContentsList = gd.gameContentsList(gameContents);

        return gameContentsList;
    }

//------------------------------------------------------

    // 각 아이디의 리스트 조회
    public GameContents getGameContentsById(Integer gameId) {
        System.out.println("ContentService getGameContentsById Start !");
        GameContents getGameContentsById = gd.getGameContentsById(gameId);

        return getGameContentsById;
    }

    public  List<GameContents> getSubscribedGameContents(int userId) {
        return gd.getSubscribedGameContents(userId);
    }








}
