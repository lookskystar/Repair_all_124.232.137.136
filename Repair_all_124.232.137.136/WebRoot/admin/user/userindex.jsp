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
    <title>用户角色管理</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
	
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<script type="text/javascript">
	$(function(){
		top.Dialog.close();
		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
		</c:if>
	});

	//增加班组
	function toAdd(){
	   	     top.Dialog.open({URL:"<%=basePath%>userRolesAction!addDictProTeamInput.do",Width:800,Height:600,Title:"添加班组"});
	}

	//修改班组
	function toEdit() {
		var bzId=document.getElementById("userIframe").contentWindow.document.getElementById("bzId").value;
		if(bzId!=null && bzId!=undefined && bzId!=''){
			top.Dialog.open({URL:"<%=basePath%>userRolesAction!editDictProTeamInput.do?proteamId="+bzId,Width:800,Height:600,Title:"修改班组"});
		}else{
			top.Dialog.alert("请选择班组!");
		}	
	}

	function toDelete(){
		var bzId=document.getElementById("userIframe").contentWindow.document.getElementById("bzId").value;
		if(bzId!=null && bzId!=undefined && bzId!=''){
		    window.location.href="userRolesAction!delDictProTeam.action?id="+bzId; 
		}else{
			top.Dialog.alert("请选择班组!");
		}	    
	}
	</script>
  </head>
  
 <body>
	 <div id="scrollContent">
	 	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	 	  	<tr>
		 		<td width="22%" class="ver01">
			 		<div class="box2"  panelTitle="班组目录" panelHeight="465" overflow="auto" showStatus="false">
			 			<div>
				 		   <button onclick="toAdd()"><span class="icon_add">新增</span></button>&nbsp;
				 		   <button  onclick="toEdit()"><span class="icon_edit">修改</span></button>&nbsp;
				 		   <button  onclick="toDelete()"><span class="icon_delete">删除</span></button>
			     		</div>
				 		<script type="text/javascript">
				 				var d = new dTree('d');
								d.add(0,-1,'全部','<%=basePath%>userRolesAction!listUsers.do','全部人员','userIframe');
								
								d.add(100,0,'管理部门',null,'','');
								d.add(101,0,'小辅修班组',null,'','');
								d.add(102,0,'中修班组',null,'','');
		
								<c:forEach var="ite" items="${dictProTeamList}">
								    if('${ite.workflag}' !=1 && '${ite.zxFlag}' !=1){
									   d.add(${ite.proteamid},100,'${ite.proteamname}','<%=basePath%>userRolesAction!listUsers.do?bzId=${ite.proteamid}','${ite.proteamname}','userIframe');
									}
									if('${ite.workflag}' == 1){
									   d.add(${ite.proteamid},101,'${ite.proteamname}','<%=basePath%>userRolesAction!listUsers.do?bzId=${ite.proteamid}','${ite.proteamname}','userIframe');
									}
									if('${ite.zxFlag}' == 1){
									   d.add(${ite.proteamid},102,'${ite.proteamname}','<%=basePath%>userRolesAction!listUsers.do?bzId=${ite.proteamid}','${ite.proteamname}','userIframe');
									} 
							    </c:forEach>
								document.write(d);
				 		</script>
			 		</div>
		 	    </td>
		 		<td class="ver01">
		 			<iframe scrolling="no" width="100%" panelHeight="465" frameBorder=0 id="userIframe" name="userIframe" onload="iframeHeight('userIframe')" src="<%=basePath%>userRolesAction!listUsers.do"  allowTransparency="true"></iframe>
		 		</td>
			</tr>
	 	</table>
	</div>
</body>
</html>