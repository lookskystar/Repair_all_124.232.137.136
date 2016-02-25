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
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
 <body>
 	<form action="jcManageAction!listDatePlanPri.do" method="post">
 	<div>
 		<table>
	 		<tr>
		 		<td>机车型号: </td>
			    <td ><select id="jcType"  class="default" name="jcType" style="width: 110px;">
		                     <option value="">全部</option>
		                     <c:forEach var="jc" items="${dictJcStypeList}">
		                         <option value="${jc.jcStypeValue }" <c:if test="${jc.jcStypeValue==jcType}">selected="selected"</c:if>>${jc.jcStypeValue  }</option>
		                     </c:forEach>
                        </select>
                </td>
				<td>机车编号：<input type="text"  name="jcNum" value="${jcNum }" style="width: 110px;"/></td>
				<td>修程修次：<input type="text"  name="fixFreque" value="${fixFreque }" style="width: 110px;"/></td>
				<td><input type="submit" value="查询"/>&nbsp;<input type="button" value="删除" onclick='enSureDelete();'/></td>
				
			</tr>
		</table>	
	</div> 	
   	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true" useCheckBox="true" id="jcTable">
		 	<tr>
		      <th width="20px" align="center"></th>
		      <th width="10%" align="center"><span>日计划ID</span></th>
		      <th width="15%" align="center"><span>机车类型</span></th>
		      <th width="20%" align="center"><span>机车编号</span></th>
		      <th width="20%" align="center"><span>修程修次</span></th>
		      <th width="20%" align="center"><span>扣车时间</span></th>
		      <th width="15%" align="center">操作</th>
		    </tr>
			<c:if test="${!empty datePlanPri}">
			   	<c:forEach items="${datePlanPri.datas}" var="repairjc" >
			   		<tr>
						<td align="center"><input id="rjhmId" name="jc" type="checkbox" value="${repairjc.rjhmId}"/></td>
						<td align="center"><span>${repairjc.rjhmId}</span></td>
						<td align="center"><span>${repairjc.jcType}</span></td>
						<td align="center"><span>${repairjc.jcnum}</span></td>
						<td align="center"><span>${repairjc.fixFreque}</span></td>
						<td align="center"><span>${repairjc.kcsj}</span></td>
						<td align="center">
							<a href="javascript:void(0);" onclick="deletes(${repairjc.rjhmId});" style="color:blue;">删除</a>&nbsp;
						</td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty datePlanPri.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
		 <!-- 处理分页 -->
		<div class="float_right padding5 paging">
			<div class="float_left padding_top4">
				<span>总共${datePlanPri.count }条记录</span>&nbsp;&nbsp;
				<pg:pager maxPageItems="${pageSize }" url="jcManageAction!listDatePlanPri.do" items="${datePlanPri.count }" export="page1=pageNumber">
					<pg:param name="jcType" value="${jcType}"/>
					<pg:param name="jcNum" value="${jcNum}"/>
					<pg:param name="fixFreque" value="${fixFreque}"/>
					
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
	</div>
	</form>
</body>
<script type="text/javascript">
		$(function(){
			top.Dialog.close();
	    	<c:if test="${!empty message}">
				top.Dialog.alert('${message}');
		    </c:if>
	    });
	    
		//删除
		function deletes(rjhmId){
			top.Dialog.confirm("确认删除吗？",function(){
	    	$.ajax({
				type:"post",
				async:false,
				url:"jcManageAction!deleteRepairjc.do",
				data:{"rjhmId":rjhmId},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("机车删除成功！",function(){
		    				window.location.href="<%=basePath%>jcManageAction!listDatePlanPri.do";
				    	});
		    		}else{
		    			top.Dialog.alert("机车删除失败！");
		    		}
				}
			})
			})
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
				url:"jcManageAction!deleteRepairjc.do",
				data:{"rjhmId":jcs.join(",")},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("机车删除成功！",function(){
				    			window.location.href="<%=basePath%>jcManageAction!listDatePlanPri.do";
			    			});
		    		}else{
		    			top.Dialog.alert("机车删除失败！");
		    		}
				}
			})
		}
</script>
</html>