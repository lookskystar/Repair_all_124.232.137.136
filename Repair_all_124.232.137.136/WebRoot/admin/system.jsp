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
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin"
			prePath="<%=basePath%>" />
		<!--框架必需end-->
		<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
		<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css" />
		<!--截取文字start-->
		<script type="text/javascript" src="js/text/text-overflow.js"></script>
		<!--截取文字end-->
		<!--修正IE6支持透明PNG图start-->
		<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
		<!--修正IE6支持透明PNG图end-->
		<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	</head>
	<body>
		<form action="system!set.do" method="post" target="frmright">
			<div class="box1">
				<table class="tableStyle" formMode="true">
					<tr>
						<th colspan="2">
							系统环境设置&nbsp;&nbsp;&nbsp;&nbsp;
							<font style="color: #f00;font-size: 11px;font-style: normal;">请勿随便修改</font>
						</th>
					</tr>
					<tr>
						<td width="200">是否启动报表模板：</td>
						<td>
							<label for="radio-5">启用</label><input type="radio" id="radio-5" name="is_use_report" value="1" <c:if test="${paramter[0].parameterValue==1}">checked="checked"</c:if>/>&nbsp;&nbsp;
							<label for="radio-6">不启用</label><input type="radio" id="radio-6" name="is_use_report" value="0" <c:if test="${paramter[0].parameterValue==0}">checked="checked"</c:if>/>
							&nbsp;&nbsp;<font style="color: #f00;">(若启用需要进行报表设置)</font>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="submit" value=" 提 交 "/>
							<input type="reset" value=" 重 置 "/>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>