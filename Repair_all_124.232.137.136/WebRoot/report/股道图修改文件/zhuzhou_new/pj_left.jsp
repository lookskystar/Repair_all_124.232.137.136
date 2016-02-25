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

<div class="menuheader expandable"><span class="normal_icon3"></span>配件检修</div>
<ul class="categoryitems">
<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',GR,'))}">
	<li><a href="partFixAction!listPJDynamicInfo.do" target="frmright"><span class="text_slice">选择配件</span></a></li>
	<li><a href="partFixAction!unfinishedPartCount.do" target="frmright"><span class="text_slice">工人签认</span></a></li>
	<li><a href="partFixAction!toAssignPredict.do" target="frmright"><span class="text_slice">报活派工</span></a></li>
</c:if>
<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',GZ,'))}">
	<li><a href="partFixAction!listPJDynamicInfo.do" target="frmright"><span class="text_slice">选择配件</span></a></li>
	<li><a href="partFixAction!unfinishedPartCount.do" target="frmright"><span class="text_slice">工长签认</span></a></li>
	<li><a href="partFixAction!toAssignPredict.do" target="frmright"><span class="text_slice">报活派工</span></a></li>
</c:if>
<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',ZJY,')||fn:containsIgnoreCase(sessionScope.session_user.roles,',DSZJ,'))}">
	<li><a href="partFixAction!unfinishedPartCount.do" target="frmright"><span class="text_slice">质检员签认</span></a></li>
</c:if>
<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',JSY,')||fn:containsIgnoreCase(sessionScope.session_user.roles,',DSJS,'))}">
	<li><a href="partFixAction!unfinishedPartCount.do" target="frmright"><span class="text_slice">技术员签认</span></a></li>
</c:if>
<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',JCGZ,'))}">
	<li><a href="partFixAction!unfinishedPartCount.do" target="frmright"><span class="text_slice">交车工长签认</span></a></li>
</c:if>
<c:if test="${(fn:containsIgnoreCase(sessionScope.session_user.roles,',YSY,'))}">
	<li><a href="partFixAction!unfinishedPartCount.do" target="frmright"><span class="text_slice">验收员签认</span></a></li>
</c:if>
<li><a href="partFixAction!toSignPredict.do" target="frmright"><span class="text_slice">报活签认</span></a></li>
<li><a href="partFixAction!approvePredictList.do" target="frmright"><span class="text_slice">待审批的报活</span></a></li>
</ul>



<div class="menuheader expandable"><span class="normal_icon5"></span>配件管理</div>
<ul class="categoryitems">
<li><a href="pjManage!staticPJListInput.do" target="frmright"><span class="text_slice">配件大类</span></a></li>
<li><a href="pjManage!dyPJListInput.do" target="frmright"><span class="text_slice">配件检修</span></a></li>
</ul>

<c:if test="${!(fn:containsIgnoreCase(sessionScope.session_user.roles,',GR,')) && !(fn:containsIgnoreCase(sessionScope.session_user.roles,',GZ,'))}">
<div class="menuheader expandable"><span class="normal_icon2"></span>配件记录</div>
<ul class="categoryitems">
<li><a href="pjManage!inputPartRecord.do?jcStype=SS3" target="frmright"><span class="text_slice">配件记录</span></a></li>
</ul>
</c:if>
<!--  
<li><a href="pjManage!handoverRecord.do" target="frmright"><span class="text_slice">配件交接记录</span></a></li>
-->
<!-- 
<li><a href="templete/example6-3.html" target="frmright"><span class="text_slice">综合布局</span></a></li>
-->
</ul>

<!-- 
<div class="menuheader expandable"><span class="normal_icon6"></span>图表模板</div>
<ul class="categoryitems">
<li><a href="../templete/example7-1.html" target="frmright"><span class="text_slice">简单图表</span></a></li>
<li><a href="../templete/example7-2.html" target="frmright"><span class="text_slice">复杂图表</span></a></li>
<li><a href="../templete/example7-3.html" target="frmright"><span class="text_slice">另类图表</span></a></li>
</ul>

<div class="menuheader expandable"><span class="normal_icon7"></span>其他</div>
<ul class="categoryitems">
<li><a href="../templete/example8-1.html" target="frmright"><span class="text_slice">日程安排</span></a></li>
</ul>

<div class="menuheader expandable"><span class="normal_icon8"></span>四级导航示例</div>
<ul class="categoryitems">
<li><a><span>第二级1</span></a>
	<ul>
		<li><a><span>第三极1</span></a>
			<ul>
				<li><a href="javascript:;"><span>第四级1</span></a></li>
				<li><a href="javascript:;"><span>第四级2</span></a></li>
			</ul>
		</li>
		<li><a href="javascript:;"><span>第三极2</span></a></li>
		<li><a href="javascript:;"><span>第三极3</span></a></li>
	</ul>
</li>
<li><a href="javascript:;"><span>第二级2</span></a>
	<ul>
		<li><a href="javascript:;"><span>第三极4</span></a></li>
		<li><a href="javascript:;"><span>第三极5</span></a></li>
		<li><a href="javascript:;"><span>第三极6</span></a></li>
	</ul>
</li>
<li><a href="javascript:;"><span>第二级3</span></a></li>
</ul>

<div class="menuheader expandable"><span class="normal_icon9"></span>基本模板</div>
<ul class="categoryitems">
<li><a href="../templete/templete_right.html" target="frmright"><span class="text_slice">基本右侧内页模板</span></a></li>
<li><a href="../templete/templete_right2.html" target="frmright"><span class="text_slice">上下固定的右侧内页模板</span></a></li>
<li><a href="../templete/example1-1.html" target="frmright"><span class="text_slice">弹出窗口内页模板</span></a></li>
</ul>
 -->	
</div>
	
</body>
</html>