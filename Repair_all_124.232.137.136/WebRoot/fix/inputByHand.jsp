<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setAttribute("py",request.getParameter("py"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"/>
    <title>手动输入动态配件的编码</title>
  </head>
<body>
<div style="padding: 10px 10px;">
		<table width="100%" align="center" >
			<tr>
				<td>配件编码：</td>
				<td>
					<input type="text" id="pjNum" value="${py}"/>
				</td>
			</tr>
		</table>
    </div>
 </body>
</html>