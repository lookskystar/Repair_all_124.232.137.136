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
			    if($("#holidayName").val()==''){
				    alert("节假日名称不能为空！");
				    return false;
			    }
			    if($("#startTime").val()==''){
				    alert("开始时间不能为空！");
				    return false;
			    }
				if($("#endTime").val()==''){
					alert("结束时间不能为空！");
					return false;
				}
			}
	</script>
</head>
<body>
	<form action="maintainAction!saveSinHoliday.do" method="post" id="subForm" target="frmright" onsubmit="return checkform()">
		<div class="box1" panelWidth="290" panelHeight="190" panelTitle="添加单个节假日" showStatus="false" roller="true">
			<table class="tableStyle" transMode="true">
				<tr>
					<td>节假日名称：</td><td><input type="text" id="holidayName" name="holiday.holidayName"/>&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>开始时间：</td><td><input type="text" id="startTime" name="holiday.startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>结束时间：</td><td><input type="text" id="endTime" name="holiday.endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" style="width: 115px;"/>&nbsp;<font color="red">*</font></td>
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
	<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>