<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
<script type="text/javascript">
//$(function(){
	//top.Dialog.close();
//})
  function sign(){
	//质检 技术
	var zjjs = top.jcmain.jcgz_gdt.page_tab_index0.document.getElementById("zj").value;
	//验收员
	var ys = top.jcmain.jcgz_gdt.page_tab_index0.document.getElementById("ys").value;
	if(zjjs != "" && zjjs != null && zjjs != undefined && ys != "" && ys != null && ys != undefined){
		top.Dialog.open({URL:"<%=basePath%>checkSign!checkSignDialogInput.do",Width:350,Height:150,Title:"用户签认"});
	}else{
		top.Dialog.alert("签认状态不符合!");
	}
  }
  
  function validate(){
	  var gzId=$("#gzId").val();
	  var zjId=$("#zjId").val();
	  var ysId=$("#ysId").val();
	  if(gzId==""||zjId==""||ysId==""){
		  top.Dialog.alert("请签认完全!");
		  return false;
	  }
  }
</script>
</head>
<body>
<button onclick="sign();" style="margin-top: 5px;margin-bottom: 8px;"><span class="icon_save">签名</span></button>
<center>
<form method="post" action="checkSign!nrHyylCheck.do" onsubmit="return validate();">
<table class="tableStyle" style="text-align: center;width: 80%" id="checkItemTab">
   <input type="hidden" value="${dpId}" name="dpId"/>
	<tr>
		<th>转速1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylzs1" value="${nrJcJyzb.hyylzs1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>转速2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylzs2" value="${nrJcJyzb.hyylzs2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>一室1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylys1" value="${nrJcJyzb.hyylys1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>一室2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylys2" value="${nrJcJyzb.hyylys2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>出口1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylck1" value="${nrJcJyzb.hyylck1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>出口2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylck2" value="${nrJcJyzb.hyylck2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>粗前1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylcq1" value="${nrJcJyzb.hyylcq1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>粗前2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylcq2" value="${nrJcJyzb.hyylcq2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>粗后1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylch1" value="${nrJcJyzb.hyylch1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>粗后2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylch2" value="${nrJcJyzb.hyylch2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>前增1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylqz1" value="${nrJcJyzb.hyylqz1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>前增2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylqz2" value="${nrJcJyzb.hyylqz2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>后增1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylhz1" value="${nrJcJyzb.hyylhz1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>后增2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.hyylhz2" value="${nrJcJyzb.hyylhz2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>二室1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.hyyles1" value="${nrJcJyzb.hyyles1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>二室2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.hyyles2" value="${nrJcJyzb.hyyles2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>交车工长:</th>
		<td align="left">
		   <input type="hidden" id="gzId" name="gzId" value="${nrJcJyzb.gzId.userid}"/>
		   <input type="text" style="width: 150px;" readonly="readonly" name="gz" id="gz" value="${nrJcJyzb.gzId.xm}"/>
		</td>
		<th>质检员:</th>
	   <td align="left">
	     <input type="hidden" id="zjId" name="zjId" value="${nrJcJyzb.zjId.userid}"/>
	     <input type="text" style="width: 150px;" readonly="readonly" name="zj" id="zj" value="${nrJcJyzb.zjId.xm}"/>
	   </td>
	</tr>
	<tr>
		<th>验收员:</th>
		<td align="left">
		   <input type="hidden" id="ysId" name="ysId" value="${nrJcJyzb.ysId.userid}"/>
		   <input type="text" style="width: 150px;" readonly="readonly" name="ys" id="ys" value="${nrJcJyzb.ysId.xm}"/>
		</td>
		<th></th>
	   <td align="left"></td>
	</tr>
	<tr>
		<td align="center" colspan="4"><input type="submit" style="width: 150px;" value=" 提    交  "/></td>
	</tr>
</table>
</form>
</center>
<script type="text/javascript">
    $(function(){
    	<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
	   </c:if>
    });
</script>
</body>
</html>