<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"  prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<!-- 打印插件 -->
	<script type="text/javascript" src="<%=basePath %>js/LodopFuncs.js"></script>
	<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
	       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed> 
	</object> 
	<!-- 打印end -->
	
	<script type="text/javascript">
	</script>
</head>
<body>
<div id="scrollContent">
    <center><h2>${userName }&nbsp;&nbsp;${time }月份工时详细信息</h1></center>
	<table class="tableStyle" style="text-align:center; margin-top:10px;">
	<tr>
		<td width="3%">序号</td>
		<td width="7%">班组</td>
		<td width="7%">工号</td>
		<td width="7%">姓名</td>
		<td width="10%">日期</td>
		<td>工作内容</td>
		<td width="7%">工时得分</td>
		<td width="10%">备注</td>
	</tr>
	<c:forEach var="userItem" items="${userItems}" varStatus="s">
		<tr>
			<td align="center">${s.index+1 } </td>
			<c:if test="${s.count==1}">
				<td align="center" rowspan="${fn:length(userItems)}">${userItem.proteam.proteamname }</td>
			</c:if>
			<c:if test="${s.count==1}">
				<td align="center" rowspan="${fn:length(userItems)}">${userItem.user.gonghao }</td>
			</c:if>
			<c:if test="${s.count==1}">
				<td align="center" rowspan="${fn:length(userItems)}">${userItem.user.xm }</td>
			</c:if>
			<td align="center">${userItem.workTime }</td>
			<td align="center">${userItem.item.itemName }</td>
			<td align="center">${userItem.workScore}分</td>
			<td align="center">${userItem.workNote }</td>
		</tr>
	</c:forEach>
	<c:if test="${empty userItems}">
	    <tr><td align="center" colspan="8">没有相应的数据信息!</td></tr>
	</c:if>
	</table>
</div>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>