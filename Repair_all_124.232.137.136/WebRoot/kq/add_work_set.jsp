<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"  prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="experiment/js/jquery.messager.js"></script>
	
	<script type="text/javascript">
	    //ajax保存数据
	    $(function(){
		    $("select").change(function(){
			    var workType=$(this).val();
			    var tdId=$(this).attr("id");
			    var workMonth=$("#time").val();
			    var xm=$(this).attr("name");
			    var gonghao=tdId.split("_")[0];
			    var workDay=workMonth+"-"+gerZeroNum(tdId.split("_")[1]);
			    var proteamId=$("#proteamId").val();
			    var proteamName=$("#proteamName").val();
			    $.post("rewardAction!ajaxSaveWorkSet.do",{
				    "gonghao":gonghao,
				    "xm":xm,
				    "proteamId":proteamId,
				    "proteamName":proteamName,
				    "workMonth":workMonth,
				    "workDay":workDay,
				    "workType":workType
			    },function(data){
				    if(data=="save"){
				    	$.messager.show(0, '排班信息保存成功', 2000);
				    }else if(data=="update"){
				    	$.messager.show(0, '排班信息更新成功', 2000);
				    }else{
				    	$.messager.show(0, '排班信息保存或更新失败', 2000);
				    }
			    });
		      });
	    });

	    //处理返回带0数字，5-->05,12-->12
	    function gerZeroNum(num){
		    if(num<10){
			    return "0"+num;
		    }else{
			    return ""+num;
		    }
	    }
	</script>
</head>
<body>
<div class="box2" panelTitle="考勤排班" roller="false">
   <center><h2>${proteam.proteamname }&nbsp;&nbsp;${time }月份考勤排班</h2></center>
</div>
<div id="scrollContent">
	<input type="hidden" id="proteamId" value="${proteam.proteamid }"/>
    <input type="hidden" id="proteamName" value="${proteam.proteamname }"/>
    <input type="hidden" id="time" value="${time}"/>
	<table class="tableStyle" style="text-align:center; margin-top:10px;">
		<tr>
		   <th>工号</th>
		   <th>姓名</th>
		   <th colspan="16">日期</th>
		</tr>
		<c:forEach var="user" items="${users}">
			<tr>
				<td rowspan="4">${user.gonghao }</td>
				<td rowspan="4"><span style="font-weight:bold;color:blue">${user.xm }</span></td>
				<c:forEach var="tdNum0" begin="1" end="16">
					<td>${tdNum0 }日</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="tdNum1" begin="1" end="16">
					<td>
						<select class="default" id="${user.gonghao }_${tdNum1}" name="${user.xm }">
							<option value="0"></option>
							<option value="1">白班</option>
							<option value="2">晚班</option>
						</select>
					</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="day" begin="17" end="${days}">
					<td>${day}日</td>
				</c:forEach>
				<c:if test="${days==31}"><td></td></c:if>
				<c:if test="${days==30}"><td></td><td></td></c:if>
				<c:if test="${days==29}"><td></td><td></td><td></td></c:if>
				<c:if test="${days==28}"><td></td><td></td><td></td><td></td></c:if>
			</tr>
			<tr>
				<c:forEach var="tdNum2" begin="17" end="${days}">
					<td>
						<select class="default" id="${user.gonghao }_${tdNum2}" name="${user.xm }">
							<option value="0"></option>
							<option value="1">白班</option>
							<option value="2">晚班</option>
						</select>
					</td>
				</c:forEach>
				<c:if test="${days==31}"><td></td></c:if>
				<c:if test="${days==30}"><td></td><td></td></c:if>
				<c:if test="${days==29}"><td></td><td></td><td></td></c:if>
				<c:if test="${days==28}"><td></td><td></td><td></td><td></td></c:if>
			</tr>
		</c:forEach>
	</table>
</div>
<script type="text/javascript">
	$(function(){
		var selectStr="${selectStr}";//4068_1-1,3813_1-2,4068_3-2,3813_3-1,4068_31-2
		if(selectStr!=""){
			$("select").each(function(){
				var selectId=$(this).attr("id");
				var selectArray=selectStr.split(",");
				for(var i=0;i<selectArray.length;i++){
					var arrayId=selectArray[i].split("-");
					if(selectId==arrayId[0]){
						$(this).val(arrayId[1]);
						break;
					}
				}
			});
		}
	});
</script>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>