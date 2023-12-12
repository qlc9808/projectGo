package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.LearningGroupDao;
import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.Users;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class LearningGroupService {
    private final LearningGroupDao groupDao;

    public int totalGroupContentCnt() {
        return groupDao.totalGroupContentCnt();
    }

    public List<LearningGroup> learningGroupList(LearningGroup learningGroup) {
        List<LearningGroup> learningGroupList = groupDao.learningGroupList(learningGroup);

        if (learningGroupList == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "학습그룹 리스트가 없습니다.");
        }

        return learningGroupList;
    }

    public LearningGroup detailGroupContent(int userId) {
        LearningGroup detailGroupContent = groupDao.detailGroupContent(userId);

        return detailGroupContent;
    }

    public List<Users> getGroupMemberByGroupId(int groupId) {
        return groupDao.getGroupMemberByGroupId(groupId);
    }

    public List<Users> getGroupMembersByEducatorId(int educatorId) {
        return groupDao.getGroupMembersByEducatorId(educatorId);
    }
}
