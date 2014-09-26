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
			
	     	//�������ݿ�����
			Class.forName("com.sybase.jdbc3.jdbc.SybDriver");
		     	//��ȡ���ݿ�����
			connection = DriverManager.getConnection(url, user, pass);

			System.out.println("�������ݿ�������"+connection);
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
				System.out.println("����Ĳ�������");
				System.out.println("-s:���������¼��ֻ��һ��δ�齱��¼");
				System.out.println("-t:���������¼��������δ�齱��¼");
				System.out.println("-m:���������¼��ȫ��Ϊδ�齱��¼");
				System.out.println("-g:���������¼������Ϊδ�齱��¼");
				System.out.println("���ӣ�java InsertTICKETRecord -s 50");
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
