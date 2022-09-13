package com.dutyfree.dto;

import java.sql.Timestamp;

public class ProductVO {
	private int pNo;
	private String pName;
	private String pBrand;
	private String pCategory;
	private int pPrice;
	private int pDiscount;
	private int pStock;
	private Timestamp pRegdate;
	private String pImage;
	private String pDetail;

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

	public String getpBrand() {
		return pBrand;
	}

	public void setpBrand(String pBrand) {
		this.pBrand = pBrand;
	}

	public String getpCategory() {
		return pCategory;
	}

	public void setpCategory(String pCategory) {
		this.pCategory = pCategory;
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

	public int getpStock() {
		return pStock;
	}

	public void setpStock(int pStock) {
		this.pStock = pStock;
	}

	public Timestamp getpRegdate() {
		return pRegdate;
	}

	public void setpRegdate(Timestamp pRegdate) {
		this.pRegdate = pRegdate;
	}

	public String getpImage() {
		return pImage;
	}

	public void setpImage(String pImage) {
		this.pImage = pImage;
	}

	public String getpDetail() {
		return pDetail;
	}

	public void setpDetail(String pDetail) {
		this.pDetail = pDetail;
	}

	@Override
	public String toString() {
		return "ProductVO [pNo=" + pNo + ", pName=" + pName + ", pBrand=" + pBrand + ", pCategory=" + pCategory
				+ ", pPrice=" + pPrice + ", pDiscount=" + pDiscount + ", pStock=" + pStock + ", pRegdate=" + pRegdate
				+ ", pImage=" + pImage + ", pDetail=" + pDetail + "]";
	}

	
}
