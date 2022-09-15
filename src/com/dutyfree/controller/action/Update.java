package com.dutyfree.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.dao.MemberDAO;
import com.dutyfree.dto.MemberVO;

public class Update implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url="";
		
		MemberDAO dao= MemberDAO.getInstance();
		MemberVO member=new MemberVO();
		
		
		member.setMemId(request.getParameter("memId"));
		member.setMemPw(request.getParameter("new_memPw"));
		member.setMemName(request.getParameter("memName"));
		member.setMemGender(request.getParameter("memGender"));
		member.setMemBirth(java.sql.Date.valueOf(request.getParameter("memBirth")));
		member.setMemPhone(request.getParameter("memPhone"));
		member.setMemPassport(request.getParameter("memPassport"));
		int result=dao.updateMember(member);
		if(result==1) {
			url="DutyfreeServlet?command=Update_page";
			request.setAttribute("update_success", "update_success");
		}
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
