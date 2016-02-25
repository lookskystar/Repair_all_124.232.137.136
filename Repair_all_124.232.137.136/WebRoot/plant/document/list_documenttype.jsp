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
    <title>文档分类管理</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>

	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
  </head>
  
 <body>
 	<div id="scrollContent">
 	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
 	  	<tr>
 			<td width="22%" class="ver01">
	 			<div class="box2"  panelTitle="文档类型" panelHeight="465" overflow="auto" showStatus="false">
	 				<table>
	 				<input type="hidden" id="modelType" value="${modelType }"/>
	 				<tr>
						<td>
							<button onclick="toAdd(${modelType });" style="margin-left: 5px;"><span class="icon_add">新增</span></button>
				 		   	<button onclick="toEdit();" style="margin-left: 5px;"><span class="icon_edit">修改</span></button>
				 		   	<button onclick="toDelete();" style="margin-left: 5px;"><span class="icon_delete">删除</span></button>
						</td>
					</tr>
					<tr>
						<td>
				 			<script type="text/javascript">
				 					var d = new dTree('d');
									d.add(0,-1,'全部','','','');
								
									<c:forEach var="map" items="${documentTypeMap}" varStatus="s">
										d.add(${s.index+101 },0,'<input type="checkbox" id="${map.key.id}" name="documentType" value="${map.key.id}"/>${map.key.name}','<%=basePath%>document!listDocument.do?modelType=${modelType }&type=${map.key.id}','${map.key.name}','documentIframe');
										<c:forEach var="documentType" items="${map.value}">
											d.add(${documentType.id},${s.index+101 },'<input type="checkbox" id="${documentType.id}" name="documentType" value="${documentType.id}"/>${documentType.name}','<%=basePath%>document!listDocument.do?modelType=${modelType }&type=${documentType.id}','${documentType.name}','documentIframe');
							 	   		</c:forEach>
							 	   	</c:forEach>
									document.write(d);
				 			</script>
			 			</td>
		 			</tr>
		 			</table>
	 			</div>
 	    	</td>
 			<td class="ver01">
	 			<div class="box2"  panelTitle="文档信息" panelHeight="465" overflow="auto" showStatus="false">
	 				<iframe scrolling="no" width="100%" frameBorder=0 id="documentIframe" name="documentIframe" onload="iframeHeight('documentIframe')" src="<%=basePath%>document!listDocument.do?modelType=${modelType }&temp="+<%=System.currentTimeMillis()%> allowTransparency="true"></iframe>
	 			</div>
 			</td>
		</tr>
 	</table>
	</div>	
</body>
<script type="text/javascript">
		//添加 
		function toAdd(modelType){
			var diag = new top.Dialog();
			diag.Title = "新建文档类型";
			diag.URL = "document!documentTypeAddInput.do?modelType="+modelType;
			diag.Width=400;
			diag.Height=150;
			diag.show();
		}
		
		//编辑
		function toEdit(){
			//用于保存 选中的那一条数据的ID 
			var documentTypes = [];  
			var documentType = null;
			//文档管理类型
			var modelType = $("#modelType").val();
			//判断是否一个未选
			var flag; 
			//遍历所有的name为documentType的 checkbox 
			$("input[name='documentType']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
				}
		    })
		    if (flag) {  
		    	$("input[name='documentType']").each(function() { 
		    		if ($(this).attr("checked")) { 
		    			//将选中的值 添加到 array中
		    			documentTypes.push($(this).val());
		    		}
		    	})
		    	documentType = documentTypes[0];
		    	if(documentTypes.length >= 2){
		    		top.Dialog.alert("请不要选择多条文档类型信息！");
		    	}else{
		    		var diag = new top.Dialog();
					diag.Title = "编辑文档类型";
					diag.URL = "document!documentTypeEditInput.do?modelType="+modelType+"&id="+documentType;
					diag.Width=400;
					diag.Height=150;
					diag.show();
		    	}
		    }else {
		    	top.Dialog.alert("请至少选择一条文档类型信息！");
		    }
		}
		
		//删除
		function toDelete() {
			//用于保存 选中的那一条数据的ID 
			var documentTypes = [];  
			//文档管理类型
			var modelType = $("#modelType").val();
			//判断是否一个未选
			var flag; 
			//遍历所有的name为documentType的 checkbox 
			$("input[name='documentType']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
				}
		    })
		    if (flag) {  
		    	$("input[name='documentType']").each(function() { 
		    		if ($(this).attr("checked")) { 
		    			//将选中的值 添加到 array中
		    			documentTypes.push($(this).val());
		    		}
		    	})
		    	top.Dialog.confirm("确认删除吗？",function(){ 
			    	$.ajax({
						type:"post",
						url:"document!documentTypeDelete.do",
						data:{"documentTypes":documentTypes.join(",")},
						success:function(result){
							if(result=="success"){
				    			top.Dialog.alert("文档类型信息删除成功！",function(){
						    			top.window.frmright.location.href="document!listDocumentType.do?modelType="+modelType;
					    			});
				    		}else{
				    			top.Dialog.alert("文档类型信息删除失败！");
				    		}
						}
					});
		    	});
		    }else {
		    	top.Dialog.alert("请至少选择一条文档类型信息！");
		    }
			
		}
</script>
</html>