package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.GameContents;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

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
            System.out.println("GameDao gameContentInsert-> " + gameContentInsert);
        }catch(Exception e){
            System.out.println("GameDao gameContentInsert Exception-> " + e);
        }
    return gameContentInsert;
    }

    // 총 갯수
    public int gameContentsTotalCount() {
        System.out.println("GameDao gameContentsTotalCount Start !");

        int gameContentsTotalCount = 0;
        try {
            gameContentsTotalCount = session.selectOne("gameContentsTotalCount");
            System.out.println("GameDao gameContentsTotalCount-> " + gameContentsTotalCount);
        }catch(Exception e) {
            System.out.println("GameDao gameContentsTotalCount Exception-> " + e);
        }
    return gameContentsTotalCount;
    }

    // 리스트 조회
    public List<GameContents> gameContentsList(GameContents gameContents) {
        System.out.println("GameDao gameContentsList Start !");

        List<GameContents> gameContentsList = null;
        try{
            gameContentsList = session.selectList("gameContentsList", gameContents);
            System.out.println("GameDao gameContentsList.size()-> " + gameContentsList.size());
        }catch (Exception e){
            System.out.println("GameDao gameContentsList Exception-> " + e);
        }
    return  gameContentsList;
    }


    public List<GameContents> gameContentsListByIds(List<Integer> gameIds) {
        return session.selectList("gameContentsListByIds",gameIds);
    }
}
