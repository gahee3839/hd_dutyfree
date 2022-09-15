package com.dutyfree.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dutyfree.dto.CartVO;
import com.dutyfree.util.DBConnection;
import com.dutyfree.util.JDBCUtil;

import oracle.jdbc.OracleTypes;

public class CartDAO {
	Connection conn = DBConnection.getConnection();
	CallableStatement cstmt = null;
	String sql;
	int result = 0;
	ResultSet rs=null;

	
	private CartDAO() {
		
	}

	private static CartDAO instance = new CartDAO();

	public static CartDAO getInstance() {
		return instance;
	}
	
	//장바구니 추가 메서드
	public void insertCart(CartVO cartVO) {
		try {
			sql = "{exec 패키지명.프로시저}";
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, cartVO.getMemId());
			cstmt.setInt(2, cartVO.getpNo());
			cstmt.setInt(3, cartVO.getcDetailAmount());
			result = cstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn);
			JDBCUtil.close(cstmt);
		}
	}
	
	// 장바구니 리스트
	public ArrayList<CartVO> listCart(String memId){
		System.out.println("DAO");
		ArrayList<CartVO> cartList = new ArrayList<CartVO>();
		String sql = "{call cartList(?,?)}";
		ResultSet rs = null;
	      try {
	         conn = DBConnection.getConnection();
	         cstmt = conn.prepareCall(sql);
	         cstmt.registerOutParameter(1, OracleTypes.CURSOR);
	         cstmt.setString(2, memId);

	         // 프로시저 실행
	         cstmt.executeUpdate();
	         // out파라미터의 값을 돌려받는다.
	         rs = (ResultSet) cstmt.getObject(1);
			while(rs.next()) {
				CartVO cartVO = new CartVO();
				cartVO.setCartNo(rs.getInt("c_no"));
				cartVO.setMemId(rs.getString("m_id"));
				cartVO.setpNo(rs.getInt("p_no"));
				cartVO.setpName(rs.getString("p_name"));
				cartVO.setcDetailNo(rs.getInt("d_no"));
				cartVO.setcDetailAmount(rs.getInt("d_amount"));
				cartVO.setpPrice(rs.getInt("p_price"));
				cartVO.setpDiscount(rs.getInt("p_discount"));
				cartVO.setpBrand(rs.getString("p_brand"));
				System.out.println(cartVO);
				cartList.add(cartVO);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(cstmt);
			JDBCUtil.close(conn);
		}
		return cartList;
	}

	// 장바구니 삭제
	public void deleteCart(int cDetailNo) {
		try {
			sql = "{exec 패키지명.프로시저}";
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, cDetailNo);
			cstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(cstmt);
			JDBCUtil.close(conn);
		}
	}
}
