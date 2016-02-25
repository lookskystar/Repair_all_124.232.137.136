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
	<form action="timecount!repItem.do" method="post" id="subForm">
	<div class="box1" roller="false">
	    <input type="hidden" name="dealFixEmp" value="${dealFixEmp}"/>
		<table>
			<tr>
				<td>报活类型：</td>
				<td>
				<select name="type">
				<option value="">请选择报活类型</option>
				<option value="0" <c:if test="${type==0 }">selected="selected"</c:if>>JT28报活</option>
				<option value="1" <c:if test="${type==1 }">selected="selected"</c:if>>复检报活</option>
				<option value="2" <c:if test="${type==2 }">selected="selected"</c:if>>过程报活</option>
				<option value="6" <c:if test="${type==6 }">selected="selected"</c:if>>零公里报活</option>
				</select>
				</td>
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
		<table class="tableStyle"  useMultColor="true">
			<tr>
		      	<th scope="col" width="15%" align="center">故障部位</th>
		      	<th scope="col" width="15%" align="center">报活情况</th>
		      	<th scope="col" width="10%" align="center">处理情况</th>
		      	<th scope="col" width="10%" align="center">检修人</th>
		      	<th scope="col" width="6%" align="center">机车型号</th>
		      	<th scope="col" width="6%" align="center">机车编号</th>
		      	<th scope="col" width="6%" align="center">修程修次</th>
		      	<th scope="col" width="10%" align="center">处理结束时间</th>
		    </tr>
		    <c:if test="${!empty jtpredict}">
			   	<c:forEach items="${jtpredict.datas}" var="jtpredict" >
			   		 <tr>
			   		 	<td class="row" align="center">${jtpredict.repPosi}</td>
			      		<td class="row" align="left">${jtpredict.repsituation}</td>
			      		<td class="row" align="center">${jtpredict.dealSituation}</td>
			      		<td class="row" align="center"><c:if test="${!empty jtpredict.dealFixEmp}">${fn:substring(jtpredict.dealFixEmp, 1, fn:length(jtpredict.dealFixEmp)-1) }</c:if></td>
			      		<td class="row" align="center">${jtpredict.datePlanPri.jcType}</td>
			      		<td class="row" align="center">${jtpredict.datePlanPri.jcnum}</td>
			      		<td class="row" align="center">${jtpredict.datePlanPri.fixFreque}</td>
				  		<td class="row" align="center">${jtpredict.fixEndTime}</td>
			    	</tr>
			   	</c:forEach>
			 </c:if>
		    <c:if test="${empty jtpredict.datas}">
			 	<tr> 
			 		<td class="row" colspan="6" align="center">没有相应的数据记录!</td>
			 	</tr>
			</c:if>			
		</table> 
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${jtpredict.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="timecount!repItem.do" items="${jtpredict.count }" export="page1=pageNumber">
				<pg:param name="startDate" value="${startDate}" /> 
				<pg:param name="endDate" value="${endDate}" /> 
				<pg:param name="jcNum" value="${jcNum}" /> 
				<pg:param name="dealFixEmp" value="${urlEmp}" /> 
				<pg:param name="type" value="${type}" /> 
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