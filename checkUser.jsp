<%@ page contentType="text/html; charset=utf-8" import="java.sql.*" errorPage="" %>

<%
String name = request.getParameter("name");

try {
	String sq = "select * from user where U_Account='"+name+"'";
	ResultSet rs = shane.dao.mysql.impl.UserDAO.checkUser(sq);
	if (rs.next()) {
		out.print("2");
	} else {
		out.print("1");
	}
} catch(Exception e) {
	e.printStackTrace();
}
%>
