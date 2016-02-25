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
    <title>机车管理</title>
    
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
	
	//增加机车型号
	function toAddJcStype(){
	   	     top.Dialog.open({URL:"<%=basePath%>jcManageAction!addJcInput.do",Width:400,Height:450,Title:"添加机车型号"});
	}

	function toDelete(){
		     
	}
	</script>
  </head>
  
  <body>
 <div id="scrollContent">
 	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
 	  <tr>
 		<td width="22%" class="ver01">
	 		<div class="box2"  panelTitle="机车型号" panelHeight="465" overflow="auto" showStatus="false">
	 		<!-- 
	 			<div>
		 		   <button onclick="toAddJcStype()"><span class="icon_add">新增</span></button>&nbsp;&nbsp;
		 		   <button  onclick=""><span class="icon_edit">修改</span></button>&nbsp;&nbsp;&nbsp;
		 		   <button  onclick="toDeleteuser()"><span class="icon_delete">删除</span></button>
	     		</div> -->
		 		<script type="text/javascript">
		 				var d = new dTree('d');
						d.add(0,-1,'全部','<%=basePath%>jcManageAction!jcManageInput.do','','');
						
						d.add(100,0,'内燃机车',null,'','');
						d.add(101,0,'电力机车',null,'','');
						d.add(102,0,'和谐机车',null,'','');

						<c:forEach var="ite" items="${dictJcStypeList}">
							if(${ite.jcTypeId.jcTypeId==1}){
							   d.add(${ite.jcNumId},101,'${ite.jcStypeValue}','<%=basePath%>jcManageAction!listJtRunKiloRec.do?jcType=${ite.jcStypeValue}','${ite.jcStypeValue}','jcIframe');
							}else if(${ite.jcTypeId.jcTypeId==2}){
							   d.add(${ite.jcNumId},100,'${ite.jcStypeValue}','<%=basePath%>jcManageAction!listJtRunKiloRec.do?jcType=${ite.jcStypeValue}','${ite.jcStypeValue}','jcIframe');
							}else if(${ite.jcTypeId.jcTypeId==3}){
							   d.add(${ite.jcNumId},102,'${ite.jcStypeValue}','<%=basePath%>jcManageAction!listJtRunKiloRec.do?jcType=${ite.jcStypeValue}','${ite.jcStypeValue}','jcIframe');
							}
					    </c:forEach>
						document.write(d);
		 		</script>
	 		</div>
 	    </td>
 		<td class="ver01">
 			<div class="box2"  panelTitle="机车信息" panelHeight="465" overflow="auto" showStatus="false">
 				<iframe scrolling="no" width="100%" frameBorder=0 id="jcIframe" name="jcIframe" onload="iframeHeight('jcIframe')" src="<%=basePath%>jcManageAction!listJtRunKiloRec.do?temp="+<%=System.currentTimeMillis() %>  allowTransparency="true"></iframe>
 			</div>
 		</td>
	</tr>
 </table>
</div>	
</body>
</html>