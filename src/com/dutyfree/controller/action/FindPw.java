package com.dutyfree.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.dao.MemberDAO;

public class FindPw implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		MemberDAO dao= MemberDAO.getInstance();
		String pw=dao.FindPw(request.getParameter("memId"), request.getParameter("memPhone"));
		System.out.println(pw);
		String url="";
		if(pw.equals("0")) {
			url="DutyfreeServlet?command=FindPw_Page";
		}else {
			url="DutyfreeServlet?command=FindPw_Page";
			request.setAttribute("pw", pw);
		}
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
