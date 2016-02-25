<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"  prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<script type="text/javascript">
		$(function(){
			dateInit();
		});

		function dateInit(){
			var myDate=new Date();
			var date=myDate.getYear()+"-"+(myDate.getMonth()+1)+"-"+myDate.getDate();
			$("#rewardTime").val(date);
		}

		function validate(){
			if($("#proteam").val()==""){
				top.Dialog.alert("请选择相应的班组!");
				return false;
			}
			if($("#rewardContent").val()==""){
				top.Dialog.alert("奖核原因不能为空!");
				return false;
			}
			if($("#rewardAdd").val()==""&&$("#rewardSub").val()==""){
				top.Dialog.alert("奖励或考核信息不能为空!");
				return false;
			}
			return true;
		}

		function getUser(){
			var proteamId=$("#proteam").val();
			var str="<option value=''>请选择被奖核人</option>";
			$.post("rewardAction!ajaxGetUser.do",{"proteamId":proteamId},function(data){
				var results=eval("("+data+")");
				if(results.length>0){
					for(var i=0;i<results.length;i++){
						str+="<option value='"+results[i].userName+"'>"+results[i].userName+"</option>";
					}
				}
				$("#rewardUser").children().remove();
				$("#rewardUser").append(str);
			});
		}
	</script>
	
</head>
<body>
   <form action="rewardAction!addRewardInfo.do" method="post" target="frmright" onsubmit="return validate();">
	<table class="tableStyle" useHover="false" useClick="false">
		<tr>
			<td align="center">班组:</td>
			<td align="left">
			   <select colNum="4" colWidth="80" name="reward.proteam.proteamid" onchange="getUser();" id="proteam">
			      <option value="">请选择班组</option>
			      <c:forEach var="proteam" items="${proteams}">
			         <option value="${proteam.proteamid }">${proteam.proteamname }</option>
			      </c:forEach>
			   </select>
			</td>
		</tr>
		<tr>
		    <td align="center">被奖核人:</td>
			<td align="left">
			   <select id="rewardUser" class="default" name="reward.rewardPerson"><option>请选择被奖核人</option></select>
			</td>
		</tr>
		<tr>
		    <td align="center">奖核日期:</td>
			<td align="left">
			  <input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" name="reward.rewardTime" id="rewardTime"/>
			</td>
		</tr>
		<tr>
		    <td align="center">奖核原因:</td>
			<td align="left">
			   <textarea name="reward.rewardContent" id="rewardContent" style="width:360px;height:100px;word-wrap: break-word;word-break: break-all;"></textarea>
			</td>
		</tr>
		<tr>
		    <td align="center">奖励:</td>
			<td align="left">
			   <input type="text" style="width:180px" onkeyup="this.value=this.value.replace(/\D/g,'')" name="reward.rewardAdd" id="rewardAdd"/>
			</td>
		</tr>
		<tr>
		    <td align="center">考核:</td>
			<td align="left">
			   -<input type="text" style="width:178px" onkeyup="this.value=this.value.replace(/\D/g,'')" name="reward.rewardSub" id="rewardSub"/>
			   <font color="red">*输入数字，系统为相应的负值</font>
			</td>
		</tr>
		<tr>
		    <td align="center">奖核类别:</td>
			<td align="left">
			   <select name="reward.rewardStandard">
			   		<option value="">请选择</option>
			   		<option value="奖励">奖励</option>
			   		<option value="考核">考核</option>
			   </select>
			</td>
		</tr>
		<tr>
		    <td align="center">备注:</td>
			<td align="left">
			   <textarea name="reward.rewardNote"></textarea>
			</td>
		</tr>
	</table>
	<div align="center"><input type="submit" value=" 提 交 " style="width:85px"/>&nbsp;&nbsp;<input type="reset" value=" 重 置 " style="width:85px"/></div>
   </form>
   <script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>