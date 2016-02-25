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
	<title>报活签认日计划</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<!-- Ajax上传图片 -->
	<Script type="text/javascript" src="js/jquery.form.js"></Script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->

	<!--文本截取start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--文本截取end-->
	<body>
		<div id="scrollContent" class="border_gray" style="margin-top: 10px;">
			<table width="100%" class="tableStyle">
				<tr align="center">
					<th class="ver01">
						机车型号
					</th>
					<th class="ver01">
						机车编号
					</th>
					<th class="ver01">
						修程修次
					</th>
					<th class="ver01">
						股道号
					</th>
					<th class="ver01">
						台位号
					</th>
					<th class="ver01">
						扣车时间
					</th>
					<th class="ver01">
						起机时间
					</th>
					<th class="ver01">
						交车时间
					</th>
					<th class="ver01">
						交车工长
					</th>
					<th class="ver01">
						操作
					</th>
				</tr>
				<c:if test="${!empty datePlanPris}">
					<c:forEach items="${datePlanPris}" var="entry">
						<tr align="center">
							<td class="ver01">
								${entry.jcType}
							</td>
							<td class="ver01">
								${entry.jcnum}
							</td>
							<td class="ver01">
								${entry.fixFreque}
							</td>
							<td class="ver01">
								${entry.gdh}
							</td>
							<td class="ver01">
								${entry.twh}
							</td>
							<td class="ver01">
								${entry.kcsj}
							</td>
							<td class="ver01">
								${entry.jhqjsj}
							</td>
							<td class="ver01">
								${entry.jhjcsj}
							</td>
							<td class="ver01">
								${entry.gongZhang.xm}
							</td>
							<td class="ver01">
								<a href="javascript:;" class="icon_view hand" onclick="return distribution(${entry.rjhmId})">签认项目</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
		<script type="text/javascript">
			function distribution(id) {
				var diag = new top.Dialog();
				diag.Title = "报活信息签认窗口";
				diag.URL = 'reportWorkManage!reportWorkSignItem.action?id='+id+'&role=${role}&flag=${flag}';
				diag.Width="100";
				diag.Height="100";
				diag.show();
				return false;
			}
		</script>
	</body>
</html>