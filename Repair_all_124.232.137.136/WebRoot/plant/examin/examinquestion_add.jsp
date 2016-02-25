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
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
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
				<td>标准答案：</td>
				<td valign="top">
					<input type="radio" id="answer" name="_answer" class="validate[required]" value="A"/>A
					<input type="radio" id="answer" name="_answer" class="validate[required]" value="B"/>B
					<input type="radio" id="answer" name="_answer" class="validate[required]" value="C"/>C
					<input type="radio" id="answer" name="_answer" class="validate[required]" value="D"/>D
				</td>
			</tr>
			<tr>
				<td>答案A：</td>
				<td valign="top">
					<input type="text" id="chooseA" name="_chooseA" class="validate[required]"/>
				</td>
			</tr>
			<tr>
				<td>答案B：</td>
				<td valign="top">
					<input type="text" id="chooseB" name="_chooseB" class="validate[required]"/>
				</td>
			</tr>
			<tr>
				<td>答案C：</td>
				<td valign="top">
					<input type="text" id="chooseC" name="_chooseC" class="validate[required]"/>
				</td>
			</tr>
			<tr>
				<td>答案D：</td>
				<td valign="top">
					<input type="text" id="chooseD" name="_chooseD" class="validate[required]"/>
				</td>
			</tr>
			<tr>
				<td>问题类型：</td>
				<td> 
					<select id="type" name="_type">
					    <option value='0'>--请选择--</option>
					    <c:if test="${!empty examinQuestionTypeList}">
						    <c:forEach items="${examinQuestionTypeList}" var="questionType">
						    	 <option value="${questionType.type }">${questionType.name } </option>
						    </c:forEach>
					    </c:if>
					 </select>
				</td>
			</tr>
			<tr>
				<td>发布人：</td>
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
			//问题
			var fileName = $("#fileName").val();
			//标准答案
			var answer = $("input[name='_answer']:checked").val();
			//答案A
			var chooseA = $("#chooseA").val();
			//答案B
			var chooseB = $("#chooseB").val();
			//答案C
			var chooseC = $("#chooseC").val();
			//答案D
			var chooseD = $("#chooseD").val();
			//问题类型
			var type = $("#type").val();
			//上传人
			var uploaderId = $("#uploaderId").val();
			if(fileName == "" || fileName == null || fileName == undefined){
				top.Dialog.alert("问题名不能为空！");
			}else if(answer == "" || answer == null || answer == undefined){
				top.Dialog.alert("答案不能为空！");
			}else if(chooseA == "" || chooseA == null || chooseA == undefined){
				top.Dialog.alert("答案A名不能为空！");
			}else if(chooseB == "" || chooseB == null || chooseB == undefined){
				top.Dialog.alert("答案B不能为空！");
			}else if(chooseC == "" || chooseC == null || chooseC == undefined){
				top.Dialog.alert("答案C不能为空！");
			}else if(chooseD == "" || chooseD == null || chooseD == undefined){
				top.Dialog.alert("答案D不能为空！");
			}else if(chooseD == "" || chooseD == null || chooseD == undefined){
				top.Dialog.alert("答案D不能为空！");
			}else if(type == "0"){
				top.Dialog.alert("请选择问题类型！");
			}else{
				//ACTION
				$.post("examin!examinQuestionAddConfirm.do",{"fileName":fileName, "answer":answer, "type":type, "uploaderId":uploaderId, "chooseA":chooseA,
							"chooseB":chooseB, "chooseC":chooseC, "chooseD":chooseD },
					function(data){
						if(data == "success"){
							top.Dialog.alert("新建问题成功！");
							top.window.frmright.location.href="examin!listExaminQuestionType.do";
						}else{
							top.Dialog.alert("新建问题失败！");
						}
				})
			}
		})
	})
</script>
</html>