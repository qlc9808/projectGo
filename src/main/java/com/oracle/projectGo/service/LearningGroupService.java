package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.LearningGroupDao;
import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.LearningGroupMember;
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

    public int totalLearningContentCnt(GameContents gameContents) {
        int totalLearningContentCnt = groupDao.totalLearningContentCnt(gameContents);
        return totalLearningContentCnt;
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

    public int insertLearningGroup(LearningGroup learningGroup) {
        int insertLearningGroup = groupDao.insertLearningGroup(learningGroup);
        return insertLearningGroup;
    }

    public int totalLearningGroupCnt(LearningGroup learningGroup) {
        return groupDao.totalLearningGroupCnt(learningGroup);
    }

    public List<LearningGroup> learningGroupList(LearningGroup learningGroup) {
        List<LearningGroup> learningGroupList = groupDao.learningGroupList(learningGroup);

        if (learningGroupList == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "학습그룹 리스트가 없습니다.");
        }
        return learningGroupList;
    }

    public List<LearningGroup> detailLearningGroup(LearningGroup learningGroup) {
        List<LearningGroup> detailLearningGroup = groupDao.detailLearningGroup(learningGroup);
        return detailLearningGroup;
    }

    public LearningGroup updateFormLearningGroup(int id) {
        LearningGroup updateFormLearningGroup = groupDao.updateFormLearningGroup(id);

        return updateFormLearningGroup;
    }

    public int updateLearningGroup(LearningGroup learningGroup) {
        int updateLearningGroup = groupDao.updateLearningGroup(learningGroup);

        return updateLearningGroup;
    }

    public int deleteLearningGroupMember(int id) {
        int deleteLearningGroupMember = groupDao.deleteLearningGroupMember(id);

        return deleteLearningGroupMember;
    }

    public int deleteLearningGroup(int id) {
        int deleteLearningGroup = groupDao.deleteLearningGroup(id);

        return deleteLearningGroup;
    }

    public int totalApprovalGroupMemberCnt(int userId) {
        int totalApprovalGroupMemberCnt = groupDao.totalApprovalGroupMemberCnt(userId);

        return totalApprovalGroupMemberCnt;
    }

    public List<LearningGroupMember> learningGroupMembers(int userId) {
        List<LearningGroupMember> learningGroupMembers = groupDao.learningGroupMembers(userId);

        return learningGroupMembers;
    }


    public List<Users> getGroupMemberByGroupId(int groupId) {
        return groupDao.getGroupMemberByGroupId(groupId);
    }

    public List<Users> getGroupMembersByEducatorId(int educatorId) {
        return groupDao.getGroupMembersByEducatorId(educatorId);
    }

    public List<Users> getUsersListByGroupInfo(LearningGroup learningGroup) {
        return groupDao.getUsersListByGroupInfo(learningGroup);
    }

    public List<LearningGroup> signUpLearningGroup() {
        return groupDao.signUpLearningGroup();
    }



}
