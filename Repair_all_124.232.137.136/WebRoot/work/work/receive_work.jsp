<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
	function openDialog(rjhmId,xx){
		top.Dialog.open({URL:"<%=basePath%>workAction!listRatifyItemsInput.do?rjhmId="+rjhmId+"&xx="+xx,Width:850,Height:500,Title:"检修项目"});
	}
</script>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	  <tr><td>
	  		<div class="box2"  panelTitle="在修机车" panelHeight="410" roller="true" showStatus="false">
			<div class="dbList">
				<table class="tableStyle" id="radioTable">
					<tr><th>机车类型</th><th>机车号</th><th>修程修次</th><th>扣车时间</th><th>操作</th></tr>
					<c:if test="${empty daprList}"><tr align="center"><td colspan="5">没有数据记录!</td></tr></c:if>
					<c:forEach var="dayPlan" items="${daprList}">
						<tr align="center">
							<td>${dayPlan.jcType}</td>
							<td>${dayPlan.jcnum}</td>
							<td>${dayPlan.fixFreque}</td>
							<td>${dayPlan.kcsj}</td>
							<td><a href="javascript:void(0);" onclick="openDialog('${dayPlan.rjhmId}','${dayPlan.fixFreque}');">查看检修项目</a></td>
						</tr>
					</c:forEach>
				</table>
				<div class="clear"></div>
			</div>
			</div>
	  </td>	</tr>
	</table>
</div>				
</body>
</html>