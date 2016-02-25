<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	<base href="<%=basePath%>" />
	<title>机车检修日计划操作</title>
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
			<form action="<%=basePath%>planManage!addDatePlanPriConfirm.action" method="post" target="jcmain" id="subform">
				<table width="100%">
					<input type="hidden" id="mainPlanDetailid" name="mainPlanDetailid" value=""/>
					<input type="hidden" id="workTeam" name="datePlan.workTeam" value=""/>
					<tr>
						<td width="40%">
							<div style="text-align: right; margin-right: 20px;">车型：</div>
						</td>
						<td>
							<input type="text" id="jcType" name="datePlan.jcType"/>&nbsp;<input id="jccurriculum" type="button" value="选择" onclick="findJcCurriculum()"/>&nbsp;<input id="jcweekplan" type="button" value="周计划" onclick="findWeekPlan()"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">车号：</div>
						</td>
						<td>
							<input type="text" id="jcNum" name="datePlan.jcnum"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">修程：</div>
						</td>
						<td>
							<input type="text" id="fixFreque" name="datePlan.fixFreque"/>
							<input id="jcfixFreque" type="button" value="选择" onclick="findFixFreque()"/>&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">股道：</div>
						</td>
						<td>
							<input type="text" name="datePlan.gdh" value="${gdh }"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">台位：</div>
						</td>
						<td>
							<input type="text" name="datePlan.twh" value="${twh }"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划扣车时间：</div>
						</td>
						<td>
							<input type="text" class="Wdate" onfocus="WdatePicker()" id="kcsj" name="datePlan.kcsj" style="width:120px" value='<%=new SimpleDateFormat("yyyy-MM-dd 07:00").format(new Date())%>'/>
							如,2012-12-14 04:51
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划起机时间：</div>
						</td>
						<td>
							<input type="text" class="Wdate" onfocus="WdatePicker()" name="datePlan.jhqjsj" style="width:120px" value='<%=new SimpleDateFormat("yyyy-MM-dd 13:30").format(new Date())%>'/>
							如,2012-12-14 04:51
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划交车时间：</div>
						</td>
						<td>
							<input type="text" class="Wdate" onfocus="WdatePicker()" name="datePlan.jhjcsj" style="width:120px" value='<%=new SimpleDateFormat("yyyy-MM-dd 16:30").format(new Date())%>'/>
							如,2012-12-14 04:51
						</td>
					</tr>
					<tr>
						<td><div style="text-align: right; margin-right: 20px;">备注: </div></td>
						<td>
						<textarea name="datePlan.comments" rows="4" cols="10"></textarea>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">交车工长：</div>
						</td>
						<td>
							<select name="id" class="default" style="width:80px" id="jcgz">
								<option value="">请选择</option>
								<c:forEach var="entry" items="${users}">
									<option value="${entry.userid}">${entry.xm}</option>
								</c:forEach>
							</select>
							<font color="red">*可以不指定</font>&nbsp;
							<input type="checkbox" id="choiceProteam"/>指定包修班组
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
									<option value="${entry.proteamid}">${entry.proteamname}</option>
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
							<input type="button" id="subtn" value=" 提 交 " onclick="checkProteam();"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#subtn").bind('click',function(){
					//参数列表
					//机车类型
					var jcType = $("#jcType").val();
					//机车编号
					var jcNum = $("#jcNum").val();
					//修程修次
					var fixFreque = $("#fixFreque").val();
					var isSub = true;
					$.post("planManage!ajaxDailyIsExist.do",{"jcType":jcType, "jcNum":jcNum, "fixFreque":fixFreque},
						function(result){
							if(result == "success"){
								if (jcType == '') {
									top.Dialog.alert("机车类型不能为空！");
									isSub = false;
								} 
								if (jcNum == '') {
									top.Dialog.alert("机车编号不能为空！");
									isSub = false;
								}
								if (jcNum.length < 4) {
									top.Dialog.alert("请输入四位机车编号！");
									isSub = false;
								}
								if (fixFreque == '') {
									top.Dialog.alert("机车修程修次不能为空！");
									isSub = false;
								}
								if(checkProteam()){
									top.Dialog.alert("不能指定包修组与不包修组是同一班组！");
									isSub = false;
								}
								if(isSub){
									$("#subform").submit();
								}
							}else{
								top.Dialog.confirm("已存在相同机车是否继续扣车？",function(){$("#subform").submit();});
							}
						}
					)
				});

				$("#choiceProteam").bind("click",function(){
					if($(this).attr("checked")){
						$("#showProteam").show();
						$("#showProteam2").show();
					}else{
						$("#showProteam").hide();
						$("#showProteam2").hide();
						$("#proteamId").val("");
						$("#workTeam").val("");
					}
				});
			})
			
			function setWorkTeamVal(){
				var msg=$("#mulSelect").val();
				if(msg==null){
					msg="";
				}
				if($("#proteamId").val()!=""){
					$("#workTeam").val(msg);
				}
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
				diag.Width=380;
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

			function findWeekPlan() {
				var diag = new top.Dialog();
				diag.Title = "机车信息窗口";
				diag.URL = "<%=basePath%>planManage!findJcCurriculumByMainPlan.action";
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
						$("#mainPlanDetailid").val(arrs[3]);
						diag.close();
					} 
				};
				diag.ShowButtonRow=true;
				diag.show();
			}

			//校验包修与未包修班组
			function checkProteam(){
				var flag = false;
				var bxproteamid = $("#proteamId").val();
				var bbproteamid = $("#mulSelect").val();
				for(var i=0;i<bbproteamid.length;i++){
					if(bxproteamid == bbproteamid[i]){
						flag = true;
					}
				}
				return flag;
			}
		</script>
		<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>