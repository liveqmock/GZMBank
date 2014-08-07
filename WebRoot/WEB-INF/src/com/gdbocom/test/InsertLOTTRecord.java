package com.gdbocom.test;

import java.sql.*;


public class InsertLOTTRecord {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		Connection connection = null;
		String url="jdbc:sybase:Tds:182.53.15.211:6600/middb";
		String user="miduser";
		String pass="miduser";

		Statement st = null;
		ResultSet rs = null;

		int count = Integer.valueOf(args[0]).intValue();
		
		try{ 
			
	     	//加载数据库驱动
			Class.forName("com.sybase.jdbc3.jdbc.SybDriver");
		     	//获取数据库连接
			connection = DriverManager.getConnection(url, user, pass);

			System.out.println("连接数据库正常："+connection);
			st = connection.createStatement();
			
			st.executeUpdate("truncate table LOTTDRAW");
			
			for(int i=1; i<count; i++){
				st.executeUpdate("insert into LOTTDRAW(PhoneNO) values('"+i+"')");
			}
			//int result = st.executeUpdate("select * from CLIENT_BEFORE_JUNE where PhoneNO='");
			//System.out.println(result);
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				if(rs != null){
					rs.close();
				}
				if(st != null){
					st.close();
				}
				if(connection != null){
					connection.close();
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}

		
		
	}

}
