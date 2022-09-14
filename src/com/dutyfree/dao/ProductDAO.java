// 22/09/13 김가희 생성
package com.dutyfree.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dutyfree.dto.ProductVO;
import com.dutyfree.util.DBConnection;

import oracle.jdbc.OracleTypes;

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
	public ArrayList<ProductVO> listProduct() {
		ArrayList<ProductVO> pList = new ArrayList<>();
		String sql = "{call prodList(?)}";
		ResultSet rs = null;
		try {
			conn = DBConnection.getConnection();
			cstmt = conn.prepareCall(sql);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);

			// 프로시저 실행
			cstmt.executeUpdate();
			// out파라미터의 값을 돌려받는다.
			rs = (ResultSet) cstmt.getObject(1);
			while (rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setpNo(rs.getInt("prod_no"));
				vo.setpName(rs.getString("prod_name"));
				vo.setpBrand(rs.getString("prod_brand"));
				vo.setpCategory(rs.getString("prod_category"));
				vo.setpPrice(rs.getInt("prod_price"));
				vo.setpDiscount(rs.getInt("prod_price"));
				vo.setpStock(rs.getInt("prod_stock"));
				vo.setpImage(rs.getString("prod_image"));
				vo.setpRegdate(rs.getTimestamp("prod_regdate"));
				System.out.println(vo);
				pList.add(vo);
			}
			rs.close();
			cstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pList;

	}
}
