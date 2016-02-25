<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<Script type="text/javascript" src="js/jquery.form.js"></Script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--文本截取start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--文本截取end-->
<script type="text/javascript">
	function getItems(){
	  	var jcType = $('#jcType').val();
	 	var jcStype = $('#jcStype').val();
	  	var userId=$("input[name='user']").filter("[checked=true]").val();
	  	var teamId=$("input[name='team']").filter("[checked=true]").val();
	  	if(userId =='' || userId==undefined || userId==null){
		  	top.Dialog.alert("请选择技术质检!");
	 	}else if(jcType == "0"){
	  	 	top.Dialog.alert("请选择机车类别!");
	  	}else if(jcStype == "0"){
	  		top.Dialog.alert("请选择机车类型!");
	 	}else{
	  		$('#itemmsg').attr("src","presetDivisionAction!getTeamItems.do?userid="+userId+"&teamId="+teamId+"&tmp="+new Date().getTime()+"&jcType="+jcType+"&jcStype="+jcStype);
	  	}
	}
  
  function saveCharge(){
	  var teamId=$("input[name='team']").filter("[checked=true]").val();
	  var userId=$("input[name='user']").filter("[checked=true]").val();
	  var status=$("#jcType").val();
	  var opt=$("#jcStype").val();
	  var items=top.frmright.itemmsg.document.getElementsByName("items");
	  var itemIdsArray=[];
	  //$("input[name='items']:checked").each(function(){
		 // alert($(this)[0].id);
	  //});
	  for(var i=0;i<items.length;i++){
		  if(items[i].checked==true){
			  itemIdsArray.push(items[i].id);
		  }
	  }
	  if(teamId==''||teamId==undefined||teamId==null){
		 top.Dialog.alert("请选择班组!");
	  }else if(itemIdsArray.length==0){
		 top.Dialog.alert("请选择项目!");
	  }else if(opt==''||opt==undefined||opt==null||opt==0){
		 top.Dialog.alert("请选择机车类型!");
	  }else{
		 var iteamIds=itemIdsArray.join("-");
		 $.post("<%=basePath%>presetDivisionAction!saveCharge.do",{"teamId":teamId,"userId":userId,"iteamIds":iteamIds,"status":status},function(data){
			 if(data=="success"){
				 top.Dialog.alert("保存成功!",function(){
					 window.location.reload();
				 });
			 }else if(data=="no_authority"){
				 top.Dialog.alert("没有权限!");
			 }else{
				 top.Dialog.alert("保存失败!");
			 }
		 });
	  }
  }
  
  function deleteCharge(){
	  var teamId=$("input[name='team']").filter("[checked=true]").val();
	  var userId=$("input[name='user']").filter("[checked=true]").val();
	  if(teamId==''||teamId==undefined||teamId==null || userId==''||userId==undefined||userId==null){
		  top.Dialog.alert("请选择班组!");
	  }else{
		   top.Dialog.confirm("确定要删除吗?",function(){
			  $.post("<%=basePath%>presetDivisionAction!deleteCharge.do",{"teamId":teamId,"userid":userId},function(data){
		 		 if(data=="success"){
					 top.Dialog.alert("删除成功!",function(){
						 window.location.reload();
					 });
				 }else if(data=="no_authority"){
					 top.Dialog.alert("没有权限!");
				 }else if(data=="no_result"){
					 top.Dialog.alert("没有分配!");
				 }else{
					 top.Dialog.alert("删除失败!");
				 }
	 		  });
		   });
	  }
  }
  
function addOption(objSelectNow, txt, val) {  
    // / 使用W3C标准语法为SELECT添加Option  
    var objOption = document.createElement("OPTION");  
    objOption.text = txt;  
    objOption.value = val;  
    objSelectNow.options.add(objOption);  
}  
function selectJcStype(){
	var v=$('#jcType').val();
	var sel=$('#jcStype').get(0);
	while(sel.options.length>1){
		sel.options.remove(1);
	}
	var teamId=$("input[name='team']").filter("[checked=true]").val();
	if(teamId==''||teamId==undefined||teamId==null){
		  top.Dialog.alert("请选择班组!");
		  $('#jcType').val(0);
		  return;
	}
	$.post('<%=basePath%>report!getJcSType.do?typeId='+v,{},function(data){
		var list=eval("("+data+")");
		for(var i=0;i<list.length;i++){
			addOption(sel,list[i].jcStypeValue,list[i].jcStypeValue);
		}
	});
}

function getTeamItems(){
	var jcType = $('#jcType').val();
	var jcStype = $('#jcStype').val();
	var teamId=$("input[name='team']").filter("[checked=true]").val();
	var userId=$("input[name='user']").filter("[checked=true]").val();
	$('#itemmsg').attr("src","presetDivisionAction!getTeamItems.do?userid="+userId+"&teamId="+teamId+"&tmp="+new Date().getTime()+"&jcType="+jcType+"&jcStype="+jcStype);
}

function selectCharegeBz(userid){
	$.post("<%=basePath%>presetDivisionAction!ajaxGetCharge.do",{"userid":userid},
		function(data){
	        var result=eval("("+data+")");
	        var datas=result.datas;
	        var str="";
	        if(datas.length>0){
	            for(var i=0;i<datas.length;i++){
	                str+="<tr><td>"+datas[i].proTeamName+"</td></tr>";
	            }
	        }else{
	            str+="<tr><td>没有数据记录!</td></tr>";
	        }
	        $("#userMsgCharge").html(str);
	    }
	);
	
	var jcType = $('#jcType').val();
	var jcStype = $('#jcStype').val();
	var teamId=$("input[name='team']").filter("[checked=true]").val();
	if(jcType != "0" && jcStype != "0" && teamId!='' && teamId!=undefined && teamId!=null){
		$('#itemmsg').attr("src","presetDivisionAction!getTeamItems.do?userid="+userid+"&teamId="+teamId+"&tmp="+new Date().getTime()+"&jcType="+jcType+"&jcStype="+jcStype);
	}else {
		return ;
	}
	
}
  
</script>
<body>
<div >
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
		<tr>
			<td  width="25%" class="ver01">
	    	  <div class="box2" panelHeight="230" panelTitle="质检技术列表"   panelUrl="javascript:openWin()"  showStatus="false" overflow="auto">
		    	  <div id="showImage" style="width: 93%;">
		    	    <table width="100%" class="tableStyle" id="userMsg">
						<tr>
						    <th  class="ver01" width="10%">选择</th>
							<th class="ver01">质检技术</th>
						</tr>
						<c:forEach var="user" items="${usersPrivsList}">
						  <tr onclick="selectCharegeBz(${user.userid});">
						    <td><input type="radio" value="${user.userid}" name="user"/></td>
							<td class="ver01">${user.xm }</td>
						  </tr>
						</c:forEach>
					</table>
		    	  </div>
	    		</div>
			</td>
			<td  width="20%" class="ver01">
		    	<div class="box2" panelHeight="230"  panelTitle="已选负责班组"   panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto">
		    		<div id="showImage" style="width: 92%;" id="userMsgCharge">
			    	    <table width="100%" class="tableStyle" id="userMsgCharge" border="0px;">
						</table>
					</div>
		    	</div>
			</td>
		<td rowspan="2">
		  	<div class="box2" panelHeight="459"  panelTitle="专业班组项目"   panelUrl="javascript:openWin()" roller="true" showStatus="false">
			  	<button onclick="saveCharge();"style="margin-left: 5px"><span class="icon_save">保存</span></button>
			   	<button onclick="deleteCharge();" style="margin-left: 5px"><span class="icon_delete">删除</span></button>
			  	<div style="margin-top: 5px;">  
			  	 
				&nbsp;&nbsp;机车类别：
			  	<select onchange="selectJcStype()" id="jcType" name="jcType" class="default">
					<option value=0>请选择机车类别</option>
					<option value=1>电力机车</option>
					<option value=2>内燃机车</option>
					<option value=3>和谐机车</option>
				</select>
				机车类型：
				<select  id="jcStype" name="jcStype" class="default" onchange="getTeamItems();">
				  <option value=0>请选择机车类型</option>
				</select>
			  	 </div>
			  	  <IFRAME style="margin-top: 5px;" scrolling="auto" width="100%" height="300px"  frameBorder=0 id=itemmsg name=itemmsg src=""  allowTransparency="true"></IFRAME>
		    	</div>
	    	</div>
		</td>
		</tr>
	  <tr>
		<td  width="30%" class="ver01" colspan="2">
	    	  <div class="box2" panelHeight="220"  panelTitle="待选班组"   panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto">
		    	  <div id="showImage" style="width: 98%">
		    	    <table width="100%" class="tableStyle" id="userMsg">
						<tr>
						    <th  class="ver01" width="10%">选择</th>
							<th class="ver01">专业班组</th>
						</tr>
						<c:forEach var="team" items="${proTeams}">
						  <tr onclick="getItems();">
						    <td><input type="radio" value="${team.proteamid}" name="team"/></td>
							<td class="ver01">${team.proteamname}</td>
						  </tr>
						</c:forEach>
					</table>
		    	  </div>
	    	</div>
		</td>
	  </tr>
	</table>
</div>				
</body>
</html>