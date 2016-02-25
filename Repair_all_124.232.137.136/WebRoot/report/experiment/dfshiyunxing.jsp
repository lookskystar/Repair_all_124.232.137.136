<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>report/">
<title>内燃试运行试验检修记录</title>
<link href="<%=basePath %>css/test.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath %>js/tree/dtree/dtree.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=basePath %>js/test.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jquery.floatDiv.js"></script>
<script type="text/javascript" src="<%=basePath %>js/menu.js"></script>
	<!-- 打印插件 -->
<script type="text/javascript" src="<%=basePath %>js/LodopFuncs.js"></script>
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed> 
</object> 
	<!-- 打印end -->
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
	//合并表格的单元格
	function cellMege(table,col){
		var lines=$('#'+table+' tr').size();
		if(lines<=2) return ;
		var v,l=0,current='',index=1;
		for(var i=1;i<lines;i++){
			var tr=$('#'+table+' tr').eq(i);
			v=tr.find('td[name="'+col+'"]').html();
			//alert(tr.find('td[name="secondname"]').size());
			l++;
			//alert(v);
			if(v!=current||i==(lines-1)){//如果两个值不相同或者是最后一行
				if(i==(lines-1)) l++;
				if(l>1){//草果两行，合并
					var td=$('#'+table+' tr').eq(index).find('td[name="'+col+'"]');
					td.attr('rowspan',l);
					for(var j=1;j<l;j++){
						var td=$('#'+table+' tr').eq(index+j).find('td[name="'+col+'"]').remove();
					}
				}
				l=0;//从新计数
				current=v;
				index=i;
			}
		}
	}
	$(function(){
		cellMege('datatabel','firstname');
		cellMege('datatabel','secondname');
		cellMege('datatabel','fixitemname');
		$('#scoll_div_id').floatdiv("middletop");
	});

   function SaveAsFile(){ 
		var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));   
		LODOP.PRINT_INIT(""); 
		LODOP.ADD_PRINT_TABLE(100,20,500,80,document.getElementById("content").innerHTML); 
		LODOP.SET_SAVE_MODE("Orientation",1); //Excel文件的页面设置：横向打印   1-纵向,2-横向;
		LODOP.SET_SAVE_MODE("LINESTYLE",1);//导出后的Excel是否有边框
		LODOP.SAVE_TO_FILE("${datePlan.jcType }-${datePlan.jcnum }中修试运记录.xls"); 
	};	

	var LODOP; //声明为全局变量 
	function preview(){
		CreatePrintPage();
		LODOP.PREVIEW();
	}

	function setup(){
		CreatePrintPage();
		LODOP.PRINT_DESIGN();
	}

	function print(){
		CreatePrintPage();
		LODOP.PRINT();	
	}

	function CreatePrintPage(){
		LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));  
		var strBodyStyle="<style>table,td{border:1 solid #000000;border-collapse:collapse}</style>";
		var strFormHtml=strBodyStyle+"<body>"+document.getElementById("content").innerHTML+"</body>";
		LODOP.PRINT_INITA(10,10,754,453,"打印控件操作");
		LODOP.SET_PRINT_PAGESIZE (2, 0, 0,"A4");
		LODOP.ADD_PRINT_TEXT(21,300,300,30,"${datePlan.jcType }-${datePlan.jcnum }中修试运记录\n");
		LODOP.SET_PRINT_STYLEA(0,"FontSize",15);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		LODOP.SET_PRINT_STYLEA(0,"Horient",2);
		LODOP.SET_PRINT_STYLEA(0,"Bold",1);
		LODOP.ADD_PRINT_TEXT(40,30,350,30,"机车号:${datePlan.jcType } ${datePlan.jcnum }  修程:${datePlan.fixFreque}  检修日期:${datePlan.kcsj }");
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
		//LODOP.ADD_PRINT_TEXT(421,37,144,22,"左下脚的文本小标题");
		//LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
		LODOP.ADD_PRINT_TEXT(421,542,165,22,"第#页/共&页");
		LODOP.SET_PRINT_STYLEA(0,"ItemType",2);
		LODOP.SET_PRINT_STYLEA(0,"Horient",1);
		LODOP.SET_PRINT_STYLEA(0,"Vorient",1);
	}
</script>
<style type="text/css">
	TABLE.bluetable {
		FONT: 100% Arial, Helvetica, sans-serif
	}
	TD {
		FONT: 100% Arial, Helvetica, sans-serif
	}
	TABLE.bluetable {
		MARGIN: 0.1em 0px; BORDER-COLLAPSE: collapse
	}
	TABLE.bluetable TH {
		BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: left; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
	}
	TABLE.bluetable TD {
		BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: center; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
	}
	TABLE.bluetable TH {
		BACKGROUND: url(images/tr_back.gif) #328aa4 repeat-x; COLOR: #fff
	}
	TABLE.bluetable TD {
		BACKGROUND: #FFFFFF
	}
	TABLE.bluetable TR.even TD {
		BACKGROUND: #e5f1f4
	}
	TABLE.bluetable TR.odd TD {
		BACKGROUND: #f8fbfc
	}
	TABLE.bluetable TH.over {
		BACKGROUND: #4a98af
	}
	TABLE.bluetable TR.even TH.over {
		BACKGROUND: #4a98af
	}
	TABLE.bluetable TR.odd TH.over {
		BACKGROUND: #4a98af
	}
	TABLE.bluetable TH.down {
		BACKGROUND: #bce774
	}
	TABLE.bluetable TR.even TH.down {
		BACKGROUND: #bce774
	}
	TABLE.bluetable TR.odd TH.down {
		BACKGROUND: #bce774
	}
	TABLE.bluetable TH.selected {
		
	}
	TABLE.bluetable TR.even TH.selected {
		
	}
	TABLE.bluetable TR.odd TH.selected {
		
	}
	TABLE.bluetable TD.over {
		BACKGROUND: #ecfbd4
	}
	TABLE.bluetable TR.even TD.over {
		BACKGROUND: #ecfbd4
	}
	TABLE.bluetable TR.odd TD.over {
		BACKGROUND: #ecfbd4
	}
	TABLE.bluetable TD.down {
		BACKGROUND: #bce774; COLOR: #fff
	}
	TABLE.bluetable TR.even TD.down {
		BACKGROUND: #bce774; COLOR: #fff
	}
	TABLE.bluetable TR.odd TD.down {
		BACKGROUND: #bce774; COLOR: #fff
	}
	TABLE.bluetable TD.selected {
		BACKGROUND: #bce774; COLOR: #555
	}
	TABLE.bluetable TR.even TD.selected {
		BACKGROUND: #bce774; COLOR: #555
	}
	TABLE.bluetable TR.odd TD.selected {
		BACKGROUND: #bce774; COLOR: #555
	}
	TABLE.bluetable TD.empty {
		BACKGROUND: #fff
	}
	TABLE.bluetable TR.odd TD.empty {
		BACKGROUND: #fff
	}
	TABLE.bluetable TR.even TD.empty {
		BACKGROUND: #fff
	}
</style>
</head>

<body bgcolor="#f8f7f7">
<form id="form1" name="form1" method="post" action="">
  <!-- 浮动导航菜单start -->
<div id="scoll_div_id" style="background:#328aa4;width:864px;height:23px;">
<ul id="nav">
    <li><a href="javascript:void(0);">◇整车记录 </a>
       <ul>
         <li><a href="<%=basePath%>query!getZxInfoByJC.do?rjhmId=${datePlan.rjhmId}&psize=100">整车检修记录</a></li>
         <li><a href="<%=basePath%>query!findJCAll.do?rjhmId=${datePlan.rjhmId}&jcStype=${datePlan.jcType }">检修配件记录</a></li>
       </ul>
    </li>
    <li><a href="javascript:void(0);">◇机车部件</a>
      <ul>
            <c:forEach items="${units}" var="unit">
               <li><a href="<%=basePath%>query!zxView.do?rjhmId=${datePlan.rjhmId}&fristUnit=${unit.firstunitid }">${unit.firstunitname }</a></li>
            </c:forEach>
      </ul>
    </li>
    <li><a href="javascript:void(0);">◇检修班组</a>
       <ul>
            <c:forEach items="${bzs}" var="bz" varStatus="index">
	            <li><a href="<%=basePath %>query!getZxInfoByBZ.do?rjhmId=${datePlan.rjhmId}&workFlag=1&teamId=${bz.proteamid}">${bz.proteamname }</a></li>
            </c:forEach>
      </ul>
    </li>
    <li><a href="javascript:void(0);" style="background-color:#fff;color:blue;">◇试验记录</a>
       <ul>
            <li><a href="<%=basePath%>query!viewExperiment.do?id=${datePlan.rjhmId}&jceiId=2">水阻试验</a></li>
            <li><a href="<%=basePath%>query!viewExperiment.do?id=${datePlan.rjhmId}&jceiId=5">顶轮试验</a></li>
            <li><a href="<%=basePath%>query!viewExperiment.do?id=${datePlan.rjhmId}&jceiId=4">高低压试验</a></li>
            <li><a href="<%=basePath%>query!viewExperiment.do?id=${datePlan.rjhmId}&jceiId=3" style="background-color:#fff;color:blue;">试运行试验</a></li>
      </ul>
    </li>
    <li><a href="<%=basePath%>query!findJCPJ.do?rjhmId=${datePlan.rjhmId}">◇配件记录</a></li>
    <li><a href="<%=basePath%>query!findJCTS.do?rjhmId=${datePlan.rjhmId}">◇探伤记录</a></li>
    <li><a href="<%=basePath%>query!listZXLeftWorkRecord.do?rjhmId=${datePlan.rjhmId }">◇未完成记录 </a></li>
    <li><a href="<%=basePath %>query!getAllInfoPre.do?rjhmId=${datePlan.rjhmId}">◇报活记录</a></li>
    <li><a href="<%=basePath%>query!searchJCjungong.do?rjhmId=${datePlan.rjhmId }">◇交车竣工 </a></li>
    <li><a href="javascript:void(0);" onclick="SaveAsFile();">◇记录导出 </a></li>
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
<center>
   <div id="content">
	<table width="924" height="591" border="1" cellpadding="0" cellspacing="0" class="bluetable">
   <tr>
 <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 24px;font-weight: bolder;" colspan="14">
    	<span style="font-size: 16px; font-weight: bold;">${datePlan.jcType }型机车中修试运记录</span>
    </th>
  </tr>
  
  <tr>
    <td height="19" width="994">车号</td>
    <td height="19" colspan="2" width="994">${datePlan.jcnum}</td>
    <td height="19" width="994">修次</td>
    <td height="19" colspan="2" width="994">${datePlan.fixFreque}</td>
    <td height="19" colspan="2" width="994">试运日期</td>
    <td colspan="2" height="19" width="994">${experiment.empAffirmTime}</td>
    <td height="19" colspan="2">吨位</td>
    <td height="19" colspan="2">${jceis.a1}</td>
  </tr>
  <tr>
    <td rowspan="2" height="38" width="994">试运人员</td>
    <td height="38" width="994">司机</td>
    <td height="38" width="994">副司机</td>
    <td height="38" width="994">技术科 </td>
    <td height="38" width="994">验收室</td>
    <td height="38" width="994">传动</td>
    <td height="38" width="994">柴总</td>
    <td height="38" width="994">燃系</td>
    <td height="38" colspan="2" width="994">制动</td>
    <td height="38" colspan="2" width="994">走行</td>
    <td height="38" colspan="2" width="994">电器</td>
  </tr>
  <tr>
    <td height="19" width="994">${jceis.a2}</td>
    <td height="19" width="994">${jceis.a3}</td>
    <td height="19" width="994">${jceis.a4}</td>
    <td height="19" width="994">${jceis.a5}</td>
    <td height="19" width="994">${jceis.a6}</td>
    <td height="19" width="994">${jceis.a7}</td>
    <td height="19" width="994">${jceis.a8}</td>
    <td height="19" colspan="2" width="994">${jceis.a9}</td>
    <td height="19" colspan="2" width="994">${jceis.a10}</td>
    <td height="19" colspan="2" width="994">${jceis.a11}</td>
  </tr>
  <tr>
    <td colspan="14" height="19" width="994">功率情况</td>
  </tr>
  <tr>
    <td height="19" width="994">主发电流</td>
    <td colspan="2" height="19" width="994">主发电流</td>
    <td colspan="2" height="19" width="994">主发电压</td>
    <td colspan="2" height="19" width="994">供油刻线</td>
    <td colspan="2" height="19" width="994">油马达位置</td>
    <td colspan="5" height="19" width="994">燃油压力</td>
  </tr>
  <tr>
    <td height="19" width="994">8位（700转/分）</td>
    <td colspan="2" height="19" width="994">${jceis.B1b1}A</td>
    <td colspan="2" height="19" width="994">${jceis.B1b2}V</td>
    <td colspan="2" height="19" width="994">${jceis.B1b3}刻</td>
    <td colspan="2" height="19" width="994">${jceis.B1b4}格</td>
    <td colspan="5" height="19" width="994">${jceis.B1b5}Kpa</td>
  </tr>
  <tr>
    <td height="19" width="994">12位（850转/分）</td>
    <td colspan="2" height="19" width="994">${jceis.B2b1}A</td>
    <td colspan="2" height="19" width="994">${jceis.B2b2}V</td>
    <td colspan="2" height="19" width="994">${jceis.B2b3}刻</td>
    <td colspan="2" height="19" width="994">${jceis.B2b4}格</td>
    <td colspan="5" height="19" width="994">${jceis.B2b5}Kpa</td>
  </tr>
  <tr>
    <td height="19" width="994">16位（1000转/分）</td>
    <td colspan="2" height="19" width="994">${jceis.B3b1}A</td>
    <td colspan="2" height="19" width="994">${jceis.B3b2}V</td>
    <td colspan="2" height="19" width="994">${jceis.B3b3}刻</td>
    <td colspan="2" height="19" width="994">${jceis.B3b4}格</td>
    <td colspan="5" height="19" width="994">${jceis.B3b5}Kpa</td>
  </tr>
  <tr>
    <td rowspan="2" height="40" width="994">过渡点</td>
    <td rowspan="2" height="40" width="994">一级</td>
    <td height="19" width="994">吸合</td>
    <td height="19" colspan="11" style="text-align: left;padding-left: 20px;">${jceis.c1}</td>
  </tr>
  <tr>
    <td height="19" width="994">释放</td>
    <td height="19" colspan="11" style="text-align: left;padding-left: 20px;">${jceis.c2}</td>
  </tr>
  
  <tr>
    <td colspan="7" height="19" width="994">分  流  情  况 </td>
    <td colspan="7" height="19" width="994">抱 轴 承 情 况（温度    ℃）</td>
  </tr>
  <tr>
    <td height="19" width="994"></td>
    <td height="19" width="994">1D</td>
    <td height="19" width="994">2D</td>
    <td height="19" width="994">3D</td>
    <td height="19" width="994">4D</td>
    <td height="19" width="994">5D</td>
    <td height="19" width="994">6D</td>
    <td height="19" width="994"></td>
    <td height="19" width="994">1D</td>
    <td height="19" width="994">2D</td>
    <td height="19" width="994">3D</td>
    <td height="19" width="994">4D</td>
    <td height="19" width="994">5D</td>
    <td height="19" width="994">6D</td>
  </tr>
  <tr>
    <td height="19" width="994">全磁场</td>
    <td height="19" width="994">${jceis.D1d1}</td>
    <td height="19" width="994">${jceis.D1d2}</td>
    <td height="19" width="994">${jceis.D1d3}</td>
    <td height="19" width="994">${jceis.D1d4}</td>
    <td height="19" width="994">${jceis.D1d5}</td>
    <td height="19" width="994">${jceis.D1d6}</td>
    <td height="19" width="994">左</td>
    <td height="19" width="994">${jceis.E1e1}</td>
    <td height="19" width="994">${jceis.E1e2}</td>
    <td height="19" width="994">${jceis.E1e3}</td>
    <td height="19" width="994">${jceis.E1e4}</td>
    <td height="19" width="994">${jceis.E1e5}</td>
    <td height="19" width="994">${jceis.E1e6}</td>
  </tr>
  <tr>
    <td height="19" width="994">一  级</td>
    <td height="19" width="994">${jceis.D2d1}</td>
    <td height="19" width="994">${jceis.D2d2}</td>
    <td height="19" width="994">${jceis.D2d3}</td>
    <td height="19" width="994">${jceis.D2d4}</td>
    <td height="19" width="994">${jceis.D2d5}</td>
    <td height="19" width="994">${jceis.D2d6}</td>
    <td height="19" width="994">右</td>
    <td height="19" width="994">${jceis.E2e1}</td>
    <td height="19" width="994">${jceis.E2e2}</td>
    <td height="19" width="994">${jceis.E2e3}</td>
    <td height="19" width="994">${jceis.E2e4}</td>
    <td height="19" width="994">${jceis.E2e5}</td>
    <td height="19" width="994">${jceis.E2e6}</td>
  </tr>
  <tr>
    <td height="19" width="994">二  级</td>
    <td height="19" width="994">${jceis.D3d1}</td>
    <td height="19" width="994">${jceis.D3d2}</td>
    <td height="19" width="994">${jceis.D3d3}</td>
    <td height="19" width="994">${jceis.D3d4}</td>
    <td height="19" width="994">${jceis.D3d5}</td>
    <td height="19" width="994">${jceis.D3d6}</td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
    <td height="19" width="994"></td>
  </tr>
  <tr>
    <td height="50" width="994">试运中其他情况</td>
    <td colspan="13" align="left" style="text-align: left;padding-left: 20px;">
    	${jceis.f1}
    </td>
  </tr>
  <tr>
    <td height="19" width="994" rowspan="2">试验人员</td>
    <td height="19" width="994" colspan="3">工人</td>
    <td height="19" width="994" colspan="2">工长</td>
    <td height="19" width="994" colspan="2">质检员</td>
    <td height="19" width="994" colspan="2">技术员</td>
    <td height="19" width="994" colspan="2">交车工长</td>
    <td height="19" width="994" colspan="2">验收员</td>
  </tr>
  <tr>
    <td height="19" width="994" colspan="3">${fn:substring(experiment.fixEmp,0,fn:length(experiment.fixEmp)-1)}</td>
    <td height="19" width="994" colspan="2">${experiment.leader}</td>
    <td height="19" width="994" colspan="2">${experiment.qi}</td>
    <td height="19" width="994" colspan="2">${experiment.teachName}</td>
    <td height="19" width="994" colspan="2">${experiment.commitLead}</td>
    <td height="19" width="994" colspan="2">${experiment.accepter}</td>
  </tr>
</table>
</div>
</center>
</form>
</body>
</html>