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
    <title>检查项目</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<script type="text/javascript" src="js/jquery.anchor.1.0.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="js/table/treeTable.js"></script>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	<!--截取文字start-->
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="fix/js/unfinished-item.js"></script>
	<style type="text/css">
		a{color: blue;}
	</style>
	<script type="text/javascript">
		//输入裂损情况
		function dealSituation(id){
			top.Dialog.open({URL:"<%=basePath%>fix/sign/pjts_ratify_dialog.jsp?role=worker&type=0&id="+id,Width:425,Height:300,Title:"裂损情况"});
		}
		
		//复探签字
		function reptSign(){
			var fixRecIds=[];
			var id;
			var flag = true;
			$("input[name='itemcheck']:checked").each(function(){
			   id = $(this)[0].value;
			   fixRecIds.push(id);
			   if($("#"+id+"_fixemp").val()==null || $("#"+id+"_fixemp").val()==""){
			   		flag = false;
			   		return false;
			   }
		   });
		   if(fixRecIds.length==0){
				top.Dialog.alert("请选择签认的项目!");
		   }else if(flag==false){
		   		top.Dialog.alert("项目主探还未签认!");
		   }else{
				var ids = ""+fixRecIds.join("-");
				$.post("<%=basePath%>partFixAction!reptPJFixRecSign.do",{"ids":ids},function(text){
					top.Dialog.alert("操作成功!",function(){
						window.location.reload();
					})
				});
			}
		}
		
		function getPJRec(presetId,pjRecId,checkId,tsflag){
			$.post("<%=basePath%>partFixAction!ajaxGetPJFixRec.do",{"presetId":presetId,"pjRecId":pjRecId,"type":0},function(data){
				if(data!="no_data"){
					var result=eval("("+data+")");
					var datas=result.datas;
					var str="";
					for(var i=0;i<datas.length;i++){
						str+="<tr align='center' class=child-of-node-"+presetId+">";
						if(datas[i].recstas<3){
							str+="<td><input type='checkbox' name='itemcheck' value="+datas[i].pjRecId+" class='ch_"+checkId+"'></td>";
						}else{
							str+="<td></td>";
						}
						str+="<td>"+datas[i].pjname+"</td>";
						str+="<td>"+parseData(datas[i].posiName)+"</td>";
						str+="<td>"+datas[i].fixItem+"</td>";
						if(tsflag==0){
							if(parseData(datas[i].empaffirmtime)==""){
								str+="<td><span style='color: red;'>(待签)</span></td>";
							}else{
								str+="<td>"+parseData(datas[i].fixemp)+"<br>"+parseData(datas[i].empaffirmtime)+"</td>";
							}
							if(datas[i].amount==0){
								str+="<td>/</td>";
							}else{
								str+="<td><a href='javascript:void(0);' onclick='inputNumber("+datas[i].pjRecId+", 1)'>输入编码</a></td>";
							}
							str+="<td>"+parseData(datas[i].fixsituation)+"</td>";
						}else{//探伤
							str+="<td><input type='hidden' id='"+datas[i].pjRecId+"_fixemp' value='"+parseData(datas[i].empaffirmtime)+"'/>"+parseData(datas[i].fixsituation)+"</td>";
							if(parseData(datas[i].dealSituaton)==""){
								str+="<td><a href='javascript:void(0);' style='color:blue;' onclick='dealSituation("+datas[i].pjRecId+")'>输入裂损情况</a></td>";
							}else{
								str+="<td><a href='javascript:void(0);' style='color:blue;' onclick='dealSituation("+datas[i].pjRecId+")'>"+datas[i].fixsituation+"</a></td>";
							}
							if(parseData(datas[i].empaffirmtime)==""){
								str+="<td><span style='color: red;'>(待签)</span></td>";
							}else{
								str+="<td>"+parseData(datas[i].fixemp)+"<br>"+parseData(datas[i].empaffirmtime)+"</td>";
							}
							if(parseData(datas[i].reptAffirmTime)==""){
								str+="<td><span style='color: red;'>(待签)</span></td>";
							}else{
								str+="<td>"+parseData(datas[i].rept)+"<br>"+parseData(datas[i].reptAffirmTime)+"</td>";
							}
						}
						if(datas[i].preStatus==1){
							str+="<td><span style='color:red'>已报活</span></td>";
						}else{
							str+="<td><a href='javascript:void(0);' onclick='createPredict("+datas[i].pjRecId+")'>报活</a></td>";
						}
						str+="</tr>";
					}
				}else{
					str+="<tr class=child-of-node-"+presetId+"><td></td><td colspan='9'>没有数据记录!</td></tr>";
				}
				$(".child-of-node-"+presetId).replaceWith(str);
       			$("#rad_"+presetId).remove();
			});
		}
		
		function parseData(data){
			if(data==undefined||data==null||data==""){
				return "";
			}else{
				return data;
			}
		}
		
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
	</script>
  </head>
  
  <body>
<div>
	<table>
		<tr>
			<td colspan="7">
				<c:choose>
					<c:when test="${tsflag==1}">
						<button id="sign_inspection"><span class="icon_edit">主探签名</span></button>
						<button id="allsign" onclick="reptSign();" ><span class="icon_edit">复探签名</span></button>
					</c:when>
					<c:otherwise><button id="sign_inspection"><span class="icon_edit">签认</span></button></c:otherwise>
				</c:choose>
				<input id="role_flag" type="hidden" value="${roleFlag}" />
			</td>
		</tr>
	</table>
	<table class="treeTable" headFixMode="true" useMultColor="true" useCheckBox="true">
		<tr align="center">
			<th width="30px"></th>
			<th width="10%">配件名</th>
			<th width="10%">部位</th>
			<th width="25%">检修项目</th>
			<c:choose>
			<c:when test="${tsflag==1}">
				<th width="11%">探伤结果</th>
				<th width="12%">裂损情况</th>
				<th width="11%">主探</th>
				<th width="11%">复探</th>
			</c:when>
			<c:otherwise>
				<th width="10%">检修员</th>
				<th width="20%">组装配件编码</th>
				<th width="15%">检修情况</th>
			</c:otherwise>
		</c:choose>
			<th width="10%">操作</th>
		</tr>
		
		<c:forEach var="pjPreset" items="${pjPresets}" varStatus="s">
	        <tr id="node-${pjPreset.presetId}">
	          <td><input type="radio" onclick="getPJRec(${pjPreset.presetId},${pjRecId},${s.index+1},${tsflag});" id="rad_${pjPreset.presetId}"/></td>
	          <td colspan="9" align="left">
	             <input type="checkbox" onclick="selectChildren(${s.index+1});" id="p_${s.index+1}"/>
	             <span class="folder">${pjPreset.presetName}
	             <c:if test="${pjPreset.signed!=0}"><font color='red'>(未签认完全)</font></c:if>
	             </span>
	          </td>
	        </tr>
	        <tr class="child-of-node-${pjPreset.presetId}">
			   <td></td>
			   <td colspan="9" align="center"><a href="javascript:void(0);" onclick="getPJRec(${pjPreset.presetId},${pjRecId},${s.index+1},${tsflag});">请点击这里/单选框获取项目信息</font></td>
			</tr>
      </c:forEach>
	</table>
</div>

</body>
<script type="text/javascript">
    //修改配件编号 
	function pjNumUpdate(){
		var arg_length = arguments.length;
		var itemName = arguments[0];
		var pjRecId = arguments[1];
		var amount = arguments[2];
		var pJNum = "";
		for(var i=3; i < arg_length;i++){
			if(i != arg_length -1){
				pJNum += arguments[i]+",";
			}else{
				pJNum += arguments[i];
			}
		}
		top.Dialog.open({MessageTitle:"检修项目:"+itemName+"  需添加配件数量:"+amount,Message:"",Title:"修改配件编号信息",URL:"<%=basePath%>partFixAction!pjNumUpdateInput.do?pjRecId="+pjRecId+"&pJNum="+pJNum,Width:500,Height:400,ID:'frmDialog'});
	}
</script>
</html>
