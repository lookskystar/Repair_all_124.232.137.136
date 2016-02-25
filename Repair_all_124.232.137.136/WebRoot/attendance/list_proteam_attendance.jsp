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
    <title>考勤记录管理</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
<body>
 	<form action="attendanceAction!findAttendanceByProteam.do?proteamId=${proteamId}" method="post" id="subfrom">
 	<div>
 		<table>
 			<tr>
				<td>查询时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" id="dates"  name="dates" value="${dates}"/></td>
 				<td><button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button></td>
			</tr>
		</table>
	</div>
   	<div id="scrollContent">
		 <table class="tableStyle"  id="attendanceTable">
		 	<tr>
		      	<th width="2%">序号</th>
		      	<th width="10%" align="center">姓名</th>
		      	<th width="18%" align="center">第一次考勤</th>
		      	<th width="18%" align="center">第二次考勤</th> 
		      	<th width="18%" align="center">第三次考勤</th>
		      	<th width="18%" align="center">第四次考勤</th>
		      	<th width="16" align="center">备注</th>
		    </tr> 
		   	<c:forEach items="${dateList}" var="map" varStatus="idx">
		   		<tr>
		   			<td align="center">${idx.index+1}</td>
					<td align="center">${map.xm}</td>
					<td align="center">
						<c:if test="${!empty map.imgurl_0}">
							<img class="check_img" src='<%=basePath%>${map.imgurl_0}' width="64px" height="48px"/><br/>${map.time_0}
						</c:if>
					</td>
					<td align="center">
						<c:if test="${!empty map.imgurl_1}">
							<img class="check_img" src='<%=basePath%>${map.imgurl_1}' width="64px" height="48px"/><br/>${map.time_1}
						</c:if>
					</td>
					<td align="center">
						<c:if test="${!empty map.imgurl_2}">
							<img class="check_img" src='<%=basePath%>${map.imgurl_2}' width="64px" height="48px"/><br/>${map.time_2}
						</c:if>
					</td>
					<td align="center">
						<c:if test="${!empty map.imgurl_3}">
							<img class="check_img" src='<%=basePath%>${map.imgurl_3}' width="64px" height="48px"/><br/>${map.time_3}
						</c:if>
					</td>
					<td align="center">${map.confirm}</td>
				</tr>
		   	</c:forEach>
			 <c:if test="${empty dateList}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="7">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
	</div>
	</form>
</body>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	//编辑
	function editAtten(id){
		var diag = new top.Dialog();
		diag.Title = "考勤记录管理";
		diag.URL = "attendanceAction!editAttendanceInput.do?id="+id;
		diag.Width=700;
		diag.Height=600;
		diag.show();
	}
	
	function confirms(num,id){
		$.post("attendanceAction!ajaxAttenConfirm.do",{"attId":id, "attNum":num},function(datas){
			if("success" == datas){
				top.Dialog.alert("确认成功！");
				top.window.frmright.location.href="attendanceAction!findUsersByProteamId.do";
			}else{
				top.Dialog.alert("确认失败！");
			}
		})
	}
</script>
</html>