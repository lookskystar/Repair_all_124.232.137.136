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
	<title>机车检修月计划机车修改</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js">
</script>
	<script type="text/javascript" src="js/framework.js">
</script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->
	<body>
		<div class="box1" panelHeight="220" whiteBg="true">
			<form action="planManage!modifyMonPlanRecorderConfirm.action" method="post" target="frmright">
				<input name="monPlanRecorder.monPrecId" type="hidden" value="${monPlanRecorder.monPrecId}" />
				<input name="monPlanRecorder.jwdCode" type="hidden" value="${monPlanRecorder.jwdCode}" />
				<input name="monPlanRecorder.areaId" type="hidden" value="${monPlanRecorder.areaId}" />
				<input name="monPlanRecorder.monPlanId.monPlanId" type="hidden" value="${monPlanRecorder.monPlanId.monPlanId}" />
				<input name="monPlanRecorder.planStatus" type="hidden" value="${monPlanRecorder.planStatus}" />
				<input name="monPlanRecorder.vary" type="hidden" value="${monPlanRecorder.vary}" />
				<table width="100%">
					<tr>
						<td height="12px;">
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td width="50%">
							<div style="text-align: right; margin-right: 20px;">机车类型：</div>
						</td>
						<td>
							<input type="text" name="monPlanRecorder.jcType" value="${monPlanRecorder.jcType}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">机车编号：</div>
						</td>
						<td>
							<input type="text" name="monPlanRecorder.jcNum" value="${monPlanRecorder.jcNum}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">修程修次：</div>
						</td>
						<td>
						   <input type="text" id="fixFreque" name="monPlanRecorder.fixFreque" value="${monPlanRecorder.fixFreque }"/>
						   <input id="jcfixFreque" type="button" value="选择" onclick="findFixFreque()"/>&nbsp;&nbsp;
						   <!--  
							<select name="monPlanRecorder.fixFreque">
								<option value="">请选择</option>
								<c:if test="${!empty dictJcFixSeqs}">
									<c:forEach items="${dictJcFixSeqs}" var="entry">
										<option value="${entry.fixValue}" <c:if test="${entry.fixValue==monPlanRecorder.fixFreque}">selected</c:if>>${entry.fixValue}</option>
									</c:forEach>
								</c:if>
							</select>-->
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">上次检修时间：</div>
						</td>
						<td>
							<input type="text" class="Wdate"
								onClick="WdatePicker()"
								name="monPlanRecorder.befFixDate" style="width: 120px" value="${monPlanRecorder.befFixDate}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">计划扣车时间：</div>
						</td>
						<td>
							<input type="text" class="Wdate"
								onClick="WdatePicker()"
								name="monPlanRecorder.planFixDate" style="width: 120px" value="${monPlanRecorder.planFixDate}"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">修程走行公里：</div>
						</td>
						<td>
							<input type="text"
								name="monPlanRecorder.runKilo" style="width: 120px" value="${monPlanRecorder.runKilo}" onkeyup="if(isNaN(value))execCommand('undo')"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">总走行公里：</div>
						</td>
						<td>
							<input type="text" 
								name="monPlanRecorder.totalRunKilo" style="width: 120px" value="${monPlanRecorder.totalRunKilo}" onkeyup="if(isNaN(value))execCommand('undo')"/>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 20px;">估算走行公里：</div>
						</td>
						<td>
							<input type="text" name="monPlanRecorder.guessRunKilo" value="${monPlanRecorder.guessRunKilo}" onkeyup="if(isNaN(value))execCommand('undo')"/>
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
			<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
		    <script type="text/javascript">
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
			</script>
	</body>
</html>