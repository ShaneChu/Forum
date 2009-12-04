<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="shane.biz.impl.BoardBiz" %>
<%@ page import="shane.biz.impl.UserBiz" %>
<%@ page import="shane.biz.impl.ArticleBiz" %>
<%@ page import="shane.vo.subcommunity" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>光影在线交流社区</title>
<style>
.s1 {font-family:宋体;font-size:14;}
.s2 {font-family:微软雅黑;font-weight:bolder;}
a:link {COLOR: #000000;text-decoration : none;}
a:visited {COLOR: #000000;text-decoration : none;}
a:active {TEXT-DECORATION: none}
a:hover {text-decoration : none; position : relative; top : 1px; left : 1px}
</style>
<script language="javascript">   
function form_submit() {
	document.form1.submit();   
}
function id_submit(id) {
	document.form2.id.value = id;
	document.form2.submit();
}
</script>   
</head>

<body background="image/bg.gif">
<%
	String user = (String)session.getAttribute("username");
	String acco = (String)session.getAttribute("account");
	boolean isAdmin = new UserBiz().isadmin(acco);
	if (user!=null) {
		if (isAdmin) {
			String head = "<div align='right' class=\"s1\">欢迎你，<font color='red'>管理员&nbsp;</font>"
						+ user + " | <a href='javascript:form_submit();'>个人信息</a> |" 
						+ "<a href='admin.jsp'> 后台管理</a> | <a href='pages/logout.jsp'>退出登录</a></div>";
			out.println(head);
		} else {
			String head = "<div align='right' class=\"s1\">欢迎你，"+user+" | <a href='controlservlet?account="
						+ acco + "&action=modify'>个人信息</a> | <a href='pages/logout.jsp'>退出登录</a></div>";
			out.println(head);
		}
	} else {
		String head = "<div align='right' class='s1'><a href='login.jsp'>登录</a>" 
					+ " | <a href='register.jsp'>注册</a></div>";
		out.println(head);
	}
%>
	<h1 align="center" class="s2">光影在线交流社区</h1>

<table border="0"  align="center">
	<tr align="center">
		<td width="180" bgcolor="lightblue" class="s2">板块名称</td>
		<td width="200" bgcolor="lightblue" class="s2">板块描述</td>
		<td width="100" bgcolor="lightblue" class="s2">主题数</td>
		<td width="120" bgcolor="lightblue" class="s2">创建时间</td>
		<td width="100" bgcolor="lightblue" class="s2">板块状态</td>
	</tr>
	<%
		List<subcommunity> boardList = new BoardBiz().getBoard();
		for (int i=0; i<boardList.size(); i++) {
	%>
		<tr align="center">
			<td>
				<%if (boardList.get(i).getStatus()) { %>
				<%//<a href="topic.jsp?id=<%=boardList.get(i).getSid()%//>"> 
				%>
				<a href="javascript:id_submit(<%=boardList.get(i).getSid() %>);">
					<%=boardList.get(i).getName() %>
				</a>
				<% } else {out.println(boardList.get(i).getName());} %>
			</td>
			<td><%=boardList.get(i).getDescribe() %></td>
			<td>
				<%=new ArticleBiz().getArtNum(boardList.get(i).getSid()) %>
				<%new BoardBiz().updateArtNum(boardList.get(i).getSid()); %>
			</td>
			<td><%=boardList.get(i).getCreTime() %></td>
			<td>
				<%
					if (boardList.get(i).getStatus()) {
						out.println("<font color='red'>开放</font>");
					}  else {
						out.println("<font color='blue'>关闭</font>");
					}
				%>
			</td>
		</tr>
	<% } %>
</table>
<form name="form1" action="controlservlet" method="post">
	<input type="hidden" name="account" value=<%=acco %>>
	<input type="hidden" name="action" value="modify">
</form>
<form name="form2" action="topic.jsp" method="post">
	<input type="hidden" name="id">
</form>
</body>
</html>
