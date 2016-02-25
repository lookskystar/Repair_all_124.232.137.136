<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <base href="<%=basePath%>"/>
	<!--框架必需start-->
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/framework.js"></script>
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>"/>
	<!--框架必需end-->
	
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--修正IE6支持透明PNG图start-->
    <script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
    <!--修正IE6支持透明PNG图end-->
    <script type="text/javascript" src="js/form/loadmask.js"></script>
    
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
			var strFormHtml=strBodyStyle+"<body>"+document.getElementById("scroll").innerHTML+"</body>";
			LODOP.PRINT_INITA(10,10,754,453,"打印控件操作");
			//设置打印页面属性：2：表示横向打印，0：定义纸张宽度，为0表示无效设置，A4：设置纸张为A4
			LODOP.SET_PRINT_PAGESIZE (2, 0, 0,"A4");
			//设置文本，参数(距离页面头部，距离页面左边距离，文本宽度，文本高度，文本内容)
			LODOP.ADD_PRINT_TEXT(21,300,300,30,"${month }考勤汇总\n");
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
			LODOP.ADD_PRINT_TABLE(100,20,500,80,document.getElementById("scroll").innerHTML); 
			LODOP.SET_SAVE_MODE("Orientation",1); //Excel文件的页面设置：横向打印   1-纵向,2-横向;
			LODOP.SET_SAVE_MODE("LINESTYLE",1);//导出后的Excel是否有边框
			LODOP.SAVE_TO_FILE("${month }考勤汇总.xls"); 
		};	


		//根据班组得到人员信息
		function getUserName(){
			   var teamId=$("#teamId").val();
			   if(teamId!=""){
				   $.post("<%=basePath%>signAction!ajaxGetTeamUser.do",{"teamId":teamId},function(data){
		               var result=eval("("+data+")");
		               var users=result.users;
		               var str="<option value=''>全部</option>";
		               for(var i=0;i<users.length;i++){
		                   str+="<option value="+users[i].xm+">"+users[i].xm+"</option>";
		               }
		               $("#xm").children().remove();
		               $("#xm").append(str);
		           });
			   }
		   }

		function resume(gonghao,day_temp){
			var day;
			var date;
			if(day_temp<10){
				day="-0"+day_temp;
			}else{
				day="-"+day_temp;
			}
		    var month=$("#month").val();
		   	date=month+day;
	   		top.Dialog.open({
				URL:"<%=basePath%>signAction!querysignInfo.do?gonghao="+gonghao+"&date="+date,
				Width:600,
				Height:580,
				Title:"查看签到详情"
			});
	   }

	   function queryByXm(){
			var teamId=$("#teamId").val()==undefined?"":$("#teamId").val();
			var xm=$("#xm").val()==undefined?"":$("#xm").val();
			var gonghao=$("#gonghao").val()==undefined?"":$("#gonghao").val();
			var month=$("#month").val()==undefined?"":$("#month").val();
			window.location.href="<%=basePath%>signAction!queryKQMonthByXm.do?teamId="+teamId+"&gonghao="+gonghao+"&xm="+xm+"&month="+month;
		}

	   function query(){
		    $("#scroll").mask("正在查询...");
			var teamId=$("#teamId").val()==undefined?"":$("#teamId").val();
			var xm=$("#xm").val()==undefined?"":$("#xm").val();
			var gonghao=$("#gonghao").val()==undefined?"":$("#gonghao").val();
			var month=$("#month").val()==undefined?"":$("#month").val();
			window.location.href="<%=basePath%>signAction!queryKQMonth.do?teamId="+teamId+"&gonghao="+gonghao+"&xm="+xm+"&month="+month;
		}

	</script>

</head>
<body>
<div id="scrollContent">
<div class="box2" panelTitle="考勤月详情" roller="false">
	   <table>
		     <tr>
		       <td>班组:<select name="teamId" colNum="4" id="teamId" onchange="getUserName();">
		                <option value="">全部</option>
					    <c:forEach items="${dictProTeamList}" var="entry">
    	                   <option value="${entry.proteamid}" <c:if test="${entry.proteamid==teamId}">selected="selected"</c:if>>${entry.proteamname}</option>
    	                </c:forEach>
				      </select></td>
	           <td>姓名:
	           	<select id="xm"  name="xm"  class="default" >
	              <option value="">全部</option>
	            </select></td>
	           <td>工号:<input type="text" style="width: 65px" name="gonghao" id="gonghao"  value="${gonghao }"/></td>
	           <td>月份:<input type="text" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM'}))" name="month" value="${month }" id="month" style="width: 90px;"/></td>
               <td><button onclick="queryByXm();"><span class="icon_find">查询</span></button></td>
               <td><button onclick="query();"  id="process"><span class="icon_mark">汇总展示</span></button></td>
			  </tr >
			  <tr >
			     <td colspan="4">
				     <button  onclick="preview();"><span class="icon_print" >打印</span></button>&nbsp;
		             <button  onclick="SaveAsFile();"><span class="icon_xls">导出</span></button>
				 </td>
			  </tr>
	   </table>
</div >
<div style="overflow-x:auto;width:100%;" id="scroll">
<div style="width:1200px;">
	<table border="1"  class="tableStyle" headFixMode="true"  useMultColor="true" >
	<c:if test="${!empty monthCount}">
	  <c:forEach var="map" items="${monthCount}">
			<tr>
				<td colspan="2" align="center">${map.base.proteamName }</td>
	   	     	<td colspan="2" align="center">${map.base.xm }</td>
	   	     	<td colspan="2" align="center">${map.base.gonghao }</td>
	   	     	<td colspan="10" align="left">${month }月</td>
			</tr>
			<tr align="center">
				<c:forEach begin="1" end="16" step="1" var="key">
					<td style="width:75px;">${key}</td>
				</c:forEach>
			</tr>	
			<tr>
				<c:forEach begin="1" end="16" step="1" var="key">
					<td onclick="resume('${map.base.gonghao }','${key}');">${map[key]}</td>
				</c:forEach>
			</tr>
			<tr align="center">
				<c:forEach begin="17" end="${maxMonthDay}" step="1" var="key">
					<td>${key}</td>
				</c:forEach>
				<c:forEach begin="${maxMonthDay+1}" end="32">
					<td></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach begin="17" end="${maxMonthDay}" step="1" var="key">
					<td onclick="resume('${map.base.gonghao }','${key}');">${map[key]}</td>
				</c:forEach>
				<c:forEach begin="${maxMonthDay+1}" end="32">
					<td></td>
				</c:forEach>
			</tr>
		    <tr><td colspan="16"></td></tr>	
	    </c:forEach>
	    </c:if>
	    <c:if test="${empty monthCount}">
	           <tr><td align="center" colspan="20">没有相应的数据信息!</td></tr>
	    </c:if>
	 </table>
	 </div>
</div>
</div>
       <link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	   <script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>

</html>