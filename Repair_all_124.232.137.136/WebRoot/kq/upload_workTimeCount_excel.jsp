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
		<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
		<script src="js/form/validationEngine.js" type="text/javascript"></script>
		<!--框架必需end-->
	<script type="text/javascript">	
	//提交表单
	function subForm(){
		var filePath=$("#excel").val();
		if(filePath==""){
			top.Dialog.alert("请选择要上传的文件!");
			return false;
		}else{
			var fileType=filePath.substring(filePath.lastIndexOf(".")+1);
			fileType=fileType.toLowerCase();
			if(fileType!="xls"&&fileType!="xlsx"){
				top.Dialog.alert("请选择Excel类型文件!");
				return false;
			}else{
				return true;
			}
		}
	}

	//关闭
	function exit(){
		top.Dialog.close();
	}
	</script>

	</head>
<body>
<form action="uploadExcel!uploadWorkTimeCountExcel.do" method="post" onsubmit="return subForm();" enctype="multipart/form-data" target="frmright">
	<table class="tableStyle" useHover="false" useClick="false">
	    <tr>
	      <td align="center">
	         <span style="font-weight:bold;font-size:12px;">请选择要导入的Excel文件:</span>
	         <a href="<%=basePath%>kq/workTimeCount_temp.xls" style="color: red;">excel模板下载</a>
	      </td>
	    </tr>
		<tr>
			<td align="center"><input type="file" name="excelFile" id="excel" style="width:250px;"/></td>
		</tr>
		<tr>
			<td align="center">
			   <span style="font-size:12px;color:red;">注意：班组填写不正确的数据将不会导入进去!</span>
			</td>
		</tr>
	</table>
	<div align="center"><input type="submit" value=" 提 交 "/>&nbsp;&nbsp;<input type="button" value=" 取 消 " onclick="exit();"/></div>
</form>
</body>
</html>
