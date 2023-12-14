package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.LearningRequestDao;
import com.oracle.projectGo.dto.LearningGroupMember;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LearningRequestService {
    private final LearningRequestDao learningRequestDao;
    public int requestSignUp(LearningGroupMember member) {
        return learningRequestDao.requestSignUp(member);
    }

    public int cancelSignUp(LearningGroupMember member) {
        return learningRequestDao.cancelSignUp(member);
    }

    public LearningGroupMember remainRequest(int userId) {
        return learningRequestDao.remainRequest(userId);
    }
}
