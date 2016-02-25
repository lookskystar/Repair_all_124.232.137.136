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
	<title>机车检修月计划计划机车修改</title>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<script type="text/javascript" src="js/form/multiselect.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
	<!--框架必需end-->
	</head>
	
	<body>
		<div class="box1" panelHeight="410" whiteBg="true">
			<form action="<%=basePath%>planManage!modifyDailyPlanConfrim.action" method="post" target="jcmain" onsubmit="return submitValidate()">
				<input name="datePlan.rjhmId" type="hidden" value="${datePlan.rjhmId}" />
				<%-- 
				<input name="datePlan.jhjcsj" type="hidden" value="${datePlan.jhjcsj}" />
				<input name="datePlan.kcsj" type="hidden" value="${datePlan.kcsj}" />
				--%>
				<input name="datePlan.planStatue" type="hidden" value="${datePlan.planStatue}" />
				<input name="datePlan.zdr" type="hidden" value="${datePlan.zdr}" />
				<input name="datePlan.zdsj" type="hidden" value="${datePlan.zdsj}" />
				<input name="datePlan.nodeid.jcFlowId" type="hidden" value="${datePlan.nodeid.jcFlowId}" />
				<input name="datePlan.projectType" type="hidden" value="${datePlan.projectType}" />
				<input type="hidden" id="workTeam" name="datePlan.workTeam" value=""/>
				<table width="100%">
					<tr>
						<td width="40%">
							<div style="text-align: right; margin-right: 20px;">车型：</div>
						</td>
						<td>
							<input type="text" id="jcType" name="datePlan.jcType" value="${datePlan.jcType}"/>
							&nbsp;&nbsp;<input id="jccurriculum" type="button" value="选择" onclick="findJcCurriculum()"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">车号：</div>
						</td>
						<td>
							<input type="text" id="jcNum" name="datePlan.jcnum" value="${datePlan.jcnum}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">修程：</div>
						</td>
						<td>
							<input type="text" id="fixFreque" name="datePlan.fixFreque" value="${datePlan.fixFreque}"/>
							<input id="jcfixFreque" type="button" value="选择" onclick="findFixFreque()"/>&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">股道：</div>
						</td>
						<td>
							<input type="text" name="datePlan.gdh" value="${datePlan.gdh}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">台位：</div>
						</td>
						<td>
							<input type="text" name="datePlan.twh" value="${datePlan.twh}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划扣车时间：</div>
						</td>
						<td>
							<input type="text" class="Wdate" onfocus="WdatePicker()" name="datePlan.kcsj" style="width:120px" value="${datePlan.kcsj}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划起机时间：</div>
						</td>
						<td>
							<input type="text" class="Wdate" onfocus="WdatePicker()" name="datePlan.jhqjsj" style="width:120px" value="${datePlan.jhqjsj}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划交车时间：</div>
						</td>
						<td>
							<input type="text" class="Wdate" onfocus="WdatePicker()" name="datePlan.jhjcsj" style="width:120px" value="${datePlan.jhjcsj}"/>
						</td>
					</tr>
					<tr>
						<td><div style="text-align: right; margin-right: 20px;">备注: </div></td>
						<td>
						<textarea name="datePlan.comments" rows="4" cols="10">${datePlan.comments}</textarea>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">交车工长：</div>
						</td>
						<td>
							<select name="id" class="default">
								<option value="">请选择</option>
								<c:forEach var="entry" items="${users}">
									<option value="${entry.userid}" <c:if test="${datePlan.gongZhang.userid==entry.userid}">selected</c:if>>${entry.xm}</option>
								</c:forEach>
							</select>
							<font color="red">*可以不指定</font>
							<input type="checkbox" id="choiceProteam" onclick="showProTeam();" <c:if test="${!empty datePlan.proteamId}">checked="checked"</c:if>/>指定包修班组
						</td>
					</tr>
					<tr style="display: none;" id="showProteam">
						<td>
							<div style="text-align: right; margin-right: 20px;">负责包修班组：</div>
						</td>
						<td>
							<select name="datePlan.proteamId" class="default" style="width:80px" id="proteamId" onchange="setWorkTeamVal();">
								<option value="">请选择</option>
								<c:forEach var="entry" items="${proteams}">
									<option value="${entry.proteamid}" <c:if test="${datePlan.proteamId==entry.proteamid}">selected="selected"</c:if>>${entry.proteamname}</option>
								</c:forEach>
							</select><font color="red">*整台车由该班组包修</font>
						</td>
					</tr>
					<tr style="display: none;" id="showProteam2">
						<td>
							<div style="text-align: right; margin-right: 20px;">不包修班组：</div>
						</td>
						<td>
							<select multiple id="mulSelect" autoWidth="true" style="width:200px;" onchange="setWorkTeamVal();"> 
								<c:forEach var="entry" items="${proteams}">
								    <c:choose>
								        <c:when test="${entry.proteamname=='制动组'||entry.proteamname=='探伤组'}">
								          <option value="${entry.proteamid}" selected="selected">${entry.proteamname}</option>
								       </c:when>
								       <c:otherwise>
								          <option value="${entry.proteamid}">${entry.proteamname}</option>
								       </c:otherwise>
								    </c:choose>
								</c:forEach>
							</select><font color="red">*指定班组不进行包修</font>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value=" 提 交 " />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<script type="text/javascript">
		    $(function(){
		    	showProTeam();
		    });
			function submitValidate() {
				if ($('#jcType').val()=='') {
					top.Dialog.alert("机车类型不能为空！");
					return false;
				} 
				if ($('#jcNum').val()=='') {
					top.Dialog.alert("机车编号不能为空！");
					return false;
				}
				if ($('#fixFreque').val()=='') {
					top.Dialog.alert("机车修程修次不能为空！");
					return false;
				}
				return true;
			}
			
			function findJcCurriculum() {
				var diag = new top.Dialog();
				diag.Title = "机车信息窗口";
				diag.URL = "<%=basePath%>planManage!findJcCurriculumByWeekPlan.action";
				diag.Width=420;
				diag.Height=320;
				diag.CancelEvent = function(){
					diag.innerFrame.contentWindow.location.reload();
					diag.close();
				};
				diag.OKEvent = function(){
					var doucmentWin = diag.innerFrame.contentWindow;
					doucmentWin.getRadioLine();
					var jcs = doucmentWin.document.getElementById("jcs").value;
					if (jcs!="") {
						var arrs = jcs.split("-");
						$("#jcType").val(arrs[0]);
						$("#jcNum").val(arrs[1]);
						$("#fixFreque").val(arrs[2]);
						diag.close();
					} 
				};
				diag.ShowButtonRow=true;
				diag.show();
			}
			
			function findFixFreque(){
				var diag = new top.Dialog();
				diag.Title = "检修修程窗口";
				diag.Width=360;
				diag.Height=400;
				diag.URL = "<%=basePath%>page/plan/fixfreque.jsp";
				diag.CancelEvent = function(){
					diag.close();
				};
				diag.OKEvent = function(){
					var doucmentWin = diag.innerFrame.contentWindow;
					doucmentWin.getFixFrequeRadioLine();
					var fixfreque = doucmentWin.document.getElementById("selectfixfreque").value;
					if (fixfreque!="") {
						$("#fixFreque").val(fixfreque);
						diag.close();
					} 
				};
				diag.ShowButtonRow=true;
				diag.show();
			}

			function showProTeam(){
				if($("#choiceProteam").attr("checked")){
					$("#showProteam").show();
					$("#showProteam2").show();
					setWorkTeamVal();
				}else{
					$("#showProteam").hide();
					$("#showProteam2").hide();
					$("#proteamId").val("");
					$("#workTeam").val("");
				}
			}

			function setWorkTeamVal(){
				var msg=$("#mulSelect").val();
				if(msg==null){
					msg="";
				}
				if($("#proteamId").val()!=""){
					$("#workTeam").val(msg);
				}
			}
		</script>
		<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>