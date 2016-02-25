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
<div id="scrollContent">
<form id="form" action="planManage!weekPlanListInput.do" method="post">
	<div id="showImage" class="box1">
                   <center> 请选择时间:<select id="monPlanId" class="default" name="monPlanId" style="width:150px;">
                     <c:forEach var="month" items="${monthPlans}">
                         <option value="${month.monPlanId }" <c:if test="${month.monPlanId==monPlanId}">selected="selected"</c:if>>${month.planTime  }</option>
                     </c:forEach>
               </select>&nbsp;&nbsp;请选择周次:
               <select class="default" style="width:100px;" name="planType">
                 <option value="0" <c:if test="${planType==0}">selected="selected"</c:if>>第一周</option>
                 <option value="1" <c:if test="${planType==1}">selected="selected"</c:if>>第二周</option>
                 <option value="2" <c:if test="${planType==2}">selected="selected"</c:if>>第三周</option>
                 <option value="3" <c:if test="${planType==3}">selected="selected"</c:if>>第四周</option>
                 <option value="4" <c:if test="${planType==4}">selected="selected"</c:if>>第五周</option>
               </select>&nbsp;&nbsp;
               <input type="submit" value="查询"/>&nbsp;&nbsp;
               <c:if test="${!empty monthId}">编制人:${monthPlan.fmtPeople.xm}&nbsp;&nbsp;编制日期:${monthPlan.fmtDate}</c:if>
              </center>
	   <table width="100%" class="tableStyle" useCheckBox="false">
			<tr>
				<th class="ver01" width="10%" align="center">车型</th>
				<th class="ver01" width="10%" align="center">车号</th>
				<th class="ver01" width="10%" align="center">修程</th>
				<th class="ver01" width="20%" align="center">计划检修日期</th>
				<th class="ver01" width="20%" align="center">上次检修日期</th>
				<th class="ver01" width="10%" align="center">修程走行公里</th>
				<th class="ver01" width="10%" align="center">总走行公里</th>
				<th class="ver01" width="10%" align="center">备注</th>
			</tr>
			<c:if test="${!empty weekRecs}">
				<c:forEach items="${weekRecs}" var="monthRec">
				   <tr>
					<td class="ver01" align="center">${monthRec.jcType}</td>
					<td class="ver01" align="center">${monthRec.jcNum}</td>
					<td class="ver01" align="center">${monthRec.fixFreque}</td>
					<td class="ver01" align="center">${monthRec.planFixDate}</td>
					<td class="ver01" align="center">${monthRec.befFixDate}</td>
					<td class="ver01" align="center">${monthRec.runKilo}</td>
					<td class="ver01" align="center">${monthRec.totalRunKilo}</td>
					<td class="ver01" align="center">
					</td>
				  </tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty weekRecs}">
			 <tr> <td class="ver01" align="center" colspan="8">没有相应的数据记录!</td></tr>
			 </c:if>
	</table>
 </div></form></div>
</body>
</html>
