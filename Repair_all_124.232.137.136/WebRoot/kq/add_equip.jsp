<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript">
		function checkform(){
			    if($("#equipName").val()==''){
				    alert("设备名称不能为空！");
				    return false;
			    }
			    if($("#equipType").val()==''){
				    alert("设备型号不能为空！");
				    return false;
			    }
				if($("#equipNum").val()==''){
					alert("设备编号不能为空！");
					return false;
				}
			}
		</script>
</head>
<body>
	<form action="maintainAction!saveEquip.do" method="post" id="subForm" target="frmright" onsubmit="return checkform()">
		<div class="box1" panelWidth="390" panelTitle="添加设备" showStatus="false" roller="true">
			<table class="tableStyle" transMode="true">
				<tr>
					<td>设备名称：</td><td><input type="text" id="equipName" name="equip.equipName"/>&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>设备型号：</td><td><input type="text" id="equipType" name="equip.equipType"/>&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>设备编号：</td><td><input type="text" id="equipNum" name="equip.equipNum"/>&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>设备IP：</td><td><input type="text" id="equipIp" name="equip.equipIp"/></td>
				</tr>
				<tr>
					<td>使用位置：</td><td><input type="text" id="equipPosition" name="equip.equipPosition"/></td>
				</tr>
				<tr>
					<td>状态：</td>
					<td>
						<select name="equip.equipState">
							<option value="1">使用中</option>
							<option value="0">未启用</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>端口号：</td><td><input type="text" value="4370" id="equipPort" name="equip.equipPort"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value=" 提 交 " />
						<input type="reset" value=" 重 置 "/>
					</td>
				</tr>
			</table>
		</div>
	</form>		
</body>
</html>