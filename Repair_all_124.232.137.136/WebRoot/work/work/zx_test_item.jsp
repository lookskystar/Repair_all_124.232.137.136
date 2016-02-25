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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左侧菜单</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<script type="text/javascript" src="js/jquery.anchor.1.0.js"></script>
<script type="text/javascript" src="js/table/treeTable.js"></script>
<script type="text/javascript" src="js/attention/messager.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/enterNext.js"></script>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
<!--框架必需end-->

<!--截取文字start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<!--截取文字end-->

<!--修正IE6支持透明PNG图start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明PNG图end-->
<script type="text/javascript">
//报活
$(document).ready(function(){
	/*$("input[name='fixSituation']").each(function(){
		var id = $(this).attr("id");
		var fixSituation = $(this).val();
		var noSelect = "没有启用";
		if(fixSituation.indexOf(noSelect) == 0 && noSelect.indexOf(fixSituation) == 0){
			$("#"+ id +"-noSelect").attr("checked", "checked");
			$("#"+ id +"").attr("disabled","disabled");
		}
	})*/
	
	$('#newreport').bind('click', function(){
		var planid = $('#dateplan').val();
		var jctype = $('#jctype').val();
		var diag = new top.Dialog();
		diag.Title = "报活操作窗口";
		diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+planid+'&type='+jctype;
		diag.Width=1000;
		diag.Height=520;
		diag.show();
	});
	
	$("#bz").zxxAnchor({
    	anchorSmooth: false                       
    });
    
    $("#nbz").zxxAnchor({
    	anchorSmooth: false                       
    });
    
})

//工位全选
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

//禁用或启用项目 ，唐倩 2016-6-29
function isSelect(id,flag){
	/*$("#"+ id +"-test_item").attr("checked","checked");
	$("#"+ id +"").removeAttr("disabled");
	if($("#"+ id +"").val().indexOf("没有启用")==0){
		$("#"+ id +"").val("");
	}
	top.Dialog.alert("项目启用成功！");
	*/
	var selDetail;
	if(flag==0)
		selDetail = "启用";
	else
		selDetail = "禁用";
	var recIds = [];
	recIds.push(id);
	top.Dialog.confirm("确定要"+selDetail+"该项目？",function(){
		var ids = ""+recIds.join("-");
		$.post("workAction!ajaxZxFixTesItems.do",{"recIds":ids,"flag":flag},function(data){
			if(data == "success"){
				top.Dialog.alert(selDetail+"项目成功！");
				window.location.reload();
			}
		})
	});
}
//多选禁用或启用项目 ，唐倩 2016-6-29
function selectDo(flag){
	var selDetail;
	if(flag==0)
		selDetail = "启用";
	else
		selDetail = "禁用";
	var recIds = [];
	$("input:radio:checked").each(function(){
    	var idValue = $(this).val();
    	recIds.push(idValue);
    })
	
	if(recIds.length==0){
		top.Dialog.alert("请选择要"+selDetail+"的项目？");
		return;
	}else{
		top.Dialog.confirm("确定要"+selDetail+"所选项目？",function(){
			var ids = ""+recIds.join("-");
			$.post("workAction!ajaxZxFixTesItems.do",{"recIds":ids,"flag":flag},function(data){
				if(data == "success"){
					top.Dialog.alert(selDetail+"项目成功！");
					window.location.reload();
				}
			})
		});
	}
	
}
//项目禁用
function noSelect(id){
	$("#"+ id +"-test_item").attr("checked","checked");
	$("#"+ id +"").attr("disabled","disabled");
	top.Dialog.alert("项目禁用成功！");
}
//一键禁用或启用项目 ，唐倩 2016-6-29 
function selectKey(flag){
	var selDetail;
	if(flag==0)
		selDetail = "启用";
	else
		selDetail = "禁用";
	var recIds = [];
	$("input:radio").each(function(){
    	var idValue = $(this).val();
    	recIds.push(idValue);
    })
	
	if(recIds.length==0){
		top.Dialog.alert("没有可"+selDetail+"的项目？");
		return;
	}else{
		top.Dialog.confirm("确定要一键"+selDetail+"所选项目？",function(){
			var ids = ""+recIds.join("-");
			$.post("workAction!ajaxZxFixTesItems.do",{"recIds":ids,"flag":flag},function(data){
				if(data == "success"){
					top.Dialog.alert("一键"+selDetail+"项目成功！");
					window.location.reload();
				}
			})
		});
	}
}

//双击取消选择的单选按钮 ，唐倩 2016-6-29
function dbNoSel(obj){
	$(obj).attr("checked",false);
}
function dbSel(obj){
	$(obj).attr("checked",true);
}		
//签名
function ratify(){
	//参数列
	var rjhmId = ${rjhmId};
	var xtype = ${xtype};
	//判断是否有一个项目被选中
	var flagSelect = false;
	//判断是否正确值
	var flagRatify = true;
	var length = 0;
	var itemString = "{";
	//遍历所有name为test_item的选项
	$("input[name='test_item']").each(function(){
		//判断是否选中
		if ($(this).attr("checked")) { 
			//只要有一个被选择 设置为 true
			flagSelect = true; 
		}
		length += 1;
	})
	if(flagSelect){
		var i = 1;
		$("input[name='test_item']:checked").each(function(){
			var idValue = $(this).val();
		    var isSelect = $("input[name='"+ idValue +"-select']").val();
		    var itemValue = $("#"+ idValue +"").val();
		    var itemMaxValue = $("#"+ idValue +"-max").val();
		    var itemMinValue = $("#"+ idValue +"-min").val();
			if(isSelect==1){
				if(itemValue != null && itemValue  != "" 
					&& itemValue != undefined 
					&& parseInt(itemValue) >= parseInt(itemMinValue) 
					&& parseInt(itemValue) <= parseInt(itemMaxValue)){
		    		//将选中的值添加到json字符串中
		    		if(i<length){
		    			itemString += "\""+ idValue +"\":";
		    			itemString += "\""+ itemValue +"\"";
		    			itemString += ",";
		    			i += 1;
		    		}else{
		    			itemString += "\""+ idValue +"\":";
		    			itemString += "\""+ itemValue +"\"";
		    		}
					$("#"+ idValue +"").removeAttr("style");
				}else{
					$("#"+ idValue +"").css({border:"1px solid red"});
					$("#"+ idValue +"").focus();
					flagRatify = false;
					top.Dialog.alert("错误的检测值！");
					return false;
				}
			}else{
				itemValue = "没有启用";
				//将选中的值添加到json字符串中
	    		if(i<length){
	    			itemString += "\""+ idValue +"\":";
	    			itemString += "\""+ itemValue +"\"";
	    			itemString += ",";
	    			i += 1;
	    		}else{
	    			itemString += "\""+ idValue +"\":";
	    			itemString += "\""+ itemValue +"\"";
	    		}
				$("#"+ idValue +"").removeAttr("style");
			}
		})
		itemString += "}";
		if(flagRatify){
			$.ajax({
				type:'post',
				url:'workAction!workerZxRatify.action',
				data:{"type":"1","qtype":"0","xtype":xtype,"rjhmId":rjhmId,"role":"worker","itemString":itemString},
				success:function(result){
					if("success"==result){
						$.messager.show(0,'签认成功!');
					}else{
						$.messager.show(0,'签认失败 !');
					}
					$("input[name='test_item']:checked").each(function(){
			        	$(this).attr("checked",false);
			        })
			        setTimeout(function(){
			            window.frames.location.reload();
			        },1000);
				}
			}); 
		}
	}else{
		$("input[name='test_item']").each(function(){
			var idValue = $(this).val();
		    var itemValue = $("#"+ idValue +"").val();
			$("#"+ idValue +"").removeAttr("style");
		})
		top.Dialog.alert("请选择要签认的项目！");
	}
	
}

//输入配件编号
function pjNumInputWith(itemName,zxRecId,amount){
	var planId = $('#dateplan').val();
	top.Dialog.open({MessageTitle:"检修项目:"+itemName+"  需添加配件数量:"+amount,Message:"",Title:"配件编号信息",URL:"<%=basePath%>workAction!pjNumInput.do?zxRecId="+zxRecId+"&type=1&planId="+planId,Width:500,Height:400,ID:'frmDialog'});
}

//修改配件编号 
function pjNumUpdate(){
	var arg_length = arguments.length;
	var itemName = arguments[0];
	var zxRecId = arguments[1];
	var amount = arguments[2];
	var upPJNum = "";
	for(var i=3; i < arg_length;i++){
		if(i != arg_length -1){
			upPJNum += arguments[i]+",";
		}else{
			upPJNum += arguments[i];
		}
	}
	top.Dialog.open({MessageTitle:"检修项目:"+itemName+"  需添加配件数量:"+amount,Message:"",Title:"修改配件编号信息",URL:"<%=basePath%>workAction!pjNumUpdateInput.do?zxRecId="+zxRecId+"&type=1&upPJNum="+upPJNum,Width:500,Height:400,ID:'frmDialog'});
}

//输入检测值选中前面的checkbox
function checkBefChb(obj,chkId){
	var text = obj.value;
	if(obj!=null && obj.value!=undefined && obj.value!=null && obj.value!=""){
		document.getElementById(chkId).checked=true;
	}
}

//撤销项目签认
function cancelZXSign(jcRecId){
	top.Dialog.confirm("确定要取消项目签认吗?",function(){
		$.post("<%=basePath%>workAction!cancelZXSign.do",{"jcRecId":jcRecId},function(data){
			if(data=="success"){
				top.Dialog.alert("项目取消签认成功",function(){
					window.location.reload();
					top.Dialog.close(); 
				});
			}else if(data=="no_user"){
				top.Dialog.alert("没有权限!");
			}else{
				top.Dialog.alert("项目取消签认失败!");
			}
		});
	});
}
</script>
<style type="text/css">
*html{
 background-image:url(about:blank);
 background-attachment:fixed;
 }
 
#sign{
 _position:absolute;
 _bottom:auto;
 _top:expression(eval(document.documentElement.scrollTop));
 _margin-top:5px;
 _margin-left:5px;
 }
 
#newreport{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:75px;
}
#keyactivated{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:135px;
}
#activated{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:228px;
}
#keybanned{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:292px;
}
#banned{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:384px;
}
#freeItemTab{
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:30px;
}
</style>
</head>
<body>
<input id="dateplan"  type="hidden" value="${rjhmId }"/>
<input id="jctype"  type="hidden" value="${jctype }"/>
<button id="sign" onclick="ratify();" ><span class="icon_save">签名</span></button>
<button id="newreport" ><span class="icon_print">报活</span></button>
<!-- 唐倩 2015-6-29 增加启用、禁用项目操作 -->
<button id="keyactivated" onclick="selectKey(0);"><span class="icon_ok">一键启用</span></button>
<button id="activated" onclick="selectDo(0);"><span class="icon_ok">启用</span></button>
<button id="keybanned" onclick="selectKey(1);"><span class="icon_no">一键禁用</span></button>
<button id="banned" onclick="selectDo(1);"><span class="icon_no">禁用</span></button>
<%--
<table class="tableStyle" style="text-align: center;margin-top: 30px;" id="testItemTab">
	<tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">我的检修项目<button anchor="nbz" id="bz">自选检修项目</button></td></tr>
	<tr>
		<th width="30px">选择</th>
		<th width="20%">工位</th>
		<th width="30%">检修项目</th>
		<th width="20%">检修情况(检测值)</th>	
		<th width="10%">是否启用</th>
		<th width="30%">检修人</th>
	</tr>
	<c:if test="${empty itemList}"><tr><td colspan="11">没有数据记录!</td></tr></c:if>
	<c:forEach var="itm" items="${itemList}">
		<tr>
			<td>
				<c:choose>
					<c:when test="${itm.recStas<2 && empty itm.fixEmp}"><input type="checkbox" value="${itm.id}" name="test_item" id="${itm.id}-test_item"/></c:when>
					<c:otherwise>&nbsp;</c:otherwise>
				</c:choose>
			</td>
			<td>${itm.itemId.unitName}  ${itm.itemId.posiName}</td>
			<td>${itm.itemName}</td>
			<td>
				<input type="hidden" id="${itm.id}-max" value="${itm.itemId.max}" />
				<input type="hidden" id="${itm.id}-min" value="${itm.itemId.min}"/>
				<input type="text" id="${itm.id}" value="${itm.fixSituation}"/>${itm.itemId.unit}
			</td>
			<td><input type="radio" name="${itm.id}-select" checked="checked" value="1"/>是
				<input type="radio" name="${itm.id}-select" value="0" onclick="noSelect(${itm.id});"/>否 
			</td>
		<td>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.fixEmpTime}</td>
		</tr>
	</c:forEach>
</table>
<div>
	<div class="float_left padding5">
		共有信息${fn:length(itemList)}条。&nbsp;&nbsp;<font color="red">当前机车：${dateplan.jcType }-${dateplan.jcnum }-${dateplan.fixFreque }</font>
	</div>
	<div class="clear"></div>
</div>	
 --%>

<table class="treeTable" style="text-align: center;" initState="collapsed" id="freeItemTab">
	<tr><td colspan="11" align="left" style="color: red;">
		<%-- 自选检测项目<button anchor="bz" id="nbz">我的检修项目</button> --%>
		当前机车：${dateplan.jcType }-${dateplan.jcnum }-${dateplan.fixFreque }
	</td></tr>
	<tr>
		<th width="20px">选择</th>
		<th width="15%">部件/部位</th>
		<th width="25%">检修项目</th>
		<th width="10%">配件编号</th>
		<th width="20%">检修情况(检测值)</th>
		<th width="10%">是否启用</th>
		<th width="30%">检修人</th>
	</tr>
	<c:if test="${empty freeItem}"><tr><td colspan="12">没有数据记录!</td></tr></c:if>
	<!-- 固定检修 -->
     <c:forEach var="freeItem" items="${freeItem}" varStatus="s">
	    <tr id="node-${s.index+1 }">
			<td style="width: 5%;">&nbsp;<input type="checkbox" onclick="selectChildren(${s.index+1});" id="p_${s.index+1}"/></td>
			<td colspan="6" align="left"><span class="folder">${freeItem.key }</span></td>
		</tr>
		<c:forEach var="itm" items="${freeItem.value}">
			<tr class="child-of-node-${s.index+1}">
			    <td>
			    <c:choose>
					<c:when test="${(itm.recStas<2 && empty itm.fixEmp && itm.fixSituation != '未启用') || (empty itm.lead  && itm.fixSituation != '未启用') }"><input type="checkbox" value="${itm.id}" class="ch_${s.index+1}" name="test_item" id="${itm.id}-test_item"/></c:when>
					<c:otherwise>&nbsp;</c:otherwise>
				</c:choose>
				</td> 
				<td>${itm.itemId.posiName} ${itm.itemId.unitName}</td>
				<td style="white-space:normal;word-break:break-all;word-wrap:break-word;">${itm.itemName}</td>
				<td style="white-space:normal;word-break:break-all;word-wrap:break-word;">
				   <c:if test="${empty itm.upPjNum&&empty itm.downPjNum}">
				   		<c:choose>
					    	<c:when test="${not empty itm.itemId.amount }" >
					    		<a href="javascript:void(0);" style="color:blue;" onclick="pjNumInputWith('${itm.itemName}','${itm.id}','${itm.itemId.amount }','${itm.itemId.stdPjId}');">点击输入</a>
					    	</c:when>
					    	<c:otherwise>	
					    		<font>/</font>
					    	</c:otherwise>
				      	</c:choose>
				   </c:if>
				   <c:if test="${!empty itm.upPjNum}"><font title="点击修改配件编码"><a href="javascript:void(0);" style="color:blue;" onclick="pjNumUpdate('${itm.itemName}','${itm.id}','${itm.itemId.amount }','${itm.upPjNum }');">${itm.upPjNum}</a></font></c:if>
				   <c:if test="${!empty itm.downPjNum}">${itm.downPjNum}</c:if>
				</td>
				<td>
					<input type="hidden" id="${itm.id}-max" value="${itm.itemId.max}" />
					<input type="hidden" id="${itm.id}-min" value="${itm.itemId.min}"/>
					<!-- <input type="text" id="${itm.id}" name="fixSituation" value="${itm.fixSituation}" onblur="checkBefChb(this,'${itm.id}-test_item');"/> ${itm.itemId.unit} -->
					<!-- 唐倩 2015-6-29 -->
					<c:choose>
						<c:when test="${!empty itm.fixEmp && itm.fixSituation == '未启用'}">
							<span>未启用</span>
						</c:when>
						<c:otherwise>
						    <c:if test="${empty itm.lead}">
								<input type="text" name="fixSituation" id="${itm.id}" value="${itm.fixSituation}"  onblur="checkBefChb(this,'${itm.id}-test_item');"/> ${itm.itemId.unit}
							</c:if>
							<c:if test="${!empty itm.lead}">${itm.fixSituation}</c:if>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
				<!-- 
				<input type="radio" id="${itm.id}-select" name="${itm.id}-select" checked="checked" value="1" onclick="isSelect(${itm.id});"/>是
				<input type="radio" id="${itm.id}-noSelect" name="${itm.id}-select" value="0" onclick="noSelect(${itm.id});"/>否
				 -->
				 <c:choose>
					<c:when test="${itm.fixSituation == '未启用'}">
						<input type="radio"  ondblclick="dbNoSel(this)" onclick="dbSel(this)" value="${itm.id}" />
						<a href="javascript:void(0);" style="color:blue;" onclick="isSelect('${itm.id}',0);">启用</a>
						<input type="hidden" id="${itm.id}-select" name="${itm.id}-select" value="0" />
					</c:when>
					<c:when test="${not empty itm.lead}">
						工长已确认项目状态
					</c:when>
					<c:otherwise>
						<input type="radio"  ondblclick="dbNoSel(this)" onclick="dbSel(this)" value="${itm.id}" />
						<a href="javascript:void(0);" style="color:blue;" onclick="isSelect('${itm.id}',1);">禁用</a>
						<input type="hidden" id="${itm.id}-select" name="${itm.id}-select" value="1" />
					</c:otherwise>
				</c:choose>
				</td>
				<td>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.fixEmpTime}
				<c:if test="${!empty itm.fixEmp&&empty itm.lead}"><br/><a href="javascript:void(0);" style="color:blue;" onclick="cancelZXSign(${itm.id});">取消签认</a></c:if>
				</td>
			</tr>
		</c:forEach>
     </c:forEach>
	
</table>			
</body>
</html>