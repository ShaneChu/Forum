<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="shane.biz.IUserBiz" %>
<%@ page import="shane.biz.impl.UserBiz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>删除用户</title>
</head>
<body>

<%
String account = request.getParameter("account");
System.out.println(account);
IUserBiz userbiz = new UserBiz();
boolean flag = userbiz.delUser(account);
if (flag) {
	response.sendRedirect("adminUser.jsp");
}
%>

</body>
</html>