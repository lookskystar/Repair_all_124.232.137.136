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

<div class="menuheader expandable"><span class="normal_icon1"></span>探伤报活</div>
<ul class="categoryitems">
<li><a href="tsAction!inputDepot.do" target="frmright"><span class="text_slice">探伤报活</span></a></li>
</ul>



<div class="menuheader expandable"><span class="normal_icon2"></span>探伤管理</div>
<ul class="categoryitems">
<li><a href="tsAction!inputDepotList.do" target="frmright"><span class="text_slice">探伤派工</span></a></li>
<li><a href="tsAction!inputRecord.do" target="frmright"><span class="text_slice">记录填写</span></a></li>
<li><a href="tsAction!inputRecordList.do" target="frmright"><span class="text_slice">记录查询</span></a></li>
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