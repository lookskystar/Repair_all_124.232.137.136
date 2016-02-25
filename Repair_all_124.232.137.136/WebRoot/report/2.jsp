<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"/>
<!--框架必需start-->
<link href="<%=basePath %>css/test.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>js/tree/dtree/dtree.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=basePath %>js/test.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.floatDiv.js"></script>
<script type="text/javascript" src="<%=basePath %>js/menu.js"></script>
<script type="text/javascript" charset="UTF-8" src="<%=basePath %>js/float.js"></script>
<script type="text/javascript" charset="UTF-8" src="<%=basePath %>js/print.js"></script>



<style type="text/css"> 
	#nav, #nav ul{
	margin:0;
	padding:0;
	list-style-type:none;
	list-style-position:outside;
	position:relative;
	line-height:1.5em; 
	}
	
	#nav a{
	display:block;
	padding:0px 5px;
	border:1px solid #333;
	color:#fff;
	font-weight:bold;
	text-decoration:none;
	background-color:#328aa4;
	}
	
	#nav a:link{
	background-color:#328aa4;
	}
	
    /*#nav a:visited{
	background-color:#fff;
	color:blue;
	}*/
	
	#nav a:hover{
	background-color:#fff;
	color:red;
	}
	
	#nav li{
	float:left;
	position:relative;
	}
	
	#nav ul {
	position:absolute;
	display:none;
	width:12em;
	top:1.5em;
	}
	
	#nav li ul a{
	width:12em;
	height:auto;
	float:left;
	}
	
	#nav ul ul{
	top:auto;
	}	
	
	#nav li ul ul {
	left:12em;
	margin:0px 0 0 10px;
	}
	
	#nav li:hover ul ul, #nav li:hover ul ul ul, #nav li:hover ul ul ul ul{
	display:none;
	}
	#nav li:hover ul, #nav li li:hover ul, #nav li li li:hover ul, #nav li li li li:hover ul{
	display:block;
	}
</style>
<script type="text/javascript">
  	$(function(){
		$('#scoll_div_id').floatdiv("middletop");
	});
</script>


 <!-- 2015-5-19 黄亮 添加，打印插件 -->
<!-- 打印插件 -->
<script type="text/javascript" src="<%=basePath %>js/LodopFuncs.js"></script>
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0">  
       <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0"></embed> 
</object> 
<!-- 打印end -->
<!-- 打印插件js    开始 -->
<script type="text/javascript">
	function SaveAsFile(){ 
		//得到LODOP对象
		var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));   
		LODOP.PRINT_INIT(""); //初始化，因为不需要打印，所以不需要为其设置标题
		//增加打印表格,（距离头部距离、距离左边、宽度、高度），得到相应表格中的html元素
		LODOP.ADD_PRINT_TABLE(100,20,500,80,document.getElementById("content").innerHTML); 
		//设置相应模式
		LODOP.SET_SAVE_MODE("Orientation",1); //Excel文件的页面设置：横向打印   1-纵向,2-横向;
		LODOP.SET_SAVE_MODE("LINESTYLE",1);//导出后的Excel是否有边框
		LODOP.SET_SAVE_MODE("CAPTION","行安检修记录");//标题栏文本内容
		//LODOP.SET_SAVE_MODE("CENTERHEADER","行安检修记录");//页眉内容
		//LODOP.SET_SAVE_MODE("PaperSize",9);  //Excel文件的页面设置：纸张大小   9-对应A4
		//LODOP.SET_SAVE_MODE("Zoom",90);       //Excel文件的页面设置：缩放比例
		//LODOP.SET_SAVE_MODE("CenterHorizontally",true);//Excel文件的页面设置：页面水平居中
		//LODOP.SET_SAVE_MODE("CenterVertically",true); //Excel文件的页面设置：页面垂直居中
		//LODOP.SET_SAVE_MODE("QUICK_SAVE",true);//快速生成（无表格样式,数据量较大时或许用到） 
		//保存文件，以窗口弹出对话框的方式，让用户去选择文件保存的位置，参数为文件保存的默认名称
		LODOP.SAVE_TO_FILE("${datePlan.jcType }-${datePlan.jcnum }-${unitType}检修记录.xls"); 
	};	

	var LODOP; //声明为全局变量 
	function preview(){
		CreatePrintPage();
		//打印预览
		LODOP.PREVIEW();
	}

	function setup(){
		CreatePrintPage();
		//LODOP.PRINT_SETUP();
		LODOP.PRINT_DESIGN();//打印设置
	}

	function print(){
		CreatePrintPage();
		LODOP.PRINT();	//打印
	}

	//初始化页面
	function CreatePrintPage(){
		//得到LODOP对象，注意head标签里面需引入object和embed标签
		LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
		//封装我们的html元素  
		var strBodyStyle="<style>table,td{border:1 solid #000000;border-collapse:collapse}</style>";
		var strFormHtml=strBodyStyle+"<body>"+document.getElementById("content").innerHTML+"</body>";
		//打印初始化，页面距离顶部10px，距离左边10px，宽754px，高453px，给打印设置个标题
		LODOP.PRINT_INITA(10,10,754,453,"打印控件操作");
		//设置打印页面属性：2：表示横向打印，0：定义纸张宽度，为0表示无效设置，A4：设置纸张为A4
		LODOP.SET_PRINT_PAGESIZE (2, 0, 0,"A4");
		//设置文本，参数(距离页面头部，距离页面左边距离，文本宽度，文本高度，文本内容)
		LODOP.ADD_PRINT_TEXT(21,300,300,30,"${unitType}${flowval }检修记录\n");
		//给所添加的文本定义样式,0：表示新添加的元素，相应的属性，相应的值
		LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);//固定标题,设置卫页眉页脚
		LODOP.SET_PRINT_STYLEA(0,"Horient",2);
		LODOP.SET_PRINT_STYLEA(0,"Bold",1);
		//同上
		LODOP.ADD_PRINT_TEXT(40,60,350,30,"机车号:${datePlan.jcType } ${datePlan.jcnum }  修程:${datePlan.fixFreque}  检修日期:${datePlan.kcsj }");
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		//添加html元素
		LODOP.ADD_PRINT_HTM(63,38,684,330,strFormHtml);
		LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",4);
		LODOP.SET_PRINT_STYLEA(0,"Horient",3);
		LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
		//添加一条线，参数(开始短点距离头部距离，开始端点距左边距离，结束端点距头部距离，结束端点距左边距离)
		LODOP.ADD_PRINT_LINE(53,23,52,725,0,1);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		LODOP.SET_PRINT_STYLEA(0,"Horient",3);
		LODOP.ADD_PRINT_LINE(414,23,413,725,0,1);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		LODOP.SET_PRINT_STYLEA(0,"Horient",3);
		LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
		//LODOP.ADD_PRINT_TEXT(421,37,144,22,"左下脚的文本小标题");
		//LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
		LODOP.ADD_PRINT_TEXT(421,542,165,22,"第#页/共&页");
		LODOP.SET_PRINT_STYLEA(0,"ItemType",2);
		LODOP.SET_PRINT_STYLEA(0,"Horient",1);
		LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
	}
</script>
<!-- 打印插件js    结束 -->


<title>
<!-- 临修记录查看页面 -->
${flowval }
检修记录
</title>
</head>

<body bgcolor="#f8f7f7">

<div id="scoll_div_id" style="background:#328aa4;width:864px;height:23px;">
<ul id="nav">
    <li><a href="<%=basePath%>query!getInfoByJC.do?rjhmId=${datePlan.rjhmId}"  style="background-color:#fff;color:blue;">◇整车记录 </a></li>
    <li><a href="javascript:void(0);">◇检修班组</a>
       <ul>
           <c:forEach items="${bzs}" var="bz" varStatus="index">
            <li><a href="<%=basePath%>query!getInfoByBZ.do?rjhmId=${datePlan.rjhmId }&teamId=${bz.proteamid }">${bz.proteamname }</a></li>
           </c:forEach>
      </ul>
    </li>
    <!-- 2015-5-11 黄亮 改，临修不需要交车试验和交车竣工 -->
	<!-- <li><a href="<%=basePath%>query!searchJcRec.do?rjhmId=${datePlan.rjhmId}">◇交车试验</a></li>-->
    <li><a href="<%=basePath %>query!getAllInfoPre.do?rjhmId=${datePlan.rjhmId}">◇报活记录</a></li>
    <!-- 2015-5-19 黄亮 添加，记录导出功能 -->
    <li><a href="javascript:void(0);" onclick="SaveAsFile();">◇记录导出 </a></li>
    <!-- 2015-5-11 黄亮 改，临修不需要交车试验和交车竣工 -->
    <!--<li><a href="<%=basePath%>query!searchJCjungong.do?rjhmId=${datePlan.rjhmId }">◇交车竣工 </a></li>-->
      <!-- 2015-5-19 黄亮 添加，打印功能 -->
     <li><a href="javascript:void(0);">◇打印 </a>
        <ul>
            <li><a href="javascript:void(0);" onclick="setup();">打印设置</a></li>
            <li><a href="javascript:void(0);" onclick="preview();">打印预览</a></li>
            <li><a href="javascript:void(0);" onclick="print();">直接打印</a></li>
      </ul>
    </li>
</ul>
</div>
<br><br>
<!-- 浮动导航菜单end -->
<br/>
<table width="800" border="0" align="center" cellspacing="0" vspace="0">
<tr>
<td colspan="5" align="center"><h2 align="center"><font>
<b>${flowval }&nbsp;&nbsp;
检修记录</b></h2></td>
</tr>
<tr>
<td  align="left" colspan="4">修程：${datePlan.fixFreque }</td>
<td  align="right"><a href="query!findXXJCPJ.do?rjhmId=${datePlan.rjhmId }" style="color:blue;" target="_blank">查看配件检修记录</a></td>
</tr>
<tr><td colspan="6">
<table id="content" width="860" border="0" align="center" cellspacing="0" vspace="0" >
 <tr>
	<td align="center" colspan="3" class="tbCELL3">
	<!-- 2015-5-19    黄亮 添加行内样式style="font-size:10pt;"，设置导出Execl字体大小，Execl字体大小必须是行内样式 -->
  <table width="860" border="0" align="center" cellspacing="0" vspace="0" style="font-size:10pt;">
    <tr style="background-color: #328aa4;font-weight: bolder;line-height:40px;height: 40px;">
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">机车型号</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">报活部位</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">报活情况</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">报活人</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">审批人</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">接收人</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">检修人</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">检修情况</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">工长</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">交车工长</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">质检员</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">技术员</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">验收员</td>
      <td class="tbCELL1" align="center" nowrap="nowrap" style="color:#ffffff;">故障备注</td>
    </tr>
    <c:forEach var="rec" items="${preDictRecs }">
    <tr>
      <td class="tbCELL1" align="center">${datePlan.jcType } ${datePlan.jcnum }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.repPosi }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.repsituation }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.repemp }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.verifier }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.receiptPeo }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.fixEmp }&nbsp;</td>
      <td class="tbCELL1" align="center">${rec.dealSituation }&nbsp;
          <c:if test="${!empty rec.upPjNum}">
              <br/>
              <c:forTokens items="${rec.upPjNum }" delims="," var="num">
					<a href="query!findPjRecordByPjNum.do?rjhmId=${datePlan.rjhmId}&pjNum=${num}" target="_blank" style="color:blue;">${num }</a>&nbsp;
				</c:forTokens>
          </c:if>
      </td>
      <td class="tbCELL1" align="center">${rec.lead }<br><c:if test="${!empty rec.ldAffirmTime}">${fn:substring(rec.ldAffirmTime, 5, 16) }</c:if></td>
	  <td class="tbCELL1" align="center">${rec.commitLd }<br><c:if test="${!empty rec.comLdAffiTime}">${fn:substring(rec.comLdAffiTime, 5, 16) }</c:if></td>
	  <td class="tbCELL1" align="center">${rec.qi }<br><c:if test="${!empty rec.qiAffiTime}">${fn:substring(rec.qiAffiTime, 5, 16) }</c:if></td>
	  <td class="tbCELL1" align="center">${rec.technician }<br><c:if test="${!empty rec.techAffiTime}">${fn:substring(rec.techAffiTime, 5, 16) }</c:if></td>
	  <td class="tbCELL1" align="center">${rec.accepter }<br><c:if test="${!empty rec.acceTime}">${fn:substring(rec.acceTime, 5, 16) }</c:if></td>
	  <td class="tbCELL1" align="center">${rec.failNum}&nbsp;</td>
    </tr>
    </c:forEach>
  </td>
  </tr>
  </table>
  </td>
  </tr>
  </table>
</body>
</html>