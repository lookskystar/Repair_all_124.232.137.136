<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>" />
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" id="skin"
	prePath="<%=basePath%>" />
<!--框架必需end-->
<script type="text/javascript" src="js/tree/dtree/dtree.js"></script>
<link href="js/tree/dtree/dtree.css" rel="stylesheet" type="text/css" />
<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->
<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
<script>

		   //将该角色已有的功能勾选
		   $(function(){
			    $.post("rolesAction!getRoleFunPrivsById.do",{"roleId":${role.roleid}},function(data){
				    var result=eval("("+data+")");
				    var fun=result.funIds;
				    for(var i=0;i<fun.length;i++){
				    	 $('input[name="fun"]').each(function(){
					    	 if(this.id==fun[i].funId){
						    	 $(this).attr("checked",true);
					    	 }
		                });
				    }
			    });
			});
		
		   //保存功能和角色之间的关系
		   function tosave(){			   
			   var roleid='${role.roleid}';
			   var funids=[];
			   $("input[name='fun']:checked").each(function(){
				   funids.push($(this)[0].id);
			   });
			   if(funids.length==0){
				   top.Dialog.alert("请选择权限!");
			   }else{
				   var ids=funids.join("-");
				   $.post("rolesAction!updaterolefunprivs.do",{"roleid":roleid,"ids":ids},function(data){
					  if(data=="success"){
						  top.Dialog.alert("保存成功!");
						  window.location.reload();
					  }else{
						  top.Dialog.alert("保存失败");
					  }
				   });
			   }
		   }

		 //关闭此页面
		function toclose(){
			top.Dialog.close();
		}
		
		//勾选子菜单
		function selectChildren(fid,sid){
	   		if($("#p_"+fid+"_"+sid).attr("checked")){
	   		  $(".ch_"+fid+"_"+sid).each(function(){
	   		    $(this).attr("checked",true);
	   		  });
	   		}else{
	   		   $(".ch_"+fid+"_"+sid).each(function(){
	   		    $(this).attr("checked",false);
	   		  });
	   		}
	   }		
</script>

</head>
	<body>
		<div class="box1">
			<a href="javascript: d.openAll();">展开所有</a> | <a href="javascript: d.closeAll();">全部收缩</a>
			<script type="text/javascript">
			d = new dTree("d");
			d.add(0,-1,'权限列表');
			<c:forEach var="map" items="${funMap}" varStatus="first">
				d.add('first_${first.index}',0,'${map.key}',null);
				<c:forEach var="it" items="${map.value}" varStatus="second">
					d.add('second_${first.index}_${second.index}','first_${first.index}','<input type="checkbox" id="p_${first.index}_${second.index}" onclick="selectChildren(${first.index},${second.index});"/>${it.key}','javascript:void(0)');
					<c:forEach var="t" items="${it.value}">
						d.add(${t.fid},'second_${first.index}_${second.index}','<input type="checkbox" id="${t.fid}" class="ch_${first.index}_${second.index}" name="fun"/>${t.funname}','javascript:void(0)');
					</c:forEach>
				</c:forEach>
			</c:forEach>	
			document.write(d);
			</script>
		    <button onclick="tosave();"><span class="icon_save">保存</span></button>&nbsp;&nbsp;
		    <button onclick="toclose();"><span class="icon_mark">关闭</span></button>
		</div>
	</body>
</html>