<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="shane.biz.impl.RevertBiz,java.util.*,shane.vo.revert" %>
<%@ page import="shane.biz.impl.UserBiz,shane.dao.mysql.impl.RevertDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>帖子管理</title>
<script>
function validate_form() {
	if (document.mod.content.value == ""){
		alert("留言内容不能为空！");
		return false;
	}
	return true;
}
function reg() {
	if (validate_form() == false) {
		return;
	}
	this.mod.submit();
}
</script>
<style>
.s1 {font-family:宋体;font-size:14;}
.s2 {font-family:微软雅黑;font-size:14;font-weight:bolder}
.s3 {font-family:微软雅黑;font-weight:bolder}
</style>
</head>
<body background="image/bg.gif">
<%
	String op = request.getParameter("op");
	String _rid = request.getParameter("rid");
	if (_rid == null) {
		_rid = "0";
	}
	int rid = Integer.parseInt(_rid);
	String acco = (String)session.getAttribute("account");
	boolean isAdmin = new UserBiz().isadmin(acco);
	if (isAdmin) {
		if (op.equals("mod")) {
			RevertDAO revdao = new RevertDAO(); 
			revert rev = revdao.getRevert(rid);
			int aid = revdao.getAID(rid);
%>
<p>&nbsp;</p>
<h2 class="s3" align="center">帖子修改</h2>
<p>&nbsp;</p>
<form action="controlservlet" name="mod" method="post">
<table align="center">
<tr>
	<td align="right">
		<textarea rows="10" cols="75" name="content"><%=rev.getContent() %></textarea>
	</td>
</tr>
<tr align="center">
	<td>
		<input type="button" value="确认修改" onClick="reg()">
		<input type="hidden" name="action" value="modRevert">
		<input type="hidden" name="rid" value=<%=rid %>>
		<input type="hidden" name="aid" value=<%=aid %>>
	</td>
</tr>
</table>
</form>

<% } else if (op.equals("del")) {
		RevertDAO revdao = new RevertDAO();
		int aid = revdao.getAID(rid);		//先借rid获取aid再删除帖子
		boolean flag = revdao.delSingleRev(rid);
		String url = "article.jsp?aid="+aid;
		response.sendRedirect(url);
} %>
<% } else {
	response.sendRedirect("index.jsp");
} %>
</body>
</html>