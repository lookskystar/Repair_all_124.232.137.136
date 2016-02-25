<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<script type="text/javascript">
    function updatePresetDivision(){
    	var clsName=$("#clsName").val();
    	
    	if(clsName=="" || clsName==undefined){
    		top.Dialog.alert("请填写预设大类名称!");
			return ;
    	}
    	
    	var workers= "";//工人
    	var workerNames = "";
		$("#checkGroup input[type=checkbox]").each(function(){
			if($(this).attr("checked")){
				workers=$(this).val()+","+workers;
				workerNames=$(this).attr("alt")+","+workerNames;
			}
		});
//		if(workers=="" || workers==undefined){
//			top.Dialog.alert("请选择班组人员!");
//			return ;
//		}
    	$.post("presetDivisionAction!updatePresetDivision.do",{"clsName":clsName,"workers":workers,"presetId":${division.proSetId},"workerNames":workerNames},function(data){
    		if(data=="success"){
    			top.Dialog.alert("信息修改成功!",function(){
					top.frmright.window.location.reload();
					top.Dialog.close();
				});
    		}else{
    			top.Dialog.alert("信息修改失败!",function(){
					top.frmright.window.location.reload();
					top.Dialog.close();
				});
    		}
    	});
    }
    
	function selectSign(id){
		var flag = !$("#"+id).attr("checked");
		$("#"+id).attr("checked",flag);
	}
	
	$(function(){
		var workerIds = "${division.fixEmpIds}";
		var ids = workerIds.split(",");
		for(var i=0;i<ids.length;i++){
			if(ids[i]!=''){
				$("#usr_"+ids[i]).attr("checked",true);
			}
		}
	});
</script>
</head>

<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="290px;" valign="top" align="center">
			<p>分类名称:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="width: 200px;" id="clsName" value="${division.clsName }"/></p>
			<p>机车型号:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="width: 200px;" id="jcValue" value="${division.jcValue }" disabled="disabled"/></p>
			<p><input type="button" value="修改预设大类" onclick="updatePresetDivision();"/></p>
		</td>
		<td align="left" valign="top">
			<div style="height: 440px;overflow: auto;">
			<table class="tableStyle" id="checkGroup" useCheckBox="false">
				<tr><td colspan="3">班组成员</td></tr>
				<tr align="center"><th width="10"></th><th width="45%">姓名</th><th>工号</th></tr>
				<c:if test="${empty users}"><tr align="center"><td colspan="3">没有数据记录!</td></tr></c:if>
				<c:forEach var="user" items="${users}">
					<tr align="center">
						<td><input type="checkbox" value="${user.userid}" id="usr_${user.userid}" name="workList" alt="${user.xm}"/></td>
						<td  onclick="selectSign('usr_${user.userid}');">${user.xm }</td><td  onclick="selectSign('usr_${user.userid}');">${user.gonghao}</td>
					</tr>
				</c:forEach>
			</table>
			</div>
	  	</td>
	</tr>
</table>
</body>
</html>