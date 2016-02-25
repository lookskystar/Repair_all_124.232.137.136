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
    <title>未完成的检修配件（工长派工/工人接活）页面</title>
    
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

 	<div class="box2" panelTitle="未完成的检修配件列表" roller="false" showStatus="false">
		<div>
		<form id="form" action="partFixAction!unfinishedPart.do?type=${type}" method="post">
		       查询条件:车型:<select id="jcsType" onchange="getFirstUnit();" class="default" name="jcsType">
                     <option value="">请选择机车型号</option>
                     <c:forEach var="jc" items="${jcsTypes}">
                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcsType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
                     </c:forEach>
               </select>
                         专业：<select id="first" class="default" name="firstUnitId">
                     <option value="">请选择大部件</option>
               </select>&nbsp;
		    配件编号:<input type="text" style="width: 200px" name="pjNum" value="${pjNum}"/>&nbsp;
		    配件名称:<input type="text" style="width: 200px" name="pjName" value="${pjName}"/>&nbsp;
		    <input type="submit" value="查询"/>
		 </form>
			<table class="tableStyle" headFixMode="true" useMultColor="true">
				<tr align="center">
					<th width="10%"><span>配件标识</span></th>
					<th width="15%"><span>配件名</span></th>
					<th width="20%"><span>配件编号</span></th>
					<th width="25%"><span>机车类型</span></th>
					<th width="10%"><span>专业</span></th>
					<th width="10%"><span>状态</span></th>
					<th width="10%"><span>操作</span></th>
				</tr>
			</table>
		</div>
		
		<div id="scrollContent" >
			<table class="tableStyle"  useMultColor="true" useCheckBox="true">
				<c:forEach items="${pageModel.datas}" var="rec" varStatus="i">
					<tr align="center">
						<td width="10%">${rec.pjDynamicInfo.pjdid}</td>
						<td width="15%">${rec.pjDynamicInfo.pjName}</td>
						<td width="20%">
							${rec.pjDynamicInfo.pjNum}
						</td>
						<td width="25%">
						${fn:substring(rec.pjDynamicInfo.pjStaticInfo.jcType,1,fn:length(rec.pjDynamicInfo.pjStaticInfo.jcType)-1)}</td>
						<td width="10%">
							${rec.pjDynamicInfo.pjStaticInfo.firstUnit.firstunitname}
						</td>
						<td width="10%">
							检修中
						</td>
						<td width="10%">
							<input type="button" value="进入签认" onclick='top.Dialog.open({URL:"partFixAction!toSignItem.do?psize=20&pjRecId=${rec.pjRecId }&pjdid="+${rec.pjDynamicInfo.pjdid},Width:"100",Height:"100",Title:"检修签认"});'/>
						</td>
					</tr>
				</c:forEach>
			</table>
			
<div style="height:35px;">
	<div class="float_left padding5">
		<c:if test="${empty pageModel}">
			共有信息0条,一页可显示${pageSize}条记录。
		</c:if>
		<c:if test="${!empty pageModel}">
			共有信息${pageModel.count }条,每页显示${pageSize}条记录。 
		</c:if>
	</div>
	<div class="float_right padding5 paging">
		<pg:pager items="${pageModel.count}" url="partFixAction!unfinishedPart.do" maxPageItems="10" export="currentPageNumber=pageNumber">
		     <pg:param name="jcsType" value="${jcsType}"/>
		     <pg:param name="type" value="${type}"/>
			 <pg:param name="firstUnitId" value="${firstUnitId}"/>
			 <pg:param name="pjName" value="${urlName}"/>
			 <pg:param name="pjNum" value="${pjNum}"/>
		    <pg:first><span><a href="${pageUrl  }" id="first">首页</a></span></pg:first>
			<pg:prev><span><a href="${pageUrl }">上一页</a></span></pg:prev>
			<pg:pages>
				<c:choose>
					<c:when test="${currentPageNumber==pageNumber}">
						<span class="paging_current"><a href="javascript:;">${currentPageNumber }</a></span>
					</c:when>
					<c:otherwise>
						<span><a href="${pageUrl }">${pageNumber }</a></span>
					</c:otherwise>
				</c:choose>
			</pg:pages>
			<pg:next><span><a href="${pageUrl }">下一页</a></span></pg:next>
			<pg:last><span><a href="${pageUrl }">末页</a></span></pg:last>
		</pg:pager>
	</div>
	<div class="clear"></div>
</div>
		</div>
	</div>
  </body>
</html>
