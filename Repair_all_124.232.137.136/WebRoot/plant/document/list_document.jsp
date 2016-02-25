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
    <title>文档管理</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
<body>
 	<form action="document!listDocument.do?modelType=${modelType }" method="post" id="subfrom">
 	<div>
 		<table>
 			<tr>
				<td>开始时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateStart"  name="dateStart"/></td>
				<td>结束时间：</td>
				<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateEnd"  name="dateEnd"/></td>
			</tr>
 			<tr>
 				<td>文档名称：</td>
 				<td><input type="text" watermark="输入文档名称" name="name" value="${name }"/></td>
 				<td>上&nbsp;&nbsp;传&nbsp;&nbsp;人：</td>
 				<td><input type="text" watermark="输入上传人姓名"  name="uploader" value="${uploader }"/></td>
 			</tr>
 			<tr>
 				<td>关&nbsp;&nbsp;键&nbsp;&nbsp;字：</td>
 				<td><input type="text" watermark="输入简介关键字"  name="description" value="${description }"/></td>
 				<td><button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button></td>
 				
 			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="新增" onclick="toAddDocu(${modelType });"/>&nbsp;&nbsp;
					<input type="button" value="删除" onclick="enSureDelete();"/>
				</td>
			</tr>
			<input type="hidden" id="modelType" value="${modelType }"/>
		</table>
	</div>
   	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true"  useCheckBox="true" id="documentTable">
		 	<tr>
		 		<th width="30px" align="center"></th>
		      	<th width="15%" align="center"><span>文档类型</span></th>
		      	<th width="30%" align="center"><span>文档名称</span></th>
		      	<th width="10%" align="center"><span>上传人</span></th> 
		      	<th width="25%" align="center"><span>上传时间</span></th>
		      	<th width="20%" align="center">操作</th>
		    </tr>
			<c:if test="${!empty documentPm}">
			   	<c:forEach items="${documentPm.datas}" var="document" >
			   		<tr>
			   			<td width="30px" align="center"><input id="documentid" name="document" type="checkbox" value="${document.id}"/></td>
						<td width="15%" align="center"><span>${document.type.name}</span></td>
						<td width="30%" align="center">
							<span title="${document.name}">
								<a href="${document.filePath}" target="_blank" class="icon_${fn:substringAfter(document.filePath,'.')}">${fn:substring(document.name,0,10)}...</a>
							</span>
						</td>
						<td width="10%" align="center"><span>${document.uploader.xm}</span></td>
						<td width="25%" align="center"><span>${document.uploadtime}</span></td>
						<td width="20%" align="center">
							<a href="${document.filePath}" target="_blank"><span class="img_btn_down" title="下载" style="margin-left: 15px;"></span></a>
							<span class="img_delete hand" title="删除" onclick="deleteDocu('${document.id}');" style="margin-left: 15px;"></span>
						</td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty documentPm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${documentPm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="document!listDocument.do" items="${documentPm.count }" export="page1=pageNumber">
				<pg:param name="type" value="${type}"/>
				<pg:param name="name" value="${name}"/>
				<pg:param name="uploader" value="${uploader}"/>
				<pg:param name="dateStart" value="${dateStart}"/>
				<pg:param name="dateEnd" value="${dateEnd}"/>
				<pg:param name="examiner" value="${examiner}"/>
				<pg:param name="modelType" value="${modelType}"/>
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
	</form>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
		//新建
		function toAddDocu(modelType){
			var diag = new top.Dialog();
			diag.Title = "新建文档";
			diag.URL = "document!documentAddInput.do?modelType="+modelType;
			diag.Width=550;
			diag.Height=300;
			diag.show();
		}
		
		//判断是否选中信息
		function enSureDelete(){
			//判断是否一个未选
			var flag; 
			//遍历所有的name为document的 checkbox 
			$("input[name='document']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
				}
		    })
		    if (flag) {  
		    	top.Dialog.confirm("确认删除？",function(){
		    		toDeleteDocu();
		    	});
		    }else {
		    	top.Dialog.alert("请至少选择一条文档信息！");
		    }
		
		}
		
		//删除
		function toDeleteDocu() {
			//用于保存 选中的那一条数据的ID 
			var documents = [];  
			//文档管理类型
			var modelType = $("#modelType").val();
	    	$("input[name='document']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			//将选中的值 添加到 array中
	    			documents.push($(this).val());
	    		}
	    	})
	    	$.ajax({
				type:"post",
				async:false,
				url:"document!documentDelete.do",
				data:{"documents":documents.join(",")},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("文档信息删除成功！",function(){
				    			top.window.frmright.location.href="document!listDocumentType.do?modelType="+modelType;
			    			});
		    		}else{
		    			top.Dialog.alert("文档信息删除失败！");
		    		}
				}
			});
		}
		
		//删除
		function deleteDocu(id) {
			//用于保存 选中的那一条数据的ID 
			var documents = [];  
			var modelType = $("#modelType").val();
	    	documents.push(id);
	    	$.ajax({
				type:"post",
				async:false,
				url:"document!documentDelete.do",
				data:{"documents":documents.join(","),"modelType":modelType},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("文档信息删除成功！",function(){
				    			top.window.frmright.location.href="document!listDocumentType.do?modelType="+modelType;
			    			});
		    		}else{
		    			top.Dialog.alert("文档信息删除失败！");
		    		}
				}
			});
		}
		
		//表单提交
		function sub(){
			$("#subform").submit();
		}
		
		//绑定事件
		function addEventHandler(target, type, func) {
		    if (target.addEventListener)
		        target.addEventListener(type, func, false);
		    else if (target.attachEvent)
		        target.attachEvent("on" + type, func);
		    else target["on" + type] = func;
		}
		
		//解除事件 
		function removeEventHandler(target, type, func) {
		    if (target.removeEventListener)
		        target.removeEventListener(type, func, false);
		    else if (target.detachEvent)
		        target.detachEvent("on" + type, func);
		    else delete target["on" + type];
		}
		
		//$(document).ready(function(){
		//	var deleteBtn = document.getElementById("delete");
		//	var ensureInfo = function(){ enSureDelete(); };
		//	addEventHandler(deleteBtn,"click",ensureInfo);
		//})
</script>
</body>
</html>