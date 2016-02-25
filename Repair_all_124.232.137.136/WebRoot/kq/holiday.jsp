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
	
		//批量新增 	
		function toAdd(){
			top.Dialog.open({URL:"<%=basePath%>maintainAction!addHolidayInput.do",Width:600,Height:360,Title:"添加多个节假日设置"});
		}

		//单个新增 
		function toSinAdd(){
			top.Dialog.open({URL:"<%=basePath%>maintainAction!addSinHolidayInput.do",Width:300,Height:200,Title:"添加单个节假日设置"});
		}

		//判断是否选中信息
		function del(){
			//判断是否一个未选
			var flag; 
			//遍历所有的name为document的 checkbox 
			$("input[name='holiday']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
				}
		    })
		    if (flag) {  
		    	top.Dialog.confirm("确认删除？",function(){
		    		toDelete();
		    	});
		    }else {
		    	top.Dialog.alert("请至少选择一条信息！");
		    }
		
		}
		
		//删除
		function toDelete() {
			//用于保存 选中的那一条数据的ID 
			var faults = [];  
	    	$("input[name='holiday']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			//将选中的值 添加到 array中
	    			faults.push($(this).val());
	    		}
	    	}) 
	    	$.ajax({
				type:"post",
				async:false,
				url:"maintainAction!deleteHolidayAjax.do",
				data:{"faults":faults.join(",")},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("删除成功！",function(){
				    			window.location.href="maintainAction!getHolidayInput.do"
			    			});
		    		}else{
		    			top.Dialog.alert("删除失败！");
		    		}
				}
			})
		}

		//删除
	    function deletes(holidayId){
	    	top.Dialog.confirm("确认删除吗？",function(){
		    	$.ajax({
					type:"post",
					async:false,
					url:"maintainAction!deleteHolidayAjax.do",
					data:{"faults":holidayId},
					success:function(result){
						if(result=="success"){
			    			top.Dialog.alert("删除成功！",function(){
			    				window.location.href="<%=basePath%>maintainAction!getHolidayInput.do";
			    			});
			    		}else{
			    			top.Dialog.alert("删除失败！");
			    		}
					}
				});
	    	});
	    }

	  //修改
		function toEdite(holidayId){
			top.Dialog.open({URL:"<%=basePath%>maintainAction!editHolidayInput.do?holidayId="+holidayId,Width:280,Height:150,Title:"修改节日设置"});
		
		}
	</script>
</head>
<body>
	<div class="box2" panelTitle="节假日设置" roller="false" >
		<table>
			<tr>
				<td>
					<button onclick="toAdd()"><span class="icon_add">批量新增</span></button>
				</td>
				<td>
					<button onclick="toSinAdd()"><span class="icon_add">单个新增</span></button>
				</td>
				<td>
					<button onclick="del()"><span class="icon_delete">删除</span></button>
				</td>
			</tr>
		</table>	
	</div> 
	<div id="scrollContent" >
	  <table class="tableStyle" useMultColor="true">
		<tr>
			<th width="3%" align="center"></th>
			<th width="19%" align="center">序号</th>
			<th width="19%" align="center">节假日名称</th>
			<th width="19%" align="center">起始时间</th>
			<th width="20%" align="center">结束时间</th>
			<th width="20%" align="center">操作</th>
		</tr>
		<c:if test="${!empty holiday}">
			<c:forEach items="${holiday}" var="holiday">
				<tr>
					<td align="center"><input id="holidayId" name="holiday" type="checkbox" width="30px" value="${holiday.id }"/></td>
					<td align="center">${holiday.id }</td>
					<td align="center">${holiday.holidayName }</td>
					<td align="center">${holiday.startTime }</td>
					<td align="center">${holiday.endTime }</td>
					<td width="40%" align="center">
						<a href="javascript:void(0);" onclick="toEdite(${holiday.id});" style="color:blue;">修改</a>&nbsp;
						<a href="javascript:void(0);" onclick="deletes(${holiday.id});" style="color:blue;">删除</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	</div>
</body>
</html>