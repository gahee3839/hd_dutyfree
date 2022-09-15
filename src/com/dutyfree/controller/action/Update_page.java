package com.dutyfree.controller.action;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import com.dutyfree.dao.MemberDAO;
import com.dutyfree.dto.MemberVO;

public class Update_page implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      MemberDAO dao=MemberDAO.getInstance();
	      HttpSession session=request.getSession();
	      String memId=(String)session.getAttribute("memId");
	      MemberVO member=dao.getMember(memId);
	      request.setAttribute("member", member);
	      String url="/user/MyHD.jsp";
	      request.getRequestDispatcher(url).forward(request, response);
	}

}
