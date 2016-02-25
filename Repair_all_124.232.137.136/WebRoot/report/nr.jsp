<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>">
		<title>交车记录</title>
		<!--框架必需start-->	
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
		<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
		<!--框架必需end-->
		<!--截取文字start-->
		<script type="text/javascript" src="js/text/text-overflow.js"></script>
	</head>

	<body class="easyui-layout" fit="true">
		<div id="scrollContent" style="margin-top: 10px;font-size: 14px;">
			<table align="center" width="700px;" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th align="left" bgcolor="lightblue">&nbsp;&nbsp;交车检测项目</th>
					<th></th>
					<%--
					<th align="left" bgcolor="lightblue">&nbsp;&nbsp;交车签到列表</th>
					 --%>
				</tr>
				<tr valign="top">
					<td width="710px">
						<table align="center" border="1px" bordercolor="#aabbcc" cellspacing="0" cellpadding="0" width="100%">
							<tr>
								<td colspan="19">压缩压力(Mpa)</td>
							</tr>
							<tr align="center">
								<td align="center" colspan="16">项目</td>
								<td rowspan="2" width="80px">交车签认</td>
								<td rowspan="2" width="80px">质检签认</td>
								<td rowspan="2" width="80px">验收签认</td>
							</tr>
							<tr align="center">
								<td align="center" width="30px;">1</td><td align="center" width="30px;">2</td><td align="center" width="30px;">3</td>
								<td align="center" width="30px;">4</td><td align="center" width="30px;">5</td><td align="center" width="30px;">6</td>
								<td align="center" width="30px;">7</td><td align="center" width="30px;">8</td><td align="center" width="30px;">9</td>
								<td align="center" width="30px;">10</td><td align="center" width="30px;">11</td><td align="center" width="30px;">12</td>
								<td align="center" width="30px;">13</td><td align="center" width="30px;">14</td><td align="center" width="30px;">15</td>
								<td align="center" width="30px;">16</td>
							</tr>
							<tr align="center">
								<td align="center" width="30px;">${itemrec.ysyl1}&nbsp;</td><td align="center" width="30px;">${itemrec.ysyl2}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ysyl3}&nbsp;</td><td align="center" width="30px;">${itemrec.ysyl4}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ysyl5}&nbsp;</td><td align="center" width="30px;">${itemrec.ysyl6}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ysyl7}&nbsp;</td><td align="center" width="30px;">${itemrec.ysyl8}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ysyl9}&nbsp;</td><td align="center" width="30px;">${itemrec.ysyl10}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ysyl11}&nbsp;</td><td align="center" width="30px;">${itemrec.ysyl2}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ysyl13}&nbsp;</td><td align="center" width="30px;">${itemrec.ysyl4}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ysyl15}&nbsp;</td><td align="center" width="30px;">${itemrec.ysyl6}&nbsp;</td>
								<td align="center">${itemrec.gzId.xm }&nbsp;</td>
								<td align="center">${itemrec.zjId.xm }&nbsp;</td>
								<td align="center">${itemrec.ysId.xm }&nbsp;</td>
							</tr>
						</table>
						
						<table align="center" border="1px" bordercolor="#aabbcc" cellspacing="0" cellpadding="0" width="100%" style="margin-top: 10px;">
							<tr>
								<td colspan="19">滑油压力 60°C (Mpa)</td>
							</tr>
							<tr align="center">
								<td align="center" colspan="8">项目</td>
								<td rowspan="2" width="80px">交车签认</td>
								<td rowspan="2" width="80px">质检签认</td>
								<td rowspan="2" width="80px">验收签认</td>
							</tr>
							<tr align="center">
								<td align="center" width="40px;">转速1</td>
								<td align="center" width="40px;">一室1</td>
								<td align="center" width="40px;">出口1</td>
								<td align="center" width="40px;">粗前1</td>
								<td align="center" width="40px;">粗后1</td>
								<td align="center" width="40px;">前增1</td>
								<td align="center" width="40px;">后增1</td>
								<td align="center" width="40px;">二室1</td>
							</tr>
							<tr align="center">
								<td align="center" width="30px;">${itemrec.hyylzs1}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylys1}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylck1 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylcq1 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylch1 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylqz1 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylhz1 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyyles1 }&nbsp;</td>
								<td align="center">${itemrec.gzId.xm }&nbsp;</td>
								<td align="center">${itemrec.zjId.xm }&nbsp;</td>
								<td align="center">${itemrec.ysId.xm }&nbsp;</td>
							</tr>
							<tr align="center">
								<td align="center" width="40px;">转速2</td>
								<td align="center" width="40px;">一室2</td>
								<td align="center" width="40px;">出口2</td>
								<td align="center" width="40px;">粗前2</td>
								<td align="center" width="40px;">粗后2</td>
								<td align="center" width="40px;">前增2</td>
								<td align="center" width="40px;">后增2</td>
								<td align="center" width="40px;">二室2</td>
							</tr>
							<tr align="center">
								<td align="center" width="30px;">${itemrec.hyylzs2}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylys2}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylck2 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylcq2 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylch2 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylqz2 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyylhz2 }&nbsp;</td>
								<td align="center" width="30px;">${itemrec.hyyles2 }&nbsp;</td>
								<td align="center">${itemrec.gzId.xm }&nbsp;</td>
								<td align="center">${itemrec.zjId.xm }&nbsp;</td>
								<td align="center">${itemrec.ysId.xm }&nbsp;</td>
							</tr>
						</table>
						
						<table align="center" border="1px" bordercolor="#aabbcc" cellspacing="0" cellpadding="0" width="100%" style="margin-top: 10px;">
							<tr>
								<td colspan="19">燃油压力(Kpa)</td>
							</tr>
							<tr align="center">
								<td align="center" colspan="6">项目</td>
								<td rowspan="2" width="80px">交车签认</td>
								<td rowspan="2" width="80px">质检签认</td>
								<td rowspan="2">验收签认</td>
							</tr>
							<tr align="center">
								<td align="center" width="40px;">一室1</td><td align="center" width="40px;">一室2</td>
								<td align="center" width="50px;">机械间1</td><td align="center" width="50px;">机械间2</td>
								<td align="center" width="40px;">二室1</td><td align="center" width="40px;">二室2</td>
							</tr>
							<tr align="center">
								<td align="center" width="70px;">${itemrec.ryylys1}&nbsp;</td><td align="center" width="70px;">${itemrec.ryylys2}&nbsp;</td>
								<td align="center" width="70px;">${itemrec.ryyljxj1}&nbsp;</td><td align="center" width="70px;">${itemrec.ryyljxj2}&nbsp;</td>
								<td align="center" width="70px;">${itemrec.ryyles1 }&nbsp;</td><td align="center" width="70px;">${itemrec.ryyles2 }&nbsp;</td>
								<td align="center">${itemrec.gzId.xm }&nbsp;</td>
								<td align="center">${itemrec.zjId.xm }&nbsp;</td>
								<td align="center">${itemrec.ysId.xm }&nbsp;</td>
							</tr>
						</table>
						
						<table align="center" border="1px" bordercolor="#aabbcc" cellspacing="0" cellpadding="0" width="100%" style="margin-top: 10px;">
							<tr>
								<td colspan="19">绝缘检测(MΩ)</td>
							</tr>
							<tr align="center">
								<td align="center" colspan="5">项目</td>
								<td rowspan="2" width="80px">交车签认</td>
								<td rowspan="2" width="80px">质检签认</td>
								<td rowspan="2" width="80px">验收签认</td>
							</tr>
							<tr align="center">
								<td align="center" width="100px;">励磁</td>
								<td align="center" width="100px;">主</td>
								<td align="center" width="100px;">控</td>
								<td align="center" width="100px;">照</td>
								<td align="center" width="100px;">主对控</td>
							</tr>
							<tr align="center">
								<td align="center" width="30px;">${itemrec.ddjylc}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ddjyz}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ddjyk}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ddjyzh}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.ddjyzdk}&nbsp;</td>
								<td align="center">${itemrec.gzId.xm }&nbsp;</td>
								<td align="center">${itemrec.zjId.xm }&nbsp;</td>
								<td align="center">${itemrec.ysId.xm }&nbsp;</td>
							</tr>
						</table>
						
						<table align="center" border="1px" bordercolor="#aabbcc" cellspacing="0" cellpadding="0" width="100%" style="margin-top: 10px;">
							<tr>
								<td colspan="19">保护装置</td>
							</tr>
							<tr align="center">
								<td align="center" colspan="5">项目</td>
								<td rowspan="2" width="80px">交车签认</td>
								<td rowspan="2" width="80px">质检签认</td>
								<td rowspan="2" width="80px">验收签认</td>
							</tr>
							<tr align="center">
								<td align="center" width="100px;">过压</td>
								<td align="center" width="100px;">差示</td>
								<td align="center" width="100px;">极限</td>
								<td align="center" width="100px;">固发</td>
								<td align="center" width="100px;">UDK</td>
							</tr>
							<tr align="center">
								<td align="center" width="30px;">${itemrec.bhzzgy}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.bhzzcs}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.bhzzjx}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.bhzzgf}&nbsp;</td>
								<td align="center" width="30px;">${itemrec.bhzzudk}&nbsp;</td>
								<td align="center">${itemrec.gzId.xm }&nbsp;</td>
								<td align="center">${itemrec.zjId.xm }&nbsp;</td>
								<td align="center">${itemrec.ysId.xm }&nbsp;</td>
							</tr>
						</table>
					</td>
					<td width="5px;"></td>
					<%--
					<td>
						<table align="center" border="1px" bordercolor="#aabbcc" width="300px;" cellspacing="0" cellpadding="0">
							<tr align="center">
								<td width="15%" align="center">班组</td>
								<td width="20%" align="center">工号</td>
								<td width="20%" align="center">人员</td>
								<td width="45%" align="center">签到时间</td></tr>
							<c:if test="${empty sign}">
								<tr><td colspan="4" align="center">暂无记录!</td></tr>
							</c:if>
							<c:forEach items="${sign}" var="sign">
								<tr align="center">
									<td>${sign.bzName}</td>
									<td>${sign.user.gonghao }</td>
									<td>${sign.user.xm }</td>
									<td>${sign.signTime }</td>
								</tr>
							</c:forEach>
						</table>
					</td>
					 --%>
				</tr>
			</table>
		</div>
	</body>
</html>
