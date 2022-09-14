//0913 김민선 생성
package com.dutyfree.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dutyfree.dao.OrderDAO;
import com.dutyfree.dto.OrderVO;
import com.dutyfree.dto.MemberVO;


public class OrderDetailAction implements Action {

  @Override
  public void execute(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String url = "order/MyHD_orderlist.jsp";
    
    HttpSession session = request.getSession();
    MemberVO member = (MemberVO) session.getAttribute("member");
    if (member == null) {
      url = "DutyfreeServlet?command=login_form";
    } else {
      OrderDAO orderDAO = OrderDAO.getInstance();
      int oseq=Integer.parseInt(request.getParameter("oseq"));
      ArrayList<OrderVO> orderList = orderDAO.listOrderById(member.getMemId(), "%", oseq);

      int totalPrice=0;
      for(OrderVO ovo :orderList){
        totalPrice+=ovo.getpPrice()*ovo.getOdAmount();
      }
      
      request.setAttribute("orderDetail", orderList.get(0));  
      request.setAttribute("orderList", orderList);
      request.setAttribute("totalPrice", totalPrice);
      
      System.out.println(orderList);
  }
    request.getRequestDispatcher(url).forward(request, response);
  }    
}
