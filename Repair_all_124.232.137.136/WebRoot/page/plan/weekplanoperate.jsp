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
	<title>机车检修周计划操作</title>
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
			<form action="planManage!weekPlanMakeConfirm.action" method="post" target="frmright" onsubmit="return submitValidate()">
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
							<div style="text-align: right; margin-right: 20px;">月计划：</div>
						</td>
						<td>
							<c:if test="${empty monPlanPri}">
								<select name="weekPlan.monPlanId.monPlanId" id="monplan">
									<option value="">请选择</option>
									<c:if test="${!empty monPlanPris}">
										<c:forEach items="${monPlanPris}" var="entry">
											<option value="${entry.monPlanId }">${entry.planTime }(<c:if test="${entry.planType==0}">月计划</c:if><c:if test="${entry.planType==1}">半月计划</c:if><c:if test="${entry.planType==2}">旬计划</c:if>)</option>
										</c:forEach>
									</c:if>
								</select>
							</c:if>
							<c:if test="${!empty monPlanPri}">
								<input type="hidden" name="weekPlan.monPlanId.monPlanId" value="${monPlanPri.monPlanId}"/>
								${monPlanPri.planTime }(<c:if test="${monPlanPri.planType==0}">月计划</c:if><c:if test="${monPlanPri.planType==1}">半月计划</c:if><c:if test="${monPlanPri.planType==2}">旬计划</c:if>)
							</c:if>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划日期：</div>
						</td>
						<td>
							<input type="text" class="Wdate"
								onfocus="WdatePicker({minDate:'%y-%M-{%d+1}'})" name="weekPlan.planDate" style="width: 120px" />
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">类型：</div>
						</td>
						<td>
							<select id="fixFreque" name="weekPlan.planType">
								<option value="0">第一周计划</option>
								<option value="1">第二周计划</option>
								<option value="2">第三周计划</option>
								<option value="3">第四周计划</option>
								<option value="4">第五周计划</option>
							</select>
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
		<script type="text/javascript">
			function submitValidate() {
				if ($('#monplan').val()!='') {
					return true;
				}
				top.Dialog.alert("请选择所属月计划！");
				return false;
			}
		</script>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
	</body>
</html>