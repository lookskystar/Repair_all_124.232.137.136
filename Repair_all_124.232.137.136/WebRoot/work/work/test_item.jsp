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
<script type="text/javascript" src="js/menu/contextmenu.js"></script>
<script type="text/javascript" src="js/enterNext.js"></script>
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
    
    var option = { width: 150, items: 
    			[
                    { text: "阿拉伯数字", icon: "images/icons/ico4.gif", alias: "1-1", type: "group", width: 170, items: 
                    	[
	                        { text: "Ⅰ", icon: "images/icons/ico1.gif", alias: "Ⅰ", action: function(target){ $("#"+ target.id +"").val(this.data.alias) ;} },
		                    { text: "Ⅱ", icon: "images/icons/ico1.gif", alias: "Ⅱ", action: function(target){ $("#"+ target.id +"").val(this.data.alias) ;} },
		                    { text: "Ⅲ", icon: "images/icons/ico1.gif", alias: "Ⅲ", action: function(target){ $("#"+ target.id +"").val(this.data.alias) ;} },
		                    { text: "Ⅲ", icon: "images/icons/ico1.gif", alias: "Ⅳ", action: function(target){ $("#"+ target.id +"").val(this.data.alias) ;} },
		                    { text: "Ⅲ", icon: "images/icons/ico1.gif", alias: "Ⅴ", action: function(target){ $("#"+ target.id +"").val(this.data.alias) ;} }
                    	]
                    },
                    { type: "splitLine" },
                    { text: "特殊符号", icon: "images/icons/ico4.gif", alias: "1-2", type: "group", width: 170, items: 
                    	[
	                        { text: "∞", icon: "images/icons/ico1.gif", alias: "∞", action: function(target){ $("#"+ target.id +"").val(this.data.alias) ;} }
                    	]
                    }
                 ]
    };
   
    $(".target").contextmenu(option);
    
    var totalCount = 0;
    var finishCount = 0;
    //统计未完成项目
   	$("[class='fixemp']").each(function(){
   		var fixemp = $(this).html();
   		totalCount = totalCount + 1;
   		if(fixemp != "" && fixemp != null) finishCount ++;
   	})
   	$("#finishCount").html(finishCount);
   	$("#totalCount").html(totalCount);
})

function select(jcRecId){
	$("#"+ jcRecId +"-test_item").attr("checked","checked");
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
		$.post("workAction!ajaxEnableFixItems.do",{"recIds":ids,"flag":flag},function(data){
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
			$.post("workAction!ajaxEnableFixItems.do",{"recIds":ids,"flag":flag},function(data){
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
			$.post("workAction!ajaxEnableFixItems.do",{"recIds":ids,"flag":flag},function(data){
				if(data == "success"){
					top.Dialog.alert("一键"+selDetail+"项目成功！");
					window.location.reload();
				}
			})
		});
	}
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
			length += 1;
		}
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
				if((itemValue != null && itemValue  != "" 
					&& itemValue != undefined 
					&& parseInt(itemValue) >= parseInt(itemMinValue) 
					&& parseInt(itemValue) <= parseInt(itemMaxValue)) || itemValue == "∞"){
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
				url:'workAction!workerRatify.action',
				data:{"type":"1","qtype":"0","xtype":xtype,"rjhmId":rjhmId,"role":"worker","itemString":itemString},
				success:function(data){
					var datas=eval("("+data+")");
					var result = datas.result;
					var fixEmp = datas.fixEmp;
					var time = datas.times;
					if("success"==result){
						$.messager.show(0,'签认成功!');
						$("input[name='test_item']:checked").each(function(){
				        	var idValue = $(this).val();
				        	$("#fixEmp-"+idValue).html(fixEmp+"&nbsp;"+time);
				        })
					}else{
						$.messager.show(0,'签认失败 !');
					}
					$("input[name='test_item']:checked").each(function(){
			        	$(this).attr("checked",false);
			        })
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

//撤销项目签认
function cancelSign(jcRecId){
	top.Dialog.confirm("确定要取消项目签认吗?",function(){
		$.post("<%=basePath%>workAction!cancelSign.do",{"jcRecId":jcRecId},function(data){
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
//双击取消选择的单选按钮 ，唐倩 2016-6-29
function dbNoSel(obj){
	$(obj).attr("checked",false);
}
function dbSel(obj){
	$(obj).attr("checked",true);
}
</script>
<style type="text/css">
*html{
 background-image:url(about:blank);
 background-attachment:fixed;
 }
 
#sign{
  position:fixed;
  margin-top:5px;
  margin-left:5px;
  top:0px;
  
 _position:absolute;
 _bottom:auto;
 _top:expression(eval(document.documentElement.scrollTop));
 _margin-top:5px;
 _margin-left:5px;
 }
 
#newreport{
position:fixed;
margin-top:5px;
margin-left:70px;
top:0px;

_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:70px;
}
#keyactivated{
position:fixed;
margin-top:5px;
margin-left:135px;
top:0px;

_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:135px;
}
#activated{
position:fixed;
margin-top:5px;
margin-left:228px;
top:0px;

_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:228px;
}
#keybanned{
position:fixed;
margin-top:5px;
margin-left:292px;
top:0px;

_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:292px;
}
#banned{
position:fixed;
margin-top:5px;
margin-left:384px;
top:0px;

_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:384px;
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
<table class="tableStyle" style="text-align: center;margin-top: 30px;" id="testItemTab" useMultColor="true"  useCheckBox="true"> 
	<tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">我的检修项目<button anchor="nbz" id="bz">自选检修项目</button></td></tr>
	<tr>
		<th width="30px">选择</th>
		<th width="20%">工位</th>
		<th width="30%">检修项目</th>
		<th width="18%">检修情况(检测值)</th>	
		<th width="10%">是否启用</th>
		<th width="32%">检修人</th>
	</tr>
	<c:if test="${empty itemList}"><tr><td colspan="11">没有数据记录!</td></tr></c:if>
	<c:forEach var="itm" items="${itemList}">
		<tr>
			<td>
				<c:choose>
					<c:when test="${itm.recStas<2 && empty itm.fixEmp}"><input type="checkbox" value="${itm.jcRecId}" name="test_item" id="${itm.jcRecId}-test_item"/></c:when>
					<c:otherwise>&nbsp;</c:otherwise>
				</c:choose>
			</td>
			<td>${itm.fixitem.secUnitName}&nbsp;${itm.fixitem.posiName}</td>
			<td>${itm.itemName}</td>
			<td>
				<input type="hidden" id="${itm.jcRecId}-max" value="${itm.fixitem.max}" />
				<input type="hidden" id="${itm.jcRecId}-min" value="${itm.fixitem.min}"/>
				<div id="target"><input type="text" id="${itm.jcRecId}" value="${itm.fixSituation}"/></div>
			</td>
			<td><input type="radio" name="${itm.jcRecId}-select" checked="checked" value="1"/>是
				<input type="radio" name="${itm.jcRecId}-select" value="0" onclick="noSelect(${itm.jcRecId});"/>否
			</td>
		<td>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.empAfformTime}</td>
		</tr>
	</c:forEach>
</table>

<div style="height:35px;">
	<div class="float_left padding5">
		共有信息${fn:length(itemList)}条。&nbsp;&nbsp;<font color="red">当前机车：${dateplan.jcType }-${dateplan.jcnum }-${dateplan.fixFreque }</font>
	</div>
	<div class="clear"></div>
</div>	
 --%>
<table class="treeTable" style="text-align: center;margin-top: 30px;" initState="collapsed" id="freeItemTab">
	<%--<tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">自选检测项目<button anchor="bz" id="nbz">我的检修项目</button></td></tr> --%>
	<tr><td colspan="11" style="color: red;text-align: left">已完成项目数量:<span id="finishCount"></span>&nbsp;&nbsp;总共项目数量:<span id="totalCount"></span></td></tr>
	<tr>
		<th width="20px">选择</th>
		<th width="20%">部件/部位</th>
		<th width="30%">检修项目</th>
		<th width="20%">检修情况(检测值)</th>
		<th width="10%">是否启用</th>
		<th width="30%">检修人</th>
	</tr>
	<c:if test="${empty freeItem}"><tr><td colspan="6">没有数据记录!</td></tr></c:if>
	<!-- 固定检修 -->
     <c:forEach var="freeItem" items="${freeItem}" varStatus="s">
	    <tr id="node-${s.index+1 }">
			<td style="width: 5%;">&nbsp;<input type="checkbox" onclick="selectChildren(${s.index+1});" id="p_${s.index+1}"/></td>
			<td colspan="5" align="left"><span class="folder">${freeItem.key }</span></td>
		</tr>
		<c:forEach var="itm" items="${freeItem.value}">
			<tr class="child-of-node-${s.index+1}">
			    <td>
			    <c:choose>
					<c:when test="${(itm.recStas<2 && empty itm.fixEmp) || empty itm.lead }"><input type="checkbox" value="${itm.jcRecId}" class="ch_${s.index+1}" name="test_item" id="${itm.jcRecId}-test_item"/></c:when>
					<c:otherwise>&nbsp;</c:otherwise>
				</c:choose>
				</td> 
				<td>${itm.fixitem.secUnitName}&nbsp;${itm.fixitem.posiName}</td>
				<td>${itm.itemName}</td>
				<td align="left" onclick="select(${itm.jcRecId});">
					<input type="hidden" id="${itm.jcRecId}-max" value="${itm.fixitem.max}" />
					<input type="hidden" id="${itm.jcRecId}-min" value="${itm.fixitem.min}" />
					<!-- <input type="text" id="${itm.jcRecId}" name="fixSituation" value="${itm.fixSituation}" class="target"/> ${itm.fixitem.unit} -->
					<!-- 唐倩 2015-6-29 -->
					<c:choose>
							<c:when test="${!empty itm.fixEmp && itm.fixSituation == '未启用'}">
								<span>未启用</span>
							</c:when>
							<c:otherwise>
							    <c:if test="${empty itm.lead}">
									<input type="text" name="fixSituation" id="${itm.jcRecId}" value="${itm.fixSituation}"  class="target"/> ${itm.fixitem.unit}
								</c:if>
								<c:if test="${!empty itm.lead}">${itm.fixSituation}</c:if>
							</c:otherwise>
					</c:choose>
				</td>
				<td>
				<!-- <input type="radio" id="${itm.jcRecId}-select" name="${itm.jcRecId}-select" checked="checked" value="1" onclick="isSelect(${itm.jcRecId});"/>是
				<input type="radio" id="${itm.jcRecId}-noSelect" name="${itm.jcRecId}-select" value="0" onclick="noSelect(${itm.jcRecId});"/>否
				 -->
				<c:choose>
					<c:when test="${itm.fixSituation == '未启用'}">
						<input type="radio" ondblclick="dbNoSel(this)" onclick="dbSel(this)" value="${itm.jcRecId}" />
						<a href="javascript:void(0);" style="color:blue;" onclick="isSelect('${itm.jcRecId}',0);">启用</a>
						<input type="hidden" id="${itm.jcRecId}-select" name="${itm.jcRecId}-select" value="0" />
					</c:when>
					<c:when test="${not empty itm.lead}">
						工长已确认项目状态
					</c:when>
					<c:otherwise>
						<input type="radio"  ondblclick="dbNoSel(this)" onclick="dbSel(this)" value="${itm.jcRecId}" />
						<a href="javascript:void(0);" style="color:blue;" onclick="isSelect('${itm.jcRecId}',1);">禁用</a>
						<input type="hidden" id="${itm.jcRecId}-select" name="${itm.jcRecId}-select" value="1" />
					</c:otherwise>
				</c:choose>
				</td>
				<td id="fixEmp-${itm.jcRecId}" class="fixemp">${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}${itm.empAfformTime}
				<c:if test="${!empty itm.fixEmp&&empty itm.lead}"><br/><a href="javascript:void(0);" style="color:blue;" onclick="cancelSign(${itm.jcRecId});">取消签认</a></c:if>
				</td>
			</tr>
		</c:forEach>
     </c:forEach>
</table>			
</body>
</html>