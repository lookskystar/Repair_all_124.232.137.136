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
		<title>日计划交车工长签字</title>
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
				<td width="70%" valign="top">
					<div>
						<fieldset>
							<legend>
								日计划签认
							</legend>
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left10">
												<a href="javascript:;" id="sign"><span class="icon_ok">签字</span>
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
												<td><input type="radio" name="dailyplan" value="${entry.rjhmId }" <c:if test="${entry.rjhmId == id}">checked</c:if> onclick="predict(this)"/></td><td>${entry.jcType }</td><td>${entry.jcnum }</td><td>${entry.fixFreque }</td><td>${entry.gdh }</td><td>${entry.twh }</td><td>${entry.kcsj }</td><td>${entry.jhqjsj }</td><td>${entry.jhjcsj }</td><td>${entry.gongZhang.xm }</td><td>${entry.nodeid.nodeName }</td><td><c:if test="${entry.planStatue==-1}">新建</c:if><c:if test="${entry.planStatue==0}">在修</c:if></td>
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
								分工项目
							</legend>
							<div class="box_tool_min padding_top2 padding_bottom2 padding_right5">
								<div class="center">
									<div class="left">
										<div class="right">
											<div class="padding_top5 padding_left10">
												<a href="javascript:;" id="dispatching"><span class="icon_ok">派工</span>
												</a>
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="modifydispatching"><span class="icon_edit">取消</span>
												</a>
												<div class="clear"></div>
												<!-- 
												<div class="box_tool_line"></div>
												<a href="javascript:;" id="deletedispatching"><span class="icon_delete">删除</span>
												</a>
												<div class="clear"></div>
												 -->
											</div>
										</div>
									</div>
								</div>
								<div class="clear"></div>
							</div>
							<div style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 407px;">
								<table class="tableStyle" useCheckBox="false" id="content">
									<tr align="center">
										<th width="30"></th><th>检修内容</th><th>班组</th>
									</tr>
									<c:if test="${!empty preDicts}">
										<c:forEach items="${preDicts}" var="entry">
											<tr>
												<td name="checkboxs"><input type="checkbox" value="${entry.preDictId}"/></td><td name="contents" align="center">${entry.repsituation}</td><td align="center" id="bzs_${entry.preDictId}">${entry.smBzNames}</td>
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
//			jQuery.fn.rowspan = function(colIdx) {
//				var beforeColIdx = colIdx-1;
//				var flag = false;
//	            this.each(function() {
//	                var that;
//	                $('tr', this).each(function(row) {
//	                    $('td:eq(' + colIdx + ')', this).filter(':visible').each(function(col) {
//	                        if (that != null && $(this).html() == $(that).html()) {
//	                        	flag = true;
//	                            rowspan = $(that).attr("rowSpan");
//	                            if (rowspan == undefined) {
//	                                $(that).attr("rowSpan", 1);
//	                                rowspan = $(that).attr("rowSpan");
//	                            }
//	                            rowspan = Number(rowspan) + 1;
//	                            $(that).attr("rowSpan", rowspan);
//	                            $(this).hide();
//	                        } else {
//	                            that = this;
//	                        }
//	                    });
//	                });
//	            });
//	         }
	         
			//$(function(){
				//传入的参数是对应的列数从0开始，哪一列有相同的内容就输入对应的列数值
				//$("table").rowspan(0); 
            	//$("table").rowspan(1);
            	//$("table").rowspan(2);
			//});
			
			$(function() {
				top.Dialog.close();
				
				$('#sign').bind('click', function() {
					var planid = $("input[name='dailyplan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						var fixFreque = $('#p'+planid).val();
						if (fixFreque=="LX" || fixFreque=="JG") {
							top.Dialog.confirm('确认检修内容已经分工完成，进行日计划签认？',function(){location.href='pdiFroemanManage!datePlanSign.action?id='+planid});
						} else {
							top.Dialog.confirm('确认对该日计划签认？',function(){location.href='pdiFroemanManage!datePlanSign.action?id='+planid});
						}
						
					} else {
						top.Dialog.alert("请选择需要签字的日计划！");
						return false;
					}
				});
				
				$('#dispatching').bind('click', function() {
					var planid = $("input[name='dailyplan']").filter("[checked=true]").val();
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
					var planid = $("input[name='dailyplan']").filter("[checked=true]").val();
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
											window.location.href="<%=basePath%>pdiFroemanManage!findDatePlanBySign.action?id="+planid;
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
				
				$('#deletedispatching').bind('click', function() {
					var planid = $("input[name='dailyplan']").filter("[checked=true]").val();
					if (typeof(planid) != 'undefined') {
						var ids = "";
						$('#content input[type=checkbox]').each(function() {
							if($(this).attr("checked")){
								ids += $(this).val()+",";
							}
						})
						if (ids != "") {
							$.post("<%=basePath%>pdiFroemanManage!ajaxDispatchingDelete.action",{"id":planid,"ids":ids.substr(0,ids.length)},function(text){
								if(text=="failure"){
									top.Dialog.alert("删除失败！");
									return false;
									
								}else{
									top.Dialog.alert("删除成功！");
									$('#content input[type=checkbox]').each(function() {
										if($(this).attr("checked")){
											$(this).closest('tr').remove();
										}
									})
								}
							});
						}else {
							top.Dialog.alert("请选择要修改的检修内容！");
						}
					}else {
						top.Dialog.alert("请选择日计划！");
						return false;
					}
				});
				
				<c:if test="${!empty message}">
					top.Dialog.alert('${message}');
				</c:if>
			});
			function predict(obj) {
				location.href='<%=basePath%>pdiFroemanManage!findDatePlanBySign.action?id='+obj.value;
			}
		</script>
	</body>
</html>
