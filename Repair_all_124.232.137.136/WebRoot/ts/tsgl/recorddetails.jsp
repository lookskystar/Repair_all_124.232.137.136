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
<title>探伤记录详情</title>

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
	<table class="tableStyle" formMode="true">
		<tr>
			<td>机车型号：</td>
			<td ><input type="text" value="${depot.jcType}" name=""/></td>	
			<td>机车号：</td>
			<td><input type="text" value="${depot.jcNum}" name=""/></td>			
		</tr>
		<tr>
			<td>修程：</td>
			<td ><input type="text" value="${depot.xc}" name=""/></td>	
			<td>修次：</td>
			<td><input type="text" value="${depot.jcFixNum}" name=""/></td>			
		</tr>
		<tr>
			<td>部件：</td>
			<td><input type="text" value="${depot.unitName}" name=""/></td>
			<td>数量：</td>
			<td><input type="text" value="${depot.unitCount}" name=""/></td>
		</tr>
		<tr>
			<td>编号：</td>
			<td><input type="text" value="${depot.unitNum}" name=""/></td>
			<td>报活人：</td>
			<td><input type="text" value="${depot.atWorker}" name=""/></td>
		</tr>
		<tr>
			<td>主探者：</td>
			<td><input type="text" value="${depot.firstWorker}" name=""/></td>
			<td>复探者：</td>
			<td><input type="text" value="${depot.secondWorker}" name=""/></td>
		</tr>
		<tr>
			<td>报活时间：</td>
			<td><input type="text" value="${depot.atTime}" name=""/></td>
			<td>接活时间：</td>
			<td><input type="text" value="${depot.fixTime}" name=""/></td>
		</tr>
		<tr>
			<td>探伤时间：</td>
			<td><input type="text" value="${depot.tsTime}" name=""/></td>
			<td>探伤方法：</td>
			<td><input type="text" value="${depot.tsMethod}" name=""/></td>
		</tr>
		<tr>
			<td>探伤结果：</td>
			<td><input type="text" value="${depot.tsResult}" name=""/></td>
			<td>处理结果：</td>
			<td><input type="text" value="${depot.tsDeal}" name=""/></td>
		</tr>
		<tr>
			<td colspan="4">
				<button onclick="close(top.Dialog.close());">关闭</button>
			</td>
		</tr>
	</table>
</body>
</html>