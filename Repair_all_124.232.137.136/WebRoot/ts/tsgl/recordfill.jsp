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
<title>探伤记录填写</title>

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
<script type="text/javascript">
	function chkForm(){
		var result = $("#tsResultSel").attr("editValue");
		var deal = $("#tsDealSel").attr("editValue");
		if(result==""||result==undefined){
			top.Dialog.alert("请选择或者输入探伤结果!");
			return false;
		}
		if(deal==""||deal==undefined){
			top.Dialog.alert("请选择或者输入处理结果!");
			return false;
		}
		$("#tsResult").val(result);
		$("#tsDeal").val(deal);
		return true;
	}
</script>
</head>

<body>
	<form action="tsAction!recordFill.do" method="post" target="frmright" onsubmit="return chkForm();">
	<input type="hidden" value="${id}" name="id"/>
		<table class="tableStyle" formMode="true">
		<tr>
			<td>机车型号：</td>
			<td><input type="text" value="${jcType}" name=""/></td>				
		</tr>
		<tr>
			<td>机车编号：</td>
			<td><input type="text" value="${jcNum}" name=""/></td>
		</tr>
		<tr>
			<td>部件名称：</td>
			<td><input type="text" value="${unitName}" name=""/></td>
		</tr>
		<tr>
			<td>主探者：</td>
			<td><input type="text" value="${firstWorker}" name=""/></td>
		</tr>
		<tr>
			<td>复探者：</td>
			<td><input type="text" value="${secondWorker}" name=""/></td>
		</tr>
		<tr>
			<td>探伤方法：</td>
			<td>
				<select name="tsMethod" class="default" style="width:125px">
					<option>超声波探伤</option>
					<option>磁粉探伤</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>探伤结果：</td>
			<td>
				<select id="tsResultSel" editable="true" style="width:125px">
					<option>合格</option>
					<option>裂</option>
				</select>
				<input type="hidden" name="tsResult" id="tsResult" value=""/>
			</td>
		</tr>
		<tr>
			<td>处理结果：</td>
			<td>
				<select id="tsDealSel" editable="true" style="width:125px">
					<option>继续使用</option>
					<option>处理后继续使用</option>
					<option>返厂</option>
				</select>
				<input type="hidden" name="tsDeal" id="tsDeal" value=""/>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="确定"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" />
			</td>				
		</tr>
		</table>
	</form>		
</body>
</html>