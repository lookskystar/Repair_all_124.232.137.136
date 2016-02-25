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
	<!--框架必需end-->
	<script type="text/javascript">
	</script>
</head>
<body>
<div class="box1">
    <center><h1>各角色帮助文档下载</h1></center>
	<table class="tableStyle"  useMultColor="true" id="datatabel">
		<tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/gr_operate.doc">工人操作模块.doc</a></td>
	    </tr>
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/gz_operate.doc">工长操作模块.doc</a></td>
	    </tr>
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/zjy_operate.doc">质检/技术员操作模块.doc</a></td>
	    </tr>
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/jcgz_operate.doc">交车工长操作模块.doc</a></td>
	    </tr>
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/ysy_operate.doc">验收员操作模块.doc</a></td>
	    </tr>
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/djs_operate.doc">段技术操作模块.doc</a></td>
	    </tr>
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/dld_operate.doc">段领导操作模块.doc</a></td>
	    </tr>
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/gly_operate.doc">系统管理员操作模块.doc</a></td>
	    </tr>
	     <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/qz_operate.doc">秋整操作模块.doc</a></td>
	    </tr>
	<!-- 
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/system_fucntion.doc">机务检修管理系统功能图.doc</a></td>
	    </tr>
	    <tr>
	      <td align="center"><a style="font-size:13px;color:blue;" href="doc/role/new_function.doc">新增功能介绍.doc</a></td>
	    </tr>
	-->
	</table>
</div>
</body>
</html>