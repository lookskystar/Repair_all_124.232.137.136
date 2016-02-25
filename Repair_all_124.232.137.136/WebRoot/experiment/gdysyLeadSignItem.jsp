<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@include file="/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>">

		<title>选择高低压试验项目</title>
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/framework.js"></script>
		<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" id="skin"
			prePath="<%=basePath%>" />
		<!--框架必需end-->

		<!--截取文字start-->
		<script type="text/javascript" src="js/text/text-overflow.js"></script>
		<script type="text/javascript" src="experiment/js/experiment.js"></script>
		<script type="text/javascript" src="experiment/js/jquery.messager.js"></script>
		<!--截取文字end-->
		<style type="text/css">
body {
	margin: 0;
	padding: 0;
	font-size: 12px;
}

tr {
	text-algin: center;
}

td {
	height: 20px;
	line-height: 20px;
}

a:LINK,a:VISITED {
	color: blue;
	width: 100%;
	text-align: center;
}
</style>
	</head>

	<body>
		<div class=Section1 style='layout-grid: 15.6pt'>
			<p align=center style='text-align: center'>
				<b><u><span lang=EN-US
						style='font-size: 18.0pt; font-family: 黑体; letter-spacing: -.5pt'>&nbsp;&nbsp;&nbsp;
					</span> </u> </b><b><u><span
						style='font-size: 18.0pt; font-family: 黑体; letter-spacing: -.5pt'>${datePlan.jcType}-${datePlan.jcnum}
							型机车低高压试验及试运作业过程控制记录</span> </u> </b>
			</p>
			<div align=center>
				<table border=1 cellspacing=0 cellpadding=0 width=786>
					<tr>
						<td width=286 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>机车号</span>
							</p>
						</td>
						<td width=67 colspan=6 valign=top>
							${datePlan.jcnum}
						</td>
						<td width=58 colspan=6 valign=top>
							<p
								style='text-align: justify; text-justify: distribute-all-lines; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>修程</span>
							</p>
						</td>
						<td width=48 colspan=6 valign=top>
							${datePlan.fixFreque}
						</td>
						<td width=81 colspan=6 valign=top>
							<p style='line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>扣车时间</span>
							</p>
						</td>
						<td width=121 colspan=6 valign=top>
							${datePlan.kcsj}
						</td>
						<td width=180 valign=top>
							<c:if test="${roleFlag==2}">
					    		<c:choose>
					    			<c:when test="${!empty experiment.leader}"><span style="font-size: 14px;font-weight: bold;color: blue;">工长：${experiment.leader}</span></c:when>
					    			<c:otherwise><input type="button" onclick="signAll()" value="工长全签"/></c:otherwise>
					    		</c:choose>
					    	</c:if>
					      	<c:if test="${roleFlag==3}">
						      	<c:choose>
						      		<c:when test="${!empty experiment.qi}"><span style="font-size: 14px;font-weight: bold;color: blue;">质检员：${experiment.qi}</span></c:when>
						    		<c:otherwise><input type="button" onclick="signAll()" value="质检员全签"/></c:otherwise>
						    	</c:choose>
					      	</c:if>
					      	<c:if test="${roleFlag==4}">
					      		<c:choose>
					      			<c:when test="${!empty experiment.teachName}"><span style="font-size: 14px;font-weight: bold;color: blue;">技术员：${experiment.teachName}</span></c:when>
					    			<c:otherwise><input type="button" onclick="signAll()" value="技术员全签"/></c:otherwise>
					      		</c:choose>
					      	</c:if>
					      	<c:if test="${roleFlag==5}">
					      		<c:choose>
					      			<c:when test="${!empty experiment.commitLead}"><span style="font-size: 14px;font-weight: bold;color: blue;">交车工长：${experiment.commitLead}</span></c:when>
					    			<c:otherwise><input type="button" onclick="signAll()" value="交车工长全签"/></c:otherwise>
					      		</c:choose>
					      	</c:if>
					      	<c:if test="${roleFlag==6}">
					      		<c:choose>
					      			<c:when test="${!empty experiment.accepter}"><span style="font-size: 14px;font-weight: bold;color: blue;">验收员：${experiment.accepter}</span></c:when>
					    			<c:otherwise><input type="button" onclick="signAll()" value="验收员全签"/></c:otherwise>
					      		</c:choose>
					      	</c:if>
						</td>
					</tr>
					<tr>
						<td width="100%" colspan=38 valign=top>
							<p style='line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>上台前高压试验情况：</span>
								${itemRecs.gdy_1}
							</p>
						</td>
					</tr>
					<tr>
						<td width=586 colspan=3 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>试验时间</span>
							</p>
						</td>
						<td width=95 colspan=13 valign=top>
							<c:choose>
								<c:when test="${empty experiment || empty experiment.empAffirmTime}">
									<input type="text" id="sytime" class="Wdate"
										onfocus="WdatePicker()" value="${experiment.empAffirmTime}"
										style="width: 85px;" />
									<input type="button" value="提交时间" onclick="changeExpTime()"
										style="width: 60px;" />
								</c:when>
								<c:otherwise>
									<input type="text" id="sytime" class="Wdate"
										onfocus="WdatePicker()" value="${experiment.empAffirmTime}"
										style="width: 85px;" />
									<input type="button" value="修改时间" onclick="changeExpTime()"
										style="width: 60px;" />
								</c:otherwise>
							</c:choose>
						</td>
						<td width=108 colspan=9 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>地勤司机</span>
							</p>
						</td>
						<td width=96 colspan=13 valign=top>
							${itemRecs.gdy_2}
						</td>
					</tr>
					<tr>
						<td width=586 rowspan=9>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>低</span>
							</p>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>压</span>
							</p>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>试</span>
							</p>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>验</span>
							</p>
						</td>
						<td width=535 colspan=37 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312; letter-spacing: 6.0pt'>低压试验前绝缘检测</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=535 colspan=9 valign=top>
							<p
								style='text-align: justify; text-justify: distribute-all-lines; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>主对地</span>
							</p>
						</td>
						<td width=129 colspan=13 valign=top>
							<p
								style='text-align: justify; text-justify: distribute-all-lines; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>辅对地</span>
							</p>
						</td>
						<td width=129 colspan=9 valign=top>
							<p
								style='text-align: justify; text-justify: distribute-all-lines; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>控对地</span>
							</p>
						</td>
						<td width=133 colspan=6 valign=top>
							<p
								style='text-align: justify; text-justify: distribute-all-lines; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>原边对地</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=235 colspan=9 valign=top>
								${itemRecs.gdy_3}
								MΩ 
						</td>
						<td width=229 colspan=13 valign=top>
							    ${itemRecs.gdy_4}
								MΩ 
						</td>
						<td width=229 colspan=9 valign=top>
								${itemRecs.gdy_5}
								MΩ 
						</td>
						<td width=233 colspan=6 valign=top>
								${itemRecs.gdy_6}
								MΩ 
						</td>
					</tr>
					<tr>
						<td width="100%" colspan=37 valign=top align="center">
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>试验人</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=535 colspan=9 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>电器质检员</span>
							</p>
						</td>
						<td width=129 colspan=13 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>电子质检员</span>
							</p>
						</td>
						<td width=129 colspan=9 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>制动质检员</span>
							</p>
						</td>
						<td width=133 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>台车质检员</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=535 colspan=9 valign=top>
							${itemRecs.gdy_7}
						</td>
						<td width=129 colspan=13 valign=top>
							${itemRecs.gdy_8}
						</td>
						<td width=129 colspan=9 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_9}
							</p>
						</td>
						<td width=133 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_10}
							</p>
						</td>
					</tr>
					<tr>
						<td width=535 colspan=4 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>受电弓</span>
							</p>
						</td>
						<td width=89 colspan=10 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>制动</span>
							</p>
						</td>
						<td width=90 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>主断</span>
							</p>
						</td>
						<td width=122 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>架电</span>
							</p>
						</td>
						<td width=78 colspan=7 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>电子</span>
							</p>
						</td>
						<td width=103 colspan=4 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>监控</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=535 colspan=4 valign=top>
							${itemRecs.gdy_11}
						</td>
						<td width=89 colspan=10 valign=top>
							${itemRecs.gdy_12}
						</td>
						<td width=90 colspan=6 valign=top>
							${itemRecs.gdy_13}
						</td>
						<td width=122 colspan=6 valign=top>
							${itemRecs.gdy_14}
						</td>
						<td width=78 colspan=7 valign=top>
							${itemRecs.gdy_15}
						</td>
						<td width=103 colspan=4 valign=top>
							${itemRecs.gdy_16}
						</td>
					</tr>
					<tr>
						<td width=535 colspan=9 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>试验开始时间</span>
							</p>
						</td>
						<td width=129 colspan=13 valign=top>
							${itemRecs.gdy_17}
						</td>
						<td width=229 colspan=9 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>试验结束时间</span>
							</p>
						</td>
						<td width=133 colspan=6 valign=top>
							${itemRecs.gdy_18}
						</td>
					</tr>
					<tr>
						<td width=586 rowspan=7>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>高</span>
							</p>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>压</span>
							</p>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>试</span>
							</p>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>验</span>
							</p>
						</td>
						<td width=535 colspan=9 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>开始时间</span>
							</p>
						</td>
						<td width=129 colspan=13 valign=top>
							${itemRecs.gdy_19}
						</td>
						<td width=229 colspan=9 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>结束时间</span>
							</p>
						</td>
						<td width=133 colspan=6 valign=top>
							${itemRecs.gdy_20}
						</td>
					</tr>
					<tr>
						<td width=535 colspan=3 rowspan=2>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>牵引试验</span>
							</p>
						</td>
						<td width=93 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>1M</span>
							</p>
						</td>
						<td width=129 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>2M</span>
							</p>
						</td>
						<td width=86 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>3M</span>
							</p>
						</td>
						<td width=86 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>4M</span>
							</p>
						</td>
						<td width=74 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>5M</span>
							</p>
						</td>
						<td width=103 colspan="4" valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>6M</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=93 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_21}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
						<td width=129 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_22}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
						<td width=86 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_23}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
						<td width=86 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_24}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
						<td width=74 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_25}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
						<td width=103 colspan="4" valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_26}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=535 colspan=3 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>制动试验</span>
							</p>
						</td>
						<td width=93 colspan=7 valign=top>
							<p
								style='text-align: justify; text-justify: distribute-all-lines; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312; letter-spacing: -1.0pt'>励磁电流</span>
							</p>
						</td>
						<td width=123 colspan=5 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_27}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
						<td width=86 colspan=6 valign=top>
							<p
								style='text-align: justify; text-justify: distribute-all-lines; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312; letter-spacing: -1.0pt'>制动电流</span>
							</p>
						</td>
						<td width=86 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_28}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
						<td width=74 colspan=6 valign=top>
							<p style='line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312; letter-spacing: -1.0pt'>励磁电流</span>
							</p>
						</td>
						<td width=103 colspan="6" valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_29}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>A</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=535 colspan=3 rowspan=2>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>空载试验</span>
							</p>
						</td>
						<td width=93 colspan=10 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312; letter-spacing: -1.0pt'>0&nbsp;
								</span><span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312; letter-spacing: -1.0pt'>位</span>
							</p>
						</td>
						<td width=86 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>1M</span><span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>电压</span>
							</p>
						</td>
						<td width=96 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_30}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>V</span>
							</p>
						</td>
						<td width=122 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>6M</span><span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>电压</span>
							</p>
						</td>
						<td width=133 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_31}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>V</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=93 colspan=10 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312; letter-spacing: -1.0pt'>限<span
									lang=EN-US>&nbsp; </span>压</span>
							</p>
						</td>
						<td width=86 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>1M</span><span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>电压</span>
							</p>
						</td>
						<td width=96 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_32}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>V</span>
							</p>
						</td>
						<td width=122 colspan=6 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>6M</span><span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>电压</span>
							</p>
						</td>
						<td width=133 colspan=6 valign=top>
							<p align=right style='text-align: right; line-height: 125%'>
								${itemRecs.gdy_33}
								<span lang=EN-US
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>V</span>
							</p>
						</td>
					</tr>
					<tr>
						<td width=535 colspan=11 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>试验开始时间</span>
							</p>
						</td>
						<td width=108 colspan=9 valign=top>
							${itemRecs.gdy_34}
						</td>
						<td width=122 colspan=12 valign=top>
							<p align=center style='text-align: center; line-height: 125%'>
								<span
									style='font-size: 12.0pt; line-height: 125%; font-family: 楷体_GB2312'>试验结束时间</span>
							</p>
						</td>
						<td width=108 colspan="5" valign=top>
							${itemRecs.gdy_35}
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input type="hidden" id="rjhmId" value="${datePlan.rjhmId}"/>
		<input type="hidden" id="expId" value="${expId}"/>
		<input type="hidden" id="roleFlag" value="${roleFlag}"/>
	    <script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
	</body>
</html>