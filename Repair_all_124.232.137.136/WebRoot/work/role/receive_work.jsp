<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->
<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<script type="text/javascript">
	function openDialog(rjhmId,xx){
		top.Dialog.open({URL:"<%=basePath%>workAction!listRatifyItemsInput.do?rjhmId="+rjhmId+"&xx="+xx,Width:750,Height:500,Title:"检修项目"});
	}
	
	function choice(obj){
		window.location.href="workAction!receivedWorkInput.do?projectType="+obj.value;
	}

	//检修记录按钮
	function redirect(){
		parent.frmright.location.href ="<%=basePath %>report/select_main.jsp";
	}
</script>
<body>
<div id="scrollContent" class="border_gray">
	<form action="workAction!receivedWorkInput.do" method="post">
		<select id="projectType" name="projectType" onchange="choice(this);" class="default" style="width: 90px;">
			<option value="" <c:if test="${empty projectType}">selected="selected"</c:if>>全部机车</option>
			<option value="0" <c:if test="${projectType==0}">selected="selected"</c:if>>小辅修机车</option>
			<option value="1" <c:if test="${projectType==1}">selected="selected"</c:if>>中修机车</option>
		</select>
		<input type="text" id="jcNum" name="jcNum" value="${jcNum }" watermark="输入机车编号" style="line-height: 22px;vertical-align: top;width: 70px;"/>
		<input type="submit" value="查询" style="width: 60px;"/>
	</form>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	  	<tr>
	  		<td>
			<div class="dbList">
				<table class="tableStyle" id="radioTable">
				 <%--
				  <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',YSY,')}">
					<tr>
						<td colspan="5">
								<a href="<%=basePath %>report/select_main.jsp" target="frmright" style="color:red;">机车检修记录</a>
						</td>
					</tr>
				 </c:if>
				  --%>
					<tr><th align="center">机车号</th><th align="center">扣车时间</th><th align="center">交车工长</th><th align="center">所处节点</th><th align="center">状态</th></tr>
					<c:if test="${empty daprList}"><tr align="center"><td colspan="5">没有数据记录!</td></tr></c:if>
					<c:forEach var="dayPlan" items="${daprList}">
						<tr align="center">
							<td>
							 <c:choose>
							  	<c:when test="${dayPlan.nodeid.jcFlowId==102 || dayPlan.nodeid.jcFlowId==103}">
							  		 <a href="experiment!enterExperiment.do?rjhmId=${dayPlan.rjhmId}&xx=${dayPlan.fixFreque}" target="frmright" style="color:red">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							  	</c:when>
							  <c:otherwise>
							   <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',GR,')}">
								 <!-- 工人 -->
							     <c:if test="${dayPlan.projectType==0}">
							        <a href="workAction!listRatifyItemsInput.do?rjhmId=${dayPlan.rjhmId}&xx=${dayPlan.fixFreque}" target="frmright" style="color:blue" title="计划起机时间:${fn:substring(dayPlan.jhqjsj,5,16)}实起机时间：${fn:substring(dayPlan.sjqjsj,5,16) }计划交车时间：${fn:substring(dayPlan.jhjcsj,5,16) }实际交车时间：${fn:substring(dayPlan.sjjcsj,5,16) }">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							  	 <c:if test="${dayPlan.projectType==1}">
							        <a href="workAction!listZxRatifyItemsInput.do?rjhmId=${dayPlan.rjhmId}&xx=${dayPlan.fixFreque}" target="frmright" style="color:red" title="计划起机时间:${fn:substring(dayPlan.jhqjsj,5,16)}实起机时间：${fn:substring(dayPlan.sjqjsj,5,16) }计划交车时间：${fn:substring(dayPlan.jhjcsj,5,16) }实际交车时间：${fn:substring(dayPlan.sjjcsj,5,16) }">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							  </c:if>
							  <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',GZ,')}">
							     <c:if test="${dayPlan.projectType==0}">
							         <a href="work/role/role_ratify.jsp?rjhmId=${dayPlan.rjhmId}&jcstype=${dayPlan.fixFreque}&rtype=1&role=foreman" target="frmright" style="color:blue">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							     <c:if test="${dayPlan.projectType==1}">
							         <a href="work/role/zx_role_ratify.jsp?rjhmId=${dayPlan.rjhmId}&jcstype=${dayPlan.fixFreque}&rtype=1&role=foreman" target="frmright" style="color:red">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							  </c:if>
							  <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',JSY,')}">
							      <c:if test="${dayPlan.projectType==0}">
							         <a href="work/role/role_ratify.jsp?rjhmId=${dayPlan.rjhmId}&jcstype=${dayPlan.fixFreque}&rtype=2&role=tech" target="frmright" style="color:blue">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							      <c:if test="${dayPlan.projectType==1}">
							         <a href="work/role/zx_role_ratify.jsp?rjhmId=${dayPlan.rjhmId}&jcstype=${dayPlan.fixFreque}&rtype=2&role=tech" target="frmright" style="color:red">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							  </c:if>
							  <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',ZJY,')}">
							     <c:if test="${dayPlan.projectType==0}">
							         <a href="work/role/role_ratify.jsp?rjhmId=${dayPlan.rjhmId}&jcstype=${dayPlan.fixFreque}&rtype=3&role=qi" target="frmright" style="color:blue">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							     <c:if test="${dayPlan.projectType==1}">
							         <a href="work/role/zx_role_ratify.jsp?rjhmId=${dayPlan.rjhmId}&jcstype=${dayPlan.fixFreque}&rtype=3&role=qi" target="frmright" style="color:red">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							  </c:if>
							  <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',YSY,')}">
							     <c:if test="${dayPlan.projectType==0}">
							         <a href="work/role/role_ratify.jsp?rjhmId=${dayPlan.rjhmId}&jcstype=${dayPlan.fixFreque}&rtype=5&role=accept" target="frmright" style="color:blue">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							     <c:if test="${dayPlan.projectType==1}">
							         <a href="work/role/zx_role_ratify.jsp?rjhmId=${dayPlan.rjhmId}&jcstype=${dayPlan.fixFreque}&rtype=5&role=accept" target="frmright" style="color:red">${dayPlan.jcType}-${dayPlan.jcnum}-${dayPlan.fixFreque}</a>
							     </c:if>
							  </c:if>
							  </c:otherwise>
							 </c:choose>
							</td>
							<td>${dayPlan.kcsj}</td>
							<td>${dayPlan.gongZhang.xm}</td>
							<td>
							  <c:choose>
							    <c:when test="${dayPlan.nodeid.jcFlowId==100}">机车分解</c:when>
							    <c:when test="${dayPlan.nodeid.jcFlowId==101}">车上组装</c:when>
							    <c:when test="${dayPlan.nodeid.jcFlowId==102}">机车试验</c:when>
							    <c:when test="${dayPlan.nodeid.jcFlowId==103}">试运行</c:when>
							    <c:otherwise>小辅修</c:otherwise>
							  </c:choose>
							</td>
							<td>
							  <c:if test="${dayPlan.planStatue==0}">在修</c:if>
							  <c:if test="${dayPlan.planStatue==1}">待验</c:if>
							  <c:if test="${dayPlan.planStatue==2}">已交</c:if>
							</td>
						</tr>
					</c:forEach>
					<tr>
					  <td colspan="5"></td>
					</tr>
				</table>
				<div class="clear"></div>
			</div>
	  		</td>	
		 </tr>
	</table>
</div>				
</body>
</html>