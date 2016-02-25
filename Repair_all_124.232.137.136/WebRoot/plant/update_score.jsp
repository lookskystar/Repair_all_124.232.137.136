<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>"/>
    <title>预设分工</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="part/js/part_plan.js"></script>
	<script type="text/javascript" src="experiment/js/jquery.messager.js"></script>
	<script type="text/javascript">
	   $(function(){
		   $("input[name='score']").change(function(){
				var preDictId=$(this).attr("id");
				var score = $(this).val();
				if($.trim(score).length>0){
					$.post("<%=basePath%>timecount!ajaxUpdateRepScore.do",{"preDictId":preDictId,"score":score},function(data){
						if(data=="success"){
							$.messager.show(0, '报活分值信息保存成功', 2000);
						}else{
							top.Dialog.alert("操作失败");
						}
					});
				}
			});
	   });
	</script>
	<style type="text/css">
		.testDiv{
			top:200px ;
			left:300px ;
			height:400px ;
			width:420px ;
			
			/*指定水平方面有滚动条，垂直状态没有 如果值为：auto，则当内容超过显示范围时才出现*/
			overFlow-x: hidden ;
			overFlow-y: auto ; 
			
			/*设置滚动条样式*/
			scrollBar-face-color: green; 
			scrollBar-hightLight-color: red; 
			scrollBar-3dLight-color: orange; 
			scrollBar-darkshadow-color:blue; 
			scrollBar-shadow-color:yellow; 
			scrollBar-arrow-color:purple; 
			scrollBar-track-color:black; 
		}
		
		.item_left{
			width: 40%;
			float: left;
		}
		
		.item_right{
			width: 57%;
			float: right;
		}
		.dTreeNode{width:480px;}
	</style>
  </head>
  
 <body>
 	<table width="100%" align="left">
 		<tr>
 			<td width="320px">
		 		<div class="box2"  panelTitle="当前在修机车" panelHeight="534" panelWidth="320" overflow="auto">
		 		     <table class="tableStyle"   headFixMode="true" useMultColor="true">
						  <tr>
							<th align="center">机车号</th>
							<th align="center">交车工长</th>
							<th align="center">所处节点</th>
							<th align="center">状态</th>
						 </tr>
						<c:forEach var="datePlan" items="${datePlans}">
						   <tr>
						     <td align="center"><a href="timecount!updateRepScoreInput.do?rjhmId=${datePlan.rjhmId }" style="color:blue;">${datePlan.jcType}-${datePlan.jcnum}-${datePlan.fixFreque}</a></td>
						     <td align="center">${datePlan.gongZhang.xm}</td>
						     <td align="center">
							  <c:choose>
							    <c:when test="${datePlan.nodeid.jcFlowId==100}">机车分解</c:when>
							    <c:when test="${datePlan.nodeid.jcFlowId==101}">车上组装</c:when>
							    <c:when test="${datePlan.nodeid.jcFlowId==102}">机车试验</c:when>
							    <c:when test="${datePlan.nodeid.jcFlowId==103}">试运行</c:when>
							    <c:otherwise>小辅修</c:otherwise>
							  </c:choose>
							</td>
							<td align="center">
							  <c:if test="${datePlan.planStatue==0}">在修</c:if>
							  <c:if test="${datePlan.planStatue==1}">待验</c:if>
							  <c:if test="${datePlan.planStatue==2}">已交</c:if>
							</td>
						   </tr>
						</c:forEach>
					</table>
				</div>
	 		</td>
		 	<td align="left">
		 		<div  class="box2" panelHeight="534" panelTitle="机车报活信息" overflow="auto">
		 		    <c:if test="${!empty datePlanPri}">
		 		    	<span style="color:red">当前机车信息:${datePlanPri.jcType }-${datePlanPri.jcnum }-${datePlanPri. fixFreque}</span>
		 		    </c:if>
		 		    <table class="tableStyle"   headFixMode="true" useMultColor="true">
		 		       	  <tr>
		 		       	    <th align="center">班组</th>
							<th align="center">具体报活部位</th>
							<th align="center">故障情况</th>
							<th align="center">报活人</th>
							<th align="center">报活时间 </th>
							<th align="center">处理人</th>
							<th align="center">处理时间</th>
							<th align="center">报活类型 </th>
							<th align="center">处理情况 </th>
							<th align="center">报活分值</th>
						 </tr>
						 <c:forEach var="jtPreDict" items="${jtPreDicts}">
						   <tr>
						     <td align="center">${jtPreDict.proTeamId.proteamname }</td>
						     <td align="center">${jtPreDict.repPosi }</td>
						     <td align="center">${jtPreDict.repsituation }</td>
						     <td align="center">${jtPreDict.repemp }</td>
						     <td align="center">${jtPreDict.repTime }</td>
						     <td align="center">${fn:substring(jtPreDict.dealFixEmp,1,fn:length(jtPreDict.dealFixEmp)-1)}</td>
						     <td align="center">${jtPreDict.fixEndTime}</td>
						     <td align="center">
						        <c:if test="${jtPreDict.type==0}">JT28报活</c:if>
						        <c:if test="${jtPreDict.type==1}">复检报活</c:if>
						        <c:if test="${jtPreDict.type==2}">过程报活</c:if>
						        <c:if test="${jtPreDict.type==6}">零公里报活</c:if>
						     </td>
						     <td align="center">${jtPreDict.dealSituation }</td>
						     <td align="center"><input type="text" value="${jtPreDict.score }" style="width:50px" onkeyup="this.value=this.value.replace(/\D/g,'')" name="score" id="${jtPreDict.preDictId }"/></td>
						   </tr>
						 </c:forEach>
					    <c:if test="${empty jtPreDicts}">
					     <tr><td align="center" colspan="10">没有相应的报活记录信息!</td></tr>
					   </c:if>
		 		    </table>
		 		</div>
		 	</td>
		</tr>
 	</table>	
</body>
</html>