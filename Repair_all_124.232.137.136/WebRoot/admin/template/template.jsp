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
	<script type="text/javascript" src="js/table/treeTable.js"></script>
	
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<script type="text/javascript">
		//控制复选框为单选
	   function selectThis(obj,ids){
		   $("input[name='template']").each(function(){
			   $(this).attr("checked",false);
		   });
		   obj.checked=true;
		   document.getElementById("fixItemIframe").contentWindow.checkNodes(ids);
	   }
		function selectJCType(){
			var jctype = $("#jctype").val();
			document.location.href="<%=basePath%>reportTemplate!searchTemplateItem.do?jctype="+jctype;
		}
		//保存关系 调用子页面方法
		function saveRelationItem(){
		   var templateId;
		   $("input[name='template']:checked").each(function(){
			   templateId=$(this)[0].id;
		   });
		   document.getElementById("fixItemIframe").contentWindow.save(templateId);
		}
	</script>
  </head>
  
 <body>
 <div id="scrollContent">
 	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
 	  <tr>
 		<td width="55%" class="ver01">
	 		<div class="box2"  panelTitle="模板项目" panelHeight="480" overflow="auto" showStatus="false">
	 			<div>
			 		   	<span style="vertical-align: top;">请选择车型：</span>
			 		   	<select id="jctype" name="jctype" class="default" style="width: 120px;vertical-align: top;" onchange="selectJCType();">
			 		   		<c:forEach var="jt" items="${jcTypes}">
			 		   			<c:choose>
			 		   				<c:when test="${jt.jcStypeValue==jcType}"><option value="${jt.jcStypeValue }" selected="selected">${jt.jcStypeValue}</option></c:when>
			 		   				<c:otherwise><option value="${jt.jcStypeValue }">${jt.jcStypeValue}</option></c:otherwise>
			 		   			</c:choose>
			 		   		</c:forEach>
			 		   </select>&nbsp;&nbsp;
			 		   <button onclick="saveRelationItem()"><span class="icon_save">保存关系</span></button>&nbsp;
			 		   <button onclick="javascript:window.location.reload();"><span class="icon_refresh">刷新</span></button>
	     		</div>
		 		<table class="treeTable" initState="collapsed">
					<tr>
						<th width="100px">检修项目</th>
						<th width="180px">检修内容</th>
						<th>技术要求</th>
						<th width="100px">所在位置</th>
						<th width="40px">关联数</th>
					</tr>
					<c:forEach var="un" items="${map}" varStatus="unIdx">
						<tr id="un-${unIdx.index+1}">
							<td><span class="folder">${un.key }</span></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td></td>
						</tr>
						<c:forEach var="fc" items="${un.value}" varStatus="fcIdx">
							<tr id="fc-${unIdx.index+1}-${fcIdx.index+1}" class="child-of-un-${unIdx.index+1}">
								<td>${fc.key}</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td></td>
							</tr>
							<c:forEach var="it" items="${fc.value}" varStatus="itIdx">
								<tr class="child-of-fc-${unIdx.index+1}-${fcIdx.index+1}">
									<td><input  type="checkbox" id="${it.id}" name="template" onclick="selectThis(this,'${it.itemIds}');"/></td>
									<td style="word-break:break-all;word-wrap: break-word;">${it.fixContent}</td>
									<td style="word-break:break-all;word-wrap: break-word;">${it.techStanderd}</td>
									<td style="word-break:break-all;word-wrap: break-word;">${it.position}</td>
									<td style="word-break:break-all;word-wrap: break-word;">${it.itemIds}</td>
								</tr>
							</c:forEach>
						</c:forEach>
					</c:forEach>
				</table>
	 		</div>
 	    </td>
 		<td class="ver01">
 			<div class="box2"  panelTitle="检修项目" panelHeight="480" overflow="auto" showStatus="false">
 				<iframe scrolling="auto" width="100%" height="100%" frameBorder=0 id="fixItemIframe" name="fixItemIframe" src="<%=basePath%>reportTemplate!searchFixItem.do?jctype=${jcType}"  allowTransparency="true"></iframe>
 			</div>
 		</td>
	</tr>
 </table>
</div>	
</body>
</html>