<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@ include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>"/>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
		<!--框架必需end-->
		<script type="text/javascript">
		   function submitForm(){
			   var content=$("#content").val();
			   var array=[];
			   $("input[name='jcNums']").each(function(){
				   var msg=$(this)[0].id+"_"+$(this).val();
				   array.push(msg);
			   });
			   $.post("planManage!editeJgItem.do",{"content":content,"pjNums":array.join(",")},function(result){
				   if(result=="success"){
		    			top.Dialog.alert("修改成功！",function(){
				    			top.window.frmright.location.href="planManage!jgEditeInput.do";
				    			top.Dialog.close();
			    			});
		    		}else{
		    			top.Dialog.alert("修改失败！");
		    		}
			   });
		   }
		</script>
	</head>
<body>
<form action="" method="post">
	<table class="tableStyle" useHover="false" useClick="false">
		<tr>
			<th colspan="2">加改项目修改</th>
		</tr>
		<tr>
		<td width="100px">加改项目内容：</td>
			<td width="400px">
				<textarea style="width:360px;height:100px;word-wrap: break-word;word-break: break-all;" id="content">${item }</textarea>
			</td>
		</tr>
		<tr>	
			<td width="60" align="center">计划加改机车数</td>
			<td>
				<ul>
				<c:forEach items="${jgitemList}" var="jgitemList">
					<li style="width: 140px;float: left;margin-left: 5px;"><span>${jgitemList.jcType }:<input type="text" style="width: 80px;float: right;margin-right: 5px;" value="${jgitemList.planNum }" id="${jgitemList.id}" name="jcNums"/></span></li>
				</c:forEach>
				</ul>
			</td>
		</tr>
	</table>
	<div align="center"><input type="button" value=" 提 交 " onclick="submitForm();"/>&nbsp;&nbsp;<input type="reset" value=" 取 消 "/></div>
</form>
</body>
</html>
