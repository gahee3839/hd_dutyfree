//0913 김민선 생성
package com.dutyfree.controller.action;

import java.io.IOException;
import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dutyfree.dao.MemberDAO;
import com.dutyfree.dao.OrderDAO;
import com.dutyfree.dto.OrderVO;
import com.dutyfree.dto.MemberVO;

public class OrderDetailAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		MemberDAO memDao=MemberDAO.getInstance();
		HttpSession session=request.getSession();

		member=memDao.getMember(member.getMemId());
		session.setAttribute("member", member);
		String url = "order/MyHD_orderlist.jsp";
		request.getRequestDispatcher(url).forward(request,response);
		
		if (member == null) {
			url = "DutyfreeServlet?command=login_form";
		} else {
			int ono = Integer.parseInt(request.getParameter("ono"));
			OrderDAO orderDAO = OrderDAO.getInstance();
			ArrayList<OrderVO> orderList = orderDAO.listOrderById(member.getMemId(), "%", ono);

			int totalPrice = 0;
			for (OrderVO ovo : orderList) {
				totalPrice += ovo.getpPrice() * ovo.getOdAmount();
			}
			request.setAttribute("orderDetail", orderList.get(0));
			request.setAttribute("orderList", orderList);
			request.setAttribute("totalPrice", totalPrice);

			System.out.println(orderList);
		}
		request.getRequestDispatcher(url).forward(request, response);
	}
	
}
