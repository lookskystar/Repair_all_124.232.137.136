<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>签认检查项目的弹出框</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->
</head>
<body>
<div style="padding: 20px 10px;">
		<table width="100%" align="center" >
			<tr>
				<td>检查情况：</td>
				<td>
					<select editable="true" id="pj_status" style="width: 150px;" autoWidth="true">
						<option value="良好">良好</option>
						<option value="更换良好">更换良好</option>
						<option value="检修良好">检修良好</option>
						<option value="清洗良好">清洗良好</option>
						<option value="探伤后处理良好">探伤后处理良好</option>
					</select>
					<input type="hidden" id="use_way" value="0" /><!-- 默认使用用户名和密码 -->
				</td>
			</tr>
			
		</table>
    </div>
 </body>
</html>