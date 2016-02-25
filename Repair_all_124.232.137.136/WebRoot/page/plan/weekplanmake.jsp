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
		<title>周计划制定</title>
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
								周计划
							</legend>
						<c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',DSJS,')}">
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left10">
												<a href="javascript:;" id="weekplan"><span class="icon_add">周计划</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="savetraintoplan"><span class="icon_save">保存</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="plandelete"><span class="icon_delete">删除</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="officialissue"><span class="icon_ok">正式发布</span>
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
									<tr align="center">
										<th>编号</th><th>月计划</th><th>计划月份</th><th>计划类型</th><th>编制人</th><th>编制时间</th><th>状态</th>
									</tr>
									<c:if test="${!empty weekPlanPris}">
										<c:forEach items="${weekPlanPris}" var="entry">
											<tr align="center">
												<td><input type="radio" name="week" value="${entry.weekPriId}" <c:if test="${otherId==entry.weekPriId}">checked</c:if> onclick="findWeekPlanRecorderByWeekPlanId()"/></td><td><c:set var="planType" value="${entry.monPlanId.planType}"/>${entry.monPlanId.planTime}(<c:if test="${planType==0}">月计划</c:if><c:if test="${planType==1}">半月计划</c:if><c:if test="${planType==2}">旬计划</c:if>)</td><td>${entry.planDate}</td><td><c:if test="${entry.planType==0}">第一周计划</c:if><c:if test="${entry.planType==1}">第二周计划</c:if><c:if test="${entry.planType==2}">第三周计划</c:if><c:if test="${entry.planType==3}">第四周计划</c:if></td><td>${entry.fmtpeo.xm}</td><td>${entry.fmtDate}</td><td><c:if test="${entry.status==-1}">作废</c:if><c:if test="${entry.status==0}">预编</c:if><c:if test="${entry.status==1}">发布</c:if><c:if test="${entry.status==2}">完成</c:if></td>
											</tr>
										</c:forEach>
									</c:if>
									
								</table>
							</div>
						</fieldset>
					</div>
				</td>
				<td valign="top">
					<div>
						<fieldset>
							<legend>
								月计划
							</legend>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 191px;">
								<table class="tableStyle" useRadio="false" id="monthplan">
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
			</tr>
			<tr>
				<td valign="top">
					<div>
						<fieldset>
							<legend>
								周计划检修机车
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
									<c:if test="${!empty weekPlanRecorders}">
										<c:forEach items="${weekPlanRecorders}" var="entry">
											<tr>
												<%--
												<td><c:if test="${entry.planStatus==0}"><input type="radio" name="recorder" value="${entry.wekPrecId}"/></c:if></td><td>${entry.jcType}</td><td>${entry.jcNum}</td><td>${entry.fixFreque}</td><td>${entry.runKilo}</td><td>${entry.totalRunKilo}</td><td>${entry.planFixDate}</td><td><c:if test="${entry.planStatus==-1}">作废</c:if><c:if test="${entry.planStatus==0}">预编</c:if><c:if test="${entry.planStatus==1}">发布</c:if><c:if test="${entry.planStatus==2}">改期</c:if><c:if test="${entry.planStatus==3}">补充</c:if><c:if test="${entry.planStatus==4}">实施</c:if><c:if test="${entry.planStatus==5}">完成</c:if></td>
												 --%>
												 <td><input type="radio" name="recorder" value="${entry.wekPrecId}"/></td><td>${entry.jcType}</td><td>${entry.jcNum}</td><td>${entry.fixFreque}</td><td>${entry.runKilo}</td><td>${entry.totalRunKilo}</td><td>${entry.planFixDate}</td><td><c:if test="${entry.planStatus==-1}">作废</c:if><c:if test="${entry.planStatus==0}">预编</c:if><c:if test="${entry.planStatus==1}">发布</c:if><c:if test="${entry.planStatus==2}">改期</c:if><c:if test="${entry.planStatus==3}">补充</c:if><c:if test="${entry.planStatus==4}">实施</c:if><c:if test="${entry.planStatus==5}">完成</c:if></td>
											</tr>
										</c:forEach>
									</c:if>
									
								</table>
							</div>
						</fieldset>
					</div>
				</td>
				<td valign="top">
					<div>
						<fieldset>
							<legend>
								当月计划检修机车
							</legend>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 191px;">
								<table class="tableStyle" useCheckBox="false" id="trains">
									<tr>
										<th>编号</th><th>机车类型</th><th>机车编号</th><th>修程修次</th><th>修程走行公里</th><th>总走行公里</th><th>计划扣车时间</th><th>状态</th>
									</tr>
									<c:if test="${!empty planRecorders}">
										<c:forEach items="${planRecorders}" var="entry">
											<tr>
												<td><c:if test="${entry.planStatus==3}"><input type="checkbox" name="recorder" value="${entry.monPrecId}"/></c:if></td><td>${entry.jcType}</td><td>${entry.jcNum}</td><td>${entry.fixFreque}</td><td>${entry.runKilo}</td><td>${entry.totalRunKilo}</td><td>${entry.planFixDate}</td><td><c:if test="${entry.planStatus==-1}">作废</c:if><c:if test="${entry.planStatus==0}">预编</c:if><c:if test="${entry.planStatus==1}">待审核</c:if><c:if test="${entry.planStatus==2}">审核</c:if><c:if test="${entry.planStatus==3}">发布</c:if><c:if test="${entry.planStatus==4}">改期</c:if><c:if test="${entry.planStatus==5}">补充</c:if><c:if test="${entry.planStatus==6}">实施</c:if></td>
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
					location.href='planManage!weekPlanMake.action?id='+planid;
				}
			}
			function findWeekPlanRecorderByWeekPlanId() {
				var planid = $("input[name='week']").filter("[checked=true]").val();
				if (typeof(planid) != 'undefined') {
					location.href='planManage!weekPlanMake.action?otherId='+planid;
				}
			}
			
			$(function() {
				top.Dialog.close();
				
				$('#plandelete').bind("click", function() {
					var planid = $("input[name='week']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						top.Dialog.confirm('确认要删除该周计划吗？',function(){location.href='planManage!deleteWeekPlanConfirm.action?id='+planid});
					} else {
						top.Dialog.alert("请选择要删除的周计划！");
						return false;
					}
				})
				
				$('#weekplan').bind("click", function() {
					var planid = $('#monthplan input[type=radio]:checked').val();
				console.log(planid);
					var diag = new top.Dialog();
					diag.Title = "周计划制定窗口";
					if (typeof(planid) == 'undefined') {
						diag.URL = "planManage!weekPlanMakeInput.action";
					} else {
						diag.URL = "planManage!weekPlanMakeInput.action?id="+planid;
					}
					diag.Width=380;
					diag.Height=240;
					diag.show();
				})
				
				$('#savetraintoplan').bind('click', function() {
					var weekid = $("input[name='week']").filter("[checked=true]").val();
					if (typeof(weekid) != 'undefined') {
						var trains = "";
						$("#trains input[type=checkbox]").each(function(){
							if($(this).attr("checked")){
								trains+=$(this).val()+",";
							}
						})
						if (trains!="") {
							top.Dialog.confirm('确认要保存选择的机车到该周计划吗？',function(){location.href='planManage!weekPlanAddOverHaulTrain.action?id='+weekid+'&trains='+trains.substr(0,trains.length);});
							
						} else {
							top.Dialog.alert("请选择要保存周计划对应的检修机车！");
							return false;
						}
					} else {
						top.Dialog.alert("请选择要保存检修机车对应的周计划！");
						return false;
					}
				});
				
				$('#officialissue').bind("click", function() {
					var planid = $("input[name='week']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						top.Dialog.confirm('确认要正式发布该周计划吗？',function(){location.href='planManage!officialIssueWeekPlanPri.action?id='+planid});
					} else {
						top.Dialog.alert("请选择要正式发布的周计划！");
						return false;
					}
				})
				
				$('#modifyrecorder').bind("click", function() {
					var recorderid = $("input[name='recorder']").filter("[checked=true]").val();
					if (typeof(recorderid) != 'undefined') {
						var diag = new top.Dialog();
						diag.Title = "周计划检修机车修改窗口";
						diag.URL = "<%=basePath%>planManage!modifyWeekPlanRecorderInput.action?id="+recorderid;
						diag.Width=480;
						diag.Height=320;
						diag.show();
					} else {
						top.Dialog.alert("请选择要修改的检修机车记录！");
						return false;
					}
					
				})
				
				$('#deleterecorder').bind("click", function() {
					var recorderid = $("input[name='recorder']").filter("[checked=true]").val();
					if (typeof(recorderid) != 'undefined') {
						top.Dialog.confirm('确认要删除该周计划机车检修记录吗？',function(){location.href='planManage!deleteWeekPlanRecorderConfirm.action?id='+recorderid});
					} else {
						top.Dialog.alert("请选择要删除的机车检修记录！");
						return false;
					}
				});
				
				<c:if test="${!empty message}">
					top.Dialog.alert("${message}");
				</c:if>
			});
		</script>
	</body>
</html>
