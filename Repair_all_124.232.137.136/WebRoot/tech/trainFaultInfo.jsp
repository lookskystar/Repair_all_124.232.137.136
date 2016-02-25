<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
</head>
<body>
	<form action="teach!editTrainFault.do" method="post" target="userIframe">
	<input type="hidden" name="trainFault.id" value="${trainFault.id }" />
	<input type="hidden" name="trainFault.jctype" value="${trainFault.jctype }" />
	<input type="hidden" name="trainFault.jcnum" value="${trainFault.jcnum }" />
	<input type="hidden" name="trainFault.locomotive" value="${trainFault.locomotive }" />
	<div class="box1">
	<fieldset> 
		<legend>机破信息</legend> 
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="10%">机破段属：</td><td width="40%"><input type="text" name="trainFault.faultmotive" value="${trainFault.faultmotive }"/></td>
				<td width="10%">机破原因：</td>
				<td>
					<input type="text" name="trainFault.faultCause" value="${trainFault.faultCause }"/>
				</td>
			</tr>
			<tr>
				<td width="10%">机破日期：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" name="trainFault.faultDate"   value="${trainFault.faultDate }"/></td>
			</tr>
			<tr>
				<td width="10%">登记人员：</td><td width="40%"><input type="text" name="trainFault.register" value="${trainFault.register }"/></td>
				<td>登记日期：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" name="trainFault.regDate"   value="${trainFault.regDate }"/></td>
			</tr>
			<tr>
				<td width="10%">处理情况：</td>
				<td>
					<span class="float_left">
						<textarea  name="trainFault.dealcondition">${trainFault.dealcondition } </textarea>
					</span>
					<span class="img_light" style="height:80px;" title="限制在200字以内"></span>
				</td>
				<td width="10%">备注：</td>
				<td>
					<span class="float_left">
						<textarea  name="trainFault.comments">${trainFault.comments } </textarea>
					</span>
					<span class="img_light" style="height:80px;" title="限制在200字以内"></span>
				</td>
			</tr>
		</table>
	</fieldset> 
	
	<fieldset> 
		<legend>机车信息</legend> 
		<input type="hidden" name="jtRunKiloRec.runId" value="${trainFault.jtRunKiloRec.runId }" />
		<table class="tableStyle" transMode="true" footer="normal">
			<tr>
				<td width="10%">机车类型：</td><td width="40%"><input type="text" name="jtRunKiloRec.jcType" value="${trainFault.jtRunKiloRec.jcType }" disabled="disabled"/></td>
				<td width="10%">机车编号：</td><td width="40%"><input type="text" name="jtRunKiloRec.jcNum" value="${trainFault.jtRunKiloRec.jcNum  }" disabled="disabled"/></td>
			</tr>
			<tr>
				<td width="10%">辅修走行：</td><td width="40%"><input type="text" name="jtRunKiloRec.minorRunKilo" value="${trainFault.jtRunKiloRec.minorRunKilo }" disabled="disabled"/></td>
				<td width="10%">小修走行：</td><td width="40%"><input type="text" name="jtRunKiloRec.smaRunKilo" value="${trainFault.jtRunKiloRec.smaRunKilo }" disabled="disabled"/></td>
			</tr>
			<tr>
				<td width="10%">中修走行：</td><td width="40%"><input type="text" name="jtRunKiloRec.midRunKilo" value="${trainFault.jtRunKiloRec.midRunKilo }" disabled="disabled"/></td>
				<td width="10%">大修走行：</td><td width="40%"><input type="text" name="jtRunKiloRec.larRunKilo" value="${trainFault.jtRunKiloRec.larRunKilo }" disabled="disabled"/></td>
			</tr>
			<tr>
				<td width="10%">当日走行：</td><td width="40%"><input type="text" name="jtRunKiloRec.dayRunKilo" value="${trainFault.jtRunKiloRec.dayRunKilo }" disabled="disabled"/></td>
				<td width="10%">总走行：</td><td width="40%"><input type="text" name="jtRunKiloRec.totalRunKilo" value="${trainFault.jtRunKiloRec.totalRunKilo }" disabled="disabled"/></td>
			</tr>
			<tr>
				<td width="10%">登记人员：</td><td width="40%"><input type="text" name="jtRunKiloRec.registRant" value="${trainFault.jtRunKiloRec.registRant }" disabled="disabled"/></td>
				<td width="10%">登记时间：</td><td width="40%"><input type="text" name="jtRunKiloRec.registTime" value="${trainFault.jtRunKiloRec.registTime }" disabled="disabled"/></td>
			</tr>
		</table>
	</fieldset> 
	<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="submit" value=" 提 交 "/>
					<input type="reset" value=" 重 置 "/>
				</td>
			</tr>
		</table>
	</div> 
	</form>		
</body>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
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
</script>
</html>