<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin"  prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<!-- 打印插件 -->
	<script type="text/javascript" src="<%=basePath %>js/LodopFuncs.js"></script>
	<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
	       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed> 
	</object> 
	<!-- 打印end -->
	
	<script type="text/javascript">
		var LODOP; //声明为全局变量 
		//打印预览
		function preview(){
			CreatePrintPage();
			LODOP.PREVIEW();
		}

		//打印设置
		function setup(){
			CreatePrintPage();
			LODOP.PRINT_DESIGN();
		}

		//打印
		function print(){
			CreatePrintPage();
			LODOP.PRINT();	
		}

		//创建打印页面
		function CreatePrintPage(){
			LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));  
			var strBodyStyle="<style>table,td{border:1 solid #000000;border-collapse:collapse}</style>";
			var strFormHtml=strBodyStyle+"<body>"+document.getElementById("scrollContent").innerHTML+"</body>";
			LODOP.PRINT_INITA(10,10,754,453,"打印控件操作");
			LODOP.SET_PRINT_PAGESIZE (2, 0, 0,"A4");
			LODOP.ADD_PRINT_TEXT(21,300,300,30,"工时统计日报信息\n");
			LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.SET_PRINT_STYLEA(0,"Horient",2);
			LODOP.SET_PRINT_STYLEA(0,"Bold",1);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.ADD_PRINT_HTM(63,38,684,330,strFormHtml);
			LODOP.SET_PRINT_STYLEA(0,"FontSize",10);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",4);
			LODOP.SET_PRINT_STYLEA(0,"Horient",3);
			LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
			LODOP.ADD_PRINT_LINE(414,23,413,725,0,1);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.SET_PRINT_STYLEA(0,"Horient",3);
			LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
			LODOP.ADD_PRINT_TEXT(421,542,165,22,"第#页/共&页");
			LODOP.SET_PRINT_STYLEA(0,"ItemType",2);
			LODOP.SET_PRINT_STYLEA(0,"Horient",1);
			LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
		}

		function SaveAsFile(){ 
			var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));   
			LODOP.PRINT_INIT(""); 
			LODOP.ADD_PRINT_TABLE(100,20,500,80,document.getElementById("scrollContent").innerHTML); 
			LODOP.SET_SAVE_MODE("Orientation",1); //Excel文件的页面设置：横向打印   1-纵向,2-横向;
			LODOP.SET_SAVE_MODE("LINESTYLE",1);//导出后的Excel是否有边框
			LODOP.SAVE_TO_FILE("工时统计日报信息.xls"); 
		};	
	</script>
</head>
<body>
<div>
<div class="box2" panelTitle="日报查询" roller="false">
<form id="form" action="rewardAction!queryDayReportNew.do" method="post">	
   <table>
    <tr>
      <td>班组:</td>
      <td>
     	<select colNum="4" colWidth="80" name="proteamId">
		  <option value="0">请选择班组</option>
	      <c:forEach var="proteam" items="${proteams}">
	         <option value="${proteam.proteamid }" <c:if test="${proteamId==proteam.proteamid }">selected="selected"</c:if>>${proteam.proteamname }</option>
	      </c:forEach>
		</select>
      </td>
      <td>时间：</td>
      <td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" name="time" value="${time }"/></td>
      <td>姓名：</td>
      <td><input type="text" style="width: 115px" name="userName" value="${userName}"/></td>
      <td>工号：</td>
      <td><input type="text" style="width: 115px" name="gonghao" value="${gonghao }"/></td>
      <td><input type="submit" value=" 查 询  "/></td>
      <td><button onclick="preview();"><span class="icon_print">打印预览</span></button></td>
      <td><button onclick="print();"><span class="icon_print">打印</span></button></td>
      <td><button onclick="SaveAsFile();"><span class="icon_xls">Excel导出</span></button></td>
    </tr>
  </table>
</form>
</div>
<div id="scrollContent">
	<table class="tableStyle" style="text-align:center; margin-top:10px;">
	<tr>
		<td width="3%">序号</td>
		<td width="7%">班组</td>
		<td width="7%">工号</td>
		<td width="7%">姓名</td>
		<td width="9%">日期</td>
		<td>工作内容</td>
		<td width="7%">工时得分</td>
		<td width="10%">备注</td>
	</tr>
	<c:forEach var="userItem" items="${userItems}" varStatus="s">
		<tr>
			<td align="center">${s.index+1 }</td>
			<td align="center">${userItem.proteam.proteamname }</td>
			<td align="center">${userItem.user.gonghao }</td>
			<td align="center">${userItem.user.xm }</td>
			<td align="center">${userItem.workTime}</td>
			<td align="center">${userItem.item.itemName }</td>
			<td align="center">${userItem.item.itemScore }</td>
			<td align="center">${userItem.workNote }</td>
		</tr>
	</c:forEach>
	<c:if test="${empty userItems}">
	    <tr><td align="center" colspan="8">没有相应的数据信息!</td></tr>
	</c:if>
	</table>
</div>
</div>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>