<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左侧菜单</title>
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
</head>
<body onl>
<div id="scrollContent" class="border_gray" style="margin-top: 10px;">
	<table class="tableStyle" style="text-align: center;">
		<tr>
			<th width="7%">车型</th>
			<th width="7%">车号</th>
			<th width="7%">修程修次</th>
			<th width="13%">扣车时间</th>
			<th width="13%">起机时间</th>
			<th width="13%">交车时间</th>
			<th width="8%">交车工长</th>
			<th width="8%">操作</th>
		</tr>
		<c:if test="${empty dpjcList}"><tr><td colspan="8">没有数据记录!</td></tr></c:if>
		<c:if test="${!empty dpjcList}">
			<c:forEach var="jc" items="${dpjcList}">
				<tr>
					<td>${jc.jcType}</td>
					<td>${jc.jcnum}</td>
					<td>${jc.fixFreque}</td>
					<td>${jc.kcsj}</td>
					<td>${jc.jhqjsj}</td>
					<td>${jc.jhjcsj}</td>
					<td>${jc.gongZhang.xm}</td>
					<td>
						<c:choose>
							<c:when test="${!empty jc.nodeid}">
								<a href="workAction!findFlowItem.do?jctype=${jc.jcType}&dpid=${jc.rjhmId}&jcnum=${jc.jcnum}&jcfix=${jc.fixFreque}&nodeId=${nodeId}"><span class="icon_view">检修分工</span></a>
							</c:when>
							<c:otherwise>&nbsp;</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>

<div style="height:35px;">
	<div class="float_left padding5">
			共有信息${fn:length(dpjcList)}条。
	</div>
	<div class="clear"></div>
</div>
						
</body>