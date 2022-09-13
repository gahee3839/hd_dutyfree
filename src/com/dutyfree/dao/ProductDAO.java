// 22/09/13 김가희 생성
package com.dutyfree.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dutyfree.dto.ProductVO;
import com.dutyfree.util.DBConnection;

public class ProductDAO {
	Connection conn = DBConnection.getConnection();
	CallableStatement cstmt = null;
	ResultSet rs = null;
	
	public ProductDAO() {
		// TODO Auto-generated constructor stub
	}
	
	private static ProductDAO instance = new ProductDAO();
	
	public static ProductDAO getInstance() {
		return instance;
	}
	
	/*
	 * 관리자모드에서 사용
	 */
	// 22/09/13 김가희 작성
	public ArrayList<ProductVO> listProduct(){
		ArrayList<ProductVO> pdList = new ArrayList<>();
		String sql = "{call selectAllProduct(?)}";
		
		
	}

}
