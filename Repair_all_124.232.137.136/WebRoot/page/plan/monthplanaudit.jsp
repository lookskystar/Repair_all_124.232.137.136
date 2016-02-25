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
	<head>
		<base href="<%=basePath%>">
		<title>月计划审核</title>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
		<!--框架必需end-->
	</head>
	<body>
		<table width="100%" border="0" cellspacing="3" cellpadding="0">
			<tr>
				<td width="50%" valign="top">
					<div>
						<fieldset>
							<legend>
								月计划审核
							</legend>
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left10">
												<a href="javascript:;" id="auditplan"><span class="icon_ok">审核</span>
												</a>
												<div class="clear"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="clear"></div>
							</div>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 407px;">
								<table class="tableStyle" useRadio="false">
									<tr>
										<th>编号</th><th>计划月份</th><th>计划类型</th><th>编制人</th><th>编制时间</th><th>状态</th>
									</tr>
									<c:if test="${!empty monPlanPris}">
										<c:forEach items="${monPlanPris}" var="entry">
											<tr align="center">
												<td><input type="radio" name="plan" value="${entry.monPlanId}" <c:if test="${id==entry.monPlanId}">checked</c:if> onclick="findMonPlanRecorderByMonPlanId()"/></td><td>${entry.planTime}</td><td><c:if test="${entry.planType==0}">月计划</c:if><c:if test="${entry.planType==1}">半月计划</c:if><c:if test="${entry.planType==2}">旬计划</c:if></td><td>${entry.fmtPeople.xm}</td><td>${entry.fmtDate}</td><td><c:if test="${entry.status==-1}">作废</c:if><c:if test="${entry.status==0}">预编制</c:if><c:if test="${entry.status==1}">正式计划</c:if><c:if test="${entry.status==2}">已审核</c:if><c:if test="${entry.status==3}">发布</c:if></td>
											</tr>
										</c:forEach>
									</c:if>
								</table>
							</div>
						</fieldset>
					</div>
				</td>
				<td rowspan="2" valign="top">
					<div>
						<fieldset>
							<legend>
								月计划检修机车
							</legend>
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left10">
												<a href="javascript:;" id="recorderaudit"><span class="icon_ok">审核通过</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="invalid"><span class="icon_remove">作废</span>
												</a>
												<div class="clear"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="clear"></div>
							</div>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 407px;">
								<table class="tableStyle" id="recorder">
									<tr>
										<th></th><th>机车类型</th><th>机车编号</th><th>修程修次</th><th>修程走行公里</th><th>总走行公里</th><th>计划扣车时间</th><th>状态</th>
									</tr>
									<c:if test="${!empty planRecorders}">
										<c:forEach items="${planRecorders}" var="entry">
											<tr>
												<td><input type="checkbox" name="recorder" value="${entry.monPrecId}"/></td><td>${entry.jcType}</td><td>${entry.jcNum}</td><td>${entry.fixFreque}</td><td>${entry.runKilo}</td><td>${entry.totalRunKilo}</td><td>${entry.planFixDate}</td><td><c:if test="${entry.planStatus==-1}">作废</c:if><c:if test="${entry.planStatus==0}">预编</c:if><c:if test="${entry.planStatus==1}">待审核</c:if><c:if test="${entry.planStatus==2}">审核</c:if><c:if test="${entry.planStatus==3}">发布</c:if><c:if test="${entry.planStatus==4}">改期</c:if><c:if test="${entry.planStatus==5}">补充</c:if><c:if test="${entry.planStatus==6}">实施</c:if></td>
											</tr>
										</c:forEach>
									</c:if>
								</table>
							</div>
						</fieldset>
					</div>
				</td>
			</tr>
		</table>
		<script type="text/javascript">
			function findMonPlanRecorderByMonPlanId() {
				var planid = $("input[name='plan']").filter("[checked=true]").val();
				if (typeof(planid) != 'undefined') {
					location.href='planManage!monthPlanAudit.action?id='+planid;
				}
			}
			$(function() {
				$('#auditplan').bind('click', function() {
					var planid = $("input[name='plan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						top.Dialog.confirm('确认该月计划审核通过吗？',function(){location.href='planManage!monthPlanAuditOperate.action?id='+planid;});
					} else {
						top.Dialog.alert("请选择月计划进行审核！");
						return false;
					}
				});
				
				$('#recorderaudit').bind('click', function() {
					auditOperate(1);
				});
				
				$('#invalid').bind('click', function() {
					auditOperate(0);
				});
				
				function auditOperate(flat) {
					var planid = $("input[name='plan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						var trains = '';
						$('#recorder input[type=checkbox]').each(function() {
							if($(this).attr("checked")){
								trains+=$(this).val()+",";
							}
						})
						console.log(trains);
						if (trains != '') {
							var message = '';
							if (flat == 1) {
								message='确认选择的这些检修记录审核通过吗？';
							} else {
								message='确认要作废选择的这些机车检修记录吗？';
							}
							top.Dialog.confirm(message,function(){location.href='planManage!monthPlanAuditOperate.action?id=${id}&type='+flat+'&trains='+trains.substr(0,trains.length);});
						} else {
							top.Dialog.alert("请选择月计划下检修机车记录！");
							return false;
						}
					} else {
						top.Dialog.alert("请选择要进行审核的月计划！");
						return false;
					}
				}
			});
		</script>
	</body>
</html>
