<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <base href="<%=basePath%>"/>
    <title>编辑机车</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
 <body>
 	<form action="jcManageAction!editeJtRunKiloRec.do" id="subform" method="post" target="frmright">
 		<input type="hidden" name="jtRunKiloRec.runId" value="${jtRunKiloRec.runId }"/>
		<table class="tableStyle" transMode="true">
			<tr>
				<td align="right">&nbsp;&nbsp;机车型号: &nbsp;&nbsp;</td>
				<td>
					<select name="jtRunKiloRec.jcType" id="jcType" class="default">
					     <option value="${jtRunKiloRec.jcType }">${jtRunKiloRec.jcType }</option>
					     <c:forEach items="${dictJcStypeList}" var="entry">
	   	                     <option value="${entry.jcStypeValue}">${entry.jcStypeValue}</option>
	   	                 </c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">机车编号:</td>
				<td>
				<input name="jtRunKiloRec.jcNum" type="text" value="${jtRunKiloRec.jcNum }" id="jcNum"></input>
				</td>
			</tr>
			<tr>
				<td align="right">当日走行公里:</td>
				<td>
				<input name="jtRunKiloRec.dayRunKilo" type="text" value="${jtRunKiloRec.dayRunKilo }"></input>
				</td>
			</tr> 
			<tr>
				<td align="right">辅修走行公里:</td>
				<td>
				<input name="jtRunKiloRec.minorRunKilo" type="text" value="${jtRunKiloRec.minorRunKilo }"></input>
				</td>
			</tr> 
			<tr>
				<td align="right">小修走行:</td>
				<td>
				<input name="jtRunKiloRec.smaRunKilo" type="text" value="${jtRunKiloRec.smaRunKilo }" ></input>
				</td>
			</tr> 
			<tr>
				<td align="right">中修走行:</td>
				<td>
				<input name="jtRunKiloRec.midRunKilo" type="text" value="${jtRunKiloRec.midRunKilo }"></input>
				</td>
			</tr> 
			<tr>
				<td align="right">大修走行:</td>
				<td>
				<input name="jtRunKiloRec.larRunKilo" type="text" value="${jtRunKiloRec.larRunKilo }"></input>
				</td>
			</tr> 
			<tr>
				<td align="right">总走行公里:</td>
				<td>
				<input name="jtRunKiloRec.totalRunKilo" type="text"  value="${jtRunKiloRec.totalRunKilo }" ></input>
				</td>
			</tr> 
			<tr>
				<td align="right">登记人:</td>
				<td>
				<input name="jtRunKiloRec.registRant" type="text"  value="${jtRunKiloRec.registRant }" ></input>
				</td>
			</tr> 
			<tr>
				<td colspan="4">
					<input type="button" value=" 提 交 " id="subBtn"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" value=" 重 置 " />
				</td>
			</tr>
	 	</table>
 	</form>
</body>
<script type="text/javascript">
	$(function(){
	    $("#subBtn").bind("click",function(){ 
			//参数列
			var jcType = $("#jcType").val();
			var jcNum = $("#jcNum").val();
			//判断是否有必填字段为空
			var isNull = true;
			if(jcType == "" || jcType == null){
				top.Dialog.alert("机车类型不能为空！");
				isNull = false;
			}else if(jcNum == "" || jcNum == null){
				top.Dialog.alert("机车编号不能为空！");
				isNull = false;
			}
			if(isNull){
				$("#subform").submit();
			}
		})
	 });
</script>
</html>