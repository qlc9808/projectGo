package com.oracle.projectGo.controller.admin;

import com.oracle.projectGo.dto.Board;
import com.oracle.projectGo.service.BoardService;
import com.oracle.projectGo.service.Paging;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/admin/board")
public class AdminBoardController {

	private final BoardService boardService;


	//공지사항 리스트
	@RequestMapping(value = "/noticeBoardList")
	public String noticBoardList(Board board, int currentPage, Model model) {

		log.info("BoardController noticBoardList Start!!");

		board.setBoardType(String.valueOf(1)); // 분류 code 강제 지정

		// boardType를 이용해 countBoard 설정
		String countBoard = String.valueOf(boardService.boardCount(board));

		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		List<Board> noticAllList = boardService.getNoticAllList(board);

		String BoardType = "";


		model.addAttribute("board", noticAllList);
		model.addAttribute("page", page);
		model.addAttribute("BoardType", BoardType);

		return "admin/notice/notice";
	}







}

