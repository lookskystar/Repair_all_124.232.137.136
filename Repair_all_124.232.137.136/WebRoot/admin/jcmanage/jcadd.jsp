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
    <title>添加机车</title>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
  </head>
 <body>
	<table class="tableStyle" transMode="true">
		<tr>
			<td align="right">&nbsp;&nbsp;机车型号: &nbsp;&nbsp;</td>
			<td>
				<select name="jcType" id="jcType" class="default">
				     <option value="">请选择机车型号</option>
				     <c:forEach items="${dictJcStypeList}" var="entry">
   	                     <option value="${entry.jcStypeValue}">${entry.jcStypeValue}</option>
   	                 </c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right">机车编号:</td>
			<td>
			<input name="jcNum" type="text"  id="jcNum" ></input>
			</td>
		</tr>
		<tr>
			<td align="right">当日走行公里:</td>
			<td>
			<input name="dayRunKilo" type="text"  id="dayRunKilo" ></input>
			</td>
		</tr> 
		<tr>
			<td align="right">辅修走行公里:</td>
			<td>
			<input name="minorRunKilo" type="text"  id="minorRunKilo" ></input>
			</td>
		</tr> 
		<tr>
			<td align="right">小修走行:</td>
			<td>
			<input name="smaRunKilo" type="text"  id="smaRunKilo" ></input>
			</td>
		</tr> 
		<tr>
			<td align="right">中修走行:</td>
			<td>
			<input name="midRunKilo" type="text"  id="midRunKilo" ></input>
			</td>
		</tr> 
		<tr>
			<td align="right">大修走行:</td>
			<td>
			<input name="larRunKilo" type="text"  id="larRunKilo" ></input>
			</td>
		</tr> 
		<tr>
			<td align="right">总走行公里:</td>
			<td>
			<input name="totalRunKilo" type="text"  id="totalRunKilo" ></input>
			</td>
		</tr> 
		<tr>
			<td align="right">登记人:</td>
			<td>
			<input name="registRant" type="text"  id="registRant" ></input>
			</td>
		</tr> 
		<tr>
			<td colspan="4">
				<input type="submit" id="subBTN" value=" 提 交 " />&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" value=" 重 置 " onclick="reset();"/>
			</td>
		</tr>
 	</table>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#subBTN").bind("click",function(){
			//参数列
			var jcType = $("#jcType").val();
			var jcNum = $("#jcNum").val();
			var dayRunKilo = $("#dayRunKilo").val();
			var minorRunKilo = $("#minorRunKilo").val();
			var smaRunKilo = $("#smaRunKilo").val();
			var midRunKilo = $("#midRunKilo").val();
			var larRunKilo = $("#larRunKilo").val();
			var totalRunKilo = $("#totalRunKilo").val();
			var registRant = $("#registRant").val();
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
				$.post("jcManageAction!addJtRunKiloRec.action",{"jcType":jcType,"jcNum":jcNum,"dayRunKilo":dayRunKilo,"minorRunKilo":minorRunKilo,
							"smaRunKilo":smaRunKilo,"midRunKilo":midRunKilo,"larRunKilo":larRunKilo,"totalRunKilo":totalRunKilo,"registRant":registRant},
					function(result){
						if("success" == result){
							top.Dialog.alert("机车添加成功！",function(){
								//top.frmright.jcIframe.location.href="<%=basePath%>jcManageAction!listJtRunKiloRec.do";
								//top.frmright.location.reload();
								top.Dialog.close();
							});
						}else{
							top.Dialog.alert("机车添加失败！");
						}
				})
			}
		})
	})
	
	//清空
	function reset(){
		$("#jcType").val("");
		$("#jcNum").val("");
		$("#dayRunKilo").val("");
		$("#minorRunKilo").val("");
		$("#smaRunKilo").val("");
		$("#midRunKilo").val("");
		$("#larRunKilo").val("");
		$("#totalRunKilo").val("");
		$("#registRant").val("");
	}
</script>
</html>