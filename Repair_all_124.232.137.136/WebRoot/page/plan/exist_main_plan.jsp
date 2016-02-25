<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="<%=basePath%>"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script src="js/form/stepForm.js" type="text/javascript"></script>
	
    <script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<script type="text/javascript" src="js/attention/floatPanel.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!-- 解决IE6、7不兼容JSON.stringify问题 -->
	<script type="text/javascript" src="js/json2.js"></script>
	<!--框架必需end-->
	<script type="text/javascript">
	   //查看计划详情信息
	   function findMainPlanDetail(mainPlanId){
		   var diag = new top.Dialog();
		   diag.Title = "计划详情信息";
		   diag.URL = "<%=basePath%>planManage!findPlanDetail.do?mainPlanId="+mainPlanId;
		   diag.Width=1300;
		   diag.Height=600;
		   diag.show();
	   }

	   //查看计划兑现信息
	   function findCashDetail(mainPlanId){
		   var diag = new top.Dialog();
		   diag.Title = "计划兑现信息";
		   diag.URL = "<%=basePath%>planManage!findCashDetail.do?mainPlanId="+mainPlanId;
		   diag.Width=1300;
		   diag.Height=600;
		   diag.show();
	   }

	   function closeDialog(){
		   top.Dialog.close();
	   }
	</script>
</head>
<body>
	<table class="tableStyle"  useMultColor="true">
		  <tr>
		        <th width="5%">序号</th>
				<th width="10%">计划开始日期</th>
				<th width="10%">计划结束日期</th>
				<th width="15%">计划标题</th>
				<th width="10%">编制人</th>
				<th width="10%">编制时间</th>
				<th width="10%">状态</th>
				<th width="10%">操作</th>
		   </tr>
	      <c:forEach var="mainPlan" items="${mainPlans}" varStatus="s">
	         <tr>
	            <td width="5%" align="center">${s.index+1}</td>
          		<td width="10%" align="center">${mainPlan.startTime }</td>
				<td width="10%" align="center">${mainPlan.endTime }</td>
				<td width="15%" align="center">${mainPlan.title }</td>
				<td width="10%" align="center">${mainPlan.makePeople }</td>
				<td width="10%" align="center">${mainPlan.makeTime }</td>
				<td width="10%" align="center">
				  <c:if test="${mainPlan.status==0}"><font color="red">未发布</font></c:if>
				  <c:if test="${mainPlan.status==1}">已发布</c:if>
				</td>
				<td width="10%" align="center">
				       <a href="javascript:void(0);" onclick="findMainPlanDetail(${mainPlan.id});" style="color:blue;">计划详情</a>&nbsp;&nbsp;&nbsp;
				       <a href="javascript:void(0);" onclick="findCashDetail(${mainPlan.id});" style="color:blue;">兑现详情</a>
				</td>
	         </tr>
	      </c:forEach>
	      <tr><td colspan="8" align="center"><button onclick="closeDialog();"><span class="icon_ok">确       认</span></button></td></tr>
		</table>
		<div style="height:40px;"></div>
<link href="<%=basePath %>js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=basePath %>js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>