<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setAttribute("rtype",request.getParameter("rtype"));
request.setAttribute("rjhmId",request.getParameter("rjhmId"));
request.setAttribute("jcstype",request.getParameter("jcstype"));
request.setAttribute("role",request.getParameter("role"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
var xtype = "${xtype}";
var role = "${sessionScope.session_user.roles}";
$( function() {
	var tab = new TabView( {
		containerId :'tab_menu',
		pageid :'page',
		cid :'tab',
		position :"top"
	});
	tab.add( {
		id :'tab_index0',
		title :"卡控签字",
		url :"signWorkAction!listSignItem.do?rtype=${rtype}&rjhmId=${rjhmId}&jcstype=${jcstype}&temp="+new Date().getTime(),
		isClosed :false
	});
	tab.add( {
		id :'tab_index1',
		title :"报活签字",
		url :"reportWorkManage!reportWorkSignItem.action?id=${rjhmId}&role=${role}&flag=1&temp="+new Date().getTime(),
		isClosed :false
	});
	tab.add( {
		id :'tab_index2',
		title :"我报的活",
		url :"reportWorkManage!reportWork.action?id=${rjhmId}&temp="+new Date().getTime(),
		isClosed :false
	});
	if(role != ",JCGZ,"){
		tab.add( {
			id :'tab_index3',
			title :"交车项目",
			url :"<%=basePath%>workAction!finishItemInput.do?rjhmId=${rjhmId}&xtype=${xtype}&type=1&temp"+new Date().getTime(),
			isClosed :false
		});
	}
	tab.activate("tab_index0")
});
</script>
</head>
<body>
	<div id="tab_menu"></div>
	<div id="page" style="width:100%;height:420px;"></div>
</body>
</html>