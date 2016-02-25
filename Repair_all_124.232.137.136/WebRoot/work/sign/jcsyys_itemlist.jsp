<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左侧菜单</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<script type="text/javascript" src="js/table/treeTable.js"></script>
<script type="text/javascript" src="js/attention/messager.js"></script>
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
//报活
$(document).ready(function(){
	$('#newreport').bind('click', function(){
		var planid = $('#dateplan').val();
		var jctype = $('#jctype').val();
		var diag = new top.Dialog();
		diag.Title = "报活操作窗口";
		diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+planid+'&type='+jctype;
		diag.Width=1000;
		diag.Height=520;
		diag.show();
	});
    
})

</script>
<style type="text/css">
*html{
 background-image:url(about:blank);
 background-attachment:fixed;
 }
 
#sign{
  position:fixed;
  margin-top:5px;
  margin-left:5px;
  top:0px;
  
 _position:absolute;
 _bottom:auto;
 _top:expression(eval(document.documentElement.scrollTop));
 _margin-top:5px;
 _margin-left:5px;
 }
 
#newreport{
position:fixed;
margin-top:5px;
margin-left:70px;
top:0px;

_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:70px;
}
</style>
</head>
<body>
<button id="sign" onclick="ratify();" ><span class="icon_save">签名</span></button>
<button id="newreport" ><span class="icon_print">报活</span></button>
<form id="subForm" action="workAction!" method="post">
<input id="dateplan"  name="rjhmId" type="hidden" value="${rjhmId }"/>
<table class="treeTable" style="text-align: center;margin-top: 30px;" initState="collapsed" id="jcItemTab">
	<tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">交车项目</td></tr>
	<tr>
		<th width="20px">选择</th>
		<th width="10%">分类</th>
		<th width="10%">检修项目</th>
		<th width="20%">检修情况(检测值)</th>
		<th width="20%">检修人</th>
		<th width="18%">质检技术</th>
		<th width="20%">验收员</th>
	</tr>
	<!--交车项目 -->
    <c:forEach var="itemListMap" items="${itemListMap}" varStatus="s">
	    <tr id="node-${s.index+1 }">
			<td style="width: 5%;">&nbsp;<input type="checkbox" onclick="selectChildren(${s.index+1});" id="p_${s.index+1}"/></td>
			<td colspan="7" align="left"><span class="folder">${itemListMap.key }</span></td>
		</tr>
		<c:forEach var="rec" items="${itemListMap.value}">
			<tr class="child-of-node-${s.index+1}">
			    <td>
					<input type="checkbox" value="${rec.recId}" class="ch_${s.index+1}" name="jcsy_item" id="jcsy_item"/>
				</td> 
				<td>${rec.classify}</td>
				<td>${rec.itemName}</td>
				<td>${rec.fixSituation}&nbsp;${rec.unit}</td>
				<td>
					<c:choose>
						<c:when test="${empty rec.fixemp}">
							<font color="#ff0000">未签认</font>
						</c:when>
						<c:otherwise>
							${rec.fixemp}&nbsp;${rec.fixEmpTime}
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty rec.tech}">
							<font color="#ff0000">未签认</font>
						</c:when>
						<c:otherwise>
							${rec.tech}&nbsp;${rec.techAffiTime}
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty rec.accept}">
							<font color="#ff0000">待签</font>
						</c:when>
						<c:otherwise>
							${rec.accept}&nbsp;${rec.acceptAffiTime}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
    </c:forEach>
</table>
</form>
</body>
<script type="text/javascript">
	//部位全选
	function selectChildren(id){
		if($("#p_"+id).attr("checked")){
		  $(".ch_"+id).each(function(){
		    $(this).attr("checked",true);
		  });
		}else{
		   $(".ch_"+id).each(function(){
		    $(this).attr("checked",false);
		  });
		}
	}
	
	//签名
	function ratify(){
		//参数列
		var rjhmId = ${rjhmId};
		//判断工人是否签认完全
		$.post("workAction!isFinishWorker.action",{"rjhmId":rjhmId},
			function(result){
				if("failure" == result){
					return false;
				}
		})
		//判断是否有一个项目被选中
		var flagSelect = false;
		//判断是否正确值
		var flagRatify = true;
		var length = 0;
		var itemString = "{";
		//遍历所有name为jcsy_item的选项
		$("input[name='jcsy_item']").each(function(){
			//判断是否选中
			if ($(this).attr("checked")) { 
				//只要有一个被选择 设置为 true
				flagSelect = true; 
				length += 1;
			}
		})
		if(flagSelect){
			var i = 1;
			$("input[name='jcsy_item']:checked").each(function(){
				var idValue = $(this).val();
			    var itemValue = "0";
	    		//将选中的值添加到json字符串中
	    		if(i<length){
	    			itemString += "\""+ idValue +"\":";
	    			itemString += "\""+ itemValue +"\"";
	    			itemString += ",";
	    			i += 1;
	    		}else{
	    			itemString += "\""+ idValue +"\":";
	    			itemString += "\""+ itemValue +"\"";
	    		}
			})
			itemString += "}";
			if(flagRatify){
				$.ajax({
					type:'post',
					url:'workAction!finishItemSign.action',
					data:{"rjhmId":rjhmId,"itemString":itemString},
					success:function(result){
						if("success"==result){
							$.messager.show(0,'签认成功!');
						}else{
							$.messager.show(0,'签认失败 !');
						}
						$("input[name='jcsy_item']:checked").each(function(){
				        	$(this).attr("checked",false);
				        })
				        setTimeout(function(){
				            window.frames.location.reload();
				        },1000);
					}
				}); 
			}
		}else{
			top.Dialog.alert("请选择要签认的项目！");
		}
	}
</script>
</html>