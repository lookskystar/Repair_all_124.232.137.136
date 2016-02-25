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
    <form action="userRolesAction!userInfoList.do" method="post" target="frmright"> 
  	    <input type="hidden" value="${user.userid }" name="userId"/>
		<table class="tableStyle" formMode="true">
			<tr>
				<td>机&nbsp;务&nbsp;段: </td>
				<td>
					 <c:forEach items="${dictJwdList}" var="entry"> 
    	                <c:if test="${user.jwdcode==entry.jwdcode}">${entry.jwdmc}</c:if>
    	             </c:forEach>
				</td>
				<td>地&nbsp;&nbsp;&nbsp;&nbsp;区: </td>
				<td>
					<c:forEach items="${dictAreaList}" var="entry"> 
    	               <c:if test="${user.areaid==entry.areaid}">${entry.name}</c:if>
    	            </c:forEach>
				</td>
			</tr>
	 		<tr>
				<td>是否启用: </td>
				<td>
				  <c:choose>
				     <c:when test="${user.isuse==1 }">是</c:when>
				     <c:otherwise>否</c:otherwise>
				  </c:choose>
				</td>
				<td>班&nbsp;&nbsp;&nbsp;&nbsp;组: </td>
				<td>
					 <c:forEach items="${dictProTeamList}" var="entry"> 
    	                <c:if test="${user.bzid==entry.proteamid}">${entry.proteamname}</c:if>
    	             </c:forEach>
				</td>
			</tr>
			<tr>
				<td>角&nbsp;&nbsp;&nbsp;&nbsp;色:</td>
				<td>
					<c:forEach items="${user.rolePrivs}" var="userrole">
						<c:forEach items="${rolePrivsList}" var="entry">
						  <c:if test="${!fn:containsIgnoreCase(entry.py,'XTGL')}">
	    	                 <c:if test="${userrole.roleid==entry.roleid}">${entry.rolename}</c:if>
	    	              </c:if>  
	    	            </c:forEach>
					</c:forEach>
				</td>
			
				<td>用户姓名: </td>
				<td>
					${user.xm }
				</td>
			</tr>
			<tr>
				<td>登陆名称: </td>
				<td>
					${user.name }
				</td>
			
				<td>用户工号: </td>
				<td>
					${user.gonghao }
				</td>
			</tr>
			<tr>
				<td>IDK卡号: </td>
				<td>
					${user.idkid }
				</td>
			
				<td>登录密码: </td>
				<td>
					${user.pwd }
				</td>
			</tr>
			
			<tr>
				<td>登录时间: </td>
				<td>
					${user.logintime }
				</td>
			
				<td>登记日期: </td>
				<td>
					${user.uptime }
				</td>
			</tr>
			
			<tr>
				<td>性&nbsp;&nbsp;&nbsp;&nbsp;别: </td>
				<td>
					${user.sex }
				</td>
			
				<td>办公电话: </td>
				<td>
					${user.tel }
				</td>
			</tr>
			<tr>
				<td>办公传真: </td>
				<td>
					${user.fax }
				</td>
			
				<td>手&nbsp;&nbsp;&nbsp;&nbsp;机1: </td>
				<td>
					${user.mobile }
				</td>
			</tr>
			<tr>
				<td>手&nbsp;&nbsp;&nbsp;&nbsp;机2: </td>
				<td>
					${user.mobile2 }
				</td>
			
				<td>家庭电话: </td>
				<td>
					${user.homephone }
				</td>
			</tr>
			<tr>
				<td>通讯地址: </td>
				<td>
					${user.address }
				</td>
			
				<td>IP地址: </td>
				<td>
					${user.ip }
				</td>
			</tr>
		    <tr>
				<td>姓名拼音: </td>
				<td>
					${user.py }
				</td>
			
				<td>备&nbsp;&nbsp;&nbsp;&nbsp;注: </td>
				<td>
					${user.qita }
				</td>
			</tr>
			<tr></tr>
		</table>
	</form>
</body>
</html>