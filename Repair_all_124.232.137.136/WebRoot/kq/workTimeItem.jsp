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
    <title>项目管理</title>
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
			top.Dialog.open({URL:"<%=basePath%>maintainAction!addWorkTimeItem.do",Width:400,Height:300,Title:"添加工时项目"});
		}

		//删除
	    function deletes(workTimeItemId){
	    	top.Dialog.confirm("确认删除吗？",function(){
		    	$.ajax({
					type:"post",
					async:false,
					url:"maintainAction!delWorkTimeItem.do",
					data:{"workTimeItemId":workTimeItemId},
					success:function(result){
						if(result=="success"){
			    			top.Dialog.alert("删除成功！",function(){
			    				window.location.href="<%=basePath%>maintainAction!getWorkTimeItems.do";
			    			});
			    		}else{
			    			top.Dialog.alert("删除失败！");
			    		}
					}
				});
	    	});
	    }

	  //修改
		function toEdite(workTimeItemId){
			top.Dialog.open({URL:"<%=basePath%>maintainAction!editWorkTimeItemInput.do?workTimeItemId="+workTimeItemId,Width:450,Height:300,Title:"修改设备信息"});
		
		}
	</script>
</head>
<body>
	<div class="box2" panelTitle="" roller="false" >
	  <form id="form" action="maintainAction!getWorkTimeItems.do" method="post">	
		<table>
			<tr>
			  <td>班组:</td>
			  <td>
			   	 <select colNum="4" colWidth="80" name="proteamId">
					<option value="0">请选择班组</option>
				    <c:forEach var="proteam" items="${proteams}">
				       <option value="${proteam.proteamid }" <c:if test="${proteamId==proteam.proteamid }">selected="selected"</c:if>>${proteam.proteamname }</option>
				    </c:forEach>
				  </select>
			   </td>
			   <td>项目名称：</td>
			   <td><input type="text" style="width: 115px" name="itemName" value="${itemName}"/></td>
			   <td><input type="submit" value=" 查 询  "/></td>
			   <td><input type="button" value=" 新增 " onclick="toAdd();"></td>
			</tr>
		</table>
	  </form>	
	</div> 
	<div id="scrollContent" >
	  <table class="tableStyle" useMultColor="true">
			<tr>
				<th width="3%" align="center"></th>
				<th width="24%" align="center">班组</th>
				<th width="24%" align="center">项目分值</th>
				<th width="25%" align="center">项目名称</th>
				<th width="24%" align="center">操作</th>
			</tr>
		<c:if test="${!empty workTimeItem}">
			<c:forEach items="${workTimeItem}" var="workTimeItem" varStatus="i">
				<tr>
					<td align="center">${i.index+1 }</td>
					<td align="center"><span>${workTimeItem.proteam.proteamname }</span></td>
					<td align="center">${workTimeItem.itemScore }</td>
					<td align="center">${workTimeItem.itemName }</td>
					<td width="40%" align="center">
						<a href="javascript:void(0);" onclick="toEdite(${workTimeItem.id});" style="color:blue;">修改</a>&nbsp;
						<a href="javascript:void(0);" onclick="deletes(${workTimeItem.id});" style="color:blue;">删除</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty workTimeItem}">
	    <tr><td align="center" colspan="5">没有相应的数据信息!</td></tr>
		</c:if>
	</table>
	</div>
</body>
</html>