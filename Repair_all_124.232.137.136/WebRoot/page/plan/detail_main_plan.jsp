<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
		<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
		<script type="text/javascript" src="js/attention/floatPanel.js"></script>
		<script type="text/javascript" src="js/attention/messager.js"></script>
		<!--框架必需end-->
		<!-- 打印插件 -->
		<script type="text/javascript" src="<%=basePath %>js/LodopFuncs.js"></script>
		<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
			<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
		</object>
		<!-- 打印end -->

	</head>

	<body>
		<div class="box2" panelTitle="检修计划详细信息" roller="false">
			<center>
				<table>
					<tr>
						<td>开始日期：</td>
						<td><font style="font-weight:bold;color:red;">${mainPlan.startTime }</font>&nbsp;&nbsp;</td>
						<td>截止日期：</td>
						<td><font style="font-weight:bold;color:red;">${mainPlan.endTime }</font>&nbsp;&nbsp;</td>
						<td>计划标题：</td>
						<td><font style="font-weight:bold;color:red;">${mainPlan.title }</font>&nbsp;&nbsp;</td>
						<c:if test="${mainPlan.status==0}">
							<td>
								<button onclick="publishPlan(${mainPlan.id});"><span class="icon_edit">发布计划</span></button>
							</td>
							<td>
								<button onclick="delPlan(${mainPlan.id});"><span class="icon_delete">删除计划</span></button>
							</td>
						</c:if>
						<c:if test="${mainPlan.status==1}">
							<td>
								<button onclick="SaveAsFile();"><span class="icon_xls">Excel导出</span></button>
							</td>
							<td>
								<button onclick="preview();"><span class="icon_print">打印预览</span></button>
							</td>
							<td>
								<button onclick="print();"><span class="icon_print">打印</span></button>
							</td>
						</c:if>
					</tr>
				</table>
			</center>
		</div>
		<table class="tableStyle" useMultColor="true" id="datatabel">
			<tr>
				<th colspan="10" class="center"><font style="font-weight:bold;font-size:15px;">${mainPlan.title }</font></th>
			</tr>
			<tr>
				<th colspan="10" class="center">制表日期:${mainPlan.makeTime }&nbsp;&nbsp;&nbsp;&nbsp;制表人:${mainPlan.makePeople }</th>
			</tr>
		</table>
		<div id="content">
			<table class="tableStyle" useMultColor="true" id="datatabel">
				<tr>
					<th width="12%">日期</th>
					<th width="10%">星期</th>
					<th width="7%">序号</th>
					<th width="9%">机型</th>
					<th width="9%">机号</th>
					<th width="10%">修程</th>
					<th width="10%">计划走行公里</th>
					<th width="10%">实际走行公里</th>
					<th width="10%">扣修点</th>
					<th>备注</th>
					<c:if test="${mainPlan.status==0}">
						<th width="5%">操作</th>
					</c:if>
				</tr>
				<c:forEach var="detail" items="${mainPlanDetails }">
					<tr>
						<td class="center" name="planTime">${detail.planTime }</td>
						<td class="center" name="planWeek">${detail.planWeek }</td>
						<td class="center">${detail.num }</td>
						<td class="center">
							<c:if test="${mainPlan.status==0}">
								<input type="text" style="width:50px;" value="${detail.jcType}" onblur="updateThis(this,${detail.id });" name="jcType" />
							</c:if>
							<c:if test="${mainPlan.status==1}">${detail.jcType}</c:if>
						</td>
						<td class="center">
							<c:if test="${mainPlan.status==0}">
								<input type="text" style="width:50px;" value="${detail.jcNum }" onblur="updateThis(this,${detail.id });" name="jcNum" />
							</c:if>
							<c:if test="${mainPlan.status==1}">${detail.jcNum }</c:if>
						</td>
						<td class="center">
							<c:if test="${mainPlan.status==0}">
								<input type="text" style="width:50px;" value="${detail.xcxc }" onblur="updateThis(this,${detail.id });" name="xcxc" />
							</c:if>
							<c:if test="${mainPlan.status==1}">${detail.xcxc }</c:if>
						</td>
						<td class="center">
							<c:if test="${mainPlan.status==0}">
								<input type="text" style="width:60px;" value="${detail.kilometre }" onblur="updateThis(this,${detail.id });" name="kilometre" />
							</c:if>
							<c:if test="${mainPlan.status==1}">${detail.kilometre }</c:if>
						</td>
						<td class="center">
							<c:if test="${mainPlan.status==0}">
								<input type="text" style="width:60px;" value="${detail.realKilometre }" onblur="updateThis(this,${detail.id });" name="realKilometre" />
							</c:if>
							<c:if test="${mainPlan.status==1}">${detail.realKilometre }</c:if>
						</td>
						<td class="center">
							<c:if test="${mainPlan.status==0}">
								<input type="text" style="width:100px;" value="${detail.kcArea }" onblur="updateThis(this,${detail.id });" name="kcArea" />
							</c:if>
							<c:if test="${mainPlan.status==1}">${detail.kcArea }</c:if>
						</td>
						<td class="center">
							<c:if test="${mainPlan.status==0}">
								<input type="text" style="width:150px;" value="${detail.comments }" onblur="updateThis(this,${detail.id });" name="comments" />
							</c:if>
							<c:if test="${mainPlan.status==1}">${detail.comments }</c:if>
						</td>
						<c:if test="${mainPlan.status==0}">
							<td class="center">
								<%--
								     	<a href="javascript:void(0);" style="color:blue" onclick="xiuDetailPlan(${detail.id});">修改</a>&nbsp;&nbsp;&nbsp;
								      --%>
									<a href="javascript:void(0);" style="color:blue" onclick="delDetailPlan(${detail.id});">删除</a>
							</td>
						</c:if>
					</tr>
				</c:forEach>
				<tr></tr>
			</table>
		</div>
	</body>

</html>