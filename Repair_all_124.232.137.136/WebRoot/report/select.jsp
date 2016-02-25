 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Insert title here</title>
	<base href="<%=basePath %>"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UFT-8" />
	<!--框架必需start-->
	<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
	<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
	<link href="<%=basePath %>report/css/global.css" type="text/css" rel="stylesheet" />
	<link href="<%=basePath %>js/lhgdialog/skins/blue.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="js/jquery-1.4.js"></script>
	<script type="text/javascript" src="js/bsFormat.js"></script>
	<!--框架必需end-->
	<script type="text/javascript" src="js/menu/jkmegamenu.js"></script>
	<link href="<%=basePath %>css/linkcss.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.4.js"></script>

	<script type="text/javascript">
	function addOption(objSelectNow, txt, val) {  
	    // / 使用W3C标准语法为SELECT添加Option  
	    var objOption = document.createElement("OPTION");  
	    objOption.text = txt;  
	    objOption.value = val;  
	    objSelectNow.options.add(objOption);  
	}  
	function selectJcStype(){
		var v=$('#jcType').val();
		var sel=$('#jcStype').get(0);
		while(sel.options.length>1){
			sel.options.remove(1);
		}
		//if(v==0){
			//selectJcNum();
			//return ;
		//}
		$.post('<%=basePath%>report!getJcSType.do?typeId='+v,{},function(data){
			var list=eval("("+data+")");
			
			for(var i=0;i<list.length;i++){
				addOption(sel,list[i].jcStypeValue,list[i].jcStypeValue);
			}
			//selectJcNum();
		});
	}
	function selectJcNum(){
		var v=$('#jcStype').val();
		//清空
		var sel=$('#jcNum').get(0);
		while(sel.options.length>1){
			sel.options.remove(1);
		}
		if(v==0)return ;
		$.post('<%=basePath%>report!getJcNum.do?jcStype='+v,{},function(data){
			var list=eval("("+data+")");
			for(var i=0;i<list.length;i++){
				addOption(sel,list[i].jcNum,list[i].jcNum);
			}
		});
	}
	
	function clickJcNum(obj){
	    if(obj.value=="请输入机车编号"){
	    	obj.value="";
	    }	
	}
	
	$(function(){
		selectJcStype();
		jkmegamenu.definemenu("megaanchor1", "megamenu1", "mouseover");
		//jkmegamenu.definemenu("megaanchor2", "megamenu2", "mouseover");
		//jkmegamenu.definemenu("megaanchor3", "megamenu3", "mouseover");
		//jkmegamenu.definemenu("megaanchor4", "megamenu4", "mouseover");
		//jkmegamenu.definemenu("megaanchor5", "megamenu5", "mouseover");
	});
	</script>
</head>

<body>
 <!-- 
<center>
  <table width="70%" id="tab">
    <tr>
	  <td style="font-size: 13px;"><a href="<%=basePath %>report/select_main.jsp" id="megaanchor1" target="_blank">机车检修管理查询</a>
	    <div id="megamenu1" class="simplemenu" style="width:100px;">
			<ul>
				<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=Z" target="_blank">中&nbsp;&nbsp;修</a></li>
				<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=X" target="_blank">小&nbsp;&nbsp;修</a></li>
				<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=F" target="_blank">辅&nbsp;&nbsp;修</a></li>
				<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=LX" target="_blank">临&nbsp;&nbsp;修</a></li>
				<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=JG" target="_blank">加&nbsp;&nbsp;改</a></li>
				<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=QZ" target="_blank">整&nbsp;&nbsp;治</a></li>
				<li><a href="<%=basePath%>query!query.do?lastOne=1&xcxc=CJ" target="_blank">春&nbsp;&nbsp;鉴</a></li>
				<li><a href="<%=basePath %>report/select_main.jsp" target="_blank">其&nbsp;&nbsp;他</a></li>
			</ul>
		</div>
	  </td>
	  <td style="font-size: 13px"><a href="javascript:void(0)" id="megaanchor2">配件检修管理</a>
	  	<div id="megamenu2" class="simplemenu" style="width:110px;">
			<ul>
				<li><a href="javascript:void(0)" target="_blank">配件配送管理</a></li>
				<li><a href="javascript:void(0)" target="_blank">大部件检修</a></li>
				<li><a href="javascript:void(0)" target="_blank">其它备件管理</a></li>
			</ul>
		</div>
	  </td> 
	  <td style="font-size: 13px"><a href="javascript:void(0)" id="megaanchor3">配件周转管理</a>
	  	<div id="megamenu3" class="simplemenu" style="width:110px;">
			<ul>
				<li><a href="javascript:void(0)" target="_blank">配件身份</a></li>
				<li><a href="javascript:void(0)" target="_blank">中心配件库</a></li>
				<li><a href="javascript:void(0)" target="_blank">配件交接</a></li>
				<li><a href="javascript:void(0)" target="_blank">配件周期</a></li>
			</ul>
		</div>
	  </td>
	  <td style="font-size: 13px"><a href="javascript:void(0)" id="megaanchor4">技术标准管理</a>
	  	<div id="megamenu4" class="simplemenu" style="width:110px;">
			<ul>
				<li><a href="javascript:void(0)" target="_blank">大中修标准</a></li>
				<li><a href="javascript:void(0)" target="_blank">小辅修标准</a></li>
				<li><a href="javascript:void(0)" target="_blank">验收规程</a></li>
				<li><a href="javascript:void(0)" target="_blank">作业指导书</a></li>
				<li><a href="javascript:void(0)" target="_blank">配件检修标准</a></li>
				<li><a href="javascript:void(0)" target="_blank">其它标准</a></li>
			</ul>
		</div>
	  </td>
	  <td style="font-size: 13px"><a href="javascript:void(0)" id="megaanchor5">检修车间管理</a>
	  	<div id="megamenu5" class="simplemenu" style="width:110px;">
			<ul>
				<li><a href="javascript:void(0)" target="_blank">考勤</a></li>
				<li><a href="javascript:void(0)" target="_blank">班组</a></li>
				<li><a href="javascript:void(0)" target="_blank">规章</a></li>
				<li><a href="javascript:void(0)" target="_blank">问题库</a></li>
			</ul>
		</div>
	  </td>
	  
	</tr>
  </table>-->
  
<center>
<form method="post" action="<%=basePath%>query!query.do" target="selectmain" style="background-color: #f8f7f7">
开始时间:<input type="text"  id="startTime" name="startTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))"/>
结束时间:<input type="text"  id="endTime" name="endTime" class="Wdate" onclick="WdatePicker(({dateFmt:'yyyy-MM-dd'}))"/>
  
<%--
机车类别:<select onchange="selectJcStype()" id="jcType" name="jcType">
		<option value="0">请选择机车类别</option>
		<c:forEach var="type" items="${dicJcType }">
			<option value=${type.jcTypeId }>${type.jcTypeValue }</option>
		</c:forEach>
		</select>
机车类型:<select id="jcStype" name="jcStype">
			<option value="0">请选择机车类型</option>
		</select> --%>
机车编号:<input type="text" id="jcNum" name="jcNum"/>
修程修次:<input type="text" name="xcxc"/>&nbsp;&nbsp;
<input type="submit" value="查  询" />
</form>
</center>
<div id="scrollContent" style="height: 100%">
  <iframe scrolling="auto" frameborder="0"  src="<%=basePath%>query!query.do" style="width:100%;height:100%;" id="selectmain" name="selectmain"></iframe>
</div>
<link href="<%=basePath %>My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=basePath %>My97DatePicker/WdatePicker.js"></script>
</body>
</html>