<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<base href="<%=basePath%>" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<!-- 引入分页JS -->
	<script type="text/javascript" src="admin/js/page.js"></script>
	<script type="text/javascript" src="js/table/treeTable.js"></script>
	<script type="text/javascript">
	   //根据机车类型得到一级部件信息
	   function getFirstUnit(){
		   var jcsType=$("#jcsType").val();
		   window.location.href="pjManageAction!storeCountList.do?jcStype="+jcsType;
	   }
	</script>
	</head>
<body>
	<form id="form" action="pjManageAction!storeCountList.do" method="post">
		<div id="showImage">
			查询条件：车型：
			<select id="jcsType" onchange="getFirstUnit();" class="default" name="jcsType">
	            <option value="">请选择机车型号</option>
	            <c:forEach var="jc" items="${jcStypes}">
	                <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcStype}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
	            </c:forEach>
	        </select>
			<table class="treeTable" initState="collapsed">
				<tr>
					<th width="150">专业</th>
					<th width="150">配件名称</th>
					<th width="150">适用车型</th>
					<th width="150">配件数量</th>
				</tr>
				<c:forEach items="${firstUnit}" var="unit">
				
					<tr id="node-${unit.firstunitid }">
						<td>
							<span class="folder">
								${unit.firstunitname }
							</span>
						</td> 
						<td align="center"></td>
						<td align="center"></td>	
						<td align="center">${unit.count}</td>			
					</tr>
					<c:forEach items="${list}" var="list" varStatus="idx">
						<c:if test="${unit.firstunitid == list[2]}">	
							<tr id="node-${unit.firstunitid}-${idx.index+1}" class="child-of-node-${unit.firstunitid }"  align="center">
								<td></td>
								<td align="left">
									<a href="javascript:;"><span class="file" onclick='top.Dialog.open({URL:"${pageContext.request.contextPath}/pjManageAction!storeCountDetail.action?pjName=${list[1]}&jcType=${jcStype }",Width:"100",Height:"100",Title:"机车互换配件(固定资产)分存卡"});'>${list[1]}</span></a>
								</td>
								<td>${jcStype }</td>
								<td>${list[3]}</td>
							</tr>
						</c:if>	
					</c:forEach>
				</c:forEach>		
			</table>                 
		</div>
	</form>
</body>
</html>
