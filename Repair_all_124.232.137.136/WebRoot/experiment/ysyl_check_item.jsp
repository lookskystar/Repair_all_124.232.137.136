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
<form method="post" action="checkSign!nrYsylCheck.do" onsubmit="return validate();">
<table class="tableStyle" style="text-align: center;width: 80%" id="checkItemTab">
   <input type="hidden" value="${dpId}" name="dpId"/>
	<tr>
		<th>YSYL1:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl1" value="${nrJcJyzb.ysyl1}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>YSYL2:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl2" value="${nrJcJyzb.ysyl2}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>YSYL3:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl3" value="${nrJcJyzb.ysyl3}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>YSYL4:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl4" value="${nrJcJyzb.ysyl4}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>YSYL5:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl5" value="${nrJcJyzb.ysyl5}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>YSYL6:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl6" value="${nrJcJyzb.ysyl6}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>YSYL7:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl7" value="${nrJcJyzb.ysyl7}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>YSYL8:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl8" value="${nrJcJyzb.ysyl8}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>YSYL9:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl9" value="${nrJcJyzb.ysyl9}"  onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>YSYL10:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl10" value="${nrJcJyzb.ysyl10}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>YSYL11:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl11" value="${nrJcJyzb.ysyl11}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>YSYL12:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl12" value="${nrJcJyzb.ysyl12}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>YSYL13:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl13" value="${nrJcJyzb.ysyl13}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>YSYL14:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl14" value="${nrJcJyzb.ysyl14}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
	</tr>
	<tr>
		<th>YSYL15:</th>
		<td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl15" value="${nrJcJyzb.ysyl15}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
		<th>YSYL16:</th>
	   <td align="left"><input type="text" style="width: 150px;" name="nrjc.ysyl16" value="${nrJcJyzb.ysyl16}" onkeyup="if(isNaN(value))execCommand('undo')"/>&nbsp;Mpa</td>
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