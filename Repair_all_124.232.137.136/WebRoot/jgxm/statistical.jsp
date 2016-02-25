<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>加改项目统计</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/bsFormat.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->

	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	
	<script type="text/javascript">
		function openWindow(){
			top.Dialog.open({URL:"http://www.baidu.com",Title:"添加加改机车 ",Width:600,Height:400})
		}
	</script>
  </head>
  
  <body>
    <table class="tableStyle" style="text-align: center;margin-top: 30px;" id="checkItemTab" useCheckbox="false">
	
		<tr>
			<th width="200px">加改项目/机车类型</th>
			<th width="10%"></th>
			<th width="10%">DF4</th>
			<th width="10%">DF4D</th>
			<th width="10%">合计</th>
		</tr>
		<tr>
			<td></td>
			<td>配属台数</td>
			<td>12</td>
			<td>10</td>
			<td>22</td>
		</tr>
		<tr>
			<td>
				<a href="javascript:openWindow()" ><font color="red">防火报警装置</font></a>
			</td>
			<td >数量</td>
			<td>1</td>
			<td>1</td>
			<td>2</td>
		</tr>
	</table>
  </body>
</html>
