<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.viatt.util.*"%>

<!-- 分行特色业务频道列表 -->
<%
		
	GzLog log = new GzLog("c:/gzLog_sj");
	
	
	log.Write("=================Mobile Phone channelList.jsp======================begin==========");

	String cdno = request.getHeader("MBK_ACCOUNT");
	int crdLength = cdno.length();
	String cardNumber = cdno;
	//如果卡号的长度小于21位 则需要在右侧补空格，补成21bit长
	if(crdLength<21){
		for (int i=crdLength; i<21; i++){
		 	cardNumber=cardNumber+" ";
		}
	}
	
	String version = request.getHeader("MBK_VERSION");
	
	//Initial Definition
	
	char errorFlag;
	
	String willInsert="NO";
	willInsert=request.getParameter("willInsert");
	if(willInsert==null){
		willInsert="NO";
	}
	
	boolean hasAgree=false;
	
	
	
	log.Write("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	log.Write("MBK_ACCOUNT=cdno:"+request.getHeader("MBK_ACCOUNT"));
	log.Write("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	log.Write("MBK_POI:"+request.getHeader("MBK_POI"));
	log.Write("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	log.Write("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	
	log.Write("SessionId："+session.getAttribute("id"));
	log.Write("INITIAL hasAgree:"+hasAgree);
	log.Write("INITIAL willInsert:"+willInsert);
	
	


	
	String testIp="182.53.15.200";
	int testPort=35850;
	
	String businessIp="xxxxxxx";
	int businessPort=12345;
	
	
	//下端会被调用
	String ipAdress = testIp;
	int portNo = testPort;
	

	
	//############################查询是否签约#################################
	
			// public header of the package is 8bits prelen for the length of package data, and the 171bits basic info
			String queryHead="00000192000048217000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
			// the package data length is 21bits card number
			
			String queryContent = queryHead+cardNumber;
			int length=queryContent.length();
			
			log.Write("###################"+"现在是482170交易，查询客户是否签约部分"+"######################");
		
			log.Write("REQUEST_PACKAGE_INFO :["+queryContent+"]"+"\n the send out package length is: "+length);
			
			
			// Socket communication to the ics
		  try{	
						BufferedReader inputStream = null; /* receive */
						PrintWriter outputStream = null; /* send */
						
						/*
						 Of course, once we opened one socket communication, we should end it while the timming is good!
						*/
						Socket soc = new Socket(ipAdress, portNo);
						inputStream = new BufferedReader(new InputStreamReader(soc.getInputStream()));
						outputStream = new PrintWriter(new BufferedWriter(new OutputStreamWriter(soc.getOutputStream())), true);
						
						//send the pacakge into ICS
						outputStream.println(queryContent);
						
						//fetch the reponse from ics
						String feedback=inputStream.readLine();
						int backLength=feedback.length();
						errorFlag=feedback.charAt(11);
						
						//Do the log
						log.Write("REPONSE_PACKAGE_INFO:"+feedback+"\n The errorFlag is: "+errorFlag);		
						
						
						/*
							Be attention that the the errorFlag could be “E” which means the ICS cannot handl the corresponding transaction
							properly. Only when the errorFlag returns as "N" the ICS transaction runs correct and bring the database query result
							with the response package info.
						*/
						 
						 
						if(feedback.charAt(backLength-1)=='T')
						{
						   // this means the cardno is existed in the database table, the related customer has signed the contract!
						   hasAgree=true;	
						
						}
					 else if(feedback.charAt(backLength-1)=='F')
					  {
					 		hasAgree=false;
					 	}
						
						log.Write("Query Result is:"+feedback.charAt(backLength-1)+"\n hasAgree is:"+hasAgree);		
						
						/*
							shut down what we opened
						*/
						inputStream.close();
						outputStream.close();
						soc.close();
					} catch (Exception e) {
							e.printStackTrace();
					}

			
			
//##################################################真正进行数据库的插入，将卡号插入签约表中####################################
	if(hasAgree==false){
			
			
				//交易482171#
				log.Write("###################"+"现在是482171交易，插入签约客户卡号操作部分"+"######################");
				String packageHead2="00000192000048217100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
				String insertContent=packageHead2+cardNumber;
                
				// Socket communication to the ics
				 try{	
				 			BufferedReader inputStream = null; /* receive */
				 			PrintWriter outputStream = null; /* send */
				 			
				 			/*
				 			 Of course, once we opened one socket communication, we should end it while the timming is good!
				 			*/
				 			Socket soc = new Socket(ipAdress, portNo);
				 			inputStream = new BufferedReader(new InputStreamReader(soc.getInputStream()));
				 			outputStream = new PrintWriter(new BufferedWriter(new OutputStreamWriter(soc.getOutputStream())), true);
				 			
				 			//send the pacakge into ICS
				 			outputStream.println(insertContent);
				 			
				 			//fetch the reponse from ics
				 			String feedback=inputStream.readLine();
				 			int backLength=feedback.length();
				 			errorFlag=feedback.charAt(11);
				 			
				 			//Do the log
				 			
				 			log.Write("REQUEST PACKAGE INFO: "+insertContent);
				 			log.Write("/n RESPONSE PACAKGE INFO: :"+feedback+"\n RESPONSE LENGTH= : "+backLength+"/n ErrorFlag= "+errorFlag);		
				 			
				 			
				 			/*
				 				Be attention that the the errorFlag could be “E” which means the ICS cannot handl the corresponding transaction
				 				properly. Only when the errorFlag returns as "N" the ICS transaction runs correct and bring the database query result
				 				with the response package info.
				 			*/
				 			 
				 			 
				 			if(feedback.charAt(backLength-1)=='T')
				 			{
				 			   // this means the cardno number insert operation did successfully
				                
				        			
				 			}
				 			
				 			log.Write("The inesrt cardno operation result is  :"+feedback.charAt(backLength-1));		
				 			
				 			/*
				 				shut down what we opened
				 			*/
				 			inputStream.close();
				 			outputStream.close();
				 			soc.close();
				 			willInsert="DONE";
				 			
				 }catch (Exception e) {
				 				e.printStackTrace();
				 } 
								
		}
							
%>

<res>
	<content>	
		<%
		  if(willInsert.equals("DONE")){
		%>  
			<label>	
	     尊敬的客户，您已经成功签约。请选择“菜单，返回主页”功能，回到分行特色业务界面继续您的业务使用。感谢您的关心与支持。
	    </label>
		 <%
		 	}else if(hasAgree==true){
		 %>
		   <label>
		   	尊敬的客户，您已经成功签约，无法再次进行重复签约， 请您通过“菜单”选项中的返回主页，并继续您的业务使用。感谢您的关心与支持。
		   </label>
		  <%
				}else {
		  %>
		  
			<label>
				签约过程有错误，请重新尝试。
			</label>
		<%
			}
    %>				
	</content>
</res>O