<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--修正IE6支持透明PNG图start-->
    <script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
    <!--修正IE6支持透明PNG图end-->
    <script type="text/javascript">
    
    //关闭此页面
	function toclose(){
		top.Dialog.close();
	}  
	
	</script>

</head>
<body>
<div class="box1" whiteBg="true">
   <c:if test="${!empty signrec}">
     <form method="post" action="">
     <input type="hidden" id="signId" value="${sign.signId }"/>
		<table class="tableStyle" formMode="true">
		   <tr>
		        <td>班&nbsp;组：</td>
				<td >
					 <c:forEach items="${dictProTeamList}" var="entry">
    	                 <c:if test="${entry.proteamid==signrec.proteamId}">${entry.proteamname}</c:if>
    	             </c:forEach>
				</td>
				<td>日&nbsp;期：</td>
				<td >
    	             ${signrec.day}
				</td>
			</tr>
			<tr>
				<td>姓&nbsp;名：</td>
				<td>${signrec.xm}</td>
				<td>工&nbsp;号：</td>
				<td>${signrec.gonghao}</td>
			</tr>
			<script type="text/javascript">
				<c:if test="${signrec.signCount==1}">
					$("#signCount").hide();
					$("#signCount1").hide();
					$("#signCount2").show();
				</c:if>
				<c:if test="${signrec.reSignTypeId!=1&&signrec.reSignTypeId!=0}">
				    $("#reSignTypeId").show();
				    $("#reSignTypeId2").show();
			    </c:if>
			</script>
			<tr id="signCount" >
              <td >上班1：</td>
              <td>
                   <c:choose>
                      <c:when test="${fn:contains(signrec.signFlag,',1,')}">
                          ${signrec.signtimeA }&nbsp;&nbsp;<span style="color:red">补</span>
                      </c:when>
                      <c:otherwise>
                          ${signrec.signtimeA }
                      </c:otherwise>
                   </c:choose>
              </td>
              <td >下班1：</td>
              <td>
                   <c:choose>
                      <c:when test="${fn:contains(signrec.signFlag,',2,')}">
                          ${signrec.signtimeB }&nbsp;&nbsp;<span style="color:red">补</span>
                      </c:when>
                      <c:otherwise>
                          ${signrec.signtimeB }
                      </c:otherwise>
                   </c:choose>
              </td>
            </tr>
            <tr id="signCount1" >
              <td >上班2：</td>
              <td>
                   <c:choose>
                      <c:when test="${fn:contains(signrec.signFlag,',3,')}">
                          ${signrec.signtimeC }&nbsp;&nbsp;<span style="color:red">补</span>
                      </c:when>
                      <c:otherwise>
                          ${signrec.signtimeC }
                      </c:otherwise>
                   </c:choose>
              
              </td>
              <td >下班2：</td>
              <td>
                   <c:choose>
                      <c:when test="${fn:contains(signrec.signFlag,',4,')}">
                          ${signrec.signtimeD }&nbsp;&nbsp;<span style="color:red">补</span>
                      </c:when>
                      <c:otherwise>
                          ${signrec.signtimeD }
                      </c:otherwise>
                   </c:choose>
              </td>
            </tr>
			<tr id="signCount2" style="display: none">
              <td >上班：</td>
              <td>
                   <c:choose>
                      <c:when test="${fn:contains(signrec.signFlag,',1,')}">
                          ${signrec.signtimeA }&nbsp;&nbsp;<span style="color:red">补</span>
                      </c:when>
                      <c:otherwise>
                          ${signrec.signtimeA }
                      </c:otherwise>
                   </c:choose>
              </td>
              <td >下班：</td>
              <td>
                   <c:choose>
                      <c:when test="${fn:contains(signrec.signFlag,',2,')}">
                          ${signrec.signtimeB }&nbsp;&nbsp;<span style="color:red">补</span>
                      </c:when>
                      <c:otherwise>
                          ${signrec.signtimeB }
                      </c:otherwise>
                   </c:choose>
              </td>
            </tr>
            <tr>
				<td>应出勤：</td>
				<td>${signrec.attendance}</td>
				<td>实出勤：</td>
				<td>${signrec.realAttendance}</td>
			</tr>
			<tr>
				<td>迟&nbsp;到：</td>
				<td><input type="checkbox"   <c:if test="${signrec.islate==1}">checked="checked"</c:if>>是</input></td>
				<td>早&nbsp;退：</td>
				<td><input type="checkbox"  <c:if test="${signrec.isgoearly==1}">checked="checked"</c:if>>是</input></td>
			</tr>
			<tr>
				<td>旷&nbsp;工：</td>
				<td><input type="checkbox"  <c:if test="${signrec.isabsenteeism==1}">checked="checked"</c:if>>是</input></td>
				<td>请&nbsp;假：</td>
				<td><input type="checkbox"  <c:if test="${signrec.reSignTypeId!=1&&signrec.reSignTypeId!=0}">checked="checked"</c:if>>是</input></td>
			</tr>
			<tr id="reSignTypeId" style="display: none">
				<td>请假类型：</td>
				<td colspan="3">
				    <c:forEach items="${resignTypeList}" var="entry">
				       <c:if test="${entry.typeId!=1}">
	                     <input type="radio"  <c:if test="${entry.typeId==signrec.reSignTypeId}">checked="checked"</c:if>>${entry.typeName}</input>
	                   </c:if>
	                 </c:forEach>
				</td>
			</tr>
			<tr id="reSignTypeId2" style="display: none">
				<td>请假开始时间：</td>
				<td>${signrec.noworkBegintime}</td>
				<td>请假结束时间：</td>
				<td>${signrec.noworkEndtime}</td>
			</tr>
			<tr>
				<td>补签操作人：</td>
				<td>${signrec.operator}</td>
				<td>操作时间：</td>
				<td>${signrec.operatorTime}</td>
			</tr>
			<tr>
				<td>补签原因：</td>
				<td colspan="3">
					${signrec.resignReason }
				</td>
			</tr>
			<tr>
				<td>签到时间：</td>
				<td colspan="3">
					<c:forEach items="${basicSign}" var="entry" >
    	                 ${entry}<br/>
    	             </c:forEach>
				</td>
			</tr>
			<tr>
			   <td colspan="4" align="center"><input type="button" value="确定" onclick="toclose();"/></td>
			</tr>
		</table>
		<div align="center"></div>
	</form>
  </c:if>
  <c:if test="${empty signrec}"><div align="center"><span style="color:red">该日没有签到信息</span></div></c:if>
</div>

<link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>


</html>