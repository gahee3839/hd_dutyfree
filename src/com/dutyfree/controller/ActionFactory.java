// 22/09/08 김가희 생성
package com.dutyfree.controller;

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
		
		return action;
	}

}
