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
<!--框架必需end-->

<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<style>
a {
	behavior:url(js/method/focus.htc)
}
.categoryitems span{
	width:160px;
}
</style>
</head>
<body leftFrame="true">
<div id="scrollContent">
<div class="arrowlistmenu">
	<div class="menuheader expandable"><span class="normal_icon3"></span>维护设置</div>
	<ul class="categoryitems">
		<li><a href="maintainAction!getEquipInput.do" target="frmright"><span class="text_slice">设备管理</span></a></li>
		<li><a href="maintainAction!getRuleInput.do" target="frmright"><span class="text_slice">考勤规则</span></a></li>
		<li><a href="maintainAction!getHolidayInput.do" target="frmright"><span class="text_slice">节日维护</span></a></li>
		<li><a href="rewardAction!workSetInput.do" target="frmright"><span class="text_slice">考勤排班</span></a></li>
	</ul>
	<div class="menuheader expandable"><span class="normal_icon5"></span>查询统计</div>
	<ul class="categoryitems">
		<li><a href="signAction!queryKQDayInput.do" target="frmright"><span class="text_slice">考勤日报</span></a></li>
		<li><a href="signAction!queryKQMonthInput.do" target="frmright"><span class="text_slice">考勤月报</span></a></li>
		<li><a href="signAction!resignInput.do" target="frmright"><span class="text_slice">手工补签</span></a></li>
		<li><a href="signAction!noworkEditInput.do" target="frmright"><span class="text_slice">休假录入</span></a></li>
		<li><a href="anomalouAction!createMSArea2DCharts.action" target="frmright"><span class="text_slice">异常出勤</span></a></li>
	</ul>
	<div class="menuheader expandable"><span class="normal_icon2"></span>考核奖励</div>
	<ul class="categoryitems">
		<li><a href="rewardAction!rewardInfoInput.do" target="frmright"><span class="text_slice">信息录入</span></a></li>
		<li><a href="rewardAction!queryRewardInput.do" target="frmright"><span class="text_slice">汇总查询</span></a></li>
		<li><a href="rewardAction!noticeInfoInput.do" target="frmright"><span class="text_slice">信息公告</span></a></li>
	</ul>
	<div class="menuheader expandable"><span class="normal_icon1"></span>工时统计</div>
	<ul class="categoryitems">
		<li><a href="proteamEntryAction!proteamEntryInput.do" target="frmright"><span class="text_slice">班组录入</span></a></li>
		<li><a href="rewardAction!queryDayReport.do" target="frmright"><span class="text_slice">日报查询</span></a></li>
		<li><a href="rewardAction!queryMonthReport.do" target="frmright"><span class="text_slice">月报查询</span></a></li>
	</ul>
	<div class="menuheader expandable"><span class="normal_icon1"></span>工时派工</div>
	<ul class="categoryitems">
		<li><a href="proteamEntryAction!proteamEntryInput.do" target="frmright"><span class="text_slice">工长派工</span></a></li>
	</ul>
</div>
</div>
</body>
</html>