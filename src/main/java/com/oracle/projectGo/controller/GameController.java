package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.GameService;
import com.oracle.projectGo.service.Paging;
import com.oracle.projectGo.service.UsersService;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/game")
public class GameController {

    private final UsersService us;
    private final GameService gs;
//-----------------------------------------------------------------
    @RequestMapping(value = "gameContent")
    public String gameContent(HttpServletRequest request){
//        UserInfo user = (UserInfo) request.getSession().getAttribute("userInfo");

        System.out.println("Dddd");
        System.out.println(request.getSession());
        return "admin/game/gameContentInsert";
    }

    // 게임콘텐츠 insert
    @RequestMapping(value = "gameContentInsert", method = RequestMethod.POST)
    public String gameContentInsert(@Valid @ModelAttribute GameContents gameContents, BindingResult bindingResult,
                                    @RequestParam(value = "file1", required = false)MultipartFile file1,
                                    HttpServletRequest request, Model model) throws IOException {
        System.out.println("GameController gameContentInsert Start !");

        //  file upload
//        String imagePath = "upload"; // 실제 파일이 저장되는 폴더명, uploadPath의 이름과 동일하게 해야 오류 X
         String uploadPath = request.getServletContext().getRealPath("/upload/gameContents/");
//        System.out.println("GameController File Upload Post Start");
//
        log.info("originalName : " + file1.getOriginalFilename());		// 원본 파일명
        log.info("size : "         + file1.getSize());					// 파일 사이즈
        log.info("contextType : "  + file1.getContentType());			    // 파일 타입
        log.info("uploadPath : "   + uploadPath);						    // 파일 저장되는 주소

        String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);  // 저장되는 파일명
        log.info("saveName: " + saveName);

        Users users = us.getLoggedInUserInfo();
        log.info("로그인 getUserType : {}", users.getUserType());
        gameContents.setUserId(users.getId());

        // subscribleStart(구독 시작 날짜) + subscribleDate(구독 기간) = subscribleEnd(구독 종료 날짜)
        LocalDate resultDate = gameContents.getSubscribleStart().toLocalDate().plusMonths(gameContents.getSubscribeDate());
        Date resultSqlDate = java.sql.Date.valueOf(resultDate);
        gameContents.setSubscribleEnd((java.sql.Date) resultSqlDate);

        gameContents.setImagePath(uploadPath);
        gameContents.setImageName(saveName);

        System.out.println("구독 시작 날짜-> "    + gameContents.getSubscribleStart());
        System.out.println("구독 기간(개월수)-> " + gameContents.getSubscribeDate());
        System.out.println("구독 종료 날짜-> "    + resultSqlDate);

        // 관리자(1)만 게임 콘텐츠 등록 버튼 보임
//        int userTypeResult = Integer.parseInt(users.getUserType());
//        int result = 0;
//        if(userTypeResult == 1){
//            result = 1;
//        } else {
//            result = 0;
//        }

        //----------------------------------------------------------
        int gameContentInsert = gs.gameContentInsert(gameContents);
        //----------------------------------------------------------
        System.out.println("GameController gameContentInsert-> " + gameContentInsert);

//        model.addAttribute("result", result);

        return "redirect:gameContent";  // 나중에 url 변경하기
    }

    // file upload method
    private String uploadFile(String originalName, byte[] bytes, String uploadPath) throws IOException {
        // universally unique identifier (UUID)
        UUID uid = UUID.randomUUID();
        System.out.println("uploadPath-> " + uploadPath);

        // 신규 폴더(Directory) 생성
        File fileDirectory = new File(uploadPath);
        if(!fileDirectory.exists()) {
            fileDirectory.mkdirs();
            System.out.println("업로드용 폴더 생성 : " + uploadPath);
        }

        String savedName = uid.toString() + "_" + originalName;
        System.out.println("savedName: " + savedName);
        File target = new File(uploadPath, savedName);
        FileCopyUtils.copy(bytes, target);

        return savedName;
    }


    // 게임컨텐츠 구독 전 모든 리스트 조회(운영자 화면)
    @RequestMapping(value = "/gameContentSelect")
    public String gameSelect(GameContents gameContents, String currentPage, Model model){

        // 총 갯수
        int gameContentsTotalCount = gs.gameContentsTotalCount();
        System.out.println("GameController gameContentsTotalCount-> " + gameContentsTotalCount);
        model.addAttribute("gameContentsTotalCount", gameContentsTotalCount);

        // 리스트 조회
        List<GameContents> gameContentsList = gs.gameContentsList(gameContents);
        System.out.println("GameController gameContentsList.size()-> " + gameContentsList.size());
        model.addAttribute("gameContentsList", gameContentsList);

        // 페이징 작업
        Paging page = new Paging(gameContentsTotalCount, currentPage);
        gameContents.setStart(page.getStart());
        gameContents.setEnd(page.getEnd());
        model.addAttribute("page", page);

        return "admin/game/gameContentSelect";
    }














}
