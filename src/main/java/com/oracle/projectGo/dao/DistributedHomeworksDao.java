package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.DistributedHomeworks;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
@Slf4j
public class DistributedHomeworksDao {
    private final SqlSession session;

    public int bulkInsert(List<DistributedHomeworks> distributedHomeworksList) {
        return session.insert("insertDistributedHomeworksByBulk",distributedHomeworksList);
    }

    public List<DistributedHomeworks> getDistributedHomeworks(DistributedHomeworks pDistributedHomework) {
        return session.selectList("getDistributedHomeworks",pDistributedHomework);
    }

    public int updateEvaluation(List<DistributedHomeworks> evaluations) {
        return session.update("updateDistributedHomeworks",evaluations);
    }
}
