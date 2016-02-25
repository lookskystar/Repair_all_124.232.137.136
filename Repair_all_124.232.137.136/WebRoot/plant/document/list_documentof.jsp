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
 	<form action="document!documentOfType.do?type=14103" method="post" id="subfrom">
 	<div class="box2">
 			<table>
 			<tr>
				<td>开始时间：<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateStart"  name="dateStart"/></td>
				<td>结束时间：<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateEnd"  name="dateEnd"/></td>
 			</tr>
 			<tr>
 				<td>文档名称：<input type="text" watermark="输入文档名称" name="name" value="${name }"/></td>
 				<td>上&nbsp;&nbsp;传&nbsp;&nbsp;人：<input type="text" watermark="输入上传人姓名"  name="uploader" value="${uploader }"/></td>
 				<td>关&nbsp;&nbsp;键&nbsp;&nbsp;字：<input type="text" watermark="输入简介关键字"  name="description" value="${description }"/></td>
 				<td><button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button></td>
 			</tr>
		</table>
	</div>
   	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true"  id="documentTable">
		 	<tr>
		      	<th width="10%" align="center"><span>文档类型</span></th>
		      	<th width="20%" align="center"><span>文档名称</span></th>
		      	<th width="8%" align="center"><span>上传人</span></th> 
		      	<th width="20%" align="center"><span>上传时间</span></th>
		      	<th width="8%" align="center"><span>审批人</span></th>
		      	<th width="20%" align="center"><span>审批时间</span></th>
		      	<th width="20%" align="center">操作</th>
		    </tr>
			<c:if test="${!empty DocumentPm}">
			   	<c:forEach items="${DocumentPm.datas}" var="document" >
			   		<tr>
						<td width="10%" align="center"><span>${document.type.name}</span></td>
						<td width="20%" align="center">
							<span>
								<a href="${document.filePath}" target="_blank" class="icon_${fn:substringAfter(document.filePath,'.')}">${document.name}</a>
							</span>
						</td>
						<td width="8%" align="center"><span>${document.uploader.xm}</span></td>
						<td width="20%" align="center"><span>${document.uploadtime}</span></td>
						<td width="8%" align="center"><span>${document.examiner.xm}</span></td>
						<td width="20%" align="center"><span>${document.examintime}</span></td>
						<td>
							<span><a href="${document.filePath}" target="_blank" style="color:blue;">下载</a></span>
						</td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty DocumentPm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${DocumentPm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="document!documentOfType.do" items="${DocumentPm.count }" export="page1=pageNumber">
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
</body>
<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
		//新建
		function toAddDocu(){
			var diag = new top.Dialog();
			diag.Title = "新建文档";
			diag.URL = "document!documentAddInput.do";
			diag.Width=400;
			diag.Height=200;
			diag.show();
		}
		
		//删除
		function toDeleteDocu() {
			//用于保存 选中的那一条数据的ID 
			var documents = [];  
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
					    			top.window.frmright.location.href="document!listDocumentType.do";
				    			});
			    		}else{
			    			top.Dialog.alert("文档信息删除失败！");
			    		}
					}
				});
		    }else {
		    	top.Dialog.alert("请至少选择一条文档信息！");
		    }
		}
		
		//删除
		function deleteDocu(id) {
			//用于保存 选中的那一条数据的ID 
			var documents = [];  
	    	documents.push(id);
	    	$.ajax({
				type:"post",
				async:false,
				url:"document!documentDelete.do",
				data:{"documents":documents.join(",")},
				success:function(result){
					if(result=="success"){
		    			top.Dialog.alert("文档信息删除成功！",function(){
				    			top.window.frmright.location.href="document!listDocumentType.do";
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
</script>
</html>