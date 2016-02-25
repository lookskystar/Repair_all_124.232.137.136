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
<head>
<title>报活信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<Script type="text/javascript" src="js/jquery.form.js"></Script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
<!--框架必需end-->
<!--文本截取start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--文本截取end-->
</head>

<body>
		<div class="box_tool_mid padding_top5 padding_right5" overflow="auto" panelHeight="410">
			<div class="center">
			<div class="left">
			<div class="right">
				<div class="padding_top8 padding_left10">
				<table>
					<tr>
						<td valign="top">机车计划：</td>
						<td valign="top" style="position: static;">
							<select autoWidth="true" style="width: 150px;" id="dateplan">
								<option value="">请选择</option>
								<c:if test="${!empty datePlanPris}">
									<c:forEach items="${datePlanPris}" var="entry">
									     <c:if test="${entry.fixFreque!='LX'||entry.fixFreque!='JG'||entry.fixFreque!='QZ'||entry.fixFreque!='CJ'}">
											<option value="${entry.rjhmId }-${entry.jcType }" <c:if test="${entry.rjhmId==id}">selected</c:if>>${entry.jcType }-${entry.jcnum }-${entry.fixFreque }</option>
										 </c:if>
									</c:forEach>
								</c:if>
							</select>
						</td>
						<td valign="top">
							<button id="reportselect"><span class="icon_find">查询</span></button>
							&nbsp;&nbsp;&nbsp;&nbsp;<button id="newreport"><span class="icon_add">报活</span></button>
						</td>
					</tr>
				</table>
				</div>			
			</div>		
			</div>	
			</div>
			<div class="clear"></div>
		</div>
		<div style="height: 3px;"></div>
		<table width="100%" class="tableStyle">
			<tr align="center">
			    <th class="ver01">
					类型
				</th>
				<th class="ver01">
					故障情况
				</th>
				<th class="ver01">
					报活人
				</th>
				<th class="ver01">
					报活时间
				</th>
				<th class="ver01">
					处理情况
				</th>
				<!-- 
				<th class="ver01">
					状态
				</th>-->
				<th class="ver01">
					操作
				</th> 
			</tr>
			<c:if test="${empty jtPreDicts}">
				<tr><td colspan="6" align="center">没有数据记录!</td></tr>
			</c:if>
			<c:if test="${!empty jtPreDicts}">
				<c:forEach items="${jtPreDicts}" var="entry">
						<tr align="center">
						    <td class="ver01">
								<c:if test="${entry.type==0}">
									JT28报活
								</c:if>
								<c:if test="${entry.type==1}">
									复检报活
								</c:if>
								<c:if test="${entry.type==2}">
									检修过程报活
								</c:if>
								<c:if test="${entry.type==6}">
									零公里报活
								</c:if>
							</td>
							<td class="ver01">
							    <c:choose>
			                        <c:when test="${!empty entry.repPosi}">
			                          ${entry.repPosi}--${entry.repsituation}
			                        </c:when>
			                        <c:otherwise>${entry.repsituation}</c:otherwise>
			                    </c:choose>
							</td>
							<td class="ver01">
								${entry.repemp}
							</td>
							<td class="ver01">
								${entry.repTime}
							</td>
							<td class="ver01">
								${entry.dealSituation}
							</td>
							<!-- <td class="ver01">
								<c:if test="${entry.recStas==-1}">
									审批未通过
								</c:if>
								<c:if test="${entry.recStas==0}">
									新报
								</c:if>
								<c:if test="${entry.recStas==1}">
									审批通过
								</c:if>
								<c:if test="${entry.recStas==2}">
									接收
								</c:if>
								<c:if test="${entry.recStas==3}">
									处理完成
								</c:if>
								<c:if test="${entry.recStas==4}">
									工长核验
								</c:if>
								<c:if test="${entry.recStas==5}">
									质检员、验收员等核验
								</c:if>
								<c:if test="${entry.recStas==9}">
									完成存档
								</c:if> 
							</td>-->
							<td class="ver01">
								<a href="javascript:;" onclick="return jtPreDictDatils(${entry.preDictId})">详细</a>&nbsp;&nbsp;
								<c:if test="${entry.repempNo==sessionScope.session_user.gonghao}">
									<c:if test="${entry.recStas<3}">
									    <a href="javascript:;" onclick="return jtPreDictUpdate(${entry.preDictId})">修改</a>&nbsp;&nbsp;
									    <a href="javascript:;" onclick="return jtPreDictDelete(${entry.preDictId})">删除</a>
									</c:if>
								</c:if>
							</td>
						</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>
	<script type="text/javascript">
		$(function() {
			if(top.Dialog!=null && top.Dialog!=undefined){
				top.Dialog.close();
			}
			$('#reportselect').bind('click', function(){
				var planid = $('#dateplan').val();
				if (planid != '') {
					var arrs = planid.split("-");
					location.href='reportWorkManage!reportWork.action?id='+arrs[0];
				} else {
					top.Dialog.alert("请选择机车计划！")
				}
			});
			
			$('#newreport').bind('click', function(){
				var planid = $('#dateplan').val();
				if (planid != '') {
					var arrs = planid.split("-");
					var diag = new top.Dialog();
					diag.Title = "报活操作窗口";
					diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+arrs[0]+'&type='+arrs[1];
					diag.Width=1000;
					diag.Height=520;
					diag.show();
				} else {
					top.Dialog.alert("请选择机车计划！")
				}
			});
			
			<c:if test="${!empty message}">
				top.Dialog.alert('${message}');
			</c:if>
		});

		function jtPreDictDatils(id) {
			var diag = new top.Dialog();
			diag.Title = "报活信息详细窗口";
			diag.URL = 'reportWorkManage!reportWorkDetail.action?id='+id;
			diag.Width=1124;
			diag.Height=480;
			diag.show();
			return false;
		}
		
		function jtPreDictDelete(id){
			top.Dialog.confirm("确认删除该报活记录?",function(){
				$.post("reportWorkManage!jtPreDictDelete.action",{"id":id},function(text){
					if(text=="success"){
						top.Dialog.alert("删除成功!",function(){
							window.location.href="reportWorkManage!reportWork.action?id=${id}";
						});
					}else{
						top.Dialog.alert("删除失败!");
					}
				});
			});
		}
		
		function jtPreDictUpdate(preDictId,jcType){
				var diag = new top.Dialog();
				diag.Title = "报活修改窗口";
				diag.URL = 'reportWorkManage!jtPreDictUpdateInput.action?preDictId='+preDictId+"&type=0";
				diag.Width=1000;
				diag.Height=520;
				diag.show();
		}
	</script>
</body>
</html>