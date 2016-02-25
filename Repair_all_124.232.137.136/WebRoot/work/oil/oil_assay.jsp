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
  $(function(){
	  top.Dialog.close();
	  $("#add").bind("click",function(){
		 var diag = new top.Dialog();
		 diag.Title = "添加油样化验记录";
		 diag.URL = "oilAssay!addOilRecorderDialog.do";
		 diag.Width=420;
		 diag.Height=250;
		 diag.show();
	  });
	  
	 $("#update").bind("click",function(){
		 var recId=$("input[name='recorders']").filter("[checked=true]").val();
		 if(recId==''||recId==undefined||recId==null){
		 	 top.Dialog.alert("请选择记录信息!");
	   	 }else{
	   		 var diag = new top.Dialog();
			 diag.Title = "更新油样化验记录";
			 diag.URL = "oilAssay!updateOilRecorderDialog.do?recId="+recId;
			 diag.Width=420;
			 diag.Height=320;
			 diag.show();
	   	 }
	 });
  });
</script>

<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
	  <tr>
		<td>
		  	<div class="box2" panelHeight="450"  panelTitle="油样化验记录"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
		  	<c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',HYY,')}">
		  	<button id="add" style="margin-top: 3px;margin-left: 5px;margin-bottom: 3px"><span class="icon_add">接活</span></button>
		  	<button id="update" style="margin-top: 3px;margin-left: 10px;margin-bottom: 3px"><span class="icon_edit">修改</span></button>
		  	</c:if>
		  	   <table width="100%" class="tableStyle">
					<tr>
					    <th class="ver01" width="2%">选择</th>
						<th class="ver01" width="5%">机车型号</th>
						<th class="ver01"  width="5%">机车号</th>
						<th class="ver01" width="15%">取样日期</th>
						<th class="ver01" width="15%">化验日期</th>
						<th class="ver01" width="10%">来样人</th>
						<th class="ver01" width="10%">化验者</th>
						<th class="ver01" width="10%">质量评定</th>
						<th class="ver01" width="10%">处理意见</th>
						<th class="ver01" width="10%">状态</th>
						<th class="ver01" width="10%">操作</th>
					</tr>
					<c:forEach items="${recorders}" var="entity">
					   <tr>
					    <td><input type="radio" name="recorders" value="${entity.recPriId}"/></td>
					    <td class="ver01" align="center">${entity.jcsTypeVal}</td>
						<td class="ver01" align="center">${entity.jcNum}</td>
						<td class="ver01" align="center">${entity.recesamTime}</td>
						<td class="ver01" align="center">${entity.finTime}</td>
						<td class="ver01" align="center">${entity.sentsamPeo}</td>
						<td class="ver01" align="center">${entity.receiptPeo}</td>
						<td class="ver01" align="center">
						  <c:if test="${entity.quasituation==0}">合格</c:if>
						  <c:if test="${entity.quasituation==1}">不合格</c:if>
						</td>
						<td class="ver01" align="center">
						  <c:if test="${entity.dealAdvice==0}">更换</c:if>
						  <c:if test="${entity.dealAdvice==1}">滤油</c:if>
						</td>
						<td class="ver01" align="center">
						  <c:if test="${entity.detecteStatus==0}">待验</c:if>
						  <c:if test="${entity.detecteStatus==1}">完成</c:if>
						</td>
						<td class="ver01" align="center">
						<c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',HYY,')}">
							<a href="oilAssay!oilAssayitemInput.do?recId=${entity.recPriId}" style="color:blue;">油样化验</a>
						</c:if>
						<c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',JCGZ,')}">
							<a href="oilAssay!searchOilAssayRecorder.do?recId=${entity.recPriId}" target="_blank" style="color:blue;">记录查询</a>
					    </c:if>
					  </td>
						
					  </tr>
					</c:forEach>
				</table>
	    	  </div>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>