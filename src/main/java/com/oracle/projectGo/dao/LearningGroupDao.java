package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.Users;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
@Slf4j
public class LearningGroupDao {
    private final SqlSession session;

    public int totalLearningContentCnt() {

        return session.selectOne("NoTotalLearningContentCnt");
    }

    public List<GameContents> learningContentList(GameContents gameContents) {
        List<GameContents> learningContentList = null;

        try {
            learningContentList = session.selectList("NoLearningContentList", gameContents);
            log.info("learningContentList : " + learningContentList);
        } catch (Exception e) {
            log.info("LearningGroupDao learningContentList e.getMessage() : " + e.getMessage());
        }
        return learningContentList;
    }

    public GameContents insertFormLearningContent(int id) {
        GameContents insertFormLearningContent = null;

        try {
            insertFormLearningContent = session.selectOne("NoInsertFormLearningContent", id);
        } catch (Exception e) {
            log.info("LearningGroupDao insertFormLearningContent e.getMessage() : " + e.getMessage());
        }
        return insertFormLearningContent;
    }

    public int insertLearningGroup(Map<String, Object> params) {
        int insertLearningGroup = 0;

        try {
            insertLearningGroup = session.insert("NoInsertLearningGroup", params);
            log.info("insertLearningGroup : " + insertLearningGroup);
        } catch (Exception e) {
            log.info("LearningGroupDao insertLearningGroup e.getMessage() : " + e.getMessage());
        }
        return insertLearningGroup;
    }

    public int totalLearningGroupCnt() {
        return session.selectOne("NoTotalLearningGroupCnt");
    }

    public List<LearningGroup> learningGroupList() {
        List<LearningGroup> learningGroupList = null;

        try {
            learningGroupList = session.selectList("NoLearningGroupList");
        } catch (Exception e) {
            log.info("LearningGroupDao learningGroupList e.getMessage() : " + e.getMessage());
        }
        return learningGroupList;
    }

    public List<LearningGroup> detailLearningGroup(LearningGroup learningGroup) {
        List<LearningGroup> detailLearningGroup = null;
        try {
            detailLearningGroup = session.selectList("NoDetailLearningGroup", learningGroup);
        } catch (Exception e) {
            log.info("LearningGroupDao detailLearningGroup e.getMessage() : " + e.getMessage());
        }
        return detailLearningGroup;
    }


    public List<Users> getGroupMemberByGroupId(int educatorId) {
        return session.selectList("getGroupMemberByGroupId",educatorId);
    }

    public List<Users> getGroupMembersByEducatorId(int educatorId) {
        return session.selectList("getGroupMembersByEducatorId",educatorId);
    }

    public List<LearningGroup> signUpLearningGroup() {
        List<LearningGroup> signUpLearningGroup = null;
        try {
            signUpLearningGroup = session.selectList("signUpLearningGroup");
            log.info(signUpLearningGroup.toString());
        } catch (Exception e) {
            log.info(e.getMessage());
        }
        return signUpLearningGroup;
    }

}
