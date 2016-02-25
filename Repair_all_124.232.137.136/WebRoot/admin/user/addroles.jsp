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
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin"
			prePath="<%=basePath%>" />
		<!--框架必需end-->
		<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
		<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css" />
		<!--截取文字start-->
		<script type="text/javascript" src="js/text/text-overflow.js"></script>
		<!--截取文字end-->
		<!--修正IE6支持透明PNG图start-->
		<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
		<!--修正IE6支持透明PNG图end-->
		<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
		
		<script>
		function checkform(){
				if($("#rolename").val()==''){
					alert("角色名称不能为空！");
					return false;
				}
				if($("#py").val()==''){
					alert("角色拼音不能为空！");
					return false;
				}
				if($("#rolenote").val()==''){
					alert("角色说明不能为空！");
					return false;
				}
			}
		</script>
	</head>
	<body>
		<form action="rolesAction!addRole.action" method="post"
			target="frmright" onsubmit="return checkform()">
			<table class="tableStyle" transMode="true">
				<tr>
					<td>角色名称:</td>
					<td>
						<input class="easyui-validatebox" type="text" name="role.rolename" id="rolename"></input>
					</td>
				</tr>
				<tr>
					<td>角色拼音:</td>
					<td>
						<input class="easyui-validatebox" type="text" name="role.py" id="py"></input>
					</td>
				</tr>
				<tr>
					<td>角色说明:</td>
					<td>
						<input class="easyui-validatebox" type="text" name="role.rolenote" id="rolenote"></input>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value=" 提 交 " />
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" 重 置 " />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>