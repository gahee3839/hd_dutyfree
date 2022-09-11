// 22/09/12 김가희 생성
package com.dutyfree.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dutyfree.dao.CsDAO;
import com.dutyfree.dto.CsVO;

public class CsWriteAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "DutyfreeServlet?command=cs_list";
		
		/*
		 * HttpSession session = request.getSession(); MemberVO loginUser = (MemberVO)
		 * session.getAttribute("loginUser");
		 * 
		 * if (loginUser == null) { url = "NonageServlet?command=login_form"; }else{
		 */
		CsVO csVO = new CsVO();
		csVO.setCsTitle(request.getParameter("title"));
		csVO.setCsContent(request.getParameter("content"));
		
		CsDAO csDAO = CsDAO.getInstance();
		csDAO.insertCs(csVO, "25");
		
		response.sendRedirect(url);
		
	}
	
}
