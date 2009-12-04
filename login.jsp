<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>光影在线用户登录</title>
</head>
<style>
.s1 {font-family:微软雅黑;font-weight:bolder;}
</style>
<script type="text/javascript">
function validate_form() {

	if (document.login.username.value == ""){
		alert("帐号不能为空！");
		return false;
	}
	if (document.login.password.value == ""){
		alert("密码不能为空！");
		return false;
	}
	return true;
}
function reg() {
	if (validate_form() == false) {
		return;
	}
	this.login.submit();
}
</script>

<body background="image/bg.gif">

<h2 align="center" class="s1">光影在线用户登录</h2>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

<form name="login" action="controlservlet" method="post">
<table align="center">
	<tr>
		<td class="s1">帐号:</td>
		<td><input type="text" name="username"></td>
	</tr>
	<tr>
		<td class="s1">密码:</td>
		<td><input type="password" name="password"></td>
	</tr>
	<tr>
		<td><input type="button" value="登录" onClick="reg()"></td>
		<td><input type="button" value="返回" onClick="document.location='index.jsp'"></td>
	</tr>
	<tr>
		<td><input type="hidden" name="action" value="login"></td>
	</tr>
</table>
</form>

</body>
</html>