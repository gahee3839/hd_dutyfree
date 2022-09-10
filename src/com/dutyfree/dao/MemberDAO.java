package com.dutyfree.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import com.dutyfree.dto.MemberVO;
import com.dutyfree.util.DBConnection;
import com.dutyfree.util.JDBCUtil;

public class MemberDAO {
	Connection conn=DBConnection.getConnection();
	CallableStatement cstmt=null;
	String sql;
	int result=0;
	
	private MemberDAO() {
		
	}
	
	private static MemberDAO instance= new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}
	
	//멤버 추가 메서드
	public int  insertMember(MemberVO member) {
		try {
		sql="{exec  패키지명.프로시져}";
		cstmt=conn.prepareCall(sql);
		cstmt.setString(1, member.getMemId());
		cstmt.setString(2, member.getMemPw());
		cstmt.setString(3, member.getMemName());
		cstmt.setTimestamp(4, member.getMemBirth());
		cstmt.setString(5, member.getMemPassport());
		cstmt.setString(6, member.getMemPhone());
		result=cstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn);
			JDBCUtil.close(cstmt);
		}
		
		return result;
	}
	
	//멤버 수정
	public int updateMember(MemberVO member) {
		try {
			sql="{exec  패키지명.프로시져}";
			cstmt=conn.prepareCall(sql);
			cstmt.setString(1, member.getMemId());
			cstmt.setString(2, member.getMemPw());
			cstmt.setString(3, member.getMemName());
			cstmt.setTimestamp(4, member.getMemBirth());
			cstmt.setString(5, member.getMemPassport());
			cstmt.setString(6, member.getMemPhone());
			result=cstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(cstmt);
			JDBCUtil.close(conn);
		}
		return 1;
	}
	
	//멤버 삭제
	public int deleteMember(String memId) {
		try {
			sql="{exec  패키지명.프로시져}";
			cstmt=conn.prepareCall(sql);
			cstmt.setString(1, memId);
			result=cstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(cstmt);
			JDBCUtil.close(conn);
		}
		return 1;
	}
	
}
