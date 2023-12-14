package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.LearningGroupDao;
import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.Users;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class LearningGroupService {
    private final LearningGroupDao groupDao;

    public int totalLearningContentCnt() {
        return groupDao.totalLearningContentCnt();
    }

    public List<GameContents> learningContentList(GameContents gameContents) {
        List<GameContents> learningContentList = groupDao.learningContentList(gameContents);

        if (learningContentList == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "게임컨텐츠 리스트가 없습니다.");
        }
        return learningContentList;
    }

    public GameContents insertFormLearningContent(int id) {
        GameContents insertFormLearningContent = groupDao.insertFormLearningContent(id);
        return insertFormLearningContent;
    }

    public int insertLearningGroup(Map<String, Object> params) {
        int insertLearningGroup = groupDao.insertLearningGroup(params);
        return insertLearningGroup;
    }

    public int totalLearningGroupCnt() {
        return groupDao.totalLearningGroupCnt();
    }

    public List<LearningGroup> learningGroupList() {
        List<LearningGroup> learningGroupList = groupDao.learningGroupList();

        if (learningGroupList == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "학습그룹 리스트가 없습니다.");
        }
        return learningGroupList;
    }

    public List<LearningGroup> detailLearningGroup(LearningGroup learningGroup) {
        List<LearningGroup> detailLearningGroup = groupDao.detailLearningGroup(learningGroup);
        return detailLearningGroup;
    }

    public int totalApprovalGroupMemberCnt(int id) {
        int totalApprovalGroupMemberCnt = groupDao.totalApprovalGroupMemberCnt(id);
        return totalApprovalGroupMemberCnt;
    }


    public List<Users> getGroupMemberByGroupId(int groupId) {
        return groupDao.getGroupMemberByGroupId(groupId);
    }

    public List<Users> getGroupMembersByEducatorId(int educatorId) {
        return groupDao.getGroupMembersByEducatorId(educatorId);
    }

    public List<LearningGroup> signUpLearningGroup() {
        return groupDao.signUpLearningGroup();
    }




}
