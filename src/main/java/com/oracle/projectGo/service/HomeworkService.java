package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.HomeworkDao;
import com.oracle.projectGo.dto.Homeworks;
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
    public int insertHomework(Homeworks homework){
//        int result = homeworkDao.insertHomework(homework);
//        if (result == 0){
//            throw new RuntimeException("숙제 추가중 오류발생");
//        }
        return homeworkDao.insertHomework(homework);
    }

    public  int getTotalHomeworksCnt(){
        return homeworkDao.getTotalHomeworksCnt();
    }

    public List<Homeworks> getHomeworksList(Homeworks homework){
        return homeworkDao.getHomeworksList(homework);
    }
}
