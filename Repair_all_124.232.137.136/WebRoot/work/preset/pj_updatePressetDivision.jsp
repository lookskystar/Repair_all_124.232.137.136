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
    function addPresetDivision(){
    	var pjsId=$("#pjsId").val();
    	var presetId=$("#presetId").val();
    	var presetName=$("#presetName").val();
    	if(presetName=="" || presetName==undefined){
    		top.Dialog.alert("请填写预设大类名称!");
			return ;
    	}else{
	    	$.post("presetDivisionAction!updatePJPresetDivision.do",{"presetId":presetId,"pjsId":pjsId,"presetName":presetName},function(data){
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
    }
    
</script>
</head>

<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="290px;" valign="top" align="center">
		    <input type="hidden" value="${pjDivision.presetId}" id="presetId"/>
		    <input type="hidden" value="${pjDivision.pjsId.pjsid}" id="pjsId"/>
			所选配件名称:${pjDivision.pjsId.pjName}
			<p>分类名称:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="width: 200px;" id="presetName" value="${pjDivision.presetName}"/></p>
			<p><input type="button" value="修改预设大类" onclick="addPresetDivision();"/></p>
		</td>
	</tr>
</table>
</body>
</html>