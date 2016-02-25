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
	<script type="text/javascript">
		function closeDialog(tar,evt){
			var href=tar;
			top.Dialog.open({URL:href,Width:900});
			var event=evt?evt:window.event;
			if(event.stopPropagation){
				event.stopPropagation();
			}else{
				event.cancelBubble = true;
			}
			return false;
		}

		//查询详细列表
		function listJc(item,jctype){
			top.Dialog.open({
				URL:"planManage!listJc.do?itemName="+item+"&jctype="+jctype,
				Width:700,
				Height:420,
				Title:"加改机车列表"
			});
		}
	</script>
	</head>
<body>
<div>
	<table class="tableStyle" headFixMode="true">
		<tr>
			<th width="30%">车型/项目</th>
			<c:forEach items="${jcAcounts}" var="jc">
				<th width="5%">${jc[0] }</th>
		    </c:forEach>
			<th width="5%">合计</th>
		</tr>
		<tr>
			<th width="30%">配属台数</th>
			<c:set value="0" var="jcCount"/>
			<c:forEach items="${jcAcounts}" var="jc">
			    <c:set value="${jcCount+jc[1]}" var="jcCount"/>
				<th width="5%">${jc[1] }</th>
		    </c:forEach>
			<th width="5%">${jcCount }</th>
		</tr>
	</table>
	<table class="tableStyle" useColor="false" useHover="false" useClick="true">
		<c:forEach items="${result}" var="map">
			<c:set var="count" value="0"/>
			<tr align="center">
				<td rowspan="2" width="25%">${map.key}</td>
				<td width="5%">计划</td>
				<c:forEach items="${map.value}" var="plan">
					<c:set var="count" value="${count+plan.planNum}"/>
					<td	width="5%">${plan.planNum}</td>
				</c:forEach>
				<td width="5%">${count}</td>
			</tr>
			<tr align="center">
				<td	width="5%">实际</td>
				<c:set var="count" value="0"/>
				<c:forEach items="${map.value}" var="plan">
					<c:set var="count" value="${count+plan.sjNum}"/>
					<c:choose>
						<c:when test="${plan.sjNum<plan.planNum}">
							<td	width="5%"><a href="javascript:listJc('${map.key }','${plan.jctype}');" style="color: #f00;font-weight: bold;">${plan.sjNum}</a></td>
						</c:when>
						<c:otherwise>
							<td	width="5%"><a href="javascript:listJc('${map.key }','${plan.jctype}');" style="color: #00f;font-weight: bold;">${plan.sjNum}</a></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<td width="5%"><a href="javascript:listJc('${map.key }','');" style="color: #00f;font-weight: bold;">${count}</a></td>
			</tr>
		</c:forEach>
	</table>
	<div style="height: 40px;"></div>
</body>
</html>
