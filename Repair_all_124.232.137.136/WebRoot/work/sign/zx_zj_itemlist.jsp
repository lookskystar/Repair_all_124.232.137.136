<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>左侧菜单</title>
<!--框架必需start-->
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<script type="text/javascript" src="js/jquery.anchor.1.0.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="js/table/treeTable.js"></script>
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
		$.post("<%=basePath%>signWorkAction!signZxWork.do",
				{"ids":ids,"rtype":"${rtype}","xtype":"${xtype}","qtype":qtype,"rjhmId":"${rjhmId}"},
				function(text){
					if(text=="login_failure"){
						top.Dialog.alert("不存在该用户!");
					}else if(text=="noprivilege_failure"){
						top.Dialog.alert("没有权限或没有可签项目!");
					}else if(text=="failure"){
						top.Dialog.alert("签名失败!");
					}else if(text=="working"){
						top.Dialog.alert("工长未签完!");
					}else{
						top.Dialog.alert("签名成功!",function(){
							//top.frames[2].location.reload();
							//top.Dialog.close();
							 top.frmright.frames[0].location.reload();
							 top.Dialog.close();
						});
					}
				}
		);
	}
}

var getItem=function(teamId,id){
   var rjhmId="${rjhmId}";
   var xtype="${xtype}";
   $.post("<%=basePath%>signWorkAction!ajaxGetZxBzItem.do",{"teamId":teamId,"rjhmId":rjhmId,"xtype":xtype},function(data){
        var result=eval("("+data+")");
        var datas=result.datas;
        var str="";
        if(datas.length>0){
            for(var i=0;i<datas.length;i++){
                str+="<tr class=child-of-node-"+teamId+">";
                if(parseData(datas[i].qi)==""&&datas[i].recstatus>=2){
                	str+="<td><input type='checkbox' value="+datas[i].jcRecId+" name='check_item' class='ch_"+id+"'/></td>";
                }else{
                    str+="<td></td>";
                }
                if(xtype==0){
	                str+="<td>"+parseData(datas[i].secUnitName)+" "+parseData(datas[i].posiName)+"</td>";
                }
                str+="<td>"+parseData(datas[i].itemName)+"</td>";
                str+="<td>"+parseData(datas[i].fixSituation)+"</td>";
                str+="<td>"+parseEmpData(datas[i].fixEmp,1)+"&nbsp;"+parseData(datas[i].empAfformTime)+"</td>";
                str+="<td>"+parseEmpData(datas[i].lead,0)+"&nbsp;"+parseData(datas[i].ldAffirmTime)+"</td>";
                if(datas[i].itemCtrlQI==1){
                    str+="<td>"+parseEmpData(datas[i].qi,0)+"&nbsp;"+parseData(datas[i].qiAffiTime)+"</td>";
                }else{
                    str+="<td>"+parseData(datas[i].qi)+"&nbsp;"+parseData(datas[i].qiAffiTime)+"</td>";
                }
                if(datas[i].itemCtrlTech==1){
                     str+="<td>"+parseEmpData(datas[i].tech,0)+"&nbsp;"+parseData(datas[i].techAffiTime)+"</td>";
                }else{
                     str+="<td>"+parseData(datas[i].tech,0)+"&nbsp;"+parseData(datas[i].techAffiTime)+"</td>";
                }
                str+="<td>"+parseData(datas[i].commitLead)+"&nbsp;"+parseData(datas[i].comLdAffiTime)+"</td>";
                if(datas[i].itemCtrlAcce==1){
                    str+="<td>"+parseEmpData(datas[i].accepter,0)+"&nbsp;"+parseData(datas[i].acceAffiTime)+"</td>";
                }else{
                    str+="<td>"+parseData(datas[i].accepter)+"&nbsp;"+parseData(datas[i].acceAffiTime)+"</td>";
                }
                //str+="<td>"+parseData(datas[i].accepter)+"&nbsp;"+parseData(datas[i].acceAffiTime)+"</td>";
                str+="</tr>";
            }
        }else{
            str+="<tr class=child-of-node-"+teamId+"><td></td><td colspan='9'>没有数据记录!</td></tr>";
        }
        $(".child-of-node-"+teamId).replaceWith(str);
        $("#itemRadio_"+id).remove();
   });
}

function parseData(data){
	if(data==undefined||data==null||data==""){
		return "";
	}else{
		return data;
	}
}

function parseEmpData(data,type){
	if(data==undefined||data==null||data==""){
	    return "<font color='red'>待签</font>";
	}else{
		if(type==1){//工人
			return data.substring(1,data.length-1);
		}else{
			return data;
		}
	}
}

$(function(){
    $("#bz").zxxAnchor({
    	anchorSmooth: false                       
    });
    $("#nbz").zxxAnchor({
    	anchorSmooth: false                       
    });
});

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
 
#allsign{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:75px;
}

#newreport{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:75px;
}
#nbz{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:145px;
}
</style>
</head>
<body>
<input id="dateplan"  type="hidden" value="${rjhmId }">
<input id="jctype"  type="hidden" value="${jctype }">
<button id="sign" onclick="ratify(0);" ><span class="icon_save">签名</span></button>
<!-- 
<button id="allsign" onclick="ratify(1);" ><span class="icon_save">全签</span></button>
 -->
<button id="newreport" ><span class="icon_print">报活</span></button>
<button anchor="bz" id="nbz">签认项目</button>
<%-- 
<table class="tableStyle" style="text-align: center;margin-top: 30px;" id="checkItemTab">
    <tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;">签认项目<button anchor="nbz" id="bz">自选签认项目</button></td></tr>
	<tr>
		<th width="30px">选择</th>
		<c:if test="${xtype==0}">
			<th width="15%">部件/部位</th>
		</c:if>
		<th width="20%">检修内容/项目名称</th>
		<th width="5%">检修情况</th>
		<th width="15%">检修人</th>
		<th width="15%">工长</th>
		<th width="15%">质检员</th>
		<th width="10%">技术员</th>
		<th width="10%">交车工长</th>
		<th width="15%">验收员</th>
	</tr>
	<c:if test="${empty itemList}"><tr><td colspan="10">没有数据记录!</td></tr></c:if>
	<c:if test="${xtype==0}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas>=2 && empty itm.qi}">
							<input type="checkbox" value="${itm.jcRecId}" name="check_item" id="check_item"/>
						</c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.fixitem.secUnitName}&nbsp;${itm.fixitem.posiName}</td>
				<td>${itm.itemName}</td>
				<td>${itm.fixSituation}${itm.fixitem.unit}</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.fixEmp}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.empAfformTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.lead}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${itm.lead}&nbsp;${itm.ldAffirmTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${(empty itm.qi && itm.fixitem.itemCtrlQI==1)&&(empty itm.tech)}"><font color="#ff0000">待签</font></c:when>
						<c:when test="${(empty itm.qi && itm.fixitem.itemCtrlQI==0)&&(empty itm.tech)}">/</c:when>
						<c:otherwise>${itm.qi}&nbsp;${itm.qiAffiTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${(empty itm.qi)&&(empty itm.tech && itm.fixitem.itemCtrlTech==1)}"><font color="#ff0000">待签</font></c:when>
						<c:when test="${(empty itm.qi)&&(empty itm.tech && itm.fixitem.itemCtrlTech==0)}">/</c:when>
						<c:otherwise>${itm.tech}&nbsp;${itm.techAffiTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.commitLead && itm.fixitem.itemCtrlComLd==1}"><font color="#ff0000">待签</font></c:when>
						<c:when test="${empty itm.commitLead && itm.fixitem.itemCtrlComLd==0}">/</c:when>
						<c:otherwise>${itm.commitLead}&nbsp;${itm.comLdAffiTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.accepter && itm.fixitem.itemCtrlAcce==1}"><font color="#ff0000">待签</font></c:when>
						<c:when test="${empty itm.accepter && itm.fixitem.itemCtrlAcce==0}">/</c:when>
						<c:otherwise>${itm.accepter}&nbsp;${itm.acceAffiTime}</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${xtype==1}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas>=4 && empty itm.qi}"><input type="checkbox" value="${itm.preDictId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.repsituation}</td>
				<td>${itm.dealSituation}</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.dealFixEmp && itm.recStas==2}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${fn:substring(itm.dealFixEmp,1,fn:length(itm.dealFixEmp)-1)}&nbsp;${itm.fixEndTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.lead}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${itm.lead}&nbsp;${itm.ldAffirmTime}</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.qi}&nbsp;${itm.qiAffiTime}</td>
				<td>${itm.technician}&nbsp;${itm.techAffiTime}</td>
				<td>${itm.commitLd}&nbsp;${itm.comLdAffiTime}</td>
				<td>${itm.accepter}&nbsp;${itm.acceTime}</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${xtype==2}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas>=2 && empty itm.qi}"><input type="checkbox" value="${itm.jcRecId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.itemName}</td>
				<td>${itm.fixSituation}</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.fixEmp}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.empAfformTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.leadName}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${itm.leadName}&nbsp;${itm.ldAffirmTime}</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.qi}&nbsp;${itm.qiAffiTime}</td>
				<td>${itm.tech}&nbsp;${itm.techAffiTime}</td>
				<td>${itm.commitLead}&nbsp;${itm.comLdAffiTime}</td>
				<td>${itm.accepter}&nbsp;${itm.acceAffiTime}</td>
			</tr>
		</c:forEach>
	</c:if>
</table>

<div style="height:35px;">
	<div class="float_left padding5">
			共有信息${fn:length(itemList)}条。
	</div>
	<div class="clear"></div>
</div>
--%>
<table class="treeTable" style="text-align: center;margin-top:30px;" initState="collapsed" id="freeItemTab">
   <tr style="background-color: lightblue;"><td colspan="11" align="left" style="font-weight: bolder;"><a id="aa">自选签认项目</a>&nbsp;&nbsp;<font color="red">(*自选项目不能全签)</font></td></tr>
   <tr>
		<th width="30px">选择</th>
		<c:if test="${xtype==0}">
			<th width="15%">部件/部位</th>
		</c:if>
		<th width="29%">检修内容/项目名称</th>
		<th width="5%">检修情况</th>
		<th width="15%">检修人</th>
		<th width="15%">工长</th>
		<th width="15%">质检员</th>
		<th width="10%">技术员</th>
		<th width="10%">交车工长</th>
		<th width="15%">验收员</th>
	</tr>
      <c:forEach var="team" items="${unfinishBzs}" varStatus="s">
           <tr id="node-${team.proteamId }">
			<td style="width: 40px;"><input type="radio" onclick="getItem(${team.proteamId },${s.index+1});" id="itemRadio_${s.index+1}"/></td>
			<td colspan="9" align="left">
				<input type="checkbox" onclick="selectChildren(${s.index+1});" id="p_${s.index+1}"/>
				<span class="folder">${team.proteamName }
				    <c:if test="${team.count!=0}"><font color='red'>${team.count}条项目未签认完全</font></c:if>
				</span>
			</td>
		</tr>
		<tr class="child-of-node-${team.proteamId }">
		   <td></td>
		   <td colspan="9"><a href="javascript:void(0);" onclick="getItem(${team.proteamId },${s.index+1});" style="color:blue;">请点击单选框/此处获取信息</a></td>
		</tr>
       </c:forEach>
</table>					
</body>
</html>