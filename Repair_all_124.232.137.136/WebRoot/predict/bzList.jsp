<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <base href="<%=basePath%>"/>
    
    <title>指派报活给某个班组</title>
    <!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	
  </head>
 <body>
<div>
	<table class="tableStyle"  headFixMode="true" useMultColor="true" useRadio="true">
		<tr align="center">
			<th width="25">选择</th>
			<th width="100"><span>班组id</span></th>
			<th width="100"><span>班组名</span></th>
		</tr>
	</table>
</div>
<div id="scrollContent" style="height: 280px;">
	<table class="tableStyle"  useMultColor="true">
		<c:if test="${!empty bzs}">
			<c:forEach items="${bzs}" var="bz">
				<tr align="center">
					<td width="25">
						<input type="radio" id="${bz.proteamname}" name="bzRadio" value="${bz.proteamid}" />
					</td>
					<td width="100">${bz.proteamid}</td>
					<td width="100">${bz.proteamname}</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	
</div>
  </body>
</html>
