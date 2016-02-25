<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setAttribute("nodeId",request.getParameter("nodeId"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<script type="text/javascript" src="js/nav/tab.js"></script>
<script type="text/javascript">
$( function() {
	 var tab = new TabView( {
		containerId :'tab_menu',
		pageid :'page',
		cid :'tab',
		position :"top"
	});
	tab.add( {
		id :'jh_index0',
		title :"检修接活",
		url :"workAction!receivedWorkInput.do?temp="+new Date().getTime(),
		isClosed :false
	});
	tab.add( {
		id :'jh_index1',
		title :"报活接活",
		url :"reportWorkManage!reportWorkSign.action?role=worker&flag=2&temp="+new Date().getTime(),
		isClosed :false
	});
	tab.activate("jh_index0")
});
</script>
<body>
<div class="box2" panelTitle="机车检修接活">	
	<div id="tab_menu"></div>
	<div id="page" style="width:100%;height: 420px"></div>
</div>
</body>
</html>