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
	<form action="teach!saveTrainFault.do" method="post" target="userIframe">
	<div class="box1" panelWidth="500" panelTitle="添加机破信息" showStatus="false" roller="true">
	<table class="tableStyle" transMode="true">
		<tr>
			<td>机车类型：</td><td><input type="text" class="validate[required]" id="jcType" name="trainFault.jctype" />&nbsp;&nbsp;<input id="jccurriculum" type="button" value="选择" onclick="findJcCurriculum()"/>
					<span class="star">*</span>
			</td>
		</tr>
		<tr>
			<td>机车编号：</td><td><input type="text" class="validate[required]" id="jcNum" name="trainFault.jcnum"/><span class="star">*</span></td>
		</tr>
		<tr>
			<td>机车段属：</td><td><input type="text" name="trainFault.locomotive"/></td>
		</tr>
		<tr>
			<td>机破日期：</td><td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" name="trainFault.faultDate"/></td>
		</tr>
		<tr>
			<td>机破原因：</td>
			<td>
				<span class="float_left">
					<textarea  name="trainFault.faultCause"> </textarea>
				</span>
				<span class="img_light" style="height:80px;" title="限制在200字以内"></span>
			</td>
		</tr>
		<tr>
			<td>机破段属：</td><td><input type="text" name="trainFault.faultmotive"/></td>
		</tr>
		<tr>
			<td>录入日期：</td><td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" name="trainFault.regDate"/></td>
		</tr>
		<tr>
			<td>录入人员：</td><td><input type="text" name="trainFault.register"/></td>
		</tr>
		<tr>
			<td>处理情况：</td>
			<td>
				<span class="float_left">
					<textarea name="trainFault.dealcondition"> </textarea>
				</span>
				<span class="img_light" style="height:80px;" title="限制在200字以内"></span>
			</td>
		</tr>
		<tr>
			<td>备注：</td>
			<td>
				<span class="float_left">
					<textarea name="trainFault.comments"> </textarea>
				</span>
				<span class="img_light" style="height:80px;" title="限制在200字以内"></span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value=" 提 交 " />
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