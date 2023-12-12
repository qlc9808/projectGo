package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.Users;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
@Slf4j
public class LearningGroupDao {
    private final SqlSession session;

    public int totalGroupContentCnt() {

        return session.selectOne("NoTotalGroupContentCnt");
    }

    public List<LearningGroup> learningGroupList(LearningGroup learningGroup) {
        List<LearningGroup> learningGroupList = null;

        try {
            learningGroupList = session.selectList("NoLearningGroupList",learningGroup);
            log.info("learningGroupList : " + learningGroupList);
        } catch (Exception e) {
            log.info("LearningGroupDao learningGroupList e.getMessage() -> " + e.getMessage());
        }
        return learningGroupList;
    }

    public LearningGroup detailGroupContent(int userId) {
        LearningGroup detailGroupContent = null;

        try {
            detailGroupContent = session.selectOne("NoDetailGroupContent", userId);
        } catch (Exception e) {
            log.info("LearningGroupDao detailGroupContent e.getMessage() -> " + e.getMessage());
        }
        return detailGroupContent;
    }


    public List<Users> getGroupMemberByGroupId(int educatorId) {
        return session.selectList("getGroupMemberByGroupId",educatorId);
    }

    public List<Users> getGroupMembersByEducatorId(int educatorId) {
        return session.selectList("getGroupMembersByEducatorId",educatorId);
    }
}