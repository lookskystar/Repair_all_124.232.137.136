<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"  prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<script type="text/javascript">
	</script>
	
</head>
<body>
	<table class="tableStyle" useHover="false" useClick="false">
	 	<tr>
	 	   <th width="10%">标题</th>
	 	   <th>内容</th>
	 	</tr>
		<tr>
		    <td align="center">公告标题:</td>
			<td align="center">
			   ${noticeInfo.noticeTitle }
			</td>
		</tr>
		<tr>
		    <td align="center">公告内容:</td>
			<td align="center">
			   ${noticeInfo.noticeContent }
			</td>
		</tr>
		<tr>
		    <td align="center">公告部门:</td>
			<td align="center">
				${noticeInfo.noticeDept }
			</td>
		</tr>
		<tr>
		    <td align="center">开始时间:</td>
			<td align="center">
				${noticeInfo.startTime }
			</td>
		</tr>
		<tr>
		    <td align="center">结束时间:</td>
			<td align="center">
				${noticeInfo.endTime }
			</td>
		</tr>
		<tr>
		    <td align="center">公告时间:</td>
			<td align="center">
				${noticeInfo.noticeTime }
			</td>
		</tr>
		<tr>
		    <td align="center">公告人:</td>
			<td align="center">
				${noticeInfo.noticePerson }
			</td>
		</tr>
	</table>
	<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>