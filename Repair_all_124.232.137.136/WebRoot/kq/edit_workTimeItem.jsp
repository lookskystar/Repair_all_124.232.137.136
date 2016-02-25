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
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<script src="js/form/validationEngine-cn.js" type="text/javascript"></script>
	<script src="js/form/validationEngine.js" type="text/javascript"></script>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript">
		function checkform(){
			    if($("#proteamid").val()==''){
				    alert("班组不能为空！");
				    return false;
			    }
			    if($("#itemName").val()==''){
				    alert("项目名称不能为空！");
				    return false;
			    }
				if($("#itemScore").val()==''){
					alert("项目分值不能为空！");
					return false;
				}
			}
		</script>
</head>
<body>
	<form action="maintainAction!editWorkTimeItem.do" method="post" target="frmright">   
	  	    <input type="hidden" value="${workTimeItem.id }" name="workTimeItemId"/>
			<table class="tableStyle" transMode="true">
				<tr>
					<td>班组：</td>
					<td>
				   	 	<select colNum="4" colWidth="80" id="proteamid"  name="workTimeItem.proteam.proteamid">
							<option value="${workTimeItem.proteam.proteamid }">${workTimeItem.proteam.proteamname }</option>
						    <c:forEach var="proteam" items="${proteams}">
						       <option value="${proteam.proteamid }" <c:if test="${proteamId==proteam.proteamid }">selected="selected"</c:if>>${proteam.proteamname }</option>
						    </c:forEach>
					    </select>
			   		</td>
				</tr>
				<tr>
					<td>项目分值：</td><td><input type="text" id="itemScore" name="workTimeItem.itemScore" value="${workTimeItem.itemScore }" onBlur="this.value=parseInt(this.value);if (isNaN(this.value) || this.value<=0){alert('请输入数字');this.focus();};"/>&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td>项目名称：</td><td><textarea style="width:200px;height:100px;word-wrap: break-word;word-break: break-all;" id="itemName"  name="workTimeItem.itemName">${workTimeItem.itemName }</textarea>&nbsp;<font color="red">*</font></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="修 改"/>&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr> 
			</table>
		</div>
	</form>		
</body>
</html>