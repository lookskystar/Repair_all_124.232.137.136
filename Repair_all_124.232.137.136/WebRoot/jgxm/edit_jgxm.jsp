<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@include file="/common/common.jsp" %>
<%@include file="/checkLogin.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加加改项目</title>
    
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/bsFormat.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<script type="text/javascript">
		$(function(){
			var sTrHtml=$("#jgxmItemTab tr:eq(1)").html();
			$("button[name='addCol']").click(function(){
				var tab=$("#jgxmItemTab");
				var len=tab.find("tr").length-1;
				if(len >= 10){
					return;
				}
				
				tab.append("<tr>"+sTrHtml+"</tr>");
				var tr=tab.find("tr:eq("+(++len)+")");
				tr.find("td:last").html("<button><span class='icon_delete' onclick='$(this).parent().parent().parent().remove();'>移除</span></button>");
				selRefresh($("select"));
			})
			
			
		})
		
	</script>
  </head>
  
  <body>
    <div class="box4" panelWidth="1000" panelHeight="600"  panelTitle="加改项目：防火报警装置">
    	<table class="tableStyle" style="text-align: center;margin-top: 30px;" id="jgxmItemTab" useCheckbox="false">
	
			<tr>
				<th width="15%">配属段</th>
				<th width="15%">支配段</th>
				<th width="5%">机型</th>
				<th width="5%">车号</th>
				<th width="10%">是否要求改造</th>
				<th width="10%">改造是否完成</th>
				<th width="10%">填报人</th>
				<th width="10%">填报时间</th>
				<th width="10%">备注</th>
				<th width="10%"></th>
			</tr>
			<tr>
				<td>
					<select >
						<option>长沙机务段</option>
					</select>
				</td>
				<td>
					<select>
						<option>长沙机务段</option>
					</select>
				</td>
				<td><input type="text"  style="width:60px;"/></td>
				<td><input type="text"  style="width:60px;"/></td>
				<td>
					<select style="width:60px;" autoWidth="true">
						<option selected>是</option>
						<option>否</option>
					</select>
				</td>
				<td>
					<select style="width:60px;" autoWidth="true">
						<option selected>是</option>
						<option>否</option>
					</select>
				</td>
				<td>当前登录用户</td>
				<td><fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd" /></td>
				<td><input type="text" style="width:60px;"/></td>
				<td><button name="addCol"><span class="icon_add" >增加</span></button></td>
			</tr>
			
		</table>
    
    </div>
  </body>
</html>
