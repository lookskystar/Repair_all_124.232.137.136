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
	<head>
		<base href="<%=basePath%>"/>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
		<!--框架必需end-->
	</head>
<body>
<div>
	<table class="tableStyle">
		<tr>
				<th colspan="4" align="left" style="color:#00f;font-size: 14px;">
					加改项目：${itemName }
				</th>
        </tr>
		<tr align="center">
				<th width="30px">序号</th>
				<th width="20%">日期</th>
				<th width="20%">车型车号</th>
				<th>备注</th>
		</tr>
		<c:forEach var="jc" items="${result}" varStatus="idx">
			<tr>
				<td align="center">
					${idx.index+1}
				</td>
				<td align="center">
					${jc[3]}
				</td>
				<td align="center">
					<a href="query!view.do?rjhmId=${jc[4]}" target="_blank" style="color: #00f;">
						${jc[0]}-${jc[1]}
					</a>
				</td>
				<td align="center">
					${jc[2]}
				</td>
			</tr>					
		</c:forEach>
	</table>
</div>
</body>
</html>
