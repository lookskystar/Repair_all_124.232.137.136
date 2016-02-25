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
	<title>机车检修月计划操作</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->
	<body>
		<div class="box1" panelHeight="170" whiteBg="true">
			<form action="planManage!addMonPlanPriConfirm.action" method="post" target="frmright">
				<input name="monPlan.planType" type="hidden" value="${param.type}" />
				<table width="100%">
					<tr>
						<td height="12px;">
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td width="50%">
							<div style="text-align: right; margin-right: 20px;">编制人：</div>
						</td>
						<td>
							${session_user.xm}
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划类型：</div>
						</td>
						<td>
							<c:if test="${param.type==0}">
								月计划
							</c:if>
							<c:if test="${param.type==1}">
								半月计划
							</c:if>
							<c:if test="${param.type==2}">
								旬月计划
							</c:if>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划月份：</div>
						</td>
						<td>
							<input type="text" class="Wdate"
								onClick="WdatePicker({dateFmt:'yyyy年MM月',minDate:'%y-{%M}'})"
								name="monPlan.planTime" style="width: 120px" />
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value=" 提 交 " />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
	</body>
</html>