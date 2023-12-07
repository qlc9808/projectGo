package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.service.ContentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/game")
public class GameController {

    private final ContentService cs;
//-----------------------------------------------------------------
    @RequestMapping(value = "gameContent")
    public String gameContent(){

        return "admin/game/gameContentInsert";
    }

    // 게임콘텐츠 insert
    @RequestMapping(value = "gameContentInsert", method = RequestMethod.POST)
    public String gameContentInsert(@Valid @ModelAttribute GameContents gameContents, BindingResult bindingResult,
                                    @RequestParam(value = "file1", required = false)MultipartFile file1,
                                    Model mode) throws IOException {
        System.out.println("GameController gameContentInsert Start !");

        // file upload
//        String attach_path = "upload"; // 실제 파일이 저장되는 폴더명, uploadPath의 이름과 동일하게 해야 오류 X
//        String uploadPath = request.getSession().getServletContext().getRealPath("/upload/"); // 저장 위치 지정
//        System.out.println("GameController File Upload Post Start");
//
//        String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);  // 저장되는 파일명
//        log.info("saveName: " + saveName);

        int gameContentInsert = cs.gameContentInsert(gameContents);
        System.out.println("GameController gameContentInsert-> " + gameContentInsert);
        mode.addAttribute("gameContentInsert", gameContentInsert);

        return "redirect:/gameContentInsert";  // 나중에 url 변경하기
    }

    // file upload method
//    private String uploadFile(String originalName, byte[] bytes, String uploadPath) throws IOException {
//        // universally unique identifier (UUID)
//        UUID uid = UUID.randomUUID();
//        System.out.println("uploadPath-> " + uploadPath);
//
//        // 신규 폴더(Directory) 생성
//        File fileDirectory = new File(uploadPath);
//        if(!fileDirectory.exists()) {
//            fileDirectory.mkdirs();
//            System.out.println("업로드용 폴더 생성 : " + uploadPath);
//        }
//
//        String savedName = uid.toString() + "_" + originalName;
//        System.out.println("savedName: " + savedName);
//        File target = new File(uploadPath, savedName);
//        FileCopyUtils.copy(bytes, target);
//
//        return savedName;
//    }
//-------------------------------------------------------------------------




}
