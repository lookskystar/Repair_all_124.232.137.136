<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
<!-- 引入分页JS -->
<script type="text/javascript" src="admin/js/page.js"></script>

<script type="text/javascript">
	$(function(){
		top.Dialog.close();
		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
	    </c:if>
	});

	function paigong(id){		
		top.Dialog.open({URL:"<%=basePath%>tsAction!inputDetails.do?id="+id,Width:480,Height:360,Title:"探伤记录详情"});
	}

</script>
</head>
<body>	
	<form action="tsAction!inputRecordList.do" method="post">
	<div class="box1" panelTitle="探伤记录" overflow="auto">
		<div>
		<table>
			<tr>
			<td>报活起始时间：
				<input name="btime" type="text" class="Wdate"	onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${btime}" style="width:125px;"/>
			</td>
			<td>报活结束时间：
				<input name="etime" type="text" class="Wdate"	onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${etime}" style="width:125px;"/>
			</td>
			<td><input type="submit" value="查询" /></td>
			</tr>
		</table>	
		</div>
		<div>
		<table class="tableStyle" overflow="auto">
			<tr align="center">
				<td>机车类型</td>
				<td>机车号</td>
				<td>修程</td>
				<td>修次</td>
				<td>部件</td>
				<td>报活时间</td>
				<td>报活人</td>
				<td>操作</td>
			</tr>
			<c:forEach var="depot" items="${depots.datas}">
			<tr align="center">
				<td>${depot.jcType }</td>
				<td>${depot.jcNum }</td>
				<td>${depot.xc}</td>
				<td>${depot.jcFixNum }</td>
				<td>${depot.unitName }</td>
				<td>${depot.atTime }</td>
				<td>${depot.atWorker }</td>
				<td>
					<a style="color:blue;" onclick="paigong(${depot.id });">查看记录详情</a>&nbsp;&nbsp;
				</td>
			</tr>
			</c:forEach>	
		</table>
		</div>
	</div>
	<!-- 处理分页 -->
	<div style="height:35px;">
		<div class="float_left padding10 paging">共${depots.count}条</div>
		<div class="float_right padding5 paging">
			<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="tsAction!inputRecordList.do" items="${depots.count}" export="page1=pageNumber">
			  	<pg:param name="btime" value="${btime}"/>
			  	<pg:param name="etime" value="${etime}"/>
			  	<pg:first>
				 	<span><a href="${pageUrl  }" id="first">首页</a></span>
			  	</pg:first>
			  	<pg:prev>
			  		
				  	<span><a href="${pageUrl  }">上一页</a></span>
			  	</pg:prev>
		  	  	<pg:pages>
					<c:choose>
						<c:when test="${page1==pageNumber}">
							<span class="paging_current"><a href="javascript:;">${pageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl  }">${pageNumber }</a></span>
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
				<div class="clear"></div>
			</div>
		</div>
	</div>
	</form>
</body>
	<link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</html>
