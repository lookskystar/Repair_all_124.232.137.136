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

		$(function(){
			$("#all").click(function(){
				if($(this).attr("checked")){
					$("input[name='proteam']").each(function(){
						$(this).attr("checked",true);
					});
				}else{
					$("input[name='proteam']").each(function(){
						$(this).attr("checked",false);
					});
				}
			});
		});
	</script>
</head>
<body>
	<fieldset>
		<table class="tableStyle" id="checkGroup" useCheckBox="false">
				<tr>
					<td colspan="4">
						<input type="checkbox" id="all"/>全选
					</td>
				</tr>
			<c:if test="${!empty proteams}">
				
				<tr>
					<c:forEach items="${proteams}" var="proteams" varStatus="s">
						<td>
							<input id="${proteams.proteamid }" name="proteam" type="checkbox" width="30px" value="${proteams.proteamname}"/>${proteams.proteamname }
						</td>
						<c:if test="${s.index>0 && (s.index+1)%4==0 }">
							</tr><tr>
						</c:if>
					</c:forEach>	
				</tr>
				
			</c:if>	
			<div class="clear"></div>
		</table>
		<input type="hidden" id="bzs"/>
	</fieldset>
</body>
</html>