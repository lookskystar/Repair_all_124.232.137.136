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
	   function validate(){
		   var startTime=$("#startTime").val();
		   var endTime=$("#endTime").val();
		   if($("#noticeContent").val()==""){
			   top.Dialog.alert("公告内容不能为空!");
			   return false;
		   }
		   if(startTime==""){
			   top.Dialog.alert("开始时间不能为空!");
			   return false;
		   }
		   if(endTime==""){
			   top.Dialog.alert("结束时间不能为空!");
			   return false;
		   }
		   if(!compareDate(startTime,endTime)){
			   top.Dialog.alert("结束时间不能小于开始时间!");
			   return false;
		   }
		   return true;
	   }

	   	//两日期进行比较
		function compareDate(startTime,endTime){
			var s_date=strToDate(startTime);
			var e_date=strToDate(endTime);
			return s_date<=e_date;
		}

		//将字符串转换为日期
		function strToDate(str){
			var array=str.split("-");
			var date=new Date(array[0],parseInt(array[1],10)-1,array[2]);
			return date;
		}
	</script>
	
</head>
<body>
  <form action="rewardAction!addNoticeInfo.do" method="post" target="frmright" onsubmit="return validate();">
	<table class="tableStyle" useHover="false" useClick="false">
		<tr>
		    <td align="center">公告标题:</td>
			<td align="center">
			   <input type="text" style="width:360px;" name="notice.noticeTitle"/>
			</td>
		</tr>
		<tr>
		    <td align="center">公告内容:</td>
			<td align="center">
			   <textarea name="notice.noticeContent" id="noticeContent" style="width:360px;height:100px;word-wrap: break-word;word-break: break-all;"></textarea>
			</td>
		</tr>
		<tr>
		    <td align="center">公告部门:</td>
			<td align="center">
				 <input type="text" style="width:360px;" name="notice.noticeDept"/>
			</td>
		</tr>
		<tr>
		    <td align="center">开始时间:</td>
			<td align="center">
			   	<input type="text" class="Wdate" onclick="WdatePicker(({minDate:'%y-%M-{%d}',dateFmt:'yyyy-MM-dd'}))" name="notice.startTime" id="startTime"/>
			</td>
		</tr>
		<tr>
		    <td align="center">结束时间:</td>
			<td align="center">
				<input type="text" class="Wdate" onclick="WdatePicker(({minDate:'%y-%M-{%d}',dateFmt:'yyyy-MM-dd'}))" name="notice.endTime" id="endTime"/>
			</td>
		</tr>
	</table>
	<div align="center"><input type="submit" value=" 提 交 " style="width:85px"/>&nbsp;&nbsp;<input type="reset" value=" 重 置" style="width:85px"/></div>
   </form>
	<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>