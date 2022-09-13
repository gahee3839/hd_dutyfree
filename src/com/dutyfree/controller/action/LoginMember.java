package com.dutyfree.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dutyfree.dao.MemberDAO;
import com.dutyfree.dto.MemberVO;

public class LoginMember implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO dao=MemberDAO.getInstance();
		HttpSession session=request.getSession();
		MemberVO member=null;
		String result=dao.LoginMember(request.getParameter("memId"),request.getParameter("memPw"));
		if(result.equals("성공")) {
			member=new MemberVO();
			member.setMemId(request.getParameter("memId"));
			member.setMemPw(request.getParameter("memPw"));
			session.setAttribute("member", member);
		}else {
			//실패 구현
		}
		if(request.getParameter("saveId")!=null) {
			if(request.getParameter("saveId").equals("Y")) {
				Cookie cookie=new Cookie("saveId",member.getMemId());
				cookie.setMaxAge(2000);
				response.addCookie(cookie);
			}
		}else {
			Cookie[] cookies=request.getCookies();
			if(cookies!=null) {
				for(Cookie c: cookies) {
					if(c.getName().equals("saveId")) {
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
			}
		}
		
		String url="/DutyfreeServlet?command=index";
		request.getRequestDispatcher(url).forward(request,response);
		/*
		 * url="/include/header.jsp"; request.getRequestDispatcher(url).forward(request,
		 * response);
		 */
	}

}
