<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="shane.biz.impl.UserBiz" %>
<%@ page import="shane.biz.impl.BoardBiz,java.util.*,shane.vo.subcommunity" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>板块管理</title>
</head>
<style>
.s1 {font-family:微软雅黑;}
.s2 {font-family:微软雅黑;font-weight:bolder;}
a:link {COLOR: #000000;text-decoration : none;}
a:visited {COLOR: #000000;text-decoration : none;}
a:active {TEXT-DECORATION: none}
a:hover {text-decoration : none; position : relative; top : 1px; left : 1px}
</style>

<body background="image/bg.gif">
<%
	String acco = (String)session.getAttribute("account");
	boolean isAdmin = new UserBiz().isadmin(acco);
	if (isAdmin) {
		List<subcommunity> boardList = new BoardBiz().getBoard();
%>

<h2 class="s1" align="center">板块管理</h2>
<p>&nbsp;</p>

<table align="center" border="1">
	<tr align="center" bgcolor="lightblue" class="s2">
		<td width="40">序号</td>
		<td width="100">板块名</td>
		<td width="150">板块描述</td>
		<td width="100">创建时间</td>
		<td width="40">状态</td>
		<td width="80" colspan="2">管理</td>
	</tr>
<%for (int i=0; i<boardList.size(); i++) { %>
	<tr align="center">
		<td><%=i+1 %></td>
		<td><%=boardList.get(i).getName() %></td>
		<td><%=boardList.get(i).getDescribe() %></td>
		<td><%=boardList.get(i).getCreTime() %></td>
		<td>
			<%
				boolean flag = boardList.get(i).getStatus();
				if (flag) {out.println("<font color='red'>开放</font>");}
				else {out.println("<font color='blue'>关闭</font>");} 
			%>
		</td>
		<td><a href="boardManage.jsp?op=modify&id=<%=boardList.get(i).getSid() %>">修改</a></td>
		<td>
			<a href="boardManage.jsp?op=delete&id=<%=boardList.get(i).getSid() %>"
			   onclick= "if(confirm('确定删除此板块吗？')){return true;}
			   else{return false;}">删除</a>
		</td>
	</tr>
<% } %>
	<tr align="center">
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td colspan="2"><a href="boardManage.jsp?op=new">新增板块</a></td>
	</tr>
</table>
<p>&nbsp;</p><p>&nbsp;</p>
<div align="center" class="s2">
<font color="red">警告：</font>删除板块后该板块下的所有主题和帖子都会被删除。
</div>
<%
	} else {
		response.sendRedirect("index.jsp");
	} 
%>
</body>
</html>