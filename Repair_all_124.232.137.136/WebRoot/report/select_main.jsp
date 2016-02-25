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
<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>
<script type="text/javascript" src="<%=basePath %>js/test.js"></script>
<script type="text/javascript" src="<%=basePath %>js/tree/dtree/dtree.js"></script>
</head>

<body bgcolor="#f8f7f7">
	<form id="form1" name="form1" method="post" action="">
		<div class="shortcut" style="z-index:1000">
	  		<iframe style="position:absolute; left:0px; top:0px; width:142px; height:300px; border:1px solid #229900; z-index:-1; opacity:0; filter:alpha(opacity=0);"></iframe>
		</div>
		<div class="shortcut_btn" id="shortcut_btn"></div>
		<div id="content1">
			<c:choose>
				<c:when test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',DSJS,')||fn:containsIgnoreCase(sessionScope.session_user.roles,',DZ,')||fn:containsIgnoreCase(sessionScope.session_user.roles,',DD,')||fn:containsIgnoreCase(sessionScope.session_user.roles,',ZR,')||fn:containsIgnoreCase(sessionScope.session_user.roles,',XTGL,')}">
					<iframe scrolling="auto" frameborder="0"  src="<%=basePath %>report!select.do?type=lead" style="width:100%;height:100%;min-height: 450px;"></iframe>
				</c:when>
				<c:otherwise>
					<iframe scrolling="auto" frameborder="0"  src="<%=basePath %>report!select.do?type=" style="width:100%;height:100%;min-height: 450px;"></iframe>
				</c:otherwise>
			</c:choose>
		</div>
	</form>
</body>
</html>