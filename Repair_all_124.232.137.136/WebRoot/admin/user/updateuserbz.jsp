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
  </head>
<body>
  	<form action="userRolesAction!updateUserBz.do" method="post" target="frmright">   
		<table class="tableStyle" transMode="true">
			<input type="hidden" name="userIds" value="${userIds }"/>
		    <tr>
				<td>转移到班组:</td>
				<td>
					<select id="proteamid"  name="bzId" colNum="2">
					     <option value="">请选择班组</option>
					     <c:forEach items="${dictProTeamList}" var="entry">
    	                     <option value="${entry.proteamid}">${entry.proteamname}</option>
    	                 </c:forEach>
					</select>
				</td>
			</tr>
		
			<tr>
				<td colspan="2">
					<input type="submit" value=" 提 交 "/>
				</td>
			</tr>      
		</table>
  	</form>  
</body>
</html>