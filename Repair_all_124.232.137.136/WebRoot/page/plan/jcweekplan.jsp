<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@ include file="/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<base href="<%=basePath%>" />
	<title>机车信息</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
	<!--框架必需end-->
	<body>
			<fieldset>
				<legend>
					待修机车
				</legend>
				<table class="tableStyle" id="radioTable">
					<thead>
						<tr>
							<th width="2%">
							</th>
							<th>
								车型
							</th>
							<th>
								车号
							</th>
							<th>
								修程修次
							</th>
							<th>
								备注
							</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${!empty mainPlanDetail}">
							<c:forEach items="${mainPlanDetail}" var="entry">
								<tr>
									<td>
										<input type="radio" name="jiche" value="${entry.jcType}-${entry.jcNum}-${entry.xcxc}-${entry.id}"/>
									</td>
									<td>
										${entry.jcType}
									</td>
									<td>
										${entry.jcNum}
									</td>
									<td>
										${entry.xcxc}
									</td>
									<td>${entry.comments }</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</fieldset>
			<input type="hidden" id="jcs"/>
		<script type="text/javascript">
			function getRadioLine(){
				var msg;
				msg=$("#radioTable input[type=radio]").filter("[checked=true]").val();
				if (typeof(msg) == 'undefined') {
					top.Dialog.alert("请选择需要扣的机车！");
				} else {
					$("#jcs").val(msg);
				}
			}
		</script>
	</body>
</html>