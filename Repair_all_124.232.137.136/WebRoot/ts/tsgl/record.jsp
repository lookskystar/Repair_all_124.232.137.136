<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<!-- 引入分页JS -->
<script type="text/javascript" src="admin/js/page.js"></script>

<script type="text/javascript">
	$(function(){
		top.Dialog.close();
		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
	    </c:if>
	});
	
	function paigong(id){		
		top.Dialog.open({URL:"<%=basePath%>tsAction!inputRecordFill.do?id="+id,Width:480,Height:360,Title:"探伤记录填写"});
	}
</script>
</head>
<body>	
<div class="box1" panelTitle="探伤记录填写" overflow="auto">
	<table class="tableStyle" overflow="auto">
		<tr align="center">
			<td>机车类型</td>
			<td>机车号</td>
			<td>修程</td>
			<td>修次</td>
			<td>部件</td>
			<td>数量</td>
			<td>部件编号</td>
			<td>报活时间</td>
			<td>报活人</td>
			<td>操作</td>
		</tr>
		<c:forEach var="depot" items="${depots}">
		<tr align="center">
			<td>${depot.jcType }</td>
			<td>${depot.jcNum }</td>
			<td>${depot.xc}</td>
			<td>${depot.jcFixNum }</td>
			<td>${depot.unitName }</td>
			<td>${depot.unitCount }</td>
			<td>${depot.unitNum }</td>
			<td>${depot.atTime }</td>
			<td>${depot.atWorker }</td>
			<td>
				<a style="color:blue;" onclick="paigong(${depot.id });">填写探伤记录</a>&nbsp;&nbsp;
			</td>
		</tr>
		</c:forEach>	
	</table>
</div>
</body>
</html>
