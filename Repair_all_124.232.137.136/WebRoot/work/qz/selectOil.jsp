<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<title>查询结果</title>
	<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />
	<meta http-equiv="Content-Type" content="text/html; charset=UFT-8">
	<style type="text/css">
		TABLE.bluetable {
			FONT: 100% Arial, Helvetica, sans-serif
		}
		TD {
			FONT: 100% Arial, Helvetica, sans-serif
		}
		TABLE.bluetable {
			MARGIN: 0.1em 0px; BORDER-COLLAPSE: collapse
		}
		TABLE.bluetable TH {
			BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: left; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
		}
		TABLE.bluetable TD {
			BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: left; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
		}
		TABLE.bluetable TH {
			BACKGROUND: url(images/tr_back.gif) #328aa4 repeat-x; COLOR: #fff
		}
		TABLE.bluetable TD {
			BACKGROUND: #e5f1f4
		}
		TABLE.bluetable TR.even TD {
			BACKGROUND: #e5f1f4
		}
		TABLE.bluetable TR.odd TD {
			BACKGROUND: #f8fbfc
		}
		TABLE.bluetable TH.over {
			BACKGROUND: #4a98af
		}
		TABLE.bluetable TR.even TH.over {
			BACKGROUND: #4a98af
		}
		TABLE.bluetable TR.odd TH.over {
			BACKGROUND: #4a98af
		}
		TABLE.bluetable TH.down {
			BACKGROUND: #bce774
		}
		TABLE.bluetable TR.even TH.down {
			BACKGROUND: #bce774
		}
		TABLE.bluetable TR.odd TH.down {
			BACKGROUND: #bce774
		}
		TABLE.bluetable TH.selected {
			
		}
		TABLE.bluetable TR.even TH.selected {
			
		}
		TABLE.bluetable TR.odd TH.selected {
			
		}
		TABLE.bluetable TD.over {
			BACKGROUND: #ecfbd4
		}
		TABLE.bluetable TR.even TD.over {
			BACKGROUND: #ecfbd4
		}
		TABLE.bluetable TR.odd TD.over {
			BACKGROUND: #ecfbd4
		}
		TABLE.bluetable TD.down {
			BACKGROUND: #bce774; COLOR: #fff
		}
		TABLE.bluetable TR.even TD.down {
			BACKGROUND: #bce774; COLOR: #fff
		}
		TABLE.bluetable TR.odd TD.down {
			BACKGROUND: #bce774; COLOR: #fff
		}
		TABLE.bluetable TD.selected {
			BACKGROUND: #bce774; COLOR: #555
		}
		TABLE.bluetable TR.even TD.selected {
			BACKGROUND: #bce774; COLOR: #555
		}
		TABLE.bluetable TR.odd TD.selected {
			BACKGROUND: #bce774; COLOR: #555
		}
		TABLE.bluetable TD.empty {
			BACKGROUND: #fff
		}
		TABLE.bluetable TR.odd TD.empty {
			BACKGROUND: #fff
		}
		TABLE.bluetable TR.even TD.empty {
			BACKGROUND: #fff
		}
	</style>
</head>
<body style="background: #fff;">
	<center>
		<h2>机车油水化验查询结果</h2>
	</center>
	<table width="100%" class="bluetable">
		<tr>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width:7%;">机车型号</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width:7%;">机车编号</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width:7%;">修程修次</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width:4%;">股道</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width:4%;">台位</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width: 10%;">扣车时间</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width: 15%;">计划起机时间/实际起机时间</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width: 15%;">计划交车时间/实际交车时间</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width:7%;">交车工长</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width:7%;">检修节点</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width:4%;">状态</th>
			<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;width: 10%;">操作</th>
		</tr>
	
		<c:forEach var="oilAPRecorder" items="${oilAPRecorderList }">
			<tr>
				<td style="text-align: center;">
				  <c:if test="${oilAPRecorder.dpId.projectType==0}">${oilAPRecorder.dpId.jcType }</c:if>
				  <c:if test="${oilAPRecorder.dpId.projectType==1}"><a href="<%=basePath%>query!findJCAll.do?rjhmId=${oilAPRecorder.dpId.rjhmId}&jcStype=${oilAPRecorder.dpId.jcType }" target="_blank">${dp.jcType }</a></c:if>
				</td>
				<td style="text-align: center;">
					${oilAPRecorder.dpId.jcnum }
				</td>
				<td style="text-align: center;">${oilAPRecorder.dpId.fixFreque }</td>
				<td style="text-align: center;">${oilAPRecorder.dpId.gdh }</td>
				<td style="text-align: center;">${oilAPRecorder.dpId.twh }</td>
				<td style="text-align: center;">${oilAPRecorder.dpId.kcsj }</td>
				<td style="text-align: center;">${fn:substring(oilAPRecorder.dpId.jhqjsj,5,16) }--${fn:substring(oilAPRecorder.dpId.sjqjsj,5,16) }</td>
				<td style="text-align: center;">${fn:substring(oilAPRecorder.dpId.jhjcsj,5,16) }--${fn:substring(oilAPRecorder.dpId.sjjcsj,5,16) }</td>
				<td style="text-align: center;">${dp.gongZhang.xm }</td>
				<td style="text-align: center;">${dp.nodeid.nodeName }</td>
				<td style="text-align: center;">
					<c:if test="${oilAPRecorder.dpId.planStatue==-1 }">新建</c:if>
					<c:if test="${oilAPRecorder.dpId.planStatue==0 }">在修</c:if>
					<c:if test="${oilAPRecorder.dpId.planStatue==1 }">待验</c:if>
					<c:if test="${oilAPRecorder.dpId.planStatue==2 }">已交</c:if>
					<c:if test="${oilAPRecorder.dpId.planStatue==3 }">转出</c:if>
				</td>
				<td style="text-align: center;">
					<c:if test="${oilAPRecorder.dpId.projectType==0}">
						<a href="<%=basePath%>qz!findOilAssayByRjhId.do?rjhmId=${oilAPRecorder.dpId.rjhmId }" target="_blank">记录查看</a>
					</c:if>
					<c:if test="${oilAPRecorder.dpId.projectType==1}">
						<a href="<%=basePath%>qz!findOilAssayByRjhId.do?rjhmId=${oilAPRecorder.dpId.rjhmId }" target="_blank">记录查看</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${empty oilAPRecorderList}"><td colspan="12" style="text-align: center;">该时间段内无相应机车信息!</td></c:if>
		<tr></tr>
	</table>
</body>
</html>