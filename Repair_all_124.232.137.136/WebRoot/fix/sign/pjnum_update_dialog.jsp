<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

request.setAttribute("recId",request.getParameter("recId"));
request.setAttribute("type",request.getParameter("type"));
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
	$(document).ready(function(){
		var pjNumsOld=[];
		$("input[name=pjNum]").each(function(){
		   var value=$(this).val();
		   if(value!=""){
			    pjNumsOld.push(value);
		   }
	   });
	   $("#pjNumsOld").val(pjNumsOld);
	})
	
   function submitFormNew(){
   	   var pjNumsOld = $("#pjNumsOld").val();
	   var pjNums=[];
	   var pjRecId=${pjRecId};
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
	   	       	   if(pjNums[j] == pjNums[j+1]){
	   	       	       top.Dialog.alert("所填编号不能相同 !");
	   	       	       flag = false;
	   	       	       break;
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
			   $.post("<%=basePath%>partFixAction!pjNumUpdate.do",{"pjRecId":pjRecId,"pjNum":pjNum,"pjNumsOld":pjNumsOld},function(data){
			   	   if(data == "success"){
			   	   	   top.Dialog.alert("操作成功!",function(){
			   	   			//window.location.reload();
			   	   			top.Dialog.close();
			   	   	   	    //window.parent.dialogArguments.document.execCommand('Refresh');
			   	   	  
			   	   	   });
			   	   	   
			   	   }else if(data.indexOf("noexist") >=0 ){
			   	       var array=data.split("-");
			   	       top.Dialog.alert("存在找不到的配件编号!");
			   	       $("input[name=pjNum]").each(function(i){
						    if(i==array[1]){
						    	$(this).css({border:"1px solid red"});
						    }
		   			   });
			   	   }
			   });
	   	   }
	   }
	  //window.history.go(-2);
	 
	//top.Dialog.close();
	//
	// window.close();
	  //window.opener.document.location.reload();
   }

  function choicePart(obj){
  	alert(1111111111111111);
  	alert(${stdPjId});
		var diag = new top.Dialog();
		diag.Title = "选择配件";
		diag.Width = 700;
		diag.URL = '<%=basePath%>partFixAction!choiceDyPjInfo.do?stdPjId=${stdPjId}&type=update';
		//diag.URL = '<%=basePath%>workAction!choiceDyPjInfo.do?stdPjId=${stdPjId}&type=update';
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
   
</script>
</head>
<body>
<form action="" method="post" id="form">
<input type="hidden" id="pjNumsOld" value=""/>
<table class="tableStyle">
	<tr><td align="left" colspan="2">检修项目：${fixItem }需添加配件数量  <font color="red">${amount }</font></td></tr>
	<%-- 
	<tr>
		<td align="right">配件编号：</td>
		<td>
		  <input type="text" name="pjNum" id="pjNum" style="width:150px;"/>&nbsp;&nbsp;
		  <input type="button" value="选择" onclick="choicePart(this);"/>&nbsp;&nbsp;
		  <input type="button" value="添加" id="add"/>
		</td>
	</tr>
	 --%>
	<c:choose>
		<c:when	test="${empty amount}">
			<tr>
				<td align="right">配件编号：</td>
				<td>
				  <input type="text" name="pjNum" id="pjNum" style="width:150px;"/>&nbsp;&nbsp;
				  <input type="button" value="选择" onclick="choicePart(this);"/>&nbsp;&nbsp;
				  <input type="button" value="添加" id="add"/>
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach begin="0" end="${fn:length(pJNumArray)-1}" step="1" varStatus="s">
			<%--<c:forEach begin="0" end="${amount-1}" step="1" varStatus="s">--%>
				<tr>
					<!--<td align="right">${s.index+1}</td>-->
					<td align="right">配件编号：</td>
					<td>
					  	<input type="text" name="pjNum" id="pjNum" value="${pJNumArray[s.index] }" style="width:150px;"/>&nbsp;&nbsp;
					  	<input type="button" value="选择" onclick="choicePart(this);"/>&nbsp;&nbsp;
					  	<input type='button' name='del' value='删除' onclick='delText(this)'/>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table><%--
   <center>
		<input type="button" value=" 提 交 " onclick="submitFormNew();"/>
		<input type="reset" value=" 重 置 "/>
  </center>
--%></form>
<script type="text/javascript">
     $("#add").click(function(){
	   var obj=$("<tr><td align='right'>配件编号：</td><td><input type='text' name='pjNum' style='width:150px;'/>&nbsp;&nbsp;<input type='button' name='choice' value='选择' onclick='choicePart(this);'/>&nbsp;&nbsp;<input type='button' name='del' value='删除' onclick='delText(this)'/></td></tr>");
	   $("table").append(obj);
     });
     
     function delText(obj){
    	 $(obj).parent().parent().remove();
     }
</script>
</body>
</html>