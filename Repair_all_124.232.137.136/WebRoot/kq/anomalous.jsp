<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		//获取浏览器窗口大小
		var w=window.innerWidth
		|| document.documentElement.clientWidth
		|| document.body.clientWidth;
		
		var h=window.innerHeight
		|| document.documentElement.clientHeight
		|| document.body.clientHeight;
		// Create a new instance of FusionCharts for rendering inside an HTML
	    var myChart = new FusionCharts({
	    	width: w * 0.98,
	    	height: h * 0.7,
	        type: 'MSArea',
	        renderAt: 'msAreaId',
	        dataFormat: 'json',
	        dataSource: ${jsonData}
	    });
	    // Render the chart.
	    myChart.render();
	})
	
	
	function dataCheck(){
		var proteam = $("#proteamId").val();
		var userName = $("#userName").val();
		if(proteam && userName) {
			top.Dialog.alert("请确定唯一查询条件!");
			return false;
		}
		return true;
	}
	</script>
</head>
<body>
	<div class="box2" panelTitle="综合条件查询">
		<form action="<%=basePath%>anomalouAction!createMSArea2DCharts.action" method="post" target="frmright" onsubmit="return dataCheck();">
			<div style="float: left;margin-left: 10px;margin-top: 5px;">考勤周期：</div>
			<div style="float: left;margin-left: 10px;margin-top: 5px;">
				<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM'}))" name="month" value="${month }"/>
			</div>
			<div style="float: left;margin-left: 10px;margin-top: 5px;">考勤班组：</div>	
			<div style="float: left;margin-left: 10px;margin-top: 5px;">
				<select id="proteamId" name="proteamId" colNum="4" >
					<option value="">--所有班组--</option>
					<c:forEach items="${proteams }" var="proteam">
						<option value="${proteam.proteamid }" <c:if test="${proteamId == proteam.proteamid}">selected="selected"</c:if> >${proteam.proteamname }</option>
					</c:forEach>
				</select>
			</div>
			<div style="float: left;margin-left: 10px;margin-top: 5px;">员工姓名：</div>
			<div style="float: left;margin-left: 10px;margin-top: 5px;"><input type="text" id="userName" name="userName" value="${userName }" style="width: 150px;" /></div>
			<div style="float: left;margin-left: 10px;margin-top: 5px;"><input type="submit" value="查  询" /></div>
		</form>
	</div>
	<div id="msAreaId" align="center" style="margin-top: 10px;"></div>
</body>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<!--报表插件start -->
<script type="text/javascript" src="fusioncharts/js/fusioncharts.js"></script>
<!--报表插件end-->
</html>