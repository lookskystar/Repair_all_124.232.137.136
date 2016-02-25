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
	<head>
		<base href="<%=basePath%>"/>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
		<!--框架必需end-->
		<script>
		function subForm(){
			var planId = $("#planId").val();
			var jcType = $("#jcType").val();
			var jcNum = $("#jcNum").val();
			var xcxc = $("#xcxc").val();
			var kilometre = $("#kilometre").val();
			var kcArea = $("#kcArea").val();
			var comments = $("#comments").val();
			
			$.post("planManage!updateMainDetailPlan.do", {"planId":planId,"jcType":jcType,"jcNum":jcNum,"xcxc":xcxc,"kilometre":kilometre,"kcArea":kcArea,"comments":comments},function(data) {
				if (data == "success") {
					top.Dialog.alert("项目修改成功!", function() {
						top.Dialog.close();
					});
					window.location.reload();
				}
		});
        }
</script>
	</head>
<body>
<div>
	<input type="hidden" value="${plan.id}" id="planId"/>
	<table class="tableStyle" align="center" transMode="true">
		<tr >
			<td>车型：</td>
			<td><input type="text" id="jcType" value="${plan.jcType }"/></td>
		</tr>
		<tr>
			<td>机车号：</td>
			<td><input type="text" id="jcNum" value="${plan.jcNum }"/></td>
		</tr>
		<tr >
			<td>修程：</td>
			<td><input type="text" id="xcxc" value="${plan.xcxc }"/></td>
		</tr>
		<tr>	
			<td>走行公里数：</td>
			<td><input type="text" id="kilometre" value="${plan.kilometre }"/></td>
		</tr>
		<tr >
			<td>扣修点：</td>
			<td><input type="text" id="kcArea" value="${plan.kcArea }"/></td>
		</tr>
		<tr>	
			<td>备注：</td>
			<td>
				<textarea style="width:168px;height:48px;" id="comments">${plan.comments }</textarea>
			</td>
		</tr>
		<tr align="center">	
			<td colspan="2">
				<input type="button" value="确认提交" onclick="subForm();"/>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
