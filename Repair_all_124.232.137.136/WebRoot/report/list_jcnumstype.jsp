<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<title>广州铁路(集团)公司</title>
<!--框架必需start-->
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<!--框架必需end-->

<!--文本截取start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>

<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<script type="text/javascript" src="js/attention/messager.js"></script>
<!--文本截取end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->
<script type="text/javascript" src="js/menu/jkmegamenu.js"></script>
</head>

<body>
<div id="scrollContent">
	<table width="100%" class="tableStyle" useCheckBox="true"  useMultColor="true">
		<tr>
			<td class="ver01" width="20%" align="center" style="font-size: 20px;vertical-align: middle;">序号</td>
			<td class="ver01" width="20%" align="center" style="font-size: 20px;vertical-align: middle;">修程修次</td>
			<td class="ver01" width="20%" align="center" style="font-size: 20px;vertical-align: middle;">机型</td>
			<td class="ver01" width="20%" align="center" style="font-size: 20px;vertical-align: middle;">机车号</td>
			<td class="ver01" width="20%" align="center" style="font-size: 20px;vertical-align: middle;">转入时间</td>
		</tr>
		<c:forEach var="dy" items="${dpList }" varStatus="s" >
		  	<tr>
		  		<td class="ver01" style="font-size: 15px;" align="center">${s.index+1 }</td>
			     <td class="ver01" style="font-size: 15px;" align="center">
			     	<c:if test="${fn:startsWith(dy.xcxc, 'N')}">年检</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'BN')}">半年检</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'F')}">辅修</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'X')}">小修</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'Z') && !fn:endsWith(dy.xcxc,'ZZ')}">中修</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'L')}">临修</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'JG')}">加改</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'JJ')}">季检</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'YJ')}">月检</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'Z') && fn:endsWith(dy.xcxc,'ZZ')}">周期整治</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'C') && fn:endsWith(dy.xcxc,'ZZ')}">出厂整治</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'C') && fn:endsWith(dy.xcxc,'J')}">春鉴</c:if>
                    <c:if test="${fn:startsWith(dy.xcxc, 'Q')}">秋整</c:if>
			     </td>
			    <td class="ver01" style="font-size: 15px;" align="center">${dy.jcType }</td>
			    <td class="ver01" style="font-size: 15px;" align="center">
			    	<c:choose>
			    		<c:when test="${fn:startsWith(dy.xcxc, 'Z') && !fn:endsWith(dy.xcxc,'ZZ')}">
			    			<a target="_blank" style="color:#00f" href="http://${url }/xx/query!zxView.do?id=${dy.rjhmId }">${dy.jcnum }</a>
			    		</c:when>
			    		<c:otherwise>
			    			<a target="_blank" style="color:#00f" href="http://${url }/xx/query!view.do?rjhmId=${dy.rjhmId }&jcStype=${dy.jcType}&jcNum=${dy.jcnum}&xcxc=${dy.xcxc}&id=${dy.rjhmId }">${dy.jcnum }</a>
			    		</c:otherwise>
			    	</c:choose>
			    </td>
			    <td class="ver01" style="font-size: 15px;" align="center">${dy.kcsj }</td>
		 	</tr>
		</c:forEach>
		<c:if test="${empty dpList}">
			     <tr> <td class="ver01" align="center" colspan="6" style="font-size: 20px;vertical-align: middle;">没有相应数据信息!</td></tr>
			  </c:if>
	</table>
</div>
</body>
</html>