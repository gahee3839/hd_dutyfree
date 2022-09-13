// 22/09/08 김가희 생성
package com.dutyfree.controller;

import com.dutyfree.admin.controller.action.AdminCsListAction;
import com.dutyfree.admin.controller.action.AdminMainAction;
import com.dutyfree.admin.controller.action.AdminMemberListAction;
import com.dutyfree.admin.controller.action.AdminOrderListAction;
import com.dutyfree.admin.controller.action.AdminProductListAction;
import com.dutyfree.controller.action.OrderDetailAction;
import com.dutyfree.controller.action.Action;
import com.dutyfree.controller.action.CsListAction;
import com.dutyfree.controller.action.CsViewAction;
import com.dutyfree.controller.action.CsWriteAction;
import com.dutyfree.controller.action.CsWriteFormAction;

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
		
		return action;
		
		
		
	
	}

}
