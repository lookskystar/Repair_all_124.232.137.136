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
	<script type="text/javascript" src="js/jquery.form.js"></script>
	<!--框架必需end-->
	
	<script src="js/form/stepForm.js" type="text/javascript"></script>
	<!--引入组件start-->
	<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
	<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
	<!--引入弹窗组件end-->
	<script type="text/javascript" src="js/nav/ddaccordion.js"></script>
	<script type="text/javascript" src="js/text/text-overflow.js"></script>
	<!--修正IE6支持透明PNG图end-->
    <script type="text/javascript" src="js/attention/floatPanel.js"></script>
	<script type="text/javascript" src="js/attention/messager.js"></script>
	<!-- 解决IE6、7不兼容JSON.stringify问题 -->
	<script type="text/javascript" src="js/json2.js"></script>
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
		//设置打印页面属性：2：表示横向打印，0：定义纸张宽度，为0表示无效设置，A4：设置纸张为A4
		LODOP.SET_PRINT_PAGESIZE (2, 0, 0,"A4");
		//设置文本，参数(距离页面头部，距离页面左边距离，文本宽度，文本高度，文本内容)
		LODOP.ADD_PRINT_TEXT(21,300,300,30,"手工补签\n");
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
		LODOP.SAVE_TO_FILE("手工补签.xls"); 
	};	


//增加补签
function  addResign(){
	top.Dialog.open({
		URL:"<%=basePath%>signAction!addResignInput.do",
		Width:600,
		Height:320,
		Title:"新增签到记录"
	});
}

function editResign(){
	var signId=$("input[name='resign']:checked").val();
	if(signId != "" && signId != undefined && signId != null){
		var diag = new top.Dialog();
		diag.Title = "修改签到记录";
		diag.URL = 'signAction!editResignInput.do?signId='+signId;
		diag.Width=600;
		diag.Height=320;
		diag.show();
	}else{
		top.Dialog.alert("请选择要编辑的签到记录");
	}
}

</script>

</head>
<body>
<div class="box2" panelTitle="手工补出勤" roller="false">
	    <form action="signAction!queryresign.do" method="post">
	       <table>
		     <tr>
		     <td>班组:
	                  <select name="teamId" colNum="4" id="teamId">
					    <option value="">全部</option>
					    <c:forEach items="${dictProTeamList}" var="entry">
    	                   <option value="${entry.proteamid}" <c:if test="${entry.proteamid==teamId}">selected="selected"</c:if>>${entry.proteamname}</option>
    	                </c:forEach>
				      </select></td>
	           <td>姓名:<input type="text" style="width: 65px" name="xm" value="${xm }"/></td>
	           <td>工号:<input type="text" style="width: 65px" name="gonghao" value="${gonghao }"/></td>
	           <td>是否补签:
	                  <select name="isResign" class="default" id="isResign">
					    <option value="">全部</option>
					    <option value="0" <c:if test="${isResign==0}">selected="selected"</c:if>>否</option>
					    <option value="1" <c:if test="${isResign==1}">selected="selected"</c:if>>是</option>
				      </select></td>
	           <td>补签类型:
	                  <select name="reSignTypeId" class="default" id="reSignTypeId">
					    <option value="">全部</option>
					    <c:forEach items="${resignTypeList}" var="entry">
    	                   <option value="${entry.typeId}" <c:if test="${entry.typeId==reSignTypeId}">selected="selected"</c:if>>${entry.typeName}</option>
    	                </c:forEach>
				      </select></td>
	           <td>日期:<input type="text" name="beginTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${beginTime}" style="width: 100px;"/></td>
	           <td>至:<input type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${endTime}" style="width: 100px;"/></td>
               <td><button type="submit"><span class="icon_find">查询</span></button></td>
			  </tr >
			  <tr >
			     <td colspan="3">
				     <button  onclick="addResign();"><span class="icon_add">新增补签</span></button>&nbsp;
				     <button  onclick="editResign();"><span class="icon_edit">编辑补签</span></button>&nbsp;
		             <button  onclick="preview();"><span class="icon_print" >打印</span></button>&nbsp;
		             <button  onclick="SaveAsFile();"><span class="icon_xls">导出</span></button>
				 </td>
			  </tr>
			  </table>
		</form> 
</div >
<div id="scrollContent">
	<table width="100%" class="tableStyle"  useMultColor="true">
			<tr>
			    <th class="ver01" width="3%" align="center"></th>
			    <th class="ver01" width="8%" align="center">班组</th>
				<th class="ver01" width="6%" align="center">日期</th>
				<th class="ver01" width="7%" align="center">姓名</th>
				<th class="ver01" width="6%" align="center">工号</th>
				<th class="ver01" width="18%" align="center">签到时间</th>
				<th class="ver01" width="6%" align="center">补签类型</th>
				<th class="ver01" width="8%" align="center">操作员</th>
				<th class="ver01" width="10%" align="center">操作时间</th>
				<th class="ver01" width="28%" align="center">补签原因</th>
		<!-- 		<th class="ver01" width="5%" align="center">操作</th>    -->
			</tr>

	<c:if test="${!empty pm}">
		<c:forEach items="${pm}" var="resign" varStatus="idx">
		<tr>
			<td align="center">
			  <c:if test="${resign.signCount==2&&!(resign.signtimeA!=null&&resign.signtimeB!=null&&resign.signtimeC!=null&&resign.signtimeD!=null)||resign.signCount==1&&!(resign.signtimeA!=null&&resign.signtimeB!=null) }">
			  	<input id="signId" name="resign" type="radio" width="30px" value="${resign.signId }"/>
			  </c:if>
			</td>
			<td align="center"><span>
			   <c:forEach items="${dictProTeamList}" var="team">
					<c:if test="${team.proteamid == resign.proteamId}">
						${team.proteamname }
					</c:if>
			   </c:forEach></span></td>
			<td align="center"><span>${resign.day }</span></td>
			<td align="center"><span>${resign.xm }</span></td>
			<td align="center"><span>${resign.gonghao }</span></td>
			<td align="center"><span>
			<c:if test="${resign.signCount==2 }">
			     ${fn:substring(resign.signtimeA,11,16)}--${fn:substring(resign.signtimeB,11,16)}&nbsp;&nbsp;&nbsp;&nbsp;
			     ${fn:substring(resign.signtimeC,11,16)}--${fn:substring(resign.signtimeD,11,16)}
			</c:if>
			<c:if test="${resign.signCount==1}">${fn:substring(resign.signtimeA,11,16)}--${fn:substring(resign.signtimeB,11,16)}</c:if></span></td>
			<td align="center"><span>
			   <c:forEach items="${resignTypeList}" var="type">
					<c:if test="${type.typeId == resign.reSignTypeId}">
						${type.typeName }
					</c:if>
			   </c:forEach></span></td>
			<td align="center"><span>${resign.operator }</span></td>
			<td align="center"><span>${resign.operatorTime }</span></td>
			<td align="center"><span>${resign.resignReason }</span></td>
		<!--   <td align="center">
                <a href="javascript:void(0);" onclick="resume(${resign.signId });" style="color:blue;">详细</a>&nbsp;&nbsp;  
			    <a href="javascript:void(0);" onclick="delete(${resign.signId });" style="color:blue;">删除</a>			  
			</td>    -->
		</tr>
		</c:forEach>
		<tr><td colspan="11"></td></tr>
	</c:if>
	<c:if test="${empty pm}">
		<tr> 
		    <td class="ver01" align="center" colspan="10">没有相应的数据记录!</td>
		</tr>
	</c:if>
	</table>

       <link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	   <script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>

</html>