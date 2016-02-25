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
	
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
  </head>
  
 <body>
 	<div id="scrollContent">
 	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
 	  	<tr>
 			<td width="22%" class="ver01">
	 			<div class="box2"  panelTitle="问题类型" panelHeight="465" overflow="auto" showStatus="false">
	 				<table>
	 				<tr>
						<td>
							<button onclick="toAdd();" style="margin-left: 5px;"><span class="icon_add">新增</span></button>
				 		   	<button onclick="toEdit();" style="margin-left: 5px;"><span class="icon_edit">修改</span></button>
				 		   	<button onclick="toDelete();" style="margin-left: 5px;"><span class="icon_delete">删除</span></button>
						</td>
					</tr>
					<tr>
						<td>
				 			<script type="text/javascript">
				 					var d = new dTree('d');
									d.add(0,-1,'全部','','','');
								
									<c:forEach var="map" items="${questionTypeMap}" varStatus="s">
										d.add(${s.index+101 },0,'<input type="checkbox" id="${map.key.id}" name="questionType" value="${map.key.id}"/>${map.key.name}','<%=basePath%>question!listQuestion.do?type=${map.key.id}','${map.key.name}','questionIframe');
										<c:forEach var="questionType" items="${map.value}">
											d.add(${questionType.id},${s.index+101 },'<input type="checkbox" id="${questionType.id}" name="questionType" value="${questionType.id}"/>${questionType.name}','<%=basePath%>question!listQuestion.do?type=${questionType.id}','${questionType.name}','questionIframe');
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
	 			<div class="box2"  panelTitle="问题信息" panelHeight="465" overflow="auto" showStatus="false">
	 				<iframe scrolling="no" width="100%" frameBorder=0 id="questionIframe" name="questionIframe" onload="iframeHeight('questionIframe')" src="<%=basePath%>question!listQuestion.do?temp="+<%=System.currentTimeMillis() %>  allowTransparency="true"></iframe>
	 			</div>
 			</td>
		</tr>
 	</table>
	</div>	
</body>
<script type="text/javascript">
	//添加 
	function toAdd(){
		var diag = new top.Dialog();
		diag.Title = "新建问题类型";
		diag.URL = "question!questionTypeAddInput.do";
		diag.Width=400;
		diag.Height=150;
		diag.show();
	}
	
	//编辑
	function toEdit(){
		//用于保存 选中的那一条数据的ID 
		var questionTypes = [];  
		var questionType = null;
		//判断是否一个未选
		var flag; 
		//遍历所有的name为questionType的 checkbox 
		$("input[name='questionType']").each(function() {
			//判断是否选中 
			if ($(this).attr("checked")) { 
				//只要有一个被选择 设置为 true
				flag = true; 
			}
	    })
	    if (flag) {  
	    	$("input[name='questionType']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			//将选中的值 添加到 array中
	    			questionTypes.push($(this).val());
	    		}
	    	})
	    	questionType = questionTypes[0];
	    	if(questionTypes.length >= 2){
	    		top.Dialog.alert("请不要选择多条文档类型信息！");
	    	}else{
	    		var diag = new top.Dialog();
				diag.Title = "编辑问题类型";
				diag.URL = "question!questionTypeEditInput.do?id="+questionType;
				diag.Width=400;
				diag.Height=150;
				diag.show();
	    	}
	    }else {
	    	top.Dialog.alert("请至少选择一条问题类型信息！");
	    }
	}
	
	//删除
	function toDelete() {
		//用于保存 选中的那一条数据的ID 
		var questionTypes = [];  
		//判断是否一个未选
		var flag; 
		//遍历所有的name为questionType 的 checkbox 
		$("input[name='questionType']").each(function() {
			//判断是否选中 
			if ($(this).attr("checked")) { 
				//只要有一个被选择 设置为 true
				flag = true; 
			}
	    })
	    if (flag) {  
	    	$("input[name='questionType']").each(function() { 
	    		if ($(this).attr("checked")) { 
	    			//将选中的值 添加到 array中
	    			questionTypes.push($(this).val());
	    		}
	    	})
	    	top.Dialog.confirm("确认删除吗？",function(){ 
		    	$.ajax({
					type:"post",
					url:"question!questionTypeDelete.do",
					data:{"questionTypes":questionTypes.join(",")},
					success:function(result){
						if(result=="success"){
			    			top.Dialog.alert("问题类型信息删除成功！",function(){
					    			top.window.frmright.location.href="question!listQuestionType.do";
				    			});
			    		}else{
			    			top.Dialog.alert("问题类型信息删除失败！");
			    		}
					}
				});
	    	});
	    }else {
	    	top.Dialog.alert("请至少选择一条问题类型信息！");
	    }
		
	}
	

</script>
</html>