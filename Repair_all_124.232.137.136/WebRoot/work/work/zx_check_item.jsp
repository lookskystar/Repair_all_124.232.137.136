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
<script type="text/javascript" src="js/zk.textSelect.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
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
//签名
function ratify(qtype){
	var fixRecIds=[];
   $("input[name='check_item']:checked").each(function(){
	   fixRecIds.push($(this)[0].value);
   });
   if(fixRecIds.length==0 && qtype==0){
		top.Dialog.alert("请选择签认的项目!");
	}else{
		var ids = ""+fixRecIds.join("-");
		top.Dialog.open({URL:"<%=basePath%>workAction!workerZxRatifyInput.do?type=0&xtype=${xtype}&rjhmId=${rjhmId}&ids="+ids+"&qtype="+qtype+"&role=worker",Width:425,Height:300,Title:"签名确认",ID:'frmDialog'});
	}
}

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

//定位锚点---20150514 ning
$(function(){
	window.location.hash = "#"+$("#zx_status").val()+"";
});

//输入配件编号
function pjNumInputWith(itemName,zxRecId,amount,stdPjId){
	var planId = $('#dateplan').val();
	top.Dialog.open({MessageTitle:"检修项目:"+itemName+"  需添加配件数量:"+amount,Message:"",Title:"添加配件编号信息",URL:"<%=basePath%>workAction!pjNumInput.do?zxRecId="+zxRecId+"&type=1&stdPjId="+stdPjId+"&planId="+planId,Width:500,Height:400,ID:'frmDialog'});
}

//修改配件编号 
function pjNumUpdate(){
	var arg_length = arguments.length;
	var itemName = arguments[0];
	var zxRecId = arguments[1];
	var amount = arguments[2];
	var stdPjId = arguments[3];
	var planId = $('#dateplan').val();
	var upPJNum = "";
	for(var i=4; i < arg_length;i++){
		if(i != arg_length -1){
			upPJNum += arguments[i]+",";
		}else{
			upPJNum += arguments[i];
		}
	}
	top.Dialog.open({MessageTitle:"检修项目:"+itemName+"  需添加配件数量:"+amount,Message:"",Title:"修改配件编号信息",URL:"<%=basePath%>workAction!pjNumUpdateInput.do?zxRecId="+zxRecId+"&type=1&stdPjId="+stdPjId+"&upPJNum="+upPJNum+"&planId="+planId,Width:500,Height:400,ID:'frmDialog'});
}

//输入裂损情况
function dealSituation(id){
	top.Dialog.open({URL:"<%=basePath%>work/work/zxts_ratify_dialog.jsp?role=worker&type=0&id="+id,Width:425,Height:300,Title:"裂损情况"});
}

//复探签字
function reptSign(){
	var fixRecIds=[];
	var id;
	var flag = true;
   $("input[name='check_item']:checked").each(function(){
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
		$.post("<%=basePath%>workAction!reptJCFixRecSign.do",{"ids":ids},function(text){
			top.Dialog.alert("操作成功!",function(){
				window.location.reload();
				top.Dialog.close();
			})
		});
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
//取消复探签认 唐倩 2015-6-29
function cancelZXReptSign(jcRecId){
	top.Dialog.confirm("确定要取消复探签认吗?",function(){
		$.post("<%=basePath%>workAction!cancelZXReptSign.do",{"jcRecId":jcRecId},function(data){
			if(data=="success"){
				top.Dialog.alert("复探取消签认成功",function(){
					window.location.reload();
					top.Dialog.close(); 
				});
			}else if(data=="no_user"){
				top.Dialog.alert("没有权限!");
			}else{
				top.Dialog.alert("复探取消签认失败!");
			}
		});
	});
}
//项目禁用
function noSelect(recId){
	top.Dialog.confirm("确认禁用？",function(){
		$.post("workAction!ajaxEnableZxFixItem.do",{"recId":recId},function(data){
			if(data == "success"){
				top.Dialog.alert("项目禁用成功！");
				window.location.reload();
			}
		})
	});
}
//项目一键禁用 ，唐倩 2016-6-24 
function keyNoSelects(){
	var recIds = [];
	$("input:radio").each(function(){
       	var idValue = $(this).val();
       	recIds.push(idValue);
       })
	
	if(recIds.length==0){
		top.Dialog.alert("没有可禁用的项目？");
		return;
	}else{
		top.Dialog.confirm("确定要一键禁用所有项目？",function(){
			var ids = ""+recIds.join("-");
			$.post("workAction!ajaxEnableZxFixItems.do",{"recIds":ids},function(data){
				if(data == "success"){
					top.Dialog.alert("一键禁用成功！");
					window.location.reload();
				}
			})
		});
	}
}
//项目禁用 ，唐倩 2016-6-24
function noSelects(){
	var recIds = [];
	$("input:radio:checked").each(function(){
       	var idValue = $(this).val();
       	recIds.push(idValue);
       })
	
	if(recIds.length==0){
		top.Dialog.alert("请选择要禁用的项目？");
		return;
	}else{
		top.Dialog.confirm("确定要禁用所选项目？",function(){
			var ids = ""+recIds.join("-");
			$.post("workAction!ajaxEnableZxFixItems.do",{"recIds":ids},function(data){
				if(data == "success"){
					top.Dialog.alert("项目禁用成功！");
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
//签名
function batchRatify(){
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
	$("input[name='check_item']").each(function(){
		//判断是否选中
		if ($(this).attr("checked")) { 
			//只要有一个被选择 设置为 true
			flagSelect = true; 
			length += 1;
		}
	})
	if(flagSelect){
		var i = 1;
		$("input[name='check_item']:checked").each(function(){
			var idValue = $(this).val();
		    var itemValue = $("#"+ idValue +"-checkinfo").attr("editValue");
			if(itemValue != null && itemValue  != "" 
				&& itemValue != undefined ){
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
			}else{
				flagRatify = false;
				top.Dialog.alert("错误的输入值！");
				return false;
			}
		});
		itemString += "}";
		if(flagRatify){
			$.ajax({
				type:'post',
				url:'workAction!workerZxRatify.action',
				data:{"type":"0","qtype":"0","xtype":${xtype},"rjhmId":${rjhmId},"role":"worker","itemString":itemString},
				success:function(data){
					var datas=eval("("+data+")");
					var success = datas.success;
					var fixEmp = datas.fixEmp;
					var time = datas.time;
					if(success){
						$.messager.show(0,'签认成功!');
						$("input[name='check_item']:checked").each(function(){
				        	var idValue = $(this).val();
				        	var str = ""+ fixEmp +"</br>";
				        	str += ""+ time +"</br>";
				        	str += "<a href='javascript:void(0);' style='color:blue;' onclick='cancelZXSign("+ idValue +");'>取消签认</a>";
				        	$("#"+ idValue +"-fixemp").append(str);
				        })
					}else{
						$.messager.show(0,'签认失败 !');
					}
					$("input[name='check_item']:checked").each(function(){
			        	$(this).attr("checked",false);
			        })
				}
			}); 
		}
	}else{
		top.Dialog.alert("请选择要签认的项目！");
	}
	
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
 #sign1{
 _position:absolute;
 _bottom:auto;
 _top:expression(eval(document.documentElement.scrollTop));
 _margin-top:5px;
 _margin-left:65px;
 }
#allsign{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:95px;
}

#newreport{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:185px;
}
#keybanned{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:247px;
}
#banned{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:337px;
}

#newreport1{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:155px;
}
#keybanned1{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:217px;
}
#banned1{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:307px;
}

#freeItemTab{
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:30px;
}

</style>
</head>
<body>
<input id="zx_status" type="hidden" value="${zx_status_flag}"/>
<input id="jctype"  type="hidden" value="${jctype }"/>
<input id="dateplan"  type="hidden" value="${rjhmId }"/>

<c:choose>
	<c:when test="${tsflag==1}">
		<button id="sign" onclick="ratify(0);" ><span class="icon_save">主探签名</span></button>
		<button id="allsign" onclick="reptSign();" ><span class="icon_save">复探签名</span></button>
		<button id="newreport" ><span class="icon_print">报活</span></button>
		<button id="keybanned" onclick="keyNoSelects();"><span class="icon_no">一键禁用</span></button>
		<button id="banned" onclick="noSelects();"><span class="icon_no">禁用</span></button>
	</c:when>
	<c:otherwise>
		<button id="sign" onclick="ratify(0);" ><span class="icon_save">签名</span></button>
		<button id="sign1" onclick="batchRatify();" ><span class="icon_save">自选签认</span></button>
		<button id="newreport1" ><span class="icon_print">报活</span></button>
		<button id="keybanned1" onclick="keyNoSelects();"><span class="icon_no">一键禁用</span></button>
		<button id="banned1" onclick="noSelects();"><span class="icon_no">禁用</span></button>
	</c:otherwise>
</c:choose>

<!-- 
<button id="allsign" onclick="ratify(1);" ><span class="icon_save" title="只能全签我的项目，不能全签自选项目">全签</span></button>
 -->

<%--
<table class="tableStyle" style="text-align: center;margin-top: 30px;" id="checkItemTab">
	<tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">我的检修项目<button anchor="nbz" id="bz">自选检修项目</button></td></tr>
	<tr>
		<th width="10px">选择</th>
		<c:if test="${xtype==0 || xtype==2}">
			<th width="20%">部件/部位</th>
		</c:if>
		<th width="30%">检修项目</th>
		<th width="20%">检修情况</th>
		<th width="30%">检修人</th>
	</tr>
	<c:if test="${empty itemList}"><tr><td colspan="11">没有数据记录!</td></tr></c:if>
	<c:if test="${xtype==0}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas<2 && empty itm.fixEmp}"><input type="checkbox" value="${itm.id}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.itemId.unitName}  ${itm.itemId.posiName}</td>
				<td>${itm.itemName}</td>
				<td>${itm.fixSituation}</td>
				<td>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.fixEmpTime}</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${xtype==1}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas<=4}"><input type="checkbox" value="${itm.preDictId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.repsituation}</td>
				<td>${itm.dealSituation}</td>
				<td>${fn:substring(itm.dealFixEmp,1,fn:length(itm.dealFixEmp)-1)}&nbsp;${itm.fixEndTime}</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${xtype==2}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas<2 && empty itm.fixEmp}"><input type="checkbox" value="${itm.jcRecId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.items.unitName}</td>
				<td>${itm.itemName}</td>
				<td>${itm.fixSituation}</td>
				<td>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.empAfformTime}</td>
			</tr>
		</c:forEach>
	</c:if>
</table>

<div>
	<div class="float_left padding5">
		共有信息${fn:length(itemList)}条。&nbsp;&nbsp;<font color="red">当前机车：${dateplan.jcType }-${dateplan.jcnum }-${dateplan.fixFreque }</font>
	</div>
	<div class="clear"></div>
</div>
 --%>

<table class="treeTable" style="text-align: center;" id="freeItemTab">
	<tr><th colspan="11" align="left" style="color: red;">
		当前机车：${dateplan.jcType }-${dateplan.jcnum }-${dateplan.fixFreque }
		<%-- 自选检修项目&nbsp;&nbsp;<font color="red">(*自选项目不能全签)</font><button anchor="bz" id="nbz">我的检修项目</button>--%>
		</th></tr>
	<tr>
		<th width="20px">选择</th>
		<c:if test="${xtype==0 || xtype==2}">
			<th width="15%">部件/部位</th>
		</c:if>
		<th width="29%">检修项目</th>
		<c:choose>
			<c:when test="${tsflag==1}">
				<th width="13%">探伤结果</th>
				<th width="13%">裂损情况</th>
				<th width="15%">主探</th>
				<th width="15%">复探</th>
			</c:when>
			<c:otherwise>
				<th width="21%">配件编号</th>
				<th width="20%">检修情况</th>
				<th width="15%">检修人</th>
			</c:otherwise>
		</c:choose>
	</tr>
	<c:if test="${empty freeItem}"><tr><td colspan="11">没有数据记录!</td></tr></c:if>
	<!-- 固定检修 -->
	<c:if test="${xtype==0}">
	     <c:forEach var="freeItem" items="${freeItem}" varStatus="s">
		    <tr id="node-${s.index+1 }">
				<td>&nbsp;<input type="checkbox" onclick="selectChildren(${s.index+1});" id="p_${s.index+1}"/></td>
				<td colspan="6" align="left"><span class="folder">${freeItem.key }</span></td>
			</tr>
			<c:forEach var="itm" items="${freeItem.value}">
				<tr class="child-of-node-${s.index+1}">
				    <td>
					<c:choose>
						<c:when test="${empty itm.itemId.amount}">
							<c:choose>
								<c:when test="${itm.recStas<2 }">
									<input type="checkbox" value="${itm.id}" class="ch_${s.index+1}" name="check_item" id="${itm.id}-check_item"/>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${not empty itm.itemId.amount}">
							<c:choose>
								<c:when test="${itm.recStas<2 && not empty itm.upPjNum}">
									<input type="checkbox" value="${itm.id}" class="ch_${s.index+1}" name="check_item" id="${itm.id}-check_item"/>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:when>
					</c:choose>
					</td> 
					<td>${itm.itemId.posiName} ${itm.itemId.unitName}</td>
					<td style="white-space:normal;word-break:break-all;word-wrap:break-word;">${itm.itemName}</td>
					<c:choose>
					  	<c:when test="${tsflag==1}">
					  		<td>${itm.fixSituation}</td>
							<td>
								<c:if test="${empty itm.dealSituation}">
									<a href="javascript:void(0);" style="color:blue;" onclick="dealSituation('${itm.id}')">输入裂损情况</a>
								</c:if>
								<c:if test="${!empty itm.dealSituation}">
									<a href="javascript:void(0);" style="color:blue;" onclick="dealSituation('${itm.id}')">${itm.dealSituation}</a>
								</c:if>
							</td>
							<td>
								${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${fn:substring(itm.fixEmpTime,0,fn:length(itm.fixEmpTime)-3)}
								<input type="hidden" id="${itm.id}_fixemp" value="${itm.fixEmpTime}"/>
								<c:if test="${!empty itm.fixEmp}">
									<br/><a href="javascript:void(0);" style="color:blue;" onclick="cancelZXSign(${itm.id});">取消签认</a>
								</c:if>
							</td>
							<td>
								<c:choose>
									<c:when test="${empty itm.reptAffirmTime && itm.itemId.itemCtrlRept==1}">
										<span style="color: red;">待签</span>
									</c:when>
									<c:otherwise>${itm.rept}&nbsp;${fn:substring(itm.reptAffirmTime,0,fn:length(itm.reptAffirmTime)-3)}
									<c:if test="${!empty itm.rept}">
									<br/><a href="javascript:void(0);" style="color:blue;" onclick="cancelZXReptSign(${itm.id});">取消签认</a>
								</c:if>
									</c:otherwise>
								</c:choose>
							</td>
					  	</c:when>
					  	<c:otherwise>
					  		<td style="white-space:normal;word-break:break-all;word-wrap:break-word;">
					  			<c:if test="${itm.nodeId==101}">
								    <c:if test="${empty itm.upPjNum&&empty itm.downPjNum}">
								    	<c:choose>
									    	<c:when test="${not empty itm.itemId.amount && empty itm.fixSituation }" >
									    		<a id="${itm.itemId.stdPJId}" href="javascript:void(0);" style="color:blue;" onclick="pjNumInputWith('${itm.itemName}','${itm.id}','${itm.itemId.amount }','${itm.itemId.stdPJId}');">点击输入</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									    		
									    	</c:when>
									    	<c:otherwise>	
									    		<font>/</font>
									    	</c:otherwise>
								      	</c:choose>
								   </c:if>
								   <c:if test="${!empty itm.upPjNum}"><font title="点击修改配件编码"><a id="${itm.itemId.stdPJId}" href="javascript:void(0);" style="color:blue;" onclick="pjNumUpdate('${itm.itemName}','${itm.id}','${itm.itemId.amount }','${itm.itemId.stdPJId}','${itm.upPjNum }');">${itm.upPjNum}</a></font></c:if>
								 </c:if>
								 <c:if test="${itm.nodeId==100}">--</c:if>
							</td>
							<td>
							<c:choose>
								<c:when test="${not empty itm.itemId.amount &&empty itm.upPjNum && empty itm.fixSituation }">
									<input type="radio" id="${itm.id}-noSelect" name="${itm.id}-select" value="${itm.id}" ondblclick="dbNoSel(this);"/><a href="javascript:void(0);" style="color:blue;" onclick="noSelect('${itm.id}');">禁用</a>
								</c:when>
								<c:when test="${empty itm.fixSituation}">
									<select id="${itm.id}-checkinfo" editable="true" style="width: 150px;" autoWidth="true">
								    	<option value="完成">完成</option>
									    <option value="良好">良好</option>
									    <option value="更换良好">更换良好</option>
									    <option value="检修良好">检修良好</option>
									    <option value="清洗良好">清洗良好</option>
									    <option value="处理后探伤良好">处理后探伤良好</option>
									    <option value="没有启用">没有启用</option>
								 	</select>
								</c:when>
								<c:otherwise>
									<font>${itm.fixSituation}</font>
								</c:otherwise>
							</c:choose>
							</td>
							<td id="${itm.id}-fixemp">
								${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}<br/>
								${fn:substring(itm.fixEmpTime,0,fn:length(itm.fixEmpTime)-3)}
								<c:if test="${!empty itm.fixEmp&&empty itm.lead}">
									<br/><a href="javascript:void(0);" style="color:blue;" onclick="cancelZXSign(${itm.id});">取消签认</a>
								</c:if>
							</td>
					  	</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
	     </c:forEach>
	</c:if>
	
</table>
</body>
</html>