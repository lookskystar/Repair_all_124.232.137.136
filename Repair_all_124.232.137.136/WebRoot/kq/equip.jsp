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
			top.Dialog.open({URL:"<%=basePath%>maintainAction!addEquipInput.do",Width:400,Height:290,Title:"添加设备"});
		}

		//判断是否选中信息
		function del(){
			//判断是否一个未选
			var flag; 
			//遍历所有的name为document的 checkbox 
			$("input[name='equip']").each(function() {
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
		    	top.Dialog.alert("请至少选择一条设备信息！");
		    }
		
		}
		
		//删除
		function toDelete() {
			//用于保存 选中的那一条数据的ID 
			var faults = [];  
	    	$("input[name='equip']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			//将选中的值 添加到 array中
	    			faults.push($(this).val());
	    		}
	    	}) 
	    	$.ajax({
				type:"post",
				async:false,
				url:"maintainAction!deleteEquipAjax.do",
				data:{"faults":faults.join(",")},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("设备删除成功！",function(){
				    			window.location.href="maintainAction!getEquipInput.do"
			    			});
		    		}else{
		    			top.Dialog.alert("设备删除失败！");
		    		}
				}
			})
		}

		//删除
	    function deletes(equipId){
	    	top.Dialog.confirm("确认删除吗？",function(){
		    	$.ajax({
					type:"post",
					async:false,
					url:"maintainAction!deleteEquipAjax.do",
					data:{"faults":equipId},
					success:function(result){
						if(result=="success"){
			    			top.Dialog.alert("删除成功！",function(){
			    				window.location.href="<%=basePath%>maintainAction!getEquipInput.do";
			    			});
			    		}else{
			    			top.Dialog.alert("删除失败！");
			    		}
					}
				});
	    	});
	    }

	  //修改
		function toEdite(equipId){
			top.Dialog.open({URL:"<%=basePath%>maintainAction!editEquipInput.do?equipId="+equipId,Width:300,Height:280,Title:"修改设备信息"});
		
		}
	</script>
</head>
<body>
	<div class="box2" panelTitle="" roller="false" >
		<table>
			<tr>
				<td>
					<button onclick="toAdd()"><span class="icon_add">新增</span></button>
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
				<th width="13%" align="center">型号</th>
				<th width="14%" align="center">编号</th>
				<th width="14%" align="center">位置</th>
				<th width="13%" align="center">状态</th>
				<th width="13%" align="center">端口号</th>
				<th width="15%" align="center">IP地址</th>
				<th width="15%" align="center">操作</th>
			</tr>
		<c:if test="${!empty equip}">
			<c:forEach items="${equip}" var="equip">
				<tr>
					<td align="center"><input id="equipId" name="equip" type="checkbox" width="30px" value="${equip.id }"/></td>
					<td align="center"><span>${equip.equipType }</span></td>
					<td align="center">${equip.equipNum }</td>
					<td align="center">${equip.equipPosition }</td>
					<td align="center">
						<c:if test="${equip.equipState==0 }">未启用</c:if>
						<c:if test="${equip.equipState==1 }">使用中</c:if>
					</td>
					<td align="center">${equip.equipPort }</td>
					<td align="center">${equip.equipIp }</td>
					<td width="40%" align="center">
						<a href="javascript:void(0);" onclick="toEdite(${equip.id});" style="color:blue;">修改</a>&nbsp;
						<a href="javascript:void(0);" onclick="deletes(${equip.id});" style="color:blue;">删除</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	</div>
</body>
</html>