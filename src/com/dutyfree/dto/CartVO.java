package com.dutyfree.dto;

import java.sql.Timestamp;

public class CartVO {
  private int cartNo;
  private int cartAmout; 

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getCartAmout() {
		return cartAmout;
	}

	public void setCartAmout(int cartAmout) {
		this.cartAmout = cartAmout;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	private int memNo;
  
  
}
