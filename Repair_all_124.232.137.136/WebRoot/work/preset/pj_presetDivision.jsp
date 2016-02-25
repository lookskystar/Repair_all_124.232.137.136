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
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="part/js/part_plan.js"></script>
    <!-- ztree -->
	<link rel="stylesheet" href="ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="ztree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="ztree/js/jquery.ztree.excheck-3.5.js"></script>
	<script type="text/javascript" src="ztree/js/jquery.ztree.exedit-3.5.js"></script>
	<script type="text/javascript">
	   //控制复选框为单选
	   function selectThis(obj){
		   $("input[name='check']").each(function(){
			   $(this).attr("checked",false);
		   });
		   obj.checked=true;
		   var ysId=obj.id;
	       var treeObj = $.fn.zTree.getZTreeObj("tree");
		   var nodes = treeObj.getCheckedNodes(true);
		   for(var i=0;i<nodes.length;i++){
			   treeObj.checkNode(nodes[i], false, false);
		   }
           $.post("presetDivisionAction!getPJFixitemByYsId.do",{"ysId":ysId},function(data){
        	   var results=eval("("+data+")");
        	   var itemIds=results.itemIds;
        	   if(itemIds.length!=0){
        		   nodes = treeObj.getCheckedNodes(false);
        		   for(var i=0;i<itemIds.length;i++){
        			   for(var j=0;j<nodes.length;j++){
        				   if(nodes[j].id==itemIds[i].itemId){
        					   treeObj.checkNode(nodes[j], true, true);
        				   }
        			   }
        	      }
        	   }
           });		   
	   }
	   
	   //根据类型得到预设分工大类信息
	   function getpresetDivision(){
		   var jcType=$("#jcType").val();
		   var bzid = $("#bzid").val();
		   var pjsId=$("#pjName").val();
		   if(pjsId!=null && ''!=pjsId){
		   		window.location.href="presetDivisionAction!pjPresetDivisionInput.do?pjsId="+pjsId+"&jcType="+jcType+"&bzid="+bzid;
		   }
	   }
	   
	   //保存预设分工信息和项目之间的关系
	   function savePresetItem(){
		   var presetId="";
		   var itemIds=[];
		   $("input[name='check']:checked").each(function(){
			   presetId=$(this)[0].id;
		   });
		   var treeObj = $.fn.zTree.getZTreeObj("tree");
		   var nodes = treeObj.getCheckedNodes(true);
		   for(var i=0;i<nodes.length;i++){
				if(!nodes[i].isParent){
					itemIds.push(nodes[i].id);
				}
			}
		   if(presetId==""){
			  top.Dialog.alert("请选择预设分工大类!");
		   }else if(itemIds.length==0){
			   top.Dialog.alert("请选择项目!");
		   }else{
			   var ids=itemIds.join("-");
			   $.post("presetDivisionAction!updatePJFixitemYsId.do",{"presetId":presetId,"ids":ids},function(data){
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
		      $("input[name='check']:checked").each(function(){
			     presetId=$(this)[0].id;
		   	  });
		      if(presetId==""){
		    	 top.Dialog.alert("请选择预设分类!");
		      }else{
		    	 top.Dialog.open({URL:"presetDivisionAction!updatePJPresetDivisionInput.do?presetId="+presetId,Width:400,Height:300,Title:"修改预设分类"});
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
	    	  $.post("presetDivisionAction!delPJPresetDivision.do",{"ysId":presetId},function(data){
	    		  if(data=="success"){
					  top.Dialog.alert("删除成功!");
					  window.location.reload();
				  }else{
					  top.Dialog.alert("删除失败");
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
	   		var pjsId=$("#pjName").val();
	   		if(pjsId==''){
	   			top.Dialog.alert("请选择配件名称!");
	   		}else{
	   			top.Dialog.open({URL:"presetDivisionAction!savePJPresetDivisionInput.do?pjsId="+pjsId,Width:400,Height:300,Title:"添加预设分类"});
	   		}
	   }
	   
	   function getPJName(){
		   var jcType=$("#jcType").val();
		   var bzid = $("#bzid").val();
		   var str="<option value=''>请选择配件名称</option>";
		   $.post("<%=basePath%>presetDivisionAction!ajaxGetPjName.do",{"jcType":jcType,"bzid":bzid},function(data){
			   if(data!='no_data'){
				   var result=eval("("+data+")");
				   var datas=result.datas;
				   for(var i=0;i<datas.length;i++){
					   str+="<option value="+datas[i].pjsId+">"+datas[i].pjName+"</option>";
				   }
				   $("#pjName").children().remove();
              	   $("#pjName").append(str);
			   }else{
				  $("#pjName").children().remove();
              	  $("#pjName").append(str);
			   }
		   });
	   }
	   
	   var setting = {
			check: {enable: true},
			data: {simpleData: {enable: true}}
		};

		var dataMaker = function(count) {
			var nodes = [];
			var n;
			<c:forEach var="map" items="${itemMap}" varStatus="idx">
				var n={id:"f_${idx.index}",pId:-1,name:'${map.key}'};
				nodes.push(n);
				<c:forEach var="item" items="${map.value}" varStatus="sidx">
				    <c:if test="${empty item.posiName}">
					   var n={id:"${item.pjItemId}",pId:"f_${idx.index}",name:"${item.fixItem}"};
				    </c:if>
				    <c:if test="${!empty item.posiName}">
				       var n={id:"${item.pjItemId}",pId:"f_${idx.index}",name:"${item.posiName}--${item.fixItem}"};
				    </c:if>
					nodes.push(n);
				</c:forEach>
			</c:forEach>
			return nodes;
		}

		var ruler = {
			doc: null,
			ruler: null,
			cursor: null,
			minCount: 5000,
			count: 5000,
			stepCount:500,
			init: function() {
				ruler.doc = $(document);
				ruler.ruler = $("#ruler");
				ruler.cursor = $("#cursor");
				if (ruler.ruler) {
					ruler.ruler.bind("mousedown", ruler.onMouseDown);
					
				}
			},
			onMouseDown: function(e) {
				ruler.drawRuler(e, true);
				ruler.doc.bind("mousemove", ruler.onMouseMove);
				ruler.doc.bind("mouseup", ruler.onMouseUp);
				ruler.doc.bind("selectstart", ruler.onSelect);
				$("body").css("cursor", "pointer");
			},
			onMouseMove: function(e) {
				ruler.drawRuler(e);
				return false;
			},
			onMouseUp: function(e) {
				$("body").css("cursor", "auto");
				ruler.doc.unbind("mousemove", ruler.onMouseMove);
				ruler.doc.unbind("mouseup", ruler.onMouseUp);
				ruler.doc.unbind("selectstart", ruler.onSelect);
				ruler.drawRuler(e);
			},
			onSelect: function (e) {
				return false;
			},
			getCount: function(end) {
				var start = ruler.ruler.offset().left+1;
				var c = Math.max((end - start), ruler.minWidth);
				c = Math.min(c, ruler.maxWidth);
				return {width:c, count:(c - ruler.minWidth)*ruler.stepCount + ruler.minCount};
			},
			drawRuler: function(e, animate) {
				var c = ruler.getCount(e.clientX);
				ruler.cursor.stop();
				if ($.browser.msie || !animate) {
					ruler.cursor.css({width:c.width});
				} else {
					ruler.cursor.animate({width:c.width}, {duration: "fast",easing: "swing", complete:null});
				}
				ruler.count = c.count;
				ruler.cursor.text(c.count);
			}
		}

		function createTree () {
			var zNodes = dataMaker(ruler.count);
			showNodeCount = 0;
			$("#tree").empty();
			$.fn.zTree.init($("#tree"), setting, zNodes);
		}

		$(document).ready(function(){
			ruler.init("ruler");
			createTree();
		});
	</script>
  </head>
  
 <body>
 	<table width="100%" align="left">
 		<tr>
 			<td width="320px">
 		<div class="box2"  panelTitle="预设分类管理" panelHeight="434" panelWidth="320">
 		   <center>请选择机车类型:
 		     <select style="width: 150px" onchange="getPJName();" id="jcType" class="default">
 		     	<c:forEach items="${dictJcTypeList}" var="type">
 		     		<option value="${type.jcStypeValue}" <c:if test="${jcType==type.jcStypeValue}">selected="selected"</c:if>>${type.jcStypeValue}</option>
 		     	</c:forEach>
 		     </select>
 		   </center>
 			<center>请选择班组名称:
 			<select style="width: 150px" onchange="getPJName();" id="bzid" class="default">
 				<option value="0">请选择班组</option>
   	        	<c:forEach items="${dictProTeamList}" var="entry">
    	           <option value="${entry.proteamid}" <c:if test="${bzid==entry.proteamid}">selected="selected"</c:if>>${entry.proteamname}</option>
    	        </c:forEach>
    	    </select>
    	    </center>
    	    <center>请选择配件名称:
 			<select style="width: 150px" onchange="getpresetDivision();" id="pjName" class="default">
 				<option value="">请选择配件名称</option>
 				<c:if test="${!empty pjStaticInfos}">
 				  <c:forEach var="pjs" items="${pjStaticInfos}">
 				    <option value="${pjs.pjsid}" <c:if test="${pjsId==pjs.pjsid}">selected="selected"</c:if>>${pjs.pjName}</option>
 				  </c:forEach>
 				</c:if>
    	    </select>
    	    </center>
 		   <button onclick='javascript:toAdd();'><span class="icon_add">新增</span></button>&nbsp;&nbsp;&nbsp;
 		   <button  onclick="delPreset();"><span class="icon_delete">删除</span></button>&nbsp;&nbsp;&nbsp;
 		   <button  onclick="updPreset();"><span class="icon_edit">修改</span></button>&nbsp;&nbsp;
 		   <button onclick="savePresetItem();"><span class="icon_save">保存关系</span></button>
			<table class="tableStyle" useCheckBox="false" overflow="auto">
				<tr align="center">
					<td width="10%"></td>
					<td width="50%">分类名称</td>
				</tr>
				<c:forEach var="preset" items="${presets}">
				 <tr>
					<td><input type="checkbox" name="check" onclick="selectThis(this);" id="${preset.presetId}"/></td>
					<td>${preset.presetName}</td>
				 </tr>
				</c:forEach>
			</table>
		</div>
 	</td><td align="left">
 		<div  class="box2" panelHeight="434" panelTitle="配件检修项目" overflow="auto">
 			  <div id="tree" class="ztree" style="overflow: auto;width: 500px;min-height: auto;"></div>
 		</div>
 		</td>
</tr>
 	</table>	
	
</body>
</html>