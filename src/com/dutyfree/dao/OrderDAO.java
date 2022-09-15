package com.dutyfree.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

//import com.dutyfree.dto.CartVO;
import com.dutyfree.dto.OrderVO;
import com.dutyfree.util.DBConnection;

import oracle.jdbc.OracleTypes;

public class OrderDAO {
	Connection conn = null;
	CallableStatement cstmt = null;
	ResultSet rs = null;
	private OrderDAO() {
	}

	private static OrderDAO instance = new OrderDAO();

	public static OrderDAO getInstance() {
		return instance;
	}
//
//	// 사용자가 주문
//	public int insertOrder(ArrayList<CartVO> cartList, String id) {
//		int maxOseq = 0;
//
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs;
//
//		try {
//			conn = DBConnection.getConnection();
//
//			String selectMaxOseq = "select max(oseq) from orders";
//			pstmt = conn.prepareStatement(selectMaxOseq);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				maxOseq = rs.getInt(1);
//			}
//			pstmt.close();
//
//			String insertOrder = "insert into orders(oseq, id) values("
//					+ "orders_seq.nextval, ?)";
//			pstmt = conn.prepareStatement(insertOrder);
//			pstmt.setString(1, id);
//			pstmt.executeUpdate();
//
//			for (CartVO cartVO : cartList) {
//				insertOrderDetail(cartVO, maxOseq);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			DBManager.close(conn, pstmt);
//		}
//		return maxOseq;
//	}
//
//	public void insertOrderDetail(CartVO cartVO, int maxOseq) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = DBConnection.getConnection();
//
//			String insertOrderDetail = "insert into order_detail(odseq, oseq, "
//					+ "pseq, quantity) values(order_detail_seq.nextval, ?, ?, ?)";
//			pstmt = conn.prepareStatement(insertOrderDetail);
//			pstmt.setInt(1, maxOseq);
//			pstmt.setInt(2, cartVO.getPseq());
//			pstmt.setInt(3, cartVO.getQuantity());
//			pstmt.executeUpdate();
//			pstmt.close();
//
//			String updateCartResult = "update cart set result=2 where cseq=?";
//			pstmt = conn.prepareStatement(updateCartResult);
//			pstmt.setInt(1, cartVO.getCseq());
//			pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			DBConnection.close(conn, pstmt);
//		}
//	}

	//0913 김민선
	// 사용자가 주문 내역 검색
	public ArrayList<OrderVO> listOrderById(String id, String result, int oseq) {
		ArrayList<OrderVO> orderList = new ArrayList<OrderVO>();
		String sql = "{call orderList(?)}";

		ResultSet rs = null;
		try {
			conn = DBConnection.getConnection();
			cstmt = conn.prepareCall(sql);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.executeUpdate();
			rs = (ResultSet)cstmt.getObject(1);
			while (rs.next()) {
				OrderVO vo = new OrderVO();
				vo.setoNo(rs.getInt("o_no"));
				vo.setOdNo(rs.getInt("od_no"));
				vo.setpNo(rs.getInt("p_no"));
				vo.setpName(rs.getString("p_name"));
				vo.setOdAmount(rs.getInt("od_amount"));
				vo.setpPrice(rs.getInt("p_price"));
				vo.setpDiscount(rs.getInt("p_dc"));
				vo.setoShipping(rs.getString("o_shipping"));
				vo.setoDate(rs.getTimestamp("o_date"));
				vo.setmNo(rs.getInt("m_no"));
				vo.setmId(rs.getString("m_id"));
				orderList.add(vo);
				System.out.println(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderList;
	}

//	// 현재 진행 중인 주문 내역만 조회
//	public ArrayList<Integer> selectSeqOrderIng(String id) {
//		ArrayList<Integer> oseqList = new ArrayList<Integer>();
//		String sql = "select distinct oseq from order_view "
//				+ "where id=? and result='1' order by oseq desc";
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//
//		try {
//			con = DBManager.getConnection();
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, id);
//			rs = pstmt.executeQuery();
//			while (rs.next()) {
//				oseqList.add(rs.getInt(1));
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} 
//		return oseqList;
//	}

	/* *
	 * 관리자 모드에서 사용되는 메소드 * *
	 */
	// 22/09/12 김가희 추가
	public ArrayList<OrderVO> listOrder() {
		ArrayList<OrderVO> orderList = new ArrayList<OrderVO>();
		ResultSet rs = null;
		String sql = "{call orderList(?)}";
		try {
			conn = DBConnection.getConnection();
			cstmt = conn.prepareCall(sql);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			//프로시저 실행
			cstmt.executeUpdate();
			//out파라미터의 값을 돌려받는다.
			rs = (ResultSet)cstmt.getObject(1);
			while (rs.next()) {
				OrderVO vo = new OrderVO();
				vo.setoNo(rs.getInt("o_no"));
				vo.setOdNo(rs.getInt("od_no"));
				vo.setpNo(rs.getInt("p_no"));
				vo.setpName(rs.getString("p_name"));
				vo.setOdAmount(rs.getInt("od_amount"));
				vo.setpPrice(rs.getInt("p_price"));
				vo.setpDiscount(rs.getInt("p_dc"));
				vo.setoShipping(rs.getString("o_shipping"));
				vo.setoDate(rs.getTimestamp("o_date"));
				vo.setmNo(rs.getInt("m_no"));
				vo.setmId(rs.getString("m_id"));
				orderList.add(vo);
				System.out.println(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orderList;
	}

	/*
	 * public void updateOrderResult(String oseq) { String sql =
	 * "update order_detail set result='2' where odseq=?";
	 * 
	 * Connection conn = null; PreparedStatement pstmt = null;
	 * 
	 * try { conn = DBManager.getConnection(); pstmt = conn.prepareStatement(sql);
	 * pstmt.setString(1, oseq); pstmt.executeUpdate(); } catch (Exception e) {
	 * e.printStackTrace(); } finally { DBManager.close(conn, pstmt); } }
	 */

}


