<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

request.setAttribute("recId",request.getParameter("recId"));
request.setAttribute("type",request.getParameter("type"));
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
  function vlidate(){
	  if($("#recesamTime").val()==""){
		  top.Dialog.alert("来样日期不能为空!");
		  return false;
	  }
	  if($("#receiptPeo").val()==""){
		  top.Dialog.alert("接样人不能为空!");
		  return false;
	  }
	  return true;
  }
  
  function show(obj){
	  if(obj.value==0){
		  $("#advice").hide();
	  }else{
		  $("#advice").show();
	  }
  }
  
</script>
</head>
<body>
<form action="oilAssay!updateOilRecorder.do" method="post" id="form" onsubmit="javascript:return vlidate();" target="frmright">
<table class="tableStyle" transMode="true">
    <input type="hidden" name="recId" value="${recorder.recPriId}"/>
	<tr>
	    <td>机车信息：</td>
		<td>
		    ${recorder.jcsTypeVal}-${recorder.jcNum}
		</td>
	</tr>
	<tr>
	  <td>取样日期：</td>
	  <td><input type="text" class="Wdate" onfocus="WdatePicker()" name="priRecorder.recesamTime" style="width:140px" id="recesamTime" value="${recorder.recesamTime}"/></td>
	</tr>
	<tr>
	  <td>化验日期：</td>
	  <td><input type="text" class="Wdate" onfocus="WdatePicker()" name="priRecorder.finTime" style="width:140px" value="${recorder.finTime}"/></td>
	</tr>
	<tr>
	  <td>来样人：</td>
	  <td><input type="text" style="width:140px" name="priRecorder.sentsamPeo" id="sentsamPeo" value="${recorder.sentsamPeo}"/></td>
	</tr>
	<tr>
	  <td>化验者：</td>
	  <td><input type="text" style="width:140px" name="priRecorder.receiptPeo" id="receiptPeo" value="${recorder.receiptPeo}" readonly="readonly"/></td>
	</tr>
	<tr>
	    <td>质量评定：</td>
		<td>
			<select class="default" style="width:140px" name="priRecorder.quasituation" onchange="show(this)">
			    <option value="0" <c:if test="${recorder.quasituation==0}">selected="selected"</c:if>>合格</option>
			  	<option value="1" <c:if test="${recorder.quasituation==1}">selected="selected"</c:if>>不合格</option>
			</select>
		</td>
	</tr>
  
	<tr id="advice" <c:if test="${empty recorder.quasituation||recorder.quasituation==0}">style="display:none;"</c:if>>
	    <td>处理意见：</td>
		<td>
			<select class="default" style="width:140px" name="priRecorder.dealAdvice">
			    <option value="0" <c:if test="${recorder.dealAdvice==0}">selected="selected"</c:if>>更换</option>
			  	<option value="1" <c:if test="${recorder.dealAdvice==1}">selected="selected"</c:if>>滤油</option>
			</select>
		</td>
    </tr>
    
	<tr>
		<td colspan="2">
			<input type="submit" value=" 提 交 "/>
			<input type="reset" value=" 重 置 "/>
		</td>
	</tr>
</table>
</form>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>