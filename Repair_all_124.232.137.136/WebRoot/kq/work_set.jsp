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
	    //添加考勤排班信息
		function addWorkSet(){
			var proteamId=$("#proteamId").val();
			var time=$("#time").val();
			if(proteamId=="0"){
				top.Dialog.alert("请选择班组!");
			}else if(time==""){
				top.Dialog.alert("请选择月份!");
			}else{
				var array=time.split("-");
				var days=getDaysInMonth(array[0],array[1]);
				top.Dialog.open({
					URL:"rewardAction!addWorkSetInput.do?proteamId="+proteamId+"&days="+days+"&time="+time,
					Width:"100",
					Height:"100",
					Title:"添加考勤排班信息"
				});
			}
		}

	    //获取一个月的天数
		function getDaysInMonth(year,month){
			month=parseInt(month,10);//不填10，默认也是10进制
			var temp=new Date(year,month,0);
			return temp.getDate();
		}

	    //排班查询
		function queryWorkSet(){
			var proteamId=$("#proteamId").val();
			var time=$("#time").val();
			if(proteamId=="0"){
				top.Dialog.alert("请选择班组!");
			}else if(time==""){
				top.Dialog.alert("请选择月份!");
			}else{
				var array=time.split("-");
				var days=getDaysInMonth(array[0],array[1]);
				window.location.href="rewardAction!workSetInput.do?proteamId="+proteamId+"&time="+time+"&days="+days;
			}
		}

	    //excel导出
		function saveAsFile(){ 
			var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));   
			LODOP.PRINT_INIT(""); 
			LODOP.ADD_PRINT_TABLE(100,20,500,80,document.getElementById("scrollContent").innerHTML); 
			LODOP.SET_SAVE_MODE("Orientation",1); //Excel文件的页面设置：横向打印   1-纵向,2-横向;
			LODOP.SET_SAVE_MODE("LINESTYLE",1);//导出后的Excel是否有边框
			LODOP.SAVE_TO_FILE("${proteam.proteamname }${time }月份考勤排班.xls"); 
		};	

		//打印
		var LODOP; //声明为全局变量 
		function preview(){
			CreatePrintPage();
			LODOP.PREVIEW();
		}

		function print(){
			CreatePrintPage();
			LODOP.PRINT();	
		}

		function CreatePrintPage(){
			LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));  
			var strBodyStyle="<style>table,th,td{border:1 solid #000000;border-collapse:collapse}</style>";
			var strFormHtml=strBodyStyle+"<body>"+document.getElementById("scrollContent").innerHTML+"</body>";
			LODOP.PRINT_INITA(10,10,754,453,"打印控件操作");
			
			//LODOP.SET_PRINT_PAGESIZE (2, 0, 0,"A4");//设置页面打印方式
			LODOP.ADD_PRINT_TEXT(21,300,150,30,"考勤排班");
			LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.SET_PRINT_STYLEA(0,"Horient",2);
			LODOP.SET_PRINT_STYLEA(0,"Bold",1);
			//LODOP.ADD_PRINT_TEXT(40,60,350,30,"制表日期:${mainPlan.makeTime }  制表人:${mainPlan.makePeople }");
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.ADD_PRINT_HTM(63,38,684,330,strFormHtml);
			LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",4);
			LODOP.SET_PRINT_STYLEA(0,"Horient",3);
			LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
			LODOP.ADD_PRINT_LINE(53,23,52,725,0,1);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.SET_PRINT_STYLEA(0,"Horient",3);
			LODOP.ADD_PRINT_LINE(414,23,413,725,0,1);
			LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
			LODOP.SET_PRINT_STYLEA(0,"Horient",3);
			LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
			LODOP.ADD_PRINT_TEXT(421,542,165,22,"第#页/共&页");
			LODOP.SET_PRINT_STYLEA(0,"ItemType",2);
			LODOP.SET_PRINT_STYLEA(0,"Horient",1);
			LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
		}
	</script>
</head>
<body>
<div>
<div class="box2" panelTitle="考勤排班查询" roller="false">
   <table>
    <tr>
      <td>班组:</td>
      <td>
     	<select colNum="4" colWidth="80" name="proteamId" id="proteamId">
		  <option value="0">请选择班组</option>
	      <c:forEach var="proteam" items="${proteams}">
	         <option value="${proteam.proteamid }" <c:if test="${proteamId==proteam.proteamid }">selected="selected"</c:if>>${proteam.proteamname }</option>
	      </c:forEach>
		</select>
      </td>
      <td>时间：</td>
      <td><input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM'}))" name="time" value="${time }" id="time"/></td>
      <td><button onclick="queryWorkSet();"><span class="icon_find">排班查询 </span></button></td>
      <c:if test="${fn:containsIgnoreCase(sessionScope.session_user.roles,',GZ,')}">
	      <td><button onclick="addWorkSet();"><span class="icon_edit">考勤排班 </span></button></td>
	  </c:if>
      <c:if test="${!empty users}">
      	<td><button onclick="saveAsFile();"><span class="icon_xls">Excel导出 </span></button></td>
      	<td><button onclick="preview();"><span class="icon_print">打印预览</span></button></td>
		<td><button onclick="print();"><span class="icon_print">打印</span></button></td>
      </c:if>
    </tr>
  </table>
</div>
<div id="scrollContent">
  <c:if test="${!empty users}">
	<table class="tableStyle" style="text-align:center; margin-top:10px;">
		<tr>
			<th>工号</th>
		   	<th>姓名</th>
		   	<c:forEach var="day" begin="1" end="${days}">
		   		<th>${day }日</th>
		   	</c:forEach>
		</tr>
		<c:forEach var="user" items="${users}">
			<tr>
				<td>${user.gonghao }</td>
				<td>${user.xm }</td>
			<c:forEach var="tdNum1" begin="1" end="16">
				<td>
				    <span id="${user.gonghao }_${tdNum1}" style="color:blue;"></span>
				</td>
			</c:forEach>
			<c:forEach var="tdNum2" begin="17" end="${days}">
				<td>
					<span id="${user.gonghao }_${tdNum2}" style="color:blue;"></span>
				</td>
			</c:forEach>
		  </tr>
		</c:forEach>
	</table>
  </c:if>
</div>
</div>
<script type="text/javascript">
	$(function(){
		var selectStr="${selectStr}";//4068_1-1,3813_1-2,4068_3-2,3813_3-1,4068_31-2
		if(selectStr!=""){
			$("span").each(function(){
				var spanId=$(this).attr("id");
				var selectArray=selectStr.split(",");
				for(var i=0;i<selectArray.length;i++){
					var arrayId=selectArray[i].split("-");
					if(spanId==arrayId[0]){
						var result="";
						if(arrayId[1]=="1"){
							result="白";
						}else if(arrayId[1]=="2"){
							result="晚";
						}
						$(this).html(result);
						break;
					}
				}
			});
		}
	});
</script>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
</body>
</html>