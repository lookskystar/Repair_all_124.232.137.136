<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>" />
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin"
			prePath="<%=basePath%>" />
		<!--框架必需end-->

		<!--截取文字start-->
		<script type="text/javascript" src="js/text/text-overflow.js"></script>
		<!--截取文字end-->

		<!--修正IE6支持透明PNG图start-->
		<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
		<!--修正IE6支持透明PNG图end-->
		<!-- 引入分页JS -->
		<script type="text/javascript" src="admin/js/page.js"></script>
	</head>
	<body>
		<form id="form" action="pjManageAction!findDynamicHandover.do" method="post">
			<input type="hidden" id="ids" name="ids"/>
			<div id="showImage">
				状态
				<select name="pjStatus">
					<option value="">请选择状态</option>
				    <option value="0">合格</option>
				    <option value="1">待修</option>
				</select>
				&nbsp;&nbsp;&nbsp;
				配件编号:
				<input type="text" style="width: 200px" name="pjNum"
					value="${pjNum }" />
				&nbsp;&nbsp;&nbsp; 配件名称:
				<input type="text" style="width: 200px" name="pjName"
					value="${pjName }" />
				&nbsp;&nbsp;&nbsp;
				<input type="submit" value="查询" />
				<table width="100%" class="tableStyle" useCheckBox="false">
					<tr>
						<th class="ver01" width="5%" align="center"></th>
						<th class="ver01" width="20%" align="center">
							配件名称
						</th>
						<th class="ver01" width="10%" align="center">
							所属静态配件
						</th>
						<th class="ver01" width="10%" align="center">
							配件编号
						</th>
						<th class="ver01" width="10%" align="center">
							出厂编号
						</th>
						<th class="ver01" width="10%" align="center">
							条形码
						</th>
						<th class="ver01" width="5%" align="center">
							存储位置
						</th>
						<th class="ver01" width="5%" align="center">
							配件状态
						</th>
						<th class="ver01" width="8%" align="center">
							检修流程
						</th>
					</tr>
					<c:if test="${!empty pjdynamics}">
						<c:forEach items="${pjdynamics}" var="pjd">
							<tr>
								<td class="ver01" align="center">
									<input type="checkbox" id="${pjd.pjdid}" name="pjIds"
										value="${pjd.pjdid}" onclick="change();"/>
								</td>
								<td class="ver01" align="center">
									${pjd.pjName}
								</td>
								<td class="ver01" align="center">
									--
								</td>
								<td class="ver01" align="center">
									${pjd.pjNum}
								</td>
								<td class="ver01" align="center">
									${pjd.factoryNum}
								</td>
								<td class="ver01" align="center">
									${pjd.pjBarCode}
								</td>
								<td class="ver01" align="center">
									<c:if test="${pjd.storePosition==0}">中心库</c:if>
									<c:if test="${pjd.storePosition==1}">班组</c:if>
									<c:if test="${pjd.storePosition==2}">车上</c:if>
									<c:if test="${pjd.storePosition==3}">外地</c:if>
								</td>
								<td class="ver01" align="center">
									<c:if test="${pjd.pjStatus==0}">合格</c:if>
									<c:if test="${pjd.pjStatus==1}">待修</c:if>
									<c:if test="${pjd.pjStatus==2}">报废</c:if>
									<c:if test="${pjd.pjStatus==3}">检修中</c:if>
								</td>
								<td class="ver01" align="center">
									${pjd.fixFlowName}
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</form>
		<script type="text/javascript">
			function change() {
				var ids = "";
				$('input[type=checkbox]:checked').each(function(i) {
					ids+=$(this).val()+",";
				});
				$('#ids').val(ids);
			}
		</script>
	</body>
</html>

