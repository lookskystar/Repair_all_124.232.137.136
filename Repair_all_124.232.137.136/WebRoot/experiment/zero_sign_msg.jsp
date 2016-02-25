<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
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
<script type="text/javascript">
     function sign(){
	   var datePlanId='${dpId}';
	   if(datePlanId==''||datePlanId==undefined||datePlanId==null){
		 	top.Dialog.alert("请选择机车!");
	   }else{
		   top.Dialog.open({URL:"<%=basePath%>zeroCheck!zeroSignDialog.do?dpId="+datePlanId,Width:350,Height:150,Title:"用户签认"});
	   }
     }

     function report(){
    	window.parent.jcgz_gdt.location="<%=basePath%>work/role/role_ratify.jsp?rjhmId=${plan.rjhmId}&jcstype=${plan.fixFreque}&rtype=4&role=comm";
     }
</script>
</head>
<body>
<div id="showImage">
               <button  onclick="sign();"><span class="icon_save">签认</span></button>&nbsp;&nbsp;&nbsp;
               <button  onclick="report();"><span class="icon_save">报活</span></button><br/>
	    	    <table width="100%" class="tableStyle">
					<tr>
					    <th  class="ver01" width="10%">标识</th>
						<th class="ver01">工号</th>
						<th class="ver01">检查人</th>
						<th class="ver01">签到时间</th>
					</tr>
					<c:forEach items="${zeroChecks}" var="entity">
					   <tr>
					   <td class="ver01" align="center">${entity.zeroid}</td>
					    <td class="ver01" align="center">${entity.userId.gonghao}</td>
						<td class="ver01" align="center">${entity.userId.xm}</td>
						<td class="ver01" align="center">${entity.signTime}</td>
					  </tr>
					</c:forEach>
				</table>
	    	  </div>
</body>
</html>