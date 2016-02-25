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
	<!--修正IE6支持透明PNG图start-->
    <script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
    <!--修正IE6支持透明PNG图end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript">
	   //根据机车类型得到一级部件信息
	   function getFirstUnit(){
		   var jcsType=$("#jcsType").val();
		   if(jcsType!=""){
			   $.post("<%=basePath%>pjManageAction!ajaxGetFirstUnit.do",{"jcsType":jcsType},function(data){
	               var result=eval("("+data+")");
	               var firstUnits=result.firstUnits;
	               var str="<option value=''>请选择大部件</option>";
	               for(var i=0;i<firstUnits.length;i++){
	                   str+="<option value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";
	               }
	               $("#first").children().remove();
	               $("#first").append(str);
	           });
		   }
	   }
	   
	   function validate(){
		   var pjName=$("#pjName").val();
		   var first=$("#first").val();
		   var flow=$("#flow").val();
		   var jcTypes=[];
		   $("input[name='jcTypes']:checked").each(function(){
			   jcTypes.push($(this).val());
		   });
		   if(pjName==""){
			    top.Dialog.alert("请填写配件名称!");
			    return false;
		   }
		   if(jcTypes.length==0){
			   	top.Dialog.alert("请选择机车类型!");
			    return false;
		   }else{
			   $("#jcType").val(jcTypes.join(",")+",");
		   }
		   if(first==""){
			    top.Dialog.alert("请选择大部件名称!");
			    return false;
		   }
		   if(flow==""){
			    top.Dialog.alert("请选择所属流程!");
			    return false;
		   }
	   }
	   
	</script>
  </head>
<body><br/>
    <form action="pjManageAction!updatePjStaticInfo.do" method="post" target="frmright" onsubmit="return validate();"> 
        <input type="hidden" name="pjStatic.pjsid" value="${pjStatic.pjsid}"/>
        <input type="hidden" name="pjStatic.jcType" id="jcType" value="${pjStatic.jcType}"/>
		<table class="tableStyle" transMode="true"><!-- transMode="true" -->
		   <tr>
				<td>配件名称: </td>
				<td colspan="3">
				   <input class="easyui-validatebox" type="text" name="pjStatic.pjName" style="width: 300px;" id="pjName" value="${pjStatic.pjName}"></input>
				</td>
			</tr>
		    <tr>
				<td>最小库存量: </td>
				<td>
				   <input class="easyui-validatebox" type="text" name="pjStatic.lowestStore" onkeyup="this.value=this.value.replace(/\D/g,'')" value="${pjStatic.lowestStore}"></input>
				</td>
			
				<td>最大库存量: </td>
				<td>
				   <input class="easyui-validatebox" type="text" name="pjStatic.mostStore" onkeyup="this.value=this.value.replace(/\D/g,'')" value="${pjStatic.mostStore}"></input>
				</td>
			</tr>
		   	<tr>
				<td>适用车型: </td>
				<td colspan="3">
				   <c:forEach var="jc" items="${jcsTypes}">
				     <input type="checkbox" value="${jc.jcStypeValue }" name="jcTypes" <c:if test="${(fn:containsIgnoreCase(pjStatic.jcType,jc.jcStypeValue))}">checked="checked"</c:if>/>${jc.jcStypeValue }
				   </c:forEach>
				</td>
			</tr>
			<tr id="unit">
			     <td>大部件名称:</td>
			     <td colspan="3"><select id="jcsType" onchange="getFirstUnit();" class="default">
		                     <option value="">请选择机车型号</option>
		                     <c:forEach var="jc" items="${jcsTypes}">
		                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcsType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
		                     </c:forEach>
                        </select>&nbsp;&nbsp;&nbsp;&nbsp;
                        <select id="first" class="default" name="pjStatic.firstUnit.firstunitid">
                            <option value="">请选择大部件</option>
                            <c:if test="${!empty pjStatic.firstUnit.firstunitid}">
                              <option value="${pjStatic.firstUnit.firstunitid}" selected="selected">${pjStatic.firstUnit.firstunitname}</option>
                            </c:if>
               			  </select></td>
			</tr>
			<tr>
				<td>所属流程: </td>
				<td colspan="3">
				   <select id="flow" class="default" name="pjStatic.pjFixFlowType.flowTypeId">
                     		<option value="">请选择流程</option>
                     	    <c:forEach var="flowType" items="${flowTypes}">
                       			<option value="${flowType.flowTypeId}" <c:if test="${flowType.flowTypeId==pjStatic.pjFixFlowType.flowTypeId}">selected="selected"</c:if>>${flowType.flowTypeName}</option>
                    	    </c:forEach>
               	   </select>
				</td>
			</tr>
			<tr>
			    <td>注意: </td>
				<td colspan="3">
				  <font color="red">(*流程类型一有分解、清洗、检修、组装、试验5个流程节点，流程类型二有清洗、检修2个流程节点)</font>
				</td>
			</tr>
			<tr><td colspan="4" align="center"><input type="submit" value="确定"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="reset" value="重置"/></td></tr>         
		</table>
	</form>
</body>
</html>