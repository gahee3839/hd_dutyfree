package com.dutyfree.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

<<<<<<< HEAD
	   private static Connection conn;
	   private static String url = "jdbc:oracle:thin:@localhost:1521/xepdb1";
	   private static uid ="dutyfree";
	   private static pwd "dutyfree";
	   private DBConnection() {
	   }
=======
	// private static Connection conn;

	private static String url = "jdbc:oracle:thin:@localhost:1521/xepdb1";
	private static String uid = "dutyfree";
	private static String pwd = "dutyfree";
>>>>>>> branch 'master' of https://github.com/gahee3839/hd_dutyfree.git

<<<<<<< HEAD
//	   static {
//	      // 환경설정 파일을 읽어오기 위한 객체 생성
//	      Properties properties  = new Properties();
//	      Reader reader;
//	      try {
//	         reader = new FileReader("WebContent/WEB-INF/lib/oracle.properties");  // 읽어올 파일 지정
//	         properties.load(reader);                           // 설정 파일 로딩하기
//	      } catch (FileNotFoundException e1) {
//	         System.out.println("예외: 지정한 파일을 찾을수없습니다 :" + e1.getMessage());
//	         e1.printStackTrace();
//	      } catch (IOException e) {
//	         e.printStackTrace();
//	      }
//
//	      String driverName = properties.getProperty("driver");
//	      String url = properties.getProperty("url");
//	      String user = properties.getProperty("user");
//	      String pwd = properties.getProperty("password");
//
//	      try {
//	         //class.forName(스트링) 해당하는 파일을 메모리에 올린다.
//	         Class.forName(driverName);
//	         conn = DriverManager.getConnection(url, user, pwd);
//	         System.out.println("connection success");
//	      } catch (ClassNotFoundException e) {
//	         System.out.println("예외: 드라이버로드 실패 :" + e.getMessage());
//	         e.printStackTrace();
//	      } catch (SQLException e) {
//	         System.out.println("예외: connection fail :" + e.getMessage());
//	         e.printStackTrace();
//	      }
//	   }

	   public static Connection getConnection() {
		   Connection conn = null;
		   try {
			   Class.forName("oracle.jdbc.driver.OracleDriver");
			   conn = DriverManager.getConnection(url,uid,pwd);
		   } catch (Exception e) {
			   e.printStackTrace();
		   }
	      return conn;
	   }
	}
=======
	private DBConnection() {
	}

	/*
	 * static { // 환경설정 파일을 읽어오기 위한 객체 생성 Properties properties = new Properties();
	 * Reader reader; try { reader = new
	 * FileReader("WebContent/WEB-INF/lib/oracle.properties"); // 읽어올 파일 지정
	 * properties.load(reader); // 설정 파일 로딩하기 } catch (FileNotFoundException e1) {
	 * System.out.println("예외: 지정한 파일을 찾을수없습니다 :" + e1.getMessage());
	 * e1.printStackTrace(); } catch (IOException e) { e.printStackTrace(); }
	 * 
	 * String driverName = properties.getProperty("driver"); String url =
	 * properties.getProperty("url"); String user = properties.getProperty("user");
	 * String pwd = properties.getProperty("password");
	 * 
	 * try { //class.forName(스트링) 해당하는 파일을 메모리에 올린다. Class.forName(driverName); conn
	 * = DriverManager.getConnection(url, user, pwd);
	 * System.out.println("connection success"); } catch (ClassNotFoundException e)
	 * { System.out.println("예외: 드라이버로드 실패 :" + e.getMessage());
	 * e.printStackTrace(); } catch (SQLException e) {
	 * System.out.println("예외: connection fail :" + e.getMessage());
	 * e.printStackTrace(); } }
	 */

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, uid, pwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}
>>>>>>> branch 'master' of https://github.com/gahee3839/hd_dutyfree.git
