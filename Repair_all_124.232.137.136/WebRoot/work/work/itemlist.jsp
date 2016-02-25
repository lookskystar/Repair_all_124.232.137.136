<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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

var dpid = '${dpid}';//日计划ID
var jctype = '${jctype}';//机车车型
var jcnum = '${jcnum}';//机车号
var type = '${itemType}';//类型 0：机修 1：临修、加改 2：秋整、春鉴

function selectAll(tablename,chk){
	var flag = chk.checked;
	$("#"+tablename+" input:checkbox").attr("checked",flag);
}

function selectSign(id){
	var flag = !$("#"+id).attr("checked");
	$("#"+id).attr("checked",flag);
}

function saveDivision(){
	var preset = "";
	$("#radioTable input[type=checkbox]").each(function(){
		if($(this).attr("checked")){
			preset=$(this).val()+","+preset;
		}
	});
	
	if(preset=="" || preset==undefined){
		top.Dialog.alert("请选择预设分类!");
		return ;
	}
	var workers= "";//工人
	$("#checkGroup input[type=checkbox]").each(function(){
		if($(this).attr("checked")){
			workers=$(this).val()+","+workers;
		}
	});
	if(workers=="" || workers==undefined){
		top.Dialog.alert("请选择班组人员!");
		return ;
	}
	$.post("<%=basePath%>workAction!saveDivision.do",{'pdId':preset,'workers':workers,'dpid':dpid,'jctype':jctype,'jcnum':jcnum,'type':type} ,function(text){
		if(text=="success"){
			top.Dialog.alert("派工成功!");
			$("#checkGroup input[type=checkbox]").each(function(){
				$(this).attr("checked",false);
			});
			$("#radioTable input[type=checkbox]").each(function(){
				$(this).attr("checked",false);
			});
			$('#divisionList').attr("src","<%=basePath%>workAction!listDivision.do?dpid=${dpid}&type=${itemType}&tmp="+new Date().getTime()); 
		}else{
			top.Dialog.alert("派工失败!");
		}
	});

}
</script>
<body>
<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	  <tr>
	  	<td width="30%">
	  		<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  			<tr><td height="140">
	  				<!-- 小辅修项目 -->
	  				<c:if test="${itemType==0}">
		  				<div class="box2" panelHeight="410"  panelTitle="预设分工大类" showStatus="false" overflow="auto">
							<table class="tableStyle" id="radioTable" useCheckBox="false" width="100%">
								<tr>
									<th width="10px"></th><th align="left">分类名称
									<input type="button" value="无活强制完成" onclick='top.Dialog.confirm("确定当修成下没有活,强制完成?",function(){
										$.post("<%=basePath%>workAction!ajaxForceMake.do",{"dpid":dpid},function(text){
											if(text=="success"){
												top.Dialog.alert("强制完成成功!");
											}else{
												top.Dialog.alert("强制完成失败!");
											}
										})
									});'/>
									</th>
								</tr>
								<c:if test="${empty result}"><tr align="center"><td colspan="2">没有数据记录!</td></tr></c:if>
								<c:forEach var="pd" items="${result}" varStatus="idx">
									<tr>
										<td width="10px"><input type="checkbox" value="${pd.proSetId}" id="ys_${pd.proSetId}" name="preset"/></td>
										<td onclick="selectSign('ys_${pd.proSetId}')">${pd.clsName }</td>
									</tr>
								</c:forEach>
							</table>
							<div class="clear"></div>
						</div>
	  				</c:if>
	  				<!-- 报活项目项目 -->
	  				<c:if test="${itemType==1}">
		  				<div class="box2" panelHeight="410"  panelTitle="项目列表" showStatus="false" overflow="auto">
							<table class="tableStyle" id="radioTable" useCheckBox="false">
								<tr><th width="10px"></th><th>检修内容
								<input type="button" value="无活强制完成" onclick='top.Dialog.confirm("确定当修成下没有活,强制完成?",function(){
										$.post("<%=basePath%>workAction!ajaxForceMake.do",{"dpid":dpid},function(text){
											if(text=="success"){
												top.Dialog.alert("强制完成成功!");
											}else{
												top.Dialog.alert("强制完成失败!");
											}
										})
										});'/>
								</th></tr>
								<c:if test="${empty result}"><tr align="center"><td colspan="2">没有数据记录!</td></tr></c:if>
								<c:forEach var="pre" items="${result}" varStatus="idx">
									<tr>
										<td><input type="checkbox" value="${pre.preDictId}" id="bh_${pre.preDictId}" name="preset"/></td>
										<td onclick="selectSign('bh_${pre.preDictId}')">${pre.repsituation }</td></tr>
								</c:forEach>
							</table>
							<div class="clear"></div>
						</div>
	  				</c:if>
	  				<!-- 秋整、春鉴项目 -->
	  				<c:if test="${itemType==2}">
		  				<div class="box2" panelHeight="410"  panelTitle="项目列表" showStatus="false" overflow="auto">
							<table class="tableStyle" id="radioTable" useCheckBox="false">
								<tr><th width="10px"></th><th>检修项目
								<input type="button" value="无活强制完成" onclick='top.Dialog.confirm("确定当修成下没有活,强制完成?",function(){
										$.post("<%=basePath%>workAction!ajaxForceMake.do",{"dpid":dpid},function(text){
											if(text=="success"){
												top.Dialog.alert("强制完成成功!");
											}else{
												top.Dialog.alert("强制完成失败!");
											}
										})
									});'/>
								</th></tr>
								<c:if test="${empty result}"><tr align="center"><td colspan="2">没有数据记录!</td></tr></c:if>
								<c:forEach var="it" items="${result}" varStatus="idx">
									<tr><td>
										<input type="checkbox" value="${it.id}" name="preset" id="qzcj_${it.id}"/></td>
										<td onclick="selectSign('qzcj_${it.id}')">${it.itemName }</td>
									</tr>
								</c:forEach>
							</table>
							<div class="clear"></div>
						</div>
	  				</c:if>
	  			</td></tr>
	  		</table>
	  	</td>
	  	<td width="40%">
 			<div class="box2" panelTitle="分工详细列表" showStatus="false" panelHeight="410" overflow="auto">
				<IFRAME scrolling="auto" width="100%" height="360px"  frameBorder=0 id=divisionList name=divisionList src="<%=basePath%>workAction!listDivision.do?dpid=${dpid}&type=${itemType}"  allowTransparency="true"></IFRAME>
			</div>
	  	</td>
	  	<td>
	  		<div class="box2" panelHeight="410"  panelTitle="班组成员" roller="true" showStatus="false" overflow="auto">
			<div class="dbList">
				<button onclick="saveDivision();"><span class="icon_save">保存分工</span></button>
				<div class="clear" style="margin-bottom: 5px;"></div>
				<table class="tableStyle" id="checkGroup" useCheckBox="false">
					<tr align="center"><th width="10"><input type="checkbox" onclick="selectAll('checkGroup',this);"/></th><th width="45%">姓名</th><th>工号</th></tr>
					<c:if test="${empty users}"><tr align="center"><td colspan="3">没有数据记录!</td></tr></c:if>
					<c:forEach var="user" items="${users}">
						<tr align="center">
							<td><input type="checkbox" value="${user.userid}" id="usr_${user.userid}" name="workList"/></td>
							<td  onclick="selectSign('usr_${user.userid}');">${user.xm }</td><td  onclick="selectSign('usr_${user.userid}');">${user.gonghao}</td>
						</tr>
					</c:forEach>
				</table>
				<div class="clear"></div>
			</div>
	    	</div>
	  	</td>
	  </tr>
	</table>
</div>				
</body>
</html>