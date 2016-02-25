<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="<%=basePath%>"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script src="js/form/stepForm.js" type="text/javascript"></script>
	
    <script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<script type="text/javascript" src="js/attention/floatPanel.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!-- 解决IE6、7不兼容JSON.stringify问题 -->
	<script type="text/javascript" src="js/json2.js"></script>
	<!--框架必需end-->
	<script type="text/javascript">
	   //查看计划详情信息
	   function findMainPlanDetail(mainPlanId){
		   var diag = new top.Dialog();
		   diag.Title = "计划详情信息";
		   diag.URL = "<%=basePath%>planManage!findPlanDetail.do?mainPlanId="+mainPlanId;
		   diag.Width=1300;
		   diag.Height=600;
		   diag.show();
	   }

	   //查看计划兑现信息
	   function findCashDetail(mainPlanId){
		   var diag = new top.Dialog();
		   diag.Title = "计划兑现信息";
		   diag.URL = "<%=basePath%>planManage!findCashDetail.do?mainPlanId="+mainPlanId;
		   diag.Width=1300;
		   diag.Height=600;
		   diag.show();
	   }
	</script>
</head>
<body>
<div class="box2" panelTitle="检修计划" roller="false">
       <form action="planManage!cashMainPlanInput.do" method="post">
			<table>
				<tr>
					<td>开始日期：</td>
					<td><input type="text" id="startTime" name="startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${startTime }"/></td>
					<td>截止日期：</td>
					<td><input type="text" id="endTime" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${endTime }"/></td>
					<td><input type="submit" value="查询" class="icon_edit"/></td>
				</tr>
			</table>
	   </form>
	</div>
<div id="scrollContent" class="box1">
	   <table class="tableStyle"  useMultColor="true">
		  <tr>
		        <th width="5%">序号</th>
				<th width="10%">计划开始日期</th>
				<th width="10%">计划结束日期</th>
				<th width="15%">计划标题</th>
				<th width="10%">编制人</th>
				<th width="10%">编制时间</th>
				<th width="10%">状态</th>
				<th width="10%">操作</th>
		   </tr>
	      <c:forEach var="mainPlan" items="${pm.datas}">
	         <tr>
	            <td width="5%" align="center">${mainPlan.id }</td>
          		<td width="10%" align="center">${mainPlan.startTime }</td>
				<td width="10%" align="center">${mainPlan.endTime }</td>
				<td width="15%" align="center">${mainPlan.title }</td>
				<td width="10%" align="center">${mainPlan.makePeople }</td>
				<td width="10%" align="center">${mainPlan.makeTime }</td>
				<td width="10%" align="center">
				  <c:if test="${mainPlan.status==0}"><font color="red">未发布</font></c:if>
				  <c:if test="${mainPlan.status==1}">已发布</c:if>
				</td>
				<td width="10%" align="center">
				       <a href="javascript:void(0);" onclick="findCashDetail(${mainPlan.id});" style="color:blue;">兑现详情</a>
				</td>
	         </tr>
	      </c:forEach>
	      <c:if test="${empty pm.datas}"><tr><td align="center" colspan="8">没有相应的数据记录!</td></tr></c:if>
		</table>
	<!-- 处理分页 -->
	<div class="float_left padding5">共有信息${pm.count}条,每页显示10条</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="planManage!queryMainPlanInput.do" items="${pm.count }" export="page1=pageNumber">
				<pg:param name="startTime" value="${startTime}" />
				<pg:param name="endTime" value="${endTime}" />
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
		<div class="clear"></div>
	</div>
	</div>
	<!-- 处理分页end -->
		<div style="height:40px;"></div>
</div>
<link href="<%=basePath %>js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=basePath %>js/My97DatePicker/WdatePicker.js"></script>
</body>
</html>