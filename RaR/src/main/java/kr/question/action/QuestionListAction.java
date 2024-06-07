package kr.question.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.rar.dao.QuestionDAO;
import kr.rar.vo.QuestionVO;
import kr.util.PagingUtil;

public class QuestionListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		QuestionDAO dao = QuestionDAO.getInstance();
		int count = dao.getQuestionCount(keyfield, keyword);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,
				          Integer.parseInt(pageNum),
				          count,20,10,"question_list.do");
		List<QuestionVO> list = null;
		if(count > 0) {
			list = dao.getListQuestion(page.getStartRow(),
				   page.getEndRow(), keyfield, keyword);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		//JSP 경로 반환
		return "/WEB-INF/views/question/question_list.jsp";
	}
}