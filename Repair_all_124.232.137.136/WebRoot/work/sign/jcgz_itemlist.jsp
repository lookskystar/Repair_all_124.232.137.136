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
			diag.URL = 'reportWorkManage!jtPreDictInput.action?id='+planid+'&type='+jctype+'&roleType=jcgz';
			diag.Width=1000;
			diag.Height=520;
			diag.show();
		} else {
			top.Dialog.alert("请选择机车计划！")
		}
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
		//top.Dialog.open({URL:"<%=basePath%>signWorkAction!signWorkInput.do?rtype=${rtype}&xtype=${xtype}&rjhmId=${rjhmId}&ids="+ids+"&qtype="+qtype,Width:420,Height:150,Title:"签名确认",ID:'frmDialog'});
		$.post("<%=basePath%>signWorkAction!signWork.do",
				{"ids":ids,"rtype":"${rtype}","xtype":"${xtype}","qtype":qtype,"rjhmId":"${rjhmId}"},
				function(text){
					if(text=="login_failure"){
						top.Dialog.alert("不存在该用户!");
					}else if(text=="noprivilege_failure"){
						top.Dialog.alert("没有权限或没有可签项目!");
					}else if(text=="failure"){
						top.Dialog.alert("签名失败!");
					}else{
						top.Dialog.alert("签名成功!",function(){
							top.jcmain.jcgz_gdt.location.reload();
							//top.Dialog.close();
						});
					}
				}
		);
	}
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
<input id="dateplan"  type="hidden" value="${rjhmId }"/>
<input id="jctype"  type="hidden" value="${jctype }"/>
<button id="sign" onclick="ratify(0);" ><span class="icon_save">签名</span></button>
<button id="allsign" onclick="ratify(1);" ><span class="icon_save">全签</span></button>
<button id="newreport" ><span class="icon_print">报活</span></button>
<table class="tableStyle" style="text-align: center;margin-top: 30px;id="checkItemTab">
	<tr>
		<th width="30px">选择</th>
		<c:if test="${xtype==0}">
			<th width="10%">部件/部位</th>
		</c:if>
		<th width="20%">检修内容/项目名称</th>
		<th width="5%">检修情况</th>
		<th width="10%">检修人</th>
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
						<c:when test="${itm.recStas>=2 && (empty itm.commitLead)}">
							<input type="checkbox" value="${itm.jcRecId}" name="check_item" id="check_item"/>
						</c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.fixitem.secUnitName}&nbsp;${itm.fixitem.posiName}</td>
				<td>${itm.itemName}</td>
				<td>
				   <c:if test="${empty itm.upPjNum}">${itm.fixSituation}${itm.fixitem.unit}</c:if>
				   <c:if test="${!empty itm.upPjNum}">${itm.fixSituation}${itm.fixitem.unit}<br/>
				       <c:forTokens items="${itm.upPjNum }" delims="," var="num">
				       <a href="query!findPjRecordByPjNum.do?rjhmId=${itm.datePlanPri.rjhmId}&pjNum=${num}" target="_blank" style="color:blue;">${num}</a>
				     </c:forTokens>
				   </c:if>
				 </td>
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
						<c:when test="${itm.recStas>=4 && empty itm.commitLd}"><input type="checkbox" value="${itm.preDictId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.repsituation}</td>
				<td>
				   <c:if test="${empty itm.upPjNum}">${itm.dealSituation}</c:if>
				   <c:if test="${!empty itm.upPjNum}">${itm.dealSituation}<br/>
				     <c:forTokens items="${itm.upPjNum }" delims="," var="num">
				       <a href="query!findPjRecordByPjNum.do?rjhmId=${itm.datePlanPri.rjhmId}&pjNum=${num}" target="_blank" style="color:blue;">${num}</a>
				     </c:forTokens>
				   </c:if>
				 </td>
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
				<td>
				  <c:choose>
						<c:when test="${itm.itemCtrlQI==1&&empty itm.lead}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${itm.qi}&nbsp;${itm.qiAffiTime}</c:otherwise>
				  </c:choose>
				</td>
				<td>
				   <c:choose>
						<c:when test="${itm.itemCtrlTech==1&&empty itm.technician}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${itm.technician}&nbsp;${itm.techAffiTime}</c:otherwise>
				  </c:choose>
				</td>
				<td>
				  <c:choose>
						<c:when test="${itm.itemCtrlComLd==1&&empty itm.commitLd}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${itm.commitLd}&nbsp;${itm.comLdAffiTime}</c:otherwise>
				  </c:choose>
				</td>
				<td>
				   <c:choose>
						<c:when test="${itm.itemCtrlAcce==1&&empty itm.accepter}"><font color="#ff0000">待签</font></c:when>
						<c:otherwise>${itm.accepter}&nbsp;${itm.acceTime}</c:otherwise>
				  </c:choose>
				</td>
 
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${xtype==2}">
		<c:forEach var="itm" items="${itemList}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${itm.recStas>=2&&empty itm.commitLead}"><input type="checkbox" value="${itm.jcRecId}" name="check_item" id="check_item"/></c:when>
						<c:otherwise>&nbsp;</c:otherwise>
					</c:choose>
				</td>
				<td>${itm.itemName}</td>
				<td>
				   <c:if test="${empty itm.upPjNum}">${itm.fixSituation}</c:if>
				   <c:if test="${!empty itm.upPjNum}">${itm.fixSituation}<br/>
				     <c:forTokens items="${itm.upPjNum }" delims="," var="num">
				       <a href="query!findPjRecordByPjNum.do?rjhmId=${itm.datePlanPri.rjhmId}&pjNum=${num}" target="_blank" style="color:blue;">${num}</a>
				     </c:forTokens>
				   </c:if>
				 </td>
				<td>
					<c:choose>
						<c:when test="${empty itm.fixEmp && itm.recStas==0}"><font color="#ff0000">待签</font></c:when>
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
</body>
</html>