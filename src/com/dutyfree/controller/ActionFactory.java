// 22/09/08 김가희 생성
package com.dutyfree.controller;


import com.dutyfree.admin.controller.action.*;
import com.dutyfree.controller.action.*;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();

	public ActionFactory() {
		super();
	}

	public static ActionFactory getInstance() {
		return instance;
	}

	public Action getAction(String command) {
		Action action = null;

		System.out.println("ActionFactory : " + command);
		
		// 22/09/12 김가희 추가
		if (command.equals("cs_list")) {
			action = new CsListAction();
		}else if(command.equals("cs_write_form")){
			action = new CsWriteFormAction();
		}else if(command.equals("cs_write")){
			action = new CsWriteAction();
		}else if(command.equals("cs_view")) {
			action = new CsViewAction();
		}
		
		// admin
		if(command.equals("admin_main")) {
			action = new AdminMainAction();
		}else if(command.equals("admin_product_list")) {
			action = new AdminProductListAction();
		}else if(command.equals("admin_member_list")) {
			action = new AdminMemberListAction();
		}else if(command.equals("admin_order_list")) {
			action = new AdminOrderListAction();
		}else if(command.equals("admin_cs_list")) {
			action = new AdminCsListAction();
		}
		

		// 0913 김민선
		// MyHD_orderdetail
		if(command.equals("order_detail")) {
			action = new OrderDetailAction();
		}
		
		// 0913 박진수
		//로그인
		if(command.equals("index")) {
			action=new IndexAction();
		}else if(command.equals("login")) {
			action=new LoginMember();
		}else if(command.equals("login_form")) {
			action=new LoginForm();
		}else if(command.equals("Logout")) {
			action=new Logout();
		}else if(command.equals("FindId_Page")) {
			action=new FindId_page();
		}else if(command.equals("FindPw_Page")) {
			action=new FindPw_page();
		}else if(command.equals("Update_page")) {
			action=new Update_page();
		}else if(command.equals("Update")) {
			action=new Update();
		}
		else if(command.equals("Delete")) {
			action=new Delete();
		}
		
		return action;
		
		
		
	
	}

}
