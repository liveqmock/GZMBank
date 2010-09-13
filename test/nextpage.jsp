<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>

<%
	//System.out.println("MBK_ACCOUNT:"+request.getHeader("MBK_ACCOUNT"));
	//System.out.println("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	
	//System.out.println("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	//System.out.println("MBK_POI:"+request.getHeader("MBK_POI"));
	
	//System.out.println("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	//System.out.println("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	

	//System.out.println("id："+session.getAttribute("id"));

	//String accountNo = request.getHeader("MBK_ACCOUNT");
	//Session ID
	//String sessionId = request.getSession().getId();
	//加密后的密钥，需从header头中获取，字段名同参数名，具体规则见开发规范
	//String pwd = request.getHeader("password1");
	//对密码进行解密，解密需要帐号和sessionid作为参数
	//String plantPwd = com.bocom.mobilebank.security.MBSecurityUtil.decryptData(accountNo,sessionId,pwd);
	//String plantPwd = MBSecurityUtil.decryptData(accountNo,sessionId,pwd);
%>

<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<table border='1'>				
			<tr>
				<td>账号：</td><td><%=request.getHeader("MBK_ACCOUNT")%></td>
			</tr>
			<tr>
				<td>手机号：</td><td><%=request.getHeader("MBK_MOBILE")%></td>
			</tr>

	
		</table>			
	</content>
</res>
