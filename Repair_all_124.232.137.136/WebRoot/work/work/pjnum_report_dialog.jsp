<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<!-- 2015-5-22,黄亮，添加，新页面：pjnum_report_dialog.jsp。目的：报活项目中，处理情况列，如果是“更换良好”，下面便会出现“更换配件编码”连接，点击，进入该页面，选择配件 -->
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

request.setAttribute("recId",request.getParameter("recId"));
request.setAttribute("type",request.getParameter("type"));//检查项目和检测项目
request.setAttribute("planId",request.getParameter("planId"));
request.setAttribute("xtype",request.getParameter("xtype"));//修程
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 报活过程，更换配件编码连接页面 -->
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
       var flag = true;
	   var pjNums=[];
	   var recId=${recId};
	   var xtype=${xtype};
	   var planId = ${planId};//日计划id
	   var predictId=${recId};//报活主键id
	   
	   var removeTime = $("#removeTime").val();
	   //var pjNumsOld=$("#pjNumsOld").val();
	   
	   var len=$("input[name=pjNum]").length;
	   $("input[name=pjNum]").each(function(){
		   $(this).css({border:"0px"});
		   var value=$(this).val();
		   if(value!=""){
			    pjNums.push(value); 
		   }
	   });
	   
	   if(pjNums.length!=len){
		   top.Dialog.alert("编号不能为空!");
	   }else{
	   	   for(var i = 0; i < pjNums.length-1; i++ ){
	   	       for(var j = 0; j < pjNums.length-i-1; j++){
	   	       	   if(pjNums[j] == pjNums[j+1]){
	   	       	       top.Dialog.alert("所填编号不能相同 !");
	   	       	       $("input[value='"+ pjNums[j+1] +"']").css({border:"1px solid red"});
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
	   	   //2015-5-21，黄亮，改，解决添加配件选项，后移除，在提交出现：存在找不到的配件编号，问题
	   	   //for(var i = 0; i<= removeTime-1; i++ ) {
	   	       //pjNums.push("cannot");
	   	   //}
	   	   
	   	   if(flag){
	   	   	   //pjNum是所有选择配件编号的字符串形式，以，号隔开
	   	       //var pjNum=pjNums.join(",");
	   	       //2015-5-21，黄亮，改，传入pjNum字符串形式和predictId报活记录id
	   	       $.post("<%=basePath%>workAction!updatePJDynamicInfosByPjNumAndJtPreDict.do?pjNums="+pjNums,{"planId":planId,"predictId":predictId},function(data){
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
					   //2015-5-21，黄亮，添加，如果type==2，则刷新frames[2]页面（frames[0]：主页面，frames[1]：左页面，frames[2]：右边页面）
					   }else if(${type}==2){
					   		top.frmright.frames[2].location.reload();
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
   //type=reportPJ:进入报活配件选择页面
  function choicePart(obj){
		var diag = new top.Dialog();
		diag.Title = "选择配件";
		diag.Width = 700;
		diag.URL = '<%=basePath%>workAction!choiceDyPjInfo.do?stdPjId=${stdPjId}&planId=${planId}&psize=20&type=reportPJ';
		diag.ShowButtonRow = true;
		diag.OkButtonText = "确 定";
		diag.OKEvent = function() {
			var flag = true;
			var doc = diag.innerFrame.contentWindow.document;
			var pj = doc.getElementsByName("pjIds");
			//2015-5-25，黄亮，改
			//pjNum:pjNum的结合体，表现形式为：pjNum
			var pjNum = "";
			var pjNumArry;
			for(var i=0;i<pj.length;i++){
				if(pj[i].checked ){
					if(i != pj.length-1){
						pjNum += pj[i].value + ",";
						//pjNum += pj[i].id+":"+pj[i].value + ","; //pj[i].id为pjdid，pj[i].value为pjNum，两者不是同一字段
						//pjNum += ${recId}+":"+pj[i].value + ",";  //recId为PREDICTID
						
					}else{
						pjNum += pj[i].value;
						//pjNum += pj[i].id+":"+pj[i].value;
						//pjNum += ${recId}+":"+pj[i].value;
					}
				}
			}
			
			pjNumArry = pjNum.split(",");
			if (pjNum == null || pjNum.length == 0) {
				top.Dialog.alert("请选择配件信息!");
			}else{
				for(var i=0;i<pjNumArry.length;i++){
					$("input[name='pjNum'][value:empty]").each(function(){
						var thisValue = $(this).val();
						if(thisValue == null || thisValue == "" ){
						  	$(this).val(pjNumArry[i]);
						  	return false;
						}
					})
				}
				//$(obj).parent().children("input[type='text']").val(pjNum);
				diag.close();
			}
		};
		diag.show();
   }
   
</script>
</head>
<body>
<form action="" method="post" id="form">
<input type="hidden" id="removeTime" value="0" />

<!--<input type="hidden" id="pjNumsOld" value=""/>-->

<table class="tableStyle">
	<c:choose>
		<c:when	test="${empty amount}">
			<tr>
				<td align="right">配件编号：</td>
				<td>
				  <input type="text" name="pjNum" id="pjNum"style="width:150px;" readonly="readonly"/>&nbsp;&nbsp;
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
					  	<input type="text" name="pjNum" id="pjNum-${s.index}" style="width:150px;" readonly="readonly"/>&nbsp;&nbsp;
					  	<c:if test="${s.index == 0}">
					  		<input type="button" value="选择" onclick="choicePart(this);"/>&nbsp;&nbsp;
					  		<input type="button" value="添加" id="add"/>
					  	</c:if>
					  	<input type='button' value='移除' onclick='delText(this);'/> 
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
	    var obj=$("<tr> "
	   			 +"<td align='right'>配件编号：</td> "
	   			 +"<td> "
	   			 +"<input type='text' name='pjNum' id='pjNum-${s.index}' style='width:150px;' readonly='readonly'/>&nbsp;&nbsp; "
	   			 +"<input type='button' value='移除' onclick='delText(this);'/> "
	   			 +"</td> "
	   			 +"</tr>");
	    $("table").append(obj);
    });
     
     function delText(obj){
    	var removeTime = $("#removeTime").val();
    	$("#removeTime").val(parseInt(removeTime) + 1 );
   	    $(obj).parent().parent().remove();
    }
</script>
</html>