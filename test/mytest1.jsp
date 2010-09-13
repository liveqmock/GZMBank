<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="org.bouncycastle.jce.provider.*"%>

<%
	String kkk = request.getParameter("param");
	System.out.println("PARAM:"+java.net.URLDecoder.decode(kkk));
		
	String yin = request.getParameter("param1");
	String ccc = new String(yin.getBytes("ISO-8859-1"),"UTF-8");	
  System.out.println("PARAM1:"+ccc);
   
	//System.out.println("MBK_ACCOUNT:"+request.getHeader("MBK_ACCOUNT"));
	//System.out.println("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	//String verify = request.getHeader("MBK_VERIFY_RESULT");
	String verify="P";
	
	//System.out.println("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	//System.out.println("MBK_POI:"+request.getHeader("MBK_POI"));
	
	//System.out.println("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	//System.out.println("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	

	//System.out.println("id："+session.getAttribute("id"));

	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	//Session ID
	//String sessionId = request.getSession().getId();
  //sessionId = sessionId.substring(0,63);

  String sessionId = null;
  Cookie ckies[] = request.getCookies();
  if(ckies != null){
    for(int i=0;i<ckies.length;i++){
       if(ckies[i].getName().equals("JSESSIONID")){
           sessionId = ckies[i].getValue();
           int idx = sessionId.indexOf(":");
           if(idx != -1){
             sessionId = sessionId.substring(0,idx);
           }
           break;
         }
      }
  }

	//加密后的密钥，需从header头中获取，字段名同参数名，具体规则见开发规范
	String pwd = request.getHeader("password");
	System.out.println("plantPwd0:"+request.getParameter("password"));
	System.out.println("plantPwd1:"+pwd);
	java.security.Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	//对密码进行解密，解密需要帐号和sessionid作为参数
	//String plantPwd = com.bocom.mobilebank.security.MBSecurityUtil.decryptData(accountNo,sessionId,pwd);
	//String plantPwd = MBSecurityUtil.decryptData(cdno,sessionId,request.getParameter("password"));
	String plantPwd = MBSecurityUtil.decryptData(cdno,sessionId,pwd);
	System.out.println("sessionId:"+sessionId);
	System.out.println("cdno:"+cdno);
	//System.out.println("plantPwd2:"+plantPwd.substring(0,6));
	System.out.println("plantPwd2:"+plantPwd);
%>

<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<% 
		if (verify != null && verify.equals("P")){
	  %>
		<table border='1'>				
			<tr>
				<td>账号：</td><td><%=request.getHeader("MBK_ACCOUNT")%></td>
			</tr>
			<tr>
				<td>手机号：</td><td><%=request.getHeader("MBK_MOBILE")%></td>
			</tr>
			<tr>
				<td>客户端版本信息：</td><td><%=request.getHeader("MBK_VERSION")%></td>
			</tr>
			<tr>
				<td>蜜蜂：</td><td><%=request.getParameter("password")%></td>
			</tr>
			<tr>
				<td>蜜密：</td><td><%=request.getHeader("password")%></td>
			</tr>
			<tr>
				<td>密码：</td><td><%=plantPwd.substring(0,6)%></td>
			</tr>	
		</table>	
		<%
		} else {
		%>
		<Label>验证失败</Label>
		<%=ccc%>
		<%
		}
		%>	
					
	</content>
</res>
