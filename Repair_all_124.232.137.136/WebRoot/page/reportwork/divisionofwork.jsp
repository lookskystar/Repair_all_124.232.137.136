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
	<base href="<%=basePath%>" />
	<title>报活分工</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->
	<body>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="80%" valign="top">					
					<div>
						<fieldset>
							<legend>
								功能面板
							</legend>
							<button id="saveDivision">
								<span class="icon_save">保存分工</span>
							</button>
							<button id="deleteDivision">
								<span class="icon_cut">取消分工</span>
							</button>
							<c:if test="${role=='dispatcher'}">
								<button id="cancleDivision">
									<span class="icon_delete">作废报活</span>
								</button>
							</c:if>
						</fieldset>
					</div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="30%" valign="top">
								<fieldset style="height: 458px;">
									<legend>
										报活列表
									</legend>
									<div id="yushe" style="line-height: 150%;position: relative;z-index: 0; overflow-x: hidden; overflow-y: auto; height: 426px;" >
										<table class="tableStyle" id="radioTable" useRadio="false" useCheckBox="false">
											<tr align="center">
												<th width="2%"></th>
												<th>
													故障位置
												</th>
												<th>
													报活内容
												</th>
												<th>
													报活人
												</th>
												<th>
													报活时间
												</th>
												<c:if test="${role=='foreman'}">
													<th>
														检修人
													</th>
												</c:if>
												<c:if test="${role=='dispatcher'}">
													<th>
														班组
													</th>
													<th>
														技术员卡控
													</th>
													<th>
														质检员卡控
													</th>
													<th>
														交车工长卡控
													</th>
													<th>
														验收员卡控
													</th>
												</c:if>
											</tr>
											<c:if test="${!empty jtPreDicts}">
												<c:forEach var="entry" items="${jtPreDicts}">
													<tr align="center">
														<td width="25">
															<input type="checkbox" name="check" value="${entry.preDictId}" />
														</td>
														<td>
															${entry.repPosi}
														</td>
														<td>
															${entry.repsituation}
														</td>
														<td>
															${entry.repemp}
														</td>
														<td>
															${entry.repTime}
														</td>
														<c:if test="${role=='foreman'}">
															<td>
															  <c:if test="${empty entry.fixEmp||entry.fixEmp==''}">
															    <font color='red'>未分工</font>
															  </c:if>
																${entry.fixEmp}
															</td>
														</c:if>
														<c:if test="${role=='dispatcher'}">
															<td id="${entry.preDictId}_bz">
																${fn:substring(entry.smBzNames,0,fn:length(entry.smBzNames)-1)}
															</td>
															<td>
																<c:choose>
																	<c:when test="${entry.itemCtrlTech==1}">
																		是
																	</c:when>
																	<c:otherwise>
																		否
																	</c:otherwise>
																</c:choose>
															</td>
															<td>
																<c:choose>
																	<c:when test="${entry.itemCtrlQI==1}">
																		是
																	</c:when>
																	<c:otherwise>
																		否
																	</c:otherwise>
																</c:choose>
															</td>
															<td>
																<c:choose>
																	<c:when test="${entry.itemCtrlComLd==1}">
																		是
																	</c:when>
																	<c:otherwise>
																		否
																	</c:otherwise>
																</c:choose>
															</td>
															<td>
																<c:choose>
																	<c:when test="${entry.itemCtrlAcce==1}">
																		是
																	</c:when>
																	<c:otherwise>
																		否
																	</c:otherwise>
																</c:choose>
															</td>
														</c:if>
														
													</tr>
												</c:forEach>
											</c:if>
										</table>
									</div>
								</fieldset>
							</td>
						</tr>
					</table>
				</td>
				<td></td>
				<td width="19%" valign="top">
					<c:if test="${role=='foreman'}">
						<div>
							<fieldset>
								<legend>
									班组成员
								</legend>
								<div style="line-height: 150%;position: relative;z-index: 0;overflow-y: auto; height: 520px;" >
									<table class="tableStyle" id="banzu"  useMultColor="true" useCheckBox="false">
										<tr>
											<th width=25>
											</th>
											<th width="80">
												姓名
											</th>
											<th width="80">
												工号
											</th>
										</tr>
										<c:forEach var="user" items="${usersPrivs}">
											<tr align="center">
												<td width="28">
													<input type="checkbox" value="${user.userid}" />
												</td>
												<td width="118">
													${user.xm }
												</td>
												<td width="80">
													${user.gonghao}
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</fieldset>
						</div>
					</c:if>
					<c:if test="${role=='dispatcher'}">
						<div>
							<fieldset>
								<legend>
									班组
								</legend>
								<div style="line-height: 150%;position: relative;z-index: 0;overflow-y: auto; height: 520px;" >
									<table class="tableStyle" id="banzu"  useMultColor="true" useCheckBox="false">
										<tr>
											<th width=25>
											</th>
											<th>
												名称
											</th>
										</tr>
										<c:forEach var="entry" items="${dictProTeams}">
											<tr align="center">
												<td>
													<input type="checkbox" value="${entry.proteamid}" name="BZList"/>
												</td>
												<td>
													${entry.proteamname }
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
							</fieldset>
						</div>
					</c:if>
				</td>
			</tr>
		</table>
		<script type="text/javascript">
			$('#saveDivision').bind('click', function() {
				var opts = $("#radioTable input[name='check']:checked");
				
				if (opts.length>0) {
					var works=[];
					for(var i = 0, len = opts.length; i < len; i++) {
						works.push($(opts[i]).val());
						<c:if test="${role=='dispatcher'}">
							if($("#"+$(opts[i]).val()+"_bz").html()!=""){
								top.Dialog.alert("请先取消分工！");
								return ;
							}
						</c:if>
					}
					var work=works.join(",");
					<c:if test="${role=='foreman'}">
						var selects = $('#banzu input[type=checkbox]:checked');
						if (selects.length>0) {
							var users = [];
							for(var i = 0, len = selects.length; i < len; i++) {
								users.push($(selects[i]).val());
							}
							location.href='reportWorkManage!distributionConfirm.action?id='+work+'&role=${role}&params='+users.join(",");
						} else {
							top.Dialog.alert("请选择要派工的班组成员！");
							return ;
						}
					</c:if>
					<c:if test="${role=='dispatcher'}">
						var selects = $('#banzu input[type=checkbox]:checked');
						if(selects.length>0){
							var users = [];
							for(var i = 0, len = selects.length; i < len; i++) {
								users.push($(selects[i]).val());
							}
						}else{
							top.Dialog.alert("请选择要派工的班组成员");
							return ;
						}
						var diag = new top.Dialog();
						diag.Title = "报活派工窗口";
						diag.URL = 'reportWorkManage!distributionDispatchingInput.action?id='+work+'&rjhmId=${rjhmId}&role=${role}&params='+users.join(",");
						diag.Width=420;
						diag.Height=320;
						diag.show();
					</c:if>
				} else {
					top.Dialog.alert("请选择要派工的报活！");
				}
			});
			$('#deleteDivision').bind('click', function() {
				var opts = $("#radioTable input[name='check']:checked");
				if (opts.length>0) {
					var works=[];
					for(var i = 0, len = opts.length; i < len; i++) {
						works.push($(opts[i]).val());
					}
					var work=works.join(",");
					<c:if test="${role=='foreman'}">
						top.Dialog.confirm('确认要取消该报活的派工吗？',function(){location.href='reportWorkManage!deleteDistributionConfirm.action?id='+work+'&role=${role}';});
					</c:if>
					<c:if test="${role=='dispatcher'}">
						top.Dialog.confirm('确认要取消该报活的派工吗？',function(){top.frames[4].location.href='reportWorkManage!distributionCancelConfirm.action?id='+work+'&role=${role}';});
					</c:if>
				} else {
					top.Dialog.alert("请选择要取消派工的报活！");
				}
			});
			$('#cancleDivision').bind('click', function() {
				var opts = $("#radioTable input[name='check']:checked");
				if (opts.length>0) {
					var works=[];
					for(var i = 0, len = opts.length; i < len; i++) {
						works.push($(opts[i]).val());
					}
					var work=works.join(",");
					<c:if test="${role=='dispatcher'}">
						top.Dialog.confirm('确认要作废该报活的派工吗？',function(){top.frames[4].location.href='reportWorkManage!abolishJtPreDictOfAbolish.action?id='+work+'&role=${role}';});
					</c:if>
				} else {
					top.Dialog.alert("请选择要作废的报活！");
				}
			});
			<c:if test="${!empty message}">
				top.Dialog.alert('${message}');
			</c:if>
		</script>
	</body>
</html>