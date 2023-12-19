package com.oracle.projectGo.controller.admin;

import com.oracle.projectGo.dto.Board;
import com.oracle.projectGo.service.BoardPaging;
import com.oracle.projectGo.service.BoardService;
import com.oracle.projectGo.service.Paging;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/admin/board")
public class AdminBoardController {

	private final BoardService boardService;


	//공지사항 리스트
	@RequestMapping(value = "/noticeBoardList")
	public String noticeBoardList(Integer pageSize, Board board, String currentPage, Model model) {

		if (pageSize == null) {
			pageSize = 10; // 기본값 설정
		}
		log.info("PageSize: " + pageSize);

		try {
			log.info("[{}]:{}", "Noticeboard", "start");

			int path = 0;

			int totalnoticeboard = boardService.totalnoticeboard();

			BoardPaging page = new BoardPaging(totalnoticeboard, currentPage, pageSize);
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());


			List<Board> listnoticeBoard = boardService.listnoticeBoard(board);

			model.addAttribute("pageSize", pageSize);
			model.addAttribute("totalnoticeboard", totalnoticeboard);
			model.addAttribute("listnoticeBoard", listnoticeBoard);
			model.addAttribute("page", page);
			model.addAttribute("path", path);

		} catch (Exception e) {
			log.error("[{}]:{}", "Noticeboard", e.getMessage());
		} finally {
			log.info("[{}]:{}", "Noticeboard", "end");
		}

		return "admin/notice/notice";
	}

	@RequestMapping(value = "noticeDetail")
	public String noticeDetail(int id, String currentPage, Model model) {

		try {
			log.info("[{}]:{}", "admin noticeDetail", "start");
			Board board = boardService.detailnotice(id);


			boardService.increaseReadCount(id); // 조회수 증가
			model.addAttribute("board", board);
			model.addAttribute("currentPage", currentPage);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin noticeDetail", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin noticeDetail", "end");
		}
		return "admin/notice/noticeDetail";
	}



	@RequestMapping(value = "/noticeInsert")
	public String noticeInsert(@ModelAttribute Board board, @RequestParam("publishDate") String publishDateStr, @RequestParam("publishOption") String publishOption, @RequestParam("isPinned") boolean isPinned,
							   @RequestParam("file") MultipartFile file, Model model) {

		board.setUserId(1);
		log.info("userId: {}", board.getUserId());


		try {
			log.info("[{}]:{}", "admin noticeInsert", "start");

			// 게시일자 처리
			Timestamp createdAt;
			if ("immediate".equals(publishOption)) {
				createdAt = Timestamp.valueOf(LocalDateTime.now());
			} else {
				createdAt = Timestamp.valueOf(LocalDateTime.parse(publishDateStr, DateTimeFormatter.ISO_LOCAL_DATE_TIME));
			}
			board.setCreatedAt(createdAt);

			if (!file.isEmpty()) {
				// 파일을 파일시스템에 저장
				String filePath = "path/to/your/directory/" + file.getOriginalFilename();
				File dest = new File(filePath);
				file.transferTo(dest);

				// 파일 경로를 Board에 설정
				board.setFilePath(filePath);
				board.setFileName(file.getOriginalFilename());
			}


			board.setIsPinned(isPinned);
			board.setBoardType("1");
			boardService.noticeInsert(board);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin noticeInsert", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin noticeInsert", "end");
		}

			return "redirect:/admin/board/noticeBoardList";
	}

	@RequestMapping(value = "/noticeInsertForm")
	public String noticeInsertForm(Board board, Model model) {

		board.setUserId(1);
		log.info("userId: {}", board.getUserId());


		try {
			log.info("[{}]:{}", "admin noticeInsertForm", "start");

		} catch (Exception e) {
			log.error("[{}]:{}", "admin accomodationInsertForm", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin accomodationInsertForm", "end");
		}
		return "admin/notice/noticeInsertForm";
	}

	@RequestMapping(value = "/noticeUpdate")
	public String noticeUpdate(Board board, String currentPage, Model model) {

		board.setBoardType("1");
		int id = board.getId();

		log.info("id->"+id);

		try {
			log.info("[{}]:{}", "admin noticeUpdate", "start");
			int result = boardService.noticeUpdate(board);

			model.addAttribute("currentPage", currentPage);
			model.addAttribute("id", board.getId());
		} catch (Exception e) {
			log.error("[{}]:{}", "admin noticeUpdate", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin noticeUpdate", "end");
		}
		return "redirect:/admin/notice/noticeDetail?id="+id;
	}

	@GetMapping(value="/noticeUpdateForm")
	public String noticeUpdateForm(int id, String currentPage, Model model) {
		try {
			log.info("[{}]:{}", "admin noticeUpdateForm", "start");

			Board board = boardService.detailnotice(id);


			model.addAttribute("currentPage", currentPage);
			model.addAttribute("userId",id);
			model.addAttribute("board", board);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin noticeUpdateForm", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin noticeUpdateForm", "end");
		}
		return "admin/notice/noticeUpdateForm";
	}

	@RequestMapping(value = "noticeDelete")
	public String noticeDelete(int id) {
		try {
			log.info("[{}]:{}", "admin noticeDelete", "start");
			int result = boardService.noticeDelete(id);
			log.info("Delete result: " + result);
		} catch (Exception e) {
			log.error("[{}]:{}", "admin noticeDelete", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin noticeDelete", "end");
		}
		return "forward:admin/notice/notice";
	}

	@RequestMapping(value = "noticeSearch")
	public String noticeSearch(Board board, Integer pageSize, String currentPage, Model model, HttpServletRequest request) {
		try {
			log.info("[{}]{}:{}", "admin noticeSearch", "start");
			int totalSearchnotice = boardService.totalSearchnotice(board);

			if (pageSize == null) {
				pageSize = 10; // 기본값 설정
			}


				int path = 1;
				String keyword = request.getParameter("keyword");
				String title = request.getParameter("title");
				String userId = request.getParameter("userId");
				String content = request.getParameter("content");
				String searchType = request.getParameter("searchType");



				BoardPaging page = new BoardPaging(totalSearchnotice, currentPage, pageSize);
				board.setStart(page.getStart());
				board.setEnd(page.getEnd());
				board.setSearchType(searchType);


				List<Board> listSearchNotice = boardService.listSearchNotice(board);


				model.addAttribute("totalnoticeboard", totalSearchnotice);
				model.addAttribute("listnoticeBoard", listSearchNotice);
				model.addAttribute("page", page);
				model.addAttribute("path", path);
				model.addAttribute("keyword", keyword);
				model.addAttribute("title", title);
				model.addAttribute("content", content);
				model.addAttribute("userId", userId);

			} catch(Exception e){
				log.error("[{}]:{}", "admin noticeSearch", e.getMessage());
			} finally{
				log.info("[{}]:{}", "admin notice", "end");
			}
			return "admin/notice/notice";


	}


	@RequestMapping(value = "/QNABoardList")
	public String QNABoardList(int pageSize, Board board, String currentPage, Model model) {

		try {
			log.info("[{}]:{}", "Noticeboard", "start");

			int path = 0;

			int totalQNAboard = boardService.totalQNAboard();

			BoardPaging page = new BoardPaging(totalQNAboard, currentPage, pageSize);
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());

			List<Board> listQNABoard = boardService.listQNABoard(board);


			model.addAttribute("totalQNAboard", totalQNAboard);
			model.addAttribute("listQNABoard", listQNABoard);
			model.addAttribute("page", page);
			model.addAttribute("path", path);

		} catch (Exception e) {
			log.error("[{}]:{}", "Noticeboard", e.getMessage());
		} finally {
			log.info("[{}]:{}", "Noticeboard", "end");
		}

		return "admin/qna/qna";
	}

	@RequestMapping(value = "QNADetail")
	public String QNADetail(int id, String currentPage, Model model) {

		try {
			log.info("[{}]:{}", "admin QNADetail", "start");
			Board board = boardService.detailQNA(id);

			model.addAttribute("board", board);
			model.addAttribute("currentPage", currentPage);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin QNADetail", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin QNADetail", "end");
		}
		return "admin/qna/qnaDetail";
	}

	@RequestMapping(value = "/QNAInsert")
	public String QNAInsert(Board board, Model model) {

		try {
			log.info("[{}]:{}", "admin QNAInsert", "start");

			board.setBoardType("3");
			boardService.QNAInsert(board);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin QNAInsert", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin QNAInsert", "end");
		}

		return "redirect:/admin/board/qna";
	}

	@RequestMapping(value = "/QNAInsertForm")
	public String QNAInsertForm(Model model) {


		try {
			log.info("[{}]:{}", "admin QNAInsertForm", "start");

		} catch (Exception e) {
			log.error("[{}]:{}", "admin QNAInsertForm", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin QNAInsertForm", "end");
		}
		return "admin/qna/qnaInsertForm";
	}

	@RequestMapping(value = "/QNAUpdate")
	public String QNAUpdate(Board board, String currentPage, Model model) {

		board.setBoardType("3");
		int id = board.getId();

		log.info("id->"+id);

		try {
			log.info("[{}]:{}", "admin QNAUpdate", "start");
			int result = boardService.QNAUpdate(board);

			model.addAttribute("currentPage", currentPage);
			model.addAttribute("id", board.getId());
		} catch (Exception e) {
			log.error("[{}]:{}", "admin QNAUpdate", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin QNAUpdate", "end");
		}
		return "redirect:/admin/qna/qnaDetail?id="+id;
	}

	@GetMapping(value="/QNAUpdateForm")
	public String QNAUpdateForm(int id, String currentPage, Model model) {
		try {
			log.info("[{}]:{}", "admin QNAUpdateForm", "start");

			Board board = boardService.detailQNA(id);


			model.addAttribute("currentPage", currentPage);
			model.addAttribute("id",id);
			model.addAttribute("board", board);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin QNAUpdateForm", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin QNAUpdateForm", "end");
		}
		return "admin/qna/qnaUpdateForm";
	}

	@RequestMapping(value = "QNADelete")
	public String QNADelete(int id) {
		try {
			log.info("[{}]:{}", "admin QNADelete", "start");
			int result = boardService.QNADelete(id);
			log.info("QNADelete result: " + result);
		} catch (Exception e) {
			log.error("[{}]:{}", "admin noticeDelete", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin noticeDelete", "end");
		}
		return "forward:admin/qna/qna";
	}

	@RequestMapping(value = "/FAQBoardList")
	public String FAQBoardList(Board board, String currentPage, Model model) {

		try {
			log.info("[{}]:{}", "FAQboard", "start");

			int path = 0;

			int totalFAQboard = boardService.totalFAQboard();

			Paging page = new Paging(totalFAQboard, currentPage);
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());

			List<Board> listFAQBoard = boardService.listFAQBoard(board);


			model.addAttribute("totalFNAboard", totalFAQboard);
			model.addAttribute("listFNABoard", listFAQBoard);
			model.addAttribute("page", page);
			model.addAttribute("path", path);

		} catch (Exception e) {
			log.error("[{}]:{}", "FAQboard", e.getMessage());
		} finally {
			log.info("[{}]:{}", "FAQboard", "end");
		}

		return "admin/faq/faq";
	}

	@RequestMapping(value = "FAQDetail")
	public String FAQDetail(int id, String currentPage, Model model) {

		try {
			log.info("[{}]:{}", "admin FAQDetail", "start");
			Board board = boardService.detailFAQ(id);

			model.addAttribute("board", board);
			model.addAttribute("currentPage", currentPage);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin FAQDetail", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin FAQDetail", "end");
		}
		return "admin/faq/faqDetail";
	}

	@RequestMapping(value = "/FAQInsert")
	public String FAQInsert(Board board, Model model) {

		try {
			log.info("[{}]:{}", "admin FAQInsert", "start");

			board.setBoardType("2");
			boardService.FAQInsert(board);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin FAQInsert", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin FAQInsert", "end");
		}

		return "redirect:/admin/board/faq";
	}

	@RequestMapping(value = "/FAQInsertForm")
	public String FAQInsertForm(Model model) {


		try {
			log.info("[{}]:{}", "admin FAQInsertForm", "start");

		} catch (Exception e) {
			log.error("[{}]:{}", "admin FAQInsertForm", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin FAQInsertForm", "end");
		}
		return "admin/faq/faqInsertForm";
	}

	@RequestMapping(value = "/FAQUpdate")
	public String FAQUpdate(Board board, String currentPage, Model model) {

		board.setBoardType("2");
		int id = board.getId();

		log.info("id->"+id);

		try {
			log.info("[{}]:{}", "admin FAQUpdate", "start");
			int result = boardService.FAQUpdate(board);

			model.addAttribute("currentPage", currentPage);
			model.addAttribute("id", board.getId());
		} catch (Exception e) {
			log.error("[{}]:{}", "admin FAQUpdate", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin FAQUpdate", "end");
		}
		return "redirect:/admin/faq/faqDetail?id="+id;
	}

	@GetMapping(value="/FAQUpdateForm")
	public String FAQUpdateForm(int id, String currentPage, Model model) {
		try {
			log.info("[{}]:{}", "admin FAQUpdateForm", "start");

			Board board = boardService.detailFAQ(id);


			model.addAttribute("currentPage", currentPage);
			model.addAttribute("id",id);
			model.addAttribute("board", board);

		} catch (Exception e) {
			log.error("[{}]:{}", "admin FAQUpdateForm", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin FAQUpdateForm", "end");
		}
		return "admin/faq/faqUpdateForm";
	}

	@RequestMapping(value = "FAQDelete")
	public String FAQDelete(int id) {
		try {
			log.info("[{}]:{}", "admin FAQDelete", "start");
			int result = boardService.FAQDelete(id);
			log.info("FAQDelete result: " + result);
		} catch (Exception e) {
			log.error("[{}]:{}", "admin FAQDelete", e.getMessage());
		} finally {
			log.info("[{}]:{}", "admin FAQDelete", "end");
		}
		return "forward:admin/faq/faq";
	}















}









