<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="shane.biz.impl.UserBiz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>后台管理</title>
<style>
.s1 {font-family:微软雅黑;}
.s2 {font-family:微软雅黑;font-size:16;font-weight:bolder;}
a:link {COLOR: #000000;text-decoration : none;}
a:visited {COLOR: #000000;text-decoration : none;}
a:active {TEXT-DECORATION: none}
a:hover {text-decoration : none; position : relative; top : 1px; left : 1px}
</style>

</head>
<body background="image/bg.gif">

<%
	String acco = (String)session.getAttribute("account");
	boolean isAdmin = new UserBiz().isadmin(acco);
	if (isAdmin) {
%>

<h2 class="s1" align="center">光影在线交流社区后台管理</h2>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

<table align="center" border="1">
	<tr align="center" bgcolor="lightblue">
		<td width="100" class="s2">管理模块</td>
	</tr>
	<tr align="center">
		<td><a href="adminUser.jsp">用户管理</a></td>
	</tr>
	<tr align="center">
		<td><a href="adminBoard.jsp">板块管理</a></td>
	</tr>
</table>
<%
	} else {
		response.sendRedirect("index.jsp");
	} 
%>
</body>
</html>