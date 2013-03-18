package com.gdbocom.report;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.ResultSetMetaData;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import com.gdbocom.util.SendFileinFTP;
import com.viatt.util.GzLog;

/**
 * �������ڶ�ʱ������ʹ��ʳ齱�н�����
 * @author ������
 *
 */
public class CommonReport {
	

	private String file_name = null;
	private String file_head = null;
	private String remark = null;
	private String url=null;
	private String user=null;
	private String pass=null;
	private String query_sql=null;
	private String reportitle=null;
	private String localpath=null;
	private String FTPServer=null;
	private String FTPUser=null;
	private String FTPPass=null;
	private String remotepath=null;
	GzLog gzLog = new GzLog("c:/gzLog_sj");

	public CommonReport(String reportfile){

		try{
			
		//ʹ��Properties�������������ļ�
		Properties props = new Properties();
		props.load(new FileInputStream("./com/gdbocom/report/"+reportfile));
	
    	//�����ļ����ļ�ͷ
		this.file_head=props.getProperty("file_head");
    	//�����������ݿ��·��
		this.url=props.getProperty("url");
		System.out.println(this.url);
    	//�����������ݿ��û���
		this.user=props.getProperty("user");
    	//�����������ݿ������
		this.pass=props.getProperty("pass");
		this.query_sql=new String(props.getProperty("query_sql").getBytes("ISO-8859-1"), "GBK");
		this.reportitle=new String(props.getProperty("reportitle").getBytes("ISO-8859-1"), "GBK");
		this.remark=new String(props.getProperty("remark").getBytes("ISO-8859-1"), "GBK");
		this.localpath=props.getProperty("localpath");
		this.FTPServer=props.getProperty("FTPServer");
		this.FTPUser=props.getProperty("FTPUser");
		this.FTPPass=props.getProperty("FTPPass");
		this.remotepath=props.getProperty("remotepath");

		}catch(IOException e){
			gzLog.Write("CommonReport:��ʼ��ʧ��");
			System.exit(-1);
		}

	}

	public void exportRS(){
		Connection connection = null;
		Statement st = null;
		ResultSet rs = null;
	
		try{

			Calendar cal=Calendar.getInstance();
	        SimpleDateFormat fileformat = new SimpleDateFormat("yyyyMMdd_HHmmss"); 
	        Date date =cal.getTime();
			this.file_name=this.localpath+this.file_head+fileformat.format(date)+".htm";
			
            SimpleDateFormat reportdateformat = new SimpleDateFormat("yyyy-MM-dd"); 
            date =cal.getTime();
            String ReportDate = reportdateformat.format(date); 
            
	     	//�������ݿ�����
			Class.forName("com.sybase.jdbc3.jdbc.SybDriver");
		    //��ȡ���ݿ�����
			connection = DriverManager.getConnection(url, user, pass);
			gzLog.Write("�������ݿ�������"+connection);
			st = connection.createStatement();
			rs = st.executeQuery(this.query_sql);
			
			this.writeFile("<html xmlns=\"http://www.w3.org/TR/REC-html40\">");
			this.writeFile("<head><meta http-equiv=Content-Type content=\"text/html; charset=gb2312\"><style type=\"text/css\"><!--#title{	font-family:\"����\";	font-size:20px;	text-align:center;}#date{	text-align:center;}.content{	text-align:center;}--></style></head>");
			this.writeFile("<body><table border=1 cellpadding=0 cellspacing=0 width=80%><tr><td colspan=3 height=37 width=500><div id=\"title\">"+this.reportitle+"</div></td></tr><tr><td colspan=3 height=18 align=\"right\">");
			this.writeFile(ReportDate);
			this.writeFile("</td></tr>");
			this.writeFile("<tr height=18>");
			ResultSetMetaData rsmd = rs.getMetaData();
			int intcolumncnt = rsmd.getColumnCount();
			for(int i=0; i<intcolumncnt; i++){
				this.writeFile("<th>"+rsmd.getColumnName(i+1)+"</th>");
			}
			this.writeFile("</tr>");
			while(rs.next()){
				this.writeFile("<tr height=18>");
				for(int i=0; i<intcolumncnt; i++){
					this.writeFile("<td class=\"content\">"+rs.getString(i+1)+"</td>");
				}
				this.writeFile("</tr>");
			}
			this.writeFile("<tr><td colspan=\""+intcolumncnt+"\">"+this.remark+"</td></tr>");
			this.writeFile("</table></body></html>");

			this.SendFileonFTP();
		}catch(SQLException e){
			gzLog.Write("���ݿ����:"+e.getMessage());
			System.exit(-1);
		}catch(IOException e){
			gzLog.Write("д���ļ�ʧ��:"+e.getMessage());
			System.exit(-1);
		}catch(Exception e){
			gzLog.Write("��������:"+e.getMessage());
			e.printStackTrace();
			System.exit(-1);
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
				
			}catch(SQLException e){
				
			}
		}
	}
	
	private void writeFile(String content) throws IOException{//д���ļ�����

		FileWriter fw = null;
		fw = new FileWriter(this.file_name,true);
		fw.write(content+"\n");
		fw.close();
	}
	
	public void SendFileonFTP(){
		SendFileinFTP sendfile = new SendFileinFTP();
		try{
			File localfile = new File(this.file_name);
			//����FTP������
			sendfile.connect(this.FTPServer, this.FTPUser, this.FTPPass);
			//�ϴ��ļ�:�����ļ�,Զ��·��,Զ���ļ���,����ģʽ,ftpģʽ
			sendfile.putFile(this.file_name, this.remotepath, localfile.getName(),SendFileinFTP.BINARY_FILE_TYPE,SendFileinFTP.ActiveMode);
			sendfile.close();
			
		}catch(IOException e){
			System.out.println("�ļ�����"+e.getMessage());
		}
	}
	
	public static void main(String[] args) {
		
		new CommonReport(args[0]).exportRS();
	}

}
