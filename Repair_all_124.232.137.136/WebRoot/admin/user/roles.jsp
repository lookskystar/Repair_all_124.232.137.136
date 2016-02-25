<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<link  rel="stylesheet" type="text/css" id="skin"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
<script>
    $(function(){
    	top.Dialog.close();
    	<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
	    </c:if>
    });
    
	function toaddRole(){
		top.Dialog.open({URL:"<%=basePath%>admin/user/addroles.jsp",Width:360,Height:180,Title:"添加角色"});
		}
	
	function deleterole(id){
		window.location.href="rolesAction!deleteRoleById.action?id="+id;
    	}

	function toeditrole(roleid){
		top.Dialog.open({URL:"<%=basePath%>rolesAction!editRoleInput.do?roleid="+roleid,Width:360,Height:180,Title:"修改角色"});
		}

	function toshouquan(roleId){
		top.Dialog.open({URL:"<%=basePath%>rolesAction!toPowerInput.do?roleId="+roleId,Width:480,Height:640,Title:"给角色授权"});
		}
</script>
</head>

<body>
<div class="box2"  panelTitle="角色管理" panelHeight="465" overflow="auto" showStatus="false">
	<div class="box1">
		<button onclick="toaddRole()"><span class="icon_add">新增</span></button>&nbsp;&nbsp;
	</div>
	<table class="tableStyle">
		<tr>
			<th width="10%">角色标示</th>
			<th width="20%">角色名称</th>
			<th width="20%">角色拼音</th>
			<th width="20%">角色说明</th>
			<th width="30%">操作</th>
		</tr>
		<c:forEach var="role" items="${rolePrivsList}">
			<c:if test="${!fn:containsIgnoreCase(role.py,'XTGL')}">
				<tr align="center">
					<td width="10%">${role.roleid}</td>
					<td width="20%">${role.rolename}</td>
					<td width="25%">${role.py}</td>
					<td width="25%">${role.rolenote}</td>
					<td width="8%">
					   <a href="javascript:void(0);" onclick="toeditrole(${role.roleid});" style="color:blue;">编辑</a>&nbsp;
					   <a href="javascript:void(0);" onclick="deleterole(${role.roleid});" style="color:blue;">删除</a>&nbsp;
					   <a href="javascript:void(0);" onclick="toshouquan(${role.roleid});" style="color:blue;">授权</a>&nbsp;
					</td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
</div>
</body>
</html>