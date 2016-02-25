<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>" />
<title>派工</title>

<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" id="skin"
	prePath="<%=basePath%>" />
<!--框架必需end-->
<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css" />

<!--引入组件start-->
<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
</head>

<body>
<form action="tsAction!paigong.do" method="post" target="frmright">
	<input type="hidden" value="${id}" name="id"/>
	<table class="tableStyle" formMode="true">
		<tr>
			<td>机车型号：</td>
			<td><input type="text" value="${jcType}" name=""/></td>				
		</tr>
		<tr>
			<td>机车编号：</td>
			<td><input type="text" value="${jcNum}" name=""/></td>
		</tr>
		<tr>
			<td>部件名称：</td>
			<td><input type="text" value="${unitName}" name=""/></td>
		</tr>
		<tr>
			<td>主探工人：</td>
			<td>
				<select name="firstWorker" class="default" style="width:125px;">
					<c:forEach var="tsworker" items="${tsworker}">
					<option>${tsworker.xm}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>复探工人：</td>
			<td>
				<select name="secondWorker" class="default" style="width:125px;">
					<c:forEach var="tsworker" items="${tsworker}">
					<option>${tsworker.xm}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" >
				<input type="reset" value="重置" />&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" value="派工"/>
			</td>				
		</tr>
	</table>
</form>		
</body>
</html>