<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>">

		<title>交车竣工单</title>
	</head>

	<body class="easyui-layout" fit="true">
		<!-- 机车段修竣工交验单表区结束 -->
		
		<div region="center" align="center">
			<div class="easyui-layout" fit="true" style="width: 1000px;">
				<div id="gg" region="north" title="机车段修竣工交验单"
					style="width: auto; height: 130px; padding: 4px;">
					<p><h4 align="center">机车竣工验收记录</h4></p>
					<p style="padding-left: 4px;text-align: left;line-height: 30px;">
						<font style="font-size: 16">
						<label style="width:40px"></label>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						配属  广州
						局  广州
						段
						<span style="color: blue;margin-left: 10px;margin-right: 10px;">${rec.jclx}</span>
						型号
						<span style="color: blue;margin-left: 10px;margin-right: 10px;">${rec.jch}</span>
						号机车，已于
						<span style="color: blue;margin-left: 10px;margin-right: 10px;">${rec.kssj}</span>
						至
						<span style="color: blue;margin-left: 10px;margin-right: 10px;">${rec.jssj}</span>
						由  广州  机务段，
						按照有关技术规定经
						<span style="color: blue;margin-left: 10px;margin-right: 10px;">${rec.xcxc}</span>
						修次竣工，经局驻段验收员检查验收，确认技术状态合格，准予交付运用。
						</font>
					</p>
				</div>
				<div region="center" style="width: auto; padding: 0px;">
					<table id="bb" class="b" align="center">
						<tr>
							<td class="a">
								<span style="font-size: 16">段长</span>
							</td>
							<td>
								<input id="leader" name="leader" style="width: 100px;" readonly="readonly" value="${rec.dzxm}" >
							</td>
							<td>
								<input style="width:130px;" id="lsigntime" name="lsigntime" style="width: 100px;" readonly="readonly"   value="${rec.jssj}">
							</td>
						</tr>
						<tr>
							<td class="a">
								<span style="font-size: 16">检修主任</span>
							</td>
							<td>
								<input id="zhuren" name="zhuren" style="width: 100px;" readonly="readonly" value="${rec.jxzrxm }">
							</td>
							<td>
								<input style="width:130px;" id="lsigntime" name="lsigntime" style="width: 100px;" readonly="readonly"   value="${rec.jssj}">
							</td>
						</tr>
						<%--
						<tr>
							<td class="a">
								<span style="font-size: 16">驻段验收员</span>
							</td>
							<td>
								<input id="accept" name="accept" style="width: 100px;" readonly="readonly" value="${rec.ysyxm}">
							</td>
							<td>
								<input style="width:130px;" id="lsigntime" name="lsigntime" style="width: 100px;" readonly="readonly"   value="${rec.jssj}">
							</td>
						</tr>
						<tr>
							<td class="a">
								<span style="font-size: 16">段长</span>
							</td>
							<td>
								<input id="duanzhang" name="duanzhang" style="width: 100px;" readonly="readonly"  value="${rec.dzxm }">
							</td>
							<td>
								<input style="width:130px;" id="lsigntime" name="lsigntime" style="width: 100px;" readonly="readonly"   value="${rec.jssj}">
							</td>
						</tr>
						 --%>
					</table>
				</div>
			</div>
		</div>
	</body>
</html>
