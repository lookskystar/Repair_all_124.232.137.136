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

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<!-- 引入分页JS -->
<script type="text/javascript" src="admin/js/page.js"></script>
<script type="text/javascript" src="js/table/treeTable.js"></script>

<script type="text/javascript">
   //根据机车类型得到一级部件信息
   function getFirstUnit(){
	   var jcsType=$("#jcsType").val();
	   window.location.href="pjManageAction!inputPartRecord.do?jcStype="+jcsType;
   }

</script>
</head>
<body>
<form id="form" action="pjManageAction!staticPJListInput.do" method="post">
	<div id="showImage">
	查询条件：车型：<select id="jcsType" onchange="getFirstUnit();" class="default" name="jcsType">
                     <option value="">请选择机车型号</option>
                     <c:forEach var="jc" items="${jcStypes}">
                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcStype}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
                     </c:forEach>
                 </select>
       
	<table class="treeTable" initState="collapsed">
		<tr>
			<th width="180">专业</th>
			<th width="120">合格配件数</th>
			<th width="120">在修配件数</th>
			<th width="120">待修配件数</th>
			<th width="120">合格率</th>
			<th width="120">总计</th>
			<th width="120">已装车</th>			
		</tr>
		<c:forEach items="${firstUnit}" var="unit">
		
			<tr id="node-${unit.firstunitid }">
				<td><span class="folder">${unit.firstunitname }</span></td>
				<td align="center">${unit.hg }</td>
				<td align="center">${unit.dx }</td>
				<td align="center">${unit.jx }</td>
				<td align="center">
					<script type="text/javascript">
								var a = ${unit.hg };
								var b = ${unit.hg + unit.dx + unit.jx};
								if(b!=0){
									document.write(((a/b*100)+"").substr(0,5)+"%");
								}else{
									document.write("/");			
								}
					</script>
				</td>
				<td align="center">${unit.hg + unit.dx + unit.jx}</td>
				<td align="center">${unit.sc }</td>				
			</tr>
			<c:forEach items="${list}" var="list" varStatus="idx">
				<c:if test="${unit.firstunitid == list[2]}">	
					<tr id="node-${unit.firstunitid}-${idx.index+1}" class="child-of-node-${unit.firstunitid }">
						<td >
						<a href="pjManageAction!dyPJListInput1.do?pjName=${list[1]}乱码"><span class="file">${list[1]}</span></a></td>
						<td align="center">${list[3]}</td>
						<td align="center">${list[4]}</td>
						<td align="center">${list[5]}</td>
						<td align="center">
							<script type="text/javascript">
								var a = ${list[3]};
								var b = ${list[6]};
								if(b!=0){
									document.write(((a/b*100)+"").substr(0,5)+"%");
								}else{
									document.write("/");			
								}
							</script>
						</td>
						<td align="center">${list[6]}</td>
						<td align="center">${list[7]}</td>
					</tr>
				</c:if>	
			</c:forEach>
		</c:forEach>		
	</table>                 
</div>
</form>
</body>
</html>
