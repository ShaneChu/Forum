<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="shane.vo.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人信息页面</title>
</head>
<style>
.s1 {font-family:微软雅黑;font-weight:bolder;}
</style>
<body background="image/bg.gif">

<script type="text/javascript">
function trim(str) {
	var t = str.replace(/(^\s*)|(\s*$)/g, "");
	return t.replace(/(^ *)|( *$)/g, "");
}

function checkPassword(e) {
	if (e.indexOf(" ") >= 0) {
		return false;
	}
return true;
}

function checkEmail(e) {
	var ok = "1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM-_.@[]+";
	for (var i=0; i<e.length; i++) {
		if (ok.indexOf(e.charAt(i))<0) {
			return false;
		}
	}
	if (e.indexOf("@")<=0) {
		return false;
	}
	if (e.indexOf(".")<=0) {
		return false;
	}
	if (e.indexOf("@")>e.lastIndexOf(".")) {
		return false;
	}
	return true;
}

function validate_form() {
	if (document.form1.password.value == ""){
		alert("密码不能为空！");
		return false;
	}
	if (document.form1.password2.value == ""){
		alert("确认密码不能为空！");
		return false;
	}
	if (document.form1.password.value != document.form1.password2.value) {
		alert("两次密码不一致！");
		return false;
	}
	if (checkPassword(document.form1.password.value) == false) {
		alert("密码不能包含空格！");
		return false;
	}
	if (document.form1.name.value == "") {
		alert("昵称不能为空！");
		return false;
	}
	if (document.form1.age.value == "") {
		alert("年龄不能为空！");
		return false;
	}		
	if (document.form1.email.value == "") {
		alert("电子邮件不能为空！");
		return false;
	}
	if (document.form1.question.value == "") {
		alert("问题不能为空！");
		return false;
	}
	if (document.form1.answer.value == "") {
		alert("答案不能为空！");
		return false;
	}
	if (checkEmail(trim(document.form1.email.value)) == false) {
		alert("输入的Email不合法！");
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

<%
User user = (User)session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("index.jsp");
} else { %>

<h1 class="s1" align="center">个人信息</h1>

<form name="form1" action="controlservlet" method="post">
<table border="0" width="340" align="center">
<tr>
	<td align="center" width="100" class="s1">帐&nbsp;号：</td>
	<td width="240"><%=user.getAccount() %></td>
</tr>
<tr>
	<td align="center" class="s1">密&nbsp;码：</td>
	<td><input type="password" name="password" id="password" value=<%=user.getPassword() %>></td>
</tr>
<tr>
	<td align="center" class="s1">确认密码：</td>
	<td><input type="password" name="password2" id="password2" value=<%=user.getPassword() %>></td>
</tr>
<tr>
	<td align="center" class="s1">昵&nbsp;称：</td>
	<td><input type="text" name="name" value=<%=user.getName() %>></td>
</tr>
<tr>
	<td align="center" class="s1">性&nbsp;别：</td>
	<td>
		<input type="radio" name="gender" value=1 <%if (user.getGender()==true) {out.println("checked");} %>>男
		<input type="radio" name="gender" value=0 <%if (user.getGender()==false) {out.println("checked");} %>>女
	</td>
</tr>
<tr>
	<td align="center" class="s1">年&nbsp;龄：</td>
	<td><input type="text" name="age" value=<%=user.getAge() %>></td>
</tr>
<tr>
	<td align="center"class="s1">邮&nbsp;箱：</td>
	<td><input type="text" name="email" id="email" value=<%=user.getEmail() %>></td>
</tr>
<tr>
	<td align="center" class="s1">问&nbsp;题：</td>
	<td>
		<input type="text" name="question" id="question" value=<%=user.getQuestion() %>>
	</td>
</tr>
<tr>
	<td align="center" class="s1">答&nbsp;案：</td>
	<td><input type="text" name="answer" value=<%=user.getAnswer() %>></td>
</tr>
<tr>
	<td class="s1">个人头像：</td>
	<td><img height=100 width=100 src='upload/<%=user.getImage()%>.jpg'></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><input name="file" type="file"></td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td class='s1'><font color='red'>只支持JPEG和JPG格式</font></td>
</tr>
<tr>
	<td align="right">
		<input type="hidden" name="action" value="update">
		<input type="hidden" name="account" value=<%=user.getAccount() %>>
		<input type="button" value="返回" onClick="document.location='index.jsp'">
	</td>
	<td><input type="button" value="修改" onClick="reg()"></td>
</tr>
</table>

</form>

<% } %>
</body>
</html>