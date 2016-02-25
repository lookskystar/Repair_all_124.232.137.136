<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<base href="<%=basePath%>" />
<title>广州铁路(集团)公司</title>
<!--框架必需start-->
<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="<%=basePath%>" />
<script type="text/javascript" src="js/jquery-1.4.js"></script>
<!-- Ajax上传图片 -->
<script type="text/javascript" src="js/jquery.form.js"></script>
<script type="text/javascript" src="js/framework.js"></script>
<!--框架必需end-->
<!--文本截取start-->
<script type="text/javascript" src="js/text/text-overflow.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<script type="text/javascript" src="js/attention/messager.js"></script>
<!--文本截取end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->
<script type="text/javascript" src="js/menu/jkmegamenu.js"></script>
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
	BORDER-BOTTOM: #2b3b58 1px solid; TEXT-ALIGN: left; BORDER-LEFT: #2b3b58 1px solid; PADDING-BOTTOM: 0.5em; PADDING-LEFT: 0.5em; PADDING-RIGHT: 0.5em; BORDER-TOP: #2b3b58 1px solid; BORDER-RIGHT: #2b3b58 1px solid; PADDING-TOP: 0.5em
}
TABLE.bluetable TH {
	BACKGROUND: url(images/tr_back.gif) #328aa4 repeat-x; COLOR: #fff
}
TABLE.bluetable TD {
	BACKGROUND: #e5f1f4
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

<body>
<!--头部与导航start-->
<div id="hbox">
	<div id="bs_bannercenter">
	<div id="bs_bannerleft">
	<div id="bs_bannerright">
		<!-- <div class="bs_banner_logo"></div> -->
		<div class="bs_banner_title"></div>
		<div class="bs_nav">
			<div class="bs_navleft">
				<li>
					欢迎您：${session_user.xm}，今天是
				<script>
					var weekDayLabels = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
					var now = new Date();
				    var year=now.getFullYear();
					var month=now.getMonth()+1;
					var day=now.getDate()
				    var currentime = year+"年"+month+"月"+day+"日 "+weekDayLabels[now.getDay()]
					document.write(currentime)
				</script>
				</li>
				<!-- 
				<li class="fontTitle">&nbsp;&nbsp;字号:</li>
				<li class="fontChange"><span><a href="javascript:;" setFont="16">大</a></span></li>
				<li class="fontChange"><span><a href="javascript:;" setFont="14">中</a></span></li>
				<li class="fontChange"><span><a href="javascript:;" setFont="12">小</a></span></li>
				 -->
				<div class="clear"></div>
			</div>
			<div class="bs_navright">
				<span class="icon_no hand" onclick='top.Dialog.confirm("确定要退出系统吗",function(){window.location="<%=basePath%>loginAction!loginOut.do"});'>退出系统</span>
				<%-- 
				<span class="icon_no hand" onclick='top.Dialog.confirm("确定要退出系统吗",function(){window.location="<%=basePath%>loginAction!loginOut.do"});'>退出系统</span>
				<span class="icon_mark hand" onclick='top.Dialog.open({URL:"leftPages/skin_accordition.html",Title:"皮肤管理",Width:720,Height:490});'>皮肤管理</span>
				<a href="../pages/choose.html"><span class="icon_home hand">返回结构选择</span></a>
				 --%>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	</div>
	</div>
</div>
<!--头部与导航end-->

<div id="scrollContent">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0" align="center">
	  <tr>
		<td>
		  	<div class="box2" panelHeight="450"  panelTitle="各段在修机车统计"   panelUrl="javascript:openWin()" showStatus="false" overflow="auto" roller="true">
		  	<center>
		  	<form action="query!count.do" method="post">
		  	  	日期：<input type="text" class="Wdate" onfocus="WdatePicker()" name="time" value="${time }" />
		  		<input type="submit" value="查  询"/>
		  	</form>
		  	</center><br/>
		  	  <center>
		  	   <table width="80%" class="bluetable" id="tab">
					<tr>
						<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">机务段</th>
					   	<th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">大修</th>
   					    <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">中修</th>
					    <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">小辅修</th>
					    <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">临修</th>
					    <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">其它</th>
					    <th class="style10" style="text-align: center; font-family: 宋体, Arial, Helvetica, sans-serif; font-size: 14px;">合计</th>
					</tr>
					<c:set var="dxCount" value="0"/>
					<c:set var="zxCount" value="0"/>
					<c:set var="xfxCount" value="0"/>
					<c:set var="lxCount" value="0"/>
					<c:set var="qtCount" value="0"/>
					<c:forEach var="data" items="${datas}">
					  <tr>
					    <td style="text-align: center;">
					    	<%-- 
					    	<c:if test="${data.area=='zz'}"><a href="http://10.183.217.5/xx/query!listJcNum.do?area=zz&username=${session_user.pwd}&pwd=${session_user.pwd}" target="_blank" style="color:blue;">株洲段</a></c:if>
					      	<c:if test="${data.area=='hh'}"><a href="http://10.165.25.115/xx/query!listJcNum.do?area=hh&username=${session_user.pwd}&pwd=${session_user.pwd}" target="_blank" style="color:blue;">怀化段</a></c:if>
					      	<c:if test="${data.area=='cs'}"><a href="http://10.183.214.3/xx/query!listJcNum.do?area=cs&username=${session_user.pwd}&pwd=${session_user.pwd}" target="_blank" style="color:blue;">长沙段</a></c:if>
					      	<c:if test="${data.area=='gz'}"><a href="http://10.167.61.71:8080/xx/query!listJcNum.do?area=gz&username=${session_user.pwd}&pwd=${session_user.pwd}" target="_blank" style="color:blue;">广州段</a></c:if>
					      	<c:if test="${data.area=='lc'}"><a href="http://10.175.167.237/xx/query!listJcNum.do?area=lc&username=${session_user.pwd}&pwd=${session_user.pwd}" target="_blank" style="color:blue;">龙川段</a></c:if>
					      	<c:if test="${data.area=='ss'}"><a href="http://10.171.33.159/xx/query!listJcNum.do?area=ss&username=${session_user.pwd}&pwd=${session_user.pwd}" target="_blank" style="color:blue;">三水段</a></c:if>
					       --%>
					       <c:if test="${data.area=='zz'}"><a href="http://10.183.217.5/xx/query!listJcNumsByArea.do?login=${session_user.pwd }&area=${data.area }" style="color:blue;">株洲段</a></c:if>
					      	<c:if test="${data.area=='hh'}"><a href="http://10.165.25.115/xx/query!listJcNumsByArea.do?login=${session_user.pwd }&area=${data.area }"  style="color:blue;">怀化段</a></c:if>
					      	<c:if test="${data.area=='cs'}"><a href="http://10.183.214.3/xx/query!listJcNumsByArea.do?login=${session_user.pwd }&area=${data.area }"  style="color:blue;">长沙段</a></c:if>
					      	<c:if test="${data.area=='gz'}"><a href="http://10.167.61.71:8080/xx/query!listJcNumsByArea.do?login=${session_user.pwd }&area=${data.area }"  style="color:blue;">广州段</a></c:if>
					      	<c:if test="${data.area=='lc'}"><a href="http://10.175.167.237/xx/report/query!listJcNumsByArea.do?login=${session_user.pwd }&area=${data.area }"  style="color:blue;">龙川段</a></c:if>
					      	<c:if test="${data.area=='ss'}"><a href="http://10.171.33.159/xx/report/query!listJcNumsByArea.do?login=${session_user.pwd }&area=${data.area }" target="_blank" style="color:blue;">三水段</a></c:if>
					      	
					    </td>
					    <td style="text-align: center;"><a href="javascript:listJcNum('${session_user.pwd}', '${data.area }', 'dx', '${time }');" style="color:blue;">${data.dx }</a></td>
					    <c:set var="dxCount" value="${dxCount+data.dx}"/>
					    <td style="text-align: center;"><a href="javascript:listJcNum('${session_user.pwd}', '${data.area }', 'zx', '${time }');" style="color:blue;">${data.zx }</a></td>
					    <c:set var="zxCount" value="${zxCount+data.zx}"/>
					    <td style="text-align: center;"><a href="javascript:listJcNum('${session_user.pwd}', '${data.area }', 'xfx', '${time }');" style="color:blue;">${data.xfx }</a></td>
					    <c:set var="xfxCount" value="${xfxCount+data.xfx}"/>
					    <td style="text-align: center;"><a href="javascript:listJcNum('${session_user.pwd}', '${data.area }', 'lx', '${time }');" style="color:blue;">${data.lx}</a></td>
					    <c:set var="lxCount" value="${lxCount+data.lx}"/>
					    <td style="text-align: center;"><a href="javascript:listJcNum('${session_user.pwd}', '${data.area }', 'qt', '${time }');" style="color:blue;">${data.qt}</a></td>
					    <c:set var="qtCount" value="${qtCount+data.qt}"/>
					    <td style="text-align: center;"><a href="javascript:listJcNum('${session_user.pwd}', '${data.area }', 'all', '${time }');" style="color:blue;">${data.dx+data.zx+data.xfx+data.lx+data.qt }</a></td>
					 </tr>
					</c:forEach>
					<tr>
					    <td style="text-align: center; background-color: #ffcc66;">总计</td>
					    <td style="text-align: center; background-color: #ffcc66;">${dxCount }</td>
					    <td style="text-align: center; background-color: #ffcc66;">${zxCount }</td>
					    <td style="text-align: center; background-color: #ffcc66;">${xfxCount }</td>
					    <td style="text-align: center; background-color: #ffcc66;">${lxCount }</td>
					    <td style="text-align: center; background-color: #ffcc66;">${qtCount }</td>
					    <td style="text-align: center; background-color: #ffcc66;">${dxCount+zxCount+xfxCount+lxCount+qtCount }</td>
					</tr>
				</table>
				</center>
	    	  </div>
		</td>
	  </tr>
	</table>
</div>			
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
	
	
	//各机务段在修机车列表	
	function listJcNum(login, area, xcxc, time){
		var diag = new top.Dialog();
		diag.Title = "在修机车列表";
		diag.URL = 'query!listJcNums.do?area='+area+'&xcxc='+xcxc+'&time='+time+'&login='+login;
		diag.Width=600;
		diag.Height=520;
		diag.show();
	}
</script>
</body>
</html>