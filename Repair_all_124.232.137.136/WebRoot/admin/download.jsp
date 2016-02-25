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
		<title>文档下载</title>

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
		<div class="box2" panelTitle="文档下载" overflow="auto">
			<table class="tableStyle" useCheckBox="false" overflow="auto">
				<tr>
					<th width="30px" align="center">
						序号
					</th>
					<th>
						文档
					</th>
				</tr>
				<tr>
					<td align="center">
						1
					</td>
					<td>
						<a href="downloadAction.action?filename=机务检修系统需求列表.doc">机务检修系统需求列表.doc</a>
					</td>
				</tr>
				<tr>
					<td align="center">
						2
					</td>
					<td>
						<a href="downloadAction.action?filename=小辅修业务流程概述.doc">小辅修业务流程概述.doc</a>
					</td>
				</tr>
				<tr>
					<td align="center">
						3
					</td>
					<td>
						<a href="downloadAction.action?filename=机务检修管理系统使用说明书.doc">机务检修管理系统使用说明书.doc</a>
					</td>
				</tr>
				<tr>
					<td align="center">
						4
					</td>
					<td>
						<a href="downloadAction.action?filename=系统结构截图.JPG">系统结构截图.JPG</a>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>