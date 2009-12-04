<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shane.biz.IArticleBiz" %>
<%@ page import="shane.biz.impl.ArticleBiz" %>
<%@ page import="shane.vo.article" %>
<%@ page import="shane.biz.IRevertBiz" %>
<%@ page import="shane.biz.impl.RevertBiz,shane.dao.mysql.impl.ArticleDAO" %>
<%@ page import="shane.biz.impl.UserBiz,shane.dao.mysql.impl.BoardDAO" %>
<%@ page import="shane.vo.revert,shane.dao.mysql.impl.UserDAO" %>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>主题页面</title>
</head>

<style>
.s1 {font-family:宋体;font-size:14;}
.s2 {font-family:微软雅黑;font-weight:bolder;}
a:link {COLOR: #000000;text-decoration : none;}
a:visited {COLOR: #000000;text-decoration : none;}
a:active {TEXT-DECORATION: none}
a:hover {text-decoration : none; position : relative; top : 1px; left : 1px}
* { padding:0; }
.msg_caption { width:100%; overflow:hidden; margin-bottom:1px;}
.msg_caption span { display:block; float:left; margin:0 2px; padding:4px 10px; background:#898989; cursor:pointer;color:white; }

</style>

<script src="script/jquery-1.3.2.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	    var $comment = $('#comment');  //获取评论框
	    $('.bigger').click(function() { //放大按钮绑定单击事件
		   if(!$comment.is(":animated")) { //判断是否处于动画
			  if( $comment.height() < 500 ){ 
				  	$comment.animate({ height : "+=50" },400); //重新设置高度，在原有的基础上加50
			  }
			}
		})
		$('.smaller').click(function() {//缩小按钮绑定单击事件
		   if(!$comment.is(":animated")){//判断是否处于动画
				if( $comment.height() > 50 ) {
					$comment.animate({ height : "-=50" },400); //重新设置高度，在原有的基础上减50
				}
			}
		});
	});
<%String acc = (String)session.getAttribute("account");%>
var acc = "<%=acc %>"
function validate_form() {
	if (document.revertSub.content.value == ""){
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
	this.revertSub.submit();
}
function form_submit() {
	document.form1.submit();   
}   
</script>  
<body background="image/bg.gif">

<%
	IArticleBiz artBiz = new ArticleBiz();
	String _aid = request.getParameter("aid");
	if (_aid == null) {
		_aid = "0";
	}
	int aid = Integer.parseInt(_aid);
	
	String user = (String)session.getAttribute("username");
	String acco = (String)session.getAttribute("account");
	boolean isAdmin = new UserBiz().isadmin(acco);
	
	if (user!=null) {
		if (isAdmin) {
			String head = "<div align='right' class=\"s1\">欢迎你，<font color='red'>管理员&nbsp;</font>"
						+ user + " | <a href='javascript:form_submit();'>个人信息</a> |" 
						+ "<a href='admin.jsp'> 后台管理</a> | <a href='pages/logout.jsp'>退出登录</a></div>";
			out.println(head);
		} else {
			String head = "<div align='right' class='s1'>欢迎你，"+user+" | <a href='controlservlet?account="
						+ acco + "&action=modify'>个人信息</a> | <a href='pages/logout.jsp'>退出登录</a></div>";
			out.println(head);
		}
	} else {
		String head = "<div align='right' class='s1'><a href='login.jsp'>登录</a>" 
					+ " | <a href='register.jsp'>注册</a></div>";
		out.println(head);
	}
	if (aid == 0) {
		response.sendRedirect("index.jsp");
	} else {
		int sid = new ArticleDAO().getSID(aid);
%>

<p class='s1'>&nbsp;
	<a href='index.jsp'>首页</a>>>>
	<a href='topic.jsp?id=<%=sid %>'>
		<%=new BoardDAO().getBoardName(sid) %>
	</a>>>>
	<%=artBiz.getArticle(aid).getTopic() %>
</p>
	
<table border="1" align="center" width="800">
<tr bgcolor="lightblue">
	<td colspan="2" class="s2" width="600"><%=artBiz.getArticle(aid).getTopic() %></td>
	<td>
		<%
			if (isAdmin) {
				String opera = "<div class='s1'>&nbsp;&nbsp;&nbsp;"
				+ "<a href='artManage.jsp?op=mod&id="+aid+"'>修改</a> | "
				+ "<a href='artManage.jsp?op=del&id="+aid+"'"
				+ "onclick= \"if(confirm('确定删除此主题吗？删除后该主题的帖子也会被删除！'))"
				+ "{return true;}else{return false;}\">删除</a></div>";
				out.println(opera);
			} else {out.println("&nbsp;");}
		%>
	</td>
</tr>
<tr>
	<td rowspan="2" align="center" width="100">
		<img width=100 height=100 src='upload/<%=new UserDAO().getHeadImage(artBiz.getArticle(aid).getUserid())%>.jpg' /><br/>
		<font color='red'><%=artBiz.getUserName(artBiz.getArticle(aid).getUserid()) %></font>
	</td>
	<td width="560">
		发表于<%=artBiz.getArticle(aid).getCreTime() %>
	</td>
	<td align="right">楼主</td>
</tr>

<tr>
	<td colspan="2">
		<%String cont = artBiz.getArticle(aid).getContent().replaceAll("\r\n","<br/>"); %>
		<%=cont.replaceAll("\r","&nbsp;") %>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
	</td>
</tr>

<%
	IRevertBiz revBiz = new RevertBiz();
	List<revert> revertList = revBiz.getRevertByID(aid);
		for (int i=0; i<revertList.size(); i++) {
%>
<tr>
	<td rowspan="2" align="center" width="100">
		<img width=100 height=100 src='upload/<%=new UserDAO().getHeadImage(revertList.get(i).getUserid())%>.jpg'/>
		<font color='red'><%=revBiz.getUserName(revertList.get(i).getUserid())%></font>
	</td>
	<td>
		发表于<%=revertList.get(i).getCreTime() %>
	</td>
	<td align="right" class="s1">
		<%
			if (isAdmin) {
				int rid = revertList.get(i).getRid();
				String admin = "&nbsp;<a href='revManage.jsp?op=mod&rid="+rid+"'>修改</a> | "
				+ "<a href='revManage.jsp?op=del&rid="+rid+"' onclick= \""
				+ "if(confirm('确定删除此帖子吗？')){return true;}else{return false;}\">"
				+ "删除</a>&nbsp;";
				out.println(admin);
			}
		%>
		<%=i+1 %>楼
		</td>
</tr>

<tr>
	<td colspan="2">
		<%=revertList.get(i).getContent() %>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
	</td>
</tr>
<% } %>
</table>

<form name="revertSub" action="controlservlet" method="post">
<table align="center" width="800" border="1">
<tr>
	<td align="center" width="150" rowspan="2" class="s2">
		回复贴子<br/>字数限制 5-2000<br/>禁止发任何反动 <br/>色情，政治问题。
	</td>
	<td>
		<div class="msg">
			<div class="msg_caption">
				<span class="bigger" ><font size="2">放大</font></span>
				<span class="smaller" ><font size="2">缩小</font></span>
			</div>
			<div>
				<textarea id="comment" rows="10" cols="75" name="content"></textarea>
			</div>
	</div>
	</td>
</tr>
<tr>
	<td align="right">
		<input type="hidden" name="action" value="revertsub">
		<input type="hidden" name="aid" value=<%=aid %>>
		<input type="hidden" name="uid" value=<%=new UserBiz().getUID(acco) %>>
		<input type="button" value="发表回复" onClick="reg()">
	</td>
</tr>
</table>
</form>
<p>&nbsp;</p><p>&nbsp;</p>
<p>&nbsp;</p><p>&nbsp;</p>
<p>&nbsp;</p><p>&nbsp;</p>
<% } %>
<form name="form1" action="controlservlet" method="post">
	<input type="hidden" name="account" value=<%=acco %>>
	<input type="hidden" name="action" value="modify">
</form>
</body>
</html>