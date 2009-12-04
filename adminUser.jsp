<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="shane.biz.impl.UserBiz,java.util.*,shane.vo.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户管理</title>
<style>
.s1 {font-family:微软雅黑;}
.s2 {font-family:微软雅黑;font-weight:bolder;}
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
		List<User> userList = new UserBiz().getAllUser();
%>

<h2 class="s1" align="center">用户管理</h2>
<p>&nbsp;</p>

<table align="center" border="1">
	<tr align="center" bgcolor="lightblue" class="s2">
		<td width="40">序号</td>
		<td width="100">用户帐号</td>
		<td width="100">密码</td>
		<td width="100">昵称</td>
		<td width="40">性别</td>
		<td width="40">年龄</td>
		<td width="150">邮箱</td>
		<td width="80">身份</td>
		<td width="40">管理</td>
	</tr>
<%for (int i=0; i<userList.size(); i++) { %>
	<tr align="center">
		<td><%=i+1 %></td>
		<td><%=userList.get(i).getAccount() %></td>
		<td><%=userList.get(i).getPassword() %></td>
		<td><%=userList.get(i).getName() %></td>
		<td>
			<%  boolean isman = userList.get(i).getGender();
				if (isman) {out.println("男");}
				else {out.println("女");}
			%>
		</td>
		<td><%=userList.get(i).getAge() %></td>
		<td><%=userList.get(i).getEmail() %></td>
		<td>
			<%  int isadmin = userList.get(i).getIdentify();
				if (isadmin == 1) {out.println("<font color='red'>管理员</font>");}
				else {out.println("<font color='blue'>普通用户</font>");}
			%>
		</td>
		<td>
			<a href="UserDel.jsp?account=<%=userList.get(i).getAccount() %>" 
				onclick= "if(confirm('确定删除此用户吗？')){return true;}
				else{return false;}">删除</a>
		</td>
	</tr>
<% } %>
</table>
<p>&nbsp;</p><p>&nbsp;</p>
<div align="center" class="s2">
<font color="red">警告：</font>删除用户后该用户发表的所有主题和帖子都会被删除。
</div>
<%
	} else {
		response.sendRedirect("index.jsp");
	} 
%>
</body>
</html>