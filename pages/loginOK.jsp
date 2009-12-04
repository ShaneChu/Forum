<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>登录成功</title>
</head>
<body background="image/bg.gif">

<%
	String success = "<p align='center'><font color='red'>"
		+"恭喜，用户登录成功，三秒会将回到主页</font></p>";
	out.println(success);
	response.setHeader("Refresh","3;URL=" + request.getContextPath() + "/index.jsp");
%>

</body>
</html>