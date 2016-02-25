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
		<form action="maintainAction!editEquip.do" method="post" target="frmright">   
	  	    <input type="hidden" value="${kqequip.id }" name="equipId"/>
			<table class="tableStyle" transMode="true">
				<tr align="center">
					<td>设备名称：</td>
					<td>
						<input type="text" name="equip.equipName" value="${kqequip.equipName }"></input>
					</td>
				</tr>
				<tr align="center">
					<td>设备型号：</td>
					<td>
						<input type="text" name="equip.equipType" value="${kqequip.equipType }" style="width: 115px;"/>
					</td>
				</tr>
				<tr align="center">
					<td>设备编号：</td>
					<td>
						<input  type="text" name="equip.equipNum" value="${kqequip.equipNum }" style="width: 115px;"/>
					</td>
				</tr>
				<tr align="center">
					<td>使用位置：</td>
					<td>
						<input  type="text" name="equip.equipPosition" value="${kqequip.equipPosition }" style="width: 115px;"/>
					</td>
				</tr>
				<tr align="center">
					<td>设备ip：</td>
					<td>
						<input  type="text" name="equip.equipIp" value="${kqequip.equipIp }" style="width: 115px;"/>
					</td>
				</tr>
				<tr align="center">
					<td>状态：</td>
					<td>
						<select name="equip.equipState">
							<c:if test="${kqequip.equipState ==1 }">
								<option value="1">使用中</option>
								<option value="0">未启用</option>
							</c:if>
							<c:if test="${kqequip.equipState ==0 }">
								<option value="0">未启用</option>
								<option value="1">使用中</option>
							</c:if>
						</select>
					</td>
				</tr>
				<tr align="center">
					<td>端口号：</td>
					<td>
						<input  type="text" name="equip.equipPort" value="${kqequip.equipPort }"  style="width: 115px;"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="修 改"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>      
			</table>
	</body>
</html>