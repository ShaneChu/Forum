<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="shane.biz.impl.UserBiz,shane.biz.impl.ArticleBiz,shane.vo.article" %>
<%@ page import="shane.biz.impl.BoardBiz,java.util.*,shane.vo.subcommunity" %>
<%@ page import="shane.dao.mysql.impl.ArticleDAO,shane.dao.mysql.impl.RevertDAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>主题管理</title>
<script>
function validate_form() {
	if (document.mod.headline.value == ""){
		alert("标题不能为空！");
		return false;
	}
	if (document.mod.content.value == ""){
		alert("留言内容不能为空！");
		return false;
	}
	return true;
}
function reg() {
	if (validate_form() == false) {
		return;
	}
	this.mod.submit();
}
</script>
<style>
.s1 {font-family:宋体;font-size:14;}
.s2 {font-family:微软雅黑;font-size:14;font-weight:bolder}
.s3 {font-family:微软雅黑;font-weight:bolder}
</style>

</head>
<body background="image/bg.gif">
<%
	String op = request.getParameter("op");
	String _aid = request.getParameter("id");
	if (_aid == null) {
		_aid = "0";
	}
	int aid = Integer.parseInt(_aid);
	
	ArticleDAO artdao = new ArticleDAO();
	int sid = artdao.getSID(aid);
	article art = new ArticleBiz().getArticle(aid);
	String acco = (String)session.getAttribute("account");
	boolean isAdmin = new UserBiz().isadmin(acco);
	if (isAdmin) {
		if (op.equals("up")) {
		
			out.println("up");
			
		} else if (op.equals("mod")) {
%>
<h2 class="s3" align="center">修改主题</h2>
<form name="mod" action="controlservlet" method="post">
<table align="center" border="1">
<tr>
	<td width="100" align="right" class="s2">文章标题：</td>
	<td align="left">
		<input type="text" name="headline" id="topicid" size="80" value="<%=art.getTopic() %>">
	</td>
</tr>
<tr>
	<td align="right" class="s2">文章内容：</td>
	<td align="left">
		<textarea cols="70" rows="20" name="content" id="contentid"><%=art.getContent() %></textarea>
	</td>
</tr>
<tr>
	<td height="40" align="right" class="s2">选择板块：</td>
	<td>
		<select name="boardName">
			<%  List<subcommunity> boardList = new BoardBiz().getBoard();
				for (int i=0; i<boardList.size(); i++) { 
			%>
			<option value=<%=boardList.get(i).getName()%>
				<%	String boardName = boardList.get(i).getName();
					if (artdao.getSID(aid) == boardList.get(i).getSid()) {
					out.println("selected");} %>>
				<%=boardName %>
			</option>
			<% } %>
		</select>
		<select name="isTop">
			<option value=1 <%if (artdao.getArticle(aid).isTop()) {
					out.println("selected");} %>>
				置顶
			</option>
			<option value=0 <%if (!artdao.getArticle(aid).isTop()) {
					out.println("selected");} %>>
				非置顶
			</option>
		</select>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td>
		<input type="button" value="确认修改" onClick="reg()">
		<input type="hidden" name="action" value="modTopic">
		<input type="hidden" name="aid" value=<%=aid %>>
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

<% } else if (op.equals("del")) {
		boolean flag = new RevertDAO().delRevByAID(aid);
		boolean isArtDel = artdao.delArt(aid);
		String url = "topic.jsp?id="+sid;
		response.sendRedirect(url);
} %>
<% } else { 
	response.sendRedirect("index.jsp");
} %>
</body>
</html>