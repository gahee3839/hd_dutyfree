package com.dutyfree.controller.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dutyfree.dao.CartDAO;

public class CartDeleteAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "DutyfreeServlet?command=cart_list";

		String[] cDetailNoArr = request.getParameterValues("cDetailNo");

		for (String cDetailNo : cDetailNoArr) {
			System.out.println(cDetailNo);
			CartDAO cartDAO = CartDAO.getInstance();
			cartDAO.deleteCart(Integer.parseInt(cDetailNo));
		}
		request.getRequestDispatcher(url).forward(request, response);
	}
}