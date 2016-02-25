<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

request.setAttribute("recId",request.getParameter("recId"));
request.setAttribute("type",request.getParameter("type"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
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
<script type="text/javascript" src="js/timer2.src.js"></script> 
<script type="text/javascript">
	//更换登陆方式
	function loginType(n){
		if(n==0){//直接登陆
			$("#login_0").hide();
			$("#login_1").show();
			$("#tr_username").show();
			$("#tr_password").show();
			$("#card_num").hide();
			$("#card_num").val("");
		}else{//刷卡登陆
			$("#login_0").show();
			$("#login_1").hide();
			$("#tr_username").hide();
			$("#tr_password").hide();
			$("#card_num").show();
		}
		$("#loginType").val(n);
	}
	//提交表单
	function submitForm(){
		var itemType = "${type}";
		var checkInfo = "";//检查情况
		//var loginType = $("#loginType").val();
		//var username = $("#username").val();
		//var password = $("#password").val();
		//var cardnum = $("#cardnum").val();
		if(itemType==0){
			checkInfo = $("#checkInfoSelect").attr("editValue");
			if(checkInfo==undefined){
				checkInfo = $("#checkInfoSelect").val();
				if(checkInfo=="" || checkInfo==null || checkInfo==undefined){
					top.Dialog.alert("检查情况不能为空!");
					return ;
				}
			}
		}else{
			checkInfo = $("#checkInfoInput").val();
			if(isNaN(checkInfo)){
				top.Dialog.alert("错误的检测值!");
				return ;
			}
		} 
		//if(loginType==0){//直接登陆
			//if(username==""){
				//top.Dialog.alert("用户名不能为空!");
				//return ;
			//}
			//if(password==""){
				//top.Dialog.alert("密码不能为空!");
				//return ;
			//}		
		//}else{//刷卡
			//if(cardnum==""){
				//top.Dialog.alert("请刷卡!");
				//return ;
			//}
		//}
		
		$.post("<%=basePath%>workAction!workerRatify.do",
				{"ids":"${ids}","checkInfo":checkInfo,"type":"${type}","xtype":"${xtype}","qtype":"${qtype}","rjhmId":"${rjhmId}"},
				function(text){
					if(text=="login_failure"){
						top.Dialog.alert("不存在该用户!");
					}else if(text=="noprivilege_failure"){
						top.Dialog.alert("没有可签项目或不是该用户的分工项目!");
					}else if(text=="value_failure"){
						top.Dialog.alert("错误的检测值!");
					}else{
						top.Dialog.alert("签名成功!",function(){
						    if("${role}"=='worker'){//工人
							    if("${type}"==0){//检查
									top.frmright.frames[0].location.reload();
									top.Dialog.close();
								}else{//检测
									top.frmright.frames[1].location.reload();
									top.Dialog.close(); 
								}
						    }else{//工长
						        top.frmright.frames[0].location.reload();
							    top.Dialog.close();
						    }
						});
					}
				}
		);
	}
</script>
<script type='text/javascript'>
var CallShowMsg = function(){
	var xx = document.getElementById("x");
	xx.Test('这是读卡数据：');
	document.getElementById("cardnum").value=xx.Msg;
	if (document.getElementById("cardnum").value!=""){
		//alert(document.all.idkid.value); 
		//alert(document.all.idkid.value); 
		//submitForm();
	}
}
//CallShowMsg()
var timer = new Timer(50); 
var globalTimer = new Timer(1000); 

function init() { 
	timer.addEventListener(TimerEvent.TIMER, calTime); 
	timer.start(); 
	globalTimer.addEventListener(TimerEvent.TIMER, controlTime); 
	globalTimer.start(); 
} 

function controlTime() { 
	if (!timer.running) { 
		timer.reset(); 
		timer.start(); 
	} 
} 

function calTime() { 
	CallShowMsg();
	var v=document.getElementById("cardnum").value;
	if (v != null) { 
		timer.stop(); 
		document.getElementById("cardnum").value=x.Msg; 
		CallShowMsg();
	} 
} 
//window.onload = init;
</script>
</head>
<body>
<form action="" method="post" id="form">
<input type="hidden" id="loginType" name="loginType" value="0"/>
<table class="tableStyle" transMode="true">
	<tr><td>检修情况：</td>
		<td>
			<c:choose>
				<c:when test="${type==0}">
					<select editable="true" id="checkInfoSelect" style="width: 150px;" autoWidth="true">
					    <option value="良好">良好</option>
					    <option value="更换良好">更换良好</option>
					    <option value="检修良好">检修良好</option>
					    <option value="清洗良好">清洗良好</option>
					    <option value="处理后探伤良好">处理后探伤良好</option>
					    <option value="没有启用">没有启用</option>
				 	</select>
				</c:when>
				<c:otherwise>
					 <input type="text" style="width: 150px;" id="checkInfoInput"/>
				</c:otherwise>
			</c:choose>
			<span>${itemUnit}</span>
			<!-- 
			<a href="javascript:loginType(1);" id="login_1" style="margin-left: 10px;">刷卡登陆</a>
			<a href="javascript:loginType(0);" id="login_0" style="margin-left: 10px;display: none;">直接登陆</a>
			 -->
		</td>
	</tr>
	<!-- 
	<tr id="tr_username"><td>用户名：</td><td><input type="text" style="width: 150px;" id="username" name="username"/></td></tr>
	<tr id="tr_password"><td>密码：</td><td><input type="password" style="width: 150px;" id="password" name="password"/></td></tr>
	<tr id="card_num" style="display: none;"><td>刷卡：</td><td><input type="text" style="width: 150px;" id="cardnum" name="cardnum"/></td></tr>
	 -->
	<tr>
		<td colspan="2">
			<input type="button" value=" 提 交 " onclick="submitForm();"/>
			<input type="reset" value=" 重 置 "/>
		</td>
	</tr>
	<!-- 
	<object width="32" height="32" title="MyActiveX" id="x" name="x" classid="clsid:A4D8D89A-CF2A-49BB-B703-25E48360D2A8" codebase="ActiveX.CAB#version=1,0,0,0"></object>
	 -->
</table>
</form>
</body>
</html>