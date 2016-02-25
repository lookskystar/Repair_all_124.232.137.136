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
   function rollOut(){
	   var datePlanId=$("input[type='radio']").filter("[checked=true]").val();
	   if(datePlanId==''||datePlanId==undefined||datePlanId==null){
		 	top.Dialog.alert("请选择机车!");
	   }else{
		   top.Dialog.confirm("确定要转出吗?",function(){
			   $.post("<%=basePath%>zeroCheck!jcRollOut.do",{"dpId":datePlanId},function(data){
				   if(data=="success"){
					   top.Dialog.alert("机车转出成功!",function(){
						   top.document.location.href="<%=basePath%>report/jcgz_main.jsp";
					   });
				   }else{
					   top.Dialog.alert("机车转出失败!");
				   }
		   	   });
		   });
	   }
   }
   
   function showMsg(id){
	   var type=$("#tr_"+id+" td:eq(1)").text();
	   var num=$("#tr_"+id+" td:eq(2)").text();
	   var xcxc=$("#tr_"+id+" td:eq(3)").text();
	   $("#typeNum").val(type+"-"+num);
	   $("#xcxc").val(xcxc);
   }

   $(function(){
	   showMsg("${rjhmId}");
   });
</script>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
	    <td  width="55%">
	    	<div class="box2"  panelTitle="已交验机车列表" roller="true" showStatus="false" overflow="auto" panelHeight="550" >
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
					   <tr onclick="showMsg(${entity.rjhmId});" id="tr_${entity.rjhmId}">
					    <td><input type="radio" id="${entity.rjhmId}" name="checkjc" value="${entity.rjhmId}" <c:if test="${entity.rjhmId==rjhmId}">checked="checked"</c:if>/></td>
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
		  	<div class="box2" panelHeight="550"  panelTitle="机车转出运用状态"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
	    	      <br/><table width="100%" class="tableStyle">
					<tr>
						<th class="ver01">机车型号:</th>
						<th class="ver01"><input type="text" id="typeNum" style="width: 150px"/></th>
					</tr>
					<tr>
						<th class="ver01">修程修次:</th>
						<th class="ver01"><input type="text" id="xcxc" style="width: 150px" /></th>
					</tr>
					<tr>
						<th class="ver01">操作人:</th>
						<th class="ver01"><input type="text" id="user" value="${session_user.xm}" disabled="disabled" style="width: 150px"/></th>
					</tr>
					<tr>
						<th class="ver01" colspan="2"><input type="button" value=" 转       出  " onclick="rollOut();"/></th>
					</tr>
				</table>
	    	  </div>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>