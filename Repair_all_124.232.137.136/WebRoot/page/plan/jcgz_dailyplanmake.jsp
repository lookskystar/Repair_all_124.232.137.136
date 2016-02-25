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
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="dispatching"><span class="icon_ok">派工</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="modifydispatching"><span class="icon_edit">取消派工</span>
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
										<th width="30"></th><th>检修内容</th><th>班组</th>
									</tr>
									<c:if test="${!empty preDicts}">
										<c:forEach items="${preDicts}" var="entry">
											<tr>
												<td><input type="checkbox" value="${entry.preDictId}"/></td><td>${entry.repsituation}</td><td align="center" id="bzs_${entry.preDictId}">${entry.smBzNames}</td>
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
				
				$('#addcontent').bind('click', function() {
						var planid = '${id}';
						var diag = new top.Dialog();
						diag.Title = "日计划检修内容添加窗口";
						diag.URL = "<%=basePath%>planManage!jcgzAddOverhaulContentInput.action?id="+planid;
						diag.Width=450;
						diag.Height=430;
						diag.show();
					});
				
				$('#deletecontent').bind("click", function() {
						var planid ='${id}';
						var ids = "";
						$('#content input[type=checkbox]').each(function() {
							if($(this).attr("checked")){
								ids += $(this).val()+",";
							}
						})
						if (ids != "") {
							top.Dialog.confirm('确认要删除该日计划检修内容吗？',function(){location.href='<%=basePath%>planManage!deleteJcgzOverhaulContentConfirm.action?id='+planid+'&trains='+ids.substr(0,ids.length);});
						} else {
							top.Dialog.alert("请选择要删除的检修内容！");
						}
					});
					
				$('#dispatching').bind('click', function() {
					var planid = '${id}';
					if (typeof(planid) != 'undefined') {
						var ids = "";
						$('#content input[type=checkbox]').each(function() {
							if($(this).attr("checked")){
								ids += $(this).val()+",";
							}
						})
						if (ids != "") {
							var opts=ids.substr(0,ids.length-1);
							var array=opts.split(",");
							var flag=0;
							for(var i=0;i<array.length;i++){
								if($("#bzs_"+array[i]).text()!=""){
									flag=1;
									break;
								}
							}
							if(flag==0){
								var diag = new top.Dialog();
								diag.Title = "检修内容派工窗口";
								diag.URL = '<%=basePath%>pdiFroemanManage!dispatchingInput.action?id='+planid+'&type=0&ids='+ids.substr(0,ids.length-1);
								diag.Width=420;
								diag.Height=320;
								diag.show();
							}else{
								top.Dialog.alert("存在班组已分工，请取消后派工！");
							}
						} else {
							top.Dialog.alert("请选择要派工的检修内容！");
						}
					} else {
						top.Dialog.alert("请选择日计划！");
						return false;
					}
				});
				
				$('#modifydispatching').bind('click', function() {
					var planid =  '${id}';
					if (typeof(planid) != 'undefined') {
						var preDictId = [];
						$("#content input[type=checkbox]:checked").each(function(){
							preDictId.push($(this).val());
						});
						if (preDictId.length>0) {
							top.Dialog.confirm("确认要取消派工?",function(){
								var preDictIds=preDictId.join(',');
								$.post("<%=basePath%>pdiFroemanManage!ajaxDispatchingDelete.action",{"ids":preDictIds},function(text){
									if(text=="success"){
										top.Dialog.alert("取消成功！",function(){
											window.location.href="<%=basePath%>planManage!jcgzDailyPlanMake.do?id="+planid;
										});
									}else if(text=="no_cancle"){
										top.Dialog.alert("班组已分工或已完成，不能取消！");
									}else if(text=="no_user"){
										top.Dialog.alert("派工取消失败，用户登录失效！");
									}else{
										top.Dialog.alert("取消失败！");
									}
								});
							});
						} else {
							top.Dialog.alert("请选择要修改的检修内容！");
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
