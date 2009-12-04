<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="shane.biz.impl.UserBiz" %>
<%@ page import="shane.biz.impl.BoardBiz" %>
<%@ page import="shane.vo.subcommunity" %>
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
<script>
function validate_form() {
	if (document.form1.boardName.value == ""){
		alert("板块名称不能为空！");
		return false;
	}
	if (document.form1.Desc.value == ""){
		alert("描述不能为空！");
		return false;
	}
	return true;
}
function reg() {
	if (validate_form() == false) {
		return;
	}
	this.form1.submit();
}

</script>
<body background="image/bg.gif">

<%
	String op = request.getParameter("op");
	String _id = request.getParameter("id");
	if (_id == null) {_id = "0";}
	int id = Integer.parseInt(_id);
	String acco = (String)session.getAttribute("account");
	boolean isAdmin = new UserBiz().isadmin(acco);
	if (isAdmin) {
		if (op.equals("modify")) {
			subcommunity board = new BoardBiz().getBoard(id);
%>
<div class="s2" align="center"><h2>修改板块信息</h2></div>
<p>&nbsp;</p><p>&nbsp;</p>
<form name="form1" action="controlservlet" method="post">
<table align="center">
	<tr>
		<td width="80" align="right" class="s2">板块名称：</td>
		<td><input type="text" name="boardName" value=<%=board.getName() %>></td>
	</tr>
	<tr>
		<td align="right" class="s2">板块描述：</td>
		<td><input type="text" name="Desc" value=<%=board.getDescribe() %>></td>
	</tr>
	<tr>
		<td align="right" class="s2">创建时间：</td>
		<td><%=board.getCreTime() %></td>
	</tr>
	<tr>
		<td align="right" class="s2">状态：</td>
		<td>
			<select name="status">
				<option value=1 <%if (board.getStatus()==true) {out.println("selected");} %>>开放</option>
				<option value=0 <%if (board.getStatus()==false) {out.println("selected");} %>>关闭</option>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr>
		<td>
			<input type="hidden" name="action" value="boardmodify">
			<input type="hidden" name="sid" value=<%=board.getSid() %>>
		</td>
		<td><input type="button" value="确定修改" onClick="reg()"></td>
	</tr>
</table>
</form>
<% } else if (op.equals("delete")) {
	
	boolean flag = new BoardBiz().delBoard(id);
	if (flag) {
		response.sendRedirect("adminBoard.jsp");
	}
	
} else if (op.equals("new")) { %>
<div class="s2" align="center"><h2>新建板块</h2></div>
<p>&nbsp;</p><p>&nbsp;</p>
<form name="form1" action="controlservlet" method="post">
<table align="center">
	<tr>
		<td width="80" align="right" class="s2">板块名称：</td>
		<td><input type="text" name="boardName"></td>
	</tr>
	<tr>
		<td align="right" class="s2">板块描述：</td>
		<td><input type="text" name="Desc"></td>
	</tr>
	<tr>
		<td align="right" class="s2">状态：</td>
		<td>
			<select name="status">
				<option value=1 selected>开放</option>
				<option value=0>关闭</option>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr>
		<td>
			<input type="hidden" name="action" value="newboard">
		</td>
		<td><input type="button" value="确定增加" onClick="reg()"></td>
	</tr>
</table>
</form>
<% } %>
<% } else {
		response.sendRedirect("/index.jsp");
	} 
%>
</body>
</html>