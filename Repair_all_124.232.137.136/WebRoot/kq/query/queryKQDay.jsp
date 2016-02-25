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
			LODOP.ADD_PRINT_TEXT(21,300,300,30,"考勤日报\n");
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
			LODOP.SAVE_TO_FILE("考勤日报.xls"); 
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


		// 查看
		function resume(signId){
			top.Dialog.open({URL:"<%=basePath%>signAction!signInfoListInput.do?signId="+signId,Width:600,Height:580,Title:"查看签到详情"});
		}
	</script>

</head>
<body>
<div class="box2" panelTitle="考勤日报" roller="false">
	   <table>
	       <form action="signAction!queryKQDay.do" method="post">
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
	           <td>工号:<input type="text" style="width: 65px" name="gonghao" value="${gonghao }"/></td>
	                
	           <td>开始时间:<input type="text" name="beginTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${beginTime}" style="width: 100px;"/></td>
	           <td>结束时间:<input type="text" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))" value="${endTime}" style="width: 100px;"/></td>
               <td><button type="submit"><span class="icon_find">查询</span></button></td>
			  </tr >
			  <tr >
			     <td colspan="4">
				 <!--    <button  onclick="add();"><span class="icon_add">补签</span></button>&nbsp;  -->
				     <button  onclick="preview();"><span class="icon_print" >打印</span></button>&nbsp;
		             <button  onclick="SaveAsFile();"><span class="icon_xls">导出</span></button>
				 </td>
			  </tr>
			 </form> 
	   </table>
</div >
<div id="scrollContent">
	<table width="100%" class="tableStyle" headFixMode="true" useCheckBox="true" useMultColor="true">
			<tr>
			    <td class="ver01" width="10%" align="center">班组</td>
				<td class="ver01" width="7%" align="center">日期</td>
				<td class="ver01" width="7%" align="center">姓名</td>
				<td class="ver01" width="5%" align="center">工号</td>
                <td class="ver01" width="22%" align="center">签到</td>
				<td class="ver01" width="5%" align="center">应出勤</td>
				<td class="ver01" width="5%" align="center">实出勤</td>
				<td class="ver01" width="4%" align="center">迟到</td>
				<td class="ver01" width="4%" align="center">早退</td>
				<td class="ver01" width="4%" align="center">旷工</td>
		<!-- 	<td class="ver01" width="4%" align="center">加班</td>   -->	
				<td class="ver01" width="4%" align="center">事假</td>
				<td class="ver01" width="4%" align="center">病假</td>
				<td class="ver01" width="4%" align="center">出差</td>
				<td class="ver01" width="4%" align="center">调休</td>
				<td class="ver01" width="4%" align="center">年假</td>
				<td class="ver01" width="7%" align="center">操作</td>
			</tr>
	<c:if test="${!empty signreclist}">
		<c:forEach items="${signreclist}" var="rec">
		<tr>
			<td align="center"><span>
			   <c:forEach items="${dictProTeamList}" var="team">
					<c:if test="${team.proteamid == rec.proteamId}">
						${team.proteamname }
					</c:if>
			   </c:forEach></span></td>
			<td align="center"><span>${fn:substring(rec.day,2,10)}</span></td>
			<td align="center"><span>${rec.xm }</span></td>
			<td align="center"><span>${rec.gonghao }</span></td>
			<td align="center"><span>
			<c:if test="${rec.signCount==2 }">
			  <c:choose>
			    <c:when test="${fn:contains(rec.signFlag,',1,')}">
			       <span style="color:red">${fn:substring(rec.signtimeA,11,16)}</span>--
			    </c:when>
			    <c:otherwise>${fn:substring(rec.signtimeA,11,16)}--</c:otherwise>
			  </c:choose>
			  <c:choose>
			    <c:when test="${fn:contains(rec.signFlag,',2,')}">
			       <span style="color:red">${fn:substring(rec.signtimeB,11,16)}</span>&nbsp;&nbsp;&nbsp;
			    </c:when>
			    <c:otherwise>${fn:substring(rec.signtimeB,11,16)}&nbsp;&nbsp;&nbsp;</c:otherwise>
			  </c:choose>
			  <c:choose>
			    <c:when test="${fn:contains(rec.signFlag,',3,')}">
			      <span style="color:red">${fn:substring(rec.signtimeC,11,16)}</span>--
			    </c:when>
			    <c:otherwise>${fn:substring(rec.signtimeC,11,16)}--</c:otherwise>
			  </c:choose>
			  <c:choose>
			    <c:when test="${fn:contains(rec.signFlag,',4,')}">
			      <span style="color:red">${fn:substring(rec.signtimeD,11,16)}</span>
			    </c:when>
			    <c:otherwise>${fn:substring(rec.signtimeD,11,16)}</c:otherwise>
			  </c:choose>
			</c:if>
			<c:if test="${rec.signCount==1 }">
			  <c:choose>
			    <c:when test="${fn:contains(rec.signFlag,',1,')}">
			      <span style="color:red">${fn:substring(rec.signtimeA,11,16)}</span>--
			    </c:when>
			    <c:otherwise>${fn:substring(rec.signtimeA,11,16)}--</c:otherwise>
			  </c:choose>
			  <c:choose>
			    <c:when test="${fn:contains(rec.signFlag,',2,')}">
			      <span style="color:red">${fn:substring(rec.signtimeB,11,16)}</span>&nbsp;&nbsp;&nbsp;
			    </c:when>
			    <c:otherwise>${fn:substring(rec.signtimeB,11,16)}&nbsp;&nbsp;&nbsp;</c:otherwise>
			  </c:choose>
			</c:if>
			</span></td>
			<td align="center"><span>${rec.attendance }</span></td>
			<td align="center"><span>
			 <c:if test="${rec.realAttendance < rec.attendance}">
			       <span style="color:red">${rec.realAttendance }</span>
			 </c:if>
			 <c:if test="${rec.realAttendance >= rec.attendance}">${rec.realAttendance }</c:if></span></td>
			<td align="center"><span><c:if test="${rec.islate == 1}">
			 <span style="color:red">√</span></c:if></span></td>
			<td align="center"><span><c:if test="${rec.isgoearly == 1}">
			 <span style="color:red">√</span></c:if></span></td>
			<td align="center"><span><c:if test="${rec.isabsenteeism == 1}">
			 <span style="color:red">√</span></c:if></span></td>
	<!--    <td align="center"><span><c:if test="${rec.isovertime == 1}">
	          <span style="color:red">√</span></c:if></span></td>    -->
			<td align="center"><span><c:if test="${rec.reSignTypeId == 2}">
			 <span style="color:red">√</span></c:if></span></td>
			<td align="center"><span><c:if test="${rec.reSignTypeId == 3}">
			 <span style="color:red">√</span></c:if></span></td>
			<td align="center"><span><c:if test="${rec.reSignTypeId == 4}">
			 <span style="color:red">√</span></c:if></span></td>
			<td align="center"><span><c:if test="${rec.reSignTypeId == 5}">
			 <span style="color:red">√</span></c:if></span></td>
			<td align="center"><span><c:if test="${rec.reSignTypeId == 6}">
			 <span style="color:red">√</span></c:if></span></td>
			<td align="center">
                <a href="javascript:void(0);" onclick="resume(${rec.signId });" style="color:blue;">详细</a>&nbsp;&nbsp;
			</td>
		</tr>
		</c:forEach>
		<tr><td colspan="18"></td></tr>
	</c:if>
	<c:if test="${empty signreclist}">
		<tr> 
		    <td class="ver01" align="center" colspan="18">没有相应的数据记录!</td>
		</tr>
	</c:if>
	</table>
   		
</div>

       <link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
	   <script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>

</html>