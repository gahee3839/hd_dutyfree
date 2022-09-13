// 22/09/12 김가희 생성
package com.dutyfree.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.dao.CsDAO;

public class CsWriteFormAction  implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = "cs/csWrite.jsp";
		/*
		 * HttpSession session = request.getSession(); MemberVO loginUser =
		 * (MemberVO)session.getAttribute("loginUser");
		 */
		request.getRequestDispatcher(url).forward(request, response);;
	}

}
