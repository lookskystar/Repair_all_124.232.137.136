<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<Script type="text/javascript" src="js/jquery.form.js"></Script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--文本截取start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--文本截取end-->
<script type="text/javascript">
  function saveChoice(){
	  var jcs=document.getElementsByName("jcs");
	  var jcIdsArray=[];
	  for(var i=0;i<jcs.length;i++){
		  if(jcs[i].checked==true){
			  jcIdsArray.push(jcs[i].id);
		  }
	  }
	  if(jcIdsArray.length==0){
		   top.Dialog.alert("请选择机车!");
	  }else{
		  var dpIds=jcIdsArray.join("-");
		  $.post("<%=basePath%>presetDivisionAction!saveChoice.do",{"dpIds":dpIds},function(data){
			 if(data=="success"){
				 top.Dialog.alert("保存成功!",function(){
					 window.location.reload();
				 });
			 }else if(data=="no_authority"){
				 top.Dialog.alert("没有权限!");
			 }else{
				 top.Dialog.alert("保存失败!");
			 }
		 });
	  }
  }
</script>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
		<td class="ver01">
	    	  	<div class="box2" panelHeight="230"  panelTitle="待选机车"   panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto">
	    	    <table width="100%" class="tableStyle" id="userMsg">
	    	    	<tr><td colspan="9"><button onclick="saveChoice();"><span class="icon_save">保存</span></button></td></tr>
					<tr>
					    <th  class="ver01" width="10px">选择</th>
						<th class="ver01" width="60px">机车型号</th>
						<th class="ver01" width="60px">机车号</th>
						<th class="ver01" width="60px">修程修次</th>
						<th class="ver01" width="100px">检修时间</th>
						<th class="ver01">技术员</th>
						<th class="ver01">质检员</th>
						<th class="ver01" width="100px">验收员</th>
						<th class="ver01" width="100px">交车工长</th>
					</tr>
					<c:forEach var="dj" items="${divisionJcs}">
					  <tr>
					    <td>
					   <c:if test="${dj.status==0}">
					   		<input type="checkbox" id="${dj.rjhmId}" name="jcs"/>
					   </c:if>
					   </td>
						<td align="center">${dj.jcType}</td>
						<td align="center">${dj.jcnum}</td>
						<td align="center">${dj.fixFreque}</td>
						<td align="center">${dj.kcsj}</td>
						<td align="center">${fn:substring(dj.jsy,0,fn:length(dj.jsy)-1)}</td>
						<td align="center">${fn:substring(dj.zjy,0,fn:length(dj.zjy)-1)}</td>
						<td align="center">${fn:substring(dj.ysy,0,fn:length(dj.ysy)-1)}</td>
						<td align="center">${dj.jcgz}</td>
					  </tr>
					</c:forEach>
				</table>
	    	</div>
		</td>
	  </tr>
	  <tr>
	    <td class="ver01">
	    	<div class="box2" panelHeight="240"  panelTitle="已选负责机车"   panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto">
	    	     <table width="100%" class="tableStyle" id="userMsg">
					<tr>
						<th class="ver01" width="10px">序号</th>
					  	<th class="ver01">机车型号</th>
						<th class="ver01">机车号</th>
						<th class="ver01">修程修次</th>
						<th class="ver01">检修时间</th>
						<th class="ver01">负责人</th>
					</tr>
					<c:forEach items="${jcChoice}" var="jcc" varStatus="idx">
					 <tr>
					    <td align="center">${idx.index+1 }</td>
					    <td align="center">${jcc.dpId.jcType}</td>
					    <td align="center">${jcc.dpId.jcnum}</td>
					    <td align="center">${jcc.dpId.fixFreque}</td>
					    <td align="center">${jcc.dpId.kcsj}</td>
					    <td align="center">${jcc.userId.xm}</td>
					 </tr>
				 </c:forEach>
				</table>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>