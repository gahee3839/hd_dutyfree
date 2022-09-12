package com.dutyfree.dto;

import java.sql.Timestamp;

public class MemberVO{
	private String memId;
	private String memPw;
	private String memName;
	private Timestamp memBirth;
	private Timestamp memRegDate;
	private String memPassport;
	private String memPhone;
	
	public String getMemId() {
		return memId;
	}
	
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Timestamp getMemRegDate() {
		return memRegDate;
	}
	public void setMemRegDate(Timestamp memRegDate) {
		this.memRegDate = memRegDate;
	}
	public String getMemPw() {
		return memPw;
	}
	public void setMemPw(String memPw) {
		this.memPw = memPw;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public Timestamp getMemBirth() {
		return memBirth;
	}
	public void setMemBirth(Timestamp memBirth) {
		this.memBirth = memBirth;
	}
	public String getMemPassport() {
		return memPassport;
	}
	public void setMemPassport(String memPassport) {
		this.memPassport = memPassport;
	}
	public String getMemPhone() {
		return memPhone;
	}
	public void setMemPhone(String memPhone) {
		this.memPhone = memPhone;
	}
	
	/*
	 * @Override public String toString() { return "MemberVO [memId=" + memId +
	 * ", memPw=" + memPw + ", memName=" + memName + ", memBirth=" + memBirth +
	 * ", memRegDate=" + memRegDate + ", memPassport=" + memPassport + ", memPhone="
	 * + memPhone + "]"; }
	 */
	
}
