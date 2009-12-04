<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="shane.biz.IBoardBiz" %>
<%@ page import="shane.biz.impl.BoardBiz" %>
<%@ page import="shane.biz.impl.UserBiz" %>
<%@ page import="shane.vo.subcommunity" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发表主题</title>

<style>
.s1 {font-family:宋体;font-size:14;}
.s2 {font-family:微软雅黑;font-size:14;font-weight:bolder}
a:link {COLOR: #000000;text-decoration : none;}
a:visited {COLOR: #000000;text-decoration : none;}
a:active {TEXT-DECORATION: none}
a:hover {text-decoration : none; position : relative; top : 1px; left : 1px}
</style>

<script type="text/javascript">

<%String acc = (String)session.getAttribute("account");%>
var acc = "<%=acc %>"

function validate_form() {
	if (document.newTopic.headline.value == ""){
		alert("标题不能为空！");
		return false;
	}
	if (document.newTopic.content.value == ""){
		alert("留言内容不能为空！");
		return false;
	}
	if (acc == "null"){
		alert("请您先登录！");
		return false;
	}
	return true;
}
function reg() {
	if (validate_form() == false) {
		return;
	}
	this.newTopic.submit();
}
function cls() {
	document.getElementById("topicid").value="";
	document.getElementById("contentid").value="";
}
</script>

</head>
<body background="image/bg.gif">

<%
	String user = (String)session.getAttribute("username");
	String acco = (String)session.getAttribute("account");
	if (user!=null) {
		String head = "<div align='right' class=\"s1\">欢迎你，"+user+" | <a href='controlservlet?account="
					+ acco + "&action=modify'>个人信息</a> | <a href='pages/logout.jsp'>退出登录</a></div>";
		out.println(head);
	} else {
		String head = "<div align='right' class='s1'><a href='login.jsp'>登录</a>" 
					+ " | <a href='register.jsp'>注册</a></div>";
		out.println(head);
	}
	IBoardBiz iboard = new BoardBiz();
	List<subcommunity> boardList = iboard.getBoard();
%>

<p>&nbsp;</p>

<form name="newTopic" action="controlservlet" method="post">
<table align="center" border="1">
<tr>
	<td colspan="2" bgcolor="lightblue" class="s2">发表新主题</td>
</tr>
<tr>
	<td width="100" align="right" class="s2">文章标题：</td>
	<td align="left">
		<input type="text" name="headline" id="topicid" size="80">
	</td>
</tr>
<tr>
	<td align="right" class="s2">文章内容：</td>
	<td align="left">
		<textarea cols="70" rows="20" name="content" id="contentid"></textarea>
	</td>
</tr>
<tr>
	<td height="40" align="right" class="s2">选择板块：</td>
	<td>
		<select name="boardName">
			<%for (int i=0; i<boardList.size(); i++) { %>
			<option value=<%=boardList.get(i).getName() %>><%=boardList.get(i).getName() %></option>
			<% } %>
		</select>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<input type="button" value="发表帖子" onClick="reg()">
		<input type="button" value="重新填写" onClick="cls()">
		<input type="hidden" name="uid" value=<%=new UserBiz().getUID(acco) %>>
		<input type="hidden" name="action" value="newtopic">
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td class="s1">
		1.这里发言，表示您接受了光影在线社区的用户行为准则。<br/> 
		2.请对您的言行负责，并遵守中华人民共和国有关法律法规,尊重网上道德。<br/> 
	</td>
</tr>
</table>
</form>

</body>
</html>