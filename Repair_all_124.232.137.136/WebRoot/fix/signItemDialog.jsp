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
<title>新增一个配件检修日计划</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
 <script type="text/javascript">
  
 
 //使用刷卡签认
 function userCard(){
	 $("#untr").css("display","none");
	 $("#pwdtr").css("display","none");
	 $("#cardtr").css("display","block");
	 $("#use_way").val(1);
 }
	
  </script>
</head>
<body>
<div style="padding: 20px 20px;">
		<table width="100%" align="center" >
			<tr>
				<td>检查情况：</td>
				<td>
					<select id="pj_status">
						<option >良好</option>
						<option >更换良好</option>
						<option >检修良好</option>
						<option >清洗良好</option>
						<option >没有启用</option>
					</select>
					&nbsp;&nbsp;<a href="javascript:void(0)" onclick="userCard()">点击刷卡</a>
					<input type="hidden" id="use_way" value="0" /><!-- 默认使用用户名和密码 -->
				</td>
			</tr>
			<tr id="untr">
				<td>用户名：</td>
				<td>
					<input type="text" id="username"/>
				</td>
			</tr>
			<tr id="pwdtr">
				<td>密码：</td>
				<td>
					<input type="password" id="password"/>
				</td>
			</tr>

			<tr id="cardtr" style="display: none;">
				<td>刷卡：</td>
				<td>
					<input type="text" id="idkid"/>
				</td>
			</tr>
			
		</table>
    </div>
 </body>
</html>