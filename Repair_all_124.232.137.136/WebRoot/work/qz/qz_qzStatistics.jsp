<%@page import="com.repair.common.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>各车型秋整机车完成情况</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
	    tr  td {
	   			 border:1px solid blue;
	  		    }
	</style>
  </head>
  
  <body>
  	 <b><h2><center>各车型秋整机车完成情况表</center></h2></b>
      <table width="864" align="center" cellspacing="0" vspace="0">
		<tr style="line-height:40px;height: 40px;background-color: #328aa4;font-weight: bolder;">
			<td class="tbCELL1" align="center" style="white-space:nowrap;color:#ffffff;" width="10%">机车型号</td>
		
		
		    <td class="tbCELL1" align="center" style="white-space:nowrap;color:#ffffff;" width="10%">计划台数</td>
		
		
		    <td class="tbCELL1" align="center" style="white-space:nowrap;color:#ffffff;" width="10%">累计完成台数</td>
		
		
		    <td class="tbCELL1" align="center" style="white-space:nowrap;color:#ffffff;" width="10%">完成百分比（%）</td>
		</tr>
		<c:forEach var="entry" items="${realMap }" >
			<tr>
			    <td align="center" width="10%">${entry.key }</td>
			    <td align="center" width="10%">${planMap[entry.key]}</td> 
			    <td align="center" width="10%">${entry.value }</td>
			    <c:set var="planTotalCount" value="${planMap[entry.key]+planTotalCount }"></c:set>
			    <c:set var="realTotalCount" value="${realMap[entry.key]+realTotalCount }"></c:set>
			    <td align="center" width="10%">
			    	<c:if test="${planMap[entry.key] != 0}">
			    		<fmt:formatNumber type="number" value="${(entry.value/planMap[entry.key] =='Infinity' ? 1:entry.value/planMap[entry.key])*100}" maxFractionDigits="2"/>%
			   		</c:if>
			    </td>
			</tr>
		</c:forEach>
		<tr style="line-height:20px;height: 30px;background-color: #328aa4;font-weight: bolder;">
		    <td align="center" width="10%">总计</td>
		    <td align="center" width="10%">${planTotalCount }</td>
		    <td align="center" width="10%">${realTotalCount }</td>
		    <td align="center" width="10%">
		    	<c:if test="${planTotalCount != 0}">
		    		<fmt:formatNumber type="number" value="${(realTotalCount/planTotalCount == 'Infinity'?1:realTotalCount/planTotalCount)*100 }" maxFractionDigits="2"/>%
		   		</c:if>
		    </td>
		</tr>
		</table>
  
  </body>
</html>
