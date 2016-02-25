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

</script>
</head>
<body>
<form id="form" action="planManage!monthPlanListInput.do" method="post">
	<div id="showImage" class="box1">
                   <center> 请选择时间:<select id="monthId" class="default" name="monthId" style="width:150px;">
                      <option value="0">请选择时间</option>
                     <c:forEach var="month" items="${monthPlans}">
                         <option value="${month.monPlanId }" <c:if test="${month.monPlanId==monthId}">selected="selected"</c:if>>${month.planTime  }</option>
                     </c:forEach>
               </select>&nbsp;&nbsp;<input type="submit" value="查询"/>&nbsp;&nbsp;
              </center>
      <c:if test="${!empty monthId}">编制人:${monthPlan.fmtPeople.xm}&nbsp;&nbsp;编制日期:${monthPlan.fmtDate}&nbsp;&nbsp;审核人:${monthPlan.verifier.xm}&nbsp;&nbsp;审核日期:${monthPlan.verifyDate}</c:if>
	   <table width="100%" class="tableStyle" useCheckBox="false">
			<tr>
				<th class="ver01" width="10%" align="center">车型</th>
				<th class="ver01" width="10%" align="center">车号</th>
				<th class="ver01" width="10%" align="center">修程</th>
				<th class="ver01" width="20%" align="center">计划检修日期</th>
				<th class="ver01" width="20%" align="center">上次检修日期</th>
				<th class="ver01" width="10%" align="center">修程走行公里</th>
				<th class="ver01" width="10%" align="center">总走行公里</th>
				<th class="ver01" width="10%" align="center">状态</th>
			</tr>
			<c:if test="${!empty pm.datas}">
				<c:forEach items="${pm.datas}" var="monthRec">
				   <tr>
					<td class="ver01" align="center">${monthRec.jcType}</td>
					<td class="ver01" align="center">${monthRec.jcNum}</td>
					<td class="ver01" align="center">${monthRec.fixFreque}</td>
					<td class="ver01" align="center">${monthRec.planFixDate}</td>
					<td class="ver01" align="center">${monthRec.befFixDate}</td>
					<td class="ver01" align="center">${monthRec.runKilo}</td>
					<td class="ver01" align="center">${monthRec.totalRunKilo}</td>
					<td class="ver01" align="center">
					  <c:if test="${monthRec.planStatus==3}">发布</c:if>
					  <c:if test="${monthRec.planStatus==4}">完成</c:if>
					</td>
				  </tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty pm.datas}">
			 <tr> <td class="ver01" align="center" colspan="8">没有相应的数据记录!</td></tr>
			 </c:if>
	</table>
 </div></form>
 
	<!-- 处理分页 -->
	<div style="height:35px;">
	总共${pm.count}条记录,每页显示10条记录
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
		<pg:pager maxPageItems="${pageSize }" url="planManage!monthPlanListInput.do" items="${pm.count}" export="page1=pageNumber">
		  <pg:param name="monthId" value="${monthId}"/>
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
	<div class="clear"></div>
</div>
   <!-- 处理分页end -->
</body>
</html>
