package com.dutyfree.controller.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.dao.MemberDAO;

public class Delete implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO dao= MemberDAO.getInstance();
		int result=dao.deleteMember(request.getParameter("memId"));
		
		if(result==1) {
			request.setAttribute("success", "success");
		}else {
			request.setAttribute("fail", "fail");
		}
		String url="DutyfreeServlet?command=index";
		request.getRequestDispatcher(url).forward(request,response);

	}

}
