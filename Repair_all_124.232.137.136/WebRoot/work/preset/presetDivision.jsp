<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>"/>
    <title>预设分工</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
	<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="part/js/part_plan.js"></script>
	<script type="text/javascript">
	   //控制复选框为单选
	   function selectThis(obj){
		   $("input[name='check']").each(function(){
			   $(this).attr("checked",false);
		   });
		   obj.checked=true;
		   var ysId=obj.id;
		   $("input[name='item']:checked").each(function(){
	            $(this).attr("checked",false);
		   });
           $.post("presetDivisionAction!getJCFixitemByYsId.do",{"ysId":ysId},function(data){
        	   var results=eval("("+data+")");
        	   var itemIds=results.itemIds;
        	   if(itemIds.length!=0){
        		   for(var i=0;i<itemIds.length;i++){
        			 $("input[name='item']").each(function(){
			            if($(this)[0].id==itemIds[i].itemId){
			            	$(this).attr("checked",true);
			            }
		   			});
        	      }
        	   }
           });		   
	   }
	   
	   //根据类型得到预设分工大类信息
	   function getpresetDivision(){
		   var jcType=$("#jcType").val();
		   var bzid = $("#bzid").val();
		   if(bzid!=null && ''!=bzid && jcType!=null && ''!=jcType){
		   		window.location.href="presetDivisionAction!presetDivisionInput.do?jcType="+jcType+"&bzid="+bzid+"&nodeId=${param.nodeId}";
		   }
	   }
	   
	   //保存预设分工信息和项目之间的关系
	   function savePresetItem(){
		   var presetId="";
		   var itemIds=[];
		   $("input[name='check']:checked").each(function(){
			   presetId=$(this)[0].id;
		   });
		   $("input[name='item']:checked").each(function(){
			 itemIds.push($(this)[0].id);
		   });
		   
		   if(presetId==""){
			  top.Dialog.alert("请选择预设分工大类!");
		   }else if(itemIds.length==0){
			   top.Dialog.alert("请选择项目!");
		   }else{
			   var ids=itemIds.join("-");
			   $.post("presetDivisionAction!updateJCFixitemYsId.do",{"presetId":presetId,"ids":ids},function(data){
				  if(data=="success"){
					  top.Dialog.alert("保存成功!");
					  window.location.reload();
				  }else{
					  top.Dialog.alert("保存失败");
				  }
			   });
		   }
	   }
	   
	   //修改预设大类
	   function updPreset(){
	   		var presetId="";
	   		var bzid = $("#bzid").val();
		      $("input[name='check']:checked").each(function(){
			     presetId=$(this)[0].id;
		   	  });
		      if(presetId==""){
		    	 top.Dialog.alert("请选择预设分类!");
		      }else{
		    	 top.Dialog.open({URL:"presetDivisionAction!updatePresetDivisionInput.do?presetId="+presetId+"&bzid="+bzid,Width:600,Height:450,Title:"修改预设分类"});
		      }
	   }
	   
	   //删除预设分类
	   function delPreset(){
		  var presetId="";
	      $("input[name='check']:checked").each(function(){
		     presetId=$(this)[0].id;
	   	  });
	      if(presetId==""){
	    	 top.Dialog.alert("请选择预设分类!");
	      }else{
	    	  $.post("presetDivisionAction!delPresetDivision.do",{"ysId":presetId},function(data){
	    		  if(data=="success"){
					  top.Dialog.alert("删除成功!");
					  window.location.reload();
				  }else{
					  top.Dialog.alert("保存失败");
				  }
	    	  });
	      }
	   }
	   var d;
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
	   function toAdd(){
	   		var val = $("#jcType").val();
	   		var bzid = $("#bzid").val();
	   		if(bzid!=null && ''!=bzid){
	   			top.Dialog.open({URL:"presetDivisionAction!savePresetDivisionInput.do?nodeId=${nodeId}&jctype="+val+"&bzid="+bzid,Width:600,Height:450,Title:"添加预设分类"});
	   		}
	   }
	</script>
	<style type="text/css">
		.testDiv{
			top:200px ;
			left:300px ;
			height:400px ;
			width:420px ;
			
			/*指定水平方面有滚动条，垂直状态没有 如果值为：auto，则当内容超过显示范围时才出现*/
			overFlow-x: hidden ;
			overFlow-y: auto ; 
			
			/*设置滚动条样式*/
			scrollBar-face-color: green; 
			scrollBar-hightLight-color: red; 
			scrollBar-3dLight-color: orange; 
			scrollBar-darkshadow-color:blue; 
			scrollBar-shadow-color:yellow; 
			scrollBar-arrow-color:purple; 
			scrollBar-track-color:black; 
		}
		
		.item_left{
			width: 40%;
			float: left;
		}
		
		.item_right{
			width: 57%;
			float: right;
		}
		.dTreeNode{width:480px;}
	</style>
  </head>
  
 <body>
 	<table width="100%" align="left">
 		<tr>
 			<td width="320px">
		 		<div class="box2"  panelTitle="预设分类管理" panelHeight="434" panelWidth="320" overflow="auto">
		 			<center>请选择预分类的班组名称:
		 			<select style="width: 100px" onchange="getpresetDivision();" id="bzid">
		 				<option value="">请选择班组</option>
		   	        	<c:forEach items="${dictProTeamList}" var="entry">
		    	           <option value="${entry.proteamid}" <c:if test="${proteamid==entry.proteamid}">selected="selected"</c:if>>${entry.proteamname}</option>
		    	        </c:forEach>
		    	    </select>
		    	    </center><br/>
		 		   <center>请选择预分类的机车类型:
		 		     <select style="width: 100px" onchange="getpresetDivision();" id="jcType">
		 		     	<c:forEach items="${dictJcTypeList}" var="type">
		 		     		<option value="${type.jcStypeValue}" <c:if test="${jcType==type.jcStypeValue}">selected="selected"</c:if>>${type.jcStypeValue}</option>
		 		     	</c:forEach>
		 		     </select>
		 		   </center><br/>
		 		   <button onclick='javascript:toAdd();'><span class="icon_add">新增</span></button>&nbsp;&nbsp;&nbsp;
		 		   <button  onclick="delPreset();"><span class="icon_delete">删除</span></button>&nbsp;&nbsp;&nbsp;
		 		   <button  onclick="updPreset();"><span class="icon_edit">修改</span></button>&nbsp;&nbsp;
		 		   <button onclick="savePresetItem();"><span class="icon_save">保存关系</span></button>
					<table class="tableStyle" useCheckBox="false" overflow="auto">
						<tr align="center">
							<td width="10px"></td>
							<td width="50%">分类名称</td>
							<td>检修人</td>
						</tr>
						<c:forEach var="preset" items="${presets}">
						 <tr>
							<td><input type="checkbox" name="check" onclick="selectThis(this);" id="${preset.proSetId}"/></td>
							<td>${preset.clsName}</td>
							<td>${fn:substring(preset.fixEmpNames,1,fn:length(preset.fixEmpNames)-1)}</td>
						 </tr>
						</c:forEach>
					</table>
				</div>
	 		</td>
		 	<td align="left">
		 		<div  class="box2" panelHeight="434" panelTitle="检修项目" overflow="auto">
		 			<div class="dbList">
		 				<div class="dtree" width="500px">
		 					<script>
								var id;
								d = new dTree("d");
								d.add(0,-1,'检修项目&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript: d.openAll();">全部展开</a>&nbsp;&nbsp;<a href="javascript: d.closeAll();">全部收缩</a>');
								<c:forEach var="map" items="${itemMap}" varStatus="idx">
				 					d.add('parent_${idx.index*10+1}',0,'<input type="checkbox" onclick="selectChildren(${idx.index+1});" id="p_${idx.index+1}"/>${map.key}',null);
				 					<c:forEach var="it" items="${map.value}">
				 					    <c:if test="${empty it.posiName}">d.add(${it.thirdUnitId},'parent_${idx.index*10+1}','<input type="checkbox" id="${it.thirdUnitId}" class="ch_${idx.index+1}" name="item"/>${it.itemName}','javascript:void(0)','${it.itemName}');</c:if>
				 					    <c:if test="${!empty it.posiName}">d.add(${it.thirdUnitId},'parent_${idx.index*10+1}','<input type="checkbox" id="${it.thirdUnitId}" class="ch_${idx.index+1}" name="item"/>${it.posiName}--${it.itemName}','javascript:void(0)','${it.posiName}--${it.itemName}');</c:if>
				 					</c:forEach>
				 				</c:forEach>
								document.write(d);
							</script> 
		 				</div>
		 			</div>
		 		</div>
		 	</td>
		</tr>
 	</table>	
</body>
</html>