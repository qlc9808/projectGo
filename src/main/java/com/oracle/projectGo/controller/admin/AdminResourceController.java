package com.oracle.projectGo.controller.admin;

import com.oracle.projectGo.dto.EducationalResources;
import com.oracle.projectGo.dto.Payments;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.AdminResourceService;
import com.oracle.projectGo.service.UsersService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/admin/resource")
public class AdminResourceController {
    private final AdminResourceService adminResourceService;
    private final UsersService usersService;
    @RequestMapping(value = "/uploadForm")
    public String educationUploadForm() {

        return "admin/resource/upload";
    }
    @GetMapping(value = "/upload")
    public String educationUpload(EducationalResources educationalResources, Model model) {
        educationalResources.setUserId(5);
        educationalResources.setContentId(5);
        // 임의로 설정한 유저ID, 게임컨텐츠ID값 나중에 수정
        log.info(educationalResources.toString());

        int result = adminResourceService.educationUpload(educationalResources);
        log.info(String.valueOf(result));

        return "redirect:/admin/resource/listEdu";
    }

    @GetMapping(value = "/listEdu")
    public String educationList(Users users, Model model) {

        users = usersService.getLoggedInUserInfo();
        model.addAttribute("users", users);

        return "admin/resource/listEdu";
    }

    @GetMapping(value = "/api/listEdu")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> educationList(Users users) {
        users = usersService.getLoggedInUserInfo();
        log.info("111"+String.valueOf(users));

        // ajax로 교육자료 리스트 불러오기
        Map<String, Object> response = new HashMap<>();

        List<EducationalResources> listEdu = adminResourceService.listEdu(users);
        transNaming(listEdu);

        log.info("222"+listEdu.toString());
        response.put("listEdu", listEdu);

        return ResponseEntity.ok(response);
    }

    @GetMapping(value = "/detailEdu")
    public String detailEdu(int id, Model model) {
        log.info(String.valueOf(id));

        model.addAttribute("id",id);

        return "admin/resource/detailEdu";
    }

    @GetMapping(value = "api/detailEdu")
    @ResponseBody
    public ResponseEntity<Map<Object, String>> detailEdu(Users users) {
        Map<Object, String> response = new HashMap<>();
        users = usersService.getLoggedInUserInfo();


        return ResponseEntity.ok(response);
    }

    @GetMapping(value = "/updateEduForm")
    public String updateEduForm(int id, Model model) {

        EducationalResources edu = adminResourceService.detailEdu(id);
        log.info(String.valueOf(edu));

        model.addAttribute("edu",edu);

        return "admin/resource/updateEdu";
    }

    @DeleteMapping(value = "/deleteEdu")
    public ResponseEntity<Map<Object, String>> deleteEdu(int id) {
        Map<Object, String> response = new HashMap<>();
        int result = adminResourceService.deleteEdu(id);

        response.put("result", Integer.toString(result));
        return ResponseEntity.ok(response);
    }






    private void transNaming(List<EducationalResources> list) {
        // 결제방법, 결제상태를 필요한 문자열로 변환
        for (EducationalResources item : list) {
            switch (item.getResourceType()) {
                case "1":
                    item.setResourceType("튜토리얼");
                    break;
                case "2":
                    item.setResourceType("교육영상");
                    break;
            }
        }

        for (EducationalResources item : list) {
            switch (item.getServiceType()) {
                case "1":
                    item.setServiceType("무료");
                    break;
                case "2":
                    item.setServiceType("유료");
                    break;
            }
        }
    }
}
