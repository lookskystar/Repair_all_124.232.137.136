<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<!--修正IE6支持透明PNG图start-->
    <script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
    <!--修正IE6支持透明PNG图end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript">
	  function submitMsg(){
		  var pjdid=$("#pjdid").val();
		  var trustFactory=$("#trustFactory").val();
		  var trustother=$("#trustother").val();
		  if(trustFactory==""){
			  top.Dialog.alert("委修厂家信息不能为空!");
		  }else{
			 $.post("partFixAction!trustOutsideFix.do",{"pjdid":pjdid,"trustFactory":trustFactory,"trustother":trustother},function(data){
				 if(data=="success"){
					  top.Dialog.alert("委外检修成功!",function(){
						  window.location.href="<%=basePath%>partFixAction!pjDynamicList.do";
						  top.Dialog.close();
					  });
				 }else{
					  top.Dialog.alert("委外检修失败!");
				 }
			 });
		  }
	  }
	</script>
  </head>
<body><br/>
    <form action="" method="post" target="frmright" name="form"> 
        <input type="hidden" name="pjdid" id="pjdid" value="${pjDynamic.pjdid}"/>
		<table class="tableStyle" transMode="true"><!-- transMode="true" -->
		   <tr>
				<td>配件名称: </td>
				<td colspan="3">
				   ${pjDynamic.pjName}
				</td>
			</tr>
			<tr>
				<td>配件编号: </td>
				<td colspan="3">
				  ${pjDynamic.pjNum}
				</td>
			</tr>
	        <tr>
				<td>委修厂家: </td>
				<td colspan="3">
				   <input class="easyui-validatebox" type="text" name="trustFactory" style="width: 300px;" id="trustFactory"></input>
				</td>
			</tr>
		    <tr>
				<td>备注: </td>
				<td colspan="3">
				   <textarea rows="" cols="" style="width: 300px;" name="trustother" id="trustother"></textarea>
				</td>
			</tr>
			<tr><td colspan="4" align="center"><input type="button" value="确定" onclick="submitMsg()"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置"/></td></tr>         
		</table>
	</form>
</body>
</html>