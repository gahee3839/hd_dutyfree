// 22/09/10 김가희 생성
package com.dutyfree.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dutyfree.dto.CsVO;
import com.dutyfree.util.DBConnection;

import oracle.jdbc.OracleTypes;

public class CsDAO {
	Connection conn = DBConnection.getConnection();
	CallableStatement cstmt = null;
	ResultSet rs = null;

	public CsDAO() {
		// TODO Auto-generated constructor stub
	}

	private static CsDAO instance = new CsDAO();

	public static CsDAO getInstance() {
		return instance;
	}

	// 전체리스트 불러오기
	public ArrayList<CsVO> listCs() {
		ArrayList<CsVO> csList = new ArrayList<>();
		String sql = "{call selectAllCs(?)}";
		/* Connection conn = null; CallableStatement cstmt = null; */
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
				CsVO vo = new CsVO();
				vo.setCsNo(rs.getInt("cs_no"));
				vo.setCsTitle(rs.getString("cs_title"));
				vo.setCsDate(rs.getTimestamp("cs_date"));
				vo.setCsCheck(rs.getString("cs_check"));
				vo.setMemNo(rs.getInt("member_mem_no"));
				csList.add(vo);
				System.out.println(vo);
			}
			rs.close();
			cstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return csList;
	}

	public void myCs(int memNo) {
		ArrayList<CsVO> csList = new ArrayList<>();
		String sql = "{call selectMyCs(?,?)}";

		try {
			conn = DBConnection.getConnection();
			cstmt = conn.prepareCall(sql);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.setInt(2, memNo);
			// 프로시저 실행
			cstmt.executeUpdate();
			// out파라미터의 값을 돌려받는다.
			rs = (ResultSet) cstmt.getObject(1);

			while (rs.next()) {
				CsVO vo = new CsVO();
				vo.setCsNo(rs.getInt("cs_no"));
				vo.setCsTitle(rs.getString("cs_title"));
				vo.setCsDate(rs.getTimestamp("cs_date"));
				vo.setCsCheck(rs.getString("cs_check"));
				vo.setMemNo(rs.getInt("mem_no"));
				csList.add(vo);
				System.out.println(vo);
			}
			rs.close();
			cstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 게시글내용 조회
	public CsVO getCs(int cs_no) {
		CsVO vo = null;
		String sql = "{call selectCs(?,?)}";

		// test용
		/*
		 * Connection conn = null; CallableStatement cstmt = null; ResultSet rs = null;
		 */

		try {
			conn = DBConnection.getConnection();
			cstmt = conn.prepareCall(sql);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.setInt(2, cs_no);
			cstmt.executeQuery();
			rs = (ResultSet) cstmt.getObject(1);
			if (rs.next()) {
				vo = new CsVO();
				vo.setCsNo(rs.getInt("cs_no"));
				vo.setCsContent(rs.getString("cs_content"));
				vo.setCsTitle(rs.getString("cs_title"));
				vo.setCsDate(rs.getTimestamp("cs_date"));
				vo.setCsReply(rs.getString("cs_reply"));
				vo.setCsCheck(rs.getString("cs_check"));
				vo.setMemNo(rs.getInt("member_mem_no"));
				System.out.println(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return vo;
	}

	// 게시글 insert
	public void insertCs(CsVO vo, String session_no) {
		String sql = "{call insertCs(?,?,?)}";
		int result = 0;
		try {
			conn = DBConnection.getConnection();
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, vo.getCsTitle());
			cstmt.setString(2, vo.getCsContent());
			cstmt.setInt(3, Integer.parseInt(session_no));
			result = cstmt.executeUpdate();
			cstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("insert 완료");
	}

	/*
	 * public static void main(String[] args) { listCs(); }
	 */

}
