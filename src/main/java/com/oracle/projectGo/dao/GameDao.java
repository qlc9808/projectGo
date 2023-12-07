package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.GameContents;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class GameDao {

    private final SqlSession session;

 // -----------------------------------------------------------

    // 게임콘텐츠 insert
    public int gameContentInsert(GameContents gameContents) {
        System.out.println("GameDao gameContentInsert Start !");

        int gameContentInsert = 0;
        try {
            gameContentInsert = session.insert("gameContentInsert", gameContents);
        }catch(Exception e){
            System.out.println("GameDao gameContentInsert Exception-> " + e);
        }
    return gameContentInsert;
    }

}
