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
	<title>检修内容派工</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->
	<script type="text/javascript" src="js/form/multiselect.js"></script>
	<body>
		<div class="box1" panelHeight="270" whiteBg="true">
			<div style="height: 45px;"></div>
			<form action="planManage!dispatchingConfirm.action" method="post" target="jcgz_gdt" onsubmit="return submitValidate()">
				<input type="hidden" name="id" value="${id}"/>
				<input type="hidden" name="ids" value="${ids}"/>
				<table width="100%" class="tableStyle">
					<tr>
						<td width="40%">
							<div style="text-align: right; margin-right: 10px;">班组：</div>
						</td>
						<td>
							<select name="dispatch.bzIds" id="bz" multiple>
								<c:forEach items="${dictProTeams}" var="entry">
									<option value="${entry.proteamid}">${entry.proteamname}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 10px;">技术员卡控：</div>
						</td>
						<td>
							<input type="radio" name="dispatch.itemCtrlTech" value="1" checked="checked"/>是&nbsp;&nbsp;&nbsp;<input type="radio" name="dispatch.itemCtrlTech" value="0"/>否
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 10px;">质检员卡控：</div>
						</td>
						<td>
							<input type="radio" name="dispatch.itemCtrlQI" value="1" checked="checked"/>是&nbsp;&nbsp;&nbsp;<input type="radio" name="dispatch.itemCtrlQI" value="0"/>否
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 10px;">交车工长卡控：</div>
						</td>
						<td>
							<input type="radio" name="dispatch.itemCtrlComLd" value="1"/>是&nbsp;&nbsp;&nbsp;<input type="radio" name="dispatch.itemCtrlComLd" value="0" checked="checked"/>否
						</td>
					</tr>
					<tr>
						<td>
							<div style="text-align: right; margin-right: 10px;">验收员卡控：</div>
						</td>
						<td>
							<input type="radio" name="dispatch.itemCtrlAcce" value="1" />是&nbsp;&nbsp;&nbsp;<input type="radio" name="dispatch.itemCtrlAcce" value="0" checked="checked"/>否
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input name="submit" type="submit" value=" 提 交 " />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<script type="text/javascript">
			function submitValidate() {
				var bzIds=$("#bz").val();
				if ($('#bz').val()==null) {
					top.Dialog.alert("请选择班组信息！");
					return false;
				} 
				return true;
			}
		</script>
	    <script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>