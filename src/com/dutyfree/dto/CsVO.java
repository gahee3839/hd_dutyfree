// 22/09/07 김가희 생성
package com.dutyfree.dto;

import java.sql.Timestamp;

public class CsVO {
	private int csNo;
	private String csTitle;
	private Timestamp csDate;
	private String csContent;
	private String csReply;
	private String csCheck;
	private int memNo;
	public int getCsNo() {
		return csNo;
	}
	public void setCsNo(int csNo) {
		this.csNo = csNo;
	}
	public String getCsTitle() {
		return csTitle;
	}
	public void setCsTitle(String csTitle) {
		this.csTitle = csTitle;
	}
	public Timestamp getCsDate() {
		return csDate;
	}
	public void setCsDate(Timestamp csDate) {
		this.csDate = csDate;
	}
	public String getCsContent() {
		return csContent;
	}
	public void setCsContent(String csContent) {
		this.csContent = csContent;
	}
	public String getCsReply() {
		return csReply;
	}
	public void setCsReply(String csReply) {
		this.csReply = csReply;
	}
	public String getCsCheck() {
		return csCheck;
	}
	public void setCsCheck(String csCheck) {
		this.csCheck = csCheck;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	@Override
	public String toString() {
		return "CsVO [csNo=" + csNo + ", csTitle=" + csTitle + ", csDate=" + csDate + ", csContent=" + csContent
				+ ", csReply=" + csReply + ", csCheck=" + csCheck + ", memNo=" + memNo + "]";
	}

	
}
