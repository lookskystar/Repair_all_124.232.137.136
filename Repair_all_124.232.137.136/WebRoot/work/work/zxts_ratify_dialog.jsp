<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

request.setAttribute("id",request.getParameter("id"));
request.setAttribute("type",request.getParameter("type"));
request.setAttribute("role",request.getParameter("role"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
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
	//提交表单
	function submitForm(){
		var checkInfo = $("#checkInfoSelect").attr("editValue");
		if(checkInfo==undefined || checkInfo == ""){
			top.Dialog.alert("输入情况不能为空!");
			return ;
		}
		$.post("<%=basePath%>workAction!dealSituationRatify.do",{"id":"${id}","deal":checkInfo,"type":"${type}"},function(text){
			top.Dialog.alert("操作成功!",function(){
			    if("${role}"=='worker'){//工人
				    if("${type}"==0){//检查
						top.frmright.frames[0].location.reload();
						top.Dialog.close();
					}else{//检测
						top.frmright.frames[1].location.reload();
						top.Dialog.close(); 
					}
			    }else{//工长
			        top.frmright.frames[0].location.reload();
				    top.Dialog.close();
			    }
			});
		});
	}
</script>
</head>
<body>
<form action="" method="post" id="form">
<input type="hidden" id="id" name="id" value="0"/>
<table class="tableStyle" transMode="true">
	<tr><td>裂损情况：</td>
		<td>
			<select editable="true" id="checkInfoSelect" style="width: 150px;" autoWidth="true">
			    <option value="裂纹">裂纹</option>
			    <option value="损坏">损坏</option>
		 	</select>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value=" 提 交 " onclick="submitForm();"/>
			<input type="reset" value=" 重 置 "/>
		</td>
	</tr>
</table>
</form>
</body>
</html>