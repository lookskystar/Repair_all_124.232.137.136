<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=basePath %>css/import_basic.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>
<title>Insert title here</title>
<style>
#infotable,#bzFinishiInfo{
	border-collapse: collapse;
}

#infotable th,#infotable td,#bzFinishiInfo th,#bzFinishiInfo td{
	border:1px solid #82A8F9;
	padding-left:2px;
	padding-right:2px;
	height:25px;
	line-height:25px;
}

#jcinfo a{
	font-size:12px;
	border:1px solid #999;
	display:block;
	float:left;
	width:60px;
	text-decoration: none;
	height:20px;
	line-height: 20px;
	text-align: center;
	margin-right:5px;
	font-weight: bold;
	background-color:#900;
	color:#fff;
}
</style>
</head>
<body>
<div style="text-align: center;">
<table class="tableStyle" style="width:550px;" id="infotable">
	<tr>
		<th align="center">车型</th>
		<th align="center">车号</th>
		<th align="center">修程</th>
		<th align="center">扣车时间</th>
		<th align="center">计划起机时间</th>
		<th align="center">计划交车时间</th>
		<th align="center">检修状态</th>
	</tr>
	<tr>
		<td>${datePlan.jcType }</td>
		<td>${datePlan.jcnum }</td>
		<td>${datePlan.fixFreque }</td>
		<td>${datePlan.kcsj }</td>
		<td>${datePlan.jhqjsj }</td>
		<td>${datePlan.jhjcsj }</td>
		<td>
			<c:if test="${datePlan.planStatue==-1 }">接车</c:if>
			<c:if test="${datePlan.planStatue==0 }">检修作业</c:if>
			<c:if test="${datePlan.planStatue==1 }">待验</c:if>
			<c:if test="${datePlan.planStatue==2 }">已交验</c:if>
			<c:if test="${datePlan.planStatue==3 }">机车转出</c:if>
		</td>
	</tr>
</table>
<table class="tableStyle" style="width:550px;" id="jcinfo">
	<tr>
		<td align="center">
			<a href="<%=basePath %>query!getInfoByBZ.do?jcStype=${datePlan.jcType }&workFlag=1&type=work&jcNum=${datePlan.jcnum }&xcxc=${datePlan.fixFreque}&teamId=${sessionScope.session_user.bzid}" target="_blank">检修记录</a>
			<a href="<%=basePath %>query!getAllInfoPre.do?jcStype=${datePlan.jcType }&workFlag=1&type=work&jcNum=${datePlan.jcnum }&xcxc=${datePlan.fixFreque }&teamId=${sessionScope.session_user.bzid}" target="_blank">报活记录</a>
		</td>
	</tr>
</table>
</body>
</html>