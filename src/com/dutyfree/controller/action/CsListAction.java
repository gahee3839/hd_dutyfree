package com.dutyfree.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.dao.CsDAO;
import com.dutyfree.dto.CsVO;

public class CsListAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "cs/csList.jsp";
		
		/*
		 * HttpSession session = request.getSession(); MemberVO loginUser =
		 * (MemberVO)session.getAttribute("loginUser");
		 */
		CsDAO csDAO = CsDAO.getInstance();
		ArrayList<CsVO> csList = csDAO.listCs();
		request.setAttribute("csList", csList);
		request.getRequestDispatcher(url).forward(request, response);
	}

}
