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
    <title>待派工的报活页面</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="predict/js/create-predict.js"></script>
  </head>
  <body>
  <div class="box2" panelTitle="报活签认列表" roller="false" showStatus="false">
  	<div>
		<table class="tableStyle" headFixMode="true" useMultColor="true">
			<tr align="center">
				<th width="5%">序号</th>
				<th width="10%"><span>配件名</span></th>
				<th width="10%"><span>配件编号</span></th>
				<th width="10%"><span>报活人</span></th>
				<th width="12%"><span>报活时间</span></th>
				<th width="10%"><span>指派班组</span></th>
				<th width="10%"><span>检修人</span></th>
				<th width="13%"><span>故障描述</span></th>
				<th width="10%"><span>工人签认</span></th>
				<th width="10%"><span>工长签认</span></th>
			</tr>
		</table>
	</div>
	
	<div id="scrollContent" >
		<table class="tableStyle"  useMultColor="true">
			
			<c:forEach items="${pageModel.datas}" var="predict" varStatus="i">
				<tr align="center">
				<td width="5%">${i.index+1}</td>
				<td width="10%">${predict.pjDynamicInfo.pjName}</td>
				<td width="10%">${predict.pjDynamicInfo.pjNum}</td>
				<td width="10%">${predict.maker}</td>
				<td width="10%">
					<fmt:formatDate value="${predict.makeDate}" pattern="yyyy-MM-dd HH:mm"/> 
				</td>
				<td width="10%">
					${predict.bzName}
				</td>
				<td width="10%">
					${predict.fixemp}
				</td>
				<td width="10%">
					${predict.description}
				</td>
				<td width="10%">
					<c:choose>
						<c:when test="${empty predict.empaffirmtime}">
							<button onclick="signPredict(${predict.predictId},1)"><span>签认</span></button>
						</c:when>
						<c:otherwise>
							<span style="color: red;">
								${predict.fixemp}<br/><fmt:formatDate value="${predict.empaffirmtime}" pattern="yyyy-MM-dd HH:mm"/> 
							</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td width="10%">
					<c:choose>
						<c:when test="${empty predict.lead}">
							<button onclick="signPredict(${predict.predictId},2)"><span>签认</span></button>
						</c:when>
						<c:otherwise>
							<span style="color: red;">
								${predict.lead}<br/><fmt:formatDate value="${predict.ldaffirmtime}" pattern="yyyy-MM-dd HH:mm"/> 
							</span>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	
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
			<pg:pager items="${pageModel.count}" url="partFixAction!toSignPredict.do" maxPageItems="10" export="currentPageNumber=pageNumber">
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
