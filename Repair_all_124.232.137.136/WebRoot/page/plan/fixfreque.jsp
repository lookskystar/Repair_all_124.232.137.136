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
						<td><label>F01</label><input type="radio" name="ra" value="F01" /></td>
						<td><label>F&nbsp;1</label><input type="radio" name="ra" value="F1" /></td>
						<td><label>F11</label><input type="radio" name="ra" value="F11" /></td>
						<td><label>F12</label><input type="radio" name="ra" value="F12" /></td>
						<td><label>F13</label><input type="radio" name="ra" value="F13" /></td>
						<td><label>F16</label><input type="radio" name="ra" value="F16" /></td>
					</tr>
					<tr>
						<td><label>F02</label><input type="radio" name="ra" value="F02" /></td>
						<td><label>F&nbsp;2</label><input type="radio" name="ra" value="F2" /></td>
						<td><label>F21</label><input type="radio" name="ra" value="F21" /></td>
						<td><label>F22</label><input type="radio" name="ra" value="F22" /></td>
						<td><label>F23</label><input type="radio" name="ra" value="F23" /></td>
						<td><label>F26</label><input type="radio" name="ra" value="F26" /></td>
					</tr>
					<tr>
						<td><label>F03</label><input type="radio" name="ra" value="F03" /></td>
						<td><label>F&nbsp;3</label><input type="radio" name="ra" value="F3" /></td>
						<td><label>F31</label><input type="radio" name="ra" value="F31" /></td>
						<td><label>F32</label><input type="radio" name="ra" value="F32" /></td>
						<td><label>F33</label><input type="radio" name="ra" value="F33" /></td>
						<td><label>F36</label><input type="radio" name="ra" value="F36" /></td>
					</tr>
					<tr>
						<td><label>F04</label><input type="radio" name="ra" value="F04" /></td>
						<td><label>F&nbsp;4</label><input type="radio" name="ra" value="F4" /></td>
						<td><label>F41</label><input type="radio" name="ra" value="F41" /></td>
						<td><label>F42</label><input type="radio" name="ra" value="F42" /></td>
						<td><label>F43</label><input type="radio" name="ra" value="F43" /></td>
						<td><label>F46</label><input type="radio" name="ra" value="F46" /></td>
					</tr>
					<tr>
						<td><label>F05</label><input type="radio" name="ra" value="F05" /></td>
						<td><label>F&nbsp;5</label><input type="radio" name="ra" value="F5" /></td>
						<td><label>F51</label><input type="radio" name="ra" value="F51" /></td>
						<td><label>F52</label><input type="radio" name="ra" value="F52" /></td>
						<td><label>F53</label><input type="radio" name="ra" value="F53" /></td>
						<td><label>F56</label><input type="radio" name="ra" value="F56" /></td>
					</tr>
					<tr>
						<td><label>F06</label><input type="radio" name="ra" value="F06" /></td>
						<td><label>F&nbsp;6</label><input type="radio" name="ra" value="F6" /></td>
						<td><label>F61</label><input type="radio" name="ra" value="F61" /></td>
						<td><label>F62</label><input type="radio" name="ra" value="F62" /></td>
						<td><label>F63</label><input type="radio" name="ra" value="F63" /></td>
					</tr>
					<tr>
						<td><label>F&nbsp;7</label><input type="radio" name="ra" value="F7" /></td>
						<td><label>F&nbsp;8</label><input type="radio" name="ra" value="F8" /></td>
						<td><label>F&nbsp;9</label><input type="radio" name="ra" value="F9" /></td>
						<td><label>F10</label><input type="radio" name="ra" value="F10" /></td>
						<td><label>F11</label><input type="radio" name="ra" value="F11" /></td>
					</tr>
					<tr>
						<td><label>X&nbsp;1</label><input type="radio" name="ra" value="X1" /></td>
						<td><label>X&nbsp;2</label><input type="radio" name="ra" value="X2" /></td>
						<td><label>X&nbsp;3</label><input type="radio" name="ra" value="X3" /></td>
						<td><label>X&nbsp;4</label><input type="radio" name="ra" value="X4" /></td>
						<td><label>X&nbsp;5</label><input type="radio" name="ra" value="X5" /></td>
						<td><label>X&nbsp;6</label><input type="radio" name="ra" value="X6" /></td>
					</tr>
					<tr>
						<td><label>X&nbsp;7</label><input type="radio" name="ra" value="X7" /></td>
						<td><label>X&nbsp;8</label><input type="radio" name="ra" value="X8" /></td>
						<td><label>X&nbsp;9</label><input type="radio" name="ra" value="X9" /></td>
						<td><label>X10</label><input type="radio" name="ra" value="X10" /></td>
						<td><label>X11</label><input type="radio" name="ra" value="X11" /></td>
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