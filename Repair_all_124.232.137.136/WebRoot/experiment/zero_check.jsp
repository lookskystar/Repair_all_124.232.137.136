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
   function sign(){
	   var datePlanId=$("input[type='radio']").filter("[checked=true]").val();
	   if(datePlanId==''||datePlanId==undefined||datePlanId==null){
		 	top.Dialog.alert("请选择机车!");
	   }else{
		   top.Dialog.open({URL:"<%=basePath%>zeroCheck!zeroSignDialog.do?dpId="+datePlanId,Width:350,Height:150,Title:"用户签认"});
	   }
   }
   
   function showSignMsg(id){
		   $('#zerosignmsg').attr("src","zeroCheck!zeroSignMsg.do?dpId="+id+"&tmp="+new Date().getTime());
   }
</script>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td  width="55%">
	    	<div class="box2"  panelTitle="交验修机车列表" roller="true" showStatus="false" overflow="auto" panelHeight="450" >
	    	    <button  onclick="sign();"><span class="icon_save">签认</span></button><br/>
				<table width="100%" class="tableStyle">
					<tr>
					    <th class="ver01" width="10%">选择</th>
						<th class="ver01" width="10%">机车型号</th>
						<th class="ver01"  width="10%">机车号</th>
						<th class="ver01" width="10%">修程修次</th>
						<th class="ver01" width="25%">检修时间</th>
						<th class="ver01" width="25%">交车时间</th>
						<th class="ver01" width="10%">状态</th>
					</tr>
					<c:forEach items="${checkJcs}" var="entity">
					   <tr onclick="showSignMsg(${entity.rjhmId});">
					    <td><input type="radio" id="${entity.rjhmId}" name="checkjc" value="${entity.rjhmId}"/></td>
					    <td class="ver01">${entity.jcType}</td>
						<td class="ver01">${entity.jcnum}</td>
						<td class="ver01">${entity.fixFreque}</td>
						<td class="ver01">${entity.kcsj}</td>
						<td class="ver01">${entity.jhjcsj}</td>
						<td class="ver01">
						  <c:if test="${entity.planStatue==2}">已交</c:if>
						</td>
					  </tr>
					</c:forEach>
				</table>
	    	</div>
		</td>
		<td>
		  	<div class="box2" panelHeight="450"  panelTitle="零公里检查签认"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
	    	  <IFRAME scrolling="auto" width="100%" height="250px"  frameBorder=0 id=zerosignmsg name=zerosignmsg src=""  allowTransparency="true"></IFRAME>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>