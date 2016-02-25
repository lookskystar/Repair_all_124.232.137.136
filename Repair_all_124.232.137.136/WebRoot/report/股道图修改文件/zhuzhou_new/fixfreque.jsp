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
	<title>机车检修日计划操作</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->
	<body>
		<div class="box1" panelHeight="350" whiteBg="true" panelWidth="350">
				<table width="100%" id="radioTable">
					<tr>
						<td><label>F&nbsp;1</label><input type="radio" name="ra" value="F1" /></td>
						<td><label>F&nbsp;2</label><input type="radio" name="ra" value="F2" /></td>
						<td><label>F&nbsp;3</label><input type="radio" name="ra" value="F3" /></td>
						<td><label>F&nbsp;4</label><input type="radio" name="ra" value="F4" /></td>
						<td><label>F&nbsp;5</label><input type="radio" name="ra" value="F5" /></td>
						<td><label>F&nbsp;6</label><input type="radio" name="ra" value="F6" /></td>
					</tr>
					<tr>
					    <td><label>F&nbsp;7</label><input type="radio" name="ra" value="F7" /></td>
						<td><label>F&nbsp;8</label><input type="radio" name="ra" value="F8" /></td>
						<td><label>F&nbsp;9</label><input type="radio" name="ra" value="F9" /></td>
						<td><label>F10</label><input type="radio" name="ra" value="F10" /></td>
						<td><label>F11</label><input type="radio" name="ra" value="F11" /></td>
						<td><label>F12</label><input type="radio" name="ra" value="F12" /></td>
					</tr>
					<tr>
						<td><label>1C1</label><input type="radio" name="ra" value="1C1" /></td>
						<td><label>2C1</label><input type="radio" name="ra" value="2C1" /></td>
						<td><label>3C1</label><input type="radio" name="ra" value="3C1" /></td>
						<td><label>4C1</label><input type="radio" name="ra" value="4C1" /></td>
						<td><label>5C1</label><input type="radio" name="ra" value="5C1" /></td>
						<td><label>6C1</label><input type="radio" name="ra" value="6C1" /></td>
					</tr>
					<tr>
						<td><label>1C2</label><input type="radio" name="ra" value="1C2" /></td>
						<td><label>2C2</label><input type="radio" name="ra" value="2C2" /></td>
						<td><label>3C2</label><input type="radio" name="ra" value="3C2" /></td>
						<td><label>1C3</label><input type="radio" name="ra" value="1C3" /></td>
						<td><label>2C3</label><input type="radio" name="ra" value="2C3" /></td>
					</tr>
					<!-- 
					<tr>
						<td><label>Z&nbsp;1</label><input type="radio" name="ra" value="Z1" /></td>
						<td><label>Z&nbsp;2</label><input type="radio" name="ra" value="Z2" /></td>
						<td><label>Z&nbsp;3</label><input type="radio" name="ra" value="Z3" /></td>
						<td colspan="3"><label>Z&nbsp;4</label><input type="radio" name="ra" value="Z4" /></td>
					</tr>
					 -->
					<tr>
						<td><label>月检</label><input type="radio" name="ra" value="YJ" /></td>
						<td><label>季检</label><input type="radio" name="ra" value="JJ" /></td>
						<td><label>半年检</label><input type="radio" name="ra" value="BNJ" /></td>
						<td><label>年检</label><input type="radio" name="ra" value="NJ" /></td>
					</tr>
					<tr>
						<td><label>临修</label><input type="radio" name="ra" value="LX" /></td>
						<td><label>加改</label><input type="radio" name="ra" value="JG" /></td>
						<td><label>秋整</label><input type="radio" name="ra" value="QZ" /></td>
					    <td><label>春鉴</label><input type="radio" name="ra" value="CJ" /></td>
					    <td><label>整治</label><input type="radio" name="ra" value="ZZ" /></td>
					</tr>
					<tr>
						<td><label>Z1</label><input type="radio" name="ra" value="Z1" /></td>
						<td><label>Z2</label><input type="radio" name="ra" value="Z2" /></td>
						<td><label>Z3</label><input type="radio" name="ra" value="Z3" /></td>
						<td><label>Z4</label><input type="radio" name="ra" value="Z4" /></td>
					</tr>
					<tr>
						<td colspan="2"><label>周期整治</label><input type="radio" name="ra" value="ZQZZ" /></td>
						<td colspan="3"><label>出厂整治</label><input type="radio" name="ra" value="CCZZ" /></td>
					</tr>
				</table>
				<input type="hidden" id="selectfixfreque"/>
		</div>
		<script type="text/javascript">
			function getFixFrequeRadioLine(){
				var msg;
				msg=$("#radioTable input[type=radio]").filter("[checked=true]").val();
				if (typeof(msg) == 'undefined') {
					top.Dialog.alert("请选择修程！");
				} else {
					$("#selectfixfreque").val(msg);
				}
			}
		</script>
		<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
	</body>
</html>