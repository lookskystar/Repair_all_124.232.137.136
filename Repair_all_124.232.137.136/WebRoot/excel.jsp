<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <script type="text/javascript" src="js/jquery-1.4.js"></script>
  <script type="text/javascript">
     function getHrefValue(){
    	 var v=$("#test1").text();
    	 $("#test2").val(v);
     }
  </script>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'excel.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	--> 
	

  </head>
  
  <body>
    <a href="javascript:void(0);" id="test1" onclick="getHrefValue();">你好</a>
    <input type="text" id="test2"/>
    <form action="<%=basePath%>uploadExcel.do" method="post" enctype="multipart/form-data">
       <!-- name名称和Action中File对象的取名要一样哦 -->
       <input type="file" name="excelFile"/><input type="submit" value="导入数据"/>
    </form>
  </body>
</html>
