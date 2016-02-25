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
<body>
   <form action="rewardAction!updateRewardInfo.do" method="post" target="frmright">
    <input type="hidden" value="${kqReward.id }" name="rewardId"/>
	<table class="tableStyle" useHover="false" useClick="false">
		<tr>
			<td align="center">班组:</td>
			<td align="left">
			   <select colNum="4" colWidth="80" class="validate[required]" name="reward.proteam.proteamid">
			      <c:forEach var="proteam" items="${proteams}">
			         <option value="${proteam.proteamid }" <c:if test="${kqReward.proteam.proteamid==proteam.proteamid }">selected="selected"</c:if>>${proteam.proteamname }</option>
			      </c:forEach>
			   </select>
			</td>
		</tr>
		<tr>
		    <td align="center">被奖核人:</td>
			<td align="left">
			   <input type="text" style="width:180px" name="reward.rewardPerson" value="${kqReward.rewardPerson }"/>
			</td>
		</tr>
		<tr>
		    <td align="center">奖核日期:</td>
			<td align="left">
			  <input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" name="reward.rewardTime" value="${kqReward.rewardTime }"/>
			</td>
		</tr>
		<tr>
		    <td align="center">奖核原因:</td>
			<td align="left">
			   <textarea class="validate[required]" name="reward.rewardContent" style="width:360px;height:100px;word-wrap: break-word;word-break: break-all;">${kqReward.rewardContent }</textarea>
			</td>
		</tr>
		<tr>
		    <td align="center">考核:</td>
			<td align="left">
			   <input type="text" style="width:180px" onkeyup="this.value=this.value.replace(/\D/g,'')" name="reward.rewardAdd" value="${kqReward.rewardAdd }"/>
			</td>
		</tr>
		<tr>
		    <td align="center">奖励:</td>
			<td align="left">
			   -<input type="text" style="width:178px" onkeyup="this.value=this.value.replace(/\D/g,'')" name="reward.rewardSub" value="${kqReward.rewardSub }"/>
			</td>
		</tr>
		<tr>
		    <td align="center">奖核类别:</td>
			<td align="left">
			   <select name="reward.rewardStandard">
			   		<option value="">请选择</option>
			   		<option value="奖励" <c:if test="${kqReward.rewardStandard=='奖励'}">selected="selected"</c:if>>奖励</option>
			   		<option value="考核" <c:if test="${kqReward.rewardStandard=='考核'}">selected="selected"</c:if>>考核</option>
			   </select>
			</td>
		</tr>
		<tr>
		    <td align="center">备注:</td>
			<td align="left">
			   <textarea name="reward.rewardNote">${kqReward.rewardNote }</textarea>
			</td>
		</tr>
	</table>
	<div align="center"><input type="submit" value=" 提 交 " style="width:85px"/>&nbsp;&nbsp;<input type="reset" value=" 重 置 " style="width:85px"/></div>
   </form>
   <script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>