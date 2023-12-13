package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.DistributedHomeworksDao;
import com.oracle.projectGo.dao.HomeworkDao;
import com.oracle.projectGo.dto.DistributedHomeworks;
import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.type.HomeworksEvaluateType;
import com.oracle.projectGo.utils.error.BusinessException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class HomeworkService {
    private final HomeworkDao homeworkDao;
    private final DistributedHomeworksDao distributedHomeworksDao;
    public int insertHomework(Homeworks homework){
//        int result = homeworkDao.insertHomework(homework);
//        if (result == 0){
//            throw new RuntimeException("숙제 추가중 오류발생");
//        }
        return homeworkDao.insertHomework(homework);
    }

    public  int getTotalHomeworksCnt(Homeworks homework){
        return homeworkDao.getTotalHomeworksCnt(homework);
    }

    public List<Homeworks> getHomeworksList(Homeworks homework){
        return homeworkDao.getHomeworksList(homework);
    }

    public List<String> getDistinctHomeworkTitles(int educatorId) {
        return homeworkDao.getDistinctHomeworkTitles(educatorId);
    }

    public int distributedHomeworksBulkInsert(List<DistributedHomeworks> distributedHomeworksList) {
        return distributedHomeworksDao.bulkInsert(distributedHomeworksList);
    }

    public List<DistributedHomeworks> getDistributedHomeworks(DistributedHomeworks pDistributedHomework) {
        return distributedHomeworksDao.getDistributedHomeworks(pDistributedHomework);
    }

    public int updateEvaluation(List<DistributedHomeworks> evaluations) {
        return distributedHomeworksDao.updateEvaluation(evaluations);
    }

    public int updateSubmission(List<DistributedHomeworks> submissions) {
        return distributedHomeworksDao.updateSubmission(submissions);
    }
}
