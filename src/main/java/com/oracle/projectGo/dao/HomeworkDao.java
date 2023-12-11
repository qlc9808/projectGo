package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.utils.error.BusinessException;
import com.oracle.projectGo.utils.error.DatabaseException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
@Slf4j
public class HomeworkDao {
    private final SqlSession session;
    public int insertHomework(Homeworks homework) {
        return session.insert("insertHomework", homework);
    }

    public int getTotalHomeworksCnt(Homeworks homework) {
        return session.selectOne("getTotalHomeworksCnt", homework);
    }

    public List<Homeworks> getHomeworksList(Homeworks homework){
        return session.selectList("getHomeworksList",homework);
    }

    public List<String> getDistinctHomeworkTitles(int educatorId) {
        return session.selectList("getDistinctHomeworkTitles",educatorId);
    }
}
