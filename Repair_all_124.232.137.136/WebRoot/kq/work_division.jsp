<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"  prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="experiment/js/jquery.messager.js"></script>
	
	<script type="text/javascript"> 
	$(function(){
	   	top.Dialog.close();
	 		<c:if test="${!empty message}">
			top.Dialog.alert('${message}');
		</c:if>
	});

	//保存派工
	function saveCharge(){
		//获取时间
		var shiJian = $("#shiJian").val();
		//获取班组任务
		var itemId = $("input[name='item']").filter("[checked=true]").val();
		if(shiJian == "" || shiJian == undefined){
			top.Dialog.alert("请先选择派工日期！");
		}
		if(itemId == "" || itemId == undefined){
			top.Dialog.alert("请先选择班组项目！");
		}else{
			//获取勾选的班组成员
			var userStr = "";
			$("input[name='user']:checkbox").each(function(){ 
				if($(this).attr("checked")){
			    userStr += $(this).val()+","
			}
			})
			$.ajax({
		   		type: "POST",
		    	url: "proteamEntryAction!saveProteamCharge.do",
		    	data: "itemId="+itemId+"&userStr="+userStr+"&shiJian="+shiJian,
		    	success: function(str){
		    		top.Dialog.alert(str);
		        }
			}); 
		}
	}

	function getUsers(itemId){
		$("input[name='user']:checkbox").each(function(){ 
			$(this).attr("checked", false);
		})
		
		var shiJian = $("#shiJian").val();
		$.ajax({
	   		type: "POST",
	    	url: "proteamEntryAction!checkCharge.do",
	    	data: "itemId="+itemId+"&shiJian="+shiJian,
	    	success: function(str){
	    		var userId = new Array();
	        	userId = str.split(",");
	        	for(var i=0;i<userId.length;i++){
		        	$("input[name='user']:checkbox").each(function(){ 
		    			if($(this).val() == userId[i]){
		    		       $(this).attr("checked", true);
		    			}
		    		})
		       	}
		       	if(userId[userId.length-1] == "c"){
			       	$("#btn").hide();
			       	$("#mes").show();
		       	}else{
		       		$("#btn").show();
		       		$("#mes").hide();
				}
	        }
		}); 
	}
</script>
</head>
<body>
<div >
	派工日期：<input type="text" id="shiJian" value="${today}" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))"/>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" >
		<tr>
		<td  width="55%" class="ver01" colspan="2">
	    	  <div class="box2" panelHeight="480"  panelTitle="班组任务" panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto">
		    	  <div id="showImage" style="width: 98%">
		    	    <table width="100%" class="tableStyle" id="userMsg">
						<tr>
						    <th class="ver01" width="6%" align="center">选择</th>
							<th class="ver01">班组任务</th>
							<th class="ver01" width="6%" align="center">工分</th>
						</tr>
						<c:forEach items="${items}" var="item">
						<tr>
						    <td align="center"><input type="radio" value="${item.id}" name="item" onclick="getUsers(${item.id});"/></td>
							<td class="ver01">${item.itemName}</td>
							<td class="ver01" align="center">${item.itemScore}</td>
						</tr>
						</c:forEach>
					</table>
		    	  </div>
	    	</div>
		</td>
		<td>
		  	<div class="box2" panelHeight="480"  panelTitle="班组成员"   panelUrl="javascript:openWin()" roller="true" showStatus="false" overflow="auto">
			  	<button onclick="saveCharge();"style="margin-left: 5px" id="btn"><span class="icon_save">派工</span></button>
			  	<span id="mes" style="color:red;display:none;">* 项目已有工人签认，无法重新派工！</span>
			  	<div style="margin-top: 5px;">  
					<table width="100%" class="tableStyle" id="userMsg" useCheckBox="false">
						<tr>
						    <th class="ver01" width="8%">选择</th>
							<th class="ver01">班组成员</th>
							<th class="ver01" width="8%">选择</th>
							<th class="ver01">班组成员</th>
							<th class="ver01" width="8%">选择</th>
							<th class="ver01">班组成员</th>
						</tr>
						<c:forEach items="${users}" var="user" varStatus="s">
						<c:if test="${(s.index+1)%3 == 1}">
							<tr>
						</c:if>
						    <td><input type="checkbox" value="${user.userid}" name="user"/></td>
							<td class="ver01">${user.xm}</td>
						<c:if test="${(s.index+1)%3 == 0}">
							</tr>
						</c:if>
						</c:forEach>
					</table>
			    </div>
			</div>
		</td>
		</tr>
	</table>
</div>				
</body>
<link href="<%=basePath %>js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=basePath %>js/My97DatePicker/WdatePicker.js"></script>
</html>
