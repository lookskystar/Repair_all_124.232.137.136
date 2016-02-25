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
		<title>日计划制定</title>
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
				<td width="80%" valign="top">
					<div>
						<fieldset>
							<legend>
								日计划扣车
							</legend>
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left10">
												<%--
												<a href="javascript:;" id="detaining">
												 --%>
												<a href="javascript:void(0);" onclick="javascript:goUrl('<%=basePath%>report/kc_main.jsp');return false;">
												<span class="icon_add">扣车
												</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="modifydailyplan"><span class="icon_edit">修改</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="deletedailyplan"><span class="icon_delete">删除</span>
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
										<th>编号</th><th>机车型号</th><th>机车编号</th><th>修程修次</th><th>股道</th><th>台位</th><th>扣车时间</th><th>起机时间</th><th>交车时间</th><th>交车工长</th><th>检修节点</th><th>状态</th>
									</tr>
									<c:if test="${!empty datePlanPris}">
										<c:forEach items="${datePlanPris}" var="entry">
											<tr align="center">
												<input type="hidden" id="p${entry.rjhmId }" value="${entry.fixFreque}"/>
												<td><c:if test="${entry.planStatue==-1}"><input type="radio" name="dailyplan" value="${entry.rjhmId }" <c:if test="${entry.rjhmId == id}">checked</c:if> onclick="predict(this)"/></c:if></td><td>${entry.jcType }</td><td>${entry.jcnum }</td><td>${entry.fixFreque }</td><td>${entry.gdh }</td><td>${entry.twh }</td><td>${entry.kcsj }</td><td>${entry.jhqjsj }</td><td>${entry.jhjcsj }</td><td>${entry.gongZhang.xm }</td><td>${entry.nodeid.nodeName }</td><td><c:if test="${entry.planStatue==-1}">新建</c:if><c:if test="${entry.planStatue==0}">在修</c:if></td>
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
								检修内容
							</legend>
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left10">
												<a href="javascript:;" id="addcontent"><span class="icon_add">添加</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="deletecontent"><span class="icon_delete">删除</span>
												</a>
												<div class="clear"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="clear"></div>
							</div>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 407px;">
								<table class="tableStyle" useCheckBox="false" id="content">
									<tr>
										<th width="30"></th><th>检修内容</th>
									</tr>
									<c:if test="${!empty preDicts}">
										<c:forEach items="${preDicts}" var="entry">
											<tr>
												<td><c:if test="${empty entry.proTeamId}"><input type="checkbox" value="${entry.preDictId}"/></c:if></td><td>${entry.repsituation}</td>
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
			function goUrl(url){
			     window.location.href=url;
			};
			$(function() {
				top.Dialog.close();
				<%--
				$('#detaining').bind("click", function() {
					
					var diag = new top.Dialog();
					diag.Title = "日计划制定窗口";
					diag.URL = "planManage!addDailyPlanInput.action";
					diag.Width=450;
					diag.Height=405;
					diag.show();
					windows.location.href="report/kc_main.jsp";
				});
				--%>
				
				$('#modifydailyplan').bind("click", function(){
					var planid = $("input[name='dailyplan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						var diag = new top.Dialog();
						diag.Title = "日计划检修机车修改窗口";
						diag.URL = "<%=basePath%>planManage!modifyDailyPlanInput.action?id="+planid;
						diag.Width=420;
						diag.Height=405;
						diag.show();
					} else {
						top.Dialog.alert("请选择要修改的检修机车记录！");
						return false;
					}
				});
				
				$('#deletedailyplan').bind("click", function() {
					var planid = $("input[name='dailyplan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						top.Dialog.confirm('确认要删除该日计划？',function(){location.href='<%=basePath%>planManage!deleteDailyPlanConfirm.action?id='+planid});
					} else {
						top.Dialog.alert("请选择要删除的日计划！");
						return false;
					}
				});
				
				$('#addcontent').bind('click', function() {
					var planid = $("input[name='dailyplan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						var fixFreque = $('#p'+planid).val();
						if (fixFreque=="LX" || fixFreque=="JG") {
							var diag = new top.Dialog();
							diag.Title = "日计划检修内容添加窗口";
							diag.URL = "<%=basePath%>planManage!addOverhaulContentInput.action?id="+planid;
							diag.Width=450;
							diag.Height=430;
							diag.show();
						} else {
							top.Dialog.alert("不属于临修加改，不需要填写检修内容！");
							return false;
						}
					} else {
						top.Dialog.alert("请选择要添加检修内容的日计划！");
						return false;
					}
				});
				
				$('#deletecontent').bind("click", function() {
					var planid = $("input[name='dailyplan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						var ids = "";
						$('#content input[type=checkbox]').each(function() {
							if($(this).attr("checked")){
								ids += $(this).val()+",";
							}
						})
						if (ids != "") {
							top.Dialog.confirm('确认要删除该日计划检修内容吗？',function(){location.href='<%=basePath%>planManage!deleteOverhaulContentConfirm.action?id='+planid+'&trains='+ids.substr(0,ids.length);});
						} else {
							top.Dialog.alert("请选择要删除的检修内容！");
						}
					} else {
						top.Dialog.alert("请选择日计划！");
						return false;
					}
				});
				
				<c:if test="${!empty message}">
					top.Dialog.alert('${message}');
				</c:if>
			});
			
			function predict(obj) {
				location.href='<%=basePath%>planManage!dailyPlanMake.action?id='+obj.value
			}
		</script>
	</body>
</html>
