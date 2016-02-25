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
	<title>报活详细</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=basePath%>" />
	<!--框架必需end-->
</script>
	<body>
		<div class="box1" whiteBg="true">
			<table width="100%" class="tableStyle">
				<tr align="center">
					<td rowspan="4" colspan="6" width="65%">
						<c:if test="${!empty jtPreDict.imgUrl}">
							<a href="<%=basePath%>${jtPreDict.imgUrl}" title="点击查看原图" target="_blank"><img src="<%=basePath%>${jtPreDict.imgUrl}" alt="报活图"  width="200"/></a>
						</c:if>
						<c:if test="${empty jtPreDict.imgUrl}">无报活图片</c:if>
					</td>
				</tr>
				<tr>
					<td align="center">
						机车类型
					</td>
					<td align="center" colspan="4">
						${jtPreDict.datePlanPri.jcType}
					</td>
				</tr>
				<tr>
					<td align="center">
						机车编号
					</td>
					<td align="center" colspan="4">
						${jtPreDict.datePlanPri.jcnum}
					</td>
				</tr>
				<tr>
					<td align="center">
						修程修次
					</td>
					<td align="center" colspan="4">
						${jtPreDict.datePlanPri.fixFreque}
					</td>
				</tr>
				<tr>
					<td align="center">
						报活类型
					</td>
					<td align="center">
						<c:if test="${jtPreDict.type==0}">
							JT28报活
						</c:if>
						<c:if test="${jtPreDict.type==1}">
							复检报活
						</c:if>
						<c:if test="${jtPreDict.type==2}">
							检修过程报活
						</c:if>
						<c:if test="${jtPreDict.type==6}">
							零公里报活
						</c:if>
					</td>
					<td align="center">
						对应项目
					</td>
					<td align="center">
						${jtPreDict.thirdUnitId.itemName}
					</td>
					<td align="center">
						项目卡控
					</td>
					<td align="center" colspan="3">
						技术员<input type="checkbox" disabled="disabled" <c:if test="${jtPreDict.itemCtrlTech==1}">checked</c:if>/> 质检员 <input type="checkbox" disabled="disabled" <c:if test="${jtPreDict.itemCtrlQI==1}">checked</c:if>/> 交车工长 <input type="checkbox" disabled="disabled" <c:if test="${jtPreDict.itemCtrlComLd==1}">checked</c:if>/> 验收员 <input type="checkbox" disabled="disabled" <c:if test="${jtPreDict.itemCtrlAcce==1}">checked</c:if>/> 
					</td>
				</tr>
				<tr>
					<td align="center">
						故障部位
					</td>
					<td align="center">
						${jtPreDict.repPosi}
					</td>
					<td align="center">
						报活情况
					</td>
					<td align="center">
						${jtPreDict.repsituation}
					</td>
					<td align="center">
						报活人
					</td>
					<td align="center">
						${jtPreDict.repemp}
					</td>
					<td align="center">
						报活时间
					</td>
					<td align="center">
						${jtPreDict.repTime}
					</td>
				</tr>
				<tr>
					<td align="center">
						审批人
					</td>
					<td align="center">
						${jtPreDict.verifier}
					</td>
					<td align="center">
						审批时间
					</td>
					<td colspan="5" align="center">
						${jtPreDict.verifyTime}
					</td>
				</tr>
				<tr>
					<td align="center">
						报修班组
					</td>
					<td align="center" colspan="3">
						${jtPreDict.proTeamId.proteamname}
					</td>
					<td align="center">
						接收人
					</td>
					<td align="center" colspan="3">
						${jtPreDict.fixEmp}
					</td>
				</tr>
				<tr>
					<td align="center">
						检修人
					</td>
					<td align="center">
						${jtPreDict.dealFixEmp}
					</td>
					<td align="center">
						处理情况
					</td>
					<td align="center">
						${jtPreDict.dealSituation}
					</td>
					<td align="center">
						检修人签字时间
					</td>
					<td align="center" colspan="3">
						${jtPreDict.fixEndTime}
					</td>
				</tr>
				<tr>
					<td align="center">
						工长
					</td>
					<td align="center">
						${jtPreDict.lead}
					</td>
					<td align="center">
						签字时间
					</td>
					<td align="center" colspan="5">
						${jtPreDict.ldAffirmTime}
					</td>
				</tr>
				<tr>
					<td align="center">
						技术员
					</td>
					<td align="center">
						${jtPreDict.technician}
					</td>
					<td align="center">
						签字时间
					</td>
					<td align="center" colspan="5">
						${jtPreDict.techAffiTime}
					</td>
				</tr>
				<tr>
					<td align="center">
						质检员
					</td>
					<td align="center">
						${jtPreDict.qi}
					</td>
					<td align="center">
						签字时间
					</td>
					<td align="center" colspan="5">
						${jtPreDict.qiAffiTime}
					</td>
				</tr>
				<tr>
					<td align="center">
						交车工长
					</td>
					<td align="center">
						${jtPreDict.commitLd}
					</td>
					<td align="center">
						签字时间
					</td>
					<td align="center" colspan="5">
						${jtPreDict.comLdAffiTime}
					</td>
				</tr>
				<tr>
					<td align="center">
						验收员
					</td>
					<td align="center">
						${jtPreDict.accepter}
					</td>
					<td align="center">
						签字时间
					</td>
					<td align="center" colspan="5">
						${jtPreDict.acceTime}
					</td>
				</tr>
				<tr>
					<td align="center">
						状态
					</td>
					<td align="center" colspan="7">
						<c:if test="${jtPreDict.recStas==-1}">
							审批未通过
						</c:if>
						<c:if test="${jtPreDict.recStas==0}">
							新报
						</c:if>
						<c:if test="${jtPreDict.recStas==1}">
							审批通过
						</c:if>
						<c:if test="${jtPreDict.recStas==2}">
							接收
						</c:if>
						<c:if test="${jtPreDict.recStas==3}">
							处理完成
						</c:if>
						<c:if test="${jtPreDict.recStas==4}">
							工长核验
						</c:if>
						<c:if test="${jtPreDict.recStas==5}">
							质检员、验收员等核验
						</c:if>
						<c:if test="${jtPreDict.recStas==9}">
							完成存档
						</c:if>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>