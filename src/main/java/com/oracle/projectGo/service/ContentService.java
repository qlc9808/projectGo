package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.GameDao;
import com.oracle.projectGo.dto.GameContents;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContentService {

    private GameDao gd;

//------------------------------------------------------

    // 게임콘텐츠 insert
    public int gameContentInsert(GameContents gameContents) {
        System.out.println("ContentService gameContentInsert Start !");
        int gameContentInsert = gd.gameContentInsert(gameContents);

        return gameContentInsert;
    }



}
