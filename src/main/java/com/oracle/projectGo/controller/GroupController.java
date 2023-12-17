package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.LearningGroupService;
import com.oracle.projectGo.service.Paging;
import com.oracle.projectGo.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/group")
public class GroupController {

    private final LearningGroupService groupService;
    private final UsersService usersService;

    // 로그인한 회원(교육자)이 소유한 게임콘텐츠 리스트 조회
    @RequestMapping(value = "listLearningContent")
    public String listlearningContent(GameContents gameContents, String currentPage, Model model) {
        Users users = usersService.getLoggedInUserInfo();
        int userId = users.getId();

        try {
            // LearningContent Count 조회
            int totalLearningContentCnt = groupService.totalLearningContentCnt(userId);

            // LearningContentList 조회
            List<GameContents> learningContentList = groupService.learningContentList(userId);

            //

            // paging 처리
            Paging page = new Paging(totalLearningContentCnt, currentPage);
            gameContents.setStart(page.getCurrentPage());
            gameContents.setEnd(page.getEnd());

            model.addAttribute("learningContentCnt", totalLearningContentCnt);
            model.addAttribute("learningContentList", learningContentList);
            model.addAttribute("currentPage", currentPage);
        } catch (Exception e) {
            log.error("GroupController listlearningContent e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController listlearningContent end");
        }
        return "educate/learningGroup/listLearningContent";
    }

    // 게임콘텐츠에서 그룹을 생성하는 폼
    @RequestMapping(value = "insertFormLearningContent")
    public String insertFormLearningContent(int id, Model model){
        log.info("id : " + id);

        try {
            GameContents insertFormLearningContent = groupService.insertFormLearningContent(id);
            log.info("insertFormLearningContent : " + insertFormLearningContent);

            model.addAttribute("insertFormLearningContent", insertFormLearningContent);
        } catch (Exception e) {
            log.error("GroupController insertFormLearningContent e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController insertFormLearningContent end");
        }

        return "educate/learningGroup/insertFormLearningContent";
    }

    // 게임콘텐츠에서 그룹을 생성
    @RequestMapping(value = "insertLearningGroup", method = RequestMethod.POST)
    public String insertLearningGroup(@RequestParam("id")        int id,
                                      @RequestParam("userId")    int userId,
                                      @RequestParam("GroupName") String groupName,
                                      @RequestParam("GroupSize") int groupSize,
                                      @RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
                                      @RequestParam("endDate")   @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
                                      @RequestParam("GroupEtc1") String groupEtc1,
                                      @RequestParam("GroupEtc2") String groupEtc2, Model model) {

        Map<String, Object> params = new HashMap<>();
        params.put("id",        id);
        params.put("userId",    userId);
        params.put("GroupName", groupName);
        params.put("GroupSize", groupSize);
        params.put("startDate", startDate);
        params.put("endDate",   endDate);
        params.put("GroupEtc1", groupEtc1);
        params.put("GroupEtc2", groupEtc2);

        log.info("params : " + params);

        try {
            int insertLearningGroup = groupService.insertLearningGroup(params);
        } catch (Exception e) {
            log.error("GroupController insertLearningGroup e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController insertLearningGroup end");
        }

        return "redirect:/group/listLearningGroup";
    }

    // 로그인한 유저(교육자)의 학습그룹 리스트 조회
    @RequestMapping(value = "listLearningGroup")
    public String listLearningGroup(LearningGroup learningGroup, String currentPage, Model model) {
        Users users = usersService.getLoggedInUserInfo();
        int userId = users.getId();

        try {
            // LearningGroup Count 조회
            int totalLearningGroupCnt = groupService.totalLearningGroupCnt(userId);
            log.info("totalLearningGroupCnt : " + totalLearningGroupCnt);

            List<LearningGroup> learningGroupList = groupService.learningGroupList(userId);
            log.info("learningGroupList : " + learningGroupList);

            // paging 처리
            Paging page = new Paging(totalLearningGroupCnt, currentPage);
            learningGroup.setStart(page.getCurrentPage());
            learningGroup.setEnd(page.getEnd());

            model.addAttribute("totalLearningGroupCnt", totalLearningGroupCnt);
            model.addAttribute("learningGroupList", learningGroupList);
            model.addAttribute("currentPage", currentPage);

        } catch (Exception e) {
            log.error("GroupController listGroupContent e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController listGroupContent end");
        }
        return "educate/learningGroup/listLearningGroup";
    }

    // 학습그룹의 상세조회
    @RequestMapping(value = "detailLearningGroup")
    public String detailLearningGroup(LearningGroup learningGroup, Model model){
        log.info("learningGroup : " + learningGroup);
        try {
            List<LearningGroup> detailLearningGroup = groupService.detailLearningGroup(learningGroup);
            log.info("detailLearningGroup : " + detailLearningGroup);

            model.addAttribute("detailLearningGroup", detailLearningGroup);
        } catch (Exception e) {
            log.error("GroupController detailLearningGroup e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController detailLearningGroup end");
        }
        return "educate/learningGroup/detailLearningGroup";
    }

    @RequestMapping(value = "updateFormLearningGroup")
    public String updateFormLearningGroup(int id, Model model) {
        log.info("id : " + id);
        try {
            LearningGroup updateFormLearningGroup = groupService.updateFormLearningGroup(id);
            log.info("updateFormLearningGroup : " + updateFormLearningGroup);

            model.addAttribute("updateFormLearningGroup", updateFormLearningGroup);
        } catch (Exception e) {
            log.error("GroupController updateFormLearningGroup e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController updateFormLearningGroup end");
        }

        return "educate/learningGroup/updateFormLearningGroup";
    }

    @RequestMapping(value = "updateLearningGroup")
    public String updateLearningGroup(@RequestParam("id")        int id,
                                      @RequestParam("userId")    int userId,
                                      @RequestParam("groupName") String groupName,
                                      @RequestParam("groupSize") int groupSize,
                                      @RequestParam("startDate") @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
                                      @RequestParam("endDate")   @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
                                      @RequestParam("groupEtc1") String groupEtc1,
                                      @RequestParam("groupEtc2") String groupEtc2) {

        Map<String, Object> params = new HashMap<>();
        params.put("id",        id);
        params.put("userId",    userId);
        params.put("groupName", groupName);
        params.put("groupSize", groupSize);
        params.put("startDate", startDate);
        params.put("endDate",   endDate);
        params.put("groupEtc1", groupEtc1);
        params.put("groupEtc2", groupEtc2);

        log.info("params : " + params);

        try {
            int updateLearningGroup = groupService.updateLearningGroup(params);
            log.info("updateLearningGroup : " + updateLearningGroup);
        } catch (Exception e) {
            log.error("GroupController updateLearningGroup e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController updateLearningGroup end");
        }

        return "redirect:/group/listLearningGroup";
    }

    @RequestMapping(value = "deleteLearningGroup")
    public String deleteLearningGroup(int id) {
        log.info("id : " + id);
        try {
            int deleteLearningGroupMember = groupService.deleteLearningGroupMember(id);
            log.info("deleteLearningGroupMember : " + deleteLearningGroupMember);

            int deleteLearningGroup = groupService.deleteLearningGroup(id);
            log.info("deleteLearningGroup : " + deleteLearningGroup);

        } catch (Exception e) {
            log.error("GroupController deleteLearningGroup e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController deleteLearningGroup end");
        }

        return "redirect:/group/listLearningGroup";
    }

    //
    @RequestMapping(value = "approvalGroupMember")
    public String approvalGroupMember(int id, Model model, String currentPage) {
        Users users = usersService.getLoggedInUserInfo();
        int userId = users.getId();
        log.info("userId : " + userId);

        try {
            int totalApprovalGroupMemberCnt = groupService.totalApprovalGroupMemberCnt(userId);
            log.info("totalApprovalGroupMemberCnt : " + totalApprovalGroupMemberCnt);


            model.addAttribute("totalApprovalMemberCnt", totalApprovalGroupMemberCnt);
        } catch (Exception e) {
            log.error("GroupController approvalGroupMember e.getMessage() : " + e.getMessage());
        } finally {
            log.info("GroupController approvalGroupMember end");
        }

        return "educate/learningGroup/approvalGroupMember";
    }


    @ResponseBody
    @RequestMapping(value="getGroupMemberByGroupId",method = RequestMethod.GET)
    public ResponseEntity<List<Users>> getGroupMemberByGroupId(@RequestParam int groupId) {

        List<Users> homeworkTitleList = groupService.getGroupMemberByGroupId(groupId);

        return ResponseEntity.ok(homeworkTitleList);
    }

    @ResponseBody
    @RequestMapping(value="getGroupMembersByEducatorId",method = RequestMethod.GET)
    public ResponseEntity<List<Users>> getGroupMembersByEducatorId(@RequestParam int educatorId) {

        List<Users> homeworkTitleList = groupService.getGroupMembersByEducatorId(educatorId);

        return ResponseEntity.ok(homeworkTitleList);
    }
}
