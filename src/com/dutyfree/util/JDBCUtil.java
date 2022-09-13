package com.dutyfree.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCUtil {
	public static void close(Connection conn) {
		try {
			if(conn!=null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void close(CallableStatement cstmt) {
		try {
			if(cstmt!=null) cstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}