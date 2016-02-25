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
		<base href="<%=basePath%>"/>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>月计划制定</title>
		<!--框架必需start-->
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
		<!--框架必需end-->
		<script type="text/javascript">
			function selectAll(obj){
				var flag = obj.checked;
				$("#trains input[type=checkbox]").each(function(){
					$(this).attr("checked",flag);
				})
			}
		</script>
	</head>
	<body>
		<table width="100%" border="0" cellspacing="3" cellpadding="0" >
			<tr>
				<td width="55%" valign="top">
					<div>
						<fieldset>
							<legend>
								月计划
							</legend>
						<c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',DSJS,')}">
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left6" style="width: 520px">
											<a href="javascript:;" id="month"><span class="icon_add">月计划</span></a>
											<div class="box_tool_line"></div>
											<a href="javascript:;" id="halfmoon"><span class="icon_add">半月计划</span></a>
											<div class="box_tool_line"></div>
											<a href="javascript:;" id="tendays"><span class="icon_add">旬计划</span></a>
											<div class="box_tool_line"></div>
											<a href="javascript:;" id="plandelete"><span class="icon_delete">删除</span></a>
											<div class="box_tool_line"></div>
											<a href="javascript:;" id="savetraintoplan"><span class="icon_save">保存</span></a>
											<div class="box_tool_line"></div>
											<a href="javascript:;" id="submitaudit"><span class="icon_ok">提交审核</span></a>
											<div class="box_tool_line"></div>
											<a href="javascript:;" id="officialissue"><span class="icon_ok">正式发布</span></a>
											<div class="clear"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="clear"></div>
							</div>
						</c:if>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 158px;">
								<table class="tableStyle" useRadio="false">
									<tr>
										<th>编号</th><th>计划月份</th><th>计划类型</th><th>编制人</th><th>编制时间</th><th>状态</th>
									</tr>
									<c:if test="${!empty monPlanPris}">
										<c:forEach items="${monPlanPris}" var="entry">
											<tr align="center">
												<td><input type="radio" name="plan" value="${entry.monPlanId}" <c:if test="${id==entry.monPlanId}">checked</c:if> onclick="findMonPlanRecorderByMonPlanId()"/></td>
												<td>${entry.planTime}</td>
												<td>
													<c:if test="${entry.planType==0}">月计划</c:if>
													<c:if test="${entry.planType==1}">半月计划</c:if>
													<c:if test="${entry.planType==2}">旬计划</c:if>
												</td>
												<td>${entry.fmtPeople.xm}</td>
												<td>${entry.fmtDate}</td>
												<td>
													<c:if test="${entry.status==-1}">作废</c:if>
													<c:if test="${entry.status==0}">预编制</c:if>
													<c:if test="${entry.status==1}">正式计划</c:if>
													<c:if test="${entry.status==2}">已审核</c:if>
													<c:if test="${entry.status==3}">发布</c:if>
												</td>
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
								机车走行
							</legend>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 430px;">
								<table id="trains" border="0" cellpadding="0" cellspacing="0" class="tableStyle" useCheckBox="false">
									<tr align="center">
										<td class="ver01" width="20px"><input type="checkbox" onclick="selectAll(this);" id="all"/></td>
										<td class="ver01">机车类型</td>
										<td class="ver01">机车编号</td>
										<td class="ver01">当日走行公里</td>
										<td class="ver01">辅修走行公里</td>
										<td class="ver01">中修走行公里</td>
										<td class="ver01">大修走行公里</td>
										<td class="ver01">总走行公里</td>
									</tr>
									<c:if test="${!empty runKiloRecs}">
										<c:forEach items="${runKiloRecs}" var="entry">
											<tr>
												<td><input type="checkbox" name="train" value="${entry.runId }"/></td>
												<td>${entry.jcType }&nbsp;</td>
												<td>${entry.jcNum }&nbsp;</td>
												<td>${entry.dayRunKilo }&nbsp;</td>
												<td>${entry.minorRunKilo }&nbsp;</td>
												<td>${entry.midRunKilo }&nbsp;</td>
												<td>${entry.larRunKilo }&nbsp;</td>
												<td>${entry.totalRunKilo }&nbsp;</td>
											</tr>
										</c:forEach>
									</c:if>
								</table>
							</div>
						</fieldset>
					</div>
				</td>
			</tr>
			<tr>
				<td valign="top">
					<div>
						<fieldset>
							<legend>
								计划详细
							</legend>
						<c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',DSJS,')}">
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left10">
												<a href="javascript:;" id="modifyrecorder"><span class="icon_edit">修改</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="deleterecorder"><span class="icon_delete">删除</span>
												</a>
												<div class="clear"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="clear"></div>
							</div>
						</c:if>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 158px;">
								<table class="tableStyle" useRadio="false">
									<tr>
										<th>编号</th><th>机车类型</th><th>机车编号</th><th>修程修次</th><th>修程走行公里</th><th>总走行公里</th><th>计划扣车时间</th><th>状态</th>
									</tr>
									<c:if test="${!empty planRecorders}">
										<c:forEach items="${planRecorders}" var="entry">
											<tr>
												<td><c:if test="${entry.planStatus==0}"><input type="radio" name="recorder" value="${entry.monPrecId}"/></c:if></td><td>${entry.jcType}</td><td>${entry.jcNum}</td><td>${entry.fixFreque}</td><td>${entry.runKilo}</td><td>${entry.totalRunKilo}</td><td>${entry.planFixDate}</td><td><c:if test="${entry.planStatus==-1}">作废</c:if><c:if test="${entry.planStatus==0}">预编</c:if><c:if test="${entry.planStatus==1}">待审核</c:if><c:if test="${entry.planStatus==2}">审核</c:if><c:if test="${entry.planStatus==3}">发布</c:if><c:if test="${entry.planStatus==4}">改期</c:if><c:if test="${entry.planStatus==5}">补充</c:if><c:if test="${entry.planStatus==6}">实施</c:if></td>
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
			$(function(){
				top.Dialog.close();
				
				$('#month').bind("click", function() {
					createDialog(1);
				})
				
				$('#halfmoon').bind("click", function() {
					createDialog(2);
				})
				
				$('#tendays').bind("click", function() {
					createDialog(3);
				})
				
				$('#plandelete').bind("click", function() {
					var planid = $("input[name='plan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						top.Dialog.confirm('确认要删除该月计划吗？',function(){location.href='<%=basePath%>planManage!deleteMonPlanPriConfirm.action?id='+planid});
					} else {
						top.Dialog.alert("请选择要删除的月计划！");
						return false;
					}
				})
				
				$('#savetraintoplan').bind("click", function() {
					var planid = $("input[name='plan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						var trains = "";
						$("input[name=train]").each(function(){
							if($(this).attr("checked") && $(this).attr("id")!='all'){
								trains+=$(this).val()+",";
							}
						})
						if (trains!="") {
							top.Dialog.confirm('确认要保存选择的机车到该月计划吗？',function(){location.href='<%=basePath%>planManage!monPlanAddOverHaulTrain.action?id='+planid+'&trains='+trains.substr(0,trains.length);});
							
						} else {
							top.Dialog.alert("请选择要保存月计划对应的检修机车！");
							return false;
						}
					} else {
						top.Dialog.alert("请选择要保存检修机车对应的月计划！");
						return false;
					}
				})
				
				$('#modifyrecorder').bind("click", function() {
					var recorderid = $("input[name='recorder']").filter("[checked=true]").val();
					if (typeof(recorderid) != 'undefined') {
						var diag = new top.Dialog();
						diag.Title = "月计划检修机车修改窗口";
						diag.URL = "<%=basePath%>planManage!modifyMonPlanRecorderInput.action?id="+recorderid;
						diag.Width=480;
						diag.Height=320;
						diag.show();
					} else {
						top.Dialog.alert("请选择要修改的检修机车记录！");
						return false;
					}
					
				})
				
				$('#deleterecorder').bind("click", function() {
					var planid = $("input[name='recorder']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						top.Dialog.confirm('确认要删除该月计划机车检修记录吗？',function(){location.href='<%=basePath%>planManage!deleteMonPlanRecorderConfirm.action?id='+planid});
					} else {
						top.Dialog.alert("请选择要删除的机车检修记录！");
						return false;
					}
				})
				
				$('#submitaudit').bind("click", function() {
					var planid = $("input[name='plan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						top.Dialog.confirm('确认要提交该月计划审核吗？',function(){location.href='<%=basePath%>planManage!submitAuditMonPlanPri.action?id='+planid});
					} else {
						top.Dialog.alert("请选择要提交审核的月计划！");
						return false;
					}
				})
				
				$('#officialissue').bind("click", function() {
					var planid = $("input[name='plan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						top.Dialog.confirm('确认要正式发布该月计划吗？',function(){location.href='<%=basePath%>planManage!officialIssueMonPlanPri.action?id='+planid});
					} else {
						top.Dialog.alert("请选择要正式发布的月计划！");
						return false;
					}
				})
				
				function createDialog(flat) {
					var diag = new top.Dialog();
					if (flat == 1) {
						diag.Title = "月计划制定窗口";
						diag.URL = "<%=basePath%>planManage!monthPlanMakeInput.action?type=0";
					} else if (flat == 2) {
						diag.Title = "半月计划制定窗口";
						diag.URL = "<%=basePath%>planManage!monthPlanMakeInput.action?type=1";
					} else if (flat == 3) {
						diag.Title = "旬计划制定窗口";
						diag.URL = "<%=basePath%>planManage!monthPlanMakeInput.action?type=2";
					}
					diag.Width=380;
					diag.Height=220;
					diag.show();
				}
				
				<c:if test="${!empty message}">
					top.Dialog.alert("${message}");
				</c:if>
			});
			function findMonPlanRecorderByMonPlanId() {
				var planid = $("input[name='plan']").filter("[checked=true]").val();
				if (typeof(planid) != 'undefined') {
					location.href='<%=basePath%>planManage!monthPlanMake.action?id='+planid;
				}
			}
		</script>
	</body>
</html>
