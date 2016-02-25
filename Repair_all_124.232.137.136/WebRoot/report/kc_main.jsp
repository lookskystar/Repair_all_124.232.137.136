<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>机车检修查询条件窗口</title>
<link href="<%=basePath %>css/test.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>js/tree/dtree/dtree.css" type="text/css" rel="stylesheet" />
</head>

<body bgcolor="#f8f7f7">
<div class="shortcut" style="z-index:1000">
  <iframe style="position:absolute; left:0px; top:0px; width:142px; height:300px; border:1px solid #229900; z-index:-1; opacity:0; filter:alpha(opacity=0);"></iframe>
</div> 
<div class="shortcut_btn" id="shortcut_btn"></div>
<div style="width:100%;height:100%;left:0px;top:0px;position:absolute;dispay:hidden;z-index: -1" id="content1">
	<iframe scrolling="auto" frameborder="0"  src="<%=basePath %>report!findAllJC.do?type=kc" style="width:100%;height:100%;"></iframe>
</div>
</body>
</html>