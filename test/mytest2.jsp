<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="org.bouncycastle.jce.provider.*"%>

<%
	String sessionId = request.getSession().getId();
	
%>

<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<table border='1'>				
			<tr>
				<td><%=sessionId%>账号：</td>
			</tr>
			</tr>	
		</table>			
	</content>
</res>
