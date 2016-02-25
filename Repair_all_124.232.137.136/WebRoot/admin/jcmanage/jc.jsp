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
  </head>
 <body>
 	
 	<div>
 		<form action="jcManageAction!listJtRunKiloRec.do" method="post" >
	 		<table>
		 		<tr>
			 		<td>
						<input type="text" watermark="输入机车编号" style="line-height: 22px;vertical-align: top" name="jcNum" value="${jcNum }"/>&nbsp;
						<input type="submit" value="查询" />&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<td>	
				 		<input type="button" value="新增" onclick="toAdd()"/>&nbsp;&nbsp;
				 		<input type="button" value="删除" onclick='enSureDelete();'/>&nbsp;&nbsp;
				 	</td>
			 	</tr>	
			</table>	
		</form> 
 	</div>
 	
   	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true" useCheckBox="true" id="jcTable">
		 	<tr>
		      <th width="30px" align="center"></th>
		      <th width="15%" align="center"><span>机车ID</span></th>
		      <th width="15%" align="center"><span>机车类型</span></th>
		      <th width="20%" align="center"><span>机车编号</span></th>
		      <th width="20%" align="center"><span>当日走行公里</span></th>
		      <th width="20%" align="center"><span>总走行公里</span></th>
		      <th width="20%" align="center">操作</th>
		    </tr>
			<c:if test="${!empty jtRunKiloRecPm}">
			   	<c:forEach items="${jtRunKiloRecPm.datas}" var="jtRunKiloRec" >
			   		<tr>
						<td width="25" align="center"><input id="runId" name="jc" type="checkbox" value="${jtRunKiloRec.runId}"/></td>
						<td width="60" align="center"><span>${jtRunKiloRec.runId}</span></td>
						<td width="90" align="center"><span>${jtRunKiloRec.jcType}</span></td>
						<td width="80" align="center"><span>${jtRunKiloRec.jcNum}</span></td>
						<td width="90" align="center"><span>${jtRunKiloRec.dayRunKilo}</span></td>
						<td width="90" align="center"><span>${jtRunKiloRec.totalRunKilo}</span></td>
						<td width="100" align="center">
							<span class="img_edit hand" title="修改" onclick="edite(${jtRunKiloRec.runId});"></span>
							<span class="img_delete hand" title="删除" onclick="deletes(${jtRunKiloRec.runId});"></span>
						</td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty jtRunKiloRecPm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
	</div>
	<!-- 处理分页 -->
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="jcManageAction!listJtRunKiloRec.do" items="${jtRunKiloRecPm.count }" export="page1=pageNumber">
				<pg:param name="jcNum" value="${jcNum}"/>
		  		<pg:first>
					 <span><a href="${pageUrl }" id="first">首页</a></span>
		 		</pg:first>
		 		<pg:prev>
					  <span><a href="${pageUrl }">上一页</a></span>
		  		</pg:prev>
	  	  		<pg:pages>
					<c:choose>
						<c:when test="${page1==pageNumber }">
							<span class="paging_current"><a href="javascript:;">${pageNumber }</a></span>
						</c:when>
						<c:otherwise>
							<span><a href="${pageUrl }">${pageNumber }</a></span>
						</c:otherwise>
					</c:choose>
		  		</pg:pages>
		  		<pg:next>
				    <span><a href="${pageUrl }">下一页</a></span>
		  		</pg:next>
		  		<pg:last>
				  	<span><a href="${pageUrl }">末页</a></span>
		 		</pg:last>
		 	</pg:pager>
		</div>
		<div class="clear"></div>
	</div>
<script type="text/javascript">
	    //添加机车
		function toAdd(){
		   	top.Dialog.open({URL:"<%=basePath%>jcManageAction!addJcInput.do",Width:500,Height:450,Title:"添加机车"});
		}
		
		//删除
		function deletes(runId){
			top.Dialog.confirm("确定要删除该信息?",function(){
				$.ajax({
					type:"post",
					async:false,
					url:"jcManageAction!deleteJtRunKiloRec.do",
					data:{"jcs":runId},
					success:function(result){
						if(result=="success"){
			    			top.Dialog.alert("机车删除成功！",function(){
								window.location.href="<%=basePath%>jcManageAction!listJtRunKiloRec.do";
					    			});
			    		}else{
			    			top.Dialog.alert("机车删除失败！");
			    		}
					}
				});
			});
	    }
	    
	    //判断是否选中信息
		function enSureDelete(){
			//判断是否一个未选
			var flag; 
			//遍历所有的name为document的 checkbox 
			$("input[name='jc']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
				}
		    })
		    if (flag) {  
		    	top.Dialog.confirm("确认删除？",function(){
		    		toDelete();
		    	});
		    }else {
		    	top.Dialog.alert("请至少选择一条机车信息！");
		    }
		
		}
	    
		//删除
		function toDelete() {
			//用于保存 选中的那一条数据的ID 
			var jcs = [];  
	    	$("input[name='jc']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			//将选中的值 添加到 array中
	    			jcs.push($(this).val());
	    		}
	    	}) 
	    	$.ajax({
				type:"post",
				async:false,
				url:"jcManageAction!deleteJtRunKiloRec.do",
				data:{"jcs":jcs.join(",")},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("机车删除成功！",function(){
		    				window.location.href="<%=basePath%>jcManageAction!listJtRunKiloRec.do";
			    			});
		    		}else{
		    			top.Dialog.alert("机车删除失败！");
		    		}
				}
			})
		}
	
		//修改机车信息
		function edite(runId){
			if(runId != "" && runId != undefined && runId != null){
				top.Dialog.open({URL:"jcManageAction!editeJtRunKiloRecInput.do?runId="+runId,Width:500,Height:450,Title:"修改机车"});
			}
			else{
				top.Dialog.alert("请选择要编辑的机车！");
			}
		}

</script>
</body>
</html>