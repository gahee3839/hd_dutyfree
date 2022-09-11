// 22/09/12 김가희 생성
package com.dutyfree.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.dao.CsDAO;
import com.dutyfree.dto.CsVO;

public class CsViewAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "cs/csView.jsp";
		int csNo = Integer.parseInt(request.getParameter("csNo"));
		CsDAO csDAO = CsDAO.getInstance();
		CsVO csVO = csDAO.getCs(csNo);
		request.setAttribute("csVO", csVO);
		request.getRequestDispatcher(url).forward(request, response);
	}

}
