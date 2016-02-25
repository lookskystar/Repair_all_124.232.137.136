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
		<title>交车记录</title>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
		<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
		<!--框架必需end-->
		<!--截取文字start-->
		<script type="text/javascript" src="js/text/text-overflow.js"></script>
	</head>

	<body>
		<div id="scrollContent" style="margin-top: 10px;font-size: 14px;">
			<table align="center" width="700px;" border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td width="650px">
						<table align="center" border="1px" bordercolor="#aabbcc" cellspacing="0" cellpadding="0">
							<tr align="center">
								<td width="100px" align="center">序号</td>
								<td width="30%" align="center">项目</td>
								<td width="30%" align="center">情况</td>
								<td width="15%" align="center">交车工长</td>
								<td width="10%" align="center">质检</td>
								<td width="10%" align="center">验收</td>							
							</tr>
							<c:if test="${empty rec}">
								<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								</tr>
							</c:if>
							<c:forEach items="${rec}" var="rec" varStatus="idx">
								<tr align="center">
									<td>${idx.index+1 }</td>
									<td>${rec.jcxm }</td>
									<td>${rec.jcqk }</td>
									<td>${rec.jcgzxm }</td>
									<td>${rec.zjxm }</td>
									<td>${rec.ysxm }</td>
								</tr>
							</c:forEach>
						</table>
					</td>
					<td width="5px;"></td>
					<%--
					<td>
						<table align="center" border="1px" bordercolor="#aabbcc" width="350px;" cellspacing="0" cellpadding="0">
							<tr align="center">
								<td width="15%" align="center">班组</td>
								<td width="20%" align="center">工号</td>
								<td width="20%" align="center">人员</td>
								<td width="45%" align="center">签到时间</td></tr>
							<c:if test="${empty sign}">
								<tr><td colspan="4" align="center">暂无记录!</td></tr>
							</c:if>
							<c:forEach items="${sign}" var="sign">
								<tr align="center">
									<td>${sign.bzName}</td>
									<td>${sign.user.gonghao }</td>
									<td>${sign.user.xm }</td>
									<td>${sign.signTime }</td>
								</tr>
							</c:forEach>
						</table>
					</td>
					 --%>
				</tr>
			</table>
		</div>
	</body>
</html>
