<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jstl-c" %>
<%@ taglib prefix="fmt" uri="jstl-fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>工人/工长签认</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="js/nav/tab.js"></script>
	<script type="text/javascript">
		$(function(){
			var tab = new TabView({
				containerId:'tab_menu',
				pageid: 'page',
				cid: 'tab1',
				position: 'top'
			});
			tab.add({
				id: 'tab1_index1',
				title: '检查项目',
				url: "partFixAction!toInspectionItem.do?psize=20&pjdid=${pjdid}&pjRecId=${pjRecId}&time="+new Date(),
				isClosed: false
			});
			tab.add({
				id: 'tab1_index2',
				title: '检测项目',
				url: "partFixAction!toDetectItem.do?psize=20&pjdid=${pjdid}&pjRecId=${pjRecId}&time="+new Date(),
				isClosed: false
			});
			tab.activate("tab1_index1");
		})
	</script>
  </head>
  
  <body>
	<div id="tab_menu"></div>
	<div id="page" style="width:100%;height:450px;border:solid 1px #cccccc;"></div>
  </body>
</html>
