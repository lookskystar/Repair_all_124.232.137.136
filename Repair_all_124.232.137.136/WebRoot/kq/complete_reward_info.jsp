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
	<!-- 表单验证脚本 -->
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
</head>
<body><br/>
   <form action="rewardAction!completeRewardInfo.do" method="post" target="frmright">
    <input type="hidden" value="${kqReward.id }" name="rewardId"/>
	<table class="tableStyle" useHover="false" useClick="false">
		<tr>
			<td align="center">班组:</td>
			<td align="center">${kqReward.proteam.proteamname }</td>
		</tr>
		<tr>
		    <td align="center">被奖核人:</td>
			<td align="left">
			    <select colNum="4" colWidth="80" class="validate[required]" name="reward_person">
			      <c:forEach var="user" items="${users}">
			         <option value="${user.xm}" <c:if test="${kqReward.rewardPerson==user.xm}">selected="selected"</c:if>>${user.xm}</option>
			      </c:forEach>
			   </select>
			</td>
		</tr>
		<tr>
		    <td align="center">奖核日期:</td>
			<td align="center">${kqReward.rewardTime }</td>
		</tr>
		<tr>
		    <td align="center">考核内容:</td>
			<td align="center">${kqReward.rewardContent }</td>
		</tr>
		<tr>
		    <td align="center">加奖:</td>
			<td align="center">${kqReward.rewardAdd }</td>
		</tr>
		<tr>
		    <td align="center">扣奖:</td>
			<td align="center">${kqReward.rewardSub }</td>
		</tr>
		<tr>
		    <td align="center">标化考核:</td>
			<td align="center">${kqReward.rewardStandard }</td>
		</tr>
		<tr>
		    <td align="center">提报人:</td>
			<td align="center">${kqReward.reportPerson }</td>
		</tr>
		<tr>
		    <td align="center">提报日期:</td>
			<td align="center">${kqReward.reportTime }</td>
		</tr>
		<tr>
		    <td align="center">备注:</td>
			<td align="center">${kqReward.rewardNote }</td>
		</tr>
	</table>
	<div align="center"><input type="submit" value=" 完善确认 " style="width:100px"/></div>
   </form>
   <script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>