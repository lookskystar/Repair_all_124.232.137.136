<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=basePath %>css/import_basic.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>
<title>Insert title here</title>
<style>
#infotable,#bzFinishiInfo{
	border-collapse: collapse;
}

#infotable th,#infotable td,#bzFinishiInfo th,#bzFinishiInfo td{
	border:1px solid #82A8F9;
	padding-left:2px;
	padding-right:2px;
	height:25px;
	line-height:25px;
}

#jcinfo a{
	font-size:12px;
	border:1px solid #999;
	display:block;
	float:left;
	width:60px;
	text-decoration: none;
	height:20px;
	line-height: 20px;
	text-align: center;
	margin-right:5px;
	font-weight: bold;
	background-color:#900;
	color:#fff;
}
</style>
<script type="text/javascript">
	function showOrHide(){
		$("#bzFinishiInfo").show();
	}
	function move(rjhmId){
		var gdh = $("#gdh").val();
		var twh = $("#twh").val();
		if(gdh==null || gdh==""){
			alert("请输入股道号!");
		}else if(twh==null || twh==""){
			alert("请输入台位号!");
		}else{
			$.post("<%=basePath %>query!moveJC.do",{"rjhmId":rjhmId,"gdh":gdh,"twh":twh},function(text){
				if(text=="success"){
					alert("转移成功!");
					parent.location.reload();
				}else{
					alert("操作失败!");
				}
			});
		}
	}
	function searchJC(){
		var jcnum = $("#jcnum").val();
		if(jcnum!=''){
			window.parent.location.href="<%=basePath%>query!showHistory.do?jcNum="+jcnum;
		}
	}
</script>
</head>
<body>
<center>
<table class="tableStyle" style="width:550px;" id="infotable">
	<tr>
		<th align="center">车型</th>
		<th align="center">车号</th>
		<th align="center">修程</th>
		<th align="center">扣车时间</th>
		<th align="center">计划起机时间</th>
		<th align="center">计划交车时间</th>
		<th align="center">检修状态</th>
	</tr>
	<tr>
		<td>${datePlan.jcType }</td>
		<td>${datePlan.jcnum }</td>
		<td>${datePlan.fixFreque }</td>
		<td>${datePlan.kcsj }</td>
		<td>${datePlan.jhqjsj }</td>
		<td>${datePlan.jhjcsj }</td>
		<td>
			<c:if test="${datePlan.planStatue==-1 }">接车</c:if>
			<c:if test="${datePlan.planStatue==0 }">检修作业</c:if>
			<c:if test="${datePlan.planStatue==1 }">待验</c:if>
			<c:if test="${datePlan.planStatue==2 }">已交验</c:if>
			<c:if test="${datePlan.planStatue==3 }">机车转出</c:if>
		</td>
	</tr>
</table>
<table class="tableStyle" style="width:550px;" id="jcinfo">
	<tr>
		<td>
		<c:choose>
			<c:when test="${datePlan.fixFreque=='LX' || datePlan.fixFreque=='JG'|| datePlan.fixFreque=='ZZ'}">
				<a href="<%=basePath %>query!getInfoByJC.do?jcStype=${datePlan.jcType }&jcNum=${datePlan.jcnum }&xcxc=${datePlan.fixFreque }&rjhmId=${datePlan.rjhmId }" target="_blank">机车</a>
			</c:when>
			<c:when test="${datePlan.fixFreque=='QZ' || datePlan.fixFreque=='CJ'}">
				<a href="<%=basePath %>query!view.do?jcStype=${datePlan.jcType }&jcNum=${datePlan.jcnum }&xcxc=${datePlan.fixFreque }&rjhmId=${datePlan.rjhmId }" target="_blank">机车</a>
			</c:when>
			<c:otherwise>
				<c:if test="${datePlan.projectType==0}">
				  <a href="<%=basePath %>query!view.do?rjhmId=${datePlan.rjhmId }" target="_blank">专业</a>
				  <a href="<%=basePath %>query!getInfoByBZ.do?workFlag=1&rjhmId=${datePlan.rjhmId }" target="_blank">班组</a>
				  <a href="<%=basePath %>query!getInfoByJC.do?rjhmId=${datePlan.rjhmId }&psize=100" target="_blank">机车</a>
				</c:if> 
				<c:if test="${datePlan.projectType==1}">
				  <a href="<%=basePath %>query!zxView.do?rjhmId=${datePlan.rjhmId}" target="_blank">专业</a>
				  <a href="<%=basePath %>query!getZxInfoByBZ.do?workFlag=1&rjhmId=${datePlan.rjhmId}" target="_blank">班组</a>
				  <a href="<%=basePath %>query!getZxInfoByJC.do?rjhmId=${datePlan.rjhmId}&psize=100" target="_blank">机车</a>
				</c:if>
			</c:otherwise>
		</c:choose>
		<a href="<%=basePath %>query!showHistory.do?jcStype=${datePlan.jcType }&jcNum=${datePlan.jcnum }&rjhmId=${datePlan.rjhmId }" target="_blank">历史</a>
		<a href="<%=basePath %>query!getAllInfoPre.do?rjhmId=${datePlan.rjhmId }" target="_blank">报活</a>
		<a href="<%=basePath %>query!searchJCjungong.do?rjhmId=${datePlan.rjhmId }" target="_blank">竣工</a>
		<c:if test="${datePlan.projectType==0}">
		  <a href="<%=basePath %>query!searchJcRec.do?rjhmId=${datePlan.rjhmId }&jcStype=${datePlan.jcType }" target="_blank">交车</a>
		</c:if>
		<c:if test="${datePlan.projectType==1}">
		  <a href="<%=basePath %>query!viewExperiment.do?id=${datePlan.rjhmId}&jceiId=5" target="_blank">交车</a>
		</c:if>
		<a href="<%=basePath %>oilAssay!searchOilAssayRecorderDaily.do?rjhmId=${datePlan.rjhmId }" target="_blank">化验单</a>
		</td>
		
	</tr>
	<tr>
		<td>
			<table width="100%">
				<tr>
				<td align="right">
					股道号：<input type="text" value="${datePlan.gdh }" style="width: 40px;" id="gdh" onkeyup="this.value=this.value.replace(/\D/g,'')"/>&nbsp;&nbsp;
					台位号：<input type="text" value="${datePlan.twh }" id="twh" style="width: 40px;" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
				</td>
				<td align="left"><a href="javascript:void(0);" onclick="move('${datePlan.rjhmId}')">股道转移</a></td>
				<td align="right">
					机车号：<input type="text" value="${datePlan.jcnum }" style="width: 80px;" id="jcnum"/>
				</td>
				<td align="left">
					<a href="javascript:void(0);" onclick="searchJC()">查询</a>
				</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table id="bzFinishiInfo" class="tableStyle" style="width:550px;">
	<tr><th align="center">检修班组</th><th align="center">完成时间</th><th align="center">检修情况</th><th align="center">所处节点</th></tr>
	<c:forEach items="${flowRecs}" var="rec">
		<tr>
			<td align="center">${rec.proTeam.proteamname }</td>
			<td align="center">${rec.finishTime }</td>
			<td align="center">
			  <c:if test="${datePlan.projectType==0}">
			     <c:choose>
					<c:when test="${rec.finishStatus==0}">
						<a  style="color: #f00" href="<%=basePath %>query!getInfoByBZ.do?workFlag=1&teamId=${rec.proTeam.proteamid }&rjhmId=${datePlan.rjhmId }" target="_blank">未完成</a>
					</c:when>
					<c:otherwise>
						<a href="<%=basePath %>query!getInfoByBZ.do?workFlag=1&teamId=${rec.proTeam.proteamid }&rjhmId=${datePlan.rjhmId }" target="_blank">完成</a>
					</c:otherwise>
				</c:choose>
			  </c:if>
			  <c:if test="${datePlan.projectType==1}">
			    <c:choose>
					<c:when test="${rec.finishStatus==0}">
						<a  style="color: #f00" href="<%=basePath %>query!getZxInfoByBZ.do?rjhmId=${datePlan.rjhmId}&workFlag=1&teamId=${rec.proTeam.proteamid }&nodeId=${rec.fixflow.jcFlowId}" target="_blank">未完成</a>
					</c:when>
					<c:otherwise>
						<a href="<%=basePath %>query!getZxInfoByBZ.do?rjhmId=${datePlan.rjhmId}&workFlag=1&teamId=${rec.proTeam.proteamid }&nodeId=${rec.fixflow.jcFlowId}" target="_blank">完成</a>
					</c:otherwise>
				</c:choose>
			  </c:if>
			</td>
			<td align="center">
			  <c:choose>
			    <c:when test="${rec.fixflow.jcFlowId==100}">机车分解</c:when>
			    <c:when test="${rec.fixflow.jcFlowId==101}">车上组装</c:when>
			    <c:otherwise>小辅修</c:otherwise>
			  </c:choose>
			</td>
		</tr>
	</c:forEach>
</table>
<c:if test="${datePlan.projectType==0&&datePlan.planStatue!=-1}">
<br/>
<table id="bzFinishiInfo" class="tableStyle" style="width:550px;">
  <tr>
      <th align="center">试验项目</th>
      <th align="center">工人</th>
      <th align="center">工长</th>
      <th align="center">质检员</th>
      <th align="center">技术员</th>
      <th align="center">交车工长</th>
      <th align="center">验收员</th>
         <c:if test="${!empty map}">
           <tr>
            <td>${map.item}</td>
            <td>
              <c:if test="${map.grFinished==0}">完成</c:if>
              <c:if test="${map.grFinished!=0}"><font style="color: #f00">未签完</font></c:if>
            </td>
            <td>
              <c:if test="${map.gzFinished==0}">完成</c:if>
              <c:if test="${map.gzFinished!=0}"><font style="color: #f00">未签完</font></c:if>
            </td>
            <td>
              <c:if test="${map.zjFinished==0}">完成</c:if>
              <c:if test="${map.zjFinished!=0}"><font style="color: #f00">未签完</font></c:if>
            </td>
            <td>
              <c:if test="${map.jsFinished==0}">完成</c:if>
              <c:if test="${map.jsFinished!=0}"><font style="color: #f00">未签完</font></c:if>
            </td>
            <td>
              <c:if test="${map.jcgzFinished==0}">完成</c:if>
              <c:if test="${map.jcgzFinished!=0}"><font style="color: #f00">未签完</font></c:if>
            </td>
            <td>
              <c:if test="${map.ysFinished==0}">完成</c:if>
              <c:if test="${map.ysFinished!=0}"><font style="color: #f00">未签完</font></c:if>
            </td>
           </tr>
      	 </c:if>
 </tr>
</table>
</c:if>
</center>
</body>
</html>