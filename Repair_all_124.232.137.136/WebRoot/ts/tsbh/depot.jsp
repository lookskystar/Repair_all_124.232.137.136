<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<base href="<%=basePath%>" />
<title>探伤报活</title>

<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" id="skin"
	prePath="<%=basePath%>" />
<!--框架必需end-->
<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css" />

<!--引入组件start-->
<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->
<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<script type="text/javascript">
	$(function(){
	   	top.Dialog.close();
	   	<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
	    </c:if>
	   });

	function checkForm(){
		var jcNum = $("#jcNum").val();
		var jcFixNum = $("#jcFixNum").val();
		var unitName = $("#unitName").val();
		if(jcNum==""||jcNum==undefined){
			top.Dialog.alert("机车号不能为空");
			return false;
		}
		if(jcFixNum==""||jcFixNum==undefined){
			top.Dialog.alert("机车修次不能为空");
			return false;
		}
		if(unitName==""||unitName==undefined){
			top.Dialog.alert("报活部件不能为空");
			return false;
		}
		return true;
	}	   
</script>
</head>

<body>
<div class="box1" panelTitle="探伤报活" overflow="auto">
	<form action="tsAction!tsDepot.do" method="post" onsubmit="return checkForm();">
	<input type="hidden" value="${session_user.xm}" name="tsAtRecord.atWorker"/>	
	<input type="hidden" value="0" name="tsAtRecord.status"/>
	<table class="tableStyle" overflow="auto">
		<tr>
			<td width="10%" align="center" style="font-size: 15px;">车型：</td>
			<td >
				<select name="tsAtRecord.jcType" class="default" autoWidth="true" style="width:125px;">
					<c:forEach var="jcType" items="${jcTypes}">
						<option <c:if test="${jcType.jcStypeValue==jcType2}"> selected="selected"</c:if>>${jcType.jcStypeValue}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td align="center" style="font-size: 15px;">车号：</td>
			<td><input id="jcNum" type="text" value="${jcNum }" name="tsAtRecord.jcNum"/></td>
		</tr>
		<tr>
			<td align="center" style="font-size: 15px;">修程：</td>
			<td>
			<select name="tsAtRecord.xc" class="default" autoWidth="true" style="width:125px;">
					<c:forEach var="xc" items="${xc}">
						<option <c:if test="${xc==xc2}"> selected="selected"</c:if>>${xc}</option>
					</c:forEach>
			</select>
			</td>
		</tr>
		<tr>
			<td align="center" style="font-size: 15px;">修次：</td>
			<td><input id="jcFixNum" type="text" value="${jcFixNum }" name="tsAtRecord.jcFixNum"/></td>
		</tr>
		<tr>
			<td align="center" style="font-size: 15px;">部件：</td>
			<td>
			<select id="unitName" name="tsAtRecord.unitName" class="default" autoWidth="true" style="width:125px;">
					<c:forEach var="unit" items="${units}">
						<option <c:if test="${unit.unitName==unitName2}"> selected="selected"</c:if>>${unit.unitName}</option>
					</c:forEach>	
			</select>
			</td>
		</tr>
		<tr>
			<td align="center" style="font-size: 15px;">数量：</td>
			<td><input type="text" value="" name="tsAtRecord.unitCount"/></td>
		</tr>
		<tr>
			<td align="center" style="font-size: 15px;">编号：</td>
			<td><input type="text" value="" name="tsAtRecord.unitNum"/></td>
		</tr>
		<tr>
			<td colspan="2" >
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value="重置" style="font-size: 12px;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" value="确定报活" style="font-size: 12px;"/>
			</td>				
		</tr>
	</table>
	</form>	
</div>
</body>
</html>