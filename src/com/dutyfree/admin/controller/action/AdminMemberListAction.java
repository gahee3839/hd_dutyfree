package com.dutyfree.admin.controller.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.controller.action.Action;
import com.dutyfree.dao.MemberDAO;
import com.dutyfree.dto.MemberVO;

public class AdminMemberListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "admin/member/memList.jsp";

		MemberDAO memDAO = MemberDAO.getInstance();
		ArrayList<MemberVO> memList = memDAO.listMember();
		System.out.println("Action");
		for(MemberVO vo : memList) {
			System.out.println(vo);
		}
		request.setAttribute("memList", memList);

		request.getRequestDispatcher(url).forward(request, response);

	}

}
