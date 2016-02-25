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
			<div class="menuheader expandable"><span class="normal_icon1"></span>工时统计</div>
				<ul class="categoryitems">
					<li><a href="timecount!getTotalDuration.do" target="frmright"><span class="text_slice">小辅修工时统计</span></a></li>
					<li><a href="timecount!getZxDuration.do" target="frmright"><span class="text_slice">中修工时统计</span></a></li>
					<li><a href="timecount!repCount.do" target="frmright"><span class="text_slice">报活计件</span></a></li>
				</ul>
			
			<div class="menuheader expandable"><span class="normal_icon2"></span>班组管理</div>
				<ul class="categoryitems">
					<li><a href="document!documentOfType.do" target="frmright"><span class="text_slice">文件管理</span></a></li>
					<li><a href="document!documentOfType.do" target="frmright"><span class="text_slice">学习培训</span></a></li>
				</ul>
			
			<div class="menuheader expandable"><span class="normal_icon3"></span>规章制度</div>
				<ul class="categoryitems">
					<li><a href="document!documentOfType.do" target="frmright"><span class="text_slice">规章制度</span></a></li>
				</ul>
			
			<div class="menuheader expandable"><span class="normal_icon4"></span>考试系统</div>
				<ul class="categoryitems">
					<li><a href="plant/examination.jsp" target="frmright"><span class="text_slice">考试系统</span></a></li>
					<li><a href="examin!listExaminQuestionType.do" target="frmright"><span class="text_slice">考试题库管理</span></a></li>
					<li><a href="examin!listExaminRecType.do" target="frmright"><span class="text_slice">考试记录查询</span></a></li>
				</ul>
			
			<div class="menuheader expandable"><span class="normal_icon5"></span>问题库管理</div>
				<ul class="categoryitems">
					<li><a href="question!questionOfType.do" target="frmright"><span class="text_slice">段问题库</span></a></li>
					<li><a href="question!questionOfType.do" target="frmright"><span class="text_slice">车间问题库</span></a></li>
					<li><a href="question!questionOfType.do" target="frmright"><span class="text_slice">班组问题库</span></a></li>
				</ul>
				
			<div class="menuheader expandable"><span class="normal_icon6"></span>设置</div>
				<ul class="categoryitems">
					<li><a href="document!listDocumentType.do?modelType=1" target="frmright"><span class="text_slice">文档库设置</span></a></li>
					<li><a href="question!listQuestionType.do" target="frmright"><span class="text_slice">问题库设置</span></a></li>
				</ul>
		</div>
	</div>
</body>
</html>