package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.Payments;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.GameService;
import com.oracle.projectGo.service.Paging;
import com.oracle.projectGo.service.PaymentService;
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
    private final PaymentService ps;
//-----------------------------------------------------------------
    @RequestMapping(value = "gameContent")
    public String gameContent(){

        return "admin/game/gameContentInsert";
    }

    // 게임콘텐츠 insert
    @RequestMapping(value = "gameContentInsert", method = RequestMethod.POST)
    public String gameContentInsert(@Valid @ModelAttribute GameContents gameContents, BindingResult bindingResult,
                                    @RequestParam(value = "file1", required = false)MultipartFile file1,
                                    HttpServletRequest request, Model model) throws IOException {
        System.out.println("GameController gameContentInsert Start !");
        System.out.println("구독 기간(개월 수)-> " + gameContents.getSubscribeDate());

        //                  실제 파일 시스템 경로를 가져옴
        String uploadPath = request.getServletContext().getRealPath("/upload/gameContents/");
        //                          업로드 된 파일의 원래 파일 이름을 가져옴, 파일 내용을 배열로 가져옴, 파일을 실제 업로드하고 저장
        String saveName = uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
        log.info("saveName: "      + saveName);                         // 저장되는 파일명
        log.info("originalName : " + file1.getOriginalFilename());		// 원본 파일명
        log.info("size : "         + file1.getSize());					// 파일 사이즈
        log.info("contextType : "  + file1.getContentType());			// 파일 타입
        log.info("uploadPath : "   + uploadPath);						// 파일 저장되는 주소

        // 로그인 한 유저 정보 세팅
        Users users = us.getLoggedInUserInfo();
        log.info("로그인 getUserType : {}", users.getUserType());
        gameContents.setUserId(users.getId());
        gameContents.setImagePath(uploadPath);
        gameContents.setImageName(saveName);

        int gameContentInsert = gs.gameContentInsert(gameContents);
        System.out.println("GameController gameContentInsert-> " + gameContentInsert);

        return "redirect:gameContentSelect";
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

//-----------------------------------------------------------------

    // 게임컨텐츠 구독 전 모든 리스트 조회(운영자 화면)
    @RequestMapping(value = "/gameContentSelect")
    public String gameSelect(String currentPage, Model model){

        // 총 갯수(운영자 화면)
        int gameContentsTotalCount = gs.gameContentsTotalCount();
        System.out.println("GameController gameContentsTotalCount-> " + gameContentsTotalCount);

        // 페이징 작업
        GameContents gameContents = new GameContents();
        Paging page = new Paging(gameContentsTotalCount, currentPage);
        gameContents.setStart(page.getStart());
        gameContents.setEnd(page.getEnd());

        // 리스트 조회(운영자 화면)
        List<GameContents> gameContentsList = gs.gameContentsList(gameContents);
        System.out.println("GameController gameContentsList.size()-> " + gameContentsList.size());

        model.addAttribute("gameContentsTotalCount", gameContentsTotalCount);
        model.addAttribute("page", page);
        model.addAttribute("gameContentsList", gameContentsList);

        return "admin/game/gameContentSelect";
    }

    // 사용자가 공개/비공개 설정
    @ResponseBody
    @RequestMapping(value = "deleteCheck")
    public String deleteCheck(int id){
        String result = null;
        System.out.println("GameController deleteCheck Start");

        Payments payments = new Payments();
        payments.setContentId(id);
        System.out.println("payments.getContentId()-> " + payments.getContentId());

        GameContents gameContents = new GameContents();
        gameContents.setId(id);
        System.out.println("gameContents.getId()-> " + gameContents.getId());

        GameContents pGameContents =  gs.getGameContentsById(id);
        log.info("pGameContents:{}",pGameContents);

        if ( pGameContents.getIsDeleted().equals("1") ){
            /* TODO : 비공개상태인 게임컨텐츠를 공개상태로 변경.*/
            // 게임테이블의 isDeleted = 비공개(1) 이라면 공개로 변경하기 위한 체크

            // 비공개(1) -> 공개(0)
            int deleteNo = gs.deleteNo(gameContents);
            System.out.println("1이면 공개 처리-> " + deleteNo);
            result = "public";
        } else {
            /* TODO : 공개상태인 게임컨텐츠를 비공개상태로 변경.*/
            // Payments 테이블에 gameContents의 id의 갯수로 존재 여부 체크
            int deleteCheck = ps.deleteCheck(payments);
            System.out.println("Payments 테이블에 존재여부 확인(1부터 존재)-> " + deleteCheck);

            // 공개(0) -> 비공개(1)
            if(deleteCheck > 0) {  // payments 테이블에 존재하지 않음
                result = "paymentExist";
            } else{
                int deleteYes = gs.deleteYes(gameContents);
                System.out.println("1이면 비공개 처리-> " + deleteYes);
                result = "nondisclosure";
            }
        }

        return result;
    }





}
