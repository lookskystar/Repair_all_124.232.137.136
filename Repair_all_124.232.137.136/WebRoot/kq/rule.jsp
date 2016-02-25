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
    <title>设备管理</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript">
		$(document).ready(function(){
			top.Dialog.close();
			<c:if test="${!empty message}">
				top.Dialog.alert('${message}');
			</c:if>
		})
	
		//新增
		function toAdd(){
			top.Dialog.open({
				URL:"<%=basePath%>maintainAction!addRuleInput.do",
				Width:550,
				Height:350,
				Title:"添加考勤设置",
				success:function(data){
				if(data!="failure"){
					top.Dialog.alert("考勤规则添加成功!",function(){
						window.location.href="maintainAction!getRuleInput.do";
					});
				}else{
					top.Dialog.alert("考勤规则添加失败!");
				}
			}
			});
		}

		//删除
	    function deletes(ruleId){
	    	top.Dialog.confirm("确认删除吗？",function(){
		    	$.ajax({
					type:"post",
					async:false,
					url:"maintainAction!deleteRuleAjax.do",
					data:{"ruleId":ruleId},
					success:function(result){
						if(result=="success"){
			    			top.Dialog.alert("删除成功！",function(){
			    				window.location.href="maintainAction!getRuleInput.do";
			    			});
			    		}else{
			    			top.Dialog.alert("删除失败！");
			    		}
					}
				});
	    	});
	    }

	  //修改
		function toEdite(ruleId){
			top.Dialog.open({URL:"<%=basePath%>maintainAction!editRuleInput.do?ruleId="+ruleId,Width:550,Height:350,Title:"修改考勤规则信息"});
		
		}
	</script>
</head>
<body>
	<div class="box2" panelTitle="考勤设置" roller="false" >
		<table>
			<tr>
				<td>
					<button onclick="toAdd()"><span class="icon_add">新增</span></button>
				</td>
			</tr>
		</table>	
	</div> 
	<div id="scrollContent" >
	  <table class="tableStyle" useMultColor="true">
		<tr>
			<th width="3%" align="center"></th>
			<th width="10%" align="center">上班类型</th>
			<th width="15%" align="center">适用班组</th>
			<th width="22%" align="center" colspan="2">上班时间</th>
			<th width="10%" align="center">迟到算旷工时长</th>
			<th width="10%" align="center">允许迟到时长</th>
			<th width="10%" align="center">早退算旷工时长</th>
			<th width="10%" align="center">允许早退时长</th>
			<th width="10%" align="center">操作</th>
		</tr>
		<c:if test="${!empty rule}">
			<c:forEach items="${rule}" var="rule" varStatus="i">
				<tr>
					<td align="center">${i.index+1 }</td>
					<td align="center">
						<c:if test="${rule.workType==1 }"><span style="color:blue;">分段上班</span></c:if>
						<c:if test="${rule.workType==2 }"><span style="color:red;">轮流倒班</span></c:if>
					</td>
					<td align="center">${rule.bzid }</td>
					<td align="center" width="11%">${rule.firstStartTime } - ${rule.firstEndTime }</td>
					<td align="center" width="11%">${rule.secStartTime } - ${rule.secEndTime }</td>
					<td align="center">${rule.lateValid }&nbsp;分钟</td>
					<td align="center">${rule.lateNot }&nbsp;分钟</td>
					<td align="center">${rule.afterValid }&nbsp;分钟</td>
					<td align="center">${rule.leaveEarly }&nbsp;分钟</td>
					<td align="center">
						<a href="javascript:void(0);" onclick="toEdite(${rule.id});" style="color:blue;">修改</a>&nbsp;
						<a href="javascript:void(0);" onclick="deletes(${rule.id});" style="color:blue;">删除</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	</div>
</body>
</html>