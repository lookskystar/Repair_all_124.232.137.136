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
		<script type="text/javascript" src="js/attention/messager.js"></script>
	<!--截取文字end-->
	<script type="text/javascript" src="fix/js/unfinished-item.js"></script>
	<style type="text/css">
		a{color: blue;}
	</style>
	<script type="text/javascript">
		function getPJRec(presetId,pjRecId){
			$.post("<%=basePath%>partFixAction!ajaxGetPJFixRec.do",{"presetId":presetId,"pjRecId":pjRecId,"type":1},function(data){
				if(data!="no_data"){
					var result=eval("("+data+")");
					var datas=result.datas;
					var str="";
					for(var i=0;i<datas.length;i++){
						str+="<tr align='center' class=child-of-node-"+presetId+">";
						str+="<td></td>";
						str+="<td>"+datas[i].pjname+"</td>";
						str+="<td>"+parseData(datas[i].posiName)+"</td>";
						str+="<td>"+datas[i].fixItem+"</td>";
						str+="<td><span id='"+datas[i].pjRecId+"-fixsituation'>";
						if(datas[i].preStatus==1){
							str+="";
						}else if(parseData(datas[i].fixemp)!=""&&datas[i].fixsituation=="未启用"){
							str+="<span>未启用</span>";
						}else{
							if(parseData(datas[i].lead)==""){
								str+="<input type='text' onchange='signItem(this);' name='fix_status' id='"+datas[i].pjRecId+","+parseData(datas[i].min)+","+parseData(datas[i].max)+"' value='"+parseData(datas[i].fixsituation)+"'/>";
							}else{
								str+=""+parseData(datas[i].fixsituation)+"";
							}
						}
						str+="</span></td>";
						str+="<td>"+ parseData(datas[i].unit) +"</td>"
						if(parseData(datas[i].fixsituation)=="未启用"){
							str+="<td><input type='radio' id='"+datas[i].pjRecId+"-select' name='"+datas[i].pjRecId+"-select' value='"+datas[i].pjRecId+"' ondblclick='dbNoSel(this)'/><a href='javascript:void(0);' style='color:blue;' onclick='selected("+datas[i].pjRecId+");'>启用</a></td>";
						}else{
							str+="<td><input type='radio' id='"+datas[i].pjRecId+"-noSelect' name='"+datas[i].pjRecId+"-select' value='"+datas[i].pjRecId+"' ondblclick='dbNoSel(this)'/><a href='javascript:void(0);' style='color:blue;' onclick='noSelect("+datas[i].pjRecId+");'>禁用</a></td>";
						}
						str+="<td><span id='fix"+datas[i].pjRecId+"'>";
						if(parseData(datas[i].empaffirmtime)==""){
							str+="<span style='color: red;'>(待签)</span>";
						}else{
							str+=""+parseData(datas[i].fixemp)+"<br>"+parseData(datas[i].empaffirmtime)+"";
						}
						str+="</span></td>";
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
		
	     //项目禁用
		function noSelect(recId){
			top.Dialog.confirm("确认禁用？",function(){
				$("#"+ recId +"-fixsituation").text("");
				$.post("partFixAction!ajaxEnablePartFixItem.do",{"recId":recId},function(data){
					if(data == "success"){
						top.Dialog.alert("项目禁用成功！");
						window.location.reload();
					}
				})
	    	});
		}
		
		//项目启用
		function selected(recId){
			top.Dialog.confirm("确认启用？",function(){
				$("#"+ recId +"-fixsituation").text("");
				$.post("partFixAction!ajaxAblePartFixItem.do",{"recId":recId},function(data){
					if(data == "success"){
						top.Dialog.alert("项目启用成功！");
						window.location.reload();
					}
				})
	    	});
		}
		//一键禁用或启用项目 ，唐倩 2016-7-3 
		function selectKey(flag){
			var selDetail;
			if(flag==1)
				selDetail = "启用";
			else
				selDetail = "禁用";
			var recIds = [];
			$("input:radio").each(function(){
	        	var idValue = $(this).val();
	        	if(idValue != "" && idValue != "on"){
	        		recIds.push(idValue);
	        	}	
	        })
			
			if(recIds.length==0){
				top.Dialog.alert("没有可"+selDetail+"的项目？");
				return;
			}else{
				top.Dialog.confirm("确定要一键"+selDetail+"所选项目？",function(){
					var ids = ""+recIds.join("-");
					$.post("partFixAction!ajaxEAblePartFixItems.do",{"recIds":ids,"flag":flag},function(data){
						if(data == "success"){
							top.Dialog.alert("一键"+selDetail+"项目成功！");
							window.location.reload();
						}
					})
				});
			}
		}
		//禁用或启用项目 ，唐倩 2016-6-25 
		function selectDo(flag){
			var selDetail;
			if(flag==1)
				selDetail = "启用";
			else
				selDetail = "禁用";
			var recIds = [];
			$("input:radio:checked").each(function(){
	        	var idValue = $(this).val();
	        	if(idValue != "" && idValue != "on")
	        		recIds.push(idValue);
	        })
			
			if(recIds.length==0){
				top.Dialog.alert("请选择要"+selDetail+"的项目？");
				return;
			}else{
				top.Dialog.confirm("确定要"+selDetail+"所选项目？",function(){
					var ids = ""+recIds.join("-");
					$.post("partFixAction!ajaxEAblePartFixItems.do",{"recIds":ids,"flag":flag},function(data){
						if(data == "success"){
							top.Dialog.alert("项目"+selDetail+"成功！");
							window.location.reload();
						}
					})
				});
			}
		}
		//双击取消选择的单选按钮 ，唐倩 2016-6-26
		function dbNoSel(obj){
			$(obj).attr("checked",false);
		} 
	    function signItem(obj){
	    	var detectValue = $(obj).val();
			var itemArr = $(obj).attr("id");
			var userName = $("#userName").val();
			var valArr = itemArr.split(",");
			var recId = valArr[0];
			var minVal = valArr[1];
			var maxVal = valArr[2];
			var reg = /^-?[0-9]*(\.[0-9]+)?(\*-?[0-9]*(\.[0-9]+)?)?$/;
			if(!reg.test(detectValue)){
				top.Dialog.alert("测量值只能输入数值和*号，请重新输入！");
				$(obj).val("");
			}else{
				var result = checkMinMax(minVal,maxVal,detectValue);
				if(result=='success'){
					$.post("partFixAction!signDetectItem.do", {
						'recId' : recId,
						'status' : detectValue
					}, function(data) {
						$.messager.show(0,data,5000);
						$("#fix"+recId).text(userName);//把当前用户的名字动态加入到检修员栏目
					}, 'text');
				}else{
					top.Dialog.alert(result);
					$(obj).val("");
					return false;
				}
			}
	    }
	
		//判断最大最小值和所填值的比较
		function checkMinMax(minVal,maxVal,detValue){
			var min;
			var max;
			detValue = parseFloat(detValue);
			if(minVal.length>0){//存在最小值
				min = parseFloat(minVal);
				if(maxVal.length>0){
					max = parseFloat(maxVal);
					if(detValue<min || detValue>max){
						return "所填测量值不在该检测项目的标准范围内";
					}else{
						return "success";
					}
				}else{
					if(detValue<min){
						return "所填测量值不在该检测项目的标准范围内";
					}else{
						return "success";
					}
				}
			}else{//不存在最小值
				if(maxVal.length>0){
					max = parseFloat(maxVal);
					if(detValue > max){
						return "所填测量值不在该检测项目的标准范围内";
					}else{
						return "success";
					}
				}else{
					return "success";
				}
			}
			
		}
	</script>
  </head>
  
  <body>
<div>
	<table>
		<tr>
			<td colspan="7">
				<span class="icon_page">注：</span>
				<button onclick="selectKey(1);"><span class="icon_ok">一键启用</span></button>
				<button onclick="selectKey(0);"><span class="icon_no">一键禁用</span></button>
				<button onclick="selectDo(1);"><span class="icon_ok">启用</span></button>
				<button onclick="selectDo(0);"><span class="icon_no">禁用</span></button>
				<input id="userName" type="hidden" value="${session_user.xm}" />
				<input id="fixString" type="hidden" value="" />
			</td>
		</tr>
	</table>
	<table class="treeTable" headFixMode="true" useMultColor="true" useCheckBox="true">
		<tr align="center">
		    <th></th>
			<th width="10%">配件名</th>
			<th width="10%">部位</th>
			<th width="30%">检修项目</th>
			<th width="15%">检测情况</th>
			<th width="5%">单位</th>
			<th width="10%">是否启用</th>
			<th width="15%">检修员</th>
			<th width="5%">操作</th>
		</tr>
		
		<c:forEach var="pjPreset" items="${pjPresets}" varStatus="s">
	        <tr id="node-${pjPreset.presetId}">
	          <td><input type="radio" onclick="getPJRec(${pjPreset.presetId},${pjRecId});" id="rad_${pjPreset.presetId}"/></td>
	          <td colspan="9" align="left">
	             <input type="checkbox" onclick="selectChildren(${s.index+1});" id="p_${s.index+1}"/>
	             <span class="folder">${pjPreset.presetName}
	             <c:if test="${pjPreset.signed!=0}"><font color='red'>(未签认完全)</font></c:if>
	             </span>
	          </td>
	        </tr>
	        <tr class="child-of-node-${pjPreset.presetId}">
			   <td></td>
			  <td colspan="9" align="center"><a href="javascript:void(0);" onclick="getPJRec(${pjPreset.presetId},${pjRecId});"/>请点击这里/单选框获取项目信息</td>
			</tr>
      </c:forEach>
	</table>
</div>

</body>
</html>
