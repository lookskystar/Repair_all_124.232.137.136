<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"/>
    <title>检修项目</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	
	<!-- ztree -->
	<link rel="stylesheet" href="ztree/css/demo.css" type="text/css" />
	<link rel="stylesheet" href="ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
	<script type="text/javascript" src="ztree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="ztree/js/jquery.ztree.excheck-3.5.js"></script>
	<script type="text/javascript" src="ztree/js/jquery.ztree.exedit-3.5.js"></script>
	<script type="text/javascript">
		var setting = {
			check: {enable: true},
			data: {simpleData: {enable: true}}
		};

		var dataMaker = function(count) {
			var nodes = [];
			var n;
			<c:forEach var="first" items="${map}" varStatus="fidx">
				var n={id:"f_${fidx.index}",pId:-1,name:'${first.key}'};
				nodes.push(n);
				<c:forEach var="second" items="${first.value}" varStatus="sidx">
					var n={id:"s_${fidx.index}_${sidx.index}",pId:"f_${fidx.index}",name:"${second.key}"};
					nodes.push(n);
					<c:forEach var="item" items="${second.value}">
						var n={id:${item.thirdUnitId},pId:"s_${fidx.index}_${sidx.index}",name:"${item.posiName}--${item.itemName}"};
						nodes.push(n);
					</c:forEach>
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
		
		//保存关系--父页面调用
		function save(templateId){
			if(templateId==null || templateId==undefined){
				top.Dialog.alert("请选择模板项目!");
			}else{
				var treeObj = $.fn.zTree.getZTreeObj("tree");
				var nodes = treeObj.getCheckedNodes(true);
				if(nodes.length==0){
					top.Dialog.alert("请选择关联的检修项目!");
				}else{
					var itemIds = [];
					for(var i=0;i<nodes.length;i++){
						if(!nodes[i].isParent){
							itemIds.push(nodes[i].id);
						}
					}
					if(itemIds.length>0){
						var ids = itemIds.join(",");
						$.post("<%=basePath%>reportTemplate!saveRelation.do",{"tpid":templateId,"itmids":ids},function(data){
							if(data=="success"){
								top.Dialog.alert("保存成功!");
							}else{
								top.Dialog.alert("保存失败!");
							}
						});
					}else{
						top.Dialog.alert("请选择关联的检修项目!");
					}
				}
			}
		}
		//勾选关联的项目--父级调用
		function checkNodes(ids){
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			var nodes = treeObj.getCheckedNodes(true);
			for(var i=0;i<nodes.length;i++){
				treeObj.checkNode(nodes[i], false, false);
			}
					
			if(ids!=null && ids!=""){
				var idArray = ids.split(",");
				var node;
				for(var i=0;i<idArray.length;i++){
					node = treeObj.getNodeByTId(idArray[i]);
					if(node!=null){
						treeObj.checkNode(node, true, true);
					}
				}
			}
		}
	</script>
 </head>
<body>
<div id="tree" class="ztree" style="overflow: auto;width: 450px;min-height: 430px;"></div>
</body>
</html>