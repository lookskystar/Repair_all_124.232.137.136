<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>机车互换配件(固定资产)分存卡</title>
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
	<script type="text/javascript">
	
	</script>	
</head>
<body>
	<div>
		<table class="tableStyle"  headFixMode="true" useMultColor="true">
			<tr>
				<th width="10%"><span>目录编号</span></th>
				<th width="15%"><span>配件名称</span></th>
				<th width="30%"><span>图号及规格</span></th>
				<th width="5%"><span>单位</span></th>
				<th width="5%"><span>单价</span></th>
				<th width="10%"><span>核定定量</span></th>
				<th width="10%"><span>核定金额</span></th>
				<th><span>适用机型</span></th>
			</tr>
			<tr align="center">
				<td></td>
				<td>${pjName }</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td>${jcType }</td>
			</tr>
		</table>
	</div>
	<div>
		<table class="tableStyle"  headFixMode="true" useMultColor="true">
			<tr>
				<th width="10%"><span>日期</span></th>
				<th width="30%"><span>摘要</span></th>
				<th width="10%"><span>收入</span></th>
				<th width="10%"><span>发出</span></th>
				<th width="20%"><span>配件编号</span></th>
				<th width="10%"><span>备注</span></th>
			</tr>
		</table>
	</div>
	<div id="scrollContent" >
		<table class="tableStyle"  useMultColor="true" >
			<c:if test="${!empty dataList}">
				<c:forEach items="${dataList}" var="map">
					<tr align="center">
						<td width="10%">${map['date']}</td>
						<td width="30%"></td>
						<td width="10%">${map['income']}</td>
						<td width="10%">${map['expend']}</td>
						<td width="20%">${map['pjnum']}</td>
						<td width="10%">${map['comments']}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty dataList}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			</c:if>
		</table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${deliverytiPm.count + storetipPm.count }条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="pjManageAction!storeCountDetail.action" items="${deliverytiPm.count + storetipPm.count }" export="page1=pageNumber">
				<pg:param name="pjName" value="${pjName}"/>
				<pg:param name="jcType" value="${jcType}"/>
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
</body>
</html>
