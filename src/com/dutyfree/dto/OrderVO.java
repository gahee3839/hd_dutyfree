
package com.dutyfree.dto;

import java.sql.Timestamp;

public class OrderVO {
	private int oNo;
	private int odNo;
	private int mNo;
	private String mId;
	private int pNo;
	private String pName;
	private int pPrice;
	private int pDiscount;
	private int odAmount;
	private Timestamp oDate;
	private String oShipping;

	public int getoNo() {
		return oNo;
	}

	public void setoNo(int oNo) {
		this.oNo = oNo;
	}

	public int getOdNo() {
		return odNo;
	}

	public void setOdNo(int odNo) {
		this.odNo = odNo;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}

	public int getpDiscount() {
		return pDiscount;
	}

	public void setpDiscount(int pDiscount) {
		this.pDiscount = pDiscount;
	}

	public int getOdAmount() {
		return odAmount;
	}

	public void setOdAmount(int odAmount) {
		this.odAmount = odAmount;
	}

	public Timestamp getoDate() {
		return oDate;
	}

	public void setoDate(Timestamp oDate) {
		this.oDate = oDate;
	}

	public String getoShipping() {
		return oShipping;
	}

	public void setoShipping(String oShipping) {
		this.oShipping = oShipping;
	}

	@Override
	public String toString() {
		return "OrderVO [oNo=" + oNo + ", odNo=" + odNo + ", mNo=" + mNo + ", pNo=" + pNo + ", pName=" + pName
				+ ", pPrice=" + pPrice + ", pDiscount=" + pDiscount + ", odAmount=" + odAmount + ", oDate=" + oDate
				+ ", oShipping=" + oShipping + "]";
	}
<<<<<<< HEAD

}
=======
	
	

}
>>>>>>> branch 'master' of https://github.com/gahee3839/hd_dutyfree.git
