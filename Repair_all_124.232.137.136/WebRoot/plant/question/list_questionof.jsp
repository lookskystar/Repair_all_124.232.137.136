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
	<script type="text/javascript" src="js/jquery.imgPreview.js"></script>
	<!--框架必需end-->
  </head>
 <body>
 	<form action="question!questionOfType.do" method="post" id="subfrom">
 	<div class="box2">
 		<table>
 			<tr>
 				<td>
					<input type="text" watermark="输入问题" style="line-height: 22px;vertical-align: top" name="questions" value="${questions }"/>
				</td>
				<td>
					<input type="text" watermark="输入上传人姓名" style="line-height: 22px;vertical-align: top" name="uploader" value="${uploader }"/>
				</td>
				<td>开始时间：</td>
				<td>
					<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateStart"  name="dateStart" value="${dateStart }"/>
				</td>
				<td>结束时间：</td>
				<td>
					<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd HH:mm:ss'}))" id="dateEnd"  name="dateEnd" value="${dateEnd }"/>
				</td>
				<td>
					<button onclick="sub();"><span class="icon_find" style="height: 22px;">查询</span></button>
				</td>
 			</tr>
 		</table>
	</div>
   	<div id="scrollContent">
		 <table class="tableStyle"  useMultColor="true" id="questionTable">
		 	<tr>
		      	<th width="10%" align="center"><span>问题类型</span></th>
		      	<th width="25%" align="center"><span>问题</span></th>
		      	<th width="25%" align="center"><span>答案</span></th>
		      	<th width="10%" align="center"><span>发布人</span></th> 
		      	<th width="20%" align="center"><span>发布时间</span></th>
		    </tr>
			<c:if test="${!empty questionPm}">
			   	<c:forEach items="${questionPm.datas}" var="questions" >
			   		<tr>
						<td width="10%" align="center">
							<span>
								${questions.type.name}
							</span>
						</td>
						<td width="20%" align="center">
							<span title="${questions.question}">
								${fn:substring(questions.question,0,10)}...
							</span>
						</td>
						<td width="20%" align="center">
							<span title="${questions.answer}">
								${fn:substring(questions.answer,0,10)}...
							</span>
						</td>
						<td width="10%" align="center"><span>${questions.uploader.xm}</span></td>
						<td width="20%" align="center"><span>${questions.uploadtime}</span></td>
					</tr>
			   	</c:forEach>
			 </c:if>
			 <c:if test="${empty questionPm.datas}">
			 	<tr> 
			 		<td class="ver01" align="center" colspan="5">没有相应的数据记录!</td>
			 	</tr>
			 </c:if>
		 </table>
	</div>
	<!-- 处理分页 -->
	<div class="float_left padding5">  共有信息${questionPm.count}条。</div>
	<div class="float_right padding5 paging">
		<div class="float_left padding_top4">
			<pg:pager maxPageItems="${pageSize }" url="question!listQuestion.do" items="${questionPm.count }" export="page1=pageNumber">
				<pg:param name="type" value="${type}"/>
				<pg:param name="questions" value="${questions}"/>
				<pg:param name="uploader" value="${uploader}"/>
				<pg:param name="dateStart" value="${dateStart}"/>
				<pg:param name="dateEnd" value="${dateEnd}"/>
				<pg:param name="examiner" value="${examiner}"/>
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
		function toAddQues(){
			var diag = new top.Dialog();
			diag.Title = "新建问题";
			diag.URL = "question!questionAddInput.do";
			diag.Width=500;
			diag.Height=300;
			diag.show();
		}
		
		//删除
		function toDeleteQues() {
			//用于保存 选中的那一条数据的ID 
			var questions = [];  
			//判断是否一个未选
			var flag; 
			//遍历所有的name为question的 checkbox 
			$("input[name='question']").each(function() {
				//判断是否选中 
				if ($(this).attr("checked")) { 
					//只要有一个被选择 设置为 true
					flag = true; 
				}
		    })
		    if (flag) {  
		    	$("input[name='question']").each(function() { 
		    		if ($(this).attr("checked")) { 
		    			//将选中的值 添加到 array中
		    			questions.push($(this).val());
		    		}
		    	})
		    	top.Dialog.confirm("确认删除吗？",function(){ 
			    	$.ajax({
						type:"post",
						async:false,
						url:"question!questionDelete.do",
						data:{"questions":questions.join(",")},
						success:function(result){
							if(result=="success"){
				    			top.Dialog.alert("问题信息删除成功！",function(){
						    			top.window.frmright.location.href="question!listQuestionType.do";
					    			});
				    		}else{
				    			top.Dialog.alert("问题信息删除失败！");
				    		}
						}
					});
				});
		    }else {
		    	top.Dialog.alert("请至少选择一条问题信息！");
		    }
		}
		
		//删除
		function deleteQues(id) {
			//用于保存 选中的那一条数据的ID 
			var questions = [];  
	    	questions.push(id);
	    	top.Dialog.confirm("确认删除吗？",function(){ 
		    	$.ajax({
					type:"post",
					async:false,
					url:"question!questionDelete.do",
					data:{"questions":questions.join(",")},
					success:function(result){
						if(result=="success"){
			    			top.Dialog.alert("问题信息删除成功！",function(){
					    			top.window.frmright.location.href="question!listQuestionType.do";
				    			});
			    		}else{
			    			top.Dialog.alert("问题信息删除失败！");
			    		}
					}
				});
			});
		}
		
		//编辑
		function editQues(id){
			var diag = new top.Dialog();
			diag.Title = "编辑问题";
			diag.URL = "question!questionEditInput.do?id="+id;
			diag.Width=500;
			diag.Height=500;
			diag.show();
		}
		
		//表单提交
		function sub(){
			$("#subform").submit();
		}
</script>
</html>