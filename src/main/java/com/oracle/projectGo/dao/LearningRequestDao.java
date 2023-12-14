package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.LearningGroupMember;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class LearningRequestDao {
    private final SqlSession session;

    public int requestSignUp(LearningGroupMember member) {
        return session.insert("requestSignUp", member);
    }

    public int cancelSignUp(LearningGroupMember member) {
        return session.delete("cancelSignUp",member);
    }

    public LearningGroupMember remainRequest(int userId) {
        return session.selectOne("remainRequest", userId);
    }
}
