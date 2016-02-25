<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin"
			prePath="<%=basePath%>" />
		<!--框架必需end-->

		<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
		<script type="text/javascript" src="js/text/text-overflow.js"></script>
		<style>
a {
	behavior: url(js/method/focus.htc)
}

.categoryitems span {
	width: 160px;
}
</style>
	</head>

	<body leftFrame="true">
		<div id="scrollContent">
			<div class="arrowlistmenu" overflow="auto">
				<div class="menuheader expandable">
					<span class="normal_icon1"></span>用户角色
				</div>
				<ul class="categoryitems">
					<li>
						<a href="userRolesAction!usersInput.do" target="frmright"><span
							class="text_slice">用户管理</span> </a>
					</li>
					<li>
						<a href="userRolesAction!rolesInput.do" target="frmright"><span
							class="text_slice">角色管理</span> </a>
					</li>
				</ul>

				<div class="menuheader expandable">
					<span class="normal_icon2"></span>机车检修项目
				</div>
				<ul class="categoryitems">
					<li>
						<a href="fixItemAction!itemListInput.do" target="frmright"><span
							class="text_slice">小辅修项目</span> </a>
					</li>
					<li>
						<a href="fixItemAction!zxFixItemList.do" target="frmright"><span
							class="text_slice">中修项目</span> </a>
					</li>
					<li>
						<a href="presetDivisionAction!presetDivisionInput.do?nodeId=106"
							target="frmright"><span class="text_slice">秋整春鉴项目</span> </a>
					</li>
				</ul>

				<div class="menuheader expandable">
					<span class="normal_icon3"></span>车间作业
				</div>
				<ul class="categoryitems">
					<li>
						<a href="presetDivisionAction!presetDivisionInput.do?nodeId=106"
							target="frmright"><span class="text_slice">小辅修预设分类管理</span> </a>
					</li>
					<li>
						<a href="presetDivisionAction!presetZxDivisionInput.do?nodeId=100&zxFlag=1"
							target="frmright"><span class="text_slice">中修预设分类管理</span> </a>
					</li>
					<li>
						<a href="presetDivisionAction!pjPresetDivisionInput.do"
							target="frmright"><span class="text_slice">配件预设分类管理</span> </a>
					</li>
					<li>
						<a href="presetDivisionAction!techDivisionInput.do"
							target="frmright"><span class="text_slice">质检技术人员预分工</span> </a>
					</li>
					<li>
						<a href="reportWorkManage!dictFailureList.action"
							target="frmright"><span class="text_slice">故障管理</span> </a>
					</li>
				</ul>

				<div class="menuheader expandable">
					<span class="normal_icon4"></span>车间管理
				</div>
				<ul class="categoryitems">
					<li>
						<a href="jcManageAction!jcManageInput.do" target="frmright"><span
							class="text_slice">机车管理</span> </a>
					</li>
					<li>
						<a href="jcManageAction!listDatePlanPri.do" target="frmright"><span
							class="text_slice">在修机车管理</span></a>
					</li>
				</ul>
				
				<div class="menuheader expandable">
					<span class="normal_icon7"></span>报表与系统
				</div>
				<ul class="categoryitems">
					<li>
						<a href="reportTemplate!searchTemplateItem.do" target="frmright"><span
							class="text_slice">小辅修报表设置</span> </a>
					</li>
					<li>
						<a href="system!setInput.do" target="frmright"><span
							class="text_slice">系统设置</span> </a>
					</li>
				</ul>
				
				<div class="menuheader expandable">
					<span class="normal_icon5"></span>下载与帮助
				</div>
				<ul class="categoryitems">
					<li>
						<a href="downloadAction!downloadInput.action" target="frmright"><span
							class="text_slice">文档下载</span> </a>
					</li>
				</ul>
			</div>
		</div>
	</body>
</html>
