//0913 김민선 생성
package com.dutyfree.admin.controller.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

import com.dutyfree.controller.action.Action;
import com.dutyfree.dao.OrderDAO;
import com.dutyfree.dto.OrderVO;;


public class OrderDetailAction implements Action {

  @Override
  public void execute(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    String url = "order/MyHD_orderlist.jsp";
//    
//    HttpSession session = request.getSession();
//    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
//    if (loginUser == null) {
//      url = "";
//    } else {
//      int oseq=Integer.parseInt(request.getParameter("oseq"));
//      ArrayList<OrderVO> orderList = orderDAO.listOrderById(loginUser.getId(), "%", oseq);
//      
      OrderDAO orderDAO = OrderDAO.getInstance();
      ArrayList<OrderVO> orderList = orderDAO.listOrder();
      
      int totalPrice=0;
      for(OrderVO ovo :orderList){
        totalPrice+=ovo.getpPrice()*ovo.getOdAmount();
      }
      
      request.setAttribute("orderDetail", orderList.get(0));  
      request.setAttribute("orderList", orderList);
      request.setAttribute("totalPrice", totalPrice);
      System.out.println(orderList);
//    }
    request.getRequestDispatcher(url).forward(request, response);
  }    
}
