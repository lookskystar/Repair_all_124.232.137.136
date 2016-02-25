<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>配件预领记录</title>
	<base href="<%=basePath%>" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!-- 表单验证 start -->
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!-- 表单验证 end --> 
</head>
<body>
	<div>
		<form action="pjManageAction!choiceAddvanceTipsList.do" method="post">
			<center>
				<table>
					<tr>	
						<td>配件名称：<input type="text" name="pjname" value="${pjname }"/></td>
						<td>日期：<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" name="addvancedate" value="${addvancedate }"/></td>
						<td><input type="submit" class="icon_find" value="查询" /></td>
					</tr>
				</table>
			</center>
		</form>
	</div>
	<div>
		<table class="tableStyle"  headFixMode="true" useMultColor="true">
			<tr>
				<th width="10%"></th>
				<th width="15%"><span>配件名称</span></th>
				<th width="15%"><span>配件编号</span></th>
				<th width="15%"><span>装机车号</span></th>
				<th width="15%"><span>修程</span></th>
				<th width="15%"><span>预领数量</span></th>
				<th width="15%"><span>预领日期</span></th>
			</tr>
		</table>
	</div>
	<div id="scrollContent" >
		<table class="tableStyle"  useMultColor="true" useCheckBox="true">
			<c:if test="${!empty pm}">
				<c:forEach items="${pm.datas}" var="item">
					<tr align="center">
						<td width="10%"><input type="radio"  name="item" value="${item.id }"/></td>
						<td width="15%">${item.pjname }</td>
						<td width="15%">${item.pjnum }</td>
						<td width="15%">${item.getonnum }</td>
						<td width="15%">${item.xcxc }</td>
						<td width="15%">${item.addvancenum }</td>
						<td width="15%">${item.addvancedate }</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty pm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="7">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		</table>
	</div>
	<!-- 处理分页 -->
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="pjManageAction!choiceAddvanceTipsList.do" items="${pm.count }" export="page1=pageNumber">
				<pg:param name="pjname" value="${pjname}"/>
				<pg:param name="addvancedate" value="${addvancedate}"/>
		  		<pg:first>
					 <span><a href="${pageUrl }" id="first">首页</a></span>
		 		</pg:first>
		 		<pg:prev>
					  <span><a href="${pageUrl }">上一页</a></span>
		  		</pg:prev>
	  	  		<pg:pages>
					<c:choose>
						<c:when test="${page1==pageNumber }">
							<span class="paging_current"><a href="javascript:;">${pageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl }">${pageNumber }</a></span>
						</c:otherwise>
					</c:choose>
		  		</pg:pages>
		  		<pg:next>
				    <span><a href="${pageUrl }">下一页</a></span>
		  		</pg:next>
		  		<pg:last>
				  	<span><a href="${pageUrl }">末页</a></span>
		 		</pg:last>
		 	</pg:pager>
		</div>
		<div class="clear"></div>
	</div>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>
