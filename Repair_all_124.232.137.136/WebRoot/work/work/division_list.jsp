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
	//取消派工
	function deleteDivision(){
		var msg=$("#recRadioTable input[type=radio]").filter("[checked=true]").val();
		if(msg=="" || msg==undefined){
			top.Dialog.alert("请选择需要取消的分工详情!");
		}else{
			$.post("<%=basePath%>workAction!deleteDivision.do",{"dvid":msg,"type":"${type}"},function(text){
				if(text=="success"){
					top.Dialog.alert("取消分工成功!");
					window.parent.location.reload();
				}else if(text=="already"){
					top.Dialog.alert("由于该工人存在已完成项目，取消分工失败!");
				}else{
					top.Dialog.alert("取消分工失败!");
				}
			});
		}	
	}
</script>
</head>
<body>
<button onclick="deleteDivision();"><span class="icon_delete">取消分工</span></button>
<div class="clear" style="margin-bottom: 5px;"></div>
<table class="tableStyle" id="recRadioTable" overflow="auto">
	<c:if test="${type==0}">
		<tr><th width="30">选择</th><th>大类名称</th><th>姓名</th><th>工号</th><th>分工工长</th></tr>
		<c:if test="${empty result}">
			<tr align="center"><td colspan="5">没有派工记录!</td></tr>
		</c:if>
		<c:forEach items="${result}" var="dv">
			<tr align="center"><td><input type="radio" name="ra" value="${dv.divideId}"/></td><td>${dv.presetDivision.clsName}</td><td>${dv.user.xm}</td><td>${dv.user.gonghao }</td><td>${dv.leader.xm}</td></tr>
			<script>$("#ys_${dv.presetDivision.proSetId}",window.parent.document).hide();</script>
		</c:forEach>
	</c:if>
	<c:if test="${type==1}">
		<tr><th width="30">选择</th><th>部位</th><th>检修内容</th><th>检修人</th></tr>
		<c:if test="${empty result}">
			<tr align="center"><td colspan="5">没有派工记录!</td></tr>
		</c:if>
		
		<c:forEach items="${result}" var="dv">
			<tr align="center"><td><input type="radio" name="ra" value="${dv.preDictId}"/></td><td>${dv.repPosi}</td><td>${dv.repsituation}</td><td>${fn:substring(dv.fixEmp,1,fn:length(dv.fixEmp)-1)}</td></tr>
			<script>$("#bh_${dv.preDictId}",window.parent.document).hide();</script>
		</c:forEach>
	</c:if>
	<c:if test="${type==2}">
		<tr><th width="30">选择</th><th>项目名称</th><th>检修人</th></tr>
		<c:if test="${empty result}">
			<tr align="center"><td colspan="5">没有派工记录!</td></tr>
		</c:if>
		<c:forEach items="${result}" var="dv">
			<tr align="center"><td><input type="radio" name="ra" value="${dv.jcRecId}"/></td><td>${dv.itemName}</td><td>${fn:substring(dv.workerName,1,fn:length(dv.workerName)-1)}</td></tr>
			<script>$("#bh_${dv.items.id}",window.parent.document).hide();</script>
		</c:forEach>
	</c:if>
	
</table>
</body>
</html>