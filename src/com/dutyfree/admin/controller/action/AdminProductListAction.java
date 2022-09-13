package com.dutyfree.admin.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dutyfree.controller.action.Action;
import com.dutyfree.dao.OrderDAO;
import com.dutyfree.dto.OrderVO;

public class AdminProductListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "admin/product/productList.jsp";
//		OrderDAO orderDAO = OrderDAO.getInstance();
//		
//		ArrayList<OrderVO> orderList = orderDAO.listOrder();
//		request.setAttribute("orderList", orderList);
		request.getRequestDispatcher(url).forward(request, response);

	}

}
