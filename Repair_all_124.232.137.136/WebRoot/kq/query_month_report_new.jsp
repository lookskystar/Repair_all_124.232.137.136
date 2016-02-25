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
	   function queryMonthDetail(gonghao,userName){
		    var time=$("#time").val();
	   		top.Dialog.open({
				URL:"rewardAction!queryMonthDetailNew.do?gonghao="+gonghao+"&time="+time+"&userName="+userName,
				Width:1200,
				Height:800,
				Title:"用户月报详细信息"
			});
	   }

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
			LODOP.SET_PRINT_PAGESIZE (1, 0, 0,"A4");
			LODOP.ADD_PRINT_TEXT(21,300,300,30,"${time }月份工时统计信息\n");
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

		//保存为excel文件
		function SaveAsFile(){ 
			var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));   
			LODOP.PRINT_INIT(""); 
			LODOP.ADD_PRINT_TABLE(100,20,500,80,document.getElementById("scrollContent").innerHTML); 
			LODOP.SET_SAVE_MODE("Orientation",1); //Excel文件的页面设置：横向打印   1-纵向,2-横向;
			LODOP.SET_SAVE_MODE("LINESTYLE",1);//导出后的Excel是否有边框
			LODOP.SAVE_TO_FILE("${time }月份工时统计信息.xls"); 
		};	
	</script>
</head>
<body>
<div class="box2" panelTitle="月报查询" roller="false">
<form id="form" action="rewardAction!queryMonthReportNew.do" method="post">	
    <table>
    	<tr>
    		<td>班组：</td>
    		<td>
    			<select colNum="4" colWidth="80" name="proteamId">
				  <option value="0">请选择班组</option>
			      <c:forEach var="proteam" items="${proteams}">
			         <option value="${proteam.proteamid }" <c:if test="${proteamId==proteam.proteamid }">selected="selected"</c:if>>${proteam.proteamname }</option>
			      </c:forEach>
				</select>
    		</td>
    		<td>时间：</td>
    		<td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM'}))" name="time" value="${time }" id="time"/></td>
    		<td> <input type="submit" value=" 查 询  "/></td>
    		<td><button onclick="preview();"><span class="icon_print">打印预览</span></button></td>
    		<td> <button onclick="print();"><span class="icon_print">打印</span></button></td>
    		<td><button onclick="SaveAsFile();"><span class="icon_xls">Excel导出</span></button></td>
    	</tr>
    </table>
</form>
</div>
<div id="scrollContent">
	<table class="tableStyle" style="text-align:center; margin-top:10px;">
	<tr>
		<td width="10%">序号</td>
		<td width="15%">班组</td>
		<td width="15%">工号</td>
		<td width="10%">姓名</td>
		<td width="25%">时间(月份)</td>
		<td width="10%">工时得分</td>
	</tr>
	<c:forEach var="workCount" items="${workCounts}" varStatus="s">
	   <tr>
	   	<td>${s.index+1 }</td>
	   	<td>${workCount.proteamName }</td>
	   	<td>${workCount.gonghao }</td>
	   	<td>${workCount.userName }</td>
	   	<td>${time }</td>
	   	<td><a href="javascript:void(0)" style="color:blue;" onclick="queryMonthDetail('${workCount.gonghao }','${workCount.userName }');">${workCount.score }分</a></td>
	   </tr>
	</c:forEach>
	<c:if test="${empty workCounts}">
	    <tr><td align="center" colspan="6">没有相应的数据信息!</td></tr>
	</c:if>
	</table>
</div>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>