package com.oracle.projectGo.controller.admin;

import com.oracle.projectGo.dto.EducationalResources;
import com.oracle.projectGo.service.AdminResourceService;
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
    @RequestMapping(value = "/uploadForm")
    public String educationUploadForm() {

        return "admin/resource/upload";
    }
    @PostMapping(value = "/upload")
    public String educationUpload(EducationalResources educationalResources, Model model) {
        educationalResources.setUserId(5);
        educationalResources.setContentId(5);
        // 임의로 설정한 유저ID, 게임컨텐츠ID값 나중에 수정
        log.info(educationalResources.toString());

        int result = adminResourceService.educationUpload(educationalResources);
        log.info(String.valueOf(result));

        return "forward:admin/resource/listEdu";
    }

    @GetMapping(value = "/listEdu")
    public String educationList(HttpSession session) {
        // 교육자료 페이지로 이동
        return "admin/resource/listEdu";
    }

    @GetMapping(value = "/api/listEdu")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> educationList() {
        // ajax로 교육자료 리스트 불러오기
        Map<String, Object> response = new HashMap<>();

        List<EducationalResources> listEdu = adminResourceService.listEdu();
        log.info(listEdu.toString());
        response.put("listEdu", listEdu);

        return ResponseEntity.ok(response);
    }
}
