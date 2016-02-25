<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>加装改造首页</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	

  </head>
  
  <body>
    <div id="scrollContent">
			<div class="arrowlistmenu">

				<div class="menuheader expandable"><span class="normal_icon2"></span>机车类型</div>
				<ul class="categoryitems">
					<li><a href="tsAction!inputDepotList.do" target="frmright"><span class="text_slice">干线内燃机车</span></a></li>
					<li><a href="tsAction!inputRecord.do" target="frmright"><span class="text_slice">内燃调小机车</span></a></li>
					<li><a href="tsAction!inputRecordList.do" target="frmright"><span class="text_slice">电力机车</span></a></li>
  					<li><a href="tsAction!inputRecordList.do" target="frmright"><span class="text_slice">和谐机车</span></a></li>
  				</ul>
  			</div>
  	</div>
  </body>
</html>
