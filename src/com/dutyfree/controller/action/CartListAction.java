package com.dutyfree.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dutyfree.dao.CartDAO;
import com.dutyfree.dto.CartVO;
import com.dutyfree.dto.MemberVO;


public class CartListAction implements Action {
	@Override
	 public void execute(HttpServletRequest request, HttpServletResponse response)
	 throws ServletException, IOException {
	 String url = "mypage/cartList.jsp";
	 
	 HttpSession session = request.getSession();
	 
//	 MemberVO loginUser = (MemberVO) session.getAttribute("memId");
	 String loginUser = (String) session.getAttribute("memId");

	 if(loginUser == null) {
		 url = "DutyfreeServlet?command=login_form";
	 } else {
		 CartDAO cartDAO = CartDAO.getInstance();
		 ArrayList<CartVO> cartList = cartDAO.listCart(loginUser);
		 double totalPrice = 0; // 할인율까지 적용된 총 금액
		 double totalPrice2 = 0; // totalPrice를 한국기준으로 변환
		 int totalAmount = 0; // 총 주문 수량
		 double totalCost = 0; // 총 원가
		 double totalCost2 = 0; // 총 원가 한국기준
		 double totalSale = 0; // 총 할인가격
		 double totalSale2 = 0; // 총 할인가격 한국기준
		 for(CartVO cartVO : cartList) {
			 double sale = (100-cartVO.getpDiscount())/100.0;
			 double saleper = cartVO.getpDiscount()/100.0;

			 totalPrice += cartVO.getpPrice() * sale * cartVO.getcDetailAmount();
			 totalAmount += cartVO.getcDetailAmount();
			 totalCost += (cartVO.getpPrice() * cartVO.getcDetailAmount());
			 totalSale += (cartVO.getpPrice() * saleper * cartVO.getcDetailAmount());
		 }
		 totalPrice2 = totalPrice * 1374.8;
		 totalCost2 = totalCost * 1374.8;
		 totalSale2 = totalSale * 1374.8;
		 System.out.println(totalPrice2);
		 request.setAttribute("cartList", cartList);
		 request.setAttribute("totalPrice", totalPrice);
		 request.setAttribute("totalPrice2", totalPrice2);
		 request.setAttribute("totalAmount", totalAmount);
		 request.setAttribute("totalCost", totalCost);
		 request.setAttribute("totalCost2", totalCost2);
		 request.setAttribute("totalSale", totalSale);
		 request.setAttribute("totalSale2", totalSale2);
		}
	 request.getRequestDispatcher(url).forward(request, response);
	}
}
