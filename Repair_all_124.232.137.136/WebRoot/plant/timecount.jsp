<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->

	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript">
		function sub(){
			$("#subForm").submit();
		}
	</script>
</head>
<body>
	<form action="timecount!getTotalDuration.do" method="post"
		id="subForm">
		<div class="box2" panelTitle="小辅修工时统计" roller="false">
			<table>
				<tr>
					<td>
						开始时间：
					</td>
					<td>
						<input type="text" id="startDate" value="${startDate }"
							class="Wdate"
							onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))"
							name="startDate" />
					</td>
					<td>
						结束时间：
					</td>
					<td>
						<input type="text" class="Wdate" id="endDate" value="${endDate }"
							onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))"
							name="endDate" />
					</td>
				</tr>
				<tr>
					<td>
						机车编号：
					</td>
					<td>
						<input type="text" id="jcnum" name="jcNum" value="${jcNum }" />
					</td>
					<td>
						工人姓名：
					</td>
					<td>
						<input type="text" id="fixemp" name="fixEmp" value="${fixEmp }" />
					</td>
					<td>
						<button onclick="sub();">
							<span class="icon_find" style="height: 22px;">查询</span>
						</button>
					</td>
				</tr>
			</table>
		</div>
			<table class="tableStyle" useMultColor="true">
				<tr>
					<th width="30%" align="center">
						<span>工人姓名</span>
					</th>
					<th width="30%" align="center">
						<span>小辅修时长</span>
					</th>
					<th width="40%" align="center">
						操作
					</th>
				</tr>
				<c:if test="${!empty pm.datas}">
					<c:forEach items="${pm.datas}" var="item">
						<tr>
							<td width="30%" align="center">
								<span>${fn:substring(item[0],1,fn:length(item[0])-1)}</span>
							</td>
							<td width="30%" align="center">
								<span>${item[1]} &nbsp;&nbsp;&nbsp;分钟</span>
							</td>
							<td width="40%" align="center">
								<a onclick="view('${item[0]}');">查看记录</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty pm.datas}">
					<tr>
						<td class="ver01" align="center" colspan="3">
							没有相应的数据记录!
						</td>
					</tr>
				</c:if>
			</table>
		<!-- 处理分页 -->
		<!-- <div class="float_left padding5">  共有信息${list.count}条。</div>  -->
		<div class="float_right padding5 paging">
			<div class="float_left padding_top4">
				<pg:pager maxPageItems="${pageSize }"
					url="timecount!getTotalDuration.do" items="${dataSize }"
					export="page1=pageNumber">
					<pg:param name="startDate" value="${startDate}" />
					<pg:param name="endDate" value="${endDate}" />
					<pg:param name="jcNum" value="${jcNum}" />
					<pg:param name="fixEmp" value="${urlEmp}" />
					<pg:first>
						<span><a href="${pageUrl }" id="first">首页</a>
						</span>
					</pg:first>
					<pg:prev>
						<span><a href="${pageUrl }">上一页</a>
						</span>
					</pg:prev>
					<pg:pages>
						<c:choose>
							<c:when test="${page1==pageNumber }">
								<span class="paging_current"><a href="javascript:;">${pageNumber
										}</a>
								</span>
							</c:when>
							<c:otherwise>
								<span><a href="${pageUrl }">${pageNumber }</a>
								</span>
							</c:otherwise>
						</c:choose>
					</pg:pages>
					<pg:next>
						<span><a href="${pageUrl }">下一页</a>
						</span>
					</pg:next>
					<pg:last>
						<span><a href="${pageUrl }">末页</a>
						</span>
					</pg:last>
				</pg:pager>
			</div>
			<div class="clear"></div>
		</div>
	</form>
</body>
	<script type="text/javascript">
		//查看记录
		function view(fixEmp){
			var diag = new top.Dialog();
			diag.Title = "记录查询窗口";
			diag.URL = "timecount!itemTime.do?fixEmp="+fixEmp;
			diag.Width=1200;
			diag.Height=520;
			diag.show();
		}
</script>
</html>