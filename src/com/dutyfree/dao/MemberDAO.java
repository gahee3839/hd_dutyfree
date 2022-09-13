package com.dutyfree.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dutyfree.dto.MemberVO;
import com.dutyfree.util.DBConnection;
import com.dutyfree.util.JDBCUtil;

import oracle.jdbc.OracleTypes;

public class MemberDAO {
	Connection conn = DBConnection.getConnection();
	CallableStatement cstmt = null;
	String sql;
	int result = 0;
	ResultSet rs=null;

	private MemberDAO() {

	}

	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
		return instance;
	}

	// 멤버 추가 메서드
	public int insertMember(MemberVO member) {
		try {
			sql = "{exec  패키지명.프로시져}";
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, member.getMemId());
			cstmt.setString(2, member.getMemPw());
			cstmt.setString(3, member.getMemName());
			cstmt.setDate(4, member.getMemBirth());
			cstmt.setString(5, member.getMemPassport());
			cstmt.setString(6, member.getMemPhone());
			result = cstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn);
			JDBCUtil.close(cstmt);
		}

		return result;
	}

	// 멤버 수정
	public int updateMember(MemberVO member) {
		try {
			sql = "{call update_member(?,?,?,?,?,?,?)}";
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, member.getMemId());
			cstmt.setString(2, member.getMemPw());
			cstmt.setString(3, member.getMemName());
			cstmt.setDate(4, member.getMemBirth());
			cstmt.setString(5, member.getMemPassport());
			cstmt.setString(6, member.getMemPhone());
			cstmt.setString(7, member.getMemGender());
			result = cstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(cstmt);
			JDBCUtil.close(conn);
		}
		return 1;
	}

	// 멤버 삭제
	public int deleteMember(String memId) {
		try {
			sql = "{exec  패키지명.프로시져}";
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, memId);
			result = cstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(cstmt);
			JDBCUtil.close(conn);
		}
		return 1;
	}

	// 22/09/12 김가희추가
	// member 전체목록 조회(관리자용)
	public ArrayList<MemberVO> listMember() {
		ArrayList<MemberVO> memList = new ArrayList<>();
		String sql = "{call selectAllMember(?)}";
		
		/*
		 * Connection conn = null; CallableStatement cstmt = null;
		 */
		
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
				MemberVO vo = new MemberVO();
				vo.setMemId(rs.getString("mem_id"));
				vo.setMemName(rs.getString("mem_name"));
				vo.setMemRegDate(rs.getTimestamp("mem_regdate"));
				vo.setMemPhone(rs.getString("mem_phone"));
				memList.add(vo);
				System.out.println(vo);
			}
			rs.close();
			cstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return memList;
	}
	//사용자에 대한 정보 불러오기
		public MemberVO getMember(String memId) {
			MemberVO member=null;
			try {			
				conn=DBConnection.getConnection();
				sql="{call getMember(?,?) }";
				cstmt=conn.prepareCall(sql);
				cstmt.setString(1, memId);
				/*
				 * cstmt.registerOutParameter(2, oracle.jdbc.OracleTypes.VARCHAR);
				 * cstmt.registerOutParameter(3, oracle.jdbc.OracleTypes.VARCHAR);
				 * cstmt.registerOutParameter(5, oracle.jdbc.OracleTypes.DATE);
				 * cstmt.registerOutParameter(4, oracle.jdbc.OracleTypes.VARCHAR);
				 * cstmt.registerOutParameter(6, oracle.jdbc.OracleTypes.VARCHAR);
				 */
				cstmt.registerOutParameter(2, OracleTypes.CURSOR);
				cstmt.executeUpdate();
				rs=(ResultSet)cstmt.getObject(2);
				if(rs.next()) {
					member=new MemberVO();
					member.setMemId(memId);
					member.setMemPw(rs.getString("mem_pw"));		
					member.setMemName(rs.getString("mem_name"));
					member.setMemBirth(rs.getDate("mem_birth"));
					member.setMemPassport(rs.getString("mem_passport"));
					member.setMemPhone(rs.getString("mem_phone"));
					member.setMemGender(rs.getString("mem_gender"));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				JDBCUtil.close(cstmt);
				JDBCUtil.close(conn);
			}
			return member;
			
			
		}
	
	
	//로그인 페이지 구현
		public String LoginMember(String memId,String memPw) {
			String result="";
			try {
				conn=DBConnection.getConnection();
				sql= "{? = call LoginMember(?,?)}";
				cstmt=conn.prepareCall(sql);
				cstmt.registerOutParameter(1, OracleTypes.VARCHAR);
				cstmt.setString(2, memId);
				cstmt.setString(3,memPw);
				cstmt.executeUpdate();
				result=cstmt.getString(1);
				System.out.println(result);
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				JDBCUtil.close(cstmt);
				JDBCUtil.close(conn);
			}
			return result;
		}
	
	/*
	 * public static void main(String[] args) { listMember(); }
	 */
}
