<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<base href="<%=basePath%>" />
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->
	<body>
		<form action="maintainAction!editHoliday.do" method="post" target="frmright">   
	  	    <input type="hidden" value="${holiday.id }" name="holidayId"/>
			<table class="tableStyle" transMode="true">
				<tr align="center">
					<td>节假日名称：</td>
					<td>
						<input type="text" name="holiday.holidayName" value="${holiday.holidayName }"></input>
					</td>
				</tr>
				<tr align="center">
					<td>放假开始时间：</td>
					<td>
						<input type="text" name="holiday.startTime" value="${holiday.startTime }" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>
					</td>
				</tr>
				<tr align="center">
					<td>放假结束时间：</td>
					<td>
						<input  type="text" name="holiday.endTime" value="${holiday.endTime }" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="修 改"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>      
			</table>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
	</body>
</html>