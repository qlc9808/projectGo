package com.oracle.projectGo.controller.admin;

import com.oracle.projectGo.dto.Board;
import com.oracle.projectGo.service.BoardService;
import com.oracle.projectGo.service.Paging;
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
	public String noticeBoardList(Board board, String currentPage, Model model) {

		try {
			log.info("[{}]:{}", "Noticeboard", "start");

			int path = 0;

			board.setBoardType("1");

			int totalnoticeboard = boardService.totalnoticeboard();

			Paging page = new Paging(totalnoticeboard, currentPage);
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());

			List<Board> listnoticeBoard = boardService.listnoticeBoard(board);


			model.addAttribute("totalnoticeboard", totalnoticeboard);
			model.addAttribute("listBoard", listnoticeBoard);
			model.addAttribute("page", page);
			model.addAttribute("path", path);

		} catch (Exception e) {
			log.error("[{}]:{}", "Noticeboard", e.getMessage());
		} finally {
			log.info("[{}]:{}", "Noticeboard", "end");
		}

		return "admin/notice/notice";
	}
	@RequestMapping(value = "noticeInsert")
	public String noticeInsert(Board board, Model model) {

		try {
			log.info("[{}]:{}", "admin noticeInsert", "start");

			board.setBoardType("1");
			boardService.noticeInsert(board);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin noticeInsert", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin noticeInsert", "end");
		}

			return "redirect:/admin/notice/notice";
	}

	@RequestMapping(value = "noticeInsertForm")
	public String noticeInsertForm(Model model) {


		try {
			log.info("[{}]:{}", "admin noticeInsertForm", "start");

		} catch (Exception e) {
			log.error("[{}]:{}", "admin accomodationInsertForm", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin accomodationInsertForm", "end");
		}
		return "admin/notice/noticeInsertForm";
	}

	@RequestMapping(value = "notice/update")
	public String noticeUpdate(Board board, String currentPage, Model model) {

		int userId = board.getUserId();

		log.info("userId->"+userId);

		try {
			log.info("[{}]:{}", "admin noticeUpdate", "start");
			int result = boardService.noticeUpdate(board);

			model.addAttribute("currentPage", currentPage);
			model.addAttribute("userId", board.getUserId());
		} catch (Exception e) {
			log.error("[{}]:{}", "admin noticeUpdate", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin noticeUpdate", "end");
		}
		return "redirect:/admin/notice/noticeDetail?userId="+userId;
	}



}









