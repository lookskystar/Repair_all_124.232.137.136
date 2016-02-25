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
	<title>机车检修日计划填写检修内容</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->
	<body>
		<div class="box1" panelHeight="270" whiteBg="true">
			<form action="planManage!jcgzAddOverhaulContentConfirm.action" method="post" target="jcgz_gdt" onsubmit="return submitValidate()">
				<input type="hidden" name="id" value="${datePlanPri.rjhmId}"/>
				<table width="100%">
					<tr>
						<td height="12px;">
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td width="40%">
							<div style="text-align: right; margin-right: 20px;">日计划：</div>
						</td>
						<td>
							${datePlanPri.jcType}-${datePlanPri.jcnum}-${datePlanPri.fixFreque}
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">检修内容：</div>
						</td>
						<td>
							<textarea id="content" name="preDict.repsituation"></textarea>
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
				if ($('#content').val()=='') {
					top.Dialog.alert("检修内容不能为空！");
					return false;
				} 
				return true;
			}
		</script>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js">
</script>
	</body>
</html>