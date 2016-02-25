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
    
    <title>创建日计划的选择配件页面</title>
    <!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<script type="text/javascript">
	</script>

  </head>
  
 <body>

<div class="box_tool_mid padding_right5">
	<div class="center">
	<div class="left">
	<div class="right">
		<div class="padding_top8 padding_left10">
		<form action="pjManageAction!choiceWzNum.action" method="post">
		  <center>
			<table>
				<tr>
					<td>物资名称：</td>
					<td><input type="text" name="pjName" value="${pjName}" /></td>
					<td>
						<input type="submit" value="查询"/>
					</td>
				</tr>
			</table></center>
		</form>
		
		</div>			
	</div>		
	</div>	
	</div>
</div>

<div>
	<table class="tableStyle"  headFixMode="true" useMultColor="true">
		<tr>
			<th width="25">选择</th>
			<th width="100"><span>物资编码</span></th>
			<th width="100"><span>物资名称</span></th>
			<th width="100"><span>规格型号</span></th>
		</tr>
	</table>
</div>
<div id="scrollContent" style="height: 280px;">
	<table class="tableStyle"  useMultColor="true">
		<c:if test="${!empty pageModel}">
			<c:forEach items="${pageModel.datas}" var="wz">
				<tr align="center">
					<td width="25">
						<input type="radio" id="${wz.id}" name="pjRadio" value="${wz.wzNum}" />
					</td>
					<td width="100">${wz.wzNum}</td>
					<td width="100">${wz.wzName}</td>
					<td width="100">${wz.wzType}</td>
				</tr>
			</c:forEach>
		</c:if>
		
		
	</table>
	
	<div style="height:35px;">
		<div class="float_left padding5">
			<c:if test="${empty pageModel}">
				共有信息0条,一页可显示${pageSize}条记录。
			</c:if>
			<c:if test="${!empty pageModel}">
				共有信息${pageModel.count }条,每页显示${pageSize}条记录。 
			</c:if>
		</div>
		<div class="float_right padding5 paging">
			<pg:pager items="${pageModel.count}" url="pjManageAction!choiceWzNum.action" maxPageItems="10" export="currentPageNumber=pageNumber">
			    <pg:param name="pjName" value="${urlName}"/>
				<pg:prev><span><a href="${pageUrl }">上一页</a></span></pg:prev>
				<pg:pages>
					<c:choose>
						<c:when test="${currentPageNumber==pageNumber}">
							<span class="paging_current"><a href="javascript:;">${currentPageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl }">${pageNumber }</a></span>
						</c:otherwise>
					</c:choose>
				</pg:pages>
				<pg:next><span><a href="${pageUrl }">下一页</a></span></pg:next>
			</pg:pager>
		</div>
		<div class="clear"></div>
	</div>

</div>



  </body>
</html>
