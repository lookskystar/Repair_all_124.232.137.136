<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

request.setAttribute("recId",request.getParameter("recId"));
request.setAttribute("type",request.getParameter("type"));
request.setAttribute("planId",request.getParameter("planId"));
request.setAttribute("xtype",request.getParameter("xtype"));
String pjNumsOld = request.getParameter("upPJNum");
if(pjNumsOld!=null && !"".equals(pjNumsOld)){
	request.setAttribute("pjNumsOld",pjNumsOld);
	request.setAttribute("amount",pjNumsOld.split(",").length);
	request.setAttribute("upPjNumArray",pjNumsOld.split(","));
}
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
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<script type="text/javascript" src="js/timer2.src.js"></script> 
<script type="text/javascript">
	
   function submitFormNew(){
   	   var pjNumsOld = $("#pjNumsOld").val();
	   var pjNums=[];
	   var recId=${recId};
	   var xtype=${xtype};
	   var planId = ${planId};
	   var flag = true;
	   var len=$("input[name=pjNum]").length;
	   $("input[name=pjNum]").each(function(){
		   $(this).css({border:"0px"});
		   var value=$(this).val();
		   if(value!=""){
			    pjNums.push(value);;
		   }
	   });
	   
	   if(pjNums.length!=len){
		   top.Dialog.alert("编号不能为空!");
	   }else{
	   	   for(var i = 0; i < pjNums.length-1; i++ ){
	   	       for(var j = 0; j < pjNums.length-i-1; j++){
	   	       	   if(pjNums[j] != '未启用' && pjNums[j+1] != '未启用'){
		   	       	   if(pjNums[j] == pjNums[j+1]){
		   	       	       top.Dialog.alert("所填编号不能相同 !");
		   	       	       flag = false;
		   	       	       break;
		   	       	   }
	   	       	   }
	   	       }
	   	       if(flag){
	   	           continue;
	   	       }else{
	   	           break;
	   	       }
	   	   }
	   	   if(flag){
	   	        var pjNum=pjNums.join(",");
			   $.post("<%=basePath%>workAction!saveXXPjNum.do",{"recId":recId,"pjNum":pjNum,"pjNumsOld":pjNumsOld,"xtype":xtype,"planId":planId},function(data){
				   var array=data.split("-");
				   if(array[0]=="noexist"){
					   top.Dialog.alert("存在找不到的配件编号!");
					   $("input[name=pjNum]").each(function(i){
						    if(i==array[1]){
						    	$(this).css({border:"1px solid red"});
						    }
		   				});
				   }else{
					   if(${type}==1){
						    top.frmright.frames[1].location.reload();
					   		top.Dialog.close();
					   }else{
						    top.frmright.frames[0].location.reload();
					   		top.Dialog.close();
					   }
				   }
			   });
	   	   }
	   }
   }
   
  function choicePart(obj){
		var diag = new top.Dialog();
		diag.Title = "选择配件";
		diag.Width = 700;
		diag.URL = '<%=basePath%>workAction!choiceDyPjInfo.do?planId=${planId}&type=update';
		diag.ShowButtonRow = true;
		diag.OkButtonText = "确 定";
		diag.OKEvent = function() {
			var flag = true;
			var doc = diag.innerFrame.contentWindow.document;
			var pj = doc.getElementsByName("pjIds");
			var pjNum;
			for(var i=0;i<pj.length;i++){
				if(pj[i].checked){
					pjNum = pj[i].value;
				}
			}
			if (pjNum == null || pjNum.length == 0) {
				top.Dialog.alert("请选择配件信息!");
			}else{
				$(obj).parent().children("input[type='text']").val(pjNum);
				diag.close();
			}
		};
		diag.show();
   }
   
   function showPJFixRec(pjnum){
   		window.open("<%=basePath%>query!findPjRecordByPjNum.do?rjhmId=${planId}&pjNum="+pjnum,'_blank') 
   }
</script>
</head>
<body>
<form action="" method="post" id="form">
<input type="hidden" id="pjNumsOld" value="${pjNumsOld}"/>
<table class="tableStyle">
	<c:choose>
		<c:when	test="${empty amount}">
			<tr>
				<td align="right">配件编号：</td>
				<td>
				  <input type="text" name="pjNum" id="pjNum" style="width:150px;" readonly="readonly"/>&nbsp;&nbsp;
				  <input type="button" value="选择" onclick="choicePart(this);"/>&nbsp;&nbsp;
				  <input type="button" value="添加" id="add"/>
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach begin="0" end="${amount-1}" step="1" varStatus="s">
				<tr>
					<td align="right">${s.index+1}</td>
					<td align="right">配件编号：</td>
					<td>
					  	<input type="text" name="pjNum" id="pjNum" value="${upPjNumArray[s.index] }" style="width:150px;" readonly="readonly"/>&nbsp;&nbsp;
					  	<input type="button" value="选择" onclick="choicePart(this);"/>&nbsp;&nbsp;
					  	<input type="button" value="检修记录" onclick="showPJFixRec('${upPjNumArray[s.index] }')"/>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
   <center>
		<input type="button" value=" 提 交 " onclick="submitFormNew();"/>
		<input type="reset" value=" 重 置 "/>
  </center>
</form>
</body>
<script type="text/javascript">
     $("#add").click(function(){
	   var obj=$("<tr><td align='right'>配件编号：</td><td><input type='text' name='pjNum' style='width:150px;' readonly='readonly'/>&nbsp;&nbsp;<input type='button' name='choice' value='选择' onclick='choicePart(this);'/>&nbsp;&nbsp;<input type='button' name='del' value='删除' onclick='delText(this)'/></td></tr>");
	   $("table").append(obj);
     });
     
     function delText(obj){
    	 $(obj).parent().parent().remove();
     }
</script>
</html>