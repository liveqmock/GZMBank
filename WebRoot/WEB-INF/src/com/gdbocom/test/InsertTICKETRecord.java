package com.gdbocom.test;

import java.sql.*;


public class InsertTICKETRecord {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		Connection connection = null;
		Statement st = null;
		ResultSet rs = null;

		String url="jdbc:sybase:Tds:182.53.15.211:6600/middb";
		String user="miduser";
		String pass="miduser";

		InsertTICKETRecord insertobject = new InsertTICKETRecord();
		
		
		try{ 
			
	     	//加载数据库驱动
			Class.forName("com.sybase.jdbc3.jdbc.SybDriver");
		     	//获取数据库连接
			connection = DriverManager.getConnection(url, user, pass);

			System.out.println("连接数据库正常："+connection);
			st = connection.createStatement();
			//
			st.executeUpdate("truncate table TICKETDRAW");
			if(args.length>1){
				if("-s".equals(args[0])){
					int count = Integer.valueOf(args[1]).intValue();
					insertobject.insertSingleValidRecord(count, st);
				}else if("-t".equals(args[0])){
					int count = Integer.valueOf(args[1]).intValue();
					insertobject.insertTwoValidRecord(count, st);
				}else if("-m".equals(args[0])){
					int count = Integer.valueOf(args[1]).intValue();
					insertobject.insertManyValidRecord(count, st);
				}else if("-g".equals(args[0])){
					int count = Integer.valueOf(args[1]).intValue();
					insertobject.insertGapValidRecord(count, st);
				}
			}else{
				System.out.println("输入的参数有误：");
				System.out.println("-s:插入多条记录，只有一条未抽奖记录");
				System.out.println("-t:插入多条记录，有两条未抽奖记录");
				System.out.println("-m:插入多条记录，全部为未抽奖记录");
				System.out.println("-g:插入多条记录，奇数为未抽奖记录");
				System.out.println("例子：java InsertTICKETRecord -s 50");
				System.exit(-1);
			}
			
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

	public void insertSingleValidRecord(int count, Statement st) throws SQLException{
		
		for(int i=0; i<count-1; i++){
			st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob, Drawlevel, NO) values('60142890710180319', '15168362842', '2', 1)");
		}
		st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob) values('60142890710180319', '15168362842')");
	}

	public void insertTwoValidRecord(int count, Statement st) throws SQLException{
		
		for(int i=0; i<count-2; i++){
			st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob, Drawlevel, NO) values('60142890710180319', '15168362842', '2', 1)");
		}
		st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob) values('60142890710180319', '15168362842')");
		st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob) values('60142890710180319', '15168362842')");
	}

	
	public void insertGapValidRecord(int count, Statement st) throws SQLException{
		
		for(int i=0; i<count; i++){
			if(0==i%2){
				st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob, Drawlevel, NO) values('60142890710180319', '15168362842', '2', 1)");
			}else{
				st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob) values('60142890710180319', '15168362842')");
			}
		}
	}

	public void insertManyValidRecord(int count, Statement st) throws SQLException{
		
		for(int i=0; i<count; i++){
			st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob) values('60142890710180319', '15168362842')");
		}
	}
}
