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
	<title>报活派工</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />

</script>
	<body>
		<div class="box1" panelHeight="270" whiteBg="true">
			<div style="height: 45px;"></div>
				<table width="100%" class="tableStyle">
					<tr>
						<td width="40%">
							<div style="text-align: right; margin-right: 10px;">已选择班组：</div>
						</td>
						<td>
							${fn:substring(bzNames,0,fn:length(bzNames)-1)}
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 10px;">技术员卡控：</div>
						</td>
						<td>
							<input type="radio" name="itemCtrlTech" value="1" checked="checked"/>是&nbsp;&nbsp;&nbsp;<input type="radio" name="itemCtrlTech" value="0" />否
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 10px;">质检员卡控：</div>
						</td>
						<td>
							<input type="radio" name="itemCtrlQI" value="1" checked="checked"/>是&nbsp;&nbsp;&nbsp;<input type="radio" name="itemCtrlQI" value="0" />否
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 10px;">交车工长卡控：</div>
						</td>
						<td>
							<input type="radio" name="itemCtrlComLd" value="1"/>是&nbsp;&nbsp;&nbsp;<input type="radio" name="itemCtrlComLd" value="0" checked="checked"/>否
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 10px;">验收员卡控：</div>
						</td>
						<td>
							<input type="radio" name="itemCtrlAcce" value="1"/>是&nbsp;&nbsp;&nbsp;<input type="radio" name="itemCtrlAcce" value="0" checked="checked"/>否
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="button" value=" 提 交 " onclick="submitValidate()"/>
						</td>
					</tr>
				</table>
		</div>
		<script type="text/javascript">
			function submitValidate() {
				var itemCtrlTech = $('input[name=itemCtrlTech]:checked').val()
				var itemCtrlQI = $('input[name=itemCtrlQI]:checked').val()
				var itemCtrlComLd = $('input[name=itemCtrlComLd]:checked').val()
				var itemCtrlAcce = $('input[name=itemCtrlAcce]:checked').val()
				
				$.post("reportWorkManage!distributionDispatchingConfirm.action",
						{"id":"${id}","role":"${role}","dispatch.bzIds":"${params}","dispatch.itemCtrlTech":itemCtrlTech,"dispatch.itemCtrlQI":itemCtrlQI,"dispatch.itemCtrlComLd":itemCtrlComLd,"dispatch.itemCtrlAcce":itemCtrlAcce},
						function(text){
							if(text=="login_failure"){
								top.Dialog.alert("派工失败!");
							} else if(text=='havework'){
								top.Dialog.alert("已经派工，请先删除分工!");
							} else{
								top.Dialog.alert("派工成功!",function(){
									top.frames[4].location.href="reportWorkManage!distributionInput.action?id=${rjhmId}&role=dispatcher";
									top.Dialog.close();
								});
							}
						}
				);
			}
		</script>
			<!--框架必需end-->
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js">
	</body>
</html>