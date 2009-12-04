<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<style>
.s1 {font-family:宋体;font-size:14;}
.s2 {font-family:微软雅黑;font-weight:bolder;}
</style>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>注册页面</title>

<script type="text/javascript">
function trim(str) {
	var t = str.replace(/(^\s*)|(\s*$)/g, "");
	return t.replace(/(^ *)|( *$)/g, "");
}

var xmlHttp;
function createXMLHttpRequest() {
	if (window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	}
}

function validate() {
	createXMLHttpRequest();
	var name = document.getElementById("account").value;
	var str = "name="+name;
	var url = "checkUser.jsp";
	xmlHttp.open("POST", url, true);
	xmlHttp.onreadystatechange = callback;
	xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xmlHttp.send(str);
}

function callback() {
	if (xmlHttp.readyState == 4) {
		var s = xmlHttp.responseText;
		if (trim(s)==1) {
			this.form1.submit();
			clear();
		}
		if (trim(s)==2) {
			var ta = "<font color='red' class='s1'>抱歉，该用户已存在！</font>";
			document.getElementById("res").innerHTML=ta;
			document.getElementById("account").value="";
		}
		if (trim(s)==0) {
			alert("产生异常");
		}
	}
}

function clear() {
	document.getElementById("account").value="";
	document.getElementById("password").value="";
	document.getElementById("password2").value="";
	document.getElementById("email").value="";
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
	if (document.form1.account.value == ""){
		alert("帐号不能为空！");
		return false;
	}
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
	validate();
}
</script>

</head>
<body background="image/bg.gif">

<h1 align="center" class="s2">光影在线用户注册</h1>
<p>&nbsp;</p>

<%
String act = (String)request.getParameter("act");
if (act == null) {act = "";}
if (act.equals("ok")) {
%>

<form name="form1" action="controlservlet" method="post">

<table align="center" border="0" width="500">
<tr>
	<td align="center" width="100" class="s2">帐&nbsp;号：</td>
	<td width="180"><input type="text" name="account" id="account"></td>
	<td width="200"><div id="res">&nbsp;</div></td>
</tr>
<tr>
	<td align="center" class="s2">密&nbsp;码：</td>
	<td><input type="password" name="password" id="password"></td>
</tr>
<tr>
	<td align="center" class="s2">确认密码：</td>
	<td><input type="password" name="password2" id="password2"></td>
</tr>
<tr>
	<td align="center" class="s2">昵&nbsp;称：</td>
	<td><input type="text" name="name"></td>
</tr>
<tr>
	<td align="center" class="s2">性&nbsp;别：</td>
	<td>
		<input type="radio" name="gender" value=1 checked>男
		<input type="radio" name="gender" value=0>女
	</td>
</tr>
<tr>
	<td align="center" class="s2">年&nbsp;龄：</td>
	<td><input type="text" name="age"></td>
</tr>
<tr>
	<td align="center" class="s2">邮&nbsp;箱:</td>
	<td><input type="text" name="email" id="email"></td>
</tr>
<tr>
	<td align="center" class="s2">问&nbsp;题：</td>
	<td>
		<select name="question">
			<option value="我的职业是什么？">我的职业是什么？</option>
			<option value="我叫什么名字？">我叫什么名字？</option>
			<option value="我的老师是谁？">我的老师是谁？</option>
			<option value="我的父亲叫什么名字？">我的父亲叫什么名字？</option>
			<option value="我父亲的生日是什么？">我父亲的生日是什么？</option>
			<option value="我最喜欢的动物是什么？">我最喜欢的动物是什么？</option>
		</select>
	</td>
</tr>
<tr>
	<td align="center" class="s2">答&nbsp;案：</td>
	<td><input type="text" name="answer"></td>
</tr>
<tr>
	<td align="center" class="s2">上传头像：</td>
	<td><input type="file" name="file"></td>
</tr>
<tr>
	<td></td>
	<td class="s2"><font color='red'>只支持JPEG和JPG格式</font></td>
</tr>
<tr>
	<td align="right">
		<input type="hidden" name="action" value="reg">
		<input type="button" value="取消" onClick="document.location='index.jsp'">
	</td>
	<td><input type="button" value="提交" onClick="reg()"></td>
</tr>
</table>

</form>

<% } else { %>

<form name="prot" action="register.jsp" method="post">
<table border="1" align="center" width="600">
	<tr>
		<td align="center" class="s2" bgcolor="lightblue">用户注册协议</td>
	</tr>
	<tr>
		<td class="s1">服务条款和声明 

继续注册前请先阅读【光影在线交流社区】论坛协议 <br/>
欢迎您加入【光影在线交流社区】参加交流和讨论，【光影在线交流社区】为公共论坛，为维护网上公共秩序和社会稳定，请您自觉遵守以下条款：<br/><br/> 
一、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、复制和传播下列信息： <br/><br/>
（一）煽动抗拒、破坏宪法和法律、行政法规实施的；<br/>
（二）煽动颠覆国家政权，推翻社会主义制度的；<br/>
（三）煽动分裂国家、破坏国家统一的；<br/>
（四）煽动民族仇恨、民族歧视，破坏民族团结的；<br/>
（五）捏造或者歪曲事实，散布谣言，扰乱社会秩序的；<br/>
（六）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；<br/>
（七）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；<br/>
（八）损害国家机关信誉的；<br/>
（九）其他违反宪法和法律行政法规的；<br/>
（十）进行商业广告行为的。 <br/><br/>

二、互相尊重，对自己的言论和行为负责。<br/> 
		</td>
	</tr>
	<tr>
		<td align="center"><input type="submit" value="同意"></td>
	</tr>
	<tr>
		<td><input type="hidden" name="act" value="ok"></td>
	</tr>
</table>
</form>

<% } %>

</body>
</html>