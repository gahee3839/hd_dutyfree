package com.dutyfree.admin.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.controller.action.Action;
import com.dutyfree.dao.CsDAO;
import com.dutyfree.dto.CsVO;

public class AdminCsListAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "admin/cs/csList.jsp";
		
		CsDAO csDAO = CsDAO.getInstance();
		ArrayList<CsVO> csList = csDAO.listCs();
		
		request.setAttribute("csList", csList);
		
		request.getRequestDispatcher(url).forward(request, response);
		
	}

}
