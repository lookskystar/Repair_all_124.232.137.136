<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%@include file="/checkLogin.jsp" %>
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

<div class="menuheader expandable"><span class="normal_icon1"></span>台账管理</div>
<ul class="categoryitems">
<li><a href="jcManageAction!jcManageInput.do" target="frmright"><span class="text_slice">机车配属台账</span></a></li>
<li><a href="jcManageAction!jcManageInput.do" target="frmright"><span class="text_slice">走行公里台账</span></a></li>
</ul>

<div class="menuheader expandable"><span class="normal_icon2"></span>加装技改管理</div>
<ul class="categoryitems">
<li><a href="teach!techManage.do" target="frmright"><span class="text_slice">加装技改管理</span></a></li>
</ul>

<div class="menuheader expandable"><span class="normal_icon3"></span>零公里检查管理</div>
<ul class="categoryitems">
<li><a href="teach!zoreAnalyse.do" target="frmright"><span class="text_slice">零公里检查</span></a></li>
</ul>

<div class="menuheader expandable"><span class="normal_icon4"></span>机车质量分析</div>
<ul class="categoryitems">
<li><a href="teach!trainFaultManage.do" target="frmright"><span class="text_slice">机破分析</span></a></li>
<li><a href="teach!techManage.do" target="frmright"><span class="text_slice">临修分析</span></a></li>
<li><a href="teach!superFix.do" target="frmright"><span class="text_slice">超修分析</span></a></li>
</ul>

<div class="menuheader expandable"><span class="normal_icon5"></span>检修指标管理</div>
<ul class="categoryitems">
<li><a href="teach!maintenIndexCountInput.do" target="frmright"><span class="text_slice">检修指标统计</span></a></li>
</ul>

<div class="menuheader expandable"><span class="normal_icon6"></span>走行部故障管理</div>
<ul class="categoryitems">
<li><a href="teach!runDepartDictManage.do" target="frmright"><span class="text_slice">走行部故障统计</span></a></li>
</ul>




</div>
</div>
</body>
</html>