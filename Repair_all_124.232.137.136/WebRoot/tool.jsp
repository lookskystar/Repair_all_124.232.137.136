<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>机务检修管理</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
<!--框架必需end-->

<!--鼠标移入图标变色start-->
<script type="text/javascript">
$(function(){
	$(".navIconSmall").hover(function(){
		$(this).addClass("navIconSmall_hover");
	},function(){
		$(this).removeClass("navIconSmall_hover");
	})
})
</script>
</head>
<!--鼠标移入图标变色end-->
<body>
		<div class="navIconSmall" onclick="top.open('http://192.168.1.112:8080/part/loginAction!enter.do?userid=${sessionScope.session_user.userid}')" style="margin: 0px;padding: 0px;">
       		<img src="icons/png/56.png"/>
			<div style="margin: 0px;padding: 0px;">配件检修</div>
       	</div>
</body>
</html>
