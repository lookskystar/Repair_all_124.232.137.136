<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <base href="<%=basePath%>"/>
    <title>配件检修</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="fix/js/part_plan.js"></script>
	<script type="text/javascript">
	   //根据机车类型得到一级部件信息
	   function getFirstUnit(){
		   var jcsType=$("#jcsType").val();
		   var firstUnitId = '${firstUnitId}';
		   if(jcsType!=""){
			   $.post("<%=basePath%>pjManageAction!ajaxGetFirstUnit.do",{"jcsType":jcsType},function(data){
	               var result=eval("("+data+")");
	               var firstUnits=result.firstUnits;
	               var str="<option value=''>请选择大部件</option>";
	               for(var i=0;i<firstUnits.length;i++){
	                   if(firstUnitId!=null && firstUnitId!="" && firstUnits[i].firstUnitId==firstUnitId){
	                   		str+="<option selected='selected' value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";
	                   }else{
	                   		str+="<option value="+firstUnits[i].firstUnitId+">"+firstUnits[i].firstUnitName+"</option>";
	                   }
	               }
	               $("#first").children().remove();
	               $("#first").append(str);
	           });
		   }
	   }
	   
	   $(function(){
		   getFirstUnit();
	   });
	</script>
  </head>
  
  <body>

 	<div class="box2" panelTitle="配件检修签认列表" roller="false" showStatus="false">
		<div>
		<form id="form" action="partFixAction!unfinishedPartCount.do" method="post">
		       查询条件:车型:<select id="jcsType" onchange="getFirstUnit();" class="default" name="jcsType">
                     <option value="">请选择机车型号</option>
                     <c:forEach var="jc" items="${jcsTypes}">
                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcsType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
                     </c:forEach>
               </select>
                         专业：<select id="first" class="default" name="firstUnitId">
                     <option value="">请选择大部件</option>
               </select>&nbsp;
		    配件名称:<input type="text" style="width: 200px" name="pjName" value="${pjName}"/>&nbsp;
		    <input type="submit" value="查询"/>
		 </form>
			<table class="tableStyle" headFixMode="true" useMultColor="true">
				<tr align="center">
					<th width="5%"><span>序号</span></th>
					<th width="20%"><span>配件名称</span></th>
					<th width="20%"><span>机车类型</span></th>
					<th width="20%"><span>专业</span></th>
					<th width="20%"><span>待签数</span></th>
					<th width="20%"><span>检修中总数</span></th>
				</tr>
			</table>
		</div>
		
		<div id="scrollContent">
			<table class="tableStyle"  useMultColor="false" useCheckBox="false">
				<c:forEach items="${list}" var="rec" varStatus="i">
					<tr align="center">
						<td width="5%">${i.index+1 }</td>
						<td width="20%">
					        <script type="text/javascript">
					       			document.write('<a style="color:blue;" href="'+encodeURI("partFixAction!unfinishedPart.do?jcsType=${fn:substring(rec[1],1,fn:length(rec[1])-1)}&type=0&pjName=${rec[0]}")+'">${rec[0]}</a>');
					    	</script>
						</td>
						<td width="20%">${fn:substring(rec[1],1,fn:length(rec[1])-1)}</td>
						<td width="20%">${rec[2]}</td>
						<td width="20%">
							<c:choose>
								<c:when test="${rec[4]>0}">
								    <script type="text/javascript">
					       				document.write('<a style="color:red;" href="'+encodeURI("partFixAction!unfinishedPart.do?jcsType=${fn:substring(rec[1],1,fn:length(rec[1])-1)}&type=1&pjName=${rec[0]}")+'">有&nbsp;<font style="font-weight: bolder">${rec[4]}</font>&nbsp;个待签配件</a>');
					    			</script>
								</c:when>
								<c:otherwise>${rec[4]}</c:otherwise>
							</c:choose>
						</td>
						<td width="20%"><a style="color: blue;font-weight: bolder;" onclick="javascript:void(0);">&nbsp;${rec[3]}&nbsp;</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
  </body>
</html>
