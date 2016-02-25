<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
<script type="text/javascript">
  function show(recDetailId){
	   var itemId=${itemId}; 
	   var diag = new top.Dialog();
	   diag.Title = "填报值";
	   diag.URL = "<%=basePath%>oilAssay!fillValueInputDialog.do?recDetailId="+recDetailId;
	   diag.Width=300;
	   diag.Height=120;
	   diag.show();
  }
</script>
</head>
<body>
<div id="showImage">
	    	 	 <table width="100%" class="tableStyle">
					<tr>
					    <th class="ver01" width="3%">选择</th>
						<th class="ver01" width="40%">项目</th>
						<!--
						<th class="ver01"  width="10%">标准(最小值)</th>
						<th class="ver01" width="10%">标准(最大值)</th>
						-->
						<th class="ver01" width="5%">填报值</th>
						<th class="ver01" width="10%">化验情况</th>
						<th class="ver01" width="25%">检验人</th>
					</tr>
					<c:forEach items="${subItems}" var="entity">
					   <tr onclick="show(${entity.recdetailid});">
					    <td align="center"><input type="radio" id="${entity.recdetailid}" name="subItem" value="${entity.recdetailid}"/></td>
					    <td class="ver01" align="center">${entity.subitemtitle}</td>
					    <!-- 
						<td class="ver01" align="center">${entity.minVal}</td>
						<td class="ver01" align="center">${entity.maxVal}</td>
						 -->
						<td class="ver01" align="center">${entity.realdeteval}</td>
						<td class="ver01" align="center">${entity.quagrade}</td>
						<td class="ver01" align="center">${entity.receiptpeo}&nbsp;${entity.fintime}</td>
					  </tr>
					</c:forEach>
				</table>
	    	  </div>
</body>
</html>