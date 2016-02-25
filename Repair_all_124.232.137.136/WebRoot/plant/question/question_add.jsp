<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<!-- Ajax上传图片 -->
	<script type="text/javascript" src="js/jquery.form.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!--框架必需end-->
	
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
</head>
<body>
	<form action="" method="post" target="frmright" id="subform">
		<table class="tableStyle" transMode="true">
			<tr>
				<td>问题：</td>
				<td valign="top">
					<textarea rows="" cols="" id="fileName" name="_fileName" class="validate[required]" ></textarea>
				</td>
			</tr>
			<tr>
				<td>答案：</td>
				<td valign="top">
					<textarea rows="" cols="" id="answer" name="_answer" class="validate[required]"></textarea>
				</td>
			</tr>
			<tr>
				<td>图片上传：</td>
				<td valign="top">
					<input id="fileupload" name="fileMaterial" type="file" /> 
					<input type="button" onclick="uploadFile();" value="上传" />
					<input type="hidden" id="imgUrl" name="_imgUrl" value=""/>
				</td>
			</tr>
			<tr>
				<td>问题类型：</td>
				<td> 
					<select id="type" name="_type">
					    <option value='0'>--请选择--</option>
					    <c:if test="${!empty questionTypeList}">
						    <c:forEach items="${questionTypeList}" var="questionType">
						    	 <option value="${questionType.id }">${questionType.name } </option>
						    </c:forEach>
					    </c:if>
					 </select>
				</td>
			</tr>
			<tr>
				<td>上传人：</td>
				<td>
					<input type="text" id="uploader" name="_uploader" value="${sessionScope.session_user.xm}" disabled="disabled"/>
					<input type="hidden" id="uploaderId" name="_uploaderId" value="${sessionScope.session_user.userid}"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value=" 提 交 " id="subEnter"/>
					<input type="reset" value=" 重 置 "/>
				</td>
			</tr>
		</table>
	</form>		
</body>
<script type="text/javascript">

	$(document).ready(function(){
		$("#subEnter").bind("click",function(){
			if($("#fileName").val() != "" && $("#fileName").val() != null && $("#fileName").val() != undefined){
				//问题
				var fileName = $("#fileName").val();
				//答案
				var answer = $("#answer").val();
				//问题类型
				var type = $("#type").val();
				//上传人
				var uploaderId = $("#uploaderId").val();
				//图片URL
				var imgUrl = $("#imgUrl").val();
				//ACTION
				$.post("question!questionAddConfirm.do",{"fileName":fileName, "answer":answer, "type":type, "uploaderId":uploaderId, "imgUrl":imgUrl},
					function(data){
						if(data == "success"){
							top.Dialog.alert("新建问题成功！");
							top.window.frmright.location.href="question!listQuestionType.do";
						}else{
							top.Dialog.alert("新建问题失败！");
						}
				})
			}else{
				top.Dialog.alert("问题名不能为空！");
			}
		})
	})
	
	//文件上传
	function uploadFile(){
	    $(document).ready(
            function(){  
                var options = { 
                	//跳转到相应的Action  
                   	url : "question!ajaxUploadFile.action",
                  	//提交方式  
                   	type : "POST",
                   	//数据类型  
                   	dataType : "script",
                   	//调用Action后返回过来的数据  
                   	success : function(msg) {
                        if (msg.indexOf(",") > 0) {  
                             var data = msg.split(","); 
                             $("#imgUrl").val(data[0]); 
                             top.Dialog.alert(data[2]);
                         } else {  
                         	top.Dialog.alert(msg);
                         }  
                        
                   }  
                };  
                //绑定页面中form表单的id  
                $("#subform").ajaxSubmit(options);
                return false;  
            });  
	}  
</script>
</html>