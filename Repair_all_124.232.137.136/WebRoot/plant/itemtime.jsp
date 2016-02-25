<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />
<!--框架必需end-->
<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<script type="text/javascript">
	function sub(){
		$("#subForm").submit();
	}
</script>
</head>
<body> 
	<form action="timecount!itemTime.do" method="post" id="subForm">
	<input type="hidden" name="fixEmp" value="${fixEmp}"/>
	<div class="box1" roller="false">
		<table>
			<tr>
				<td>开始时间：</td>
				<td><input type="text" id="startDate" value="${startDate }" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" name="startDate"/></td>
				<td>结束时间：</td>
				<td><input type="text" class="Wdate" id="endDate" value="${endDate }" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" name="endDate"/></td>
				<td>机车编号：</td>
				<td><input type="text" id="jcnum" name="jcNum" value="${jcNum }"/></td>
				<td><button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button></td>
			</tr>
		</table>
	</div>
	<div id="scrollContent">
		<table class="tableStyle"  useMultColor="true">
			<tr>
		      	<th scope="col" width="10%" align="center">检修人</th>
		      	<th scope="col" width="50%" align="center">检修项目</th>
		      	<th scope="col" width="10%" align="center">检修情况</th>
		      	<th scope="col" width="10%" align="center">机车型号</th>
		      	<th scope="col" width="10%" align="center">机车编号</th>
		      	<th scope="col" width="10%" align="center">工时</th>
		    </tr>
		    <c:if test="${!empty jcfixrec}">
			   	<c:forEach items="${jcfixrec.datas}" var="jcfixrec" >
			   		 <tr>
			      		<td class="row" width="10%" align="center"><c:if test="${!empty jcfixrec.fixEmp}">${fn:substring(jcfixrec.fixEmp, 1, fn:length(jcfixrec.fixEmp)-1) }</c:if></td>
			      		<td class="row" width="50%" align="left">${jcfixrec.itemName}&nbsp;</td>
			      		<td class="row" width="10%" align="center">${jcfixrec.fixSituation}&nbsp;</td>
			      		<td class="row" width="10%" align="center">${jcfixrec.jcType}&nbsp;</td>
			      		<td class="row" width="10%" align="center">${jcfixrec.jcNum}&nbsp;</td>
				  		<td class="row" width="10%" align="center">${jcfixrec.duration}&nbsp;&nbsp;分钟</td>
			    	</tr>
			   	</c:forEach>
			 </c:if>
		    <c:if test="${empty jcfixrec.datas}">
			 	<tr> 
			 		<td class="row" colspan="6" align="center">没有相应的数据记录!</td>
			 	</tr>
			</c:if>			
		</table> 
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${jcfixrec.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="timecount!itemTime.do" items="${jcfixrec.count }" export="page1=pageNumber">
				<pg:param name="startDate" value="${startDate}" /> 
				<pg:param name="endDate" value="${endDate}" /> 
				<pg:param name="jcNum" value="${jcNum}" /> 
				<pg:param name="fixEmp" value="${urlEmp}" /> 
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
	</form>	
</body>
</html>