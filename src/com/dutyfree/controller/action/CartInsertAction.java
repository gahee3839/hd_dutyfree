package com.dutyfree.controller.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dutyfree.dao.CartDAO;
import com.dutyfree.dto.CartVO;
import com.dutyfree.dto.MemberVO;

public class CartInsertAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "DutyfreeServlet?command=cart_list";

		HttpSession session = request.getSession();
		
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		//로그인이 안되어 있으면 로그인 페이지로 이동
		if (loginUser == null) {
			url = "NonageServlet?command=login_form";
		} else {
			CartVO cartVO = new CartVO();
			cartVO.setMemId(loginUser.getMemId());
			cartVO.setpNo(Integer.parseInt(request.getParameter("pNo")));
			cartVO.setcDetailAmount(Integer.parseInt(request.getParameter("cDetailAmount")));
			
			CartDAO cartDAO = CartDAO.getInstance();
			cartDAO.insertCart(cartVO);
		}
		response.sendRedirect(url);
	}
}
