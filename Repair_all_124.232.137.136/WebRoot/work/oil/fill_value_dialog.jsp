<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

request.setAttribute("recDetailId",request.getParameter("recDetailId"));
request.setAttribute("itemId",request.getParameter("itemId"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左侧菜单</title>
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
<script type="text/javascript" src="js/timer2.src.js"></script> 
<script type="text/javascript">
  function submit(){
	  var fillValue=$("#fill").val();
	  var recDetailId=${recDetailId};
	  var valueType=$("#valueType").val();
	  if(fillValue==""||fillValue==undefined){
		  top.Dialog.alert("请填值!");
	  }else{
		  $.post("<%=basePath%>oilAssay!updateOilDetailRecorder.do",{"recDetailId":recDetailId,"fillVlaue":fillValue,"valueType":valueType},function(data){
			  if(data=="success"){
				  top.frmright.oilsubitem.window.location.reload();
				  top.Dialog.close();
			  }else{
				  top.Dialog.alert("操作失败!");
			  }
		  });
	  }
  }
  
  function reset(){
	  $("#fill").val("");
  }
</script>
</head>
<body>
<table class="tableStyle" transMode="true">
	<tr>
	    <td>填报值:</td>
		<td>
		  <c:if test="${empty detailRecorder.subItemId.fillDefVal}">
		    <input type="hidden" value="1" id="valueType"/>
		    <input type="text" onkeyup="if(isNaN(value))execCommand('undo')" id="fill" value="${detailRecorder.realdeteVal}"/>
		  </c:if>
		  <c:if test="${!empty detailRecorder.subItemId.fillDefVal}">
		    <input type="hidden" value="2" id="valueType"/>
		    <input type="text" id="fill" value="${detailRecorder.quaGrade}"/>
		  </c:if>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value=" 提 交 " onclick="submit();"/>
			<input type="button" value=" 重 置 " onclick="reset();"/>
		</td>
	</tr>
	<!-- 
	<object width="32" height="32" title="MyActiveX" id="x" name="x" classid="clsid:A4D8D89A-CF2A-49BB-B703-25E48360D2A8" codebase="ActiveX.CAB#version=1,0,0,0"></object>
	 -->
</table>
</body>
</html>