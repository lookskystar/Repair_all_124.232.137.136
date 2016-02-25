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
<!-- 小辅修操作，配件查询,检查项目页面 -->
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<script type="text/javascript" src="js/jquery.anchor.1.0.js"></script>
<script type="text/javascript" src="js/table/treeTable.js"></script>
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
		top.Dialog.open({URL:"<%=basePath%>workAction!workerRatifyInput.do?type=0&xtype=${xtype}&rjhmId=${rjhmId}&ids="+ids+"&qtype="+qtype+"&role=worker",Width:420,Height:170,Title:"签名确认",ID:'frmDialog'});
	}
}

function select(jcRecId){
	$("#"+jcRecId+"check_item").attr("checked","checked");
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

//输入配件编号
function pjNumInputWith(itemName,recId){
	var planId = $('#dateplan').val();
	top.Dialog.open({MessageTitle:"检修项目:"+itemName,Title:"添加配件编号信息",URL:"<%=basePath%>work/work/pjnum_xx_dialog.jsp?xtype=${xtype}&type=0&recId="+recId+"&planId="+planId,Width:500,Height:400,ID:'frmDialog'});
}

//修改配件编号 
function pjNumUpdate(){
	var arg_length = arguments.length;
	var itemName = arguments[0];
	var recId = arguments[1];
	var planId = $('#dateplan').val();
	var upPJNum = "";
	for(var i=2; i < arg_length;i++){
		if(i != arg_length -1){
			upPJNum += arguments[i]+",";
		}else{
			upPJNum += arguments[i];
		}
	}
	top.Dialog.open({MessageTitle:"检修项目:"+itemName,Message:"",Title:"修改配件编号信息",URL:"<%=basePath%>work/work/pjnum_update_xx_dialog.jsp?xtype=${xtype}&recId="+recId+"&type=0&upPJNum="+upPJNum+"&planId="+planId,Width:500,Height:400,ID:'frmDialog'});
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
 
#allsign{
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

#newreport{
position:fixed;
margin-top:5px;
margin-left:140px;
top:0px;

_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:140px;
}
</style>
</head>
<body>
<input id="jctype"  type="hidden" value="${jctype }"/>
<input id="dateplan"  type="hidden" value="${rjhmId }" />
<button id="sign" onclick="ratify(0);" ><span class="icon_save">签名</span></button>
<button id="allsign" onclick="ratify(1);" ><span class="icon_save" title="只能全签我的项目，不能全签自选项目">全签</span></button>
<button id="newreport" ><span class="icon_print">报活</span></button>
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
		<th>检修人</th>
	</tr>
	<c:if test="${empty itemList}"><tr><td colspan="11">没有数据记录!</td></tr></c:if>
	<c:if test="${xtype==0}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas<2 && empty itm.fixEmp}"><input type="checkbox" value="${itm.jcRecId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.fixitem.secUnitName}&nbsp;${itm.fixitem.posiName}</td>
				<td>${itm.itemName}</td>
				<td>${itm.fixSituation}</td>
				<td>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.empAfformTime}</td>
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
				<td>${itm.repPosi} ${itm.repsituation}</td>
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

<div style="height:35px;">
	<div class="float_left padding5">
			共有信息${fn:length(itemList)}条。&nbsp;&nbsp;<font color="red">当前机车：${dateplan.jcType }-${dateplan.jcnum }-${dateplan.fixFreque }</font>
	</div>
	<div class="clear"></div>
</div>
 --%>
<table class="treeTable" style="text-align: center;margin-top: 30px;" initState="collapsed" id="freeItemTab">
	<%--<tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">自选检修项目&nbsp;&nbsp;<font color="red">(*自选项目不能全签)</font><button anchor="bz" id="nbz">我的检修项目</button></td></tr>--%>
	<tr><td colspan="11" style="color: red;text-align: left">已完成项目数量:<span id="finishCount"></span>&nbsp;&nbsp;总共项目数量:<span id="totalCount"></span></td></tr>
	<tr>
		<th width="20px">选择</th>
		<c:if test="${xtype==0 || xtype==2}">
			<th width="20%">部件/部位</th>
		</c:if>
		<th width="30%">检修项目</th>
		<th width="20%">检修情况</th>
		<th>检修人</th>
	</tr>
	<!-- 固定检修 -->
	<c:if test="${xtype==0 || xtype == 2}">
		<c:if test="${empty freeItem}"><tr><td colspan="11">没有数据记录!</td></tr></c:if>
	     <c:forEach var="freeItem" items="${freeItem}" varStatus="s">
		    <tr id="node-${s.index+1 }">
				<td style="width: 5%;">&nbsp;<input type="checkbox" onclick="selectChildren(${s.index+1});" id="p_${s.index+1}"/></td>
				<td colspan="4" align="left"><span class="folder">${freeItem.key }</span></td>
			</tr>
			<c:forEach var="itm" items="${freeItem.value}">
				<tr class="child-of-node-${s.index+1}">
				    <td>
					<c:choose>
						<c:when test="${itm.recStas<2}"><input type="checkbox" value="${itm.jcRecId}" class="ch_${s.index+1}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
					</td> 
					<td>${itm.fixitem.secUnitName}&nbsp;${itm.fixitem.posiName}</td>
					<td>${itm.itemName}</td>
					<td onclick="select(${itm.jcRecId});">
						<c:choose>
							<c:when test="${itm.fixSituation=='更换良好'}">
								${itm.fixSituation}<br/>
								<c:choose>
									<c:when test="${empty itm.upPjNum}">
										<a href="javascript:pjNumInputWith('${itm.itemName}','${itm.jcRecId}');" style="color: blue;">更换配件编码</a>
									</c:when>
									<c:otherwise><a href="javascript:pjNumUpdate('${itm.itemName}','${itm.jcRecId}','${itm.upPjNum }');" style="color: blue;">${itm.upPjNum }</a></c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>${itm.fixSituation}</c:otherwise>
						</c:choose>
					</td>
					<td class="fixemp">${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}${itm.empAfformTime}
					<c:if test="${!empty itm.fixEmp&&empty itm.lead}"><br/><a href="javascript:void(0);" style="color:blue;" onclick="cancelSign(${itm.jcRecId});">取消签认</a></c:if>
					</td>
				</tr>
			</c:forEach>
	     </c:forEach>
	</c:if>
	<!-- 临修加改 -->
	<c:if test="${xtype==1}">
		<c:if test="${empty freeItemList}"><tr><td colspan="10">没有数据记录!</td></tr></c:if>
		<c:forEach var="itm" items="${freeItemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas<=4}"><input type="checkbox" value="${itm.preDictId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.repPosi} ${itm.repsituation}</td>
				<td>
					<c:choose>
						<c:when test="${itm.dealSituation=='更换良好'}">
							${itm.dealSituation}<br/>
							<c:choose>
								<c:when test="${empty itm.upPjNum}">
									<a href="javascript:pjNumInputWith('${itm.repPosi} ${itm.repsituation}','${itm.preDictId}');" style="color: blue;">更换配件编码</a>
								</c:when>
								<c:otherwise><a href="javascript:pjNumUpdate('${itm.repPosi} ${itm.repsituation}','${itm.preDictId}','${itm.upPjNum }');" style="color: blue;">${itm.upPjNum }</a></c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>${itm.dealSituation}</c:otherwise>
					</c:choose>
				</td>
				<td class="fixemp">${fn:substring(itm.dealFixEmp,1,fn:length(itm.dealFixEmp)-1)}${itm.fixEndTime}</td>
			</tr>
		</c:forEach>
	</c:if>
	<!-- 秋整春鉴 -->
	<%--
	<c:if test="${xtype==2}">
		<c:if test="${empty freeItem}"><tr><td colspan="11">没有数据记录!</td></tr></c:if>
	     <c:forEach var="freeItem" items="${freeItem}" varStatus="s">
		    <tr id="node-${s.index+1 }">
				<td>&nbsp;</td>
				<td colspan="4" align="left"><span class="folder">${freeItem.key }</span></td>
			</tr>
			<c:forEach var="itm" items="${freeItem.value}">
				<tr class="child-of-node-${s.index+1}">
					<td>
						<c:choose>
							<c:when test="${itm.recStas<2 && empty itm.fixEmp}"><input type="checkbox" value="${itm.jcRecId}" name="check_item" id="check_item"/></c:when>
							<c:otherwise>&nbsp;</c:otherwise>
						</c:choose>
					</td>
					<td>${itm.items.unitName}</td>
					<td>${itm.itemName}</td>
					<td>
						<c:choose>
							<c:when test="${itm.dealSituation=='更换良好'}">
								${itm.dealSituation}<br/>
								<c:choose>
									<c:when test="${empty itm.upPjNum}">
										<a href="javascript:pjNumInputWith('${itm.itemName}','${itm.jcRecId}');" style="color: blue;">更换配件编码</a>
									</c:when>
									<c:otherwise><a href="javascript:pjNumUpdate('${itm.itemName}','${itm.jcRecId}','${itm.upPjNum }');" style="color: blue;">${itm.upPjNum }</a></c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>${itm.dealSituation}</c:otherwise>
						</c:choose>
					</td>
					<td class="fixemp">${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}${itm.empAfformTime}</td>
				</tr>
			</c:forEach>
	     </c:forEach>
	</c:if>
	 --%>
</table>
</body>
</html>