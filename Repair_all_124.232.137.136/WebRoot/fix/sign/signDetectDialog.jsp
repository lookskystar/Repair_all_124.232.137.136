<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setAttribute("unit",request.getParameter("unit"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"/>
    <title>签认检测项目的弹出框</title>
  </head>
<body>
	<div style="padding: 20px 10px;">
		<table width="100%" align="center" >
			<tr>
				<td>测量值：</td>
				<td>
					<input type="text" id="detect_value" />
					<c:if test="${!empty unit}">${unit}</c:if>
				</td>
			</tr>
		</table>
    </div>
 </body>
</html>