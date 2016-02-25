<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<base href="<%=basePath%>" />
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
</script>
</head>
<body>
	  <div id="showImage">
	    	    <table width="100%" class="tableStyle" id="userMsg">
					<tr>
					    <th  class="ver01" width="5%">选择</th>
						<th class="ver01">项目名</th>
						<th class="ver01">适用车型</th>
					</tr>
					<c:forEach var="item" items="${fixItemList}">
					 <tr>
					  <td>
					    <c:if test="${item.status==0}">
					      <input type="checkbox" id="${item.thirdUnitId}" name="items"/>
					    </c:if>
					  </td>
					  <td>${item.itemName}</td>
					  <td width="15%">${item.jcsType}</td>
					 </tr>
					</c:forEach>
				</table>
	   </div>
</body>
</html>