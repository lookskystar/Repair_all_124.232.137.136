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
<style type="text/css">
*html{
 background-image:url(about:blank);
 background-attachment:fixed;
 }

tr{text-align:center;}
a{color: blue;}
</style>
</head>
<body>
<c:forEach items="${experiments}" var="exp" varStatus="i">
<div style="width:100%; height: 30px; line-height:30px; border-bottom:2px solid #247BB6; text-align:center;">
	<span style="font-size:16px;font-weight: bold;">
		${datePlan.jcType}机车试验
	</span>
</div>
<div class="tab_hr"></div>
	<table class="tableStyle">
		<tr>
			<th width="10%">试验名</th>
			<th width="8%">机车</th>
			<th width="12%">检修员</th>
			<th width="12%">工长</th>
			<th width="12%">质检员</th>
			<th width="12%">技术员</th>
			<th width="12%">交车工长</th>
			<th width="12%">验收员</th>
		</tr>
		<tr>
			<td><span style="color: red;">${exp.itemName}</span></td>
			<td>${datePlan.jcnum}</td>
			<td><a onclick='top.Dialog.open({URL:"experiment!tosignExpItem.do?rjhmId=${datePlan.rjhmId}&roleFlag=1&expId=${exp.jceiId}&expType=${exp.itemName}",Width:"100",Height:"100",Title:"${expName}"});' href="javascript:void(0)">签认</a></td>
			<td><a onclick='top.Dialog.open({URL:"experiment!tosignExpItem.do?rjhmId=${datePlan.rjhmId}&roleFlag=2&expId=${exp.jceiId}&expType=${exp.itemName}",Width:"100",Height:"100",Title:"${expName}"});' href="javascript:void(0)">签认</a></td>
			<td><a onclick='top.Dialog.open({URL:"experiment!tosignExpItem.do?rjhmId=${datePlan.rjhmId}&roleFlag=3&expId=${exp.jceiId}&expType=${exp.itemName}",Width:"100",Height:"100",Title:"${expName}"});' href="javascript:void(0)">签认</a></td>
			<td><a onclick='top.Dialog.open({URL:"experiment!tosignExpItem.do?rjhmId=${datePlan.rjhmId}&roleFlag=4&expId=${exp.jceiId}&expType=${exp.itemName}",Width:"100",Height:"100",Title:"${expName}"});' href="javascript:void(0)">签认</a></td>
			<td><a onclick='top.Dialog.open({URL:"experiment!tosignExpItem.do?rjhmId=${datePlan.rjhmId}&roleFlag=5&expId=${exp.jceiId}&expType=${exp.itemName}",Width:"100",Height:"100",Title:"${expName}"});' href="javascript:void(0)">签认</a></td>
			<td><a onclick='top.Dialog.open({URL:"experiment!tosignExpItem.do?rjhmId=${datePlan.rjhmId}&roleFlag=6&expId=${exp.jceiId}&expType=${exp.itemName}",Width:"100",Height:"100",Title:"${expName}"});' href="javascript:void(0)">签认</a></td>
		</tr>
	</table>

</c:forEach>

<div style="height:35px;">

	<div class="clear"></div>
</div>
</body>
</html>	