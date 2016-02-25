<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>"/>
    <title>用户登陆</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
 <body>
	<table class="tableStyle" transMode="true">
		<tr>
			<td align="right">用户名:</td>
			<td><input id="username" name="username" type="text"></input></td>
		</tr>
		<tr>
			<td align="right">密&nbsp;&nbsp;码:</td>
			<td><input id="password" name="password" type="password"></input></td>
		</tr>
		<tr>
			<td align="right">
				<input type="hidden" id="rjhmId" value="${rjhmId }"/>
				<input type="button" value="提交" id="subtn"/>
			</td>
			<td><input type="button" value="取消" id="cancelbtn"/></td>
		</tr>
 	</table>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#subtn").bind("click",function(){
			var username = $("#username").val();
			var password = $("#password").val();
			var rjhmId = $("#rjhmId").val();
			var flag = false;
			$.post("<%=basePath%>loginAction!ajaxLogin.do",{"username":username,"password":password},
				function(result){
	   				if("success" == result){
	   					flag = true;
	   				}else{
	   					top.Dialog.alert("用户错误！");
	   					return;
	   				}	   			
	   			}
	   		);
	   		if(flag = true){
	   			$.post("<%=basePath%>checkSign!sign.do",{"dpid":rjhmId},
	   				function(result){
	   					if("success" == result){
	   						top.Dialog.alert("签认成功！",function(){
	   						    top.jcmain.jcgz_gdt.window.location.reload();
	   							top.Dialog.close();
	   						});
	   					}
	   				}
	   			)
	   		}
		})
	
	})
</script>
</html>