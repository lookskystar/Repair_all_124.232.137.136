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
		if (planid != '') {
			var diag = new top.Dialog();
			diag.Title = "报活操作窗口";
			diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+planid+'&type='+jctype;
			diag.Width=1000;
			diag.Height=520;
			diag.show();
		} else {
			top.Dialog.alert("请选择机车计划！")
		}
	});
});
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
						top.Dialog.alert("工人未签认完全!");
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

//工长项目签认
function itemRatify(){
   var checkIds=[];
   var testId= $("input[name='test_item']").filter("[checked=true]").val()
   $("input[name='check_item']:checked").each(function(){
	      checkIds.push($(this)[0].value);
	});
	if(checkIds.length==0&&testId==undefined){
	   top.Dialog.alert("请选择项目!");
	}else if(checkIds.length>0){
	   var ids = ""+checkIds.join("-");
	   top.Dialog.open({URL:"<%=basePath%>workAction!workerZxRatifyInput.do?type=0&xtype=${xtype}&rjhmId=${rjhmId}&ids="+ids+"&qtype=0&role=foreman",Width:420,Height:170,Title:"签名确认",ID:'frmDialog'});
	}else{
	  top.Dialog.open({URL:"<%=basePath%>workAction!workerZxRatifyInput.do?type=1&qtype=0&xtype=${xtype}&rjhmId=${rjhmId}&role=foreman&ids="+testId,Width:420,Height:170,Title:"签名确认"});
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

var obj={
  disable:function(object,type){
      var flag=0;
      if(type==0){
          $("input[name='check_item']").each(function(){
	     	 if($(this).attr("checked")){
	     	    obj.disableRadio();
	     	    flag=1;
	     	 }
	   	  });
	   	  if(flag==0){
	   	       this.showRadio();
	   	  }
      }else{ 
         $("input[name='test_item']").each(function(){
	         if($(this).attr("checked")){
	     	    obj.disableCheckbox();
	     	 }
	   	});
      }
  },
  disableRadio:function(){
	   $("input[name='test_item']").each(function(){
	      $(this).attr("disabled",true);
	   });
  },
  showRadio:function(){
	   $("input[name='test_item']").each(function(){
	      $(this).attr("disabled",false);
	   });
  },
  disableCheckbox:function(){
        $("input[name='check_item']").each(function(){
	      $(this).attr("disabled",true);
	   });
  },
  showCheckbox:function(){
        $("input[name='check_item']").each(function(){
	      $(this).attr("disabled",false);
	   });
  }
};

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
_margin-left:95px;
}

#newreport{
_position:absolute;
_bottom:auto;
_top:expression(eval(document.documentElement.scrollTop));
_margin-top:5px;
_margin-left:185px;
}
</style>
</head>
<body>
<input id="zx_status" type="hidden" value="${zx_status_flag}"/>
<input id="dateplan"  type="hidden" value="${rjhmId }"/>
<input id="jctype"  type="hidden" value="${jctype }"/>
<button id="sign" onclick="itemRatify();" ><span class="icon_save">项目签认</span></button>
<button id="allsign" onclick="ratify(1);" ><span class="icon_save">卡控全签</span></button>
<button id="newreport" ><span class="icon_print">报活</span></button>
<table class="tableStyle" style="text-align: center;margin-top: 30px;" id="checkItemTab" useCheckbox="false">
	
	<tr>
		<th width="30px">选择</th>
		<c:if test="${xtype==0}">
			<th width="10%">部件/部位</th>
		</c:if>
		<th width="10%">检修内容/项目名称</th>
		<th width="10%">检修/探伤情况</th>
		<th width="15%">配件编号</th>
		<th width="10%">检修人/探伤员</th>
		<th width="10%">工长</th>
		<th width="10%">质检员</th>
		<th width="10%">技术员</th>
		<th width="10%">交车工长</th>
		<th width="10%">验收员</th>
	</tr>
	<c:if test="${empty itemList}"><tr><td colspan="10">没有数据记录!</td></tr></c:if>
	<c:if test="${xtype==0}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.itemType==0 && empty itm.itemId.amount}">
							<c:choose>
								<c:when test="${empty record.lead}">
									<input type="checkbox" value="${itm.id}" name="check_item" id="check_item" onclick="obj.disable(this,0);"/>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${itm.itemType==0 && not  empty itm.itemId.amount}">
							<c:choose>
								<c:when test="${empty record.lead && not empty record.pjNum}">
									<input type="checkbox" value="${itm.id}" name="check_item" id="check_item" onclick="obj.disable(this,0);"/>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${itm.itemType==1 && empty itm.itemId.amount}">
							<c:choose>
								<c:when test="${empty record.lead}">
									<input type="radio" value="${itm.id}" name="test_item" id="test_item" onclick="obj.disable(this,1);"/>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${itm.itemType==1 && not  empty itm.itemId.amount}">
							<c:choose>
								<c:when test="${empty record.lead && not empty record.pjNum}">
									<input type="radio" value="${itm.id}" name="test_item" id="test_item" onclick="obj.disable(this,1);"/>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</c:when>
					</c:choose>
					
					<%--
					<c:if test="${itm.itemType==0 && empty itm.fixEmp && not empty itm.upPjNum}">
					  <input type="checkbox" value="${itm.id}" name="check_item" id="check_item" onclick="obj.disable(this,0);"/>
					</c:if>
					<c:if test="${itm.itemType==1 && empty itm.fixEmp}">
					  <input type="radio" value="${itm.id}" name="test_item" id="test_item" onclick="obj.disable(this,1);"/>
					</c:if>
					 --%>
				</td>
				<td style="white-space:normal;word-break:break-all;word-wrap:break-word;">${itm.itemId.unitName} ${itm.itemId.posiName}</td>
				<td style="white-space:normal;word-break:break-all;word-wrap:break-word;">${itm.itemName}</td>
				<td style="white-space:normal;word-break:break-all;word-wrap:break-word;">
					<c:choose>
						<c:when test="${itm.bzId==tsbzid}">
							<a href="javascript:void(0);" title="探伤结果：${itm.fixSituation}<br/>裂损情况：${itm.dealSituation}" style="color: blue;">
								${itm.fixSituation}${itm.itemId.unit}<br/>${itm.dealSituation}
							</a>
						</c:when>
						<c:otherwise>${itm.fixSituation}${itm.itemId.unit}</c:otherwise>
					</c:choose>
					
				</td>
				<td style="white-space:normal;word-break:break-all;word-wrap:break-word;">
					  <c:if test="${itm.nodeId==101}">
					    <c:if test="${empty itm.upPjNum&&empty itm.downPjNum}">
					    	<c:choose>
						    	<c:when test="${not empty itm.itemId.amount }" >
						    		<a id="${itm.itemId.stdPJId}" href="javascript:void(0);" style="color:blue;" onclick="pjNumInputWith('${itm.itemName}','${itm.id}','${itm.itemId.amount }','${itm.itemId.stdPJId}');">点击输入</a>
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
						<c:when test="${itm.bzId==tsbzid}">
							<c:if test="${empty itm.fixEmp}"><font color="#ff0000">待签(主探)</font></c:if>
							<c:if test="${!empty itm.fixEmp}">
								<a href="javascript:void(0);" style="color:blue;" title="主探:${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)} ${itm.fixEmpTime}">
									${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}(主探)
								</a>
							</c:if><br/>
							<c:if test="${empty itm.rept && itm.itemId.itemCtrlRept==1}"><font color="#ff0000">待签(复探)</font></c:if>
							<c:if test="${!empty itm.rept}">
								<a href="javascript:void(0);" style="color:blue;" title="复探:${itm.rept} ${itm.reptAffirmTime}">
									${itm.rept}(复探)
								</a>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${empty itm.fixEmp}"><font color="#ff0000">待签</font></c:when>
								<c:otherwise>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.fixEmpTime}</c:otherwise>
							</c:choose>
						</c:otherwise>
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
						<c:when test="${(empty itm.qi && itm.itemId.itemCtrlQi==1) && (empty itm.teachName)}"><font color="#ff0000">待签</font></c:when>
						<c:when test="${(empty itm.qi && itm.itemId.itemCtrlQi==0) && (empty itm.teachName)}">/</c:when>
						<c:otherwise>${itm.qi}&nbsp;${itm.qiAffiTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${(empty itm.qi)&&(empty itm.teachName && itm.itemId.itemCtrlTech==1)}"><font color="#ff0000">待签</font></c:when>
						<c:when test="${(empty itm.qi)&&(empty itm.teachName && itm.itemId.itemCtrlTech==0)}">/</c:when>
						<c:otherwise>${itm.teachName}&nbsp;${itm.teachAffiTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.commitLead && itm.itemId.itemCtrlComld==1}"><font color="#ff0000">待签</font></c:when>
						<c:when test="${empty itm.commitLead && itm.itemId.itemCtrlComld==0}">/</c:when>
						<c:otherwise>${itm.commitLead}&nbsp;${itm.comLdAffiTime}</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.acceptEr && itm.itemId.itemCtrlAcce==1}"><font color="#ff0000">待签</font></c:when>
						<c:when test="${empty itm.acceptEr && itm.itemId.itemCtrlAcce==0}">/</c:when>
						<c:otherwise>${itm.acceptEr}&nbsp;${itm.acceAffiTime}</c:otherwise>
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
						<c:when test="${itm.recStas==3}"><input type="checkbox" value="${itm.preDictId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.repsituation}</td>
				<td>${itm.dealSituation}</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.dealFixEmp}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${fn:substring(itm.dealFixEmp,1,fn:length(itm.dealFixEmp)-1)}&nbsp;${itm.fixEndTime}</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.lead}&nbsp;${itm.ldAffirmTime}</td>
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
					<c:if test="${itm.itemType==0 && empty itm.fixEmp}">
					  <input type="checkbox" value="${itm.jcRecId}" name="check_item" id="check_item" onclick="obj.disable(this,0);"/>
					</c:if>
					<c:if test="${itm.itemType==1 && empty itm.fixEmp}">
					  <input type="radio" value="${itm.jcRecId}" name="test_item" id="test_item" onclick="obj.disable(this,1);"/>
					</c:if>
				<td>${itm.itemName}</td>
				<td>${itm.fixSituation}</td>
				<td>
					<c:choose>
						<c:when test="${empty itm.fixEmp && itm.recStas==0}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${fn:substring(itm.fixEmp,1,fn:length(itm.fixEmp)-1)}&nbsp;${itm.empAfformTime}</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.leadName}&nbsp;${itm.ldAffirmTime}</td>
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
<script type="text/javascript">
 
</script>				
</body>
</html>