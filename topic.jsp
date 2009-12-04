<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="shane.biz.IArticleBiz" %>
<%@ page import="shane.biz.impl.ArticleBiz,shane.dao.mysql.impl.BoardDAO" %>
<%@ page import="shane.biz.impl.RevertBiz" %>
<%@ page import="shane.biz.impl.UserBiz" %>
<%@ page import="shane.vo.article" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>主题列表</title>
<script language="javascript">   
function form_submit() {
	document.form1.submit();   
}   
</script>
<style>
.s1 {font-family:宋体;font-size:14;}
.s2 {font-family:微软雅黑;font-weight:bolder;}
a:link {COLOR: #000000;text-decoration : none;}
a:visited {COLOR: #000000;text-decoration : none;}
a:active {TEXT-DECORATION: none}
a:hover {text-decoration : none; position : relative; top : 1px; left : 1px}
</style>
</head>

<body background="image/bg.gif">
<%
	String _sid = request.getParameter("id");
	if (_sid == null) {
		_sid = "0";
	}
	Integer sid = Integer.parseInt(_sid);
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
			String head = "<div align='right' class='s1'>欢迎你，"+user+" | <a href='controlservlet?account="
						+ acco + "&action=modify'>个人信息</a> | <a href='pages/logout.jsp'>退出登录</a></div>";
			out.println(head);
		}
	} else {
		String head = "<div align='right' class='s1'><a href='login.jsp'>登录</a>" 
					+ " | <a href='register.jsp'>注册</a></div>";
		out.println(head);
	}
	if (sid == 0) {
		response.sendRedirect("index.jsp");
	} else {
%>

<p class='s1'>&nbsp;
	<a href='index.jsp'>首页</a>>>><%=new BoardDAO().getBoardName(sid) %>
</p>

<table border="0"  align="center">
	<tr align="center">
		<td width="200" bgcolor="lightblue" class="s2">主题名称</td>
		<td width="120" bgcolor="lightblue" class="s2">发表人</td>
		<td width="60" bgcolor="lightblue" class="s2">回复数</td>
		<td width="140" bgcolor="lightblue" class="s2">发表时间</td>
		<td width="100" bgcolor="lightblue" class="s2">最后回复人</td>
		<td width="140" bgcolor="lightblue" class="s2">最后回复时间</td>
	</tr>
	<%
		IArticleBiz articlebiz = new ArticleBiz();
		List<article> articleList = articlebiz.getArticleByID(sid);
		for (int i=0; i<articleList.size(); i++) {
	%>
	<tr align="center">
			<td>
				<%if (articleList.get(i).isTop()) {out.println("<font color='red'>【顶】</font>");} %>
				<a href="article.jsp?aid=<%=articleList.get(i).getAid()%>">
					<%=articleList.get(i).getTopic() %>
				</a>
			</td>
			<td>
				<%=articlebiz.getUserName(articleList.get(i).getUserid())%>
			</td>
			<td>
				<%=new RevertBiz().getRevNum(articleList.get(i).getAid()) %>
				<%new ArticleBiz().updateRevNum(articleList.get(i).getAid()); %>
			</td>
			<td><%=articleList.get(i).getCreTime() %></td>
			<td>
				<%=articlebiz.getUserName(articleList.get(i).getLastReUser())%>
			</td>
			<td><%=articleList.get(i).getLastReTime() %></td>
	</tr>	
	<% }} %>
</table>
<p align="right"><input type="button"  value="发表主题" onClick="document.location='newTopic.jsp'"></p>

<form name="form1" action="controlservlet" method="post">
	<input type="hidden" name="account" value=<%=acco %>>
	<input type="hidden" name="action" value="modify">
</form>

</body>
</html>