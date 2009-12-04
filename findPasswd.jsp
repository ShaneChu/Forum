<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新设密码</title>
</head>
<body background="image/bg.gif">

<h1>用户密码找回</h1>

<form name="form1" action="controlservlet" method="post">
<table>
	<tr>
		<td>请输入用户名：</td>
		<td><input type="text" name="account"></td>
	</tr>
	<tr>
		<td align="right"><input type="submit" value="下一步"></td>
		<td><input type="button" value="返回" onClick="document.location='login.jsp'"></td>
	</tr>
	<tr>
		<td><input type="hidden" name="action" value="findpw"></td>
	</tr>
</table>
</form>

</body>
</html>