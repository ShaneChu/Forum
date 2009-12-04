<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="shane.vo.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>回答问题</title>
</head>
<body background="image/bg.gif">

<%
User user = (User)session.getAttribute("findUser");
if (user == null) {
	response.sendRedirect("index.jsp");
} else { %>

<font color="red"><%=user.getAccount() %></font>您好！<br/>
光影在线可以通过回答问题新设密码。<br/>

<form name="form1" action="/Community/pages/answer.jsp" method="post">
<table>
	<tr>
		<td>问题：</td>
		<td><%=user.getQuestion() %></td>
	</tr>
	<tr>
		<td>答案：</td>
		<td><input type="text" name="answer"></td>
	</tr>
	<tr>
		<td><input type="submit" value="下一步"></td>
		<td><input type="button" value="返回" onClick="document.location='findPasswd.jsp'"></td>
	</tr>
</table>
</form>

<%} %>
<%
request.setCharacterEncoding("utf-8");
String answer = request.getParameter("answer");
if (answer != null) {
	if (answer.equals(user.getAnswer())) {
		session.setAttribute("currentUser", user);
		response.sendRedirect("../info.jsp");
	} else {
		out.println("<font color='red'>答案错误！</font>");
	}
}
%>

</body>
</html>